package zad2;


public class BankCustomer {
	
	//Pola klasy - kompozycja z klas Person i Account (klient banku zawiera w sobie osobę i konto)
	private Person person;
	private Account account;
			
	//Konstruktor - tworzy nowy obiekt klienta-banku, który jest osoba i ma konto (inicjowane początkowo z saldem 0)
	public BankCustomer (Person person)
	{
		this.person = person;
		this.account = new Account(0);
	}

	//Wyświetla zawartość obiektów
	public String toString()
	{
		return "Klient: " + person.getName() + " stan konta " + account.getBalance();  
	}

	public Account getAccount() 
	{
		return account;
	}
			
}
