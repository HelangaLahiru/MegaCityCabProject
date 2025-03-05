<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    <link rel="stylesheet" href="styles.css" />
    <title>Driver Register</title>
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
            <form action="" method="GET" class="menu-list-item-search-bar-main">
              <li class="menu-list-item"> <menu> <input type="text" name="search"  class="menu-list-item-search-bar" placeholder="Search"> </menu> </li>
              <li class="menu-list-item"> <button type="submit" class="search-menu-icon-button"> <i class="search-menu-icon fas fa-search"></i> </button> </li>
            </form>
          </ul>
        </div>
      </div>
    </div>
    
    <div class="sidebar">
     <div class="menu-item">
        <a href="Register.jsp">CUSTOMER REGISTER</a>
      </div>
      <div class="menu-item">
        <a href="Login.jsp">CUSTOMER LOGIN</a>
      </div>
      <div class="menu-item">
        <a href="DriverRegister.jsp">DRIVER REGISTER</a>
      </div>
      <div class="menu-item">
        <a href="DriverLogin.jsp">DRIVER LOGIN</a>
      </div>
    </div>
    
    <div class="form-wrapper sign up">
      <form class="registration1" id="registration" method="post" action="addDriver" onsubmit="return formValidation()">
        <h1 style="font-size: 30px;">DRIVER REGISTRATION</h1>
        <div class="input-box">
          <input class="text-input-field" type="text" id="CustomerFullName" name="Driver_Name" required>
          <label class="main-labels" for="">Enter Your Full Name Here</label>
          <i class='i-icons bx bxs-user'></i>
        </div>
        <div class="input-box">
          <input class="text-input-field" type="Email" id="CustomerEmail" name="Driver_Email" required>
          <label class="main-labels" for="Email">Enter Your Email Here</label>
          <i class='i-icons bx bxs-envelope'></i>
        </div>
        <div class="input-box">
          <input class="text-input-field" type="number" id="CustomerEmail" name="Driver_Telephone_Number" required>
          <label class="main-labels" for="Email">Enter Your Telephone Number Here</label>
          <i class='i-icons fas fa-phone-alt'></i>
        </div>
        <div class="input-box">
          <div class="icons-container">
            <i class="password-hide-icon fas fa-eye-slash" style="left:357px" onclick="togglePasswordVisibility('customerpassword', this)"></i>
            <i class='i-icons fas fa-lock'></i>
          </div>
          <input class="password-field" type="password" name="Driver_Password" id="customerpassword" required>
          <label class="main-labels">Enter Your Password Here</label>
        </div>
        <div class="input-box">
          <div class="icons-container">
            <i class="password-hide-icon fas fa-eye-slash" style="left:357px" onclick="togglePasswordVisibility('confirmCustomerPassword', this)"></i>
            <i class='i-icons fas fa-lock'></i>
          </div>
          <input class="password-field" type="password" name="Driver_Confirm_Password" id="confirmCustomerPassword" required>
          <label class="main-labels">Confirm Your Password Here</label>
        </div>
        
        <button class="register-button" style="font-size:24px" type="submit" name="submit">Register</button>
        <div class="signIn-link">
          <p>Already have an account?<a href="DriverLogin.jsp"class="signInBtn"> Sign In</a>
        </p>
        </div>
      </form>
    </div>

    <script>
      function togglePasswordVisibility(fieldId, toggleIcon) {
        var input = document.getElementById(fieldId);
        var isPasswordVisible = input.type === 'password';
        input.type = isPasswordVisible ? 'text' : 'password';
        toggleIcon.className = isPasswordVisible ? 'password-hide-icon fas fa-eye' : 'password-hide-icon fas fa-eye-slash';
      }
    </script>

    <script type="text/javascript">
      function formValidation() {
        var CustomerFullName = document.getElementById('CustomerFullName').value;
        var CustomerEmail = document.getElementById('CustomerEmail').value;
        var CustomerPassword = document.getElementById('customerpassword').value; 
        var ConfirmCustomerPassword = document.getElementById('confirmCustomerPassword').value;

        if (allLetter(CustomerFullName)) {
            if (ValidateEmail(CustomerEmail)) {
          	if (PasswordLengthLong(CustomerPassword)) {
                if (PasswordandConfirmPasswordMatching(CustomerPassword, ConfirmCustomerPassword)) {
                  return true;
                }
              }
            }
          }
          return false;
        }

      function allLetter(CustomerFullName) {
        var letters = /^[A-Za-z ]+$/; 
        if (CustomerFullName.match(letters)) {
          return true;
        } else {
          alert('Dear Driver, Full Name must have alphabet characters and spaces only!');
          return false;
        }
      }

      function ValidateEmail(CustomerEmail) {
        var mailformat = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (CustomerEmail.match(mailformat)) {
          return true;
        } else {
          alert("Dear Driver, please enter a valid Email address!");
          return false;
        }
      }

      function PasswordandConfirmPasswordMatching(CustomerPassword, ConfirmCustomerPassword) {
        if (CustomerPassword !== ConfirmCustomerPassword) {
          alert("Dear Driver, Password and Confirm Password must be equal!");
          return false;
        }
        return true;
      }
      
      function PasswordLengthLong(CustomerPassword) {
        if (CustomerPassword.length<5) {
            alert("Dear Customer, Password must have more than 4 characters!");
            return false;
        }
        return true;
      }
    </script>

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
    <style>
      /* Wrapper for the form */
      .form-wrapper {
        max-width: 450px;
        margin: 0 auto;
        padding: 20px;
        background-color: #f9f9f9;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        overflow: hidden;
        box-sizing: border-box;
        margin-top: 30px;
        margin-bottom: 30px;
      }

      /* Form styles */
      .registration1 {
        display: flex;
        flex-direction: column;
        gap: 15px;
      }

      /* Form heading */
      .registration1 h1 {
        text-align: center;
        color: #007BFF;
        text-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
        font-weight: 600;
        margin-bottom: 20px;
      }

      /* Input box styles */
      .input-box {
        position: relative;
        width: 100%; /* Ensures the input box fits within the form */
        margin-bottom: 15px;
        box-sizing: border-box;
      }

      .text-input-field,
      .password-field,
      .input-selector {
        width: 100%; /* Ensures the input fields fit within the parent container */
        padding: 12px 14px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 14px;
        outline: none;
        transition: border-color 0.3s;
        box-sizing: border-box; /* Includes padding and borders in width calculation */
      }

      .text-input-field:focus,
      .password-field:focus,
      .input-selector:focus {
        border-color: #FF69B4;
      }

      .label-container {
        position: relative;
      }

      .main-labels,
      .membership-plan-label,
      .price-label {
        position: absolute;
        top: -10px;
        left: 12px;
        font-size: 12px;
        background: #f9f9f9;
        padding: 0 4px;
        color: #FF69B4;
        pointer-events: none;
      }

      .i-icons {
        position: absolute;
        top: 50%;
        right: 12px;
        transform: translateY(-50%);
        font-size: 18px;
        color: #aaa;
      }

      .password-hide-icon {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        font-size: 18px;
        cursor: pointer;
        color: #666;
      }

      /* Register button */
      .register-button {
        width: 100%;
        padding: 12px;
        background: linear-gradient(90deg, #007BFF, #FF69B4);
        border: none;
        border-radius: 5px;
        font-size: 18px;
        color: #fff;
        cursor: pointer;
        transition: background-color 0.3s;
      }

      .register-button:hover {
        background: linear-gradient(90deg, #FF69B4, #007BFF);
      }

      /* Sign-in link */
      .signIn-link {
        text-align: center;
        margin-top: 10px;
      }

      .signIn-link a {
        color: #007BFF;
        text-decoration: none;
        font-weight: 500;
      }

      .signIn-link a:hover {
        text-decoration: underline;
      }

      /* Responsive adjustments */
      @media (max-width: 480px) {
        .form-wrapper {
          padding: 15px;
        }
      
        .text-input-field,
        .password-field,
        .input-selector {
          font-size: 13px;
          padding: 10px;
        }
      
        .register-button {
          font-size: 16px;
        }
      }
    </style>
  </body>
</html>