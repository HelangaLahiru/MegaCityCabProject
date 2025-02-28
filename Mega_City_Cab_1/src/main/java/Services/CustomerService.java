package Services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import Controllers.DatabaseConnector;
import Models.Customer;

public class CustomerService {
    public boolean registerCustomer(Customer customer) {
        String query = "INSERT INTO customer_registration_table "
                     + "(User_ID, User_Username, User_Email, User_NIC, User_Address, User_Telephone_Number, User_Password) "
                     + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DatabaseConnector.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            // Set parameters in the query
            preparedStatement.setInt(1, customer.getUser_ID()); // Assuming User_ID is a string
            preparedStatement.setString(2, customer.getUser_Username());
            preparedStatement.setString(3, customer.getUser_Email());
            preparedStatement.setString(4, customer.getUser_NIC());
            preparedStatement.setString(5, customer.getUser_Address());
            preparedStatement.setString(6, customer.getUser_Telephone_Number());
            preparedStatement.setString(7, customer.getUser_Password()); // Already hashed password
            
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0; // Return true if at least one row was inserted
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Return false if an exception occurs
        }
    }
    
    public boolean isNICDuplicate(String userNIC) {
        String query = "SELECT COUNT(*) FROM customer_registration_table WHERE User_NIC = ?";
        try (Connection conn = DatabaseConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, userNIC);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true; // Duplicate found
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in isNICDuplicate: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Unexpected Error in isNICDuplicate: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean isEmailDuplicate(String userEmail) {
        String query = "SELECT COUNT(*) FROM customer_registration_table WHERE User_Email = ?";
        try (Connection conn = DatabaseConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, userEmail);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return true; // Duplicate found
            }
        } catch (SQLException e) {
            System.err.println("SQL Error in isEmailDuplicate: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Unexpected Error in isEmailDuplicate: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean validateCustomerLogin(Customer customer, HttpServletRequest request) {
        String query = "SELECT User_ID, User_Username, User_Address, User_Telephone_Number FROM customer_registration_table WHERE User_Email = ? AND User_Password = ?";
        try (Connection connection = DatabaseConnector.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            // Set parameters in the query
            preparedStatement.setString(1, customer.getUser_Email()); // Email provided by the customer
            preparedStatement.setString(2, customer.getUser_Password()); // Hashed password provided by the customer
            
            // Execute query
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    // If a record exists, set session attributes
                    int userId = resultSet.getInt("User_ID");
                    String username = resultSet.getString("User_Username");
                    String telephonenumber = resultSet.getString("User_Telephone_Number");
                    String userAddress = resultSet.getString("User_Address");
                    
                    // Create or retrieve the session
                    HttpSession session = request.getSession();
                    session.setAttribute("User_ID", userId);
                    session.setAttribute("User_Username", username);
                    session.setAttribute("User_Telephone_Number", telephonenumber);
                    session.setAttribute("User_Address", userAddress);
                    
                    return true; // Login successful
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // Return false if no record exists or an exception occurs
    }
}