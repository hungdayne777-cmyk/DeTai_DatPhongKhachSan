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

@WebServlet(name = "PhongServlet", urlPatterns = {"/rooms"})
public class PhongServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
    
    String sort = request.getParameter("sort");
    PhongDAO dao = new PhongDAO();
    List<Phong> list = null;
    
    try {
        // Gọi hàm sắp xếp
        if (sort != null && !sort.trim().isEmpty()) {
            list = dao.getRoomsSorted(sort);
        }
        
        // PHÒNG HỜ: Nếu danh sách sắp xếp bị lỗi hoặc null/rỗng, tự động lấy danh sách gốc để không bị mất phòng
        if (list == null || list.isEmpty()) {
            list = dao.getAllRooms(); 
            // Nếu hàm lấy tất cả phòng của bạn tên khác, ví dụ getAllPhong(), thì thay vào đây
        }
        
        // Sắp xếp an toàn trực tiếp tại Servlet bằng Java Comparator để chắc chắn không bị phụ thuộc vào SQL
        if (list != null && !list.isEmpty()) {
            if ("asc".equalsIgnoreCase(sort)) {
                list.sort((p1, p2) -> Double.compare(p1.getGia(), p2.getGia()));
            } else if ("desc".equalsIgnoreCase(sort)) {
                list.sort((p1, p2) -> Double.compare(p2.getGia(), p1.getGia()));
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        // Nếu có bất kỳ ngoại lệ nào xảy ra, gán bằng danh sách gốc để trang không bị trắng
        list = dao.getAllRooms();
    }
    
    request.setAttribute("roomList", list);
    request.setAttribute("currentSort", sort);
    
    request.getRequestDispatcher("/view/room.jsp").forward(request, response);
}
}