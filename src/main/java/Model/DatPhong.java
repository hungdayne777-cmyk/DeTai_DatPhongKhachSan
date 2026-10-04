package Model;

import java.time.LocalDateTime;

public class DatPhong {
    private String maDP;
    private String maPhong;
    private String soPhong; // Số phòng hiển thị lên bảng
    private String maKH;
    private String tenKH;   // Tên khách hàng
    private LocalDateTime ngayDat;
    private LocalDateTime ngayNhan;
    private LocalDateTime ngayTra;
    private String trangThai;
    private int soLuong;
    private double tongTien;
    private double tienCoc;
    private String trangThaiCoc;

    public DatPhong() {}

    // Getters và Setters đầy đủ
    public String getMaDP() { return maDP; }
    public void setMaDP(String maDP) { this.maDP = maDP; }

    public String getMaPhong() { return maPhong; }
    public void setMaPhong(String maPhong) { this.maPhong = maPhong; }

    public String getSoPhong() { return soPhong; }
    public void setSoPhong(String soPhong) { this.soPhong = soPhong; }

    public String getMaKH() { return maKH; }
    public void setMaKH(String maKH) { this.maKH = maKH; }

    public String getTenKH() { return tenKH; }
    public void setTenKH(String tenKH) { this.tenKH = tenKH; }

    public LocalDateTime getNgayDat() { return ngayDat; }
    public void setNgayDat(LocalDateTime ngayDat) { this.ngayDat = ngayDat; }

    public LocalDateTime getNgayNhan() { return ngayNhan; }
    public void setNgayNhan(LocalDateTime ngayNhan) { this.ngayNhan = ngayNhan; }

    public LocalDateTime getNgayTra() { return ngayTra; }
    public void setNgayTra(LocalDateTime ngayTra) { this.ngayTra = ngayTra; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }

    public int getSoLuong() { return soLuong; }
    public void setSoLuong(int soLuong) { this.soLuong = soLuong; }

    public double getTongTien() { return tongTien; }
    public void setTongTien(double tongTien) { this.tongTien = tongTien; }

    public double getTienCoc() { return tienCoc; }
    public void setTienCoc(double tienCoc) { this.tienCoc = tienCoc; }

    public String getTrangThaiCoc() { return trangThaiCoc; }
    public void setTrangThaiCoc(String trangThaiCoc) { this.trangThaiCoc = trangThaiCoc; }
}