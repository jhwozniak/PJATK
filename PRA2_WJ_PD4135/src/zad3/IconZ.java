package zad3;


import javax.swing.*;
import java.awt.*;
import static javax.swing.SwingConstants.*;

public class IconZ implements Icon {

  private Color color;
  private int w, h;  

  /*IconZ(Color c, boolean frame) {
    color = c;
    this.frame = frame;
  }*/
  
  IconZ(int w, int h, Color c) {
	  this.w = w;
	  this.h = h;
	  color = c;
  }

  @Override
  public void paintIcon(Component c, Graphics g, int x, int y) {
    g.setColor(color);
    g.fillOval(x, y, w, h);
  }
  
  
  
  
  /*public void paintIcon(Component c, Graphics g, int x, int y) {
    Color old = g.getColor();
    g.setColor(color);
    w = ((JComponent) c).getHeight() / 2;
    int p = w / 4, d = w / 2;
    g.fillOval(x + p, y + p, d, d);
    //if (frame) g.drawRect(x, y, w - 1, w - 1);
    g.setColor(old);
  }*/
  
  

  public int getIconWidth() {
    return w;
  }

  public int getIconHeight() {
    return w;
  }

}
