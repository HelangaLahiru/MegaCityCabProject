package Services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import Controllers.DatabaseConnector;
import Models.Driver;

public class DriverService {
    public boolean registerDriver(Driver driver) {
        String query = "INSERT INTO driver_table "
                     + "(Driver_ID, Driver_Name, Driver_Email, Driver_Telephone_Number, Driver_Password)"
                     + "VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = DatabaseConnector.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            // Set parameters in the query
            preparedStatement.setInt(1, driver.getDriver_ID());
            preparedStatement.setString(2, driver.getDriver_Name());
            preparedStatement.setString(3, driver.getDriver_Email());
            preparedStatement.setString(4, driver.getDriver_Telephone_Number());
            preparedStatement.setString(5, driver.getDriver_Password()); // Already hashed password
            
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0; // Return true if at least one row was inserted
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Return false if an exception occurs
        }
    }
    
    public boolean isEmailDuplicate(String driverEmail) {
        String query = "SELECT COUNT(*) FROM driver_table WHERE Driver_Email = ?";
        try (Connection conn = DatabaseConnector.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, driverEmail);
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
    
    public List<Driver> getUnassignedDrivers() {
        String query = "SELECT * FROM driver_table WHERE Car_Assignability_Status = 'Not Assigned'";
        List<Driver> unassignedDrivers = new ArrayList<>();
        
        try (Connection connection = DatabaseConnector.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            
            // Iterate through the result set to create Driver objects
            while (resultSet.next()) {
                Driver driver = new Driver();
                driver.setDriver_ID(resultSet.getInt("Driver_ID"));
                driver.setDriver_Name(resultSet.getString("Driver_Name"));
                driver.setDriver_Email(resultSet.getString("Driver_Email"));
                driver.setDriver_Telephone_Number(resultSet.getString("Driver_Telephone_Number"));
                driver.setDriver_Password(resultSet.getString("Driver_Password"));
                driver.setCar_Assignability_Status(resultSet.getString("Car_Assignability_Status"));
                
                unassignedDrivers.add(driver); // Add the driver to the list
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return unassignedDrivers;
    }
    
    public boolean validateDriverLogin(Driver driver, HttpServletRequest request) {
        String query = "SELECT Driver_ID, Driver_Name FROM driver_table WHERE Driver_Email = ? AND Driver_Password = ?";
        try (Connection connection = DatabaseConnector.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            
            // Set parameters in the query
            preparedStatement.setString(1, driver.getDriver_Email()); // Email provided by the customer
            preparedStatement.setString(2, driver.getDriver_Password()); // Hashed password provided by the customer
            
            // Execute query
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    // If a record exists, set session attributes
                    int driverId = resultSet.getInt("Driver_ID");
                    String drivername = resultSet.getString("Driver_Name");
                    
                    // Create or retrieve the session
                    HttpSession session = request.getSession();
                    session.setAttribute("Driver_ID", driverId);
                    session.setAttribute("Driver_Name", drivername);
                    
                    return true; // Login successful
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false; // Return false if no record exists or an exception occurs
    }
}