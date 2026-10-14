package Controller;

import Dao.KhachHangDAO;
import Dao.TaiKhoanDAO;
import Model.TaiKhoan;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
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
            acc.setAvatar(customerInfo.get("avatar")); // Đọc avatar lên session

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
        TaiKhoan acc = (TaiKhoan) session.getAttribute("acc");

        if (acc == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 1. Lấy thông tin cá nhân từ form
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");

        // 2. Xử lý upload Avatar mới
        String avatarName = acc.getAvatar(); // Mặc định giữ lại ảnh cũ nếu không chọn ảnh mới
        try {
            Part filePart = request.getPart("avatarFile");
            if (filePart != null) {
                System.out.println("--> FilePart size: " + filePart.getSize());
                String fileName = filePart.getSubmittedFileName();
                System.out.println("--> Submitted FileName: " + fileName);

                if (fileName != null && !fileName.trim().isEmpty()) {
                    avatarName = System.currentTimeMillis() + "_" + fileName;

                    // Thư mục lưu file ảnh trong project trên server
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
                    System.out.println("--> Upload Path: " + uploadPath);

                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdir();
                    }

                    // Ghi file vào thư mục images
                    filePart.write(uploadPath + File.separator + avatarName);
                    System.out.println("--> Lưu file thành công với tên: " + avatarName);
                } else {
                    System.out.println("--> Tên file rỗng hoặc chưa chọn file!");
                }
            } else {
                System.out.println("--> filePart bị null!");
            }
        } catch (Exception e) {
            System.out.println("--> Lỗi khi upload file:");
            e.printStackTrace();
        }

        // 3. Cập nhật thông tin và avatar xuống database thông qua DAO
        KhachHangDAO khDao = new KhachHangDAO();
        khDao.updateCustomerProfile(acc.getUsername(), fullname, phone, email, address, avatarName);

        // Cập nhật lại thông tin vào object trong session
        acc.setFullname(fullname);
        acc.setPhone(phone);
        acc.setEmail(email);
        acc.setAddress(address);
        acc.setAvatar(avatarName);

        // 4. Lấy dữ liệu đổi mật khẩu
        String currentPass = request.getParameter("currentPassword");
        if (currentPass == null) {
            currentPass = request.getParameter("oldPassword");
        }
        if (currentPass == null) {
            currentPass = request.getParameter("matKhauCu");
        }
        if (currentPass == null) {
            currentPass = request.getParameter("txtOldPass");
        }

        String newPass = request.getParameter("newPassword");
        if (newPass == null) {
            newPass = request.getParameter("matKhauMoi");
        }
        if (newPass == null) {
            newPass = request.getParameter("txtNewPass");
        }
        if (newPass == null) {
            newPass = request.getParameter("newpass");
        }

        String confirmPass = request.getParameter("confirmPassword");
        if (confirmPass == null) {
            confirmPass = request.getParameter("xacNhanMatKhau");
        }
        if (confirmPass == null) {
            confirmPass = request.getParameter("confirm");
        }

        // 5. Xử lý đổi mật khẩu nếu người dùng nhập mật khẩu mới
        if (newPass != null && !newPass.trim().isEmpty()) {
            if (currentPass == null || !currentPass.equals(acc.getPassword())) {
                request.setAttribute("message", "Lỗi: Mật khẩu hiện tại không đúng hoặc chưa nhập!");
                request.getRequestDispatcher("/view/thongtinnguoidung.jsp").forward(request, response);
                return;
            }

            if (confirmPass != null && !confirmPass.trim().isEmpty() && !newPass.equals(confirmPass)) {
                request.setAttribute("message", "Lỗi: Xác nhận mật khẩu mới không khớp!");
                request.getRequestDispatcher("/view/thongtinnguoidung.jsp").forward(request, response);
                return;
            }

            TaiKhoanDAO tkDao = new TaiKhoanDAO();
            boolean passUpdated = tkDao.updatePassword(acc.getUsername(), newPass);

            if (passUpdated) {
                acc.setPassword(newPass);
                session.setAttribute("acc", acc);
                request.setAttribute("message", "Cập nhật thông tin, avatar và đổi mật khẩu thành công!");
            } else {
                request.setAttribute("message", "Lỗi: Không thể cập nhật mật khẩu vào cơ sở dữ liệu!");
            }
        } else {
            request.setAttribute("message", "Cập nhật thông tin cá nhân và avatar thành công!");
        }

        session.setAttribute("acc", acc);
        request.getRequestDispatcher("/view/thongtinnguoidung.jsp").forward(request, response);
    }
}
