package zad1;

import java.util.*;
import java.util.function.Consumer;
import java.util.stream.Collectors;


public class XList <T> extends ArrayList<T> {

    public XList (T ... args) {
    	this.addAll(Arrays.asList(args));
    }
	
    public XList (Collection<T> col) {
    	this.addAll(col);
    }
	
    public static <T> XList<T> of(T ... args) {
    	XList list = new XList<>();
    	list.addAll(Arrays.asList(args));
    	return list;
    }
    
    public static <T> XList<T> of(Collection<T> col) {
    	XList list = new XList<>();
    	list.addAll(col);
    	return list;
    }
    
    public static XList<String> charsOf(String str) {
		XList list = new XList();
		for (char c : str.toCharArray()) {
		    list.add(c);
		}
		return list;
	}
	
    public static XList<String> tokensOf(String str) {
		XList list = new XList();
		for (String s : str.split("\\s+")) {
			list.add(s);
		}
		return list;		
	}

	public static XList<String> tokensOf(String str, String delimiter) {
		XList list = new XList();
		for (String s : str.split(delimiter)) {
			list.add(s);
		}
		return list;		
	}
    
	
	public XList union(T ... args) {
		XList list = new XList(this);
		list.addAll(Arrays.asList(args));
		return list;
	}
	
	
	public XList union(Collection<T> col) {
		XList list = new XList(this);
		list.addAll(col);
		return list;
	}
    
	public XList diff(Collection<T> col) {
		XList list = new XList(this);
		list.removeAll(col);
		return list;
	}
	
	public XList unique() {
		XList list = new XList(this);
		Set<String> set = new LinkedHashSet<>(list);
		list.clear();
		list.addAll(set);
		return list;
	}
	
	public XList<XList<T>> combine() {
	    
		XList rlists = this; 
		XList<XList<T>> lists = new XList<XList<T>>();
		
		for (int i = 0; i < rlists.size(); i++) {
			XList temp = new XList();
			List elements = new ArrayList((List) rlists.get(i));
			for (int j = 0; j < elements.size(); j++) {
				temp.add(elements.get(j));
			}
			lists.add(temp);		
		}
		
		
		XList<XList<T>> combinations = new XList<XList<T>>();
		XList<XList<T>> newCombinations;

	    int index = 0;
	    	    
	    for (T i : lists.get(0)) {
	        XList<T> newList = new XList<T>();
	        newList.add(i);
	        combinations.add(newList);
	    }
	    index++;
	    while (index < lists.size()) {
	        XList<T> nextList = new XList<T>();
	    	nextList = lists.get(index);
	        newCombinations = new XList<XList<T>>();
	        for (XList<T> first : combinations) {
	            for (T second : nextList) {
	                XList<T> newList = new XList<T>();
	                newList.addAll(first);
	                newList.add(second);
	                newCombinations.add(newList);
	            }
	        }
	        combinations = newCombinations;
	        index++;
	    }
	    return combinations;
	}
	
	
	public String join(String delimiter) {
		XList rlists = this; 
		XList<XList<T>> lists = new XList<XList<T>>();
		
		for (int i = 0; i < rlists.size(); i++) {
			XList temp = new XList();
			List elements = new ArrayList((List) rlists.get(i));
			for (int j = 0; j < elements.size(); j++) {
				temp.add(elements.get(j));
			}
			lists.add(temp);
		//System.out.println(lists);
		}
				
		String msg = "";   
                
		int index = 0;
		while (index < lists.size()) {
			XList<T> nextList = new XList<T>();
			nextList = lists.get(index);
				for (T element : nextList) {
					msg += element;
				}
			msg += delimiter;
			index++;	
		}
		return msg;
    }

	
	public XList<T> join() {
		return this;
		
	}
	
	public XList<String> collect(Consumer<? super T> object) {
		this.forEach(object);
		return (XList<String>) this;	
	
	}
	
	
	
	
	
	
	
	
}