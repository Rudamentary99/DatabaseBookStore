package model;

import java.math.BigInteger;
import java.sql.Date;

public class User {
	int userID;
	String firstName;
	String lastName;
	String email;
	String email2;
	String phone;
	Date date_of_birth;
	Date created_at;
	Date deteDate;
	boolean isAdmin;
	String password;
	String attemptedLogin = "false";

	public String getAttemptedLogin() {
		return attemptedLogin;
	}

	public void setAttemptedLogin(String attemptedLogin) {
		this.attemptedLogin = attemptedLogin;
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getDate_of_birth() {
		return date_of_birth;
	}

	public void setDate_of_birth(Date date_of_birth) {
		this.date_of_birth = date_of_birth;
	}

	public Date getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}

	public Date getDeteDate() {
		return deteDate;
	}

	public void setDeteDate(Date deteDate) {
		this.deteDate = deteDate;
	}

	public boolean isAdmin() {
		return isAdmin;
	}

	public void setAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	public void setPassword(String pPassword) {
		this.password = pPassword;
	}

	public String getPassword() {
		return password;
	}

}
