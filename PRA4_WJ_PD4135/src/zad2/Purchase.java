/**
 *
 *  @author Woźniak Jakub PD4135
 *
 */

package zad2;
import java.awt.event.*;
import java.beans.*;
import java.io.*;
import java.util.EventObject;

public class Purchase implements PropertyChangeListener, VetoableChangeListener {
	
	private String prod;
	private String data;
	private Double price;
		
	
	public Purchase() {
		
	}
		
	
	public Purchase(String string1, String string2, double d) {
		setProd(string1);
		setData(string2);
		try 
		{
			setPrice(d);
		} catch (PropertyVetoException e) {
			e.printStackTrace();
		}
	}
	
	private PropertyChangeSupport dataPcs = new PropertyChangeSupport(this);
	private PropertyChangeSupport pricePcs = new PropertyChangeSupport(this);
	private VetoableChangeSupport priceVcs = new VetoableChangeSupport(this);
	
	
	//gettery
	public String getProd() {
		return prod;
	}
	
	public String getData() {
		return data;
	}

	public Double getPrice() {
		return price;
	}

	//settery
	public void setProd(String str) {
		prod = str;
	}
	
	public void setData(String str){
		String oldData = data;
		data = str;
		dataPcs.firePropertyChange("data",
                oldData, str);
	}
	
		
	public void setPrice(Double d) throws PropertyVetoException {
		Double oldPrice = price;
		priceVcs.fireVetoableChange("price", oldPrice, d);
		price = d;
		pricePcs.firePropertyChange("price", oldPrice, d);
	}
	
		
	public void addPropertyChangeListener(PropertyChangeListener listener) {
        dataPcs.addPropertyChangeListener(listener);
    }
    
    public void removePropertyChangeListener(PropertyChangeListener listener) {
        dataPcs.removePropertyChangeListener(listener);
    }
	
    
    public void addVetoableChangeListener(VetoableChangeListener listener) {
        priceVcs.addVetoableChangeListener(listener);
    }
    
    public void removeVetoableChangeListener(VetoableChangeListener listener) {
        priceVcs.removeVetoableChangeListener(listener);
    }
	
    public String toString() {
    	return this.getClass().getSimpleName() + " [" + "prod=" + prod + ", " + "data=" + data + ", " + "price=" + price +"]";
    }


	@Override
	public void propertyChange(PropertyChangeEvent e)  {
	    Object oldVal = e.getOldValue(),
	           newVal = e.getNewValue();
	    System.out.println("Change value of: " + e.getPropertyName() + " from: " + oldVal + " to: " + newVal);
	    
	}


	@Override
	public void vetoableChange(PropertyChangeEvent evt) throws PropertyVetoException {
		if((Double) evt.getNewValue() < 1000) 
		{
			
			
			      throw new PropertyVetoException("Price change to: " + (Double) evt.getNewValue() + " not allowed", evt );
		}
		
		
		Object oldVal = evt.getOldValue(),
		           newVal = evt.getNewValue();
		    System.out.println("Change value of: " + evt.getPropertyName() + " from: " + oldVal + " to: " + newVal);
		
	}
}  
