/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad1;
import java.util.*;

public class Main {
  public static void main(String[] args) {
	
	  //1) podaje na konsoli długość łańcucha
	  System.out.println("1) " + args[0].length());
	  
	  //2) wyprowadza pierwszy i ostatni znak (rozdzielone spacją) 
	  System.out.println("2) " + args[0].charAt(0) + " " + args[0].charAt(args[0].length() - 1));
	    
	  //3) wyprowadza podłańcuch od 4 znaku do ostatniego znaku, 
	  System.out.println("3) " + args[0].substring(4));
	  
	  //4) wyprowadza podłańcuch od 4 znaku do przedostatniego znaku, 
	  System.out.println("4) " + args[0].substring(4, args[0].length() - 1));
	  
	  //5) wyprowadza informacje o tym ile razy w wejściowym łańcuchu występuje zadany (podany jako drugi argument wywołania programu)  podłańcuch  
	  
	  int p = 0;
	  int counter = 0;
	  
	  while( (p = args[0].indexOf(args[1], p)) != -1) // dopóki w łańcuchu args[0] istnieją podłańcuchy args[1]
	  {
		  int end = args[0].indexOf(args[1], p); //taki podłańcuch występuje na pozycji o indeksie end
		  counter++;							 //aktualizujemy licznik
		  p = end + args[1].length(); 			 //przesuwamy znacznik
	  }
	  System.out.println("5) " + counter);
	  
	  
	  //6) tworzy tablicę wszystkich słów  łańcucha (tu slowa niech oznaczają zestawy znaków rozdzielone spacjami, przecinkami, kropkami i średnikami) 
	  //i wyprowadza jej elementy w jednym wierszu, rozdzielone znakiem _ (podkreślenie) ,
	  
	  //ustalamy def słowa
	  StringTokenizer st = new StringTokenizer(args[0], " \t\n\r\f.,:;()[]\"'?!-{}");
	  
	  //ustalamy rozmiar tablicy
	  int n = st.countTokens(); 
	  
	  //tworzymy tablicę o rozmiarze n
	  String[] words = new String[n];  
	    
	  //zapełniamy tablicę i drukujemy słowa
	  System.out.print("6) ");
	  for (int i = 0; i < n; i++) {
		  words[i] = st.nextToken();
		  System.out.print(words[i]);
		  if ( i + 1 < n ) System.out.print("_"); //jeśli to nie jest ostatnie słowo, dodaj znak "_"
	  }
	  System.out.println();
	  
	  //7) stwierdza czy pierwsze i ostatnie słowo łańcucha jest takie samo. 
	  if ( words[0].compareTo(words[n-1]) == 0) System.out.println("7) " + "true");
	  else System.out.println("7) " + "false");
	    
	  }
  
  
  
  
  
 }

