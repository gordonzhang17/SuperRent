package ca.ubc.cs304.ui;

import ca.ubc.cs304.model.Cost;
import ca.ubc.cs304.model.ReservationModel;
import ca.ubc.cs304.model.ReturnModel;
import ca.ubc.cs304.model.VehicleType;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Date;
import java.text.DecimalFormat;

public class MakeAndShowReturnDetails extends JFrame {

    private ReturnModel returnModel;
    private ReservationModel reservationModel;

    private JLabel rentIdLabel;

    private JLabel reservationConfirmationNumberLabel;
    private JLabel fromDateAndTimeLabel;

    private JLabel odometerLabel;

    private JLabel dateOfReturnLabel;

    private JLabel weeklyCostLabel;
    private JLabel dailyCostLabel;
    private JLabel hourlyCostLabel;

    private JLabel weeklyInsuranceCostLabel;
    private JLabel dailyInsuranceCosLabel;
    private JLabel hourlyInsuranceCostLabel;

    private JLabel totalCostLabel;

    private JButton closeButton;

    public MakeAndShowReturnDetails(ReturnModel returnModel, ReservationModel reservationModel) {
        super("Return Details");
        this.returnModel = returnModel;
        this.reservationModel = reservationModel;
    }

    public void showFrame() {
        JPanel contentPane = new JPanel();

        this.setContentPane(contentPane);
        GridBagLayout gb = new GridBagLayout();
        GridBagConstraints c = new GridBagConstraints();
        contentPane.setLayout(gb);
        contentPane.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        contentPane.setBorder(BorderFactory.createTitledBorder(
                BorderFactory.createEtchedBorder(), "You are good to go! Here are your return details!"));

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        rentIdLabel = new JLabel("Rental ID: " + returnModel.getRent_id());
        gb.setConstraints(rentIdLabel, c);
        contentPane.add(rentIdLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        reservationConfirmationNumberLabel = new JLabel("Reservation Confirmation Number: " + reservationModel.getConfNo());
        gb.setConstraints(reservationConfirmationNumberLabel, c);
        contentPane.add(reservationConfirmationNumberLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        fromDateAndTimeLabel = new JLabel("From: " + reservationModel.getFromDate().toLocalDateTime());
        gb.setConstraints(fromDateAndTimeLabel, c);
        contentPane.add(fromDateAndTimeLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        dateOfReturnLabel = new JLabel("To: " + returnModel.getReturn_date().toLocalDateTime());
        gb.setConstraints(dateOfReturnLabel, c);
        contentPane.add(dateOfReturnLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        odometerLabel = new JLabel("Final odometer reading: " + returnModel.getOdometer());
        gb.setConstraints(odometerLabel, c);
        contentPane.add(odometerLabel);

        DecimalFormat df = new DecimalFormat("#.##");

        Cost cost = returnModel.getCostObject();

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        weeklyCostLabel = new JLabel("Calculated weekly cost: $" + df.format(cost.getWeeklyCost()));
        gb.setConstraints(weeklyCostLabel, c);
        contentPane.add(weeklyCostLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        dailyCostLabel = new JLabel("Calculated daily cost: $" + df.format(cost.getDailyCost()));
        gb.setConstraints(dailyCostLabel, c);
        contentPane.add(dailyCostLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        hourlyCostLabel = new JLabel("Calculated hourly cost: $" + df.format(cost.getHourlyCost()));
        gb.setConstraints(hourlyCostLabel, c);
        contentPane.add(hourlyCostLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        weeklyInsuranceCostLabel = new JLabel("Calculated weekly insurance cost: $" + df.format(cost.getWeeklyInsuranceCost()));
        gb.setConstraints(weeklyInsuranceCostLabel, c);
        contentPane.add(weeklyInsuranceCostLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        dailyInsuranceCosLabel = new JLabel("Calculated daily insurance cost: $" + df.format(cost.getDailyInsuranceCost()));
        gb.setConstraints(dailyInsuranceCosLabel, c);
        contentPane.add(dailyInsuranceCosLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        hourlyInsuranceCostLabel = new JLabel("Calculated hourly insurance cost: $" + df.format(cost.getHourlyInsuranceCost()));
        gb.setConstraints(hourlyInsuranceCostLabel, c);
        contentPane.add(hourlyInsuranceCostLabel);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 10, 5, 0);
        totalCostLabel = new JLabel("Total cost: $" + df.format(returnModel.getCost()));
        gb.setConstraints(totalCostLabel, c);
        contentPane.add(totalCostLabel);

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
        MakeAndShowReturnDetails.super.dispose();
    }
}
