package Models;

public class Driver {
	private int Driver_ID;
	private String Driver_Name;
	private String Driver_Email;
	private String Driver_Telephone_Number;
	private String Driver_Password;
	private String Car_Assignability_Status;
	
	public int getDriver_ID() {
		return Driver_ID;
	}
	public void setDriver_ID(int driver_ID) {
		Driver_ID = driver_ID;
	}
	public String getDriver_Name() {
		return Driver_Name;
	}
	public void setDriver_Name(String driver_Name) {
		Driver_Name = driver_Name;
	}
	public String getDriver_Email() {
		return Driver_Email;
	}
	public void setDriver_Email(String driver_Email) {
		Driver_Email = driver_Email;
	}
	
	public String getDriver_Telephone_Number() {
		return Driver_Telephone_Number;
	}
	public void setDriver_Telephone_Number(String driver_Telephone_Number) {
		Driver_Telephone_Number = driver_Telephone_Number;
	}
	public String getDriver_Password() {
		return Driver_Password;
	}
	public void setDriver_Password(String driver_Password) {
		Driver_Password = driver_Password;
	}
	public String getCar_Assignability_Status() {
		return Car_Assignability_Status;
	}
	public void setCar_Assignability_Status(String car_Assignability_Status) {
		Car_Assignability_Status = car_Assignability_Status;
	}
}