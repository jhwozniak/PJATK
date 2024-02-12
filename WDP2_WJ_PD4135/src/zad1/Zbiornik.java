/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad1;


public class Zbiornik {
	
	//Pola klasy 
	private static int counter = 0;			//Licznik numerów
	
	private int numerZbiornika;  			//Bieżący numer zbiornika 
	private double pojemnosc;               //Pojemność zbiornika w m3
	private double stanWody;                //Aktualny stan wody w zbiorniku
	
	
	//Konstruktor - tworzy nowy zbiornik o podanej pojemności
	public Zbiornik(double poj)
	{
		counter++;
		numerZbiornika = counter;			//Nadaje nowy (kolejny) numer
		pojemnosc = poj;					//Ustala zadaną pojemność nowego zbiornika
		stanWody = 0;						//Ustala początkowy stan wody na 0 
	}
	
	//Metoda na dolewanie wody do zbiornika
	public void dolej(double woda)
	{
		if (woda < 0) System.out.println("Wartość nie może być ujemna. Nie mogę wykonać polecenia.");
		else if ( stanWody + woda > pojemnosc ) System.out.println("Chcesz dolać za dużo. Nie mogę wykonać polecenia.");			
		else stanWody += woda;
	}
	
	//Metoda na odlewanie wody ze zbiornika
	public void odlej(double woda)
	{
		if (woda < 0) System.out.println("Wartość nie może być ujemna. Nie mogę wykonać polecenia.");
		else if ( stanWody - woda < 0 ) System.out.println("Chcesz odlać za dużo. Nie mogę wykonać polecenia.");			
		else stanWody -= woda;
	}
	
	//Metoda na wyświetlenie zawartości obiektu
	public String toString()
	  {
		  return "Zbiornik " + numerZbiornika + " , pojemność " + pojemnosc + ", stan wody " + stanWody;
	  }
	
	
}  
