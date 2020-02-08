package ca.ubc.cs304.controller;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.error.EntryNotFoundException;
import ca.ubc.cs304.model.CustomerrModel;

public class CustomerController {
    private static final String CUSTOMER_BY_DLICENSE = "SELECT * FROM customer WHERE dlicense = ?";
    private static final String INSERT_CUSTOMER = "INSERT INTO customer (cellphone, name, address, dlicense) VALUES (?, ?, ?, ?)";
    private DatabaseConnectionHandler db = null;

    public CustomerController() {
        this.db = DatabaseConnectionHandler.getInstance();
    }

    public CustomerrModel getCustomer(long dlicense) throws EntryNotFoundException, SQLException {
        PreparedStatement ps = db.getConnection().prepareStatement(CUSTOMER_BY_DLICENSE);
        ps.setLong(1, dlicense);
        ResultSet rs = ps.executeQuery();
        if (rs.next() == false) {
            ps.close();
            rs.close();
            throw new EntryNotFoundException("Error - No customers found with driver's license number: "+dlicense);
        } else {
            long cellphone = rs.getLong(1);
            String name = rs.getString(2);
            String address = rs.getString(3);
            long customer_dlicense = rs.getLong(4);
            CustomerrModel customer = new CustomerrModel(cellphone, name, address, customer_dlicense);
            ps.close();
            rs.close();
            return customer;
        }
    }

    public CustomerrModel insertCustomer(CustomerrModel customer) throws SQLException{
        PreparedStatement ps = db.getConnection().prepareStatement(INSERT_CUSTOMER);
        ps.setLong(1, customer.getCellphone());
        ps.setString(2, customer.getName());
        ps.setString(3, customer.getAddress());
        ps.setLong(4, customer.getDlicense());
        ps.executeUpdate();
        db.getConnection().commit();
        ps.close();
        return customer;
    }
}