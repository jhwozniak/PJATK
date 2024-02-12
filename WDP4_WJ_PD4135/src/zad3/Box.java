package zad3;
import java.util.*;
public class Box extends ShoppingCart {

			//pudełko to tablica kwiatów konkretnego klienta, klasa dziedziczona od koszyka
			//specyficzny atrybut to imie klienta, do którego należy pudełko
			private Customer cust;
			
			//w konstruktorze nie przywołujemy poprzez super() parametrów z nadklasy, bo ich nie ma
			//zamiast tego przy inicjacji uruchomi się konstr bezparametrowy z nadklasy
			public Box(Customer c) {
				cust = c;
			}
			
						
			//getter - zwraca referencję do klienta
			public Customer getCustomer() { return cust; }	
					
			public String toString() {
			
				double cena = 0;
				String msg = "";
				
				//dla każdej pozycji w pudełku
				for ( int i = 0; i < getList().size(); i++) {
										
					//szukaj w cenniku ceny kwiatu o danej nazwie
					for ( int j = 0; j < PriceList.getList().size(); j++) {
						
						if ( getList().get(i).getName() == PriceList.getList().get(j).getName()) cena = PriceList.getList().get(j).getPrice();
											
					}
					
					//uzupełnij tekst wiadomości o nazwę kwiata, kolor, ilość i cenę
					msg += "\n" + getList().get(i).getName() + ", kolor: " + getList().get(i).getColor() + " , ilosc " + getList().get(i).getVolume() + ", cena " + cena;
				}	
				
				return "Pudełko własciciel " + cust.getName() + msg; 
			}	
	
	
}
