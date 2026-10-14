package Controller;

import Dao.KhachHangDAO;
import Dao.TaiKhoanDAO;
import Model.TaiKhoan;
import java.io.IOException;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "AccountServlet", urlPatterns = {"/AccountServlet"})
public class AccountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        TaiKhoan acc = (TaiKhoan) session.getAttribute("acc");

        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Truy vấn dữ liệu từ bảng KhachHang theo Username
        KhachHangDAO dao = new KhachHangDAO();
        Map<String, String> customerInfo = dao.getCustomerByUsername(acc.getUsername());

        if (!customerInfo.isEmpty()) {
            acc.setFullname(customerInfo.get("fullname"));
            acc.setPhone(customerInfo.get("phone"));
            acc.setEmail(customerInfo.get("email"));
            acc.setAddress(customerInfo.get("address"));
            
            // Cập nhật lại vào Session
            session.setAttribute("acc", acc);
        }

        request.getRequestDispatcher("/view/thongtinnguoidung.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Model.TaiKhoan acc = (Model.TaiKhoan) session.getAttribute("acc");

        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // --- DEBUG: In toàn bộ dữ liệu từ form gửi lên bảng Console của NetBeans ---
        System.out.println("=== DANH SACH PARAMETER GUI LEN ===");
        java.util.Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String pName = paramNames.nextElement();
            System.out.println(pName + " = " + request.getParameter(pName));
        }
        System.out.println("==================================");

        // 1. Cập nhật thông tin cá nhân trước
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        KhachHangDAO khDao = new KhachHangDAO();
        khDao.updateCustomerProfile(acc.getUsername(), fullname, phone, email, address);

        acc.setFullname(fullname);
        acc.setPhone(phone);
        acc.setEmail(email);
        acc.setAddress(address);

        // 2. Lấy dữ liệu đổi mật khẩu (Hỗ trợ quét tất cả các tên gọi phổ biến trong JSP)
        String currentPass = request.getParameter("currentPassword");
        if (currentPass == null) currentPass = request.getParameter("oldPassword");
        if (currentPass == null) currentPass = request.getParameter("matKhauCu");
        if (currentPass == null) currentPass = request.getParameter("txtOldPass");

        String newPass = request.getParameter("newPassword");
        if (newPass == null) newPass = request.getParameter("matKhauMoi");
        if (newPass == null) newPass = request.getParameter("txtNewPass");
        if (newPass == null) newPass = request.getParameter("newpass");

        String confirmPass = request.getParameter("confirmPassword");
        if (confirmPass == null) confirmPass = request.getParameter("xacNhanMatKhau");
        if (confirmPass == null) confirmPass = request.getParameter("confirm");

        // 3. Tiến hành xử lý đổi mật khẩu nếu người dùng có nhập ô mật khẩu mới
        if (newPass != null && !newPass.trim().isEmpty()) {
            
            // Kiểm tra mật khẩu hiện tại
            if (currentPass == null || !currentPass.equals(acc.getPassword())) {
                request.setAttribute("message", "Lỗi: Mật khẩu hiện tại không đúng hoặc chưa nhập!");
                request.getRequestDispatcher("/view/thongtinnguoidung.jsp").forward(request, response);
                return;
            }

            // Kiểm tra xác nhận mật khẩu mới (nếu có ô xác nhận)
            if (confirmPass != null && !confirmPass.trim().isEmpty() && !newPass.equals(confirmPass)) {
                request.setAttribute("message", "Lỗi: Xác nhận mật khẩu mới không khớp!");
                request.getRequestDispatcher("/view/thongtinnguoidung.jsp").forward(request, response);
                return;
            }

            // Gọi DAO cập nhật vào bảng TaiKhoan trong SQL Server
            TaiKhoanDAO tkDao = new TaiKhoanDAO();
            boolean passUpdated = tkDao.updatePassword(acc.getUsername(), newPass);

            if (passUpdated) {
                acc.setPassword(newPass); // Cập nhật session ngay lập tức
                session.setAttribute("acc", acc);
                request.setAttribute("message", "Cập nhật thông tin và đổi mật khẩu thành công!");
            } else {
                request.setAttribute("message", "Lỗi: Không thể cập nhật mật khẩu vào cơ sở dữ liệu!");
            }
        } else {
            request.setAttribute("message", "Cập nhật thông tin cá nhân thành công!");
        }

        session.setAttribute("acc", acc);
        request.getRequestDispatcher("/view/thongtinnguoidung.jsp").forward(request, response);
    }
}