/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad4;


public class NumTeller {
	
		
	//Zwraca podaną liczbę z przyrostkiem
	public static String say(int n)
	{
		String tekst = "";
		
		
		//Jeśli zero lub wielokrotność miliona
		if ( n == 0 || n % 1000000 == 0)
		{
			tekst = n + " = " + n + "-owy";
			return tekst;
		}
		
		//Jeśli wielokrotność 100
		else if ( n % 100 == 0 )
		{
			tekst = n + " = " + n + "-ny";
			return tekst;
		}
				
		//Jeśli ostatnie 2 cyfry n w przedziale <11, 20> lub <-20, -11>
		else if( ( n % 100 >= 11 && n % 100 <= 20) || ( n % 100 >= -20 && n % 100 <= -11) )
		{
			tekst = n + " = " + n + "-ty";
			return tekst;
		}
		
		//Jeśli ostatnia liczbą jest 1 lub -1
		else if (  ( n % 10 == 1 ) || ( n % 10 == -1 ) )
		{
			tekst = n + " = " + n + "-szy";
			return tekst;
		}
		
		//Jeśli 2 lub -2
		else if ( ( n % 10 == 2) || ( n % 10 == -2 ))
		{
			tekst = n + " = " + n + "-gi";
			return tekst;
		}
		
		//Jeśli 3 lub -3
		else if ( ( n % 10 == 3 ) || ( n % 10 == -3 ))
		{
			tekst = n + " = " + n + "-ci";
			return tekst;
		}
		
		//Jeśli 4, 5, 6, 9, 0 lub ujemne
		else if ( n % 10 == 4 || n % 10 == 5 || n % 10 == 6 || n % 10 == 9 || n % 10 == 0 
				|| n % 10 == -4 || n % 10 == -5 || n % 10 == -6 || n % 10 == -9 )  
		{
			tekst = n + " = " + n + "-ty";
			return tekst;
		}
		
		//Jeśli 7, 8 lub ujemne
		else if ( n % 10 == 7 || n % 10 == 8 || n % 10 == -7 || n % 10 == -8 )
		{
			tekst = n + " = " + n + "-my";
			return tekst;
		}
				
		else return tekst;
	}
	
}
