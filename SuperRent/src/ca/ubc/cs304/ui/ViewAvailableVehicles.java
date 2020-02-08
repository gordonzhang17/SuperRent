package ca.ubc.cs304.ui;

import ca.ubc.cs304.controller.ReservationController;
import ca.ubc.cs304.controller.VehicleController;
import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.model.BranchModel;
import ca.ubc.cs304.model.ReservationModel;
import ca.ubc.cs304.model.VehicleModel;
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

public class ViewAvailableVehicles extends JFrame implements ActionListener {

    private JComboBox<String> dropdownMenuForVehicleType;

    private JLabel locationLabel;

    // dummy data for branch dropdown:

    private ArrayList<BranchModel> branchModels;
    private JComboBox<String> dropdownMenuForBranch;

//    private JLabel fromDateLabel;
//    private JTextField fromDateTextField;
//
//    private JLabel toDateTextLabel;
//    private JTextField toDateTextField;
//
//    private JLabel fromTimeLabel;
//    private JTextField fromTimeTextField;
//
//    private JLabel toTimeLabel;
//    private JTextField toTimeTextField;

    private JButton submitButton;

    public ViewAvailableVehicles(ArrayList<BranchModel> branchModels) {
        super("View Available Vehicles");
        this.branchModels = branchModels;

        if (branchModels.size() < 1) {
            JOptionPane.showMessageDialog(this, "There are no branches to view.");
            closeWindow();
        }
    }

    public void showFrame() {
        JPanel contentPane = new JPanel();

        this.setContentPane(contentPane);
        GridBagLayout gb = new GridBagLayout();
        GridBagConstraints c = new GridBagConstraints();
        contentPane.setLayout(gb);
        contentPane.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        contentPane.setBorder(BorderFactory.createTitledBorder(
                BorderFactory.createEtchedBorder(), "View Available Vehicles"));

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

//        String fromDateFinal = null;
//        String toDateFinal = null;
//
//        Date fromDate = null;
//        Date toDate = null;
//
//        String fromTimeFinal = null;
//        String toTimeFinal = null;

        String vehicleTypeString = (String) dropdownMenuForVehicleType.getSelectedItem(); // this is guaranteed to be one of the valid vehicle types

//        String datePattern = "dd/MM/yyyy";
//        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(datePattern);
//        String timePattern = "^(0[0-9]|1[0-9]|2[0-3]|[0-9]):[0-5][0-9]";
//
//        System.out.println(vehicleTypeString);
//
//        if (vehicleTypeString.equals("NONE")) {
//            // they didn't select or don't want a vehicle type, set the string to null
//            vehicleTypeString = null;
//        }

        String locationFinal = (String) dropdownMenuForBranch.getSelectedItem();
//
//        // validate dates
//
//        String fromDateString = fromDateTextField.getText().trim();
//
//        if (!fromDateString.isEmpty()) {
//
//            try {
//                Date ret = simpleDateFormat.parse(fromDateString);
//                fromDate = ret;
//                if (simpleDateFormat.format(ret).equals(fromDateString)) {
//                    fromDateFinal = fromDateString;
//                }
//            } catch (ParseException parseException) {
//                JOptionPane.showMessageDialog(this, "From date format is not correct");
//                return;
//            }
//        }
//
//        String toDateString = toDateTextField.getText().trim();
//
//        if (!toDateString.isEmpty()) {
//
//            try {
//                Date ret = simpleDateFormat.parse(toDateString);
//                toDate = ret;
//                if (simpleDateFormat.format(ret).equals(toDateString)) {
//                    toDateFinal = toDateString;
//                }
//            } catch (ParseException parseException) {
//                JOptionPane.showMessageDialog(this, "To date format is not correct");
//                return;
//            }
//        }
//        // check if the from Date if before to date (same day is fine)
//
//        if (fromDate != null && toDate != null && (!fromDate.equals(toDate) && !fromDate.before(toDate))) {
//            JOptionPane.showMessageDialog(this, "From date must be before to date!");
//            return;
//        }
//
//        // validate times
//
//        String fromTimeString = fromTimeTextField.getText().trim();
//
//        if (!fromTimeString.isEmpty()) {
//
//            if (fromTimeString.matches(timePattern)) {
//                fromTimeFinal = fromTimeString;
//            } else {
//                JOptionPane.showMessageDialog(this, "From time format is not correct");
//                return;
//            }
//        }
//
//        String toTimeString = toTimeTextField.getText().trim();
//
//        if (!toTimeString.isEmpty()) {
//
//            if (toTimeString.matches(timePattern)) {
//                toTimeFinal = toTimeString;
//            } else {
//                JOptionPane.showMessageDialog(this, "To time format is not correct");
//                return;
//            }
//        }
//
//        try {
//
//            Timestamp fromDateWithTime = null;
//
//            if (fromTimeFinal != null && fromDateFinal != null) {
//                SimpleDateFormat simpleDateTimeWithTime = new SimpleDateFormat("MM/dd/yyyy, HH:mm");
//                Date temp = simpleDateTimeWithTime.parse(fromDateFinal + ", " + fromTimeFinal);
//                fromDateWithTime = new java.sql.Timestamp(temp.getTime());
//            } else if (fromDateFinal != null) {
//                SimpleDateFormat simpleDateTimeWithTime = new SimpleDateFormat("MM/dd/yyyy");
//                Date temp = simpleDateTimeWithTime.parse(fromDateFinal);
//                fromDateWithTime = new java.sql.Timestamp(temp.getTime());
//            }
//
//            Timestamp toDateWithTime = null;
//
//            if (toTimeFinal != null && toDateFinal != null) {
//                SimpleDateFormat simpleDateTimeWithTime = new SimpleDateFormat("MM/dd/yyyy, HH:mm");
//                Date temp = simpleDateTimeWithTime.parse(toDateFinal + ", " + toTimeFinal);
//                toDateWithTime = new java.sql.Timestamp(temp.getTime());
//            } else if (toDateFinal != null) {
//                SimpleDateFormat simpleDateTimeWithTime = new SimpleDateFormat("MM/dd/yyyy");
//                Date temp = simpleDateTimeWithTime.parse(fromDateFinal);
//                toDateWithTime = new java.sql.Timestamp(temp.getTime());
//            }

        VehicleController vehicleController = new VehicleController();
        ArrayList<VehicleModel> returnedVehicleModels;

        if (vehicleTypeString.equals("None")) {
            try {
                returnedVehicleModels = (ArrayList<VehicleModel>) vehicleController.getAvailableVehiclesByLocation(Utility.getCityFromBranchString(locationFinal).trim(), Utility.getLocationFromBranchString(locationFinal).trim());
                ShowListOfAvailableVehicles showListOfAvailableVehicles = new ShowListOfAvailableVehicles(returnedVehicleModels);
                showListOfAvailableVehicles.showFrame();
            } catch (SQLException sqlException) {
                JOptionPane.showMessageDialog(this, sqlException.getMessage());
                DatabaseConnectionHandler.getInstance().rollbackConnection();
                return;
            }
        } else {
            try {
                returnedVehicleModels = (ArrayList<VehicleModel>) vehicleController.getAvailableVehiclesByTypeAndLocation(vehicleTypeString, Utility.getCityFromBranchString(locationFinal).trim(), Utility.getLocationFromBranchString(locationFinal).trim());
                ShowListOfAvailableVehicles showListOfAvailableVehicles = new ShowListOfAvailableVehicles(returnedVehicleModels);
                showListOfAvailableVehicles.showFrame();
            } catch (SQLException sqlException) {
                JOptionPane.showMessageDialog(this, sqlException.getMessage());
                DatabaseConnectionHandler.getInstance().rollbackConnection();
            }
        }
        closeWindow();

    }

    private void closeWindow() {
        ViewAvailableVehicles.super.dispose();
    }
}
