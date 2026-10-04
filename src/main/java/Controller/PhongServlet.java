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
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "PhongServlet", urlPatterns = {"/rooms"})
public class PhongServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. Gọi DAO để lấy danh sách phòng từ cơ sở dữ liệu SQL Server
        PhongDAO dao = new PhongDAO();
        List<Phong> list = dao.getAllRooms();
        
        // 2. Đẩy danh sách phòng vào request với tên là "roomList"
        request.setAttribute("roomList", list);
        
        // 3. Chuyển hướng (Forward) sang trang room.jsp để hiển thị
        request.getRequestDispatcher("./view/room.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}