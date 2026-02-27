    /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class TestJDBC {

    public static void main(String[] args) {

        String url = "jdbc:sqlserver://localhost:1433;databaseName=PRJ_Group5;encrypt=true;trustServerCertificate=true";
        String user = "sa";
        String password = "123456";

        try {
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println("Connected successfully!");
            conn.close();

        } catch (SQLException e) {

            System.out.println(" Cannot connect to database!");

            System.out.println("Error Code: " + e.getErrorCode());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("Message: " + e.getMessage());

            e.printStackTrace();
        }
    }
}

