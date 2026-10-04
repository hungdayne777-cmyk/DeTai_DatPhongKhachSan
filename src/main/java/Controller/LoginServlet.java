package Controller;

import Dao.TaiKhoanDAO;
import Model.TaiKhoan;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
     
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

       
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        
        TaiKhoanDAO dao = new TaiKhoanDAO();
        TaiKhoan acc = dao.login(user, pass);

       
        if (acc == null) {
        
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác!");
            request.getRequestDispatcher("view/login.jsp").forward(request, response);
        } else {
           
            HttpSession session = request.getSession();
            session.setAttribute("acc", acc);

         
            if (acc.getRole() == 1) {
               
                response.sendRedirect(request.getContextPath() + "/admin/overview");
            } else {
               
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu người dùng gõ trực tiếp /login trên URL thì chuyển về trang login.jsp
        request.getRequestDispatcher("view/login.jsp").forward(request, response);
    }
}