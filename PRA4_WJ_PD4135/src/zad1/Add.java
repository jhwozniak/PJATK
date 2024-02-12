package zad1;

import java.math.BigDecimal;

public class Add implements ArithmeticOp {

	@Override
	public BigDecimal makeOp(BigDecimal number1, BigDecimal number2) {
		return number1.add(number2);
	}
	
}
