package zad1;

import java.math.BigDecimal;

public class Mult implements ArithmeticOp {

	@Override
	public BigDecimal makeOp(BigDecimal number1, BigDecimal number2) {
		return number1.multiply(number2);
	}

}
