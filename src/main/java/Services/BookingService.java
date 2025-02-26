package Services;

import java.sql.Connection;
import java.sql.PreparedStatement;

import Controllers.DatabaseConnector;
import Models.Booking;

public class BookingService {
	public boolean registerBooking(Booking booking) {
        String insertBookingQuery = "INSERT INTO booking_table "
                              + "(Booking_ID, Car_ID, Car_Name, Car_Brand, Car_Number_Plate, Car_Colour, Driver_ID, Driver_Name, Driver_Telephone_Number, Car_Booking_Price, User_ID, User_Username, User_Telephone_Number, User_Address, User_Current_Location, User_Destination, Hire_Charge, Total_Payable_Amount)"
                              + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        String updateCarStatusQuery = "UPDATE car_table "
                                       + "SET Car_Status = 'Not Available' "
                                       + "WHERE Car_ID = ? AND Car_Status = 'Available'";

        try (Connection connection = DatabaseConnector.getConnection()) {
            // Start transaction
            connection.setAutoCommit(false);

            // Insert the booking
            try (PreparedStatement insertBookingStmt = connection.prepareStatement(insertBookingQuery)) {
            	insertBookingStmt.setInt(1, booking.getBooking_ID());
                insertBookingStmt.setInt(2, booking.getCar_ID());
                insertBookingStmt.setString(3, booking.getCar_Name());
                insertBookingStmt.setString(4, booking.getCar_Brand());
                insertBookingStmt.setString(5, booking.getCar_Number_Plate());
                insertBookingStmt.setString(6, booking.getCar_Colour());
                insertBookingStmt.setInt(7, booking.getDriver_ID());
                insertBookingStmt.setString(8, booking.getDriver_Name());
                insertBookingStmt.setString(9, booking.getDriver_Telephone_Number());
                insertBookingStmt.setDouble(10, booking.getCar_Booking_Price());
                insertBookingStmt.setInt(11, booking.getUser_ID());
                insertBookingStmt.setString(12, booking.getUser_Username());
                insertBookingStmt.setString(13, booking.getUser_Telephone_Number());
                insertBookingStmt.setString(14, booking.getUser_Address());
                insertBookingStmt.setString(15, booking.getUser_Current_Location());
                insertBookingStmt.setString(16, booking.getUser_Destination());
                insertBookingStmt.setString(17, booking.getHire_Charge());
                insertBookingStmt.setString(18, booking.getTotal_Payable_Amount());
                insertBookingStmt.executeUpdate();
            }

            // Update the driver's status
            try (PreparedStatement updateCarStmt = connection.prepareStatement(updateCarStatusQuery)) {
                updateCarStmt.setInt(1, booking.getCar_ID());
                int rowsUpdated = updateCarStmt.executeUpdate();

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
	
	public boolean updateHireChargeandTotalPayableAmount(Booking booking) {
        String updateHireChargeAndTotalPayableAmountQuery = "UPDATE booking_table SET Hire_Charge = ?, Total_Payable_Amount = ? WHERE Booking_ID = ?";

        try (Connection connection = DatabaseConnector.getConnection()) {
            // Start transaction
            connection.setAutoCommit(false);

            // Insert the booking
            try (PreparedStatement insertHireChargeAndTotalPayableAmountStmt = connection.prepareStatement(updateHireChargeAndTotalPayableAmountQuery)) {
            	insertHireChargeAndTotalPayableAmountStmt.setString(1, booking.getHire_Charge());
            	insertHireChargeAndTotalPayableAmountStmt.setString(2, booking.getTotal_Payable_Amount());
            	insertHireChargeAndTotalPayableAmountStmt.setInt(3, booking.getBooking_ID());
                insertHireChargeAndTotalPayableAmountStmt.executeUpdate();
            }

            connection.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
	
	public boolean makeCarStatusAvailable(Booking booking) {
        String finishJourneyQuery = "UPDATE booking_table SET Journey_Status = ? WHERE Booking_ID = ? AND Car_ID = ?";
        
        String updateCarStatusQuery1 = "UPDATE car_table "
                                       + "SET Car_Status = 'Available' "
                                       + "WHERE Car_ID = ? AND Car_Status = 'Not Available'";

        try (Connection connection = DatabaseConnector.getConnection()) {
            // Start transaction
            connection.setAutoCommit(false);

            // Insert the booking
            try (PreparedStatement insertBookingStmt = connection.prepareStatement(finishJourneyQuery)) {
            	insertBookingStmt.setString(1, booking.getJourney_Status());
                insertBookingStmt.setInt(2, booking.getBooking_ID());
                insertBookingStmt.setInt(3, booking.getCar_ID());
                insertBookingStmt.executeUpdate();
            }

            // Update the driver's status
            try (PreparedStatement updateCarStmt = connection.prepareStatement(updateCarStatusQuery1)) {
                updateCarStmt.setInt(1, booking.getCar_ID());
                int rowsUpdated = updateCarStmt.executeUpdate();

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
            System.err.println("Error details: " + e.getMessage());
            return false;
        }
    }
	
}