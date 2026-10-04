package Controller;

import Dao.LoaiPhongDAO;
import Model.LoaiPhong;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminLoaiPhongServlet", urlPatterns = {"/admin/adminloaiphong", "/admin/loai-phong"})
public class AdminLoaiPhongServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        LoaiPhongDAO dao = new LoaiPhongDAO();

        switch (action) {
            case "list":
                List<LoaiPhong> list = dao.getAllLoaiPhong();
                request.setAttribute("loaiPhongList", list);
                request.setAttribute("contentPage", "adminloaiphong.jsp");
                request.getRequestDispatcher("../admin.jsp").forward(request, response);
                break;

            case "form-add":
                String nextMaLoai = dao.generateNextMaLoai();
                request.setAttribute("nextMaLoai", nextMaLoai);
                request.setAttribute("contentPage", "form_adminloaiphong.jsp");
                request.getRequestDispatcher("../admin.jsp").forward(request, response);
                break;

            case "add":
                String maLoaiAdd = request.getParameter("maLoai");
                String tenLoaiAdd = request.getParameter("tenLoai");
                String moTaAdd = request.getParameter("moTa");

                LoaiPhong newLP = new LoaiPhong(maLoaiAdd, tenLoaiAdd, moTaAdd);
                dao.addLoaiPhong(newLP);

                // Lưu thông báo thêm thành công vào Session
                request.getSession().setAttribute("message", "Thêm loại phòng mới thành công!");
                response.sendRedirect("loai-phong?action=list");
                break;

            case "edit":
                String maLoaiEdit = request.getParameter("maLoai");
                LoaiPhong lpEdit = dao.getLoaiPhongById(maLoaiEdit);
                request.setAttribute("loaiPhong", lpEdit);

                request.setAttribute("contentPage", "form_adminloaiphong.jsp");
                request.getRequestDispatcher("../admin.jsp").forward(request, response);
                break;

            case "update":
                String maLoaiUp = request.getParameter("maLoai");
                String tenLoaiUp = request.getParameter("tenLoai");
                String moTaUp = request.getParameter("moTa");

                LoaiPhong updateLP = new LoaiPhong(maLoaiUp, tenLoaiUp, moTaUp);
                dao.updateLoaiPhong(updateLP);

                // Lưu thông báo cập nhật thành công vào Session
                request.getSession().setAttribute("message", "Cập nhật thông tin loại phòng thành công!");
                response.sendRedirect("loai-phong?action=list");
                break;

            case "delete":
                String maLoaiDel = request.getParameter("maLoai");

                // 1. Kiểm tra xem loại phòng này có còn phòng nào thuộc về nó không
                if (dao.hasRooms(maLoaiDel)) {
                    // Nếu vẫn còn phòng -> Chặn xóa và thông báo lỗi (hiện khung đỏ)
                    request.getSession().setAttribute("message", "Không thể xóa! Vẫn còn phòng thuộc loại phòng này.");
                } else {
                    // Nếu trống phòng -> Tiến hành xóa bình thường
                    dao.deleteLoaiPhong(maLoaiDel);
                    request.getSession().setAttribute("message", "Xóa loại phòng thành công!");
                }

                response.sendRedirect("loai-phong?action=list");
                break;

            default:
                response.sendRedirect("loai-phong?action=list");
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
