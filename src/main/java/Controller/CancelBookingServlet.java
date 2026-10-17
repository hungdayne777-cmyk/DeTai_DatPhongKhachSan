package Controller;

import Dao.DatPhongDAO;
import Dao.PhongDAO;
import Model.DatPhong;
import Model.TaiKhoan;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CancelBookingServlet", urlPatterns = {"/cancel-booking"})
public class CancelBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        TaiKhoan acc = (session != null) ? (TaiKhoan) session.getAttribute("acc") : null;
        
        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/view/login.jsp");
            return;
        }

        String maDP = request.getParameter("maDP");
        if (maDP != null && !maDP.trim().isEmpty()) {
            DatPhongDAO dao = new DatPhongDAO();
            
            DatPhong dp = dao.getDatPhongByMaDP(maDP);
            if (dp != null) {
                String oldTrangThai = dp.getTrangThai() != null ? dp.getTrangThai().trim() : "";
                String trangThaiCocMoi = "Đã hoàn tiền";
                
                if ("Đã xác nhận".equals(oldTrangThai)) {
                    trangThaiCocMoi = "Phạt Cọc";
                }
                
                boolean updated = dao.updateTrangThaiVaCoc(maDP, "Đã hủy", trangThaiCocMoi);
                
                if (updated) {
                    // Sửa thành updateTrangThaiPhong cho khớp với PhongDAO.java có sẵn của bạn
                    PhongDAO phongDAO = new PhongDAO();
                    phongDAO.updateTrangThaiPhong(dp.getMaPhong(), "Trống");

                    session.setAttribute("message", "Đã hủy đơn đặt phòng thành công! (Trạng thái cọc: " + trangThaiCocMoi + ")");
                } else {
                    session.setAttribute("errorMessage", "Không thể hủy đơn phòng này!");
                }
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/my-booking");
    }
}