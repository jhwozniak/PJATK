/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad1;

import java.util.HashMap;
import java.util.Map;
import java.math.BigDecimal;

public class Calc {
	//mapa operacji: KLUCZ: substring +, -, * lub / podany w argumentach wiersza poleceń,
	// WARTOŚĆ: nowy obiekt Add, Sub, Mult lub Div implementujący interfejs ArithmeticOp 
	Map<String, ArithmeticOp> opsMap;
	
	//zapełniamy hashmapę
	public Calc() {
		opsMap = new HashMap<>(); 		
		opsMap.put("+", new Add());
		opsMap.put("-", new Sub());
		opsMap.put("*", new Mult());
		opsMap.put("/", new Div());
	}	
		
	String doCalc(String cmd) {
		try 
		{
			//rozbieramy na substringi argumenty wiersza poleceń
			String[] arrOfargs = cmd.split("\\s+");
			
			//szukamy w hashmapie odpowiadającej operacji
			ArithmeticOp op = opsMap.get(arrOfargs[1]);
			
			//wykonujemy na znalezionej operacji metodę interfejsową z parametrami podanymi w wierszu poleceń, wynik zmieniamy na string
			BigDecimal result = op.makeOp(new BigDecimal(arrOfargs[0]), new BigDecimal(arrOfargs[2]));
			result.setScale(7);
			
			return result.toString();			
		}
		catch (Exception e) {
			return "Invalid command to calc";
		}
		
		
	}
}  
