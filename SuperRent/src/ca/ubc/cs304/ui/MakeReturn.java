package ca.ubc.cs304.ui;

import ca.ubc.cs304.controller.RentReserveController;
import ca.ubc.cs304.controller.ReservationController;
import ca.ubc.cs304.controller.ReturnController;
import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.error.EntryNotFoundException;
import ca.ubc.cs304.model.RentReserveModel;
import ca.ubc.cs304.model.ReservationModel;
import ca.ubc.cs304.model.ReturnModel;
import ca.ubc.cs304.utils.Utility;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MakeReturn extends JFrame implements ActionListener {

    private JLabel enterRentalIdLabel;
    private JTextField enterRentalIdField;

    private JLabel odometerLabel;
    private JTextField odometerField;

    private JLabel fullTankLabel;
    private JCheckBox fullTankCheckbox;

    private JButton submitButton;
    private int TEXT_FIELD_WIDTH = 20;

    public MakeReturn() {
        super("Enter Rental Id");
    }

    public void showFrame() {

        JPanel contentPane = new JPanel();

        this.setContentPane(contentPane);
        GridBagLayout gb = new GridBagLayout();
        GridBagConstraints c = new GridBagConstraints();
        contentPane.setLayout(gb);
        contentPane.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        contentPane.setBorder(BorderFactory.createTitledBorder(
                BorderFactory.createEtchedBorder(), "Enter Rental Id"));

        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        enterRentalIdLabel = new JLabel("Enter Rent Id here. Your Rent Id must be a number");
        gb.setConstraints(enterRentalIdLabel, c);
        contentPane.add(enterRentalIdLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        enterRentalIdField = new JTextField();
        enterRentalIdField.setColumns(TEXT_FIELD_WIDTH);
        gb.setConstraints(enterRentalIdField, c);
        contentPane.add(enterRentalIdField);

        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        odometerLabel = new JLabel("Enter the odometer reading of the vehicle");
        gb.setConstraints(odometerLabel, c);
        contentPane.add(odometerLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        odometerField = new JTextField();
        odometerField.setColumns(TEXT_FIELD_WIDTH);
        gb.setConstraints(odometerField, c);
        contentPane.add(odometerField);

        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        fullTankLabel = new JLabel("Check this if the tank is full");
        gb.setConstraints(fullTankLabel, c);
        contentPane.add(fullTankLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        fullTankCheckbox = new JCheckBox();
        gb.setConstraints(fullTankCheckbox, c);
        contentPane.add(fullTankCheckbox);

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

        long rentIdFinal;
        char isTankFullFinal;

        Timestamp currentTimestamp = null;

        try {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM/dd/yyyy, HH:mm");
            Date date = new Date(System.currentTimeMillis());
            String currentDateString = simpleDateFormat.format(date);
            Date currentDate = simpleDateFormat.parse(currentDateString);
            currentTimestamp = new Timestamp(currentDate.getTime());

        } catch (ParseException pe) {
            JOptionPane.showMessageDialog(this, "Something went wrong. Please try again");
            return;
        }

        long odometerFinal;

        String rentIdString = enterRentalIdField.getText().trim();

        if (!rentIdString.isEmpty()) {
            if (Utility.isInteger(rentIdString)) {
                rentIdFinal = Long.parseLong(rentIdString);
            } else {
                JOptionPane.showMessageDialog(this, "Your rent id is not a number! Try again");
                return;
            }
        } else {
            JOptionPane.showMessageDialog(this, "Your rent id can't be empty!");
            return;
        }

        String odometerString = odometerField.getText().trim();

        if (!odometerString.isEmpty()) {
            if (Utility.isInteger(odometerString)) {
                odometerFinal = Long.parseLong(odometerString);
            } else {
                JOptionPane.showMessageDialog(this, "Your odometer reading is not a number! Try again");
                return;
            }
        } else {
            JOptionPane.showMessageDialog(this, "Your odometer reading can't be empty!");
            return;
        }

        boolean isFullTankSelected = fullTankCheckbox.isSelected();

        if (isFullTankSelected) {
            isTankFullFinal = '1';
        } else {
            isTankFullFinal = '0';
        }

        ReturnModel returnModel = new ReturnModel(rentIdFinal, currentTimestamp, odometerFinal, isTankFullFinal, 0);

        ReturnController returnController = new ReturnController();

        try {
            ReturnModel returnedReturnDetails = returnController.returnVehicle(returnModel);

            RentReserveController rentReserveController = new RentReserveController();
            RentReserveModel rentReserveModel = rentReserveController.getRentReserveByRentID(returnedReturnDetails.getRent_id());

            ReservationController reservationController = new ReservationController();
            ReservationModel reservationModel = reservationController.getReservationByID(rentReserveModel.getReservation_confNo());

            MakeAndShowReturnDetails makeAndShowReturnDetails = new MakeAndShowReturnDetails(returnedReturnDetails, reservationModel);
            makeAndShowReturnDetails.showFrame();

            closeWindow();

        } catch (EntryNotFoundException entryNotFoundException) {
            JOptionPane.showMessageDialog(this, entryNotFoundException.getMessage());
        } catch (SQLException sqlException) {
            JOptionPane.showMessageDialog(this, sqlException.getMessage());
            DatabaseConnectionHandler.getInstance().rollbackConnection();

        }
    }

    private void closeWindow() {
        MakeReturn.super.dispose();
    }
}
