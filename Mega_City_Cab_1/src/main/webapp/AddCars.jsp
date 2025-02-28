<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    HttpSession adminSession = request.getSession(false);
    if (adminSession == null || adminSession.getAttribute("adminLoggedIn") == null) {
        response.sendRedirect("Login.jsp"); // Redirect if session is missing
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Cab Adding Form</title>
<style>
  /* Reset styles */
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  body {
    font-family: 'Arial', sans-serif;
    background: linear-gradient(135deg, #89f7fe, #66a6ff);
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    min-height: 100vh;
    overflow-y: auto; /* Enable scrolling for the body */
    padding: 20px; /* Add padding for smaller screens */
    color: #444;
  }

  .form-container {
    width: 100%;
    max-width: 500px;
    background: #ffffff;
    padding: 30px;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
    position: relative;
    overflow: hidden;
  }

  .form-container::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255,255,255,0.15), transparent);
    z-index: 0;
    animation: rotate 10s linear infinite;
  }

  @keyframes rotate {
    0% { transform: rotate(0); }
    100% { transform: rotate(360deg); }
  }

  .form-header {
    text-align: center;
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #444;
    z-index: 1;
    position: relative;
  }

  .form-row {
    margin-bottom: 15px;
    z-index: 1;
    position: relative;
  }

  .form-label {
    font-size: 14px;
    font-weight: bold;
    color: #333;
    margin-bottom: 8px;
    display: block;
  }

  .form-input, .form-file, .textareadescription {
    width: 100%;
    padding: 12px;
    border: 2px solid #ddd;
    border-radius: 10px;
    font-size: 14px;
    outline: none;
    transition: all 0.3s ease;
    background: rgba(240, 240, 240, 0.7);
    color: #444;
  }

  .form-input:focus, .form-file:focus, .textareadescription:focus {
    border-color: #66a6ff;
    background: #fff;
  }

  .textareadescription {
    height: 120px;
    resize: none;
  }

  .button-group {
    display: flex;
    gap: 10px;
    justify-content: space-between;
    z-index: 1;
    position: relative;
  }

  .btn {
    flex: 1;
    padding: 12px;
    font-size: 14px;
    font-weight: bold;
    color: #fff;
    background: linear-gradient(135deg, #66a6ff, #89f7fe);
    border: none;
    border-radius: 10px;
    cursor: pointer;
    transition: all 0.3s ease;
    text-align: center;
  }

  .btn:hover {
    background: linear-gradient(135deg, #89f7fe, #66a6ff);
    transform: translateY(-3px);
  }

  .btn-reset {
    background: linear-gradient(135deg, #ff758c, #ff7eb3);
  }

  .btn-reset:hover {
    background: linear-gradient(135deg, #ff7eb3, #ff758c);
    transform: translateY(-3px);
  }

  @media (max-width: 500px) {
    .form-container {
      padding: 20px;
    }
  }
</style>
</head>
<body>
  <div class="form-container">
    <h1 class="form-header">Add Cab</h1>
    <form id="addCarForm" action="addCar" method="post" enctype="multipart/form-data" accept-charset="UTF-8" onsubmit="return validateDriverSelection()">
      <div class="form-row">
        <label class="form-label" for="carName">Cab Name</label>
        <input type="text" class="form-input" name="Car_Name" required />
      </div>
      <div class="form-row">
        <label class="form-label" for="carBrand">Cab Brand</label>
        <input type="text" class="form-input" name="Car_Brand" required />
      </div>
      <div class="form-row">
        <label class="form-label" for="carNumberPlate">Cab Number Plate</label>
        <input type="text" class="form-input" name="Car_Number_Plate" required />
      </div>
      <div class="form-row">
        <label class="form-label" for="carColour">Cab Colour</label>
        <input type="text" class="form-input" name="Car_Colour" required />
      </div>
      <div class="form-row">
        <label class="form-label" for="carImage">Cab Image</label>
        <input type="file" class="form-file" name="Car_Image" required />
      </div>
      <div class="form-row">
        <label class="form-label" for="carBookingPrice">Cab Booking Price</label>
        <input type="number" class="form-input" name="Car_Booking_Price" required />
      </div>
      <div class="form-row">
        <label class="form-label" for="carAssigningDriver">Cab Assigning Driver</label>
        <select class="form-input" name="Car_Assigning_Driver" id="Car_Assigning_Driver" onchange="updateDriverID()">
          <option value="" data-id="">Select a Driver</option>
          <!-- Driver options will be dynamically populated here -->
        </select>
      </div>
      <div class="form-row" style="display:none;">
        <label class="form-label" for="driverID">Driver ID</label>
        <input type="number" class="form-input" name="Driver_ID" id="Driver_ID" required readonly />
      </div>
      <div class="button-group">
        <button type="submit" name="submit" class="btn">Add Cab</button>
        <button type="reset" class="btn btn-reset">Reset</button>
      </div>
    </form>
  </div>

  <script>
    // Function to fetch and populate the driver dropdown
    function fetchUnassignedDrivers() {
      fetch('TakeDriversCarUnassigned')  // API endpoint to fetch unassigned drivers
        .then(response => response.json())
        .then(drivers => {
          const driverSelect = document.getElementById("Car_Assigning_Driver");
          // Clear existing options
          driverSelect.innerHTML = '<option value="" data-id="">Select a Driver</option>';
          
          drivers.forEach(driver => {
            const option = document.createElement("option");
            option.value = driver.Driver_Name;  // Set the driver's name as the value
            option.textContent = driver.Driver_Name;  // Display the driver's name
            option.setAttribute("data-id", driver.Driver_ID);  // Store the driver ID in data-id attribute
            driverSelect.appendChild(option);
          });
        })
        .catch(error => {
          console.error("Error fetching drivers:", error);
        });
    }

    // Function to update the Driver_ID when a driver is selected
    function updateDriverID() {
      const driverSelect = document.getElementById("Car_Assigning_Driver");
      const selectedOption = driverSelect.options[driverSelect.selectedIndex];
      const driverID = selectedOption.getAttribute("data-id");  // Get the driver ID from the data-id attribute
      const driverIDInput = document.getElementById("Driver_ID");
      driverIDInput.value = driverID;  // Set the Driver ID input value
    }

    // Validation function to ensure a driver is selected
    function validateDriverSelection() {
      const driverSelect = document.getElementById("Car_Assigning_Driver");
      const selectedValue = driverSelect.value;
      
      // Check if the default option is still selected
      if (selectedValue === "") {
        alert("Please select a driver before submitting the form!");
        return false;  // Prevent form submission
      }

      return true;  // Allow form submission
    }

    // Fetch and populate drivers when the page is loaded
    document.addEventListener("DOMContentLoaded", fetchUnassignedDrivers);
  </script>
</body>
</html>