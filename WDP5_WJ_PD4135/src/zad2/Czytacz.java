package zad2;

import java.io.*;
import java.util.*;

//wątek A: czyta dane z pliku, tworzy nowy obiekt Towar, podaje do pola towarów, raportuje 
public class Czytacz extends Thread {
	
	Towar poleTowaru;
	
	Czytacz(Towar t) {
		poleTowaru = t;
	}
	
	//co robi ten wątek
	public void run() {
		int wg = 0;
		int liczbaOdczytow = 0; 
		String line;
		String fname = "../Towary.txt";
		try {
			   			   
			   //wrzucamy dane z pliku do bufora
			   BufferedReader br = new BufferedReader(new FileReader(fname));
			   
			   //dopóki są wiersze w buforze
			   while ((line = br.readLine()) != null) { 
				  //sięgnij po drugi element wiersza (waga towaru)
				   StringTokenizer st = new StringTokenizer(line);
				   wg = Integer.parseInt(st.nextToken());
				   wg = Integer.parseInt(st.nextToken());
				   
				 //podaj wagę czytanego towaru na pole towaru
				 //od wywołania tej metody działa koordynacja wątków, wątek podał dane i czeka na pobranie
				 poleTowaru.setTowar(wg);
				      
				 //aktualizuj licznik 
				 liczbaOdczytow++;
				      
				 //testuje liczbe odczytów i raportuje co 200 odczytow	
				 if ( liczbaOdczytow % 200 == 0 && liczbaOdczytow > 0) { System.out.println("utworzono " + liczbaOdczytow + " obiektów");}
				 
			   }
			   br.close(); 
			 } catch (IOException e) {
			     e.printStackTrace();
			 } 
	poleTowaru.setTowar(-1);
	}
	
	
}
