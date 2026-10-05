package Controller;

import Dao.DatPhongDAO;
import Dao.PhongDAO;
import Dao.KhachHangDAO;
import Model.DatPhong;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(name = "AdminDatPhongServlet", urlPatterns = {"/admin/booking-manage", "/admin/dat-phong"})
public class AdminDatPhongServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8"); // Đảm bảo đọc tiếng Việt chuẩn từ form gửi lên

        DatPhongDAO dao = new DatPhongDAO();
        PhongDAO phongDAO = new PhongDAO();
        KhachHangDAO khachHangDAO = new KhachHangDAO();

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "list":
                   dao.checkAndUpdateExpiredBookings();
                
                String keyword = request.getParameter("keyword");
                String status = request.getParameter("status");
                
                // Thiết lập phân trang
                int currentPage = 1;
                int recordsPerPage = 5; // Số dòng trên 1 trang
                
                String pageStr = request.getParameter("page");
                if (pageStr != null && !pageStr.trim().isEmpty()) {
                    try {
                        currentPage = Integer.parseInt(pageStr);
                        if (currentPage < 1) currentPage = 1;
                    } catch (NumberFormatException e) {
                        currentPage = 1;
                    }
                }
                
                // Lấy tổng số bản ghi theo bộ lọc
                int totalRecords = dao.getTotalSearchDatPhong(keyword, status);
                int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
                if (totalPages == 0) totalPages = 1;
                if (currentPage > totalPages) currentPage = totalPages;
                
                // Lấy danh sách theo trang hiện tại
                List<DatPhong> list = dao.searchDatPhongPaging(keyword, status, currentPage, recordsPerPage);

                request.setAttribute("keyword", keyword);
                request.setAttribute("status", status);
                request.setAttribute("datPhongList", list);
                request.setAttribute("currentPage", currentPage);
                request.setAttribute("totalPages", totalPages);

                request.setAttribute("contentPage", "admindatphong.jsp");
                request.getRequestDispatcher("../admin.jsp").forward(request, response);
                    break;

                case "form-add":
                    request.removeAttribute("datPhong");

                    // 1. Gọi hàm sinh mã tự động cho đặt phòng
                    String nextMaDP = dao.generateNextMaDP();
                    request.setAttribute("nextMaDP", nextMaDP);
                    request.setAttribute("roomStatusMap", dao.getRoomActiveStatusMap());
                    // 2. Lấy danh sách phòng và khách hàng để hiển thị lên form
                    request.setAttribute("phongList", phongDAO.getAllPhong());
                    request.setAttribute("khachHangList", khachHangDAO.getAllKhachHang());

                    request.setAttribute("contentPage", "form_admindatphong.jsp");
                    request.getRequestDispatcher("../admin.jsp").forward(request, response);
                    break;

                case "insert":
                case "add":
                    // 1. Lấy dữ liệu từ form
                    String maDP = request.getParameter("maDP");
                    String maKH = request.getParameter("maKH");
                    String trangThai = request.getParameter("trangThai");

                    // QUAN TRỌNG: Form thêm mới dùng checkbox nên phải lấy qua getParameterValues
                    String[] selectedRooms = request.getParameterValues("selectedRooms");

                    // 2. Kiểm tra các trường bắt buộc không được để trống
                    if (maDP == null || maDP.trim().isEmpty()
                            || selectedRooms == null || selectedRooms.length == 0
                            || maKH == null || maKH.trim().isEmpty()) {

                        request.getSession().setAttribute("message", "Thêm thất bại! Vui lòng nhập mã đặt phòng, chọn ít nhất một phòng và khách hàng.");
                        response.sendRedirect(request.getContextPath() + "/admin/dat-phong?action=form-add");
                        return;
                    }

                    // 3. Xử lý Ngày Giờ Nhận Phòng
                    LocalDateTime ngayNhanLDT = parseDateTime(request.getParameter("ngayNhan"));

                    // 4. Xử lý Ngày Giờ Trả Phòng
                    LocalDateTime ngayTraLDT = parseDateTime(request.getParameter("ngayTra"));

                    // Xử lý số lượng
                    int soLuong = 1;
                    try {
                        String slStr = request.getParameter("soLuong");
                        if (slStr != null && !slStr.trim().isEmpty()) {
                            soLuong = Integer.parseInt(slStr);
                        }
                    } catch (NumberFormatException e) {
                        soLuong = 1;
                    }

                    long soNgayThue = 1;
                    if (ngayNhanLDT != null && ngayTraLDT != null) {
                        long daysBetween = java.time.temporal.ChronoUnit.DAYS.between(ngayNhanLDT, ngayTraLDT);
                        soNgayThue = (daysBetween > 0) ? daysBetween : 1;
                    }

                    String trangThaiCoc = request.getParameter("trangThaiCoc");

                    // Thực hiện vòng lặp lưu từng phòng được chọn với giá tiền riêng biệt
                    boolean isInserted = true;
                    for (int i = 0; i < selectedRooms.length; i++) {
                        String maPhong = selectedRooms[i];
                        String currentMaDP = (selectedRooms.length > 1) ? (maDP.trim() + "_" + (i + 1)) : maDP.trim();

                        Model.Phong pItem = phongDAO.getPhongById(maPhong);
                        double roomPricePerDay = (pItem != null) ? pItem.getGia() : 0;

                        double tongTienPhong = roomPricePerDay * soNgayThue;
                        double tienCocPhong = tongTienPhong * 0.3; // Tiền cọc = 30%

                        DatPhong newDp = new DatPhong();
                        newDp.setMaDP(currentMaDP);
                        newDp.setMaPhong(maPhong);
                        newDp.setMaKH(maKH);
                        newDp.setNgayDat(LocalDateTime.now());
                        newDp.setNgayNhan(ngayNhanLDT);
                        newDp.setNgayTra(ngayTraLDT);
                        newDp.setTrangThai(trangThai);
                        newDp.setSoLuong(soLuong);
                        newDp.setTongTien(tongTienPhong);
                        newDp.setTienCoc(tienCocPhong);
                        newDp.setTrangThaiCoc(trangThaiCoc);

                        if (!dao.insertDatPhong(newDp)) {
                            isInserted = false;
                        }
                    }

                    if (isInserted) {
                        request.getSession().setAttribute("message", "Thêm đặt phòng mới thành công!");
                    } else {
                        request.getSession().setAttribute("message", "Thêm thất bại! Vui lòng kiểm tra lại mã đặt phòng hoặc khóa ngoại.");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/dat-phong?action=list");
                    break;

                case "form-edit":
                case "edit":
                    String maDPEdit = request.getParameter("maDP");
                    DatPhong dpEdit = dao.getDatPhongByMaDP(maDPEdit);

                    request.setAttribute("phongList", phongDAO.getAllPhong());
                    request.setAttribute("khachHangList", khachHangDAO.getAllKhachHang());
                    request.setAttribute("roomStatusMap", dao.getRoomActiveStatusMap());
                    request.setAttribute("datPhong", dpEdit);
                    request.setAttribute("contentPage", "form_admindatphong.jsp");
                    request.getRequestDispatcher("../admin.jsp").forward(request, response);
                    break;

                case "update":
                    String updMaDP = request.getParameter("maDP");
                    String updMaPhong = request.getParameter("maPhong");
                    String updMaKH = request.getParameter("maKH");
                    String updTrangThai = request.getParameter("trangThai");

                    if (updMaDP == null || updMaDP.trim().isEmpty() || updMaPhong == null || updMaPhong.trim().isEmpty()) {
                        request.getSession().setAttribute("message", "Cập nhật thất bại! Thiếu thông tin mã đặt phòng hoặc phòng.");
                        response.sendRedirect(request.getContextPath() + "/admin/dat-phong?action=list");
                        return;
                    }

                    DatPhong oldDatPhong = dao.getDatPhongByMaDP(updMaDP);
                    if (oldDatPhong == null) {
                        request.getSession().setAttribute("message", "Cập nhật thất bại! Không tìm thấy mã đặt phòng [" + updMaDP + "].");
                        response.sendRedirect(request.getContextPath() + "/admin/dat-phong?action=list");
                        return; // Chặn an toàn, không rơi xuống case delete
                    }

                    String oldTrangThai = oldDatPhong.getTrangThai();

                    // Ràng buộc 1: Nếu đơn cũ đã "Đã hủy" hoặc "Hoàn thành" -> Khóa cứng, không cho đổi trạng thái
                    if ("Đã hủy".equals(oldTrangThai) || "Hoàn thành".equals(oldTrangThai)) {
                        if (!oldTrangThai.equals(updTrangThai)) {
                            request.getSession().setAttribute("message", "Lỗi: Đơn hàng đã ở trạng thái '" + oldTrangThai + "', không thể thay đổi trạng thái nữa!");
                            response.sendRedirect(request.getContextPath() + "/admin/dat-phong?action=form-edit&maDP=" + updMaDP);
                            return;
                        }
                    }

                    // Ràng buộc 2: Nếu đơn cũ là "Đã thuê" -> Chỉ được giữ nguyên hoặc chuyển sang "Hoàn thành"
                    if ("Đã thuê".equals(oldTrangThai)) {
                        if (!"Đã thuê".equals(updTrangThai) && !"Hoàn thành".equals(updTrangThai)) {
                            request.getSession().setAttribute("message", "Lỗi ràng buộc: Đơn đang ở trạng thái 'Đã thuê' chỉ có thể chuyển sang 'Hoàn thành' hoặc giữ nguyên!");
                            response.sendRedirect(request.getContextPath() + "/admin/dat-phong?action=form-edit&maDP=" + updMaDP);
                            return;
                        }
                    }

                    LocalDateTime updNgayNhanLDT = parseDateTime(request.getParameter("ngayNhan"));
                    LocalDateTime updNgayTraLDT = parseDateTime(request.getParameter("ngayTra"));

                    int updSoLuong = (request.getParameter("soLuong") != null && !request.getParameter("soLuong").isEmpty())
                            ? Integer.parseInt(request.getParameter("soLuong")) : 1;

                    // Tự động tính toán lại tổng tiền và tiền cọc khi cập nhật
                    double roomPrice = 0;
                    Model.Phong pUpd = phongDAO.getPhongById(updMaPhong);
                    if (pUpd != null) {
                        roomPrice = pUpd.getGia();
                    }

                    long soNgayThueUpd = 1;
                    if (updNgayNhanLDT != null && updNgayTraLDT != null) {
                        long daysBetween = java.time.temporal.ChronoUnit.DAYS.between(updNgayNhanLDT, updNgayTraLDT);
                        soNgayThueUpd = (daysBetween > 0) ? daysBetween : 1;
                    }

                    double updTongTien = roomPrice * soNgayThueUpd;
                    double updTienCoc = updTongTien * 0.3; // 30% tiền cọc

                    String updTrangThaiCoc = request.getParameter("trangThaiCoc");

                    DatPhong updDp = new DatPhong();
                    updDp.setMaDP(updMaDP);
                    updDp.setMaPhong(updMaPhong);
                    updDp.setMaKH(updMaKH);
                    updDp.setNgayNhan(updNgayNhanLDT);
                    updDp.setNgayTra(updNgayTraLDT);
                    updDp.setTrangThai(updTrangThai);
                    updDp.setSoLuong(updSoLuong);
                    updDp.setTongTien(updTongTien);
                    updDp.setTienCoc(updTienCoc);
                    updDp.setTrangThaiCoc(updTrangThaiCoc);

                    boolean isUpdated = dao.updateDatPhong(updDp);
                    if (isUpdated) {
                        request.getSession().setAttribute("message", "Cập nhật đặt phòng thành công!");
                    } else {
                        request.getSession().setAttribute("message", "Cập nhật đặt phòng thất bại!");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/dat-phong?action=list");
                    break;

                case "delete":
                    String maDPDelete = request.getParameter("maDP");
                    boolean isDeleted = dao.deleteDatPhong(maDPDelete);

                    if (isDeleted) {
                        request.getSession().setAttribute("message", "Xóa đặt phòng [" + maDPDelete + "] thành công!");
                    } else {
                        request.getSession().setAttribute("message", "Xóa đặt phòng thất bại!");
                    }
                    response.sendRedirect(request.getContextPath() + "/admin/dat-phong?action=list");
                    break;

                default:
                    response.sendRedirect(request.getContextPath() + "/admin/dat-phong?action=list");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống: " + e.getMessage());
            request.setAttribute("contentPage", "admindatphong.jsp");
            request.getRequestDispatcher("../admin.jsp").forward(request, response);
        }
    }

    private LocalDateTime parseDateTime(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) {
            return null;
        }
        try {
            if (dateStr.length() == 10) {
                return LocalDate.parse(dateStr).atStartOfDay();
            } else {
                return LocalDateTime.parse(dateStr);
            }
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}