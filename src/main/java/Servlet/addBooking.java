package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.Booking;
import Services.BookingService;

@WebServlet("/addBooking")
@MultipartConfig // Enables handling file uploads
public class addBooking extends javax.servlet.http.HttpServlet {
    private static final long serialVersionUID = 1L;

    public addBooking() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Create a Booking object
        Booking booking = new Booking();
        booking.setCar_ID(Integer.parseInt(request.getParameter("Car_ID")));
        booking.setCar_Name(request.getParameter("Car_Name"));
        booking.setCar_Brand(request.getParameter("Car_Brand"));
        booking.setCar_Number_Plate(request.getParameter("Car_Number_Plate"));
        booking.setCar_Colour(request.getParameter("Car_Colour"));
        booking.setDriver_ID(Integer.parseInt(request.getParameter("Driver_ID")));
        booking.setDriver_Name(request.getParameter("Driver_Name"));
        booking.setDriver_Telephone_Number(request.getParameter("Driver_Telephone_Number"));
        booking.setCar_Booking_Price(Double.parseDouble(request.getParameter("Car_Booking_Price")));
        booking.setUser_ID(Integer.parseInt(request.getParameter("User_ID")));
        booking.setUser_Username(request.getParameter("User_Username"));
        booking.setUser_Telephone_Number(request.getParameter("User_Telephone_Number"));
        booking.setUser_Address(request.getParameter("User_Address"));
        booking.setUser_Current_Location(request.getParameter("User_Current_Location"));
        booking.setUser_Destination(request.getParameter("User_Destination"));
        booking.setHire_Charge(request.getParameter("Hire_Charge"));
        booking.setTotal_Payable_Amount(request.getParameter("Total_Payable_Amount"));

        // Pass the Booking object to the service layer
        BookingService bookingService = new BookingService();
        boolean isRegistered = bookingService.registerBooking(booking);

        // Generate JavaScript response
        response.setContentType("text/html");
        if (isRegistered) {
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('Dear Customer, Your Booking is Successful and Check out the Hire Amount and the Total Amount Payable in your Bookings!');");
            response.getWriter().println("window.location.href = 'Home.jsp';");
            response.getWriter().println("</script>");
        } else {
            response.getWriter().println("<script type=\"text/javascript\">");
            response.getWriter().println("alert('Booking Failed');");
            response.getWriter().println("window.location.href = 'Home.jsp';");
            response.getWriter().println("</script>");
        }
    }
}