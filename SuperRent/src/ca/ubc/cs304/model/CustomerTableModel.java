package ca.ubc.cs304.model;

import javax.swing.table.AbstractTableModel;
import java.util.ArrayList;
import java.util.List;

public class CustomerTableModel extends AbstractTableModel {

    private ArrayList<CustomerrModel> customers;
    private String[] columnNames = {"Cellphone", "Name", "Address", "DLicense"};

//    this.customer_cellphone =customer_cellphone;
//        this.customer_name =customer_name;
//        this.customer_address =customer_address;
//        this.customer_dlicense =customer_dlicense;

    public CustomerTableModel(List<CustomerrModel> customers) {

        this.customers = new ArrayList<>(customers);
    }


    @Override
    public int getRowCount() {
        return customers.size();
    }

    @Override
    public int getColumnCount() {
        return 4;
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {

        Object value = null;
        CustomerrModel customer = customers.get(rowIndex);
        switch (columnIndex) {
            case 0:
                value = customer.getCellphone();
                break;
            case 1:
                value = customer.getName();
                break;
            case 2:
                value = customer.getAddress();
                break;
            case 3:
                value = customer.getDlicense();
                break;
        }

        return value;
    }

    @Override
    public String getColumnName(int index) {
        return columnNames[index];
    }

//    @Override
//    public void setValueAt(Object valueToChangeTo, int rowIndex, int columnIndex) {
//        Customer row = customers.get(rowIndex);
//
//        if (0 == columnIndex) {
//            row.setCustomer_cellphone((Integer) valueToChangeTo);
//        } else if (1 == columnIndex) {
//            row.setCustomer_name((String) valueToChangeTo);
//        } else if (2 == columnIndex) {
//            row.setCustomer_address((String) valueToChangeTo);
//        } else if (3 == columnIndex) {
//            row.setCustomer_dlicense((Integer) valueToChangeTo);
//        }
//    }

    @Override
    public boolean isCellEditable(int rowIndex, int columnIndex) {
        return true;
    }

    public ArrayList<CustomerrModel> getCustomers() {
        return customers;
    }
}
