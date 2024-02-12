package zad1;

import java.util.*;

public class Letters extends Thread {
		
		//tworzymy nową listę wątków
		ArrayList<Thread> threads = new ArrayList<Thread>();
		
		private String argument;
		
		//konstruktor klasy Letters
		Letters(String s) {
		
			argument = s;
		
			//dla każdej litery podanej jako argument konstruktora
			for ( int i = 0; i < argument.length(); i++ ) {
						
			char c = argument.charAt(i);
			
			//tworzymy nowy wątek o nazwie "Thread + kolejna litera podana jako argument konstruktora"...
			//...definujemy mu w anonimowej klasie wewnętrznej metodę run() i zapełniamy listę

			threads.add(new Thread("Thread " + c) {
				public void run() {
					while(true) {
						try {
							this.sleep(1000); //usypiamy wątek na 1 sek
							System.out.print(c); //drukujemy literę z argumentu
						} catch(InterruptedException exc) {
							break;
						}
					}
				}
			});		
			}
		}
		
		//zwraca wątek z listy wątków
		public ArrayList<Thread> getThreads() {
			return threads;
				}
}
