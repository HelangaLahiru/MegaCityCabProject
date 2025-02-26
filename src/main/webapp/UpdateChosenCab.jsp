<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.sql.*" %>
<%@ page import="java.sql.*, java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Chosen Cab Updating Form</title>
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

<%
    String carId = request.getParameter("Car_ID");
    String carName = "", carBrand = "", carNumberPlate = "", carColour = "", carBookingPrice = "";
    String base64Image = ""; 

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/megacitycab1?characterEncoding=utf8&serverTimezone=UTC", "root", "");
        
        String query = "SELECT Car_ID, Car_Name, Car_Brand, Car_Number_Plate, Car_Colour, Car_Image, Car_Booking_Price FROM car_table WHERE Car_ID = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, carId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            carName = rs.getString("Car_Name");
            carBrand = rs.getString("Car_Brand");
            carNumberPlate = rs.getString("Car_Number_Plate");
            carColour = rs.getString("Car_Colour");
            carBookingPrice = rs.getString("Car_Booking_Price");

            byte[] imageBytes = rs.getBytes("Car_Image");
            if (imageBytes != null && imageBytes.length > 0) {
                base64Image = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(imageBytes);
            }
        }

        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<div class="form-container">
    <h1 class="form-header">Update Cab</h1>
    <form id="updateCarForm" action="updateCar" method="post" enctype="multipart/form-data" onsubmit="return validateUpdate()">
        <div class="form-row">
            <label class="form-label">Cab ID</label>
            <input type="text" class="form-input" name="Car_ID" value="<%= carId %>" readonly/>
        </div>
        <div class="form-row">
            <label class="form-label">Cab Name</label>
            <input type="text" class="form-input" name="Car_Name" id="Car_Name" value="<%= carName %>" required />
        </div>
        <div class="form-row">
            <label class="form-label">Cab Brand</label>
            <input type="text" class="form-input" name="Car_Brand" id="Car_Brand" value="<%= carBrand %>" required />
        </div>
        <div class="form-row">
            <label class="form-label">Cab Number Plate</label>
            <input type="text" class="form-input" name="Car_Number_Plate" id="Car_Number_Plate" value="<%= carNumberPlate %>" required />
        </div>
        <div class="form-row">
            <label class="form-label">Cab Colour</label>
            <input type="text" class="form-input" name="Car_Colour" id="Car_Colour" value="<%= carColour %>" required />
        </div>
        <div class="form-row">
            <label class="form-label">Cab Image</label>
            <input type="file" class="form-file" name="Car_Image" id="Car_Image"/>
            <div>
                <img id="currentImage" src="<%= base64Image %>" width="150px" height="auto" alt="Cab Image"/>
            </div>
        </div>
        <div class="form-row">
            <label class="form-label">Cab Booking Price</label>
            <input type="number" class="form-input" name="Car_Booking_Price" id="Car_Booking_Price" value="<%= carBookingPrice %>" required />
        </div>
        <div class="button-group">
            <button type="submit" name="submit" class="btn">Update Cab</button>
            <button type="reset" class="btn btn-reset">Reset</button>
        </div>
    </form>
</div>

<script>
    function validateUpdate() {
        var initialValues = {
            name: "<%= carName %>",
            brand: "<%= carBrand %>",
            numberPlate: "<%= carNumberPlate %>",
            colour: "<%= carColour %>",
            price: "<%= carBookingPrice %>",
            imageChanged: false
        };

        var currentValues = {
            name: document.getElementById("Car_Name").value,
            brand: document.getElementById("Car_Brand").value,
            numberPlate: document.getElementById("Car_Number_Plate").value,
            colour: document.getElementById("Car_Colour").value,
            price: document.getElementById("Car_Booking_Price").value,
            imageChanged: document.getElementById("Car_Image").files.length > 0
        };

        // Check if any value has changed
        if (
            initialValues.name === currentValues.name &&
            initialValues.brand === currentValues.brand &&
            initialValues.numberPlate === currentValues.numberPlate &&
            initialValues.colour === currentValues.colour &&
            initialValues.price === currentValues.price &&
            initialValues.imageChanged === currentValues.imageChanged
        ) {
            alert("Please Update at least One Field!");
            return false;
        }
        return true;
    }
</script>

</body>
</html>