package zad1;

import java.math.BigDecimal;

public class Div implements ArithmeticOp {

	@Override
	public BigDecimal makeOp(BigDecimal number1, BigDecimal number2) {		
		return number1.divide(number2, 7, 1);
	}

}
