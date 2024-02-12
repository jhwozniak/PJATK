/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad2;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

public class CustomersPurchaseSortFind {
	private Map<String,ArrayList<Purchase>> purchases;
	
	public CustomersPurchaseSortFind() {
	
		purchases = new HashMap<String, ArrayList<Purchase>>();
		
	}
	
	public void readFile(String path) {
		Scanner scan;
		try {
			scan = new Scanner(new File(path));
			String custId;
			String line;
			
			while(scan.hasNextLine()) {
				line = scan.nextLine();
				String[] temp = line.split(";"); 
						
				if (temp.length == 5) {
					Purchase singlePurchase = new Purchase(temp[0], temp[1], temp[2], Double.parseDouble(temp[3]), Double.parseDouble(temp[4]));
					custId = temp[0];
									
					//jeśli pod tym id w hashmap nie ma jeszcze listy zakupów
					if (purchases.get(custId) == null) {
						//stwórz nową listę zakupów
						ArrayList<Purchase> list = new ArrayList<Purchase>();
						//dodaj do niej pierwszy zakup
						list.add(singlePurchase);
						//umieść listę pod kluczem id w hashmap
						purchases.put(custId, list);
					}
					//jeśli pod tym id w hashmap jest już coś
					else {
						//pobierz istniejącą listę zakupów
						ArrayList<Purchase> list2 = purchases.get(custId);
						//dodaj zakup do listy zakupów
						list2.add(singlePurchase);
						//zaktualizuj listę pod kluczem id w hashmap
						purchases.put(custId, list2);
					}
				}
			}	
						
			} catch (FileNotFoundException e) {
			e.printStackTrace();
		}		
	}
	
	
	public void showSortedBy(String category) {
		List<Purchase> list = new ArrayList<Purchase>();
		
		for (String key : purchases.keySet()) {
			list.addAll(purchases.get(key));
		}
				
		if (category.equals("Nazwiska")) {
			System.out.println("Nazwiska");
			Collections.sort(list, new Comparator<Purchase>() {
                public int compare(Purchase obj1, Purchase obj2) {
                    int output = obj1.getCustName().compareTo(obj2.getCustName());
                    if (output == 0) {
                        return obj1.getCustId().compareTo(obj2.getCustId());
                    }
                    return output;
                }
            });
            for (Purchase element : list) {
                System.out.println(element);
			}
		}
		
		if (category.equals("Koszty")) {
			System.out.println("Koszty");
			Collections.sort(list, new Comparator<Purchase>() {
                public int compare(Purchase obj1, Purchase obj2) {
                    int output = Double.compare(obj1.getProdPrice()*obj1.getProdAmt(), obj2.getProdPrice()*obj2.getProdAmt());
                    if (output == 0) {
                        return obj1.getCustId().compareTo(obj2.getCustId());
                    }
                    return output;
                }
            });
						
			for (Purchase element : list) {
                System.out.println(element + " (koszt: " + element.getProdAmt()*element.getProdPrice() + ")");
                
            }
		}
		System.out.println();
	}
	
	
	public void showPurchaseFor(String custId) {
		System.out.println("Klient " + custId);
		ArrayList<Purchase> list3 = purchases.get(custId);
		for (Purchase element : list3) {
			System.out.println(element);
		}
		System.out.println();
		
	}
}
	

