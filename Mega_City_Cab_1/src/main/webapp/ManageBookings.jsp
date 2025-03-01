<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Bookings</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap');
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Roboto', sans-serif;
  }
  body {
    height: 100vh;
    display: flex;
    flex-direction: column;
    background: linear-gradient(135deg, #89f7fe, #66a6ff);
    color: #333;
  }
  
  .menu-box {
  background-color: #ffffff; /* White background for table container */
  padding: 20px;
  border-radius: 12px;
  width: 100%;
  max-width: 100%;
  box-sizing: border-box; /* Includes padding and borders in width calculation */
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  overflow-x: auto; /* Ensures horizontal scrolling if content overflows */
  margin-top: 40px;
}

.header1 {
  font-size: 28px;
  font-weight: 600;
  color: #ff7eb3; /* Orange header */
  margin-bottom: 20px;
  text-align: center;
}

.search-bar {
  margin: 20px 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
}

.search-container {
  display: flex;
  align-items: center;
  gap: 10px; /* Adds a 10px gap between the input field and the button */
  width: 100%;
  justify-content: center;
}

.search-container input[type="text"] {
  padding: 10px 15px;
  width: 600px;
  border: 2px solid #ff7eb3; /* Orange border */
  border-radius: 5px;
  font-size: 16px;
  background-color: #1a1a1a; /* Black background */
  color: #ffffff; /* White text */
  box-sizing: border-box; /* Includes padding and borders in width */
}

.search-container button {
  padding: 10px 20px;
  background: linear-gradient(135deg, #66a6ff, #ff7eb3);
  color: #ffffff;
  border: none;
  border-radius: 5px;
  font-size: 16px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.search-container button:hover {
  background: linear-gradient(135deg, #ff7eb3, #66a6ff);
}

.search-label {
  margin-top: 10px;
  font-size: 18px;
  font-weight: 500;
  color: #66a6ff; /* Orange label */
}

.menu-box table {
  width: 100%;
  border-collapse: collapse;
  box-sizing: border-box; /* Includes padding and borders */
}

.menu-box th {
  background: linear-gradient(135deg, #66a6ff, #ff7eb3);
  color: #ffffff; /* White text */
  font-weight: 500;
  text-transform: uppercase;
  padding: 15px;
  font-size: 14px;
  border-top: 1px solid #d0d7de;
  text-align: left;
}

.menu-box td {
  padding: 12px 15px;
  font-size: 15px;
  color: #333; /* Dark text for table cells */
  background-color: #f9f9f9; /* Light gray background */
}

.menu-box tr:nth-child(even) td {
  background-color: #ffffff; /* Alternate row color */
}

.menu-box tr:hover td {
  background-color: rgb(196, 218, 250); /* Light orange hover effect */
}

.menu-box img {
  width: 60px;
  height: auto;
  box-shadow: 
    1px 1px 3px #1a1a1a,  /* Slight offset for the first shadow */
    -1px -1px 3px #333,   /* Opposite offset for top-left lighting */
    inset 1px 1px 2px rgba(0, 0, 0, 0.3); /* Inner shadow for depth */
  border-radius: 5px;
}

.menu-box .action-cell {
  display: flex;
  justify-content: center;
  gap: 8px;
  white-space: nowrap;
}

.menu-box .btndel1 {
  padding: 8px 12px;
  background-color: #ffa500; /* Orange buttons in the table */
  border: none;
  border-radius: 5px;
  color: white;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.3s;
}

.menu-box .btndel1:hover {
  background-color: #cc8400; /* Darker orange hover effect */
}

.read-more-button {
  margin-top: 20px;
  width: fit-content;
  padding: 6px;
  font-size: 18px;
  background: linear-gradient(90deg, #007BFF, #FF69B4);
  border: none;
  border-radius: 50px;
  color: #fff;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.read-more-button:hover {
  background-color: #c84f2b; /* Slightly darker orange */
}

/* Responsive Design */
@media (max-width: 768px) {
  .menu-box {
    padding: 15px;
    width: 100%;
  }

  .header1 {
    font-size: 24px;
  }

  .search-container {
    flex-direction: column;
  }

  .search-container input[type="text"] {
    width: 100%;
    max-width: 90%;
  }

  .menu-box table {
    display: block;
    overflow-x: auto;
    white-space: nowrap;
  }

  .menu-box th,
  .menu-box td {
    font-size: 13px;
    padding: 10px;
  }

  .menu-box img {
    width: 50px;
  }

  .menu-box .action-cell {
    flex-direction: column;
    gap: 5px;
  }

  .search-container button {
    width: auto;
    padding: 8px 16px;
    font-size: 14px;
  }
}
</style>
</head>

<body>
<%
    // Retrieve session attributes safely
    

    String searchTerm = request.getParameter("search");
%>
  <%
    try {
        // Load the database driver
        Class.forName("com.mysql.jdbc.Driver");
        // Establish connection
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab1?characterEncoding=utf8&serverTimezone=UTC", "root", "Helanga@2003");

        // SQL query to join booking_table and filter by User_ID
        String query = "SELECT booking_table.Booking_ID, booking_table.Car_ID, booking_table.Car_Name, booking_table.Car_Brand, " +
                       "booking_table.Car_Number_Plate, booking_table.Car_Colour, booking_table.Driver_ID, booking_table.Driver_Name, booking_table.Driver_Telephone_Number, booking_table.Car_Booking_Price, " +
                       "booking_table.User_ID, booking_table.User_Username, booking_table.User_Telephone_Number, booking_table.User_Address, booking_table.User_Current_Location, booking_table.User_Destination, " +
                       "booking_table.Booked_Date, booking_table.Booked_Time, booking_table.Hire_Charge, booking_table.Total_Payable_Amount, booking_table.Journey_Status " +
                       "FROM booking_table";

        // Add search filtering if searchTerm exists
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            query += " WHERE (booking_table.Booking_ID LIKE ? OR " +
                     "booking_table.Car_ID LIKE ? OR " +
                     "booking_table.Car_Name LIKE ? OR " +
                     "booking_table.Car_Brand LIKE ? OR " +
                     "booking_table.Car_Number_Plate LIKE ? OR " +
                     "booking_table.Car_Colour LIKE ? OR " +
                     "booking_table.Driver_ID LIKE ? OR " +
                     "booking_table.Driver_Name LIKE ? OR " +
                     "booking_table.Driver_Telephone_Number LIKE ? OR " +
                     "booking_table.Car_Booking_Price LIKE ? OR " +
                     "booking_table.User_ID LIKE ? OR " +
                     "booking_table.User_Username LIKE ? OR " +
                     "booking_table.User_Telephone_Number LIKE ? OR " +
                     "booking_table.User_Address LIKE ? OR " +
                     "booking_table.User_Current_Location LIKE ? OR " +
                     "booking_table.User_Destination LIKE ? OR " +
                     "booking_table.Booked_Date LIKE ? OR " +
                     "booking_table.Booked_Time LIKE ? OR " +
                     "booking_table.Hire_Charge LIKE ? OR " +
                     "booking_table.Total_Payable_Amount LIKE ? OR " +
                     "booking_table.Journey_Status LIKE ?)";
        }

        // Prepare the statement
        PreparedStatement ps = con.prepareStatement(query);

        // Bind search term parameters
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            String searchPattern = "%" + searchTerm + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setString(4, searchPattern);
            ps.setString(5, searchPattern);
            ps.setString(6, searchPattern);
            ps.setString(7, searchPattern);
            ps.setString(8, searchPattern);
            ps.setString(9, searchPattern);
            ps.setString(10, searchPattern);
            ps.setString(11, searchPattern);
            ps.setString(12, searchPattern);
            ps.setString(13, searchPattern);
            ps.setString(14, searchPattern);
            ps.setString(15, searchPattern);
            ps.setString(16, searchPattern);
            ps.setString(17, searchPattern);
            ps.setString(18, searchPattern);
            ps.setString(19, searchPattern);
            ps.setString(20, searchPattern);
            ps.setString(21, searchPattern);
        }

        // Execute the query
        ResultSet rs = ps.executeQuery();
        boolean hasResults = false;
%>

<h1 class="header1">Cab Booking List</h1>

<div class="search-bar">
      <form method="GET" action="">
        <div class="search-container">
          <input type="text" name="search" placeholder="Search by Any Criteria" value="<%= searchTerm != null ? searchTerm : "" %>">
          <button type="submit">Search</button>
        </div>
      </form>
      <%
    	if (searchTerm != null && !searchTerm.trim().isEmpty()) {
	%>
    <p class="search-label">Search results for "<%= searchTerm %>"</p>
	<%
    	}
	%>
    </div>
    
    <div class="menu-box">
    <table>
        <tr>
            <th>Booking ID</th>
            <th>Car ID</th>
            <th>Car Name</th>
            <th>Car Brand</th>
            <th>Car Number Plate</th>
            <th>Car Colour</th>
            <th>Driver ID</th>
            <th>Driver Name</th>
            <th>Driver Telephone Number</th>
            <th>Cab Booking Price</th>
            <th>User ID</th>
            <th>User Username</th>
            <th>User Telephone Number</th>
            <th>User Address</th>
            <th>User Current Location</th>
            <th>User Destination</th>
            <th>Booked Date</th>
            <th>Booked Time</th>
            <th>Hire Charge</th>
            <th>Total Payable Amount</th>
            <th>Journey Status</th>
        </tr>

        <%
            // Loop through the result set
            while (rs.next()) {
                hasResults = true;
        %>
        <tr>
            <td><%= rs.getString("Booking_ID") %></td>
            <td><%= rs.getString("Car_ID") %></td>
            <td><%= rs.getString("Car_Name") %></td>
            <td><%= rs.getString("Car_Brand") %></td>
            <td><%= rs.getString("Car_Number_Plate") %></td>
            <td><%= rs.getString("Car_Colour") %></td>
            <td><%= rs.getString("Driver_ID") %></td>
            <td><%= rs.getString("Driver_Name") %></td>
            <td><%= rs.getString("Driver_Telephone_Number") %></td>
            <td><%= rs.getString("Car_Booking_Price") %></td>
            <td><%= rs.getString("User_ID") %></td>
            <td><%= rs.getString("User_Username") %></td>
            <td><%= rs.getString("User_Telephone_Number") %></td>
            <td><%= rs.getString("User_Address") %></td>
            <td><%= rs.getString("User_Current_Location") %></td>
            <td><%= rs.getString("User_Destination") %></td>
            <td><%= rs.getString("Booked_Date") %></td>
            <td><%= rs.getString("Booked_Time") %></td>
            <td><%= rs.getString("Hire_Charge") %></td>
            <td><%= rs.getString("Total_Payable_Amount") %></td>
            <td><%= rs.getString("Journey_Status") %></td>
        </tr>
        <%
            }
            // If no results are found, display a message
            if (!hasResults) {
        %>
        <tr>
            <td colspan="25" style="text-align: center;">No results found</td>
        </tr>
        <%
            }
        %>
    </table>
</div>

<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>