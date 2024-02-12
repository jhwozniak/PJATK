package zad3;

//definiujemy podklasę peonia
public class Peony extends Flower {
	
	private String name;
	private String color;
	private int volume;
	
	public Peony(int n) {
		name = "piwonia";
		color = "czerwony";
		volume = n;
	}
	
	//definiujemy metody
	public String getName() { return name; }
	public String getColor() { return color; }
	public int getVolume() { return volume; }
}
