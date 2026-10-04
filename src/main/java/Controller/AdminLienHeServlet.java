package Controller;

import Dao.LienHeDAO;
import Model.LienHe;
import Model.TaiKhoan;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AdminLienHeServlet", urlPatterns = {"/admin/lien-he", "/admin/xoa-lien-he" })
public class AdminLienHeServlet extends HttpServlet {

  @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        TaiKhoan acc = (TaiKhoan) session.getAttribute("acc");
        
       
        if (acc == null || acc.getRole() != 1) { 
            response.sendRedirect(request.getContextPath() + "/view/login.jsp");
            return;
        }

        LienHeDAO dao = new LienHeDAO();
        String action = request.getServletPath();

  
        if ("/admin/xoa-lien-he".equals(action)) {
            String idStr = request.getParameter("id");
            if (idStr != null) {
                try {
                    int maLH = Integer.parseInt(idStr);
                    boolean deleted = dao.deleteLienHe(maLH);
                    if (deleted) {
                        session.setAttribute("message", "Xóa tin nhắn thành công!");
                    } else {
                        session.setAttribute("message", "Xóa thất bại!");
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
         
            response.sendRedirect(request.getContextPath() + "/admin/lien-he");
            
       } else {
            String keyword = request.getParameter("keyword");
            List<LienHe> listLienHe;
            
            // Nếu có từ khóa tìm kiếm thì gọi hàm search, ngược lại lấy tất cả
            if (keyword != null && !keyword.trim().isEmpty()) {
                listLienHe = dao.searchLienHe(keyword.trim());
            } else {
                listLienHe = dao.getAllLienHe();
            }
            
            request.setAttribute("listLienHe", listLienHe);
            request.setAttribute("contentPage", "admin_lienhe.jsp");
            request.getRequestDispatcher("/admin.jsp").forward(request, response);
        }
    }
}