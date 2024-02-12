/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad2;

//koordynuje pracę 2 wątków: wątek Czytacz czyta z pliku wagę towaru i podaje do wątku Sumator, który sumuje wagi 
public class Main {

  public static void main(String[] args) {
	  
	  Towar t = new Towar();
	  
	  //tworzymy wątki... 
	  Thread t1 = new Czytacz(t);
	  Thread t2 = new Sumator(t);
	  
	  //...startujemy je
	  t1.start();
	  t2.start();
	  	  
  }
}
