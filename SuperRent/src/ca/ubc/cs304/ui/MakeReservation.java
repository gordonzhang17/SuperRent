package ca.ubc.cs304.ui;

import ca.ubc.cs304.controller.ReservationController;
import ca.ubc.cs304.error.EntryNotFoundException;
import ca.ubc.cs304.model.BranchModel;
import ca.ubc.cs304.model.CustomerrModel;
import ca.ubc.cs304.model.ReservationModel;
import ca.ubc.cs304.model.VehicleType;
import ca.ubc.cs304.utils.Utility;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class MakeReservation extends JFrame implements ActionListener {

    private JLabel customerNameLabel;

    private JLabel customerDLicense;
    private JLabel customerDLicenseTextLabel;

    private JComboBox<String> dropdownMenuForVehicleType;

    private JLabel locationLabel;

    private ArrayList<BranchModel> branchModels;
    private CustomerrModel customerrModel;

    private JComboBox<String> dropdownMenuForBranch;

    private int TEXT_FIELD_WIDTH = 20;
    private int TIME_FIELD_WIDTH = 5;

    private JLabel fromDateLabel;
    private JTextField fromDateTextField;

    private JLabel toDateTextLabel;
    private JTextField toDateTextField;

    private JLabel fromTimeLabel;
    private JTextField fromTimeTextField;

    private JLabel toTimeLabel;
    private JTextField toTimeTextField;

    private JButton submitButton;

    public MakeReservation(ArrayList<BranchModel> branchModels, CustomerrModel customer) {
        super("Make a reservation");
        this.branchModels = branchModels;
        this.customerrModel = customer;
    }

    public void showFrame() {
        JPanel contentPane = new JPanel();

        this.setContentPane(contentPane);
        GridBagLayout gb = new GridBagLayout();
        GridBagConstraints c = new GridBagConstraints();
        contentPane.setLayout(gb);
        contentPane.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        contentPane.setBorder(BorderFactory.createTitledBorder(
                BorderFactory.createEtchedBorder(), "Make a reservation!"));

        // name
        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        customerNameLabel = new JLabel("Hi " + customerrModel.getName() + ". Good to see you again!");
        gb.setConstraints(customerNameLabel, c);
        contentPane.add(customerNameLabel);

        // driver's license
        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        customerDLicense = new JLabel("Driver's license");
        gb.setConstraints(customerDLicense, c);
        contentPane.add(customerDLicense);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        customerDLicenseTextLabel = new JLabel(Long.toString(customerrModel.getDlicense()));
        gb.setConstraints(customerDLicenseTextLabel, c);
        contentPane.add(customerDLicenseTextLabel);

        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        JLabel vehicleTypeLabel = new JLabel("Select one of the vehicle types");
        gb.setConstraints(vehicleTypeLabel, c);
        contentPane.add(vehicleTypeLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        String[] vehicleTypeString = VehicleType.getVtnames();
        dropdownMenuForVehicleType = new JComboBox<>(vehicleTypeString);
        gb.setConstraints(dropdownMenuForVehicleType, c);
        contentPane.add(dropdownMenuForVehicleType);

        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        locationLabel = new JLabel("Enter the location you want to look at");
        gb.setConstraints(locationLabel, c);
        contentPane.add(locationLabel);

        ArrayList<String> branchStrings = new ArrayList<>();

        for (BranchModel bm : branchModels) {
            branchStrings.add(bm.toString());
        }

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        dropdownMenuForBranch = new JComboBox<>(branchStrings.toArray(new String[branchStrings.size()]));
        gb.setConstraints(dropdownMenuForBranch, c);
        contentPane.add(dropdownMenuForBranch);

        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        fromDateLabel = new JLabel("Enter the date you want to rent from (in MM/DD/YYYY format)");
        gb.setConstraints(fromDateLabel, c);
        contentPane.add(fromDateLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        fromDateTextField = new JTextField();
        fromDateTextField.setColumns(TEXT_FIELD_WIDTH);
        gb.setConstraints(fromDateTextField, c);
        contentPane.add(fromDateTextField);

        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        toDateTextLabel = new JLabel("Enter the date you want to rent to (in MM/DD/YYYY format)");
        gb.setConstraints(toDateTextLabel, c);
        contentPane.add(toDateTextLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        toDateTextField = new JTextField();
        toDateTextField.setColumns(TEXT_FIELD_WIDTH);
        gb.setConstraints(toDateTextField, c);
        contentPane.add(toDateTextField);

        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        fromTimeLabel = new JLabel("Enter the time you want to rent from (in 24 hour HH:MM format)");
        gb.setConstraints(fromTimeLabel, c);
        contentPane.add(fromTimeLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        fromTimeTextField = new JTextField();
        fromTimeTextField.setColumns(TIME_FIELD_WIDTH);
        gb.setConstraints(fromTimeTextField, c);
        contentPane.add(fromTimeTextField);

        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        toTimeLabel = new JLabel("Enter the time you want to rent to (in 24 hour HH:MM format)");
        gb.setConstraints(toTimeLabel, c);
        contentPane.add(toTimeLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        toTimeTextField = new JTextField();
        toTimeTextField.setColumns(TIME_FIELD_WIDTH);

        gb.setConstraints(toTimeTextField, c);
        contentPane.add(toTimeTextField);

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

        String locationFinal;

        long dLicenseFinal;

        String fromDateFinal = "";
        String toDateFinal = "";

        Date fromDate;
        Date toDate;

        String fromTimeFinal = "00:00";
        String toTimeFinal = "00:00";

        String datePattern = "MM/dd/yyyy";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(datePattern);
        String timePattern = "^(0[0-9]|1[0-9]|2[0-3]|[0-9]):[0-5][0-9]";

        String dLicenseInput = customerDLicenseTextLabel.getText().trim();

        if (!dLicenseInput.isEmpty()) {
            if (Utility.isInteger(dLicenseInput)) {
                dLicenseFinal = Long.parseLong(dLicenseInput);
            } else {
                JOptionPane.showMessageDialog(this, "Your license is not a number! Try again");
                return;
            }
        } else {
            JOptionPane.showMessageDialog(this, "Your license can't be empty!");
            return;
        }

        String vehicleTypeString = (String) dropdownMenuForVehicleType.getSelectedItem();

        if (vehicleTypeString != null && vehicleTypeString.equals("NONE")) {
            JOptionPane.showMessageDialog(this, "You must select a vehicle type!");
            return;
        }

        String locationString = (String) dropdownMenuForBranch.getSelectedItem();
        locationFinal = locationString;

        // validate dates

        String fromDateString = fromDateTextField.getText().trim();

        if (!fromDateString.isEmpty()) {

            try {
                Date ret = simpleDateFormat.parse(fromDateString);
                fromDate = ret;
                if (simpleDateFormat.format(ret).equals(fromDateString)) {
                    fromDateFinal = fromDateString;
                }
            } catch (ParseException parseException) {
                JOptionPane.showMessageDialog(this, "From date format is not correct");
                return;
            }
        } else {
            JOptionPane.showMessageDialog(this, "From date can't be empty!");
            return;
        }

        String toDateString = toDateTextField.getText().trim();

        if (!toDateString.isEmpty()) {

            try {
                Date ret = simpleDateFormat.parse(toDateString);
                toDate = ret;
                if (simpleDateFormat.format(ret).equals(toDateString)) {
                    toDateFinal = toDateString;
                }
            } catch (ParseException parseException) {
                JOptionPane.showMessageDialog(this, "To date format is not correct");
                return;
            }
        } else {
            JOptionPane.showMessageDialog(this, "To date can't be empty!");
            return;
        }

        // check if the from Date if before to date

        if (fromDate != null && toDate != null && (!fromDate.equals(toDate) && !fromDate.before(toDate))) {
            JOptionPane.showMessageDialog(this, "From date must be before to date!");
            return;
        }

        // validate times

        String fromTimeString = fromTimeTextField.getText().trim();

        if (!fromTimeString.isEmpty()) {

            if (fromTimeString.matches(timePattern)) {
                fromTimeFinal = fromTimeString;
            } else {
                JOptionPane.showMessageDialog(this, "From time format is not correct");
                return;
            }
        }

        String toTimeString = toTimeTextField.getText().trim();

        if (!toTimeString.isEmpty()) {

            if (toTimeString.matches(timePattern)) {
                toTimeFinal = toTimeString;
            } else {
                JOptionPane.showMessageDialog(this, "To time format is not correct");
                return;
            }
        }

        // now, transform date + time into a timestamp

        Timestamp fromDateTimeStamp = new Timestamp(System.currentTimeMillis());
        Timestamp toDateTimeStamp = new Timestamp(System.currentTimeMillis());

        SimpleDateFormat simpleDateFormatWithTime = new SimpleDateFormat("MM/dd/yyyy, HH:mm");

        try {
            String combined = fromDateFinal + ", " + fromTimeFinal;
            Date date = simpleDateFormatWithTime.parse(combined);
            fromDateTimeStamp = new Timestamp(date.getTime());

        } catch (ParseException pe) {
            JOptionPane.showMessageDialog(this, "Something's wrong with the date you inserted. Try again");
            return;
        }

        try {
            String combined = toDateFinal + ", " + toTimeFinal;
            Date date = simpleDateFormatWithTime.parse(combined);
            toDateTimeStamp = new Timestamp(date.getTime());

        } catch (ParseException pe) {
            JOptionPane.showMessageDialog(this, "Something's wrong with the date you inserted. Try again");
            return;
        }

        ReservationModel reservationModel = new ReservationModel(-1, vehicleTypeString,
                Utility.getLocationFromBranchString(locationFinal).trim(), Utility.getCityFromBranchString(locationFinal).trim(),
                dLicenseFinal, fromDateTimeStamp, toDateTimeStamp);

        ReservationController reservationController = new ReservationController();

        try {
            ReservationModel returnedReservationModel = reservationController.makeReservation(reservationModel);
            ShowReservationDetails showReservationDetails = new ShowReservationDetails(customerrModel, returnedReservationModel);
            showReservationDetails.showFrame();
            closeWindow();
        } catch (EntryNotFoundException | SQLException exception) {
            JOptionPane.showMessageDialog(this, exception.getMessage());
        }
    }

    private void closeWindow() {
        MakeReservation.super.dispose();
    }
}
