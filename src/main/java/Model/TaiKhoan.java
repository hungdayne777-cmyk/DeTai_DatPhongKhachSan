package Model;

public class TaiKhoan {
    private String username;
    private String password;
    private int role;
    
    // Thêm các thuộc tính thông tin cá nhân
    private String fullname;
    private String phone;
    private String email;
    private String address;

    public TaiKhoan() {
    }

    public TaiKhoan(String username, String password, int role) {
        this.username = username;
        this.password = password;
        this.role = role;
    }

    public TaiKhoan(String username, String password, int role, String fullname, String phone, String email, String address) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.fullname = fullname;
        this.phone = phone;
        this.email = email;
        this.address = address;
    }

    // Getter & Setter
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public int getRole() { return role; }
    public void setRole(int role) { this.role = role; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
}