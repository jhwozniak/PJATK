package zad1;

import java.util.*;

	//base class of one travel offer (one line in file, one record in database)
	public class Offer {
		private Locale countryCode;
		private String countryName;
		private Date departureDate;
		private Date returnDate;
		private String destinationType;
		private Double price;
		private String currency;
	
	public Offer(
		Locale countryCode, 
		String countryName, 
		Date departureDate, 
		Date returnDate,
		String destinationType,
		Double price,
		String currency) {
		
		this.countryCode = countryCode;
		this.countryName = countryName;
		this.departureDate= departureDate;
		this.returnDate = returnDate;
		this.destinationType = destinationType;
		this.price = price;
		this.currency = currency;
	}
	
	
	public Locale getCountryCode() {
		return countryCode;
	}
	
	public String getCountryName() {
		return countryName;
	}
	
	public Date getDepartureDate() {
		return departureDate;
	}
	
	public Date getReturnDate() {
		return returnDate;
	}
	
	public String getDestinationType() {
		return destinationType;
	}
	
	public Double getPrice() {
		return price;
	}
	
	public String getCurrency() {
		return currency;
	}	
	
	Object[] toArray() {
        return new Object[]{countryCode, countryName, departureDate, returnDate, destinationType, price, currency};
    }
	
	@Override
	public String toString() {
		return null;		
	}
	
}
