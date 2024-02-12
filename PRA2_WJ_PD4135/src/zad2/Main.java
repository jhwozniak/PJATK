/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad2;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.*;

class Butt extends JFrame implements ActionListener {
	
	private int i = 0;
	private JFrame frame;
	private JPanel panel;
	private JButton button;
	
	public Butt() {
		frame = new JFrame();
		panel = new JPanel();
		button = new JButton("Zmień kolor tła!");
		button.addActionListener(this);
		button.setFont(new Font("Helvetica", Font.BOLD, 16));
					
		panel.setBorder(BorderFactory.createEmptyBorder(100, 100, 100, 100));
		panel.setLayout(new GridLayout(0, 1));	
		panel.add(button);
		
		frame.add(panel, BorderLayout.CENTER);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.pack();
		frame.setVisible(true);			
	}
	
	@Override
	public void actionPerformed(ActionEvent e) {
		Color colors[] = { new Color(200, 20, 20), new Color(100, 150, 50), new Color(25, 55, 10), new Color(10, 170, 100),
				  new Color(150, 10, 150) };				
		panel.setBackground(colors[i]);
		i++;
		if ( i == 5) i = 0;
		}		
	}

public class Main {

  public static void main(String[] args) {
	  SwingUtilities.invokeLater(new Runnable() {
	      public void run() {
	        new Butt();
	      }
	  });
  }
}
