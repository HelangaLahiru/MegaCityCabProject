<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.sql.*" %>
<%@page import="java.sql.*, java.util.Base64, java.io.*" %>
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
    <title>Your Assigned Cab</title>
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
          </ul>
        </div>
      </div>
    </div>
    <% 
    // Retrieve session attributes
    Integer Driver_ID = (Integer) session.getAttribute("Driver_ID");
    String Driver_Name = (String) session.getAttribute("Driver_Name");

    // Redirect to login if not logged in
    if (Driver_ID == null) {
        response.sendRedirect("DriverLogin.jsp");
        return;
    }
    %>

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

    <h1 class="header1">Your Assigned Cab</h1>
        <div class="menu-box">
            <table border="1">
                <tr>
                    <th>Cab ID</th>
                    <th>Cab Name</th>
                    <th>Cab Brand</th>
                    <th>Cab Number Plate</th>
                    <th>Cab Colour</th>
                    <th>Cab Image</th>
                    <th>Assignability Status</th>
                </tr>
                <%
                try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab1?characterEncoding=utf8&serverTimezone=UTC", "root", "Helanga@2003")) {
                    Class.forName("com.mysql.jdbc.Driver");

                    String query = "SELECT c.Car_ID, c.Car_Name, c.Car_Brand, c.Car_Number_Plate, " +
                                   "c.Car_Colour, c.Car_Image, d.Car_Assignability_Status " +
                                   "FROM car_table c " +
                                   "LEFT JOIN driver_table d ON c.Driver_ID = d.Driver_ID " +
                                   "WHERE c.Driver_ID = ?";
                    
                    try (PreparedStatement ps = con.prepareStatement(query)) {
                        ps.setInt(1, Driver_ID);
                        try (ResultSet rs = ps.executeQuery()) {
                            boolean hasResults = false;
                            while (rs.next()) {
                                hasResults = true;
                                byte[] imgData = rs.getBytes("Car_Image");
                                String base64Image = (imgData != null) ? Base64.getEncoder().encodeToString(imgData) : "";
                %>
                <tr>
                    <td><%= rs.getInt("Car_ID") %></td>
                    <td><%= rs.getString("Car_Name") %></td>
                    <td><%= rs.getString("Car_Brand") %></td>
                    <td><%= rs.getString("Car_Number_Plate") %></td>
                    <td><%= rs.getString("Car_Colour") %></td>
                    <td>
                        <% if (!base64Image.isEmpty()) { %>
                            <img src="data:image/jpeg;base64,<%= base64Image %>"/>
                        <% } else { %>
                            No Image Available
                        <% } %>
                    </td>
                    <td><%= rs.getString("Car_Assignability_Status") %></td>
                </tr>
                <%
                            }
                            if (!hasResults) {
                %>
                <tr>
                    <td colspan="7" style="text-align: center;">Please Wait, Your Cab Assigning Process is Pending</td>
                </tr>
                <%
                            }
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                %>
            </table>
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