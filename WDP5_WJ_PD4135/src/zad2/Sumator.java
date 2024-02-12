package zad2;

//wątek B: sięga po towary, sumuje wagi, raportuje
public class Sumator extends Thread {

	Towar poleTowaru;
	
	Sumator(Towar t) {
		poleTowaru = t;
	}
	
	//co robi ten wątek
	public void run() {
		int sumaWag = 0;
		int liczbaPobran = 0; 
				
		//pobiera wagę bieżącego towaru z pola towaru
		int w = 0; //poleTowaru.getTowar();
						
		//dopóki trwają odczyty
		while ( w != -1) {
			//pobieraj wagę towaru
			//po tym wywołaniu uruchamiana jest koordynacja wątków, wątek pobrał dane i czeka na nowe
			w = poleTowaru.getTowar();
			
			//aktualizuj liczniki
			sumaWag += w;
			liczbaPobran++;
						
			//testuje liczbe pobrań i raportuje	
			 if (liczbaPobran % 100 == 0) { System.out.println("policzono wage " + liczbaPobran + " towarów");}
			 if (liczbaPobran == 10000) System.out.println(sumaWag); 
		}
	}
	
}
