package Controller;

import Dao.DatPhongDAO;
import Dao.KhachHangDAO;
import Dao.PhongDAO;
import Model.DatPhong;
import Model.Phong;
import Model.TaiKhoan;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "BookServlet", urlPatterns = {"/book"})
public class BookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        TaiKhoan acc = (session != null) ? (TaiKhoan) session.getAttribute("acc") : null;

        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String maPhong = request.getParameter("maPhong");
        if (maPhong != null) {
            maPhong = maPhong.replaceAll("\\s+", "");
        }

        // 1. Lấy giá trị ngày nhận và trả phòng từ URL
        String arrival = request.getParameter("arrival");
        String departure = request.getParameter("departure");

        // 2. Chuyển định dạng từ dd/MM/yyyy sang yyyy-MM-dd để khớp với <input type="date">
        if (arrival != null && arrival.contains("/")) {
            String[] parts = arrival.split("/");
            if (parts.length == 3) {
                arrival = parts[2] + "-" + parts[1] + "-" + parts[0];
            }
        }
        if (departure != null && departure.contains("/")) {
            String[] parts = departure.split("/");
            if (parts.length == 3) {
                departure = parts[2] + "-" + parts[1] + "-" + parts[0];
            }
        }

        PhongDAO phongDAO = new PhongDAO();
        Phong phong = phongDAO.getPhongById(maPhong);

        if (phong == null) {
            response.sendRedirect(request.getContextPath() + "/danh-sach-phong");
            return;
        }

        KhachHangDAO khDAO = new KhachHangDAO();
        String maKH = khDAO.getOrCreateMaKHByUsername(acc.getUsername());
        Model.KhachHang kh = khDAO.getKhachHangById(maKH);
        if (kh != null) {
            request.setAttribute("khachHang", kh);
        }

        // 3. Gửi ngày đã chuẩn hóa sang trang book_room.jsp
        request.setAttribute("arrival", arrival);
        request.setAttribute("departure", departure);

        request.setAttribute("phongChiTiet", phong);
        request.getRequestDispatcher("/view/book_room.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        TaiKhoan acc = (session != null) ? (TaiKhoan) session.getAttribute("acc") : null;

        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            String maPhong = request.getParameter("maPhong");
            if (maPhong != null) {
                maPhong = maPhong.replaceAll("\\s+", "");
            }

            String hoTen = request.getParameter("hoTen");
            String sdt = request.getParameter("sdt");
            String ngayNhanStr = request.getParameter("ngayNhan");
            String ngayTraStr = request.getParameter("ngayTra");
            String ghiChu = request.getParameter("ghiChu");
            String phuongThucThanhToan = request.getParameter("phuongThucThanhToan");

            KhachHangDAO khDAO = new KhachHangDAO();
            String maKH = khDAO.getOrCreateMaKHByUsername(acc.getUsername());
            khDAO.updateKhachHangNameAndPhone(maKH, hoTen, sdt);

            if (maKH == null) {
                session.setAttribute("errorMessage", "Không thể xử lý thông tin khách hàng!");
                response.sendRedirect(request.getContextPath() + "/book?maPhong=" + maPhong);
                return;
            }

            PhongDAO phongDAO = new PhongDAO();
            Phong phong = phongDAO.getPhongById(maPhong);

            if (phong == null) {
                session.setAttribute("errorMessage", "Phòng không tồn tại!");
                response.sendRedirect(request.getContextPath() + "/danh-sach-phong");
                return;
            }

            LocalDate ngayNhanDate = LocalDate.parse(ngayNhanStr);
            LocalDate ngayTraDate = LocalDate.parse(ngayTraStr);
            LocalDate today = LocalDate.now();

            if (ngayNhanDate.isBefore(today) || ngayTraDate.isBefore(today)) {
                session.setAttribute("errorMessage", "Ngày nhận phòng và ngày trả phòng không được là ngày trong quá khứ!");
                response.sendRedirect(request.getContextPath() + "/book?maPhong=" + maPhong);
                return;
            }

            if (ngayTraDate.isBefore(ngayNhanDate) || ngayTraDate.isEqual(ngayNhanDate)) {
                session.setAttribute("errorMessage", "Ngày trả phòng phải sau ngày nhận phòng ít nhất 1 ngày!");
                response.sendRedirect(request.getContextPath() + "/book?maPhong=" + maPhong);
                return;
            }

            LocalDateTime ngayNhanTime = ngayNhanDate.atStartOfDay();
            LocalDateTime ngayTraTime = ngayTraDate.atStartOfDay();

            DatPhongDAO dpDAO = new DatPhongDAO();
            if (dpDAO.isRoomBookedOverlap(maPhong, ngayNhanTime, ngayTraTime)) {
                session.setAttribute("errorMessage", "Phòng này đã có người đặt trong khoảng thời gian từ " + ngayNhanStr + " đến " + ngayTraStr + ". Vui lòng chọn ngày hoặc phòng khác!");
                response.sendRedirect(request.getContextPath() + "/book?maPhong=" + maPhong);
                return;
            }

            long soNgayO = ChronoUnit.DAYS.between(ngayNhanDate, ngayTraDate);
            double tongTien = soNgayO * phong.getGia();

            // Đọc tỷ lệ % cọc từ form người dùng gửi lên (mặc định 30% = 0.3)
            double tyLeCoc = 0.3;
            String tyLeCocStr = request.getParameter("tyLeCoc");
            if (tyLeCocStr != null && !tyLeCocStr.trim().isEmpty()) {
                try {
                    tyLeCoc = Double.parseDouble(tyLeCocStr) / 100.0;
                } catch (NumberFormatException e) {
                    tyLeCoc = 0.3;
                }
            }
            double tienCoc = tongTien * tyLeCoc;

            String maDP = dpDAO.generateNextMaDP();

            DatPhong dp = new DatPhong();
            dp.setMaDP(maDP);
            dp.setMaPhong(maPhong);
            dp.setMaKH(maKH);
            dp.setNgayDat(LocalDateTime.now());
            dp.setNgayNhan(ngayNhanTime);
            dp.setNgayTra(ngayTraTime);
            dp.setSoLuong(1);
            dp.setTongTien(tongTien);
            dp.setTienCoc(tienCoc);
            dp.setTrangThai("Chờ xác nhận");
            dp.setTrangThaiCoc("Đã cọc");

            boolean isInserted = dpDAO.insertDatPhong(dp);

            if (isInserted) {
                session.setAttribute("message", "Đặt phòng thành công! Mã đơn của bạn là: " + maDP);
                response.sendRedirect(request.getContextPath() + "/my-booking");
            } else {
                session.setAttribute("errorMessage", "Lỗi hệ thống khi lưu đơn đặt phòng!");
                response.sendRedirect(request.getContextPath() + "/book?maPhong=" + maPhong);
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/Trang-chu");
        }
    }
}