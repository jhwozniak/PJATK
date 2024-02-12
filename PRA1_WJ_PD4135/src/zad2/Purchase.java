/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad2;


public class Purchase {
	private String custId;
	private String custName;
	private String prodName;
	private double prodPrice;
	private double prodAmt;
	
	public Purchase (String id, String name, String product, double price, double amount) {
		custId = id;
		custName = name;
		prodName = product;
		prodPrice = price;
		prodAmt = amount;		
	}
	
	public void setCustId(String id) {
		this.custId = id;
	}
	
	public void setCustName(String name) {
		this.custName = name;
	}
	
	public void setProdName(String product) {
		this.prodName = product;
	}
	
	public void setProdPrice(double price) {
		this.prodPrice = price;
	}
	
	public void setProdAmt(double amount) {
		this.prodAmt = amount;
	}
	
	public String getCustId() {
		return this.custId;
	}
	
	public String getCustName() {
		return this.custName;
	}
	
	public String getProdName() {
		return this.prodName;		
	}
	
	public double getProdPrice() {
		return this.prodPrice;
	}
	
	public double getProdAmt() {
		return this.prodAmt;
	}
	
	public String toString() {
		return custId + ";" + custName + ";" + prodName + ";" + prodPrice + ";" + prodAmt;
	}
}
