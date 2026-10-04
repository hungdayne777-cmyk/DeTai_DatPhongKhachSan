package Dao;

import Model.LoaiPhong;
import Utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class LoaiPhongDAO {

    // 1. Lấy toàn bộ danh sách loại phòng
    public List<LoaiPhong> getAllLoaiPhong() {
        List<LoaiPhong> list = new ArrayList<>();
        String query = "SELECT * FROM LoaiPhong";
        try (Connection conn = new DBConnection().getConnection(); PreparedStatement ps = conn.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new LoaiPhong(
                        rs.getString("MaLoai"),
                        rs.getString("TenLoai"),
                        rs.getString("MoTa")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Thêm loại phòng mới
    public void addLoaiPhong(LoaiPhong lp) {
        String query = "INSERT INTO LoaiPhong (MaLoai, TenLoai, MoTa) VALUES (?, ?, ?)";
        try (Connection conn = new DBConnection().getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, lp.getMaLoai());
            ps.setString(2, lp.getTenLoai());
            ps.setString(3, lp.getMoTa());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 3. Lấy thông tin loại phòng theo mã (phục vụ cho nút Sửa)
    public LoaiPhong getLoaiPhongById(String maLoai) {
        String query = "SELECT * FROM LoaiPhong WHERE MaLoai = ?";
        try (Connection conn = new DBConnection().getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, maLoai);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new LoaiPhong(
                            rs.getString("MaLoai"),
                            rs.getString("TenLoai"),
                            rs.getString("MoTa")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 4. Cập nhật loại phòng
    public void updateLoaiPhong(LoaiPhong lp) {
        String query = "UPDATE LoaiPhong SET TenLoai = ?, MoTa = ? WHERE MaLoai = ?";
        try (Connection conn = new DBConnection().getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, lp.getTenLoai());
            ps.setString(2, lp.getMoTa());
            ps.setString(3, lp.getMaLoai());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 5. Xóa loại phòng
    public void deleteLoaiPhong(String maLoai) {
        String query = "DELETE FROM LoaiPhong WHERE MaLoai = ?";
        try (Connection conn = new DBConnection().getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, maLoai);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public String generateNextMaLoai() {
        String nextId = "LP01";
        String sql = "SELECT TOP 1 maLoai FROM LoaiPhong ORDER BY maLoai DESC";

        try (Connection conn = new DBConnection().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                String maxId = rs.getString(1);
                if (maxId != null) {
                    maxId = maxId.trim(); // <-- Cắt bỏ toàn bộ khoảng trắng thừa do SQL Server sinh ra

                    String numberPart = maxId.replaceAll("\\D+", "");
                    if (!numberPart.isEmpty()) {
                        int nextNum = Integer.parseInt(numberPart) + 1;
                        String prefix = maxId.replaceAll("\\d+", "");
                        nextId = String.format("%s%02d", prefix, nextNum);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return nextId;
    }
    public boolean hasRooms(String maLoai) {
    String sql = "SELECT COUNT(*) FROM Phong WHERE MaLoai = ?";
    try (Connection conn = new DBConnection().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, maLoai);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0; // Trả về true nếu vẫn còn phòng thuộc loại này
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
}
