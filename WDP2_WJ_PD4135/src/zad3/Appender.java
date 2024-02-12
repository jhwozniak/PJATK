/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad3;


public class Appender {
	
	//Pola klasy
	String src;
	
	//Pierwszy konstruktor, inicjuje scr napisem pustym
	public Appender()
	{
		src = ""; 				 
	}
	
	//Drugi konstruktor, inicjuje src napisem s
	public Appender(String s)  
	{
		src = s;
	}
	
	//Do źródłowego napisu src dołącza n-razy powielony napis reprezentowany przez app
	public Appender append(String app, int n) 
	{
		if ( n < 0 ) throw new IllegalArgumentException("Liczba powtórzeń nie może być ujemna.");
		
		//Dopisujemy n-razy
		while (n-- > 0)
		{
			src += app;
		}
		
		return this;
	}
	
	//Wyświetla zawartośc obiektu
	public String toString()
	{
		return src;
	}

}
