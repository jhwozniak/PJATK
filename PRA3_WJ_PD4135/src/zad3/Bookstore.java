package zad3;
import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.TableModel;

//obsługuje tabelę z książkami, plik books.txt oraz pliki graficzne pobiera z src/zad3/resources
public class Bookstore extends JPanel {
			
	public Bookstore() {
        super(new BorderLayout(0,0)); 
        JTable table = new JTable(new BookstoreModel());
        JButton btn = new JButton("Dodaj książkę");
        
        //słuchacz usuwający z tabeli po kliknięciu LPM + ALT		
        table.addMouseListener(new MouseAdapter() {
        	@Override
        	public void mousePressed(MouseEvent e) {        		      			
        		if (e.isAltDown()) 
        		{ 
        			BookstoreModel model = (BookstoreModel) table.getModel();
        			model.removeRow(table.getSelectedRow());        				        				
        		} 	
			}
        });	        
        
        //słuchacz dodający książkę do tabeli
        btn.addActionListener(new ActionListener()
        {
            @Override
            public void actionPerformed(ActionEvent e)
            {                
                BookstoreModel model = (BookstoreModel) table.getModel();
                Book bookObj = new Book("podaj autora", "podaj tytuł", 0.00, new ImageIcon("podaj nazwę pliku"));
                model.addRow(bookObj);
            }
        });                
        
        table.setPreferredScrollableViewportSize(new Dimension(700, 500));
        table.setFillsViewportHeight(true);
        table.setRowHeight(90);        
        JScrollPane scrollPane = new JScrollPane(table);        
        
        add(scrollPane, BorderLayout.CENTER);
        add(btn, BorderLayout.PAGE_END);
    }		
			
	public class BookstoreModel extends AbstractTableModel {
		
		private String[] columnNames = {"Autor", "Tytuł", "Cena", "Okładka"};      
		List<Book> data = new ArrayList<Book>();
		
		public BookstoreModel () {
			
			String fname = "src/zad3/resources/books.txt";
			String lineInFile;
			String autor = "";
			String tytul = "";
			double cena = 0;
			String sciezkaDoOkladki = "";
			
			//wczytuje atrybuty książki z plików w tym samym katalogu, dodaje nową książkę do modelu
			try 
			{				
				BufferedReader br = new BufferedReader(new FileReader(fname));
				while ((lineInFile = br.readLine()) != null) 
				{					  
					sciezkaDoOkladki = "src/zad3/resources/";
					StringTokenizer st = new StringTokenizer(lineInFile, ",");
					autor = st.nextToken();
					tytul = st.nextToken();
					cena = Double.parseDouble(st.nextToken());
					sciezkaDoOkladki += st.nextToken();					
					data.add(new Book(autor, tytul, cena, new ImageIcon(sciezkaDoOkladki))); 
				}								
			} catch (IOException e) { e.printStackTrace(); }			
		}
		
		@Override
		public int getColumnCount() {
	        return columnNames.length;
	    }
	    
		@Override
		public String getColumnName(int col) {
	        return columnNames[col];
	    }
		
		@Override
		//zapewnia pobieranie wartości komórek z modelu
		public Object getValueAt(int row, int col) {
		     Book bookObj = data.get(row);	     
		     
		      switch(col){
		        case 0: return bookObj.getAutor();
		        case 1: return bookObj.getTytul();
		        case 2: return bookObj.getCena();
		        case 3: return bookObj.getOkladka();
		        default : return null;
		      }
		}

		@Override
		public int getRowCount() {		
			return data.size();
		}
		
		@Override
		public Class getColumnClass(int col) {
            return getValueAt(0, col).getClass();
        }
		
		@Override
		//zapewnia edytowalność komórek z ceną
		public boolean isCellEditable(int row, int col) {
            if (col == 2) {return true;}
            else if (row == getRowCount()-1 && (col == 0 || col == 1 || col == 2 || col == 3)) {return true;}
            else {return false;}
        }
        
		@Override
		public void setValueAt(Object value, int row, int col) {
			Book bookObj = data.get(row);
			
			//edytowanie ceny
			if (col == 2 && (double) value >= 0) 
			{
				bookObj.setCena((double) value);
				fireTableCellUpdated(row, col);				
			}
			
			//switch do wypełnienia ostatniego wiersza (książka już istnieje, tylko pusta)
			if ( row == getRowCount()-1 ) 			
			{
				try 
				{
					switch(col){
		        	case 0: bookObj.setAutor((String) value); break;
		        	case 1: bookObj.setTytul((String) value); break;
		        	case 2: bookObj.setCena((double) value); break; 
		        	case 3: 
		        		{
		        			String sciezkaDoOkladki = "src/zad3/resources/";		        			
		        			sciezkaDoOkladki += value.toString();		        			
		        			bookObj.setOkladka(new ImageIcon(sciezkaDoOkladki));
		        			break;
		        		} 
					}									
				}
				catch (IllegalArgumentException e) {System.out.println("Illegal argument");}				
				fireTableCellUpdated(row, col);
			}
		}
		
		public void removeRow(int row)
		{
		    data.remove(row);
		    fireTableRowsDeleted(row, row);
		}      		
		
		public void addRow(Book bookObj)
		{
	        data.add(bookObj);	        
	        fireTableRowsInserted(getRowCount()-1,getRowCount()-1);	        
	    }
	}
}
