/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad2;
import java.io.*;
import java.util.*;

//Wczytuje liczby z pliku do tablicy, wyświetla zawartość, podaje największą liczbę i indeksy, pod którymi występuje
public class Main {

  public static void main(String[] args) {
    String fname = System.getProperty("user.home") + "/tab.txt";            
    
    try {
    //Otwiera plik
    Scanner scan = new Scanner(new File(fname)); 
    
    //Tworzy obiekt klasy ArrayList
    ArrayList list = new ArrayList();
    
    //Dopóki w pliku są liczby całkowite
    while (scan.hasNextInt()) 
    {
      // dodawaj kolejny element do listy
      list.add(scan.nextInt());
    }
    
    //Inicjujemy zmienną przechowującą największą liczbę z listy pierwszym elementem listy 
    int maxNumber = (int) list.get(0); 
    
    //Iterujemy po tablicy szukając największej liczby
    for ( int i = 0; i < list.size(); i++ )
    {
    	if ( maxNumber < (int) list.get(i) )
    	{
    		maxNumber = (int) list.get(i); // Jeśli znajdziemy większą, aktualizujemy wartość maxNumber  
    	}
    }
    
    // Wyświetla zawartość listy
    for ( int i = 0; i < list.size(); i++ )
      System.out.print(list.get(i) + " ");
      System.out.println();
    
    // Wyświetla największą liczbę z listy
      System.out.print(maxNumber);
      System.out.println();
      
    // Wyświetla indeksy największej liczby 
    for ( int i = 0; i < list.size(); i++ )
    	{
    		if ( (int) list.get(i) == maxNumber ) 
    		System.out.print(i + " ");
    	}
    System.exit(0); 
    } 
    catch (Exception exc) {
    	System.out.println("***"); //Brak pliku, wadliwe dane etc.
	    System.exit(1);
    }
  
  }
}
    
    
  
    
    
    
 
