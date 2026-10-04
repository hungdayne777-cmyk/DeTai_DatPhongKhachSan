package Model;

public class LoaiPhong {
    private String maLoai;
    private String tenLoai;
    private String moTa;

    // Constructor không tham số
    public LoaiPhong() {
    }

    // Constructor có đầy đủ tham số
    public LoaiPhong(String maLoai, String tenLoai, String moTa) {
        this.maLoai = maLoai;
        this.tenLoai = tenLoai;
        this.moTa = moTa;
    }

    // Getter và Setter cho MaLoai
    public String getMaLoai() {
        return maLoai;
    }

    public void setMaLoai(String maLoai) {
        this.maLoai = maLoai;
    }

    // Getter và Setter cho TenLoai
    public String getTenLoai() {
        return tenLoai;
    }

    public void setTenLoai(String tenLoai) {
        this.tenLoai = tenLoai;
    }

    // Getter và Setter cho MoTa
    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }
}