package zad3;

public class Rose extends Flower {
	
	private String name;
	private String color;
	private int volume;
	
	public Rose(int n) {
		name = "róża";
		color = "czerwony";
		volume = n;
	}
	
	//definiujemy metody
	public String getName() { return name; }
	public String getColor() { return color; }
	public int getVolume() { return volume; }
}
