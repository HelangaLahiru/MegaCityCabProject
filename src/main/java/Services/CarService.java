package Services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import Controllers.DatabaseConnector;
import Models.Car;
import Models.Driver;

public class CarService {
	private static Connection con = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;
	
    public boolean registerCar(Car car) {
        String insertCarQuery = "INSERT INTO car_table "
                              + "(Car_ID, Car_Name, Car_Brand, Car_Number_Plate, Car_Colour, Car_Image, Car_Booking_Price, Driver_ID)"
                              + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        String updateDriverStatusQuery = "UPDATE driver_table "
                                       + "SET Car_Assignability_Status = 'Assigned' "
                                       + "WHERE Driver_ID = ? AND Car_Assignability_Status = 'Not Assigned'";

        try (Connection connection = DatabaseConnector.getConnection()) {
            // Start transaction
            connection.setAutoCommit(false);

            // Insert the car
            try (PreparedStatement insertCarStmt = connection.prepareStatement(insertCarQuery)) {
                insertCarStmt.setInt(1, car.getCar_ID());
                insertCarStmt.setString(2, car.getCar_Name());
                insertCarStmt.setString(3, car.getCar_Brand());
                insertCarStmt.setString(4, car.getCar_Number_Plate());
                insertCarStmt.setString(5, car.getCar_Colour());
                insertCarStmt.setBytes(6, car.getCar_Image());
                insertCarStmt.setDouble(7, car.getCar_Booking_Price());
                insertCarStmt.setInt(8, car.getDriver_ID());
                insertCarStmt.executeUpdate();
            }

            // Update the driver's status
            try (PreparedStatement updateDriverStmt = connection.prepareStatement(updateDriverStatusQuery)) {
                updateDriverStmt.setInt(1, car.getDriver_ID());
                int rowsUpdated = updateDriverStmt.executeUpdate();

                if (rowsUpdated == 0) {
                    // If no rows were updated, rollback and return false
                    connection.rollback();
                    return false;
                }
            }

            // Commit transaction
            connection.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public Driver getDriverDetails(int driverId) {
        String query = "SELECT Driver_Name, Driver_Telephone_Number FROM driver_table WHERE Driver_ID = ?";
        Driver driver = null;

        try (Connection connection = DatabaseConnector.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setInt(1, driverId); // Set the Driver_ID in the query
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                driver = new Driver();
                driver.setDriver_Name(resultSet.getString("Driver_Name"));
                driver.setDriver_Telephone_Number(resultSet.getString("Driver_Telephone_Number"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return driver;
    }
    
    public List<Car> getAllCars() {
        String query = "SELECT * FROM car_table";
        List<Car> allCars = new ArrayList<>();
        
        try (Connection connection = DatabaseConnector.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {

            // Iterate through the result set to create Car objects
            while (resultSet.next()) {
                Car car = new Car();
                car.setCar_ID(resultSet.getInt("Car_ID"));
                car.setCar_Name(resultSet.getString("Car_Name"));
                car.setCar_Brand(resultSet.getString("Car_Brand"));
                car.setCar_Number_Plate(resultSet.getString("Car_Number_Plate"));
                car.setCar_Colour(resultSet.getString("Car_Colour"));
                car.setCar_Booking_Price(resultSet.getDouble("Car_Booking_Price"));
                car.setDriver_ID(resultSet.getInt("Driver_ID"));
                car.setCar_Status(resultSet.getString("Car_Status"));
                
                byte[] carImageBytes = resultSet.getBytes("Car_Image");
                car.setCar_Image(carImageBytes); // Store the byte array in the car object

                // Fetch driver details based on the Driver_ID from the Car object
                Driver driver = getDriverDetails(car.getDriver_ID());

                if (driver != null) {
                    // You can use the driver information here, like:
                    String driverName = driver.getDriver_Name();
                    String driverTelephone = driver.getDriver_Telephone_Number();

                    // Now you can print or store the driver details along with the car details
                    System.out.println("Car Name: " + car.getCar_Name());
                    System.out.println("Driver Name: " + driverName);
                    System.out.println("Driver Phone: " + driverTelephone);
                }

                allCars.add(car);
                // Add the car to the list
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return allCars;
    }
    
    public static List<Car> getCarDetails() {
    	ArrayList<Car> car = new ArrayList<>();
    	try {
    		con = DatabaseConnector.getConnection();
    		stmt = con.createStatement();
    		String sql = "SELECT * FROM car_table";
    		rs = stmt.executeQuery(sql);
    		
    		while (rs.next()){
    			int Car_ID = rs.getInt(1);
    			String Car_Name = rs.getString(2);
    			
    			Car c = new Car(Car_ID, Car_Name);
    			car.add(c);
    		}
    	}
    	catch (Exception e) {
    		e.printStackTrace();
    	}
    	return car;
    }
    
    public boolean updateCar(Car car) {
        String updateCarQuery = "UPDATE car_table SET Car_Name = ?, Car_Brand = ?, Car_Number_Plate = ?, Car_Colour = ?, Car_Image = ?, Car_Booking_Price = ? WHERE Car_ID = ?";

        try (Connection connection = DatabaseConnector.getConnection()) {
            // Start transaction
            connection.setAutoCommit(false);

            // Insert the car
            try (PreparedStatement updateCarStmt = connection.prepareStatement(updateCarQuery)) {
                updateCarStmt.setString(1, car.getCar_Name());
                updateCarStmt.setString(2, car.getCar_Brand());
                updateCarStmt.setString(3, car.getCar_Number_Plate());
                updateCarStmt.setString(4, car.getCar_Colour());
                updateCarStmt.setBytes(5, car.getCar_Image());
                updateCarStmt.setDouble(6, car.getCar_Booking_Price());
                updateCarStmt.setInt(7, car.getCar_ID());

                int rowsUpdated = updateCarStmt.executeUpdate();
                if (rowsUpdated > 0) {
                    connection.commit(); // Commit only if update was successful
                    return true;
                } else {
                    connection.rollback(); // Rollback if update fails
                    return false;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public byte[] getCarImage(int carId) {
        String query = "SELECT Car_Image FROM car_table WHERE Car_ID = ?";
        byte[] carImage = null;

        try (Connection connection = DatabaseConnector.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, carId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                carImage = rs.getBytes("Car_Image");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return carImage; // Returns null if no image is found
    }

}