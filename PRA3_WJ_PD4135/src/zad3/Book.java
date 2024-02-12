package zad3;

import javax.swing.ImageIcon;

public class Book {
	private String autor;
	private String tytul;
	private double cena;
	private ImageIcon okladka;
	
	public Book(String autor, String tytul, double cena, ImageIcon okladka) {
		this.autor = autor;
		this.tytul = tytul;
		this.cena = cena;
		this.okladka = okladka;
	}
	
	public String getAutor() {
		return this.autor;
	}
	
	public String getTytul() {
		return this.tytul;
	}
	
	public double getCena() {
		return this.cena;
	}
	
	public ImageIcon getOkladka() {
		return this.okladka;
	}

	public void setAutor(String autor) {
		this.autor = autor;					
	}
	
	public void setTytul(String tytul) {
		this.tytul = tytul;					
	}
		
	public void setCena(double value) {
		this.cena = value;			
	}
	
	public void setOkladka(ImageIcon okladka) {
		this.okladka = okladka;			
	}
	
}
