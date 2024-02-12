/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad3;

import javax.swing.JFrame;

public class Main {

  public static void main(String[] args) {
	  javax.swing.SwingUtilities.invokeLater(new Runnable() {
          public void run() {        	  
        	  JFrame frame = new JFrame("Księgarnia");
              frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);    
              Bookstore newContentPane = new Bookstore();
              newContentPane.setOpaque(true);               
              frame.setContentPane(newContentPane);
              frame.pack();
              frame.setVisible(true);
          }
      });
  }
}
