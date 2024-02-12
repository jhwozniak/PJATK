/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad4;


public class Main {
	  public static void main(String[] args) {
		  //Ustala pierwszą litere zbioru
		  char c = 'a';
		  
		  //Pobiera kod tej litery
		  int kod = c;
		  
		  //Ustala ostatnią litere zbioru
		  char d = 'z';
		  
		  //Pobiera kod tej litery
		  int kon = d;
		  
		  //Iterujemy po wszystkich kodach liter zbioru
		  while ( kod <= kon )
		  {
			  //Drukujemy w każdej linii stosowny komunikat
			  System.out.println("Kod znaku " + c + " = " + kod); 
			  
			  //Przechodzimy do kodu następnej litery ...
			  kod++;
			  
			  //.. z odpowiadającym jej kodem
			  c = (char) kod;		  
		  }

	  }
	}
