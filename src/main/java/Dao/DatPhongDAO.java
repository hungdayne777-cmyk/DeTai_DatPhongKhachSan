package Dao;

import Utils.DBConnection;
import Model.DatPhong;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DatPhongDAO {

   
    public List<DatPhong> getAllDatPhong() {
        return searchDatPhong(null, null);
    }

    // 2. Lấy thông tin đặt phòng theo mã (MaDP)
    public DatPhong getDatPhongByMaDP(String maDP) {
        String query = "SELECT dp.*, kh.HoTen, p.TenPhong " +
                       "FROM DatPhong dp " +
                       "LEFT JOIN KhachHang kh ON dp.MaKH = kh.MaKH " +
                       "LEFT JOIN Phong p ON dp.MaPhong = p.MaPhong " +
                       "WHERE dp.MaDP = ?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, maDP);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    DatPhong dp = mapResultSetToDatPhong(rs);
                    try { dp.setTenKH(rs.getString("HoTen")); } catch (Exception ignored) {}
                    try { dp.setSoPhong(rs.getString("TenPhong")); } catch (Exception ignored) {}
                    return dp;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    
public boolean updateDatPhong(DatPhong dp) {
    boolean isUpdated = false;
    String queryDP = "UPDATE DatPhong SET MaPhong = ?, MaKH = ?, NgayNhan = ?, NgayTra = ?, " +
                     "TrangThai = ?, SoLuong = ?, TongTien = ?, TienCoc = ?, TrangThaiCoc = ? WHERE MaDP = ?";
    String queryPhong = "UPDATE Phong SET TinhTrang = ? WHERE MaPhong = ?";

    try (Connection conn = new DBConnection().getConnection()) {
        conn.setAutoCommit(false);


        try (PreparedStatement psDP = conn.prepareStatement(queryDP)) {
            psDP.setString(1, dp.getMaPhong());
            psDP.setString(2, dp.getMaKH());
            psDP.setTimestamp(3, dp.getNgayNhan() != null ? Timestamp.valueOf(dp.getNgayNhan()) : null);
            psDP.setTimestamp(4, dp.getNgayTra() != null ? Timestamp.valueOf(dp.getNgayTra()) : null);
            psDP.setString(5, dp.getTrangThai());
            psDP.setInt(6, dp.getSoLuong());
            psDP.setDouble(7, dp.getTongTien());
            psDP.setDouble(8, dp.getTienCoc());
            psDP.setString(9, dp.getTrangThaiCoc());
            psDP.setString(10, dp.getMaDP());
            psDP.executeUpdate();
        }

        
        String trangThaiPhong = "Trống";
        String status = dp.getTrangThai() != null ? dp.getTrangThai().trim() : "";
        if ("Đã thuê".equals(status) || "Đã xác nhận".equals(status)) {
            trangThaiPhong = "Đang thuê";
        } else if ("Hoàn thành".equals(status) || "Đã hủy".equals(status)) {
            trangThaiPhong = "Trống";
        }

      
        if (dp.getMaPhong() != null) {
            try (PreparedStatement psPhong = conn.prepareStatement(queryPhong)) {
                psPhong.setString(1, trangThaiPhong);
                psPhong.setString(2, dp.getMaPhong());
                psPhong.executeUpdate();
            }
        }

        conn.commit();
        isUpdated = true;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return isUpdated;
}
   
    


   public boolean deleteDatPhong(String maDP) {
    boolean isDeleted = false;
    String maPhong = null;

  
    String sqlGetPhong = "SELECT MaPhong FROM DatPhong WHERE MaDP = ?";
    try (Connection conn = new DBConnection().getConnection();
         PreparedStatement psGet = conn.prepareStatement(sqlGetPhong)) {
        
        psGet.setString(1, maDP);
        try (ResultSet rs = psGet.executeQuery()) {
            if (rs.next()) {
                maPhong = rs.getString("MaPhong");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

 
    String sqlUpdatePhong = "UPDATE Phong SET TinhTrang = N'Trống' WHERE MaPhong = ?";
    String sqlDeleteDP = "DELETE FROM DatPhong WHERE MaDP = ?";

    try (Connection conn = new DBConnection().getConnection()) {
        conn.setAutoCommit(false); 

       
        if (maPhong != null) {
            try (PreparedStatement psUpdate = conn.prepareStatement(sqlUpdatePhong)) {
                psUpdate.setString(1, maPhong);
                psUpdate.executeUpdate();
            }
        }

  
        try (PreparedStatement psDelete = conn.prepareStatement(sqlDeleteDP)) {
            psDelete.setString(1, maDP);
            int rowsAffected = psDelete.executeUpdate();
            if (rowsAffected > 0) {
                isDeleted = true;
            }
        }

        conn.commit(); 
    } catch (Exception e) {
        System.err.println("--- LỖI KHI DELETE DAT PHONG ---");
        e.printStackTrace();
    }
    return isDeleted;
}

   public List<DatPhong> searchDatPhong(String keyword, String trangThai) {
    List<DatPhong> list = new ArrayList<>();
    

    StringBuilder query = new StringBuilder(
        "SELECT dp.*, kh.HoTen, p.TenPhong " +
        "FROM DatPhong dp " +
        "LEFT JOIN KhachHang kh ON dp.MaKH = kh.MaKH " +
        "LEFT JOIN Phong p ON dp.MaPhong = p.MaPhong " +
        "WHERE 1=1"
    );
    

    boolean hasKeyword = (keyword != null && !keyword.trim().isEmpty());
    boolean hasTrangThai = (trangThai != null && !trangThai.trim().isEmpty());
    
    if (hasKeyword) {
        query.append(" AND (dp.MaDP LIKE ? OR dp.MaPhong LIKE ? OR dp.MaKH LIKE ? OR kh.HoTen LIKE ?)");
    }
    if (hasTrangThai) {
        query.append(" AND dp.TrangThai = ?");
    }
    
    try (Connection conn = new DBConnection().getConnection();
         PreparedStatement ps = conn.prepareStatement(query.toString())) {
        
        int paramIndex = 1;
        if (hasKeyword) {
            String searchLike = "%" + keyword.trim() + "%";
            ps.setString(paramIndex++, searchLike);
            ps.setString(paramIndex++, searchLike);
            ps.setString(paramIndex++, searchLike);
            ps.setString(paramIndex++, searchLike);
        }
        if (hasTrangThai) {
            ps.setString(paramIndex++, trangThai.trim());
        }
        
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                DatPhong dp = mapResultSetToDatPhong(rs);
                
              
                try { dp.setTenKH(rs.getString("HoTen")); } catch (Exception ignored) {}
                try { dp.setSoPhong(rs.getString("TenPhong")); } catch (Exception ignored) {}
                
                list.add(dp);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}


    public int getTotalDatPhong() {
        String query = "SELECT COUNT(*) FROM DatPhong";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countDatPhongByStatus(String trangThai) {
        String query = "SELECT COUNT(*) FROM DatPhong WHERE TrangThai = ?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, trangThai);
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

    public List<Double> getRevenueByMonths() {
        List<Double> revenues = new ArrayList<>();
        for (int i = 0; i < 12; i++) {
            revenues.add(0.0);
        }

       String query = "SELECT MONTH(NgayDat) AS Thang, SUM(TongTien) AS DoanhThu " +
                   "FROM DatPhong " +
                   "WHERE YEAR(NgayDat) = YEAR(GETDATE()) " +
                   "  AND (TrangThai = N'Đã thuê' OR TrangThai = N'Hoàn thành') " +
                   "GROUP BY MONTH(NgayDat)";
        
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                int thang = rs.getInt("Thang");
                double doanhThu = rs.getDouble("DoanhThu");
                if (thang >= 1 && thang <= 12) {
                    revenues.set(thang - 1, doanhThu);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return revenues;
    }

    
    private DatPhong mapResultSetToDatPhong(ResultSet rs) {
        DatPhong dp = new DatPhong();
        try { dp.setMaDP(rs.getString("MaDP")); } catch (Exception ignored) {}
        try { dp.setMaPhong(rs.getString("MaPhong")); } catch (Exception ignored) {}
        try { dp.setMaKH(rs.getString("MaKH")); } catch (Exception ignored) {}

        try {
            if (rs.getTimestamp("NgayDat") != null) {
                dp.setNgayDat(rs.getTimestamp("NgayDat").toLocalDateTime());
            }
        } catch (Exception ignored) {}

        try {
            if (rs.getTimestamp("NgayNhan") != null) {
                dp.setNgayNhan(rs.getTimestamp("NgayNhan").toLocalDateTime());
            }
        } catch (Exception ignored) {}

        try {
            if (rs.getTimestamp("NgayTra") != null) {
                dp.setNgayTra(rs.getTimestamp("NgayTra").toLocalDateTime());
            }
        } catch (Exception ignored) {}

        try { dp.setTrangThai(rs.getString("TrangThai")); } catch (Exception ignored) {}
        try { dp.setSoLuong(rs.getInt("SoLuong")); } catch (Exception ignored) {}
        try { dp.setTongTien(rs.getDouble("TongTien")); } catch (Exception ignored) {}
        try { dp.setTienCoc(rs.getDouble("TienCoc")); } catch (Exception ignored) {}
        try { dp.setTrangThaiCoc(rs.getString("TrangThaiCoc")); } catch (Exception ignored) {}
        
        return dp;
    }
public String generateNextMaDP() {
    String nextId = "DP001";
    
 
    String query = "SELECT TOP 1 MaDP FROM DatPhong ORDER BY CAST(REPLACE(REPLACE(MaDP, 'DP', ''), ' ', '') AS INT) DESC";
    
    try (Connection conn = new DBConnection().getConnection(); 
         PreparedStatement ps = conn.prepareStatement(query); 
         ResultSet rs = ps.executeQuery()) {
        
        if (rs.next()) {
            String maxId = rs.getString("MaDP").trim(); // Lấy đúng cột MaDP
            String numberPart = maxId.replaceAll("\\D+", ""); 
            if (!numberPart.isEmpty()) {
                int nextNum = Integer.parseInt(numberPart) + 1;
                String prefix = maxId.replaceAll("[0-9]", "").trim(); // Lấy chữ "DP"
                nextId = String.format("%s%0" + numberPart.length() + "d", prefix, nextNum);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return nextId;
}

public Map<String, String> getRoomActiveStatusMap() {
    Map<String, String> map = new HashMap<>();
    String sql = "SELECT MaPhong, TrangThai FROM DatPhong WHERE TrangThai IN (N'Đã xác nhận', N'Đã thuê', N'Chờ xác nhận')";
    try (Connection conn = new DBConnection().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            String maPhong = rs.getString("MaPhong");
            String trangThai = rs.getString("TrangThai");
          
            if (!map.containsKey(maPhong) || "Đã thuê".equals(trangThai) || "Đã xác nhận".equals(trangThai)) {
                map.put(maPhong, trangThai);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return map;
}
public void checkAndUpdateExpiredBookings() {
    // 1. Tìm các đơn đang ở trạng thái 'Đã thuê' nhưng có NgayTra đã nhỏ hơn thời gian hiện tại
    String selectSql = "SELECT MaDP, MaPhong FROM DatPhong WHERE TrangThai = N'Đã thuê' AND NgayTra < ?";
    String updateBookingSql = "UPDATE DatPhong SET TrangThai = N'Hoàn thành' WHERE MaDP = ?";
    String updateRoomSql = "UPDATE Phong SET tinhTrang = N'Trống' WHERE maPhong = ?";

    try (Connection conn = new DBConnection().getConnection();
         PreparedStatement psSelect = conn.prepareStatement(selectSql)) {
        
        psSelect.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
        
        try (ResultSet rs = psSelect.executeQuery()) {
            while (rs.next()) {
                String maDP = rs.getString("MaDP");
                String maPhong = rs.getString("MaPhong");

                // 2. Tiến hành cập nhật trạng thái đơn thành "Hoàn thành" và trả phòng về "Trống"
                try (PreparedStatement psUpDP = conn.prepareStatement(updateBookingSql);
                     PreparedStatement psUpRoom = conn.prepareStatement(updateRoomSql)) {
                    
                    psUpDP.setString(1, maDP);
                    psUpDP.executeUpdate();

                    if (maPhong != null) {
                        psUpRoom.setString(1, maPhong);
                        psUpRoom.executeUpdate();
                    }
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
}
public int getTotalSearchDatPhong(String keyword, String trangThai) {
        StringBuilder query = new StringBuilder(
            "SELECT COUNT(*) FROM DatPhong dp " +
            "LEFT JOIN KhachHang kh ON dp.MaKH = kh.MaKH " +
            "LEFT JOIN Phong p ON dp.MaPhong = p.MaPhong " +
            "WHERE 1=1"
        );
        boolean hasKeyword = (keyword != null && !keyword.trim().isEmpty());
        boolean hasTrangThai = (trangThai != null && !trangThai.trim().isEmpty());
        
        if (hasKeyword) {
            query.append(" AND (dp.MaDP LIKE ? OR dp.MaPhong LIKE ? OR dp.MaKH LIKE ? OR kh.HoTen LIKE ?)");
        }
        if (hasTrangThai) {
            query.append(" AND dp.TrangThai = ?");
        }
        
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(query.toString())) {
            int paramIndex = 1;
            if (hasKeyword) {
                String searchLike = "%" + keyword.trim() + "%";
                ps.setString(paramIndex++, searchLike);
                ps.setString(paramIndex++, searchLike);
                ps.setString(paramIndex++, searchLike);
                ps.setString(paramIndex++, searchLike);
            }
            if (hasTrangThai) {
                ps.setString(paramIndex++, trangThai.trim());
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

   
    public List<DatPhong> searchDatPhongPaging(String keyword, String trangThai, int page, int recordsPerPage) {
        List<DatPhong> list = new ArrayList<>();
        StringBuilder query = new StringBuilder(
            "SELECT dp.*, kh.HoTen, p.TenPhong " +
            "FROM DatPhong dp " +
            "LEFT JOIN KhachHang kh ON dp.MaKH = kh.MaKH " +
            "LEFT JOIN Phong p ON dp.MaPhong = p.MaPhong " +
            "WHERE 1=1"
        );
        
        boolean hasKeyword = (keyword != null && !keyword.trim().isEmpty());
        boolean hasTrangThai = (trangThai != null && !trangThai.trim().isEmpty());
        
        if (hasKeyword) {
            query.append(" AND (dp.MaDP LIKE ? OR dp.MaPhong LIKE ? OR dp.MaKH LIKE ? OR kh.HoTen LIKE ?)");
        }
        if (hasTrangThai) {
            query.append(" AND dp.TrangThai = ?");
        }
        
        
        query.append(" ORDER BY dp.NgayDat DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(query.toString())) {
            
            int paramIndex = 1;
            if (hasKeyword) {
                String searchLike = "%" + keyword.trim() + "%";
                ps.setString(paramIndex++, searchLike);
                ps.setString(paramIndex++, searchLike);
                ps.setString(paramIndex++, searchLike);
                ps.setString(paramIndex++, searchLike);
            }
            if (hasTrangThai) {
                ps.setString(paramIndex++, trangThai.trim());
            }
            
            // Tính toán vị trí bắt đầu (Offset)
            int offset = (page - 1) * recordsPerPage;
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex++, recordsPerPage);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    DatPhong dp = mapResultSetToDatPhong(rs);
                    try { dp.setTenKH(rs.getString("HoTen")); } catch (Exception ignored) {}
                    try { dp.setSoPhong(rs.getString("TenPhong")); } catch (Exception ignored) {}
                    list.add(dp);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public List<DatPhong> getDatPhongByMaKH(String maKH) {
    List<DatPhong> list = new ArrayList<>();
    String query = "SELECT dp.*, kh.HoTen, p.TenPhong " +
                   "FROM DatPhong dp " +
                   "LEFT JOIN KhachHang kh ON dp.MaKH = kh.MaKH " +
                   "LEFT JOIN Phong p ON dp.MaPhong = p.MaPhong " +
                   "WHERE dp.MaKH = ? " +
                   "ORDER BY dp.NgayDat DESC";
    
    try (Connection conn = new DBConnection().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        
        ps.setString(1, maKH);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                DatPhong dp = mapResultSetToDatPhong(rs);
                try { dp.setTenKH(rs.getString("HoTen")); } catch (Exception ignored) {}
                try { dp.setSoPhong(rs.getString("TenPhong")); } catch (Exception ignored) {}
                list.add(dp);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
    public List<DatPhong> getDatPhongByUsername(String username) {
    List<DatPhong> list = new java.util.ArrayList<>();
    // Thêm JOIN với bảng Phong để lấy TenPhong
    String query = "SELECT dp.*, p.TenPhong FROM DatPhong dp " +
                   "JOIN KhachHang kh ON dp.MaKH = kh.MaKH " +
                   "LEFT JOIN Phong p ON dp.MaPhong = p.MaPhong " +
                   "WHERE kh.Username = ? " +
                   "ORDER BY dp.NgayDat DESC";
    
    try (Connection conn = new DBConnection().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setString(1, username);
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                DatPhong dp = new DatPhong();
                dp.setMaDP(rs.getString("MaDP"));
                dp.setMaPhong(rs.getString("MaPhong"));
                dp.setMaKH(rs.getString("MaKH"));
                dp.setTenPhong(rs.getString("TenPhong")); // Lấy tên phòng ở đây
                
                if (rs.getTimestamp("NgayDat") != null) {
                    dp.setNgayDat(rs.getTimestamp("NgayDat").toLocalDateTime());
                }
                if (rs.getTimestamp("NgayNhan") != null) {
                    dp.setNgayNhan(rs.getTimestamp("NgayNhan").toLocalDateTime());
                }
                if (rs.getTimestamp("NgayTra") != null) {
                    dp.setNgayTra(rs.getTimestamp("NgayTra").toLocalDateTime());
                }
                
                dp.setTrangThai(rs.getString("TrangThai"));
                dp.setSoLuong(rs.getInt("SoLuong"));
                dp.setTongTien(rs.getDouble("TongTien"));
                dp.setTienCoc(rs.getDouble("TienCoc"));
                dp.setTrangThaiCoc(rs.getString("TrangThaiCoc"));
                
                list.add(dp);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
    public boolean updateTrangThaiDatPhong(String maDP, String trangThai) {
    String query = "UPDATE DatPhong SET TrangThai = ? WHERE MaDP = ?";
    try (Connection conn = new DBConnection().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setString(1, trangThai);
        ps.setString(2, maDP);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
    }
   
public boolean updateTrangThaiVaCoc(String maDP, String trangThai, String trangThaiCoc) {
    String query = "UPDATE DatPhong SET TrangThai = ?, TrangThaiCoc = ? WHERE MaDP = ?";
    try (Connection conn = new DBConnection().getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {
        ps.setString(1, trangThai);
        ps.setString(2, trangThaiCoc);
        ps.setString(3, maDP);
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}
public boolean insertDatPhong(DatPhong dp) {
    boolean isInserted = false;
    String queryDP = "INSERT INTO DatPhong (MaDP, MaPhong, MaKH, NgayDat, NgayNhan, NgayTra, TrangThai, SoLuong, TongTien, TienCoc, TrangThaiCoc) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    String queryPhong = "UPDATE Phong SET TinhTrang = ? WHERE MaPhong = ?";

    try (Connection conn = new DBConnection().getConnection()) {
        conn.setAutoCommit(false); 

      
        try (PreparedStatement psDP = conn.prepareStatement(queryDP)) {
            psDP.setString(1, dp.getMaDP());
            psDP.setString(2, dp.getMaPhong());
            psDP.setString(3, dp.getMaKH());
            psDP.setTimestamp(4, dp.getNgayDat() != null ? Timestamp.valueOf(dp.getNgayDat()) : new Timestamp(System.currentTimeMillis()));
            psDP.setTimestamp(5, dp.getNgayNhan() != null ? Timestamp.valueOf(dp.getNgayNhan()) : null);
            psDP.setTimestamp(6, dp.getNgayTra() != null ? Timestamp.valueOf(dp.getNgayTra()) : null);
            psDP.setString(7, dp.getTrangThai());
            psDP.setInt(8, dp.getSoLuong());
            psDP.setDouble(9, dp.getTongTien());
            psDP.setDouble(10, dp.getTienCoc());
            psDP.setString(11, dp.getTrangThaiCoc());
            psDP.executeUpdate();
        }

   
        String trangThaiPhong = "Trống";
        String status = dp.getTrangThai() != null ? dp.getTrangThai().trim() : "";
        if ("Đã thuê".equals(status) || "Đã xác nhận".equals(status)) {
            trangThaiPhong = "Đang thuê"; 
        }

      
        if (dp.getMaPhong() != null) {
            try (PreparedStatement psPhong = conn.prepareStatement(queryPhong)) {
                psPhong.setString(1, trangThaiPhong);
                psPhong.setString(2, dp.getMaPhong());
                psPhong.executeUpdate();
            }
        }

        conn.commit(); 
        isInserted = true;
    } catch (Exception e) {
        System.err.println("--- LỖI KHI INSERT DAT PHONG ---");
        e.printStackTrace();
    }
    return isInserted;
}
}