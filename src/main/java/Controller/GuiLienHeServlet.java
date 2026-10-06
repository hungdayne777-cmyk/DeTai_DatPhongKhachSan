package Controller;

import Dao.LienHeDAO;
import Model.LienHe;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "GuiLienHeServlet", urlPatterns = {"/gui-lien-he"})
public class GuiLienHeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String hoTen = request.getParameter("hoTen");
        String email = request.getParameter("email");
        String sdt = request.getParameter("sdt");
        String noiDung = request.getParameter("noiDung");

        LienHeDAO dao = new LienHeDAO();

        LienHe lh = new LienHe();
        lh.setHoTen(hoTen);
        lh.setEmail(email);
        lh.setSdt(sdt);
        lh.setNoiDung(noiDung);

        boolean success = dao.addLienHe(lh);

        HttpSession session = request.getSession();
        if (success) {
            session.setAttribute("message", "Gửi liên hệ thành công! Chúng tôi sẽ xử lý trong thời gian sớm nhất.");
        } else {
            session.setAttribute("message", "Gửi liên hệ thất bại. Vui lòng thử lại sau!");
        }

        request.getRequestDispatcher("/view/contact.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/view/contact.jsp").forward(request, response);
    }
}
