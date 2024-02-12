/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad3;



import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;

public class Anagrams {
	
	private List<String> wordsList = new ArrayList<>();
    private HashMap<String, List<String>> anagramsMap = new HashMap<>();
	
    private static String hash(String in)
    {
        char[] out = in.toCharArray();
        Arrays.sort(out);
        return new String(out);
    }
    
    public Anagrams(String fname) throws FileNotFoundException {
    	Scanner scan = new Scanner(new File(fname));
    	String line;
		
		while(scan.hasNextLine()) {
			line = scan.nextLine();
			wordsList.addAll(Arrays.asList(line.split("\\s+"))); 
		}
    	    	
    	for (String word : wordsList) {
            String key = hash(word);

            if (anagramsMap.containsKey(key)) {
                anagramsMap.get(key).add(word);
            } else {
                List<String> list = new ArrayList<>();
                list.add(word);
                anagramsMap.put(key, list);
            }
        }    	    	
    }
    
    
    public List<List<String>> getSortedByAnQty() {
    	List<List<String>> output = new ArrayList<List<String>>();
    	for (String key : anagramsMap.keySet()) {
    		output.add(anagramsMap.get(key));
    	}
    	return output;
    }

	public String getAnagramsFor(String word) {
		List<String> tempList = new ArrayList<>(anagramsMap.get(hash(word)));
		for (Iterator<String> iterator = tempList.iterator(); iterator.hasNext(); ) {
		    String value = iterator.next();
		    if (value.contains(word)) iterator.remove();
		}
		return word + ": " + tempList;
	}
        
    
    
    
    
}   
