package Utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL 
            = "jdbc:sqlserver://localhost\\MSSQLSERVER01:1433;" //DESKTOP-1V4LFQF\MSSQLSERVER01:1433; (server dùng ở nhà) ,//PC-34\\SQLEXPRESS01:1433;(server dùng trên lớp)
            + "databaseName=QLKS;"
            + "encrypt=true;"
            + "trustServerCertificate=true;";

    private static final String USER = "sa";
    private static final String PASSWORD = "123456";

    public static Connection getConnection() throws ClassNotFoundException {
        Connection conn = null;
        try {
           Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
//            System.out.println("Kết nối SQL Server thành công.");
        } catch (SQLException e) {
            System.out.println("Không thể kết nối SQL Server!");
            System.out.println(e.getMessage());
        }
        return conn;
    }
}