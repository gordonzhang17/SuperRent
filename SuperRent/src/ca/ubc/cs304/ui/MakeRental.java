package ca.ubc.cs304.ui;

import ca.ubc.cs304.controller.RentController;
import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.error.EntryNotFoundException;
import ca.ubc.cs304.model.RentModel;
import ca.ubc.cs304.utils.Utility;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;

public class MakeRental extends JFrame implements ActionListener {

    private JButton enterCustomerDlicenseButton;

    private JLabel enterConfirmationNumberLabel;
    private JTextField confirmationNumberField;


    private JLabel creditCardNameLabel;
    private JTextField creditCardNameField;

    private JLabel creditCardNumberLabel;
    private JTextField creditCardNumberField;

    private JLabel creditCardExpirationDateLabel;
    private JTextField creditCardExpirationDateField;

    private JButton submitButton;
    private int TEXT_FIELD_WIDTH = 20;

    public MakeRental() {
        super("Enter Reservation Confirmation Number");
    }

    public void showFrame() {

        JPanel contentPane = new JPanel();

        this.setContentPane(contentPane);
        GridBagLayout gb = new GridBagLayout();
        GridBagConstraints c = new GridBagConstraints();
        contentPane.setLayout(gb);
        contentPane.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        contentPane.setBorder(BorderFactory.createTitledBorder(
                BorderFactory.createEtchedBorder(), "Enter Reservation Confirmation Number"));

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        enterCustomerDlicenseButton = new JButton("If you do not have a reservation, click here");
        enterCustomerDlicenseButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                EnterCustomerDLicense enterCustomerDLicense = new EnterCustomerDLicense();
                enterCustomerDLicense.showFrame();
                closeWindow();

            }
        });

        gb.setConstraints(enterCustomerDlicenseButton, c);
        contentPane.add(enterCustomerDlicenseButton);

        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        enterConfirmationNumberLabel = new JLabel("Enter Reservation Confirmation Number here. Your confirmation Number must be a number");
        gb.setConstraints(enterConfirmationNumberLabel, c);
        contentPane.add(enterConfirmationNumberLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        confirmationNumberField = new JTextField();
        confirmationNumberField.setColumns(TEXT_FIELD_WIDTH);
        gb.setConstraints(confirmationNumberField, c);
        contentPane.add(confirmationNumberField);


        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        creditCardNameLabel = new JLabel("Enter your credit card name here");
        gb.setConstraints(creditCardNameLabel, c);
        contentPane.add(creditCardNameLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        creditCardNameField = new JTextField();
        creditCardNameField.setColumns(TEXT_FIELD_WIDTH);
        gb.setConstraints(creditCardNameField, c);
        contentPane.add(creditCardNameField);

        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        creditCardNumberLabel = new JLabel("Enter your credit card number here");
        gb.setConstraints(creditCardNumberLabel, c);
        contentPane.add(creditCardNumberLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        creditCardNumberField = new JTextField();
        creditCardNumberField.setColumns(TEXT_FIELD_WIDTH);
        gb.setConstraints(creditCardNumberField, c);
        contentPane.add(creditCardNumberField);


        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        creditCardExpirationDateLabel = new JLabel("Enter your credit card expiration date here in MM/YY format");
        gb.setConstraints(creditCardExpirationDateLabel, c);
        contentPane.add(creditCardExpirationDateLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        creditCardExpirationDateField = new JTextField();
        creditCardExpirationDateField.setColumns(TEXT_FIELD_WIDTH);
        gb.setConstraints(creditCardExpirationDateField, c);
        contentPane.add(creditCardExpirationDateField);

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

        long reservationNumberFinal;
        String cardNameFinal;
        long cardNumberFinal;
        String cardExpDateFinal;

        String reservationNumberString = confirmationNumberField.getText().trim();

        if (!reservationNumberString.isEmpty()) {
            if (Utility.isInteger(reservationNumberString)) {
                reservationNumberFinal = Long.parseLong(reservationNumberString);
            } else {
                JOptionPane.showMessageDialog(this, "Your reservation number is not a number! Try again");
                return;
            }
        } else {
            JOptionPane.showMessageDialog(this, "Your reservation number can't be empty!");
            return;
        }

        String cardName = creditCardNameField.getText().trim();

        if (!cardName.isEmpty()) {
            cardNameFinal = cardName;
        } else {
            JOptionPane.showMessageDialog(this, "Your credit card name can't be empty!");
            return;
        }

        String cardNumber = creditCardNumberField.getText().trim();

        if (!cardNumber.isEmpty()) {
            if (Utility.isInteger(cardNumber)) {
                cardNumberFinal = Long.parseLong(cardNumber);
            } else {
                JOptionPane.showMessageDialog(this, "Your credit card number is not a number! Try again");
                return;
            }
        } else {
            JOptionPane.showMessageDialog(this, "Your credit card number can't be empty!");
            return;
        }

        String cardExpDate = creditCardExpirationDateField.getText().trim();

        if (!cardExpDate.isEmpty()) {
            cardExpDateFinal = cardExpDate;
        } else {
            JOptionPane.showMessageDialog(this, "Your credit card expiration date can't be empty!");
            return;
        }


        RentModel rentModel = new RentModel(-1, -1, -1, null, null, -1,
                cardNameFinal, cardNumberFinal, cardExpDateFinal, reservationNumberFinal);

        RentController rentController = new RentController();
        try {
            RentModel returnedRentModel = rentController.createRent(rentModel);
            MakeAndShowRentalDetails makeAndShowRentalDetails = new MakeAndShowRentalDetails(returnedRentModel);
            makeAndShowRentalDetails.showFrame();

            closeWindow();

        } catch (EntryNotFoundException exception) {
            JOptionPane.showMessageDialog(this, exception.getMessage());
            DatabaseConnectionHandler.getInstance().rollbackConnection();
        } catch (SQLException sqlException) {
            JOptionPane.showMessageDialog(this, sqlException.getMessage());
            rentController.deleteRentById(rentModel);
            DatabaseConnectionHandler.getInstance().rollbackConnection();
        }

    }

    private void closeWindow() {
        MakeRental.super.dispose();
    }
}
