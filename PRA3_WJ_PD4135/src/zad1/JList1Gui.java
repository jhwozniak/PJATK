package zad1;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class JList1Gui extends JFrame implements ActionListener {
	JList list;
	JList1Gui() {		
		Container cp = getContentPane();
		list = new JList(new JList1Model());
		cp.add(new JScrollPane(list), "Center");		
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		pack();
		setVisible(true);
	}
	
	@Override
	public void actionPerformed(ActionEvent e) {
		return;		
	}

}
