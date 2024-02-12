/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad2;


public class Przedzial {

	  private int pocz, koniec;

	  public Przedzial(int a, int b)
	  {
		  //Poczatek przedzialu zawsze nie wiekszy niz koniec
		  if ( a <= b ) {
			  pocz = a;
			  koniec = b;
		  }
		  else {
			  pocz = b;
			  koniec = a;
		  }
		    
	  }

	  Przedzial przeciecie(Przedzial p)
	  {

		  //Tworzymy nowy obiekt w klasie Przedzial
		  Przedzial wynik = new Przedzial(pocz, koniec);
		  
		  //Testujemy 4 przypadki części wspólnych przdziałów
		  if ( wynik.pocz < p.pocz && p.pocz < wynik.koniec && wynik.koniec < p.koniec ) 
		  {
			  wynik.pocz = p.pocz;
			  return wynik;
		  }
		  
		  else if ( p.pocz < wynik.pocz && wynik.pocz < p.koniec && p.koniec < wynik.koniec )
		  {
			  wynik.koniec = p.koniec;
			  return wynik;
		  }
		  
		  else if ( p.pocz < wynik.pocz && wynik.pocz < p.koniec && wynik.koniec < p.koniec ) 
		  {
			  return wynik;
		  }
		  
		  else if ( wynik.pocz < p.pocz && p.pocz < wynik.koniec && p.koniec < wynik.koniec )
		  {
			  wynik.pocz = p.pocz;
			  wynik.koniec = p.koniec;
			  return wynik;
		  }
		  else if ( wynik.koniec == p.pocz )
		  {
			  wynik.pocz = p.pocz;
			  return wynik;
		  }
		  else if ( wynik.pocz == p.koniec )
		  {
			  wynik.koniec = p.koniec;
			  return wynik;
		  }
		  		  
		  //Jeśli nie ma części wspólnych zwracamy null
		  else 
		  {
			  return null;
		  }
		  
	  }

	  //Metoda okreslajaca poczatek przedzialu
	  public int poczatek() 
	  {
		  return pocz;
	  }
	  
	  
	  //Metoda okreslajaca koniec przedzialu
	  public int koniec()
	  {
		  return koniec;
	  }
	  
	  //Metoda toString()
	  public String toString()
	  {
		  return "[" + pocz + "," + koniec + "]";
	  }
	    
	}
