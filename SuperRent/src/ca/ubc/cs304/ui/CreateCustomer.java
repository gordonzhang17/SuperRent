package ca.ubc.cs304.ui;

import ca.ubc.cs304.controller.BranchController;
import ca.ubc.cs304.controller.CustomerController;
import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.model.BranchModel;
import ca.ubc.cs304.model.CustomerrModel;
import ca.ubc.cs304.utils.Utility;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.util.ArrayList;

public class CreateCustomer extends JFrame implements ActionListener {

    private String customerDLicenseString;

    private JLabel customerFirstName;
    private JTextField customerFirstNameTextField;

    private JLabel customerLastName;
    private JTextField customerLastNameTextField;

    private JLabel customerCellPhoneLabel;
    private JTextField customerCellPhoneTextField;

    private JLabel customerAddress;
    private JTextField customerAddressTextField;

    private JLabel customerDLicense;
    private JLabel customerDLicenseTextFieldLabel;

    private JButton submitButton;
    private int TEXT_FIELD_WIDTH = 20;

    public CreateCustomer(String customerDlicense) {
        super("Enter Customer Information");
        customerDLicenseString = customerDlicense;
    }

    public void showFrame() {

        JPanel contentPane = new JPanel();

        this.setContentPane(contentPane);
        GridBagLayout gb = new GridBagLayout();
        GridBagConstraints c = new GridBagConstraints();
        contentPane.setLayout(gb);
        contentPane.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        contentPane.setBorder(BorderFactory.createTitledBorder(
                BorderFactory.createEtchedBorder(), "Join SuperRent as a customer!"));

        // first name
        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        customerFirstName = new JLabel("Enter your first name");
        gb.setConstraints(customerFirstName, c);
        contentPane.add(customerFirstName);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        customerFirstNameTextField = new JTextField();
        customerFirstNameTextField.setColumns(TEXT_FIELD_WIDTH);
        gb.setConstraints(customerFirstNameTextField, c);
        contentPane.add(customerFirstNameTextField);

        // last name
        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        customerLastName = new JLabel("Enter your last name");
        gb.setConstraints(customerLastName, c);
        contentPane.add(customerLastName);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        customerLastNameTextField = new JTextField();
        customerLastNameTextField.setColumns(TEXT_FIELD_WIDTH);
        gb.setConstraints(customerLastNameTextField, c);
        contentPane.add(customerLastNameTextField);

        // cell phone
        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        customerCellPhoneLabel = new JLabel("Enter your cell number");
        gb.setConstraints(customerCellPhoneLabel, c);
        contentPane.add(customerCellPhoneLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        customerCellPhoneTextField = new JTextField();
        customerCellPhoneTextField.setColumns(TEXT_FIELD_WIDTH);
        gb.setConstraints(customerCellPhoneTextField, c);
        contentPane.add(customerCellPhoneTextField);

        // address
        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        customerAddress = new JLabel("Enter your address");
        gb.setConstraints(customerAddress, c);
        contentPane.add(customerAddress);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        customerAddressTextField = new JTextField();
        customerAddressTextField.setColumns(TEXT_FIELD_WIDTH);
        gb.setConstraints(customerAddressTextField, c);
        contentPane.add(customerAddressTextField);

        // driver's license
        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        customerDLicense = new JLabel("Driver's license");
        gb.setConstraints(customerDLicense, c);
        contentPane.add(customerDLicense);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        customerDLicenseTextFieldLabel = new JLabel(customerDLicenseString);
        gb.setConstraints(customerDLicenseTextFieldLabel, c);
        contentPane.add(customerDLicenseTextFieldLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        submitButton = new JButton("Submit the information");
        gb.setConstraints(submitButton, c);
        contentPane.add(submitButton);
        submitButton.addActionListener(this);

        this.pack();

        Dimension d = this.getToolkit().getScreenSize();
        Rectangle r = this.getBounds();
        this.setLocation((d.width - r.width) / 2, (d.height - r.height) / 2);

        this.setVisible(true);

    }

    @Override
    public void actionPerformed(ActionEvent e) {

        String firstNameFinal;
        String lastNameFinal;
        long cellPhoneFinal;
        String addressFinal;

        String firstNameInput = customerFirstNameTextField.getText().trim();

        if (!firstNameInput.isEmpty()) {
            firstNameFinal = firstNameInput;
        } else {
            JOptionPane.showMessageDialog(this, "First name can't be empty!");
            return;
        }

        String lastNameInput = customerLastNameTextField.getText().trim();

        if (!lastNameInput.isEmpty()) {
            lastNameFinal = lastNameInput;
        } else {
            JOptionPane.showMessageDialog(this, "Last name can't be empty!");
            return;
        }

        String cellPhoneInput = customerCellPhoneTextField.getText().trim();

        if (!cellPhoneInput.isEmpty() || Utility.isInteger(cellPhoneInput)) {
            if (Utility.isInteger(cellPhoneInput)) {
                cellPhoneFinal = Long.parseLong(cellPhoneInput);
            } else {
                JOptionPane.showMessageDialog(this, "Something is wrong with the cell phone input");
                return;
            }
        } else {
            JOptionPane.showMessageDialog(this, "Something is wrong with the cell phone input");
            return;
        }

        String addressInput = customerAddressTextField.getText().trim();

        if (!addressInput.isEmpty()) {
            addressFinal = addressInput;
        } else {
            JOptionPane.showMessageDialog(this, "Address can't be empty!");
            return;
        }

        CustomerrModel customer = new CustomerrModel(cellPhoneFinal, firstNameFinal + " " + lastNameFinal, addressFinal, Long.parseLong(customerDLicenseString));

        CustomerController customerController = new CustomerController();

        try {

            CustomerrModel returnedCustomerModel = customerController.insertCustomer(customer);
            if (returnedCustomerModel != null) {

                BranchController branchController = new BranchController();
                ArrayList<BranchModel> branchModels = (ArrayList<BranchModel>) branchController.getBranches();
                if (branchModels != null) {
                    MakeReservation makeReservation = new MakeReservation(branchModels, returnedCustomerModel);
                    makeReservation.showFrame();
                }
            }

        } catch (SQLException sqlException) {
            JOptionPane.showMessageDialog(this, sqlException.getMessage());
            DatabaseConnectionHandler.getInstance().rollbackConnection();
        }


        closeWindow();

    }

    private void closeWindow() {
        CreateCustomer.super.dispose();
    }

}
