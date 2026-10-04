package Controller;

import Dao.PhongDAO;
import Dao.LoaiPhongDAO;
import Dao.KhachHangDAO;
import Dao.DatPhongDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminHomeServlet", urlPatterns = {"/admin/overview"})
public class AdminHomeServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            PhongDAO pDao = new PhongDAO();
            LoaiPhongDAO lpDao = new LoaiPhongDAO();
            KhachHangDAO khDao = new KhachHangDAO();
            DatPhongDAO dpDao = new DatPhongDAO();

            int totalRooms = (pDao.getAllRooms() != null) ? pDao.getAllRooms().size() : 0;
            int totalLoaiPhong = (lpDao.getAllLoaiPhong() != null) ? lpDao.getAllLoaiPhong().size() : 0;
            int totalKhachHang = (khDao.getAllKhachHang() != null) ? khDao.getAllKhachHang().size() : 0;
            int totalDatPhong = (dpDao.getAllDatPhong() != null) ? dpDao.getAllDatPhong().size() : 0;

            // Thống kê số lượng theo từng trạng thái
            int countDaXacNhan = dpDao.countDatPhongByStatus("Đã xác nhận");
            int countChoXacNhan = dpDao.countDatPhongByStatus("Chờ xác nhận");
            int countDaThue = dpDao.countDatPhongByStatus("Đã thuê");         // ✅ Bổ sung đếm trạng thái Đã thuê
            int countDaHuy = dpDao.countDatPhongByStatus("Đã hủy");
            int countHoanThanh = dpDao.countDatPhongByStatus("Hoàn thành");
            
            // Lấy danh sách doanh thu theo tháng (lưu ý hàm này trong DAO đã được lọc chỉ tính Đã thuê hoặc Hoàn thành)
            List<Double> monthlyRevenues = dpDao.getRevenueByMonths();

            // Set attribute tổng quan
            request.setAttribute("totalRooms", totalRooms);
            request.setAttribute("totalLoaiPhong", totalLoaiPhong);
            request.setAttribute("totalKhachHang", totalKhachHang);
            request.setAttribute("totalDatPhong", totalDatPhong);

            // Set attribute số lượng trạng thái cho biểu đồ tròn
            request.setAttribute("countDaXacNhan", countDaXacNhan);
            request.setAttribute("countChoXacNhan", countChoXacNhan);
            request.setAttribute("countDaThue", countDaThue);                 // ✅ Gửi sang JSP
            request.setAttribute("countDaHuy", countDaHuy);
            request.setAttribute("countHoanThanh", countHoanThanh);     
            
            // Set attribute doanh thu cho biểu đồ cột
            request.setAttribute("monthlyRevenues", monthlyRevenues);

            // Chuyển hướng hiển thị trang giao diện quản trị tổng quan
            request.setAttribute("contentPage", "admin_overview.jsp");
            request.getRequestDispatcher("/admin.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi kết nối CSDL hoặc DAO: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}