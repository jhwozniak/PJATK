package zad3;

//definiujemy podklasę bez
public class Lilac extends Flower {
		
	private String name;
	private String color;
	private int volume;
	
	public Lilac(int n) {
		name = "bez";
		color = "biały";
		volume = n;
	}
	
	//definiujemy metody
	public String getName() { return name; }
	public String getColor() { return color; }
	public int getVolume() { return volume; }
}
