/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad2;
import java.io.*;
import java.util.*;

//wyłuskuje i wypisuje daty z pliku w formacie YYYY-MM-DD
public class Main {

  public static void main(String[] args) throws FileNotFoundException {
	  
	//separator końca wiersza 
	  String fname = System.getProperty("user.home") + "/test/daty.txt";  
	  
	  //czytamy dane z pliku
	  Scanner scan = new Scanner(new File(fname));
	  
	  //ustalamy wyrażenie regularne
	  String regex = "(([1-2][0-9][0-9][0-9]\\-((1[02]|0[13578])\\-(0[1-9]|[12][0-9]|3[01])))|"
	  		+ "([1-2][0-9][0-9][0-9]\\-((1[1]|0[469])\\-(0[1-9]|[12][0-9]|3[0])))|"
	  		+ "([1-2][0-9]([0248][048]|[13579][26])\\-(0[2])\\-(0[1-9]|[12][0-9])))";
	  	  
	  	  
	  //szuka w pliku wyrażenia regularnego
	  while(scan.findWithinHorizon(regex, 0) != null) {
	      
		  String title = scan.match().group(1);
	      
	      //jeśli znajdzie, podaje wynik
	      System.out.print(title + " ");
	    }
	    scan.close();  // zamykamy skaner i plik
     
  }
}
