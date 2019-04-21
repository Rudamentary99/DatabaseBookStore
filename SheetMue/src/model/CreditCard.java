package model;

public class CreditCard {
	private String ccn;
	private String ccv;
	private String exp;
	
	public final String getCcn() {
		return ccn;
	}
	public final void setCcn(String ccn) {
		this.ccn = ccn;
	}
	public final String getCcv() {
		return ccv;
	}
	public final void setCcv(String ccv) {
		this.ccv = ccv;
	}
	public final String getExp() {
		return exp;
	}
	public final void setExp(String exp) {
		this.exp = exp;
	}
}
