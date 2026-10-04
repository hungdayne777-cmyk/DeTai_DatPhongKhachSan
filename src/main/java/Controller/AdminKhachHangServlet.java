package Controller;

import Dao.KhachHangDAO;
import Model.KhachHang;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminKhachHangServlet", urlPatterns = {"/admin/adminkhachhang", "/admin/khach-hang", "/admin/customer-manage"})
public class AdminKhachHangServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        KhachHangDAO dao = new KhachHangDAO();

        switch (action) {
            case "list":

                String keyword = request.getParameter("keyword");
                List<KhachHang> list;
                if (keyword != null && !keyword.trim().isEmpty()) {
                    list = dao.searchKhachHang(keyword);
                } else {
                    list = dao.getAllKhachHang();
                }
                request.setAttribute("khachHangList", list);
                request.setAttribute("contentPage", "adminkhachhang.jsp");
                request.getRequestDispatcher("../admin.jsp").forward(request, response);
                break;

            case "form-add":
                // Tự động sinh mã khách hàng tiếp theo (ví dụ: KH001, KH002...)
                String nextMaKH = dao.generateNextMaKH();
                request.setAttribute("nextMaKH", nextMaKH);
                // Giữ nguyên: form_adminkhachhang.jsp (có dấu gạch dưới theo ý bạn)
                request.setAttribute("contentPage", "form_adminkhachhang.jsp");
                request.getRequestDispatcher("../admin.jsp").forward(request, response);
                break;

            case "add":
                // Lấy đầy đủ dữ liệu từ form thêm khách hàng (bao gồm cả Địa Chỉ)
                String maKHAdd = request.getParameter("maKH");
                String tenKHAdd = request.getParameter("hoTen");
                String sdtAdd = request.getParameter("sdt");
                String emailAdd = request.getParameter("email");
                String diaChiAdd = request.getParameter("diaChi");

                // Khởi tạo model với đủ 5 tham số
                KhachHang newKH = new KhachHang(maKHAdd, tenKHAdd, sdtAdd, emailAdd, diaChiAdd);
                dao.addKhachHang(newKH);

                // Lưu thông báo thành công vào Session
                request.getSession().setAttribute("message", "Thêm khách hàng mới thành công!");
                response.sendRedirect("khach-hang?action=list");
                break;

            case "edit":
                String maKHEdit = request.getParameter("maKH");
                KhachHang khEdit = dao.getKhachHangById(maKHEdit);
                request.setAttribute("khachHang", khEdit);

                // Giữ nguyên: form_adminkhachhang.jsp (có dấu gạch dưới theo ý bạn)
                request.setAttribute("contentPage", "form_adminkhachhang.jsp");
                request.getRequestDispatcher("../admin.jsp").forward(request, response);
                break;

            case "update":
                String maKHUp = request.getParameter("maKH");
                String tenKHUp = request.getParameter("hoTen");
                String sdtUp = request.getParameter("sdt");
                String emailUp = request.getParameter("email");
                String diaChiUp = request.getParameter("diaChi");

                // Cập nhật với đủ 5 tham số
                KhachHang updateKH = new KhachHang(maKHUp, tenKHUp, sdtUp, emailUp, diaChiUp);
                dao.updateKhachHang(updateKH);

                // Lưu thông báo cập nhật thành công vào Session
                request.getSession().setAttribute("message", "Cập nhật thông tin khách hàng thành công!");
                response.sendRedirect("khach-hang?action=list");
                break;

            case "delete":
                String maKHDel = request.getParameter("maKH");

                // Kiểm tra xem khách hàng này đã có đơn đặt phòng nào chưa
                if (dao.hasBookings(maKHDel)) {
                    // Nếu đã có -> Chặn xóa và thông báo lỗi (hiện khung đỏ)
                    request.getSession().setAttribute("message", "Không thể xóa! Khách hàng này đã có lịch sử đặt phòng trong hệ thống.");
                } else {
                    // Nếu chưa có -> Tiến hành xóa bình thường
                    dao.deleteKhachHang(maKHDel);
                    request.getSession().setAttribute("message", "Xóa khách hàng thành công!");
                }

                response.sendRedirect("khach-hang?action=list");
                break;

            default:
                response.sendRedirect("khach-hang?action=list");
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
