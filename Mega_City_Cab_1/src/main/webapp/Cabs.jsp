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
    <link rel="stylesheet" href="carstyles.css" />
    <title>Cabs</title>
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
            	try {
    				// Load the database driver
    				Class.forName("com.mysql.jdbc.Driver");
    				// Establish connection
    				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab1?characterEncoding=utf8&serverTimezone=UTC", "root", "Helanga@2003");

    				// Get the search term from the request
    				String searchTerm = request.getParameter("search");

    				// SQL query to join car_table and driver_table with search filtering
    				String query = "SELECT car_table.Car_ID, car_table.Car_Name, car_table.Car_Brand, " +
                   		"car_table.Car_Number_Plate, car_table.Car_Colour, car_table.Car_Image, " +
                   		"car_table.Car_Booking_Price, car_table.Car_Status, driver_table.Driver_Name, driver_table.Driver_Telephone_Number " +
                   		"FROM car_table " +
                   		"LEFT JOIN driver_table ON car_table.Driver_ID = driver_table.Driver_ID";
    				
    				// If there's a search term, add a WHERE clause to filter results
    				if (searchTerm != null && !searchTerm.trim().isEmpty()) {
        				query += " WHERE car_table.Car_Name LIKE ? OR " +
                 		"car_table.Car_Brand LIKE ? OR " +
                 		"car_table.Car_Booking_Price LIKE ?";
        			}

    				// Prepare the statement
    				PreparedStatement ps = con.prepareStatement(query);
    				
    				// If there's a search term, bind the parameters
    				if (searchTerm != null && !searchTerm.trim().isEmpty()) {
        			String searchPattern = "%" + searchTerm + "%";
        			ps.setString(1, searchPattern);
        			ps.setString(2, searchPattern);
        			ps.setString(3, searchPattern);
    			}

    			// Execute the query
    			ResultSet rs = ps.executeQuery();
    			boolean hasResults = false;
			%>

            <form action="" method="GET" class="menu-list-item-search-bar-main">
    			<li class="menu-list-item"><menu><input type="text" name="search" class="menu-list-item-search-bar" placeholder="Search" value="<%= searchTerm != null ? searchTerm : "" %>"></menu></li>
    			<li class="menu-list-item"><button type="submit" class="search-menu-icon-button"><i class="search-menu-icon fas fa-search"></i></button></li>
			</form>
          </ul>
        </div>
      </div>
    </div>

    <%
        // Retrieve session attributes safely
        Integer User_ID = (Integer) session.getAttribute("User_ID");
        String User_Username = (String) session.getAttribute("User_Username");
        String User_Telephone_Number = (String) session.getAttribute("User_Telephone_Number");
        String User_Address = (String) session.getAttribute("User_Address");
    %>

    <c:choose>
        <c:when test="${not empty User_Username && not empty User_ID}">
            <!-- Display navbar2 and user content if logged in -->
            <div class="navbar2">
                <div class="navbar-container2">
                    <div class="menu-icon2">&#9776;</div>
                    <div class="menu-container2">
                        <ul class="menu-list2">
                            <li class="menu-list-item2"><menu><a class="link-stylings2" href="CabBookingsCustomer.jsp">MY CAB BOOKINGS</a></menu></li>
                        </ul>
                    </div>
                    <div class="logo-container2">
                        <h1 class="logo2">WELCOME ${User_Username}</h1>
                    </div>
                </div>
            </div>
            <div class="sidebar">
                <div class="menu-item"><a href="javascript:void(0);" onclick="confirmLogout()">LOGOUT</a></div>
            </div>
        </c:when>
        
        <c:when test="${not empty Driver_Name && not empty Driver_ID}">
            <!-- Display navbar2 and user content if logged in -->
            <div class="navbar2">
                <div class="navbar-container2">
                    <div class="menu-icon2">&#9776;</div>
                    <div class="menu-container2">
                        <ul class="menu-list2">
                            <li class="menu-list-item2"><menu><a class="link-stylings2" href="EnterHireCharge.jsp">ENTER HIRE CHARGE</a></menu></li>
                            <li class="menu-list-item2"><menu><a class="link-stylings2" href="FinishJourney.jsp">FINISH JOURNEY</a></menu></li>
                            <li class="menu-list-item2"><menu><a class="link-stylings2" href="CabBookingsDriver.jsp">MY CAB RIDES</a></menu></li>
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

    <h2 class="section__header">CABS</h2>
    
    <%
    	if (searchTerm != null && !searchTerm.trim().isEmpty()) {
	%>
    <p class="search-label">Search results for "<%= searchTerm %>"</p>
	<%
    	}
	%>
    
    <div class="container3">
      <section class="section__container1" id="menu">
         <div class='order__grid'>
         	<% 
      			// Loop through the results
      			while (rs.next()) {
          		// Set hasResults to true when there are results
          		hasResults = true;
          
          		// Retrieve the image as a byte array
          		byte[] imgData = rs.getBytes("Car_Image");

          		// Convert the image data to Base64
          		String base64Image = null;
          		if (imgData != null) {
          			base64Image = java.util.Base64.getEncoder().encodeToString(imgData);
          		}
          	%>
          	<div class='order__card'>
          		<% if (base64Image != null) { %>
          			<img class="plan-image" src="data:image/jpeg;base64,<%= base64Image %>" alt="Car Image" />
              	<% } else { %>
                  	<img class="plan-image" src="placeholder.jpg" alt="Placeholder Image" /> <!-- Placeholder if no image -->
              	<% } %>
              	<h4>Car Name: <%= rs.getString("Car_Name") %></h4>
              	<p class="paragraph-description">Brand: <%= rs.getString("Car_Brand") %></p>
              	<h5>Number Plate: <%= rs.getString("Car_Number_Plate") %></h5>
              	<h6>Colour: <%= rs.getString("Car_Colour") %></h6>
              	<p class="paragraph-description2">Booking Price: Rs. <%= rs.getDouble("Car_Booking_Price") %></p>
              
              	<!-- Display driver's name and telephone number -->
              	<p>Driver Name: <%= rs.getString("Driver_Name") != null ? rs.getString("Driver_Name") : "Not Assigned" %></p>
              	<p>Driver Telephone: <%= rs.getString("Driver_Telephone_Number") != null ? rs.getString("Driver_Telephone_Number") : "Not Available" %></p>
              
              	<h5>Availability: <%= rs.getString("Car_Status") %></h5>
              	<a href='BookCab.jsp?Car_ID=<%= rs.getInt("Car_ID") %>'>
              		<c:choose>
        				<c:when test="${not empty User_Username && not empty User_ID}">
          		  			<button class='read-more-button' style="<%= rs.getString("Car_Status").equals("Not Available") ? "cursor: not-allowed; opacity: 0.3;" : "" %>" 
              				<%= rs.getString("Car_Status").equals("Not Available") ? "disabled" : "" %>>Book Cab</button>
          				</c:when>
          	  		</c:choose>
      			</a>
          	</div>
      		<% 
      			}
         		// If no results are found, display the "No cars available" message
         		if (!hasResults) {
  			%>
      		<p>No cars available at the moment.</p>
  			<% 
      			}
				} catch (Exception e) {
    			e.printStackTrace();
				}
			%>
		</div>
      </section>
    </div>
      
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
            <li>Email: support@megacitycabs.lk</li>
            <li>Phone: +94 775697120</li>
            <li>Address: 456 Some Street, Somewhere</li>
          </ul>
        </div>
      </div>
      <div class="footer__copy">© 2024 MEGA CITY CABS. All rights reserved.</div>
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