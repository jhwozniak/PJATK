/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad3;


public class BooksOnShelves {
	
	//Pola klasy
	private int numOfBooks;
	private int shelfCap;
	
	//Konstruktor
	public BooksOnShelves(int n, int k) {
		numOfBooks = n;
		shelfCap = k;
	}
	
	//Metody klasy
	
	//Oblicza liczbę półek
	public int getNumOfShelves()
	{
		int numOfShelves = numOfBooks / shelfCap;
		
		//Sprawdza, czy jest jakas reszta z dzielenie tzn. czy potrzebna bedzie jeszcze jedna półka
		if ( numOfBooks % shelfCap != 0)
		{
			numOfShelves ++;
		}
		return numOfShelves;
	}
	
		
	//Oblicza liczbę książek na ostatniej półce
	public int getBooksOnLastShelf()
	{
		if ( numOfBooks % shelfCap != 0 ) return numOfBooks % shelfCap;
		else return numOfBooks / shelfCap;
	}

}	

