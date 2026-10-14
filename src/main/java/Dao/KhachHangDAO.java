package Dao;

import Model.KhachHang;
import Utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class KhachHangDAO {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // 1. Tự động sinh MaKH tiếp theo (KH001, KH002...)
    public String generateNextMaKH() {
        String query = "SELECT MAX(MaKH) FROM KhachHang";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                String maxMa = rs.getString(1);
                if (maxMa != null && maxMa.startsWith("KH")) {
                    int number = Integer.parseInt(maxMa.substring(2)) + 1;
                    return String.format("KH%03d", number);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return "KH001";
    }

    // 2. Lấy MaKH dựa theo Username, nếu chưa có thì tự động tạo mới
    public String getOrCreateMaKHByUsername(String username) {
        String query = "SELECT MaKH FROM KhachHang WHERE Username = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("MaKH");
            } else {
                String newMaKH = generateNextMaKH();
                insertKhachHang(newMaKH, username, "", "", "", username);
                return newMaKH;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return null;
    }

    // 3. Lấy đối tượng KhachHang theo MaKH
    public KhachHang getKhachHangById(String maKH) {
        String query = "SELECT * FROM KhachHang WHERE MaKH = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, maKH);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new KhachHang(
                    rs.getString("MaKH"),
                    rs.getString("HoTen"),
                    rs.getString("SDT"),
                    rs.getString("Email"),
                    rs.getString("DiaChi"),
                    rs.getString("Username")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return null;
    }

    // 4. Thêm Khách hàng mới
    public void insertKhachHang(String maKH, String hoTen, String sdt, String email, String diaChi, String username) {
        String query = "INSERT INTO KhachHang (MaKH, HoTen, SDT, Email, DiaChi, Username) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, maKH);
            ps.setString(2, hoTen);
            ps.setString(3, sdt);
            ps.setString(4, email);
            ps.setString(5, diaChi);
            ps.setString(6, username);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }

    // 5. Lấy thông tin khách hàng dạng Map theo Username (cho AccountServlet)
    public Map<String, String> getCustomerByUsername(String username) {
        Map<String, String> info = new HashMap<>();
        String query = "SELECT HoTen, SDT, Email, DiaChi FROM KhachHang WHERE Username = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                info.put("fullname", rs.getString("HoTen"));
                info.put("phone", rs.getString("SDT"));
                info.put("email", rs.getString("Email"));
                info.put("address", rs.getString("DiaChi"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return info;
    }

    // 6. Cập nhật thông tin khách hàng theo Username (cho AccountServlet)
    public boolean updateCustomerProfile(String username, String fullname, String phone, String email, String address) {
        String query = "UPDATE KhachHang SET HoTen = ?, SDT = ?, Email = ?, DiaChi = ? WHERE Username = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, fullname);
            ps.setString(2, phone);
            ps.setString(3, email);
            ps.setString(4, address);
            ps.setString(5, username);
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return false;
    }

    // 7. Lấy danh sách tất cả khách hàng
    public List<Map<String, String>> getAllKhachHang() {
        List<Map<String, String>> list = new ArrayList<>();
        String query = "SELECT * FROM KhachHang";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, String> item = new HashMap<>();
                item.put("maKH", rs.getString("MaKH"));
                item.put("hoTen", rs.getString("HoTen"));
                item.put("sdt", rs.getString("SDT"));
                item.put("email", rs.getString("Email"));
                item.put("diaChi", rs.getString("DiaChi"));
                item.put("username", rs.getString("Username"));
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return list;
    }

    // 8. Đếm tổng số lượng khách hàng (Hỗ trợ tìm kiếm theo từ khóa cho AdminKhachHangServlet)
    public int getTotalKhachHang(String keyword) {
        String query = "SELECT COUNT(*) FROM KhachHang WHERE HoTen LIKE ? OR SDT LIKE ? OR Email LIKE ? OR Username LIKE ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            String searchKey = "%" + (keyword != null ? keyword : "") + "%";
            ps.setString(1, searchKey);
            ps.setString(2, searchKey);
            ps.setString(3, searchKey);
            ps.setString(4, searchKey);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return 0;
    }

    // 9. Lấy danh sách khách hàng phân trang & tìm kiếm (Hỗ trợ cho AdminKhachHangServlet)
    public List<KhachHang> getKhachHangByPage(String keyword, int offset, int limit) {
        List<KhachHang> list = new ArrayList<>();
        String query = "SELECT * FROM KhachHang WHERE HoTen LIKE ? OR SDT LIKE ? OR Email LIKE ? OR Username LIKE ? " +
                       "ORDER BY MaKH OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            String searchKey = "%" + (keyword != null ? keyword : "") + "%";
            ps.setString(1, searchKey);
            ps.setString(2, searchKey);
            ps.setString(3, searchKey);
            ps.setString(4, searchKey);
            ps.setInt(5, offset);
            ps.setInt(6, limit);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new KhachHang(
                    rs.getString("MaKH"),
                    rs.getString("HoTen"),
                    rs.getString("SDT"),
                    rs.getString("Email"),
                    rs.getString("DiaChi"),
                    rs.getString("Username")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return list;
    }

    // 10. Xóa khách hàng theo MaKH
    public void deleteKhachHang(String maKH) {
        String query = "DELETE FROM KhachHang WHERE MaKH = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, maKH);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }
    public boolean updateKhachHangNameAndPhone(String maKH, String hoTen, String sdt) {
        String query = "UPDATE KhachHang SET HoTen = ?, SDT = ? WHERE MaKH = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, hoTen);
            ps.setString(2, sdt);
            ps.setString(3, maKH);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return false;
    }
    
    public void addKhachHang(KhachHang kh) {
        String query = "INSERT INTO KhachHang (MaKH, HoTen, SDT, Email, DiaChi, Username) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, kh.getMaKH());
            ps.setString(2, kh.getHoTen());
            ps.setString(3, kh.getSdt());
            ps.setString(4, kh.getEmail());
            ps.setString(5, kh.getDiaChi());
            ps.setString(6, kh.getUsername() != null ? kh.getUsername() : "");
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
    }
    
    public boolean updateKhachHang(KhachHang kh) {
        String query = "UPDATE KhachHang SET HoTen = ?, SDT = ?, Email = ?, DiaChi = ? WHERE MaKH = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, kh.getHoTen());
            ps.setString(2, kh.getSdt());
            ps.setString(3, kh.getEmail());
            ps.setString(4, kh.getDiaChi());
            ps.setString(5, kh.getMaKH());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        return false;
    }

    // 2. Kiểm tra xem khách hàng đã có lịch sử đặt phòng hay chưa (Kiểm tra trước khi xóa)
    public boolean hasBookings(String maKH) {
        // Thay đổi tên bảng đặt phòng (ví dụ DatPhong) và tên cột khóa ngoại cho khớp với DB của bạn nếu cần
        String query = "SELECT COUNT(*) FROM DatPhong WHERE MaKH = ?";
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, maKH);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            // Nếu bảng DatPhong không tồn tại hoặc lỗi truy vấn, tạm thời trả về false để cho phép xóa
            return false;
        } finally {
            closeResources();
        }
        return false;
    }
    
    public boolean updatePassword(String username, String newPassword) {
    String query = "UPDATE TaiKhoan SET password = ? WHERE username = ?";
    try {
        conn = Utils.DBConnection.getConnection();
        ps = conn.prepareStatement(query);
        ps.setString(1, newPassword);
        ps.setString(2, username);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
    return false;
}

    private void closeResources() {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
}