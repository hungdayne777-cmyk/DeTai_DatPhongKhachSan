package Dao;

import Model.KhachHang;
import Utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class KhachHangDAO {

    // 1. Lấy toàn bộ danh sách khách hàng
    public List<KhachHang> getAllKhachHang() {
        List<KhachHang> list = new ArrayList<>();
        String query = "SELECT * FROM KhachHang";
        try (Connection conn = new DBConnection().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query); 
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new KhachHang(
                        rs.getString("MaKH"),
                        rs.getString("HoTen"),
                        rs.getString("SDT"),
                        rs.getString("Email"),
                        rs.getString("DiaChi")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Thêm khách hàng mới
    public void addKhachHang(KhachHang kh) {
        String query = "INSERT INTO KhachHang (MaKH, HoTen, SDT, Email, DiaChi) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = new DBConnection().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, kh.getMaKH());
            ps.setString(2, kh.getHoTen());
            ps.setString(3, kh.getSdt());
            ps.setString(4, kh.getEmail());
            ps.setString(5, kh.getDiaChi());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 3. Lấy thông tin khách hàng theo mã (phục vụ cho nút Sửa)
    public KhachHang getKhachHangById(String maKH) {
        String query = "SELECT * FROM KhachHang WHERE MaKH = ?";
        try (Connection conn = new DBConnection().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, maKH);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new KhachHang(
                            rs.getString("MaKH"),
                            rs.getString("HoTen"),
                            rs.getString("SDT"),
                            rs.getString("Email"),
                            rs.getString("DiaChi")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 4. Cập nhật thông tin khách hàng
    public void updateKhachHang(KhachHang kh) {
        String query = "UPDATE KhachHang SET HoTen = ?, SDT = ?, Email = ?, DiaChi = ? WHERE MaKH = ?";
        try (Connection conn = new DBConnection().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, kh.getHoTen());
            ps.setString(2, kh.getSdt());
            ps.setString(3, kh.getEmail());
            ps.setString(4, kh.getDiaChi());
            ps.setString(5, kh.getMaKH());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 5. Xóa khách hàng
    public void deleteKhachHang(String maKH) {
        String query = "DELETE FROM KhachHang WHERE MaKH = ?";
        try (Connection conn = new DBConnection().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, maKH);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 6. Tự động sinh mã khách hàng tiếp theo (Ví dụ: đang là KH002 -> sinh ra KH003)
    public String generateNextMaKH() {
        String nextId = "KH001";
        String sql = "SELECT TOP 1 MaKH FROM KhachHang ORDER BY MaKH DESC";

        try (Connection conn = new DBConnection().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                String maxId = rs.getString(1);
                if (maxId != null) {
                    maxId = maxId.trim(); // Cắt khoảng trắng thừa từ SQL Server

                    String numberPart = maxId.replaceAll("\\D+", "");
                    if (!numberPart.isEmpty()) {
                        int nextNum = Integer.parseInt(numberPart) + 1;
                        String prefix = maxId.replaceAll("\\d+", "");
                        // Dùng %03d tương ứng với định dạng 3 số (KH001, KH002,...)
                        nextId = String.format("%s%03d", prefix, nextNum);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return nextId;
    }
    // 7. Tìm kiếm khách hàng theo Tên hoặc Số điện thoại
public List<KhachHang> searchKhachHang(String keyword) {
    List<KhachHang> list = new ArrayList<>();
    String query = "SELECT * FROM KhachHang WHERE HoTen LIKE ? OR SDT LIKE ?";
    try (Connection conn = new DBConnection().getConnection(); 
         PreparedStatement ps = conn.prepareStatement(query)) {
        String searchPattern = "%" + keyword + "%";
        ps.setString(1, searchPattern);
        ps.setString(2, searchPattern);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new KhachHang(
                        rs.getString("MaKH"),
                        rs.getString("HoTen"),
                        rs.getString("SDT"),
                        rs.getString("Email"),
                        rs.getString("DiaChi")
                ));
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
    public boolean hasBookings(String maKH) {
        String sql = "SELECT COUNT(*) FROM DatPhong WHERE MaKH = ?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, maKH);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // Trả về true nếu khách hàng đã có lịch sử đặt phòng
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
// 8. Đếm tổng số lượng khách hàng (Hỗ trợ phân trang và tìm kiếm)
    public int getTotalKhachHang(String keyword) {
        String sql = "SELECT COUNT(*) FROM KhachHang";
        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        if (hasKeyword) {
            sql += " WHERE HoTen LIKE ? OR SDT LIKE ?";
        }
        
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (hasKeyword) {
                ps.setString(1, "%" + keyword + "%");
                ps.setString(2, "%" + keyword + "%");
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    
    public List<KhachHang> getKhachHangByPage(String keyword, int offset, int limit) {
        List<KhachHang> list = new ArrayList<>();
        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        
        String query;
        if (hasKeyword) {
            query = "SELECT * FROM KhachHang WHERE HoTen LIKE ? OR SDT LIKE ? ORDER BY MaKH OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        } else {
            query = "SELECT * FROM KhachHang ORDER BY MaKH OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        }
        
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            int index = 1;
            if (hasKeyword) {
                ps.setString(index++, "%" + keyword + "%");
                ps.setString(index++, "%" + keyword + "%");
            }
            ps.setInt(index++, offset);
            ps.setInt(index++, limit);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new KhachHang(
                            rs.getString("MaKH"),
                            rs.getString("HoTen"),
                            rs.getString("SDT"),
                            rs.getString("Email"),
                            rs.getString("DiaChi")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public String getOrSaveKhachHang(String hoTen, String sdt) {
        String checkSql = "SELECT MaKH FROM KhachHang WHERE SDT = ?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(checkSql)) {
            ps.setString(1, sdt);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("MaKH"); // Khách cũ -> Lấy MaKH
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    
        String newMaKH = generateNextMaKH();
        KhachHang newKh = new KhachHang(newMaKH, hoTen, sdt, "", ""); // Email và Địa chỉ có thể để trống hoặc cập nhật sau
        addKhachHang(newKh);
        
        return newMaKH;
    }
    public String getOrCreateMaKHByUsername(String username) {
    String maKH = null;
    String checkQuery = "SELECT MaKH FROM KhachHang WHERE Username = ?";
    
    try (Connection conn = new DBConnection().getConnection();
         PreparedStatement ps = conn.prepareStatement(checkQuery)) {
        ps.setString(1, username);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                maKH = rs.getString("MaKH");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    
 
    if (maKH == null) {
        maKH = generateNextMaKH();
        String insertQuery = "INSERT INTO KhachHang (MaKH, HoTen, SDT, Email, DiaChi, Username) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(insertQuery)) {
            ps.setString(1, maKH);
            ps.setString(2, username);
            ps.setString(3, "");
            ps.setString(4, "");
            ps.setString(5, "");
            ps.setString(6, username);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    return maKH;
}
    public boolean updateKhachHangNameAndPhone(String maKH, String hoTen, String sdt) {
    String query = "UPDATE KhachHang SET HoTen = ?, SDT = ? WHERE MaKH = ?";
    try (Connection conn = new DBConnection().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setString(1, hoTen);
        ps.setString(2, sdt);
        ps.setString(3, maKH);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
    
    public boolean insertKhachHang(String maKH, String hoTen, String sdt, String email, String diachi, String username) {
        String query = "INSERT INTO KhachHang (MaKH, HoTen, SDT, Email, DiaChi, Username) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, maKH);
            ps.setString(2, hoTen);
            ps.setString(3, sdt);
            ps.setString(4, email);
            ps.setString(5, diachi);
            ps.setString(6, username);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}