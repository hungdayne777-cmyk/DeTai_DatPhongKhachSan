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

@WebFilter(urlPatterns = {"/*"})
public class AdminAuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        String requestURI = req.getRequestURI();
        
      
        if (requestURI.endsWith("/Trang-chu") 
                || requestURI.endsWith("/login") 
                || requestURI.endsWith("/register")
                || requestURI.endsWith("/logout") 
                || requestURI.contains("/assets/") 
                || requestURI.contains("/css/") 
                || requestURI.contains("/js/") 
                || requestURI.contains("/images/")) {
            chain.doFilter(request, response);
            return;
        }
        
     
        if (requestURI.endsWith(".jsp")) {
            res.sendRedirect(req.getContextPath() + "/Trang-chu"); 
            return;
        }
        
     
        if (requestURI.contains("/admin/")) {
            HttpSession session = req.getSession(false);
            TaiKhoan acc = (session != null) ? (TaiKhoan) session.getAttribute("acc") : null;
            
            if (acc != null) {
                if (acc.getRole() == 1) {
                   
                    chain.doFilter(request, response);
                } else {
                   
                    res.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang quản trị!");
                }
            } else {
              
                res.sendRedirect(req.getContextPath() + "/login");
            }
        } else {
       
            chain.doFilter(request, response);
        }
    }
}