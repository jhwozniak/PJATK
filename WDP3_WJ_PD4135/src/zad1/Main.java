/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad1;

import java.io.*;
import java.util.*;

//Wczytuje liczby z pliku, sumuje aż do osiągnięcia lub przekroczenia limitu
public class Main {

  public static void main(String[] args) {
    
	  String fname = System.getProperty("user.home") + "/iter.txt";            
    
	  //Pobiera liczby z pliku
	  try 
	  {
		  Scanner scan = new Scanner(new File(fname));
		  		  		  
		  int start = scan.nextInt();
		  int end = scan.nextInt();
		  int limit = scan.nextInt();
		  
		  int sum = 0;
		  
		  //Iteruje od start do end
		  for ( int i = start; i <= end; i++ )
		  {
			  if ( sum + i > limit ) break;  //Jeśli suma przekroczy limit, stop
			  sum += i;						 //Jeśli nie przekroczy limitu, dodaj do sumy bieżącą liczbę 
		  }
			  
		  //Podaje wynik
		  System.out.println(sum);
		  System.exit(0);
	  } 
	  catch (Exception exc) 
	  {
		  System.out.println("***"); //Brak pliku, wadliwe dane etc.
	      System.exit(1);
	  }
  }
}
