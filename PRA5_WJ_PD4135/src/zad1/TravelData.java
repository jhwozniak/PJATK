package zad1;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException; 
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

//contains offers from file
public class TravelData {
	
	File dataDir;
	
	//base data containers
	private List<Offer> listOfOffers;	
	public List<TranslatedOffer> listOfTranslatedOffers;
	
	public TravelData(File dataDir) {
		this.dataDir = dataDir;
		listOfOffers = new ArrayList<>();
		listOfTranslatedOffers = new ArrayList<>();
		String lineInFile;	
		
		try 
		{
			//getting list of files in directory			
			File[] files = dataDir.listFiles();				
			
			//for each file in directory
			for (File file : files) { 
				if (file.isFile()) {
					
					//reading from file					
					BufferedReader br = new BufferedReader(new FileReader(file.getPath()));
					
					//for each line in a file
					while ((lineInFile = br.readLine()) != null) {
						String[] line = lineInFile.split("\t");					
						Locale loc = new Locale(line[0]);
						Locale.setDefault(loc); //ustalamy locale wg oferty
						SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
						NumberFormat nf = NumberFormat.getInstance(); //ustalamy numberformat wg locale
						
						try {
							//making new offer
							Offer theOffer = new Offer(
									loc,
									line[1],
									df.parse(line[2]),
									df.parse(line[3]),
									line[4],
									nf.parse(line[5]).doubleValue(),
									line[6]);
							
							//adding new offer to the list
							listOfOffers.add(theOffer);
							
						} catch (ParseException e) {e.printStackTrace(); }											 							
					} 						
				} else System.out.println("Not a file!");								
			} 				
		} catch (Exception e) { e.printStackTrace(); } 		 
	}		
	
	public List<String> getOffersDescriptionsList(String locale, String dateFormat) {
		
		List<String> descriptions = new ArrayList<>();		
		
		Locale loc = Locale.forLanguageTag(locale.replace("_", "-"));
		Locale.setDefault(loc);				
		SimpleDateFormat df = new SimpleDateFormat(dateFormat);
		NumberFormat nf = NumberFormat.getInstance(); //ustalamy numberformat wg locale
							
		//formatuj liczby i daty do zadanego parametru locale
		//przy okazji tłumacz contryName i destinationType
		for (Offer off : listOfOffers) {			
			
			String country = translateCountryName(off.getCountryCode(), loc, off.getCountryName());			
			String word = translateDestinationType(off.getCountryCode(), loc, off.getDestinationType());
			
			String str = "";
			String str1 = country + " ";
			String str2 = df.format(off.getDepartureDate()) + " ";
			String str3 = df.format(off.getReturnDate()) + " ";
			String str4 = word + " ";
			String str5 = nf.format(off.getPrice()) + " ";
			String str6 = off.getCurrency();
			str = str1 + str2 + str3 + str4 + str5 + str6;			
			descriptions.add(str);
			
			listOfTranslatedOffers.add(new TranslatedOffer(str1, str2, str3, str4, str5, str6));
			
		}		
		
		return descriptions;
	}
	
	//translates country name, searches actual country name in actual locale, when matched displays translated name 
	//depending on wished (out) locale language 
	public String translateCountryName(Locale in, Locale out, String countrName) {
		Locale[] locales = Locale.getAvailableLocales();
		for (Locale loc : locales) {
            if (loc.getDisplayCountry(in).equals(countrName)) {
                return loc.getDisplayCountry(out);
            }
        }
        return countrName;
    }	
	
	//searches languages in maps depending on locales
	public String translateDestinationType(Locale in, Locale out, String destinationType) {
		Map polishToEnglish = new HashMap();
		polishToEnglish.put("morze", "sea");
		polishToEnglish.put("jezioro", "lake");
		polishToEnglish.put("góry", "mountains");
		
		Map englishToPolish = new HashMap();
		englishToPolish.put("sea", "morze");
		englishToPolish.put("lake", "jezioro");
		englishToPolish.put("mountains", "góry");
		
		if ((in.getLanguage() == "pl") && (out.getLanguage() == "pl"))  
			return destinationType;
		if ((in.getLanguage() == "pl_pl") && (out.getLanguage() == "pl"))  
			return destinationType;
		if ((in.getLanguage() == "en_gb") && (out.getLanguage() == "pl"))  
			return (String) englishToPolish.get(destinationType);
		if ((in.getLanguage() == "pl") && (out.getLanguage() == "en"))  
			return (String) polishToEnglish.get(destinationType);
		if ((in.getLanguage() == "pl_pl") && (out.getLanguage() == "en"))  
			return (String) polishToEnglish.get(destinationType);		
		else 		
			return destinationType;
	}
	
	public List<Offer> getListOfOffers() {
		return listOfOffers;
	}
	
	public List<TranslatedOffer> getListOfTranslatedOffers() {
		return listOfTranslatedOffers;
	}
}
