<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  	<meta charset="UTF-8" />
    <link href="https://cdn.jsdelivr.net/npm/remixicon@4.2.0/fonts/remixicon.css" rel="stylesheet"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=ABeeZee:ital@0;1&family=Allerta&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;400;500;700;900&family=Sen:wght@400;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel='stylesheet'>
    <link href="https://fonts.googleapis.com/css2?family=ABeeZee:ital@0;1&family=Allan:wght@400;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css" />
    <title>Hire Charge Applying</title>
  </head>
  
  <body>
  	<div class="navbar">
      <div class="navbar-container">
        <div class="logo-container">
          <h1 class="logo">MEGA CITY CAB</h1>
        </div>
        <div class="menu-icon">&#9776;</div>
        <div class="menu-container">
          <ul class="menu-list">
            <li class="menu-list-item"><menu><a class="link-stylings" href="Home.jsp">HOME</a></menu> </li>
            <li class="menu-list-item"><menu><a class="link-stylings" href="Cabs.jsp">CABS</a></menu> </li>
            <li class="menu-list-item"><menu><a class="link-stylings" href="Help.jsp">HELP</a></menu> </li>
            <li class="menu-list-item"><menu><a class="link-stylings" href="AboutUs.jsp">ABOUT US</a></menu> </li>
            <%
    // Retrieve session attributes safely
    Integer Driver_ID = (Integer) session.getAttribute("Driver_ID");
    String Driver_Name = (String) session.getAttribute("Driver_Name");

    // Check if User_ID exists in session
    if (Driver_ID == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    String searchTerm = request.getParameter("search");
%>

<form action="Cabs.jsp" method="GET" class="menu-list-item-search-bar-main">
    <li class="menu-list-item">
        <menu>
            <input type="text" name="search" class="menu-list-item-search-bar" placeholder="Search">
        </menu>
    </li>
    <li class="menu-list-item">
        <button type="submit" class="search-menu-icon-button"><i class="search-menu-icon fas fa-search"></i></button>
    </li>
</form>



<%
    try {
        // Load the database driver
        Class.forName("com.mysql.jdbc.Driver");
        // Establish connection
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab1?characterEncoding=utf8&serverTimezone=UTC", "root", "");

        // SQL query to join booking_table and filter by User_ID
        String query = "SELECT booking_table.Booking_ID, booking_table.Car_Name, booking_table.Car_Brand, " +
                       "booking_table.Car_Number_Plate, booking_table.Car_Colour, booking_table.Driver_Name, booking_table.Driver_Telephone_Number, booking_table.Car_Booking_Price, " +
                       "booking_table.User_Telephone_Number, booking_table.User_Username, booking_table.User_Address, booking_table.User_Current_Location, booking_table.User_Destination, " +
                       "booking_table.Booked_Date, booking_table.Booked_Time, booking_table.Hire_Charge, booking_table.Total_Payable_Amount " +
                       "FROM booking_table WHERE Driver_ID = ? AND Hire_Charge = 'Will be Notified Soon' AND Total_Payable_Amount = 'Will be Notified Soon'";

        // Add search filtering if searchTerm exists
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            query += " AND (booking_table.Car_Name LIKE ? OR " +
                     "booking_table.User_Username LIKE ? OR " +
                     "booking_table.Booked_Date LIKE ? OR " +
                     "booking_table.Booked_Time LIKE ? OR " +
                     "booking_table.User_Current_Location LIKE ? OR " +
                     "booking_table.User_Destination LIKE ?)";
        }

        // Prepare the statement
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, Driver_ID);

        // Bind search term parameters
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            String searchPattern = "%" + searchTerm + "%";
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setString(4, searchPattern);
            ps.setString(5, searchPattern);
            ps.setString(6, searchPattern);
            ps.setString(7, searchPattern);
        }

        // Execute the query
        ResultSet rs = ps.executeQuery();
        boolean hasResults = false;
%>
          </ul>
        </div>
      </div>
    </div>

    <c:choose>
        <c:when test="${not empty Driver_Name && not empty Driver_ID}">
            <!-- Display navbar2 and user content if logged in -->
            <div class="navbar2">
                <div class="navbar-container2">
                    <div class="menu-icon2">&#9776;</div>
                    <div class="menu-container2">
                        <ul class="menu-list2">
                            <li class="menu-list-item2"><menu><a class="link-stylings2" href="EnterHireCharge.jsp">ENTER HIRE CHARGE</a></menu></li>
                            <li class="menu-list-item2"><menu><a class="link-stylings2" href="FinishJourney.jsp">FINISH JOURNEY</a></menu></li>
                            <li class="menu-list-item2"><menu><a class="link-stylings2" href="CabBookingsDriver.jsp">FINISHED HIRES</a></menu></li>
                            <li class="menu-list-item2"><menu><a class="link-stylings2" href="AssignedCab.jsp">ASSIGNED CAB</a></menu></li>
                        </ul>
                    </div>
                    <div class="logo-container2">
                        <h1 class="logo2">WELCOME ${Driver_Name}</h1>
                    </div>
                </div>
            </div>
            <div class="sidebar">
                <div class="menu-item"><a href="javascript:void(0);" onclick="confirmLogout()">LOGOUT</a></div>
            </div>
        </c:when>

        <c:otherwise>
            <!-- Display alternative content when logged out -->
            <div class="sidebar">
                <div class="menu-item"><a href="Register.jsp">CUSTOMER REGISTER</a></div>
                <div class="menu-item"><a href="Login.jsp">CUSTOMER LOGIN</a></div>
                <div class="menu-item"><a href="DriverRegister.jsp">DRIVER REGISTER</a></div>
                <div class="menu-item"><a href="DriverLogin.jsp">DRIVER LOGIN</a></div>
            </div>
        </c:otherwise>
    </c:choose>

    <h1 class="header1">Hire Charge Entering List</h1>
    
    <div class="search-bar">
      <form method="GET" action="">
        <div class="search-container">
          <input type="text" name="search" placeholder="Search by Appointment Date or Time" value="<%= searchTerm != null ? searchTerm : "" %>">
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
        	<th>Action</th>
            <th>Booking ID</th>
            <th>Car Name</th>
            <th>Car Brand</th>
            <th>Car Number Plate</th>
            <th>Car Colour</th>
            <th>Your Name</th>
            <th>Your Telephone Number</th>
            <th>Cab Booking Price</th>
            <th>Customer Name</th>
            <th>Customer Telephone Number</th>
            <th>Customer Address</th>
            <th>Customer Current Location</th>
            <th>Customer Destination</th>
            <th>Booked Date by Customer</th>
            <th>Booked Time by customer</th>
            <th>Hire Charge</th>
            <th>Total Payable Amount</th>
        </tr>

        <%
            // Loop through the result set
            while (rs.next()) {
                hasResults = true;
        %>
        <tr>
        	<td><a href='ConfirmHireCharge.jsp?Booking_ID=<%= rs.getInt("Booking_ID") %>'><button class='read-more-button'>Enter Hire Charge</button></a></td>
            <td><%= rs.getString("Booking_ID") %></td>
            <td><%= rs.getString("Car_Name") %></td>
            <td><%= rs.getString("Car_Brand") %></td>
            <td><%= rs.getString("Car_Number_Plate") %></td>
            <td><%= rs.getString("Car_Colour") %></td>
            <td><%= rs.getString("Driver_Name") %></td>
            <td><%= rs.getString("Driver_Telephone_Number") %></td>
            <td><%= rs.getString("Car_Booking_Price") %></td>
            <td><%= rs.getString("User_Username") %></td>
            <td><%= rs.getString("User_Telephone_Number") %></td>
            <td><%= rs.getString("User_Address") %></td>
            <td><%= rs.getString("User_Current_Location") %></td>
            <td><%= rs.getString("User_Destination") %></td>
            <td><%= rs.getString("Booked_Date") %></td>
            <td><%= rs.getString("Booked_Time") %></td>
            <td><%= rs.getString("Hire_Charge") %></td>
            <td><%= rs.getString("Total_Payable_Amount") %></td>
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
   
    <footer class="footer">
      <div class="footer__container">
        <div class="footer__section">
          <h3>Why Choose Us</h3>
          <p>Get the most strengthful experience</p>
        </div>
        <div class="footer__section">
          <h3>Quick Links</h3>
          <ul>
            <li><a href="Home.php">Home</a></li>
            <li><a href="Register.php">Register</a></li>
            <li><a href="Login.php">Login</a></li>
            <li><a href="AboutUs.php">About Us</a></li>
          </ul>
        </div>
        <div class="footer__section">
          <h3>Contact</h3>
          <ul>
            <li>Email: support@fitzonefitnesscenter.lk</li>
            <li>Phone: +94 775697120</li>
            <li>Address: 456 Some Street, Somewhere</li>
          </ul>
        </div>
      </div>
      <div class="footer__copy">© 2024 FITZONE FITNESS CENTER. All rights reserved.</div>
    </footer>
    
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        const menuIcon = document.querySelector(".menu-icon");
        const menuIcon2 = document.querySelector(".menu-icon2");
        const menuContainer = document.querySelector(".menu-container");
        const menuContainer2 = document.querySelector(".menu-container2");
      
        menuIcon.addEventListener("click", () => {
          menuContainer.classList.toggle("active");
        });

        menuIcon2.addEventListener("click", () => {
          menuContainer2.classList.toggle("active");
        });
      });
    </script>
    <script type="text/javascript">
        // Function to confirm logout
        function confirmLogout() {
            // Show confirmation dialog
            var result = confirm("Are you sure you want to log out?");
            
            if (result) {
                // If user confirms, clear the session and reload the page (logout on same page)
                // Send a request to logout
                window.location.href = "LogoutProcess.jsp"; // Or directly handle session invalidation
            } else {
                // If user cancels, do nothing
                alert("You are still logged in.");
            }
        }
    </script>
  </body>
</html>