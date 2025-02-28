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
    <title>Confirming Hire Charge</title>
    <style>
    	@import url("https://fonts.googleapis.com/css2?family=Alfa+Slab+One&family=Bebas+Neue&family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap");
    
    	:root {
  			--primary-color: #42200b;
  			--secondary-color: #ffc135;
  			--tertiary-color: #df1c1c;
  			--price-outline-color: #e7e730;
  			--text-dark: #212529;
  			--white: #ffffff;
  			--max-width: 1200px;
  			--header-font-1: "Alfa Slab One", serif;
  			--header-font-2: "Bebas Neue", sans-serif;
		}

		.allan-regular {
  			font-family: "Allan", serif;
  			font-weight: 400;
  			font-style: normal;
		}

		.allan-bold {
  			font-family: "Allan", serif;
  			font-weight: 700;
  			font-style: normal;
		}

    	.container {
  			display: flex;
  			justify-content: center;
  			align-items: center;
			background-color: #f9f9f9;
  			margin-bottom: 40px;
		}

		.content-container {
  			width: 100%;
  			max-width: 800px;
  			padding: 20px;
  			background-color: #fff;
  			border-radius: 8px;
  			box-shadow: 0 4px 10px rgba(0, 0, 0, 3);
		}

		.food-list-container {
  			text-align: center;
		}

		.food-list-title {
  			font-size: 3rem;
  			font-weight: 500;
  			font-family: var(--header-font-1);
  			background: linear-gradient(180deg, #007BFF, #FF69B4);
      		-webkit-background-clip: text;
      		-webkit-text-fill-color: transparent;
  			text-align: center;
  			text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
		}

		.food-list-wrapper {
  			display: flex;
  			justify-content: center;
		}

		.food-list {
  			width: 100%;
		}

		.food-image {
  			max-width: 100%;
  			height: auto;
  			border-radius: 8px;
  			margin-bottom: 20px;
  			margin-top: 20px
		}

		.form-group {
  			margin-top: 25px;
  			margin-bottom: 20px;
		}

		.title {
  			font-size: 30px;
  			margin-bottom: 8px;
  			color: #555;
		}

		.input-box, .quantity-choosing, .input-box-total-payable-amount {
  			width: 100%;
  			padding: 12px;
  			font-size: 22px;
  			text-align: center;
  			border: 1px solid #ddd;
  			border-radius: 4px;
  			background-color: #f4f4f4;
  			box-sizing: border-box;
		}

		.input-box-total-payable-amount {
  			font-size: 28px;
  			font-weight: 800;
  			color: #e819ff;
		}

		.quantity-choosing {
  			background-color: #fff;
		}

		.order-button {
  			width: 100%;
  			padding: 12px;
  			background-color: #e91e63;
  			color: #fff;
  			font-weight: 900;
  			border: none;
  			border-radius: 40px;
  			font-size: 34px;
  			cursor: pointer;
  			transition: background-color 0.3s;
		}

		.order-button:hover {
  			background-color: #d81b60;
		}
  </style>
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
    			<li class="menu-list-item"><menu><input type="text" name="search" class="menu-list-item-search-bar" placeholder="Search"></menu></li>
    			<li class="menu-list-item"><button type="submit" class="search-menu-icon-button"><i class="search-menu-icon fas fa-search"></i></button></li>
			</form>
          </ul>
        </div>
      </div>
    </div>

    <%
        // Retrieve session attributes safely
        Integer Driver_ID = (Integer) session.getAttribute("Driver_ID");
        String Driver_Name = (String) session.getAttribute("Driver_Name");
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
                            <li class="menu-list-item2"><menu><a class="link-stylings2" href="CabBookingsDriver.jsp">MY CAB RIDES</a></menu></li>
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

    <h2 class="section__header">ENTER YOUR HIRE CHARGE</h2>
    
<%
    try {
        // Load the database driver
        Class.forName("com.mysql.jdbc.Driver");
        // Establish connection
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab1?characterEncoding=utf8&serverTimezone=UTC", "root", "");

        // Get the Car_ID from the request
        String bookingId = request.getParameter("Booking_ID");

        // SQL query to join car_table and driver_table with search filtering
        String query = "SELECT booking_table.Booking_ID, booking_table.User_Username, booking_table.User_Telephone_Number, " +
                       "booking_table.User_Address, booking_table.User_Current_Location, booking_table.User_Destination, " +
                       "booking_table.Booked_Date, booking_table.Booked_Time, booking_table.Driver_ID, booking_table.Driver_Name, " +
                       "booking_table.Driver_Telephone_Number, booking_table.Car_Booking_Price, booking_Table.User_Current_Location, booking_table.User_Destination " +
                       "FROM booking_table " +
                       "WHERE booking_table.Booking_ID = ?";

        // Prepare the statement
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, bookingId); // Set the Car_ID parameter

        // Execute the query
        ResultSet rs = ps.executeQuery();
%>

<div class="container">
    <div class="content-container">
        <div class="featured-contents"></div>
        <div class="food-list-container">
            <h1 class="food-list-title">ENTER HIRE CHARGE</h1>
            <div class="food-list-wrapper">
                <div class="food-list">
                    <% 
                        // Loop through the results
                        if (rs.next()) {
                            // Retrieve the image as a byte array
                            

                            // Convert the image data to Base64
                            
                    %>
                    <form name="foods" action="updateHCandTPA" class="fbox" method="post" onSubmit="return formValidation();">
                        <div class="form-group">
                            <h3 class="title">The Booking ID is</h3>
                            <input type="text" readonly class="input-box" name="Booking_ID" value="<%= rs.getInt("Booking_ID") %>">
                        </div>
                        <div class="form-group">
                            <h3 class="title">The Customer Name is</h3>
                            <input type="text" readonly class="input-box" name="User_Username" value="<%= rs.getString("User_Username") %>">
                        </div>
                        <div class="form-group">
                            <h3 class="title">The Customer's Telephone Number is</h3>
                            <input type="text" readonly class="input-box" name="Driver_Name" value="<%= rs.getString("User_Telephone_Number") %>">
                        </div>
                        <div class="form-group">
                            <h3 class="title">The Customer's Address is</h3>
                            <input type="text" readonly class="input-box" name="User_Address" value="<%= rs.getString("User_Address") %>">
                        </div>
                        <div class="form-group">
                            <h3 class="title">Your Driver ID is</h3>
                            <input type="text" readonly class="input-box" name="Driver_ID" value="<%= rs.getInt("Driver_ID") %>">
                        </div>
                        <div class="form-group">
                            <h3 class="title">Your Name is</h3>
                            <input type="text" readonly class="input-box" name="Driver_Name" value="<%= rs.getString("Driver_Name") %>">
                        </div>
                        <div class="form-group">
                            <h3 class="title">Your Telephone Number is</h3>
                            <input type="text" readonly class="input-box" name="Driver_Telephone_Number" value="<%= rs.getString("Driver_Telephone_Number") %>">
                        </div>
                        <div class="form-group">
                            <h3 class="title">The Cab Booking Price is</h3>
                            <input type="text" readonly class="input-box" style="color: #e81c63; font-weight: 900; font-size: 30px;" name="Car_Booking_Price" id="txtCarBookingPrice" value="<%= rs.getDouble("Car_Booking_Price") %>">
                        </div>
                        <div class="form-group">
                            <h3 class="title">Customer's Current Location is</h3>
                            <input type="text" readonly required="required" class="input-box-total-payable-amount" style="color: #1c6ae8" name="User_Current_Location" value="<%= rs.getString("User_Current_Location") %>">
                        </div>
                        <div class="form-group">
                            <h3 class="title">Customer's Destination is</h3>
                            <input type="text" readonly required="required" class="input-box-total-payable-amount" style="color: #1c6ae8" name="User_Destination" value="<%= rs.getString("User_Destination") %>">
                        </div>
                        <div class="form-group">
                            <h3 class="title">Enter Your Hire Charge</h3>
                            <input type="number" class="input-box-total-payable-amount" style="color: #e81c63; font-weight: 900; font-size: 25px;" name="Hire_Charge" id="txtHireCharge" onchange="calculateTotal()" min="1">
                        </div>
                        <div class="form-group">
                            <h3 class="title">Total Payable Amount of Customer</h3>
                            <input type="number" readonly class="input-box-total-payable-amount" style="color: #e81c63; font-weight: 900; font-size: 30px;" name="Total_Payable_Amount" id="txtTotalPayableAmount">
                        </div>
                        <div class="form-group">
                            <input type="submit" name="confirm_order" value="Confirm Hire Charge" class="order-button">
                        </div>
                    </form>
                    <% 
                        } else {
                            out.println("<p>No cab found with the provided Car_ID.</p>");
                        }
                        rs.close();
                        ps.close();
                        con.close();
                    %>
                </div>
            </div>
        </div>
    </div>
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
	<script>
    	function calculateTotal() {
        	// Get the product price and preferred quantity by using ClientID
        	const cabBookingPrice = parseFloat(document.getElementById('txtCarBookingPrice').value);
        	const hireCharge = parseFloat(document.getElementById('txtHireCharge').value);
        	// Calculate the total amount
        	const totalAmount = cabBookingPrice + hireCharge;
        	// Set the total amount in the total payable amount input field
        	document.getElementById('txtTotalPayableAmount').value = totalAmount;

        	if (isNaN(hireCharge) || hireCharge < 1) {
            	hireCharge = 1;
            	document.getElementById('txtHireCharge').value = hireCharge;
        	}
    	}
    	window.onload = function () {
        	// Initialize the total calculation on page load
        	const quantityInput = document.getElementById('txtHireCharge');
        	quantityInput.value = 1;
        	calculateTotal();
        	// Get the quantity input field and attach both 'input' and 'change' event listeners
        	quantityInput.addEventListener('input', calculateTotal);
        	quantityInput.addEventListener('change', calculateTotal);
    	};
	</script>
  </body>
</html>