package ca.ubc.cs304.ui;

import ca.ubc.cs304.model.CustomerrModel;
import ca.ubc.cs304.model.ReservationModel;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ShowReservationDetails extends JFrame {

    private CustomerrModel customerrModel;
    private ReservationModel reservationModel;

    private JLabel customerNameLabel;
    private JLabel customerAddressLabel;
    private JLabel customerDLicenseLabel;

    private JLabel reservationConfirmationNumberLabel;
    private JLabel vehicleTypeLabel;
    private JLabel fromDateAndTimeLabel;
    private JLabel toDateAndTimeLabel;

    private JButton closeButton;

    public ShowReservationDetails(CustomerrModel customerrModel, ReservationModel returnedReservationModel) {
        super("Reservation Details");
        this.customerrModel = customerrModel;
        this.reservationModel = returnedReservationModel;
    }

    public void showFrame() {
        JPanel contentPane = new JPanel();

        this.setContentPane(contentPane);
        GridBagLayout gb = new GridBagLayout();
        GridBagConstraints c = new GridBagConstraints();
        contentPane.setLayout(gb);
        contentPane.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        contentPane.setBorder(BorderFactory.createTitledBorder(
                BorderFactory.createEtchedBorder(), "Here are your reservation details!"));

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        customerNameLabel = new JLabel("Name: " + customerrModel.getName());
        gb.setConstraints(customerNameLabel, c);
        contentPane.add(customerNameLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        customerAddressLabel = new JLabel("Address: " + customerrModel.getAddress());
        gb.setConstraints(customerAddressLabel, c);
        contentPane.add(customerAddressLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        customerDLicenseLabel = new JLabel("Driver's license: " + customerrModel.getDlicense());
        gb.setConstraints(customerDLicenseLabel, c);
        contentPane.add(customerDLicenseLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        reservationConfirmationNumberLabel = new JLabel("Reservation Confirmation Number: " + reservationModel.getConfNo());
        gb.setConstraints(reservationConfirmationNumberLabel, c);
        contentPane.add(reservationConfirmationNumberLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        vehicleTypeLabel = new JLabel("Vehicle Type chosen: " + reservationModel.getVtname());
        gb.setConstraints(vehicleTypeLabel, c);
        contentPane.add(vehicleTypeLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        fromDateAndTimeLabel = new JLabel("From: " + reservationModel.getFromDate().toLocalDateTime());
        gb.setConstraints(fromDateAndTimeLabel, c);
        contentPane.add(fromDateAndTimeLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        toDateAndTimeLabel = new JLabel("To: " + reservationModel.getToDate().toLocalDateTime());
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
        ShowReservationDetails.super.dispose();
    }
}
