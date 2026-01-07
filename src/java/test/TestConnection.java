package test;

import java.sql.Connection;
import com.election.util.DatabaseConnection;

public class TestConnection {
    public static void main(String[] args) {
        try {
            System.out.println("Testing Derby (NetBeans database) connection...");
            Connection conn = DatabaseConnection.getConnection();
            System.out.println("✅ Connection SUCCESSFUL!");
            conn.close();
        } catch (Exception e) {
            System.out.println("❌ Connection FAILED!");
            e.printStackTrace();
        }
    }
}