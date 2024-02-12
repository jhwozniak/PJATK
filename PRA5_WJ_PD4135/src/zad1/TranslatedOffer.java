package zad1;

import java.util.Date;

public class TranslatedOffer {
	
	private String countryName;
	private String departureDate;
	private String returnDate;
	private String destinationType;
	private String price;
	private String currency;
	
	public TranslatedOffer(
			String countryName,
			String departureDate,
			String returnDate,
			String destinationType,
			String price,
			String currency) {
		
		this.countryName = countryName;
		this.departureDate = departureDate;
		this.returnDate = returnDate;
		this.destinationType = destinationType;
		this.price = price;
		this.currency = currency;		
	}
	
	public String getCountryName() {
		return countryName;
	}
	
	public String getDepartureDate() {
		return departureDate;
	}
	
	public String getReturnDate() {
		return returnDate;
	}
	
	public String getDestinationType() {
		return destinationType;
	}
	
	public String getPrice() {
		return price;
	}
	
	public String getCurrency() {
		return currency;
	}
	
	
	

}
