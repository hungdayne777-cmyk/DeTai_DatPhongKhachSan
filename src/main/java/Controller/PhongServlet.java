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

@WebServlet(name = "PhongServlet", urlPatterns = {"/rooms", "/room"})
public class PhongServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        PhongDAO dao = new PhongDAO();

        // 1. Cấu hình phân trang: 6 phòng trên 1 trang
        int page = 1;
        int recordsPerPage = 6;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        // 2. Nhận tham số sắp xếp giá (asc / desc)
        String sort = request.getParameter("sort");
        if (sort == null) {
            sort = "";
        }

        int offset = (page - 1) * recordsPerPage;
        List<Phong> list = null;

        try {
            // Gọi hàm phân trang & sắp xếp có sẵn trong PhongDAO của bạn
            list = dao.getRoomsByPageAndSort(offset, recordsPerPage, sort);

            // Tính tổng số trang (truyền null cho keyword và tinhTrang để lấy tổng tất cả phòng)
            int totalRecords = dao.getTotalRooms(null, null);
            int noOfPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

// In ra cửa sổ Output của NetBeans để kiểm tra giá trị thực tế
            System.out.println("Total Rooms: " + totalRecords + " - No Of Pages: " + noOfPages);

            request.setAttribute("currentPage", page);
            request.setAttribute("noOfPages", noOfPages);

        } catch (Exception e) {
            e.printStackTrace();
            // Phòng hờ nếu lỗi thì lấy toàn bộ danh sách
            list = dao.getAllRooms();
            request.setAttribute("currentPage", 1);
            request.setAttribute("noOfPages", 1);
        }

        request.setAttribute("roomList", list);
        request.setAttribute("currentSort", sort);

        // Điều hướng về trang room.jsp
        request.getRequestDispatcher("/view/room.jsp").forward(request, response);
    }
}
