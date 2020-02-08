package ca.ubc.cs304.ui;

import ca.ubc.cs304.controller.BranchController;
import ca.ubc.cs304.controller.CustomerController;
import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.error.EntryNotFoundException;
import ca.ubc.cs304.model.BranchModel;
import ca.ubc.cs304.model.CustomerrModel;
import ca.ubc.cs304.utils.Utility;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.util.ArrayList;

public class EnterCustomerDLicense extends JFrame implements ActionListener {

    private JLabel enterDLicenseLabel;
    private JTextField dlicenseTextField;

    private JButton submitButton;
    private int TEXT_FIELD_WIDTH = 20;

    public EnterCustomerDLicense() {
        super("Enter Customer Driver's License");
    }

    public void showFrame() {

        JPanel contentPane = new JPanel();

        this.setContentPane(contentPane);
        GridBagLayout gb = new GridBagLayout();
        GridBagConstraints c = new GridBagConstraints();
        contentPane.setLayout(gb);
        contentPane.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        contentPane.setBorder(BorderFactory.createTitledBorder(
                BorderFactory.createEtchedBorder(), "Enter Customer Driver's License"));

        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        enterDLicenseLabel = new JLabel("Enter Customer Driver's License here. Your driver's license must be a number");
        gb.setConstraints(enterDLicenseLabel, c);
        contentPane.add(enterDLicenseLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        dlicenseTextField = new JTextField();
        dlicenseTextField.setColumns(TEXT_FIELD_WIDTH);
        gb.setConstraints(dlicenseTextField, c);
        contentPane.add(dlicenseTextField);


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

    /**
     * ActionListener Methods
     */
    @Override
    public void actionPerformed(ActionEvent e) {

        Long customerDLicenseFinal;

        String customerDLicense = dlicenseTextField.getText();

        customerDLicense = customerDLicense.trim();

        if (!customerDLicense.isEmpty()) {
            if (Utility.isInteger(customerDLicense)) {
                customerDLicenseFinal = Long.parseLong(customerDLicense);
            } else {
                JOptionPane.showMessageDialog(this, "Your license is not a number! Try again");
                return;
            }
        } else {
            JOptionPane.showMessageDialog(this, "Your license can't be empty!");
            return;
        }

        CustomerController customerController = new CustomerController();

        try {

            CustomerrModel fetchedCustomerModel = customerController.getCustomer(customerDLicenseFinal);

            BranchController branchController = new BranchController();
            ArrayList<BranchModel> branchModels = (ArrayList<BranchModel>) branchController.getBranches();
            MakeReservation makeReservation = new MakeReservation(branchModels, fetchedCustomerModel);
            makeReservation.showFrame();


        } catch (EntryNotFoundException entryNotFoundException) {
            int input = JOptionPane.showConfirmDialog(null, "Do you want to join SuperRent?", "Select an Option...",
                    JOptionPane.YES_NO_CANCEL_OPTION, JOptionPane.ERROR_MESSAGE);

            if (input ==  0) {
                CreateCustomer createCustomer = new CreateCustomer(customerDLicenseFinal.toString());
                createCustomer.showFrame();
            } else {
                closeWindow();
            }
        } catch (SQLException exception) {
            JOptionPane.showMessageDialog(this, exception.getMessage());
            DatabaseConnectionHandler.getInstance().rollbackConnection();
        }

        closeWindow();

    }

    private void closeWindow() {
        EnterCustomerDLicense.super.dispose();
    }
}
