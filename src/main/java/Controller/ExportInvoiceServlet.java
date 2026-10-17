package Controller.Admin;

import Dao.DatPhongDAO;
import Model.DatPhong;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ExportInvoiceServlet", urlPatterns = {"/admin/export-invoice"})
public class ExportInvoiceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // Lấy mã đặt phòng từ tham số trên URL (?maDP=...)
        String maDP = request.getParameter("maDP");

        DatPhongDAO dao = new DatPhongDAO();
        DatPhong datPhong = dao.getDatPhongByMaDP(maDP);

        if (datPhong != null) {
            // Truyền đối tượng đặt phòng sang trang in hóa đơn
            request.setAttribute("invoice", datPhong);
            
            // Trỏ đúng đến file invoice-print.jsp nằm ở thư mục gốc
            request.getRequestDispatcher("/invoice-print.jsp").forward(request, response);
        } else {
            // Nếu không tìm thấy mã đặt phòng, chuyển hướng về lại danh sách
            response.sendRedirect(request.getContextPath() + "/admin/dat-phong?action=list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}