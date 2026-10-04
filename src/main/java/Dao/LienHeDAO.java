package Dao;

import Model.LienHe;
import Utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class LienHeDAO {

    // Thêm tin nhắn từ form khách hàng
    public boolean addLienHe(LienHe lh) {
        String sql = "INSERT INTO LienHe (HoTen, Email, SDT, NoiDung, NgayGui, TrangThai) VALUES (?, ?, ?, ?, GETDATE(), N'Chưa xử lý')";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, lh.getHoTen());
            ps.setString(2, lh.getEmail());
            ps.setString(3, lh.getSdt());
            ps.setString(4, lh.getNoiDung());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy toàn bộ danh sách cho Admin
    public List<LienHe> getAllLienHe() {
        List<LienHe> list = new ArrayList<>();
        String sql = "SELECT * FROM LienHe ORDER BY NgayGui DESC";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                LienHe lh = new LienHe();
                lh.setMaLH(rs.getInt("MaLH"));
                lh.setHoTen(rs.getString("HoTen"));
                lh.setEmail(rs.getString("Email"));
                lh.setSdt(rs.getString("SDT"));
                lh.setNoiDung(rs.getString("NoiDung"));
                if (rs.getTimestamp("NgayGui") != null) {
                    lh.setNgayGui(rs.getTimestamp("NgayGui").toLocalDateTime());
                }
                lh.setTrangThai(rs.getString("TrangThai"));
                list.add(lh);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Xóa tin nhắn liên hệ theo ID (Dùng cho trang quản trị Admin)
    public boolean deleteLienHe(int maLH) {
        String sql = "DELETE FROM LienHe WHERE MaLH = ?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maLH);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public List<LienHe> searchLienHe(String keyword) {
        List<LienHe> list = new ArrayList<>();
        String sql = "SELECT * FROM LienHe WHERE HoTen LIKE ? OR Email LIKE ? OR SDT LIKE ? ORDER BY NgayGui DESC";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LienHe lh = new LienHe();
                    lh.setMaLH(rs.getInt("MaLH"));
                    lh.setHoTen(rs.getString("HoTen"));
                    lh.setEmail(rs.getString("Email"));
                    lh.setSdt(rs.getString("SDT"));
                    lh.setNoiDung(rs.getString("NoiDung"));
                    if (rs.getTimestamp("NgayGui") != null) {
                        lh.setNgayGui(rs.getTimestamp("NgayGui").toLocalDateTime());
                    }
                    lh.setTrangThai(rs.getString("TrangThai"));
                    list.add(lh);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}