package com.dub.site.quicksort;



public class Pair {
	/** An ordered pair of integers */
	private int p;
	private int q;
	
	public Pair(int p, int q) {
		this.p = p;
		this.q = q;
	}
	
	
	public int getP() {
		return p;
	}
	public void setP(int p) {
		this.p = p;
	}
	public int getQ() {
		return q;
	}
	public void setQ(int q) {
		this.q = q;
	}

	public String toString() {
		return p + ", " + q;
	}
	
}

