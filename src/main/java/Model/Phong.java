package Model;

public class Phong {
    private String maPhong;
    private String tenPhong;
    private String maLoai;
    private String tenLoai; 
    private String moTa;    
    private double gia;
    private String tinhTrang;
    private String hinhAnh; // Thêm trường lưu tên ảnh

    public Phong() {}

    // Constructor đầy đủ có thêm hinhAnh
    public Phong(String maPhong, String tenPhong, String maLoai, String tenLoai, String moTa, double gia, String tinhTrang, String hinhAnh) {
        this.maPhong = maPhong;
        this.tenPhong = tenPhong;
        this.maLoai = maLoai;
        this.tenLoai = tenLoai;
        this.moTa = moTa;
        this.gia = gia;
        this.tinhTrang = tinhTrang;
        this.hinhAnh = hinhAnh;
    }

    // Các Getter và Setter
    public String getMaPhong() { return maPhong; }
    public void setMaPhong(String maPhong) { this.maPhong = maPhong; }

    public String getTenPhong() { return tenPhong; }
    public void setTenPhong(String tenPhong) { this.tenPhong = tenPhong; }

    public String getMaLoai() { return maLoai; }
    public void setMaLoai(String maLoai) { this.maLoai = maLoai; }

    public String getTenLoai() { return tenLoai; }
    public void setTenLoai(String tenLoai) { this.tenLoai = tenLoai; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }

    public double getGia() { return gia; }
    public void setGia(double gia) { this.gia = gia; }

    public String getTinhTrang() { return tinhTrang; }
    public void setTinhTrang(String tinhTrang) { this.tinhTrang = tinhTrang; }

    public String getHinhAnh() { return hinhAnh; }
    public void setHinhAnh(String hinhAnh) { this.hinhAnh = hinhAnh; }
}