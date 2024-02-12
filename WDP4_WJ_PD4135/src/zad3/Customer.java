package zad3;
import java.util.*;
public class Customer {
	//pola klasy
		private static String name;
		private double cash;
		private ShoppingCart sc;
		
		public Customer(String n, double c) {
			name = n;
			cash = c;
			sc = new ShoppingCart();
		}
		
		
		//zwraca imie klienta
		public static String getName() { return name;}
				
		
		//umieszcza wybrane kwiaty w wózku sklepowym
		public void get(Flower flower) {
			sc.getList().add(flower);
		}
		
		//getter - zwraca referencję do wózka
		public ShoppingCart getShoppingCart() { return sc; }

		
		//płaci za kwiaty 
		public void pay() {
			
			//1. czyszczenie koszyka - czy wybrany kwiat jest w cenniku?
				
				//deklarujemy licznik
				int counter;
							
				//pierwsza pętla: dla każdego kwiata w koszyku
				for ( int i = 0; i < sc.getList().size(); i++ ) {
					
					//resetuj licznik
					counter = 0;
					
					// druga pętla: dla każdej pozycji w cenniku
					for ( int j = 0; j < PriceList.getList().size(); j++) {
						
						//jeśli nazwa kwiata w koszyku (indeks i) = nazwa kwiata w cenniku (indeks j), aktualizuj licznik i wyjdz pętli szukania nazwy w cenniku
						if ( sc.getList().get(i).getName() == PriceList.getList().get(j).getName()) { counter++ ; break;}	
					}
					
					//jeśli licznik zero, to znaczy że w cenniku nie było kwiata, usuwamy komplet z koszyka
					if ( counter == 0) sc.getList().remove(i);
				}
				
							
			//2. czy wart zakupów > cash? 
			
				//inicjujemy wartość koszyka
				double scValue = 0;
				
				//pierwsza pętla: dla każdego kompltegu kwiatów i w oczyszczonym koszyku
				for ( int i = 0; i < sc.getList().size(); i++ ) {
					
					// druga pętla: dla każdej pozycji w cenniku
					for ( int j = 0; j < PriceList.getList().size(); j++) {
						
						//znajdz nazwę TEGO kompletu kwiatów i w cenniku
						if ( sc.getList().get(i).getName() == PriceList.getList().get(j).getName()) {
							
							//jeśli zwiększenie wartości zakupów TEGO kompletu kwiatów nie przekroczy dostępnej gotówki
							if ( ( scValue + (sc.getList().get(i).getVolume() * PriceList.getList().get(j).getPrice() ) ) <= cash )
							
								//aktualizuj wartość koszyka o kwotę = wolumen kwiatów w koszyku x cena kwiata w cenniku i wyjdz pętli szukania nazwy w cenniku
								{ scValue += sc.getList().get(i).getVolume() * PriceList.getList().get(j).getPrice(); break; }
							
							//w przeciwnym przypadku, usuń TEN komplet kwiatów z koszyka 
							else sc.getList().remove(i); break;
						}
					}
				}
							
			//3. zmniejsz stan gotówki o wartość koszyka (powinny zostać jakieś $) 
			cash -= scValue;
		}
		
		
		//getter: zwraca stan gotówki 
		public double getCash() { return cash;}
		
		//pakuje kwiaty z koszyka do pudełka
		public void pack(Box b) {
			
			//każdy element z koszyka
			for ( int i = 0; i < sc.getList().size(); i++) {
				
				//przypisz do pudełka 
				b.getList().add(sc.getList().get(i));
			}
			
			// ... a potem usuń cały koszyk 
			sc.getList().removeAll(sc.getList());
				
		}

}
