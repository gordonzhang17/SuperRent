package ca.ubc.cs304.ui;


import ca.ubc.cs304.controller.ReportController;
import ca.ubc.cs304.controller.VehicleController;
import ca.ubc.cs304.model.*;
import ca.ubc.cs304.utils.Utility;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;


public class EnterBranchForGenerateDailyRentalReport extends JFrame implements ActionListener {
    // components of the JFrame

    private JLabel locationLabel;
    private ArrayList<BranchModel> branchModels;
    private JComboBox<String> dropdownMenuForBranch;

    private JButton submitButton;

    public EnterBranchForGenerateDailyRentalReport(ArrayList<BranchModel> branchModels) {
        super("Generate Daily Rental Report");
        this.branchModels = branchModels;
    }

    public void showFrame() {

        JPanel contentPane = new JPanel();

        this.setContentPane(contentPane);
        GridBagLayout gb = new GridBagLayout();
        GridBagConstraints c = new GridBagConstraints();
        contentPane.setLayout(gb);
        contentPane.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        contentPane.setBorder(BorderFactory.createTitledBorder(
                BorderFactory.createEtchedBorder(), "Generate Daily Rental Report"));

        c.gridwidth = GridBagConstraints.RELATIVE;
        c.insets = new Insets(10, 10, 5, 0);
        locationLabel = new JLabel("Enter the location you want to look at");
        gb.setConstraints(locationLabel, c);
        contentPane.add(locationLabel);

        ArrayList<String> branchStrings = new ArrayList<>();

        branchStrings.add("All Branches");

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

        String locationFinal = "All Branches";
        switch ((String) dropdownMenuForBranch.getSelectedItem()) {
            case "NY - A":
                locationFinal = "A";
                break;
            case "Vancouver - B":
                locationFinal = "B";

                break;
            case "Montreal - C":
                locationFinal = "C";

                break;
            case "Chicago - D":
                locationFinal = "D";
                break;
        }
        ReportController reportController = new ReportController();

        Timestamp currentTimestamp = null;
        Timestamp dayTimestamp = null;


        try {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM/dd/yyyy, HH:mm");
            SimpleDateFormat noSeconds = new SimpleDateFormat("MM/dd/yyyy");

            Date date = new Date(System.currentTimeMillis());
            String currentDateString = simpleDateFormat.format(date);
            Date currentDate = simpleDateFormat.parse(currentDateString);
            Date noSecondsDate = noSeconds.parse(currentDateString);

            currentTimestamp = new Timestamp(currentDate.getTime());
            dayTimestamp = new Timestamp(noSecondsDate.getTime());

        } catch (ParseException pe) {

        }

        ReportModel reportModel;
        BranchReportModel branchReportModel;

        if (locationFinal.equals("All Branches")) {
            reportModel = reportController.getDailyRentalReport("ANY", currentTimestamp, dayTimestamp);
            ShowGeneratedDailyRentalReport showGeneratedDailyRentalReport = new ShowGeneratedDailyRentalReport(reportModel);
            showGeneratedDailyRentalReport.showFrame();
        } else {
            branchReportModel = reportController.getDailyRentalBranchReport(locationFinal, currentTimestamp, dayTimestamp);
            ShowGeneratedDailyRentalReport showGeneratedDailyRentalReport = new ShowGeneratedDailyRentalReport(branchReportModel);
            showGeneratedDailyRentalReport.showFrame();
        }
        closeWindow();

    }

    private void closeWindow() {
        EnterBranchForGenerateDailyRentalReport.super.dispose();
    }
}
