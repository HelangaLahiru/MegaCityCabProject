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
    <title>Home</title>
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
    
    <!-- Welcome Section -->
    <section class="welcome-section">
      <div class="welcome-content">
        <h1>Welcome to Mega City Cab</h1>
        <p>Your journey to a safer ride begins here. Join us today and experience the quickest and the safest journey!</p>
      </div>
      <img class="welcome-image" src="Img/welcpg.png" alt="Gym Welcome Image">
    </section>

    <!-- Services Section -->
    <section class="services-section">
      <h2>Our Services</h2>
      <div class="services-container">
        <div class="service-item">
          <img src="Img/svc1.png" alt="Ride Booking">
          <h3>Ride Booking</h3>
          <p>Instant booking for immediate rides can be done here, you will be traveled quickly and safely to your destination</p>
        </div>
        <div class="service-item">
          <img src="Img/svc2.png" alt="Ride Tracking and Navigation">
          <h3>Ride Tracking and Navigation</h3>
          <p>Real-time GPS tracking to monitor the cab’s location. Estimated time of arrival (ETA) for the driver and ride completion. Navigation assistance for the driver to optimize the route.</p>
        </div>
        <div class="service-item">
          <img src="Img/svc3.png" alt="Flexible Payment Options">
          <h3>Flexible Payment Options</h3>
          <p>Multiple payment methods (cash, credit/debit cards, mobile wallets, UPI). Split fare options for shared rides. Digital receipts sent via email or in-app notifications.</p>
        </div>
      </div>
    </section>

    <!-- Testimonials Section -->
    <section class="testimonials-section">
      <h2>What Our Members Say</h2>
      <div class="testimonials-container">
        <div class="testimonial-item">
          <img src="Img/cbrv1.png" alt="Testimonial 1">
          <p>"The cab booking process was seamless! I booked a ride to the airport, and the driver arrived within minutes. The car was clean, the driver was polite, and the ride was very comfortable. I especially loved the live tracking feature—it gave me peace of mind knowing exactly when the cab would arrive. The payment process was quick and hassle-free with multiple options. Highly recommend!"</p>
          <h3>Mikaela Rogers</h3>
        </div>
        <div class="testimonial-item">
          <img src="Img/cbrv2.png" alt="Testimonial 2">
          <p>"Excellent service! I scheduled a cab in advance for a business meeting, and the driver arrived on time. The car was in great condition, and the driver followed all traffic rules. I appreciated the updates about my ride and the prompt customer support when I had a query. It's so convenient to have everything managed through the app. Definitely using this service again!"</p>
          <h3>Nayomi Hughes</h3>
        </div>
      </div>
    </section>

    <!-- Image Gallery Section -->
    <section class="gallery-section">
      <h2>Our Cabs in Action</h2>
      <div class="gallery-container">
        <img src="Img/car1.png" alt="Gym Image 1">
        <img src="Img/car2.png" alt="Gym Image 2">
        <img src="Img/car3.png" alt="Gym Image 3">
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