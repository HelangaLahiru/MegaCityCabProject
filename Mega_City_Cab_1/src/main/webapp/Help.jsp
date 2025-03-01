<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <title>Help For Customers</title>
    <style>
    /* Styling the Services Section */
.services-section {
    background-color: #f8f9fa; /* Light gray background */
    padding: 50px 20px;
    text-align: center;
}

/* Styling the Main Heading */
.services-section h2 {
    font-size: 40px;
    font-weight: bold;
    color: #FF69B4;
    margin-bottom: 30px;
    text-transform: uppercase;
}

/* Styling the Container */
.services-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 40px;
    max-width: 1200px;
    margin: 0 auto;
}

/* Styling Each Service Item */
.service-items {
    background-color: #ffffff;
    border-radius: 10px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    padding: 30px;
    max-width: 550px;
    text-align: center;
    transition: transform 0.3s ease-in-out;
}

.service-items:hover {
    transform: translateY(-5px);
}

/* Styling the Images */
.service-items img {
    width: 100%s;
    height: auto;
    margin-bottom: 15px;
}

/* Styling the Headings */
.service-items h3 {
    font-size: 30px;
    font-weight: bold;
    color: #007bff; /* Blue color */
    margin-bottom: 15px;
}

/* Styling the Paragraphs */
.service-items p {
    font-size: 20px;
    color: #555;
    line-height: 1.6;
    margin-bottom: 15px;
}

/* Styling for Sub-points in Mission Statement */
.service-items p:nth-child(n+3) {
    font-size: 18px;
    font-weight: 500;
    text-align: left;
    margin-left: 20px;
}

/* Responsive Design */
@media (max-width: 768px) {
    .services-container {
        flex-direction: column;
        align-items: center;
    }

    .service-items {
        width: 80%;
    }
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
              <li class="menu-list-item"> <menu> <input type="text" name="search"  class="menu-list-item-search-bar" placeholder="Search"> </menu> </li>
              <li class="menu-list-item"> <button type="submit" class="search-menu-icon-button"> <i class="search-menu-icon fas fa-search"></i> </button> </li>
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
        Integer Driver_ID = (Integer) session.getAttribute("Driver_ID");
        String Driver_Name = (String) session.getAttribute("Driver_Name");
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

    <!-- Services Section -->
    <section class="services-section">
      <h2>HELP FOR CUSTOMERS</h2>
      <div class="services-container">
        <div class="service-items">
          <img src="Img/register.png" alt="Ride Booking">
          <h3>Register First</h3>
          <p>Register yourself Properly by giving the essential user credentials of you. You can only use letters when entering your full name. And also, use a valid email address and a telephone number and make sure you type the exact password you typed in the password field also in the confirm password field and also make sure to make the password's length to be more than 4 characters. If the system says to use a different Email or an NIC Number, do so as it says.</p>
        </div>
        <div class="service-items">
          <img src="Img/login.png" alt="Ride Tracking and Navigation">
          <h3>Login After that</h3>
          <p>Use your registered email and password as exactly to log in to the Website. If it is wrong, then your login will be failed and you are not able to book a cab through our Website.</p>
        </div>
        <div class="service-items">
          <img src="Img/aftersuclogin.png" alt="Flexible Payment Options">
          <h3>After a Successful Login</h3>
          <p>The second navigation bar appears after a successful login and when visiting the Cabs Menu, the ""Book Cab" button also will be visible. Click on that button to book the cab and you will be directed to a page.</p>
        </div>
        <div class="service-items">
          <img src="Img/bookcab.png" alt="Flexible Payment Options">
          <h3>Booking the Cab</h3>
          <p>Your Customer Details and the Details of the Cab along with the Cab's Driver's Details is displayed in this page. Enter your Current Location and the Destination you want to go and Click the "Book This Cab" Button to confirm your Booking. Your Hire Charge and the Total Payable Amount will be notified soon and check them in your "My Cab Bookings" tab.</p>
        </div>
        <div class="service-items">
          <img src="Img/hcandtpa.png" alt="Flexible Payment Options">
          <h3>Checking the Total Payable Amount and the Hire Charge and the Status of the Journey</h3>
          <p>If the "Hire Charge" and the "Total Payable Amount" is denoted as "Will be Notified Soon", then it means that the driver has not updated the hire charge for you. So wait till he updates that and if it is updated, the Amount will be shown as like in previous bookings in here. If you are still on Journey, your Journey's Status will be denoted as "You are on Journey" and when your Journey is finished, it will be denoted as "Your Journey is Finished". Do not worry, accepting your hire by our driver is compulsory and you will be safely carried until your destination. So good luck with your journey and use this help to help yourself on booking a cab of our "Mega City Cab Services".</p>
        </div>
      </div>
    </section>
    
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