package zad2;

//klasa towarów tworzonych z danych czytanych z pliku ../Towary.txt
public class Towar {

	int idTowaru;
	int wagaTowaru;
	boolean nowyTowar = false;
	
	//wołana w klasie Czytacz, podaje towar na pole towaru
	synchronized void setTowar(int w) {
		//dopóki jest nowy towar, czekaj
		while (nowyTowar == true) {
			try {
				wait();				
			} catch(InterruptedException exc) {}
		} 
		//podaje waę nowego towaru w polu towary
		wagaTowaru = w;
		
		//ustwa flagę że jest
		nowyTowar = true;
		
		//poinformuj wszystkie czekające wątki, że obiekt jest odblokowany
		notifyAll();
	}
	
	//wołana w klasie Sumator, sięga po towar
	synchronized int getTowar() {
		//dopóki nie ma nowego towaru, czekaj
		while(nowyTowar == false) {
			try {
				wait();
			} catch(InterruptedException exc) {}
		}
		//ustaw flagę że nie ma
		nowyTowar = false;
		
		//poinformuj wszystkie czekające wątki, że obiekt jest odblokowany
		notifyAll();
		
		//pobierz wagę		
		return wagaTowaru;
	}
	
	
}
