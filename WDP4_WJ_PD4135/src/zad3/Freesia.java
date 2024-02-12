package zad3;

//definiujemy podklasę frezja
public class Freesia extends Flower {
		
	private String name;
	private String color;
	private int volume;
	
	public Freesia(int n) {
		name = "frezja";
		color = "żółty";
		volume = n;
	}
	
	//definiujemy metody
	public String getName() { return name; }
	public String getColor() { return color; }
	public int getVolume() { return volume; }
}
