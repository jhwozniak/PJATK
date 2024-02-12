/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad1;


public class Main {
	  public static void main(String[] args) {

	    int a =  6,            // liczby biorace udzial w sumowaniu 
	        b =  9,            // i mnozeniu oznaczam przez: a, b, c  
	        c = 18;

	    //Suma
	    System.out.println( a + " + " + b + " + " + c + " = " + (a + b + c) );
	        
	    //Iloczyn
	    System.out.println( a + " * " + b + " * " + c + " = " + (a * b * c) );
	    
	    //Suma polowek
	    System.out.println( a + "/2 + " + b + "/2 + " + c + "/2 " + " = " + (a + b + c) / 2.0 );
	    
	    //Suma jednych trzecich
	    System.out.println( a + "/3 + " + b + "/3 + " + c + "/3 " + " = " + (a + b + c) / 3.0 );
	        
	 }
	}

