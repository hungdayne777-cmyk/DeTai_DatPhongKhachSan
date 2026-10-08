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

        PhongDAO phongDAO = new PhongDAO();
        Phong phong = phongDAO.getPhongById(maPhong);
        
        if (phong == null) {
            response.sendRedirect(request.getContextPath() + "/danh-sach-phong");
            return;
        }

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
            
            
            // để đơn hàng chắc chắn hiển thị trong trang "Phòng của tôi" của bạn.
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
            
            if (ngayTraDate.isBefore(ngayNhanDate) || ngayTraDate.isEqual(ngayNhanDate)) {
                session.setAttribute("errorMessage", "Ngày trả phòng phải sau ngày nhận phòng ít nhất 1 ngày!");
                response.sendRedirect(request.getContextPath() + "/book?maPhong=" + maPhong);
                return;
            }

            long soNgayO = ChronoUnit.DAYS.between(ngayNhanDate, ngayTraDate);
            double tongTien = soNgayO * phong.getGia();
            double tienCoc = tongTien * 0.3;

            DatPhongDAO dpDAO = new DatPhongDAO();
            String maDP = dpDAO.generateNextMaDP();

            DatPhong dp = new DatPhong();
            dp.setMaDP(maDP);
            dp.setMaPhong(maPhong);
            dp.setMaKH(maKH); // Gắn đúng MaKH của tài khoản đang đăng nhập
            dp.setNgayDat(LocalDateTime.now());
            dp.setNgayNhan(ngayNhanDate.atStartOfDay());
            dp.setNgayTra(ngayTraDate.atStartOfDay());
            dp.setSoLuong(1);
            dp.setTongTien(tongTien);
            dp.setTienCoc(tienCoc); 
            
            dp.setTrangThai("Chờ xác nhận");      
            dp.setTrangThaiCoc("Đã cọc");         

            boolean isInserted = dpDAO.insertDatPhong(dp);

            if (isInserted) {
                session.setAttribute("message", "Đặt phòng thành công! Mã đơn của bạn là: " + maDP);
                response.sendRedirect(request.getContextPath() + "/my-booking"); // Chuyển thẳng tới trang lịch sử xem luôn cho trực quan
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