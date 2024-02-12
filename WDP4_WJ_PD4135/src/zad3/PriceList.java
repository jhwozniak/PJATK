package zad3;

import java.util.*;

//def cennika jako singleton (możliwe tylko jedno stworzenie obiektu cennik)
public class PriceList {
	
	//pole klasy - instance oraz tablica par nazwa-cena (klasa Para)
	private static PriceList instance = null;
	private static ArrayList<Para> list;
		
	//konstruktor - tworzymy raz tablicę Par o nieokreślonym rozmiarze, potem dodajemy nowo utworzone Pary przez add()
	private PriceList() {
		 list = new ArrayList<Para>();
	}
	
	//metoda put() zapełnia kolejne miejsce w tablicy parą nazwa-cena
	public void put(String n, double p) {
		
		//tworzy nowy obiekt typu Para z parametrami podanymi w wywołaniu put()
		Para para = new Para(n, p);
		
		//dodaje go za pomoc add() do tablicy par
		list.add(para);
		
	}
	
	//def getInstance() 
	public static PriceList getInstance() {
		if(instance == null) {
	         instance = new PriceList();
	      }
	      return instance;
	   }
	
	//zwraca referencję do listy par nazwa-cena
	public static ArrayList<Para> getList() { return list;}
	


}
	
	
