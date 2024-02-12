package zad1;
import java.math.BigDecimal;

//podstawowe zachowanie każdej z klas Add,Sub, Mult, Div - każda z nich implementuje operację makeOp()
public interface ArithmeticOp {	
	
	BigDecimal makeOp(BigDecimal number1, BigDecimal number2);

}
