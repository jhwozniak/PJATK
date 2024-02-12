package zad3;

import java.util.*;
import javax.swing.*;

public class ShoppingCart {
	
	//wózek to tablica kwiatów
	private ArrayList<Flower> list;
	
	public ShoppingCart() {
		list = new ArrayList<Flower>();
	}
	
	//getter - zwraca referencję do tablicy
	public ArrayList<Flower> getList() {
		return list;
	}
		
	public String toString() {
		
		double cena = 0;
		String msg = "";
		
		//dla każdej pozycji w koszyku
		for ( int i = 0; i < list.size(); i++) {
			
			//szukaj w cenniku ceny kwiatu o danej nazwie
			for ( int j = 0; j < PriceList.getList().size(); j++) {
				
				if ( list.get(i).getName() == PriceList.getList().get(j).getName()) { 
					
					//jak znajdziesz nazwę, pobierze cenę i już nie szukaj
					cena = PriceList.getList().get(j).getPrice(); break;
				}  
				
				//jeśli nie ma ceny, cena = -1
				else cena = -1;
			}
			
			//uzupełnij tekst wiadomości o nazwę kwiata, kolor, ilość i cenę
			msg += "\n" + list.get(i).getName() + ", kolor: " + list.get(i).getColor() + ", ilosc " + list.get(i).getVolume() + ", cena " + cena;
		}	
		
		//jeśli nic nie ma w koszyku, wypisz "pusto"
		if ( msg == "") { msg =" -- pusto";}
				
		return "Wózek własciciel " + Customer.getName() + msg; 
		
	}
	
	
	
}

