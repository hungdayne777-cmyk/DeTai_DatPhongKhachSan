package Dao;

import Model.TaiKhoan;
import Utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TaiKhoanDAO {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // Hàm đăng nhập của bạn
    public TaiKhoan login(String user, String pass) {
        String query = "SELECT * FROM TaiKhoan WHERE username = ? AND password = ?";
        try {
            conn = Utils.DBConnection.getConnection(); 
            ps = conn.prepareStatement(query);
            ps.setString(1, user);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                return new TaiKhoan(
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getInt("role")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return null; 
    }

  
    public List<TaiKhoan> getAllAccounts() {
        List<TaiKhoan> list = new ArrayList<>();
        String query = "SELECT * FROM TaiKhoan";
        try {
            conn = Utils.DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new TaiKhoan(
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getInt("role")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return list;
    }


    public void insertAccount(String username, String password, int role) {
        String query = "INSERT INTO TaiKhoan (username, password, role) VALUES (?, ?, ?)";
        try {
            conn = Utils.DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setInt(3, role);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }

    // 3. Xóa tài khoản theo username
    public void deleteAccount(String username) {
        String query = "DELETE FROM TaiKhoan WHERE username = ?";
        try {
            conn = Utils.DBConnection.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }

public boolean checkAccountExist(String username) {
    String query = "SELECT * FROM TaiKhoan WHERE username = ?";
    try {
        conn = Utils.DBConnection.getConnection();
        ps = conn.prepareStatement(query);
        ps.setString(1, username);
        rs = ps.executeQuery();
        if (rs.next()) {
            return true; // Đã tồn tại
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
    return false; // Chưa tồn tại
}


public void register(String username, String password) {
    String query = "INSERT INTO TaiKhoan (username, password, role) VALUES (?, ?, 0)";
    try {
        conn = Utils.DBConnection.getConnection();
        ps = conn.prepareStatement(query);
        ps.setString(1, username);
        ps.setString(2, password);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
}
}