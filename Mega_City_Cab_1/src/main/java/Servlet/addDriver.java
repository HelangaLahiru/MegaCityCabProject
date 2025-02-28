package Servlet;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.Driver;
import Services.DriverService;

@WebServlet("/addDriver")
public class addDriver extends javax.servlet.http.HttpServlet {
	private static final long serialVersionUID = 1L;

	public addDriver() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Create a Customer object
		Driver driver = new Driver();
		driver.setDriver_Name(request.getParameter("Driver_Name"));
		driver.setDriver_Email(request.getParameter("Driver_Email"));
		driver.setDriver_Telephone_Number(request.getParameter("Driver_Telephone_Number"));
		
		// Hash the password before saving
		String plainPassword = request.getParameter("Driver_Password");
		String hashedPassword = hashPassword(plainPassword);
		driver.setDriver_Password(hashedPassword);

		DriverService driverService = new DriverService();
        boolean isEmailDuplicate = driverService.isEmailDuplicate(driver.getDriver_Email());

        response.setContentType("text/html");
        if (isEmailDuplicate) {
            response.setContentType("text/html");
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('Dear Driver, please use a Different Email!');");
            response.getWriter().println("history.back();"); // Go back to the previous page without redirecting
            response.getWriter().println("</script>");
        } else {
		
        	boolean isRegistered = driverService.registerDriver(driver); // Assume this method returns true/false

        	if (isRegistered) {
        		response.getWriter().println("<script type=\"text/javascript\">");
        		response.getWriter().println("alert('Dear Driver, Your Registration is Successful');");
        		response.getWriter().println("window.location.href = 'DriverLogin.jsp';"); // Redirect to Login.jsp
        		response.getWriter().println("</script>");
        	} else {
        		response.getWriter().println("<script type=\"text/javascript\">");
        		response.getWriter().println("alert('Dear Driver, Your Registration Failed');");
        		response.getWriter().println("window.location.href = 'DriverRegister.jsp';"); // Redirect back to the registration page
        		response.getWriter().println("</script>");
        	}
        }
	}

	// Utility method to hash a password using SHA-256
	private String hashPassword(String password) {
		try {
			MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
			byte[] hashedBytes = messageDigest.digest(password.getBytes());
			StringBuilder sb = new StringBuilder();
			for (byte b : hashedBytes) {
				sb.append(String.format("%02x", b)); // Convert byte to hex
			}
			return sb.toString();
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException("Error hashing password", e);
		}
	}
}