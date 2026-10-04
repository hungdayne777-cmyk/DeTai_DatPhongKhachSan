package Controller;

import Dao.PhongDAO;
import Model.Phong;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserPhongServlet", urlPatterns = {"/room"})
public class UserPhongServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // 1. Gọi DAO lấy toàn bộ danh sách phòng từ database
        PhongDAO dao = new PhongDAO();
        List<Phong> list = dao.getAllRooms();

        // 2. Đẩy danh sách vào request attribute
        request.setAttribute("roomList", list);

        // 3. Chuyển hướng sang file room.jsp trong thư mục view
        request.getRequestDispatcher("view/room.jsp").forward(request, response);
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