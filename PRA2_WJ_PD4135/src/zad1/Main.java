/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad1;

import java.awt.*;
import javax.swing.*;

class Labels extends JFrame {

  public Labels() {
	  setLayout(new BorderLayout());
	  Color colors[] = { new Color(10, 15, 5), new Color(25, 55, 10), new Color(10, 170, 100),
			  new Color(150, 10, 150), new Color(200, 20, 20), new Color(255, 255, 25)};
	  String borders[] = { "West", "North", "East", "South", "Center" };
	  String fonts[] = { "Serif", "SansSerif", "Monospaced", "Dialog", "DialogInput"};
	  	  
	  for (int i = 0; i < 5; i++) {
		  JLabel lab = new JLabel("Label nr " + (i+1) );
		  lab.setToolTipText("To jest etykieta nr " + (i+1));
		  lab.setBackground(colors[i]);
		  lab.setForeground(colors[i+1]);
		  lab.setFont(new Font(fonts[i], Font.BOLD, 2*i+15));
		  lab.setBorder(BorderFactory.createLineBorder(colors[i+1]));		  
		  lab.setOpaque(true);		  
		  add(lab, borders[i]);		  
	  }	    	  
	  setDefaultCloseOperation(EXIT_ON_CLOSE);
	  pack();
	  setVisible(true);	  
 }
}  

public class Main {

  public static void main(String[] args) {
	  SwingUtilities.invokeLater(new Runnable() {
	      public void run() {
	        new Labels();
	      }
	  });
  }
}
