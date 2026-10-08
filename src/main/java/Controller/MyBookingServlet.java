package Controller;

import Dao.DatPhongDAO;
import Model.DatPhong;
import Model.TaiKhoan;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MyBookingServlet", urlPatterns = {"/my-booking"})
public class MyBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        TaiKhoan acc = (TaiKhoan) session.getAttribute("acc"); 
        if (acc == null) {
            response.sendRedirect("view/login.jsp");
            return;
        }
        
        
        DatPhongDAO dao = new DatPhongDAO();
        List<DatPhong> list = dao.getDatPhongByUsername(acc.getUsername()); 
        
        request.setAttribute("myBookings", list);
        request.getRequestDispatcher("/view/my_booking.jsp").forward(request, response);
    }
}