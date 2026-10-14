package Model;

public class KhachHang {
    private String maKH;
    private String hoTen;
    private String sdt;
    private String email;
    private String diaChi;
    private String username;
    private String avatar; // Thuộc tính lưu tên file ảnh đại diện

    // Constructor rỗng
    public KhachHang() {
    }

    // Constructor 5 tham số (Dành cho AdminKhachHangServlet đang gọi)
    public KhachHang(String maKH, String hoTen, String sdt, String email, String diaChi) {
        this.maKH = maKH;
        this.hoTen = hoTen;
        this.sdt = sdt;
        this.email = email;
        this.diaChi = diaChi;
    }

    // Constructor 6 tham số (Cũ - giữ lại để không bị lỗi các file khác đang gọi)
    public KhachHang(String maKH, String hoTen, String sdt, String email, String diaChi, String username) {
        this.maKH = maKH;
        this.hoTen = hoTen;
        this.sdt = sdt;
        this.email = email;
        this.diaChi = diaChi;
        this.username = username;
    }

    // Constructor đầy đủ tất cả thuộc tính (Bổ sung thêm avatar)
    public KhachHang(String maKH, String hoTen, String sdt, String email, String diaChi, String username, String avatar) {
        this.maKH = maKH;
        this.hoTen = hoTen;
        this.sdt = sdt;
        this.email = email;
        this.diaChi = diaChi;
        this.username = username;
        this.avatar = avatar;
    }

    // Getter và Setter
    public String getMaKH() { return maKH; }
    public void setMaKH(String maKH) { this.maKH = maKH; }

    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }

    public String getSdt() { return sdt; }
    public void setSdt(String sdt) { this.sdt = sdt; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getDiaChi() { return diaChi; }
    public void setDiaChi(String diaChi) { this.diaChi = diaChi; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }
}