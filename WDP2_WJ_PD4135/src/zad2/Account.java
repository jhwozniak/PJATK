package zad2;

public class Account {
	
	//Pola klasy
	private static double interestRate;		//Stopa oprocentowania depozytów taka sama dla wszystkich kont
	private double balance;					//Saldo na koncie
	
	//Konstruktor - tworzy nowe konto
	public Account (double balance)
	{
		this.balance = balance;						
	}

	//Metody klasy
	public double getBalance()
	{
		return balance;
	}
		
	//Wpłaty
	public void deposit(double d)  
	{
	    if ( d < 0) System.out.println("Wpłata nie może być ujemna.");
	    else balance += d;
	}

	//Wypłaty
	public boolean withdraw(double d)
	{
		if ( d < 0) 
		{
			System.out.println("Wypłata nie może być ujemna."); 
			return false;
		}
		else if ( balance - d < 0)
		{
			System.out.println("Brak środków na koncie do zrealizowania wypłaty."); 
			return false;
		}
		else 
		{
			balance -= d; 
			return true;
		}
	}
	
	//Przelew 
	public void transfer(Account account, double d) 
	{
		if ( withdraw(d) == false ) System.out.println("Przelew nieudany."); 
		else account.deposit(d);
	}
		
	//Dopisuje odsetki do stanu konta
	public void addInterest()
	{
		balance *= (1 + interestRate / 100);
	}
	
	//Ustala oprocentowanie dla wszystkich kont
	public static void setInterestRate(double d)
	{
		Account.interestRate = d;
	}
		
}
