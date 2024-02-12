/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad3;

import java.io.*;
import java.util.*;

//Podaje ile pakietów danych określonej pojemności zmieści się na dysku, wyświetla indeks 
//i wielkość pakietu i całkowitą zajmowaną przestrzeń dyskową
public class Main {

  public static void main(String[] args) {
    String fname = System.getProperty("user.home") + "/pakiety.txt";            
    
    try { 
    
    //Otwiera plik
    Scanner scan = new Scanner(new File(fname));
    
    //Pobiera z pliku rozmiar pierwszego pakietu w bajtach
    int firstPackageSize = scan.nextInt();
    
    //Pobiera z pliku rozmiar dostępnej przestrzeni dyskowej w bajtach
    int discSize = scan.nextInt() * 1000000;
    
    //Tworzy obiekt klasy ArrayList
    ArrayList list = new ArrayList();
    
    //Licznik aktualnie zajmowanej przestrzeni dyskowej
    int actualSize = 0; 
    
    //Indeks do listy, zaczynamy od 1 
    int pakiety = 1;
    
    //Licznik aktualnego rozmiaru pakietu, zaczynamy od zera
    int actualPackageSize = 0;
    
    //Dopóki wystarczy miejsca na dysku
    while (actualSize < discSize) 
    {
    	//Dla pierwszego pakietu
    	if ( pakiety == 1)
    	{
    		//Rozmiar pierwszego pakietu jest znany (pierwsza liczba w pliku)
    		actualPackageSize = firstPackageSize;
    		
    		if ( actualSize + actualPackageSize >= discSize) break;
    		   		    		
    		//Zaktualizuj zajmowaną przestrzeń dyskową
    		actualSize += actualPackageSize;
    		
    		//Dodaj element do listy
    		list.add(actualPackageSize);
    		
    		//Zwiększ indeks o 1
        	pakiety++;
    	}
    	
    	//Dla pakietów od drugiego do do 5-ego włącznie 
    	else if ( pakiety > 1 && pakiety <= 5 )
    	{
    		//Zwiększ podwójnie rozmiar aktualnego pakietu 
    		actualPackageSize = 2 * actualPackageSize;
    		
    		if ( actualSize + actualPackageSize >= discSize) break;
    		    		
    		//Zaktualizuj zajmowaną przestrzeń dyskową
    		actualSize += actualPackageSize;
    		
    		//Dodaj element do listy 
    		list.add(actualPackageSize);
    		
    		//Zwiększ indeks o 1
        	pakiety++;
    		
    	}
    	
    	//Dla pakietów powyżej 5-ego
    	else if ( pakiety > 5)
    	{
    		//Zwiększ potrójnie rozmiar aktualnego pakietu 
    		actualPackageSize = 3 * actualPackageSize;
    		
    		if ( actualSize + actualPackageSize >= discSize) break;
    		    		
    		//Zaktualizuj zajmowaną przestrzeń dyskową
    		actualSize += actualPackageSize;
    		
    		//Dodaj element do listy 
    		list.add(actualPackageSize);
    		
    		//Zwiększ indeks o 1
        	pakiety++;
    	}
    }
        
    //Wyświetla ile pakietów zmieści się na dysku
    System.out.println(pakiety-1);
    
    //Podaje numery pakietów z rozmiarami
    for (int i = 0; i < list.size(); i++)
        System.out.print( (i+1) + " " + list.get(i) + "\n" );
    
    //Podaje zajmowaną przestrzeń dyskową
    System.out.println(actualSize);
    System.exit(0);
    }
    catch (Exception exc) {
    	System.out.println("***"); //Brak pliku, wadliwe dane etc.
	    System.exit(1);
    }
    
     
  }
}
