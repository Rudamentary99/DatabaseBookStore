package model;

public class loginUser extends User{
 private boolean atteptedLogin = false;

public boolean isAtteptedLogin() {
	return atteptedLogin;
}

public void setAtteptedLogin(boolean atteptedLogin) {
	this.atteptedLogin = atteptedLogin;
}
}
