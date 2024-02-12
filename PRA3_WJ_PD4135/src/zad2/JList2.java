package zad2;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class JList2 extends JFrame {
   
	private DefaultListModel model;
	private JList list;
	private JTextField tf;
   
	public JList2() {
		setTitle("JList2");
		model = new DefaultListModel();
		tf = new JTextField();				
		list = new JList(model);
		
		//sluchacz dodający tekst z pola tekstowego do JList-y
		tf.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent event) {
				model.addElement(tf.getText());
				tf.setText("");				
			}
		});
				
		//słuchacz usuwający z list po kliknięciu LPM + alt		
		list.addMouseListener(new MouseAdapter() {
            @Override
            public void mousePressed(MouseEvent e) {
            	java.util.List selectedItems = list.getSelectedValuesList();
            	if (e.isAltDown()){
            		for (Object o : selectedItems) {
            			model.removeElement(o); 
            		}
            	}
            }
        });		
		
      add(tf,BorderLayout.NORTH);
      add(new JScrollPane(list),BorderLayout.CENTER);
      setSize(300, 200);
      setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
      setLocationRelativeTo(null);
      setVisible(true);
   }
   
}

