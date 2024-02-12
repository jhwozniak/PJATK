package zad1;

import java.util.List;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GUI extends JPanel {
	List<TranslatedOffer> offers;
	
	public GUI(List<TranslatedOffer> offers) {		
		super();
		this.offers = offers;
		
		//setting column names
		String[] columnNames = {"Country", "Departure", "Return", "Type", "Price", "Currency"};
		
		//populating data array
		int rows = offers.size();
		Object[][] data = new Object[rows][6];		
		JButton btn1 = new JButton("PL");
		JButton btn2 = new JButton("EN");
		
		//button 1 listener
		btn1.addActionListener(new ActionListener()
        {
            @Override
            public void actionPerformed(ActionEvent e)
            {                
            	int rows = offers.size() / 2;
            	for (int i = 0; i < rows; i++) {
            		data[i][0] = offers.get(i).getCountryName();
            		data[i][1] = offers.get(i).getDepartureDate();
            		data[i][2] = offers.get(i).getReturnDate();
            		data[i][3] = offers.get(i).getDestinationType();
            		data[i][4] = offers.get(i).getPrice();
            		data[i][5] = offers.get(i).getCurrency();
        		}
            }
        });    
		
		//button 2 listener
		btn2.addActionListener(new ActionListener()
		{
		    @Override
		    public void actionPerformed(ActionEvent e)
		    {                
		    	int rows = offers.size() / 2;
		        for (int i = 0; i < rows; i++) {
		        	data[i][0] = offers.get(i+rows).getCountryName();
            		data[i][1] = offers.get(i+rows).getDepartureDate();
            		data[i][2] = offers.get(i+rows).getReturnDate();
            		data[i][3] = offers.get(i+rows).getDestinationType();
            		data[i][4] = offers.get(i+rows).getPrice();
            		data[i][5] = offers.get(i+rows).getCurrency();			
		        }
		    }
		}); 	
				
		//displaying data			
		final JTable table = new JTable(data, columnNames);
		
		table.setPreferredScrollableViewportSize(new Dimension(500, 70));
		table.setFillsViewportHeight(true);
		JScrollPane scrollPane = new JScrollPane(table); 
		add(scrollPane); 
		add(btn1, BorderLayout.PAGE_END);
		add(btn2, BorderLayout.PAGE_END);
		JFrame frame = new JFrame("Offers");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setOpaque(true); 
		frame.setContentPane(this);        
		frame.pack();
		frame.setVisible(true);   
	}	
}
