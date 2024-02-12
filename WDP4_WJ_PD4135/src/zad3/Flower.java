package zad3;

//klasa abstrakcyjna
public abstract class Flower {

	private String name = "bez nazwy";
	private String color = "bez koloru";
	private int volume;
		
	public Flower() { }
		
	//metody abstrakcyjne
	public abstract String getName();
	public abstract String getColor();
	public abstract int getVolume();
}

