package ca.ubc.cs304.ui;

import ca.ubc.cs304.model.RentModel;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Timestamp;

public class MakeAndShowRentalDetails extends JFrame {

    private JLabel rentIdLabel;
    private JLabel vehicleIdLabel;

    private JLabel customerDLicenseLabel;
    private JLabel reservationConfirmationNumberLabel;
    private JLabel fromDateAndTimeLabel;
    private JLabel toDateAndTimeLabel;

    private JButton closeButton;

    private Long rentId;
    private Long customerDLicense;

    private Long reservationConfirmationNumber;
    private Long vehicleId;
    private Timestamp fromDateAndTime;
    private Timestamp toDateAndTime;


    public MakeAndShowRentalDetails(RentModel returnedRentModel) {
        super("Rental Details");

        rentId = returnedRentModel.getRent_id();
        customerDLicense = returnedRentModel.getDlicense();
        reservationConfirmationNumber = returnedRentModel.getReservation_confNo();
        vehicleId = returnedRentModel.getVehicle_id();
        fromDateAndTime = returnedRentModel.getFromDate();
        toDateAndTime = returnedRentModel.getToDate();
    }

    public void showFrame() {
        JPanel contentPane = new JPanel();

        this.setContentPane(contentPane);
        GridBagLayout gb = new GridBagLayout();
        GridBagConstraints c = new GridBagConstraints();
        contentPane.setLayout(gb);
        contentPane.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        contentPane.setBorder(BorderFactory.createTitledBorder(
                BorderFactory.createEtchedBorder(), "You are good to go! Here are your rental details!"));

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        rentIdLabel = new JLabel("Rental ID: " + rentId);
        gb.setConstraints(rentIdLabel, c);
        contentPane.add(rentIdLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        vehicleIdLabel = new JLabel("Vehicle Id: " + vehicleId);
        gb.setConstraints(vehicleIdLabel, c);
        contentPane.add(vehicleIdLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        customerDLicenseLabel = new JLabel("Customer Driver's license: " + customerDLicense.toString());
        gb.setConstraints(customerDLicenseLabel, c);
        contentPane.add(customerDLicenseLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        reservationConfirmationNumberLabel = new JLabel("Reservation Confirmation Number: " + reservationConfirmationNumber.toString());
        gb.setConstraints(reservationConfirmationNumberLabel, c);
        contentPane.add(reservationConfirmationNumberLabel);
        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        fromDateAndTimeLabel = new JLabel("From: " + fromDateAndTime.toLocalDateTime());
        gb.setConstraints(fromDateAndTimeLabel, c);
        contentPane.add(fromDateAndTimeLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        toDateAndTimeLabel = new JLabel("From: " + toDateAndTime.toLocalDateTime());
        gb.setConstraints(toDateAndTimeLabel, c);
        contentPane.add(toDateAndTimeLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        closeButton = new JButton("Close this window");
        closeButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                closeWindow();
            }
        });

        gb.setConstraints(closeButton, c);
        contentPane.add(closeButton);

        this.pack();

        Dimension d = this.getToolkit().getScreenSize();
        Rectangle r = this.getBounds();
        this.setLocation((d.width - r.width) / 2, (d.height - r.height) / 2);

        this.setVisible(true);

    }

    private void closeWindow() {
        MakeAndShowRentalDetails.super.dispose();
    }


}
