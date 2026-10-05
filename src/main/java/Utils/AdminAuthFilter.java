package Utils;

import Model.TaiKhoan;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "AdminAuthFilter", urlPatterns = {"/admin/*"})
public class AdminAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        String requestURI = req.getRequestURI();
        
     
        if (requestURI.endsWith(".jsp")) {
            res.sendRedirect(req.getContextPath() + "/view/login.jsp"); 
            return;
        }
        
   
       HttpSession session = req.getSession(false);
TaiKhoan acc = (session != null) ? (TaiKhoan) session.getAttribute("acc") : null;

if (acc != null) {
    if (acc.getRole() == 1) {
        // Đã đăng nhập và là Admin -> Cho qua
        chain.doFilter(request, response);
    } else {
        // Đã đăng nhập nhưng là Khách (role = 0) -> Không có quyền
        res.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này!");
        // Hoặc redirect về trang chủ: res.sendRedirect(req.getContextPath() + "/home");
    }
} else {
    // Chưa đăng nhập -> Về trang login
    res.sendRedirect(req.getContextPath() + "/view/login.jsp");
}
    }
}