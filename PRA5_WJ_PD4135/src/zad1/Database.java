package zad1;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Database {
		
    private TravelData travelData;
    private List<TranslatedOffer> offers;  
    
    private String url;
    public static final String DRIVER = "org.sqlite.JDBC";	
    private Connection conn;
    private Statement stat;
        
    Database(String url, TravelData travelData) {
        this.travelData = travelData;
        this.url = url;
    }            
    
    public void create () {
    	//spr sterownik
        try {
            Class.forName(Database.DRIVER);            
        } catch (ClassNotFoundException e) {
            System.err.println("Brak sterownika JDBC");
            e.printStackTrace();}
        
        //połączenie z bd
        try {
            conn = DriverManager.getConnection(url);
            stat = conn.createStatement();            
                         
            stat.execute("CREATE TABLE IF NOT EXISTS translated_offers (countryName TEXT NOT NULL, departureDate TEXT NOT NULL, returnDate TEXT NOT NULL, destinationType TEXT NOT NULL, price TEXT NOT NULL, currency TEXT NOT NULL);");
            
            //zapełniamy tabelkę przetłumaczonymi ofertami 
            PreparedStatement prep = conn.prepareStatement("INSERT INTO translated_offers (countryName, departureDate, returnDate, destinationType, price, currency) values (?, ?, ?, ?, ?, ?)");
                        
            for (TranslatedOffer translatedOffer : travelData.getListOfTranslatedOffers()) {
            	prep.setString(1, translatedOffer.getCountryName());
            	prep.setString(2, translatedOffer.getDepartureDate());
            	prep.setString(3, translatedOffer.getReturnDate());
            	prep.setString(4, translatedOffer.getDestinationType());
            	prep.setString(5, translatedOffer.getPrice());
            	prep.setString(6, translatedOffer.getCurrency());
            	prep.execute();
            }            
            
            
        } catch (SQLException e) {
            System.err.println("Problem z otwarciem polaczenia");
            e.printStackTrace();
        } finally {       
            try {          
                conn.close();
              } catch(SQLException exc) {
                System.out.println(exc);
                System.exit(1);
              }
           }
    }
    
    public List<TranslatedOffer> selectOffers() {
    	offers = new ArrayList();
    	try {
    		conn = DriverManager.getConnection(url);
    		stat = conn.createStatement();  
    		ResultSet rs = stat.executeQuery("SELECT * FROM translated_offers");
    		while (rs.next()) {
    			TranslatedOffer offer = new TranslatedOffer(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getString(6));
    			offers.add(offer); 
            }
    		
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {       
            try {          
                conn.close();
              } catch(SQLException exc) {
                System.out.println(exc);
                System.exit(1);
              }
           }        
    	return offers;
    }
    
	//uruchamia GUI z załadowaną listą ofert
    void showGui() {
        new GUI(this.selectOffers());    	
    }    
}
