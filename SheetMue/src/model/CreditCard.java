package model;

public class CreditCard {
	private int ccn;
	private int ccv;
	private int exp;
	
	public final int getCcv() {
		return ccv;
	}

	public final void setCcv(int ccv) {
		this.ccv = ccv;
	}

	public final int getCcn() {
		return ccn;
	}

	public final void setCcn(int ccn) {
		this.ccn = ccn;
	}

	public final int getExp() {
		return exp;
	}

	public final void setExp(int exp) {
		this.exp = exp;
	}
}
