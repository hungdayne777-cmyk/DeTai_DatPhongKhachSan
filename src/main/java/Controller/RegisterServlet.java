package Controller;

import Dao.KhachHangDAO;
import Dao.TaiKhoanDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

       
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        String re_pass = request.getParameter("re_password");

    
        String hoTen = request.getParameter("hoTen");
        String sdt = request.getParameter("sdt");
        String email = request.getParameter("email");
        String diachi = request.getParameter("diachi");


        if (!pass.equals(re_pass)) {
            request.setAttribute("error", "Mật khẩu nhập lại không khớp!");
            request.getRequestDispatcher("/view/register.jsp").forward(request, response);
            return;
        }

        TaiKhoanDAO tkDao = new TaiKhoanDAO();
        if (tkDao.checkAccountExist(user)) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("/view/register.jsp").forward(request, response);
        } else {
            
            tkDao.register(user, pass);

           
            KhachHangDAO khDao = new KhachHangDAO();
            String maKH = khDao.generateNextMaKH(); 
            khDao.insertKhachHang(maKH, hoTen, sdt, email, diachi, user);

            request.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("/view/login.jsp").forward(request, response);
        }
    }
}
