/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad3;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.HashMap;
import javax.swing.*;
import javax.swing.JPopupMenu.Separator;

class SimpleEditor extends JFrame implements ActionListener {	
	
	static JTextArea textarea;
	JMenuBar mbar;	
	JFileChooser fch;
	String fname, fileContent;	
	String[] labels = {"File", "Edit", "Options", "Open", "Save", "Save as ...", "Exit", "Adresy", "Foreground", "Background", "Font size",
			"Praca", "Szkoła", "Dom", "Blue", "Yellow", "Orange", "Red", "White", "Black", "Green", "Blue", "Yellow", "Orange", "Red", 
			"White", "Black", "Green", "8 pts", "10 pts", "12 pts", "14 pts", "16 pts", "18 pts", "20 pts", "22 pts", "24 pts"};
	JComponent[] comps = new JComponent[labels.length];	
	Icon[] iconz = { new IconZ(10, 10, Color.blue), new IconZ(10, 10, Color.yellow), new IconZ(10, 10, Color.orange), new IconZ(10, 10, Color.red),
			new IconZ(10, 10, Color.white), new IconZ(10, 10, Color.black), new IconZ(10, 10, Color.green)
		  };	
	
	public SimpleEditor() {		
		super("Simple text editor");
		fch = new JFileChooser(".");
		textarea = new JTextArea();		
        getContentPane().add(textarea);
        getContentPane().add(new JScrollPane(textarea),BorderLayout.CENTER);
        //budujemy menu rozwijane
        mbar = new JMenuBar();
        setJMenuBar(mbar);        
        //File ... Options
        for (int i = 0; i < 3; i++) {
        	JMenu comp = new JMenu(labels[i]);
        	comps[i] = comp;
        	mbar.add(comp);
        }
        makeAndAddJMenuItem(3, 5); //Open ... Save as
        Separator sep = new Separator(); // Separator
		sep.setBorder(BorderFactory.createRaisedBevelBorder());
		sep.setBackground(Color.red);
		comps[0].add(sep);    
		makeAndAddJMenuItem(6, 6); //Exit
        makeAndAddJMenu(7, 7); //Adresy
        makeAndAddJMenu(8, 10); //Praca ...Dom
        makeAndAddJMenuItem(11, 13); //Foreground ... Font size
        makeAndAddJMenuItem(14, 20); //Kolory front
        makeAndAddJMenuItem(21, 27); //Kolory tło
        makeAndAddJMenuItem(28, 36); //Rozmiar czcionki                     
        //mnemonika i akceleratory
        ((JMenuItem) comps[3]).setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_O, ActionEvent.CTRL_MASK));
        ((JMenuItem) comps[4]).setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_S, ActionEvent.CTRL_MASK));
        ((JMenuItem) comps[5]).setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_A, ActionEvent.CTRL_MASK));
        ((JMenuItem) comps[6]).setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_X, ActionEvent.CTRL_MASK));
        
        ((JMenuItem) comps[3]).setMnemonic(KeyEvent.VK_O);
        ((JMenuItem) comps[4]).setMnemonic(KeyEvent.VK_S);
        ((JMenuItem) comps[5]).setMnemonic(KeyEvent.VK_A);
        ((JMenuItem) comps[6]).setMnemonic(KeyEvent.VK_X);                   
        
        ((JMenuItem) comps[11]).setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_P, ActionEvent.CTRL_MASK | ActionEvent.SHIFT_MASK));
        ((JMenuItem) comps[12]).setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_S, ActionEvent.CTRL_MASK | ActionEvent.SHIFT_MASK));
        ((JMenuItem) comps[13]).setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_D, ActionEvent.CTRL_MASK | ActionEvent.SHIFT_MASK));
        
        ((JMenuItem) comps[11]).setMnemonic(KeyEvent.VK_P);
        ((JMenuItem) comps[12]).setMnemonic(KeyEvent.VK_S);
        ((JMenuItem) comps[13]).setMnemonic(KeyEvent.VK_D);
                
        setSize(500, 400);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
  	  	setVisible(true);			
	}	
	//metoda wytwórcza komponentów JMenu
	public void makeAndAddJMenu(int begLab, int endLab) {
		for (int i = begLab; i <= endLab; i++) {
	    	JMenu comp = new JMenu(labels[i]);
	    	comps[i] = comp;
	    	comp.setBorder(BorderFactory.createRaisedBevelBorder());
	    	comp.addActionListener(this);
	    	if (begLab == 7) { comps[1].add(comp);}
	    	else if (begLab >= 8 && endLab <= 10) { comps[2].add(comp);}
		}		
	}	
	//metoda wytwórcza komponentów JMenuItem
		public void makeAndAddJMenuItem(int begLab, int endLab) {
			for (int i = begLab; i <= endLab; i++) {
				if (begLab >= 3 && endLab <= 6) //Open ... Exit
				{
					JMenuItem comp = new JMenuItem(labels[i]);
		        	comps[i] = comp;
		        	comp.setBorder(BorderFactory.createRaisedBevelBorder());
		        	comp.addActionListener(this);
		        	comps[0].add(comp);
				}	
				else if (begLab >= 11 && endLab <= 13) //Praca ... Dom
				{
					JMenuItem comp = new JMenuItem(labels[i]);
		        	comps[i] = comp;
		        	comp.setBorder(BorderFactory.createRaisedBevelBorder());
		        	comp.addActionListener(this);
		        	comps[7].add(comp);
				}
				else if (begLab >= 14 && endLab <= 20) //Kolory front
				{
					JMenuItem comp = new JMenuItem(labels[i], iconz[i-begLab]);
					comp.setActionCommand("foreground_color");
		        	comps[i] = comp;
		        	comp.setBorder(BorderFactory.createRaisedBevelBorder());		        	
		        	comp.addActionListener(this);
		        	comps[8].add(comp);
				}
				else if (begLab >= 21 && endLab <= 27) //Kolory tło
				{
					JMenuItem comp = new JMenuItem(labels[i], iconz[i-begLab]);
					comp.setActionCommand("background_color");
		        	comps[i] = comp;
		        	comp.setBorder(BorderFactory.createRaisedBevelBorder());		        	
		        	comp.addActionListener(this);
		        	comps[9].add(comp);
				}
				else if (begLab >= 28 && endLab <= 36) //Czcionka
				{
					JMenuItem comp = new JMenuItem(labels[i]);
					comp.setActionCommand("fontsize");
		        	comps[i] = comp;
		        	comp.setBorder(BorderFactory.createRaisedBevelBorder());		        	
		        	comp.addActionListener(this);
		        	comps[10].add(comp);
				}				
			}		
		}	
	@Override
	public void actionPerformed(ActionEvent e) {
		String cmd = e.getActionCommand();
		
		switch(cmd) {
			case "Open": openFile(); break; 
			case "Save": saveFile(); break;
			case "Save as ...": saveAsFile(); break;
			case "Exit": exitFile(); break;
			case "Praca": textarea.insert("[adres praca]", textarea.getCaretPosition()); break;
			case "Szkoła": textarea.insert("[adres szkoła]", textarea.getCaretPosition()); break;
			case "Dom": textarea.insert("[adres dom]", textarea.getCaretPosition()); break;					
		}		
		//odsyłą do metod zmieniających kolory i rozmiar czcionki
		if ( cmd == "foreground_color") {
			changeForeground( ((AbstractButton) e.getSource()).getLabel());
		}
		else if (cmd == "background_color") {
			changeBackground( ((AbstractButton) e.getSource()).getLabel());
		}
		else if (cmd == "fontsize") {
			changeFontSize(((AbstractButton) e.getSource()).getLabel());
		}				
	}
		
	public void openFile() {		
        try {
            if(fch.showOpenDialog(this) == JFileChooser.APPROVE_OPTION)
            {
                BufferedReader reader = new BufferedReader(new FileReader(fch.getSelectedFile()));
                textarea.setText("");
                String line="";
                fname = fch.getSelectedFile().getName();
                setTitle(fname);
                while ((line = reader.readLine()) != null) {textarea.append(line + "\n");}
                reader.close();
            }
        }
        catch(Exception e) {JOptionPane.showMessageDialog(this, "Nie znaleziono pliku.");} 
	}        
		
	public void saveFile() {
        FileWriter fw = null;
        try {
            if(fname == null) {
                saveAsFile();
            }
            else{
                fw = new FileWriter(fch.getSelectedFile());
                fw.write(textarea.getText());
                setTitle(fname);
                JOptionPane.showMessageDialog(this, "Plik zapisany.");
                fileContent = textarea.getText();
                fw.close();
            }
        }
        catch(Exception e) {
            JOptionPane.showMessageDialog(this, "Coś poszło nie tak...");
        }
    }	
	
	public void saveAsFile() {
        FileWriter fw = null;
        //int retval = -1;
        try {
            //retval = fch.showSaveDialog(this);
            if(fch.showSaveDialog(this) == JFileChooser.APPROVE_OPTION) {
                File file = fch.getSelectedFile();
                if(file.exists()) {
                    int option = JOptionPane.showConfirmDialog(this, "Czy chcesz nadpisać obecny plik?", "Tak", JOptionPane.YES_NO_OPTION);
                    if(option == 0) {
                        fw = new FileWriter(fch.getSelectedFile());
                        fw.write(textarea.getText());
                        JOptionPane.showMessageDialog(this, "Plik zapisany.");
                        fname = fch.getSelectedFile().getName();
                        setTitle(fname);
                        fileContent = textarea.getText();
                    }
                    else {
                        saveAsFile();
                    }
                }
                else {
                    fw = new FileWriter(fch.getSelectedFile());
                    fw.write(textarea.getText());
                    JOptionPane.showMessageDialog(this, "Plik zapisany.");
                    fname = fch.getSelectedFile().getName();
                    setTitle(fname);
                    fileContent = textarea.getText();
                }
                fw.close();
            }
        }
        catch(Exception e) {
            JOptionPane.showMessageDialog(this, "Coś poszło nie tak...");
        }   

    }
	
	public void exitFile() {
		System.exit(0);
	}
	
	public void changeForeground(String cmd) {
		HashMap map = new HashMap();
		map.put("Blue", Color.blue);
		map.put("Yellow", Color.yellow);
		map.put("Orange", Color.orange);
		map.put("Red", Color.red);
		map.put("White", Color.white);
		map.put("Black", Color.black);
		map.put("Green", Color.green);
						
		String[] arr = new String[map.size()];
		map.keySet().toArray(arr);				
		
		for (String item : arr ) {
			if (item == cmd) {
				textarea.setForeground((Color) map.get(cmd));
				break;
			}
		}	
	}
	
	public void changeBackground(String cmd) {
		HashMap map = new HashMap();
		map.put("Blue", Color.blue);
		map.put("Yellow", Color.yellow);
		map.put("Orange", Color.orange);
		map.put("Red", Color.red);
		map.put("White", Color.white);
		map.put("Black", Color.black);
		map.put("Green", Color.green);
						
		String[] arr = new String[map.size()];
		map.keySet().toArray(arr);		
		
		for (String item : arr ) {
			if (item == cmd) {
				textarea.setBackground((Color) map.get(cmd));
				break;
			}
		}	
	}	
	
	public void changeFontSize(String cmd) {		
		HashMap<String, Float> map = new HashMap<String, Float>();
		map.put("8 pts", (float) 8.0);
		map.put("10 pts", (float) 10.0);
		map.put("12 pts", (float) 12.0);
		map.put("14 pts", (float) 14.0);
		map.put("16 pts", (float) 16.0);
		map.put("18 pts", (float) 18.0);
		map.put("20 pts", (float) 20.0);
		map.put("22 pts", (float) 22.0);
		map.put("24 pts", (float) 24.0);
								
		String[] arr = new String[map.size()];
		map.keySet().toArray(arr);		
		
		for (String item : arr ) {
			if (item == cmd) {
				Font font = textarea.getFont();
				float size = map.get(item);
				textarea.setFont( font.deriveFont(size) );				
				break;
			}
		}
	}
}

public class Main {	
  public static void main(String[] args) {	  
	  SwingUtilities.invokeLater(new Runnable() {
	      public void run() {
	        new SimpleEditor();
	      }
	  });
  }
}


