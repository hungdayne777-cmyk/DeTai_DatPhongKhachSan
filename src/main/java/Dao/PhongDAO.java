package Dao;

import Utils.DBConnection;
import Model.Phong;
import java.sql.*;
import java.util.*;

public class PhongDAO {

  public List<Phong> getAllRooms() {
    List<Phong> list = new ArrayList<>();
    // Đổi từ JOIN sang LEFT JOIN để đồng bộ với searchPhong
    String query = "SELECT p.MaPhong, p.TenPhong, p.MaLoai, lp.TenLoai, lp.MoTa, p.Gia, p.TinhTrang, p.hinhAnh "
            + "FROM Phong p LEFT JOIN LoaiPhong lp ON p.MaLoai = lp.MaLoai";
    try (Connection conn = new DBConnection().getConnection(); 
         PreparedStatement ps = conn.prepareStatement(query); 
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            Phong p = new Phong();
            p.setMaPhong(rs.getString("MaPhong"));
            p.setTenPhong(rs.getString("TenPhong"));
            p.setMaLoai(rs.getString("MaLoai"));
            p.setTenLoai(rs.getString("TenLoai"));
            p.setMoTa(rs.getString("MoTa"));
            p.setGia(rs.getDouble("Gia"));
            p.setTinhTrang(rs.getString("TinhTrang"));
            p.setHinhAnh(rs.getString("hinhAnh"));
            list.add(p);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

    // 2. Thêm phòng mới vào CSDL (Đã bổ sung hinhAnh)
    public void addPhong(Phong p) {
        String query = "INSERT INTO Phong (MaPhong, TenPhong, MaLoai, Gia, TinhTrang, hinhAnh) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = new DBConnection().getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, p.getMaPhong());
            ps.setString(2, p.getTenPhong());
            ps.setString(3, p.getMaLoai());
            ps.setDouble(4, p.getGia());
            ps.setString(5, p.getTinhTrang());
            ps.setString(6, p.getHinhAnh()); // Truyền tên ảnh vào
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 3. Lấy thông tin phòng theo Mã Phòng (phục vụ chức năng Sửa)
    public Phong getPhongById(String maPhong) {
        String query = "SELECT p.MaPhong, p.TenPhong, p.MaLoai, lp.TenLoai, lp.MoTa, p.Gia, p.TinhTrang, p.hinhAnh " +
                       "FROM Phong p LEFT JOIN LoaiPhong lp ON p.MaLoai = lp.MaLoai WHERE p.MaPhong = ?";
        try (Connection conn = new DBConnection().getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, maPhong);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Phong p = new Phong();
                    p.setMaPhong(rs.getString("MaPhong"));
                    p.setTenPhong(rs.getString("TenPhong"));
                    p.setMaLoai(rs.getString("MaLoai"));
                    p.setTenLoai(rs.getString("TenLoai"));
                    p.setMoTa(rs.getString("MoTa"));
                    p.setGia(rs.getDouble("Gia"));
                    p.setTinhTrang(rs.getString("TinhTrang"));
                    p.setHinhAnh(rs.getString("hinhAnh")); // Lấy tên ảnh cũ
                    return p;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 4. Cập nhật thông tin phòng (Đã bổ sung cập nhật hinhAnh)
    public void updatePhong(Phong p) {
        String query = "UPDATE Phong SET TenPhong = ?, MaLoai = ?, Gia = ?, TinhTrang = ?, hinhAnh = ? WHERE MaPhong = ?";
        try (Connection conn = new DBConnection().getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, p.getTenPhong());
            ps.setString(2, p.getMaLoai());
            ps.setDouble(3, p.getGia());
            ps.setString(4, p.getTinhTrang());
            ps.setString(5, p.getHinhAnh()); // Cập nhật tên ảnh mới
            ps.setString(6, p.getMaPhong());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void deletePhong(String maPhong) {
        String query = "DELETE FROM Phong WHERE MaPhong = ?";
        try (Connection conn = new DBConnection().getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, maPhong);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
  public String generateNextMaPhong() {
    String nextId = "P01";
    // Sửa câu lệnh SQL: Loại bỏ chữ 'P' và khoảng trắng, sau đó ép kiểu thành INT để sắp xếp chuẩn theo số thực tế
    String query = "SELECT TOP 1 MaPhong FROM Phong ORDER BY CAST(REPLACE(REPLACE(MaPhong, 'P', ''), ' ', '') AS INT) DESC";
    
    try (Connection conn = new DBConnection().getConnection(); 
         PreparedStatement ps = conn.prepareStatement(query); 
         ResultSet rs = ps.executeQuery()) {
        
        if (rs.next()) {
            String maxId = rs.getString("MaPhong").trim(); // Cắt khoảng trắng thừa nếu có
            // Lọc lấy phần số để cộng thêm 1
            String numberPart = maxId.replaceAll("\\D+", "");
            if (!numberPart.isEmpty()) {
                int nextNum = Integer.parseInt(numberPart) + 1;
                String prefix = maxId.replaceAll("[0-9]", "").trim(); // Giữ lại phần chữ (VD: "P")
                nextId = prefix + nextNum;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return nextId;
}
  public List<Phong> getAllPhong() {
        return getAllRooms();
    }
  public List<Phong> searchPhong(String keyword, String tinhTrang) {
    List<Phong> list = new ArrayList<>();
    StringBuilder sql = new StringBuilder(
        "SELECT p.MaPhong, p.TenPhong, p.MaLoai, lp.TenLoai, p.Gia, p.TinhTrang, p.hinhAnh " +
        "FROM Phong p LEFT JOIN LoaiPhong lp ON p.MaLoai = lp.MaLoai WHERE 1=1"
    );

    boolean hasKeyword = (keyword != null && !keyword.trim().isEmpty());
    if (hasKeyword) {
        sql.append(" AND (p.TenPhong LIKE ? OR lp.TenLoai LIKE ? OR p.MaPhong LIKE ?)");
    }

    boolean hasStatus = (tinhTrang != null && !tinhTrang.trim().isEmpty());
    if (hasStatus) {
        sql.append(" AND p.TinhTrang = ?");
    }

    sql.append(" ORDER BY p.TenPhong ASC");

    try (Connection conn = new DBConnection().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql.toString())) {

        int paramIndex = 1;
        if (hasKeyword) {
            String pattern = "%" + keyword.trim() + "%";
            ps.setString(paramIndex++, pattern);
            ps.setString(paramIndex++, pattern);
            ps.setString(paramIndex++, pattern);
        }
        if (hasStatus) {
            ps.setString(paramIndex++, tinhTrang);
        }

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Phong p = new Phong();
                p.setMaPhong(rs.getString("MaPhong"));
                p.setTenPhong(rs.getString("TenPhong"));
                p.setMaLoai(rs.getString("MaLoai"));
                p.setTenLoai(rs.getString("TenLoai"));
                p.setGia(rs.getDouble("Gia"));
                p.setTinhTrang(rs.getString("TinhTrang"));
                p.setHinhAnh(rs.getString("hinhAnh"));
                list.add(p);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
  // 5. Lấy giá phòng theo Mã Phòng (phục vụ tính tổng tiền đặt phòng)
    public double getRoomPrice(String maPhong) {
        double gia = 0.0;
        String query = "SELECT Gia FROM Phong WHERE MaPhong = ?";
        try (Connection conn = new DBConnection().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, maPhong);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    gia = rs.getDouble("Gia");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return gia;
    }
    public void updateTrangThaiPhong(String maPhong, String tinhTrang) {
        String query = "UPDATE Phong SET TinhTrang = ? WHERE MaPhong = ?";
        try (Connection conn = new DBConnection().getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, tinhTrang);
            ps.setString(2, maPhong);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}