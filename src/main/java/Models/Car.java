package Models;

import java.util.Base64;

public class Car {
	private int Car_ID;
	private String Car_Name;
	private String Car_Brand;
	private String Car_Number_Plate;
	private String Car_Colour;
	private byte[] Car_Image;
	private Double Car_Booking_Price;
	private int Driver_ID;
	private String Car_Status;
	
	public Car () {}
	
	public Car(int car_ID, String car_Name, String car_Brand, String car_Number_Plate, String car_Colour,
			byte[] car_Image, Double car_Booking_Price, int driver_ID, String car_Status) {
		super();
		Car_ID = car_ID;
		Car_Name = car_Name;
		Car_Brand = car_Brand;
		Car_Number_Plate = car_Number_Plate;
		Car_Colour = car_Colour;
		Car_Image = car_Image;
		Car_Booking_Price = car_Booking_Price;
		Driver_ID = driver_ID;
		Car_Status = car_Status;
	}
	
	public Car(int car_ID, String car_Name) {
		super();
		Car_ID = car_ID;
		Car_Name = car_Name;
	}


	public int getCar_ID() {
		return Car_ID;
	}
	public void setCar_ID(int car_ID) {
		Car_ID = car_ID;
	}
	public String getCar_Name() {
		return Car_Name;
	}
	public void setCar_Name(String car_Name) {
		Car_Name = car_Name;
	}
	public String getCar_Brand() {
		return Car_Brand;
	}
	public void setCar_Brand(String car_Brand) {
		Car_Brand = car_Brand;
	}
	public String getCar_Number_Plate() {
		return Car_Number_Plate;
	}
	public void setCar_Number_Plate(String car_Number_Plate) {
		Car_Number_Plate = car_Number_Plate;
	}
	public String getCar_Colour() {
		return Car_Colour;
	}
	public void setCar_Colour(String car_Colour) {
		Car_Colour = car_Colour;
	}
	public byte[] getCar_Image() {
		return Car_Image;
	}
	public void setCar_Image(byte[] car_Image) {
		Car_Image = car_Image;
	}
	public Double getCar_Booking_Price() {
		return Car_Booking_Price;
	}
	public void setCar_Booking_Price(Double car_Booking_Price) {
		Car_Booking_Price = car_Booking_Price;
	}
	public int getDriver_ID() {
		return Driver_ID;
	}
	public void setDriver_ID(int driver_ID) {
		Driver_ID = driver_ID;
	}
	public String getCar_Status() {
		return Car_Status;
	}
	public void setCar_Status(String car_Status) {
		Car_Status = car_Status;
	}
	public String getCarImageBase64() {
        if (Car_Image != null) {
            return Base64.getEncoder().encodeToString(Car_Image);
        }
        return null;
    }
}