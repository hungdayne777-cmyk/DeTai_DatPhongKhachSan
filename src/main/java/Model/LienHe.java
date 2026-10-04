package Model;

import java.time.LocalDateTime;

public class LienHe {
    private int maLH;
    private String hoTen;
    private String email;
    private String sdt;
    private String noiDung;
    private LocalDateTime ngayGui;
    private String trangThai;

    public LienHe() {}

    // Getters và Setters
    public int getMaLH() { return maLH; }
    public void setMaLH(int maLH) { this.maLH = maLH; }

    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getSdt() { return sdt; }
    public void setSdt(String sdt) { this.sdt = sdt; }

    public String getNoiDung() { return noiDung; }
    public void setNoiDung(String noiDung) { this.noiDung = noiDung; }

    public LocalDateTime getNgayGui() { return ngayGui; }
    public void setNgayGui(LocalDateTime ngayGui) { this.ngayGui = ngayGui; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }
}