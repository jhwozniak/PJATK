package zad1;

import javax.swing.AbstractListModel;

public class JList1Model extends AbstractListModel {
	
	@Override
	public Object getElementAt(int i) {		
		return (i - 70) + " stopni C = " + (2*(i - 70) + 32) + " stopni F";
	}
	
	@Override
	public int getSize() {
		return 131;
	}
}
