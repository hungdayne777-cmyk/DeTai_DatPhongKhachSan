package Controller;

import java.text.Normalizer;
import java.util.regex.Pattern;
import Dao.PhongDAO;
import Dao.LoaiPhongDAO;
import Model.Phong;
import Model.LoaiPhong;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@WebServlet(name = "AdminPhongServlet", urlPatterns = {"/admin/room"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AdminPhongServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8"); // Chống lỗi tiếng Việt

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        PhongDAO dao = new PhongDAO();

        switch (action) {
            case "list":
                String keyword = request.getParameter("keyword");
                String status = request.getParameter("status");

                
                int currentPage = 1;
                int recordsPerPage = 5; 

                String pageStr = request.getParameter("page");
                if (pageStr != null && !pageStr.isEmpty()) {
                    try {
                        currentPage = Integer.parseInt(pageStr);
                    } catch (NumberFormatException e) {
                        currentPage = 1;
                    }
                }

                int offset = (currentPage - 1) * recordsPerPage;

            
                List<Phong> list = dao.getRoomsByPage(keyword, status, offset, recordsPerPage);
                int totalRecords = dao.getTotalRooms(keyword, status);
                int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

               
                request.setAttribute("roomList", list);
                request.setAttribute("currentPage", currentPage);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("keyword", keyword);
                request.setAttribute("status", status);

                request.setAttribute("contentPage", "admin_room.jsp");
                request.getRequestDispatcher("../admin.jsp").forward(request, response);
                break;

            case "form-add":
                List<LoaiPhong> listLPAdd = new LoaiPhongDAO().getAllLoaiPhong();
                request.setAttribute("listLoaiPhong", listLPAdd);
                String nextMaPhong = dao.generateNextMaPhong();
                request.setAttribute("nextMaPhong", nextMaPhong);
                request.setAttribute("contentPage", "form_adminphong.jsp");
                request.getRequestDispatcher("../admin.jsp").forward(request, response);
                break;

            case "add":
                String maPhongAdd = request.getParameter("maPhong");
                String tenPhongAdd = request.getParameter("tenPhong");
                String maLoaiAdd = request.getParameter("maLoai");
                double giaAdd = Double.parseDouble(request.getParameter("gia"));
                String tinhTrangAdd = request.getParameter("tinhTrang");

                String fileNameAdd = "room1.jpg";
                try {
                    Part filePart = request.getPart("imageFile");
                    if (filePart != null && filePart.getSize() > 0) {
                        String rawName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                        fileNameAdd = sanitizeFileName(rawName);

                        String uploadPath = getServletContext().getRealPath("/") + "images";
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdir();
                        }
                        filePart.write(uploadPath + File.separator + fileNameAdd);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

                Phong newPhong = new Phong();
                newPhong.setMaPhong(maPhongAdd);
                newPhong.setTenPhong(tenPhongAdd);
                newPhong.setMaLoai(maLoaiAdd);
                newPhong.setGia(giaAdd);
                newPhong.setTinhTrang(tinhTrangAdd);
                newPhong.setHinhAnh(fileNameAdd);

                dao.addPhong(newPhong);
                // Lưu thông báo thêm thành công vào Session
                request.getSession().setAttribute("message", "Thêm phòng mới thành công!");
                response.sendRedirect("room?action=list");
                break;

            case "edit":
                String maPhongEdit = request.getParameter("maPhong");
                Phong roomEdit = dao.getPhongById(maPhongEdit);
                request.setAttribute("phong", roomEdit);

                List<LoaiPhong> listLPEdit = new LoaiPhongDAO().getAllLoaiPhong();
                request.setAttribute("listLoaiPhong", listLPEdit);

                request.setAttribute("contentPage", "form_adminphong.jsp");
                request.getRequestDispatcher("../admin.jsp").forward(request, response);
                break;

            case "update":
                String maPhongUp = request.getParameter("maPhong");
                String tenPhongUp = request.getParameter("tenPhong");
                String maLoaiUp = request.getParameter("maLoai");
                double giaUp = Double.parseDouble(request.getParameter("gia"));
                String tinhTrangUp = request.getParameter("tinhTrang");

                String fileNameUp = "";
                try {
                    Part filePart = request.getPart("imageFile");
                    if (filePart != null && filePart.getSize() > 0) {
                        String rawName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                        fileNameUp = sanitizeFileName(rawName);

                        String uploadPath = getServletContext().getRealPath("/") + "images";
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) {
                            uploadDir.mkdir();
                        }
                        filePart.write(uploadPath + File.separator + fileNameUp);
                    } else {
                        fileNameUp = request.getParameter("oldImage");
                    }
                } catch (Exception e) {
                    fileNameUp = request.getParameter("oldImage");
                }

                if (fileNameUp == null || fileNameUp.isEmpty()) {
                    fileNameUp = "room1.jpg";
                }

                Phong updatePhong = new Phong();
                updatePhong.setMaPhong(maPhongUp);
                updatePhong.setTenPhong(tenPhongUp);
                updatePhong.setMaLoai(maLoaiUp);
                updatePhong.setGia(giaUp);
                updatePhong.setTinhTrang(tinhTrangUp);
                updatePhong.setHinhAnh(fileNameUp);

                dao.updatePhong(updatePhong);
                // Lưu thông báo cập nhật thành công vào Session
                request.getSession().setAttribute("message", "Cập nhật thông tin phòng thành công!");
                response.sendRedirect("room?action=list");
                break;

            case "delete":
                String maPhongDel = request.getParameter("maPhong");
                try {
                    Phong p = dao.getPhongById(maPhongDel);
                    if (p != null) {
                        // Lấy trạng thái và loại bỏ khoảng trắng thừa nếu có
                        String tinhTrang = p.getTinhTrang() != null ? p.getTinhTrang().trim() : "";
                        
                        // Kiểm tra nếu không phải trạng thái "Trống" thì chặn lại
                        if (!tinhTrang.equalsIgnoreCase("Trống")) {
                            request.getSession().setAttribute("message", "Không thể xóa! Phòng này đang ở trạng thái '" + tinhTrang + "'.");
                        } else {
                            // Tiến hành xóa (Nếu vướng khóa ngoại DB sẽ ném lỗi sang catch)
                            dao.deletePhong(maPhongDel);
                            request.getSession().setAttribute("message", "Xóa phòng thành công!");
                        }
                    } else {
                        request.getSession().setAttribute("message", "Không tìm thấy phòng cần xóa!");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    request.getSession().setAttribute("message", "Không thể xóa! Phòng này đã có lịch sử đặt phòng (vướng dữ liệu liên quan).");
                }
                response.sendRedirect("room?action=list");
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

    private String sanitizeFileName(String originalFileName) {
        if (originalFileName == null || originalFileName.isEmpty()) {
            return "default.jpg";
        }
        // Chuyển đổi ký tự tiếng Việt có dấu thành không dấu
        String temp = Normalizer.normalize(originalFileName, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        String fileName = pattern.matcher(temp).replaceAll("").replaceAll("Đ", "D").replaceAll("đ", "d");

        // Thay thế khoảng trắng và các ký tự đặc biệt thành dấu gạch dưới '_'
        fileName = fileName.replaceAll("[^a-zA-Z0-9\\.\\-_]", "_");

        // Gắn thêm thời gian hiện tại vào trước tên file để tuyệt đối không bị trùng
        return System.currentTimeMillis() + "_" + fileName;
    }
}
