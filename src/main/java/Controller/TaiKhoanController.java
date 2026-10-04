package Controller;

import Dao.TaiKhoanDAO;
import Model.TaiKhoan;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "TaiKhoanController", urlPatterns = {"/admin/accounts", "/admin/add-account", "/admin/delete-account"})
public class TaiKhoanController extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getServletPath();
        TaiKhoanDAO dao = new TaiKhoanDAO();
        
        try {
            if (action.equals("/admin/delete-account")) {
                String username = request.getParameter("username");
                dao.deleteAccount(username);
                response.sendRedirect(request.getContextPath() + "/admin/accounts");
                
            } else if (action.equals("/admin/add-account")) {
             
                request.setAttribute("contentPage", "form_taikhoan.jsp");
                request.getRequestDispatcher("/admin.jsp").forward(request, response);
                
            } else {
              
                List<TaiKhoan> list = dao.getAllAccounts();
                request.setAttribute("listAcc", list);
                request.setAttribute("contentPage", "quan_ly_tai_khoan.jsp");
                request.getRequestDispatcher("/admin.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi xử lý tài khoản: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getServletPath();
        
        try {
            if (action.equals("/admin/add-account")) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                int role = Integer.parseInt(request.getParameter("role"));
                
                TaiKhoanDAO dao = new TaiKhoanDAO();
                dao.insertAccount(username, password, role);
                
              
                response.sendRedirect(request.getContextPath() + "/admin/accounts");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi thêm tài khoản: " + e.getMessage());
        }
    }
}