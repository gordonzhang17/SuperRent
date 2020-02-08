package ca.ubc.cs304.ui;

import ca.ubc.cs304.model.BranchReportModel;
import ca.ubc.cs304.model.ReportModel;
import ca.ubc.cs304.model.VehicleTableModel;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ShowGeneratedDailyRentalReport extends JFrame implements ActionListener {

    private BranchReportModel branchReportModel;
    private ReportModel reportModel;

    private JLabel economyCountLabel;
    private JLabel compactCountLabel;
    private JLabel midsizeCountLabel;
    private JLabel standardCountLabel;
    private JLabel fullsizeCountLabel;
    private JLabel suvCountLabel;
    private JLabel truckCountLabel;

    private JTable table;

    private JButton closeButton;
    private int TEXT_FIELD_WIDTH = 20;

    public ShowGeneratedDailyRentalReport(BranchReportModel branchReportModel) {
        super("Daily rental report");
        this.branchReportModel = branchReportModel;
    }

    public ShowGeneratedDailyRentalReport(ReportModel reportModel) {
        super("Daily rental report");
        this.reportModel = reportModel;
    }

    public void showFrame() {
        // this.delegate = delegate;

        JPanel contentPane = new JPanel();

        this.setContentPane(contentPane);
        GridBagLayout gb = new GridBagLayout();
        GridBagConstraints c = new GridBagConstraints();
        contentPane.setLayout(gb);
        contentPane.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        contentPane.setBorder(BorderFactory.createTitledBorder(
                BorderFactory.createEtchedBorder(), "Rented Vehicles"));

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        if (branchReportModel != null) {
            table = new JTable(branchReportModel);
        } else {
            table = new JTable(reportModel);
        }
        table.setBounds(30, 40, 500, 500);

        table.setRowHeight(30);

        table.getColumnModel().getColumn(0).setPreferredWidth(100);
        table.getColumnModel().getColumn(1).setPreferredWidth(100);
        table.getColumnModel().getColumn(2).setPreferredWidth(100);
        table.getColumnModel().getColumn(3).setPreferredWidth(100);
        table.getColumnModel().getColumn(4).setPreferredWidth(100);
        table.getColumnModel().getColumn(6).setPreferredWidth(100);
        table.getColumnModel().getColumn(7).setPreferredWidth(100);
        table.getColumnModel().getColumn(8).setPreferredWidth(100);
        table.getColumnModel().getColumn(9).setPreferredWidth(100);
        table.getColumnModel().getColumn(10).setPreferredWidth(100);

        table.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
        JScrollPane scrollPane = new JScrollPane(table);
        gb.setConstraints(scrollPane, c);
        contentPane.add(scrollPane);

        if (reportModel != null) {
            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            economyCountLabel = new JLabel("Economy Rented:" +  reportModel.categoryCounts.get("Economy"));
            gb.setConstraints(economyCountLabel, c);
            contentPane.add(economyCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            compactCountLabel = new JLabel("Compact Rented:" +  reportModel.categoryCounts.get("Compact"));
            gb.setConstraints(compactCountLabel, c);
            contentPane.add(compactCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            midsizeCountLabel = new JLabel("Mid-size Rented:" +  reportModel.categoryCounts.get("Mid-size"));
            gb.setConstraints(midsizeCountLabel, c);
            contentPane.add(midsizeCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            standardCountLabel = new JLabel("Standard Rented:" +  reportModel.categoryCounts.get("Standard"));
            gb.setConstraints(standardCountLabel, c);
            contentPane.add(standardCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            fullsizeCountLabel = new JLabel("Full-size Rented:" +  reportModel.categoryCounts.get("Full-size"));
            gb.setConstraints(fullsizeCountLabel, c);
            contentPane.add(fullsizeCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            suvCountLabel = new JLabel("SUV Rented :" +  reportModel.categoryCounts.get("SUV"));
            gb.setConstraints(suvCountLabel, c);
            contentPane.add(suvCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            truckCountLabel = new JLabel("Truck Rented: " +  reportModel.categoryCounts.get("Truck"));
            gb.setConstraints(truckCountLabel, c);
            contentPane.add(truckCountLabel);
        }

        if (branchReportModel != null) {
            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            economyCountLabel = new JLabel("Economy Rented:" +  branchReportModel.categoryCounts.get("Economy"));
            gb.setConstraints(economyCountLabel, c);
            contentPane.add(economyCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            compactCountLabel = new JLabel("Compact Rented:" +  branchReportModel.categoryCounts.get("Compact"));
            gb.setConstraints(compactCountLabel, c);
            contentPane.add(compactCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            midsizeCountLabel = new JLabel("Mid-size Rented:" +  branchReportModel.categoryCounts.get("Mid-size"));
            gb.setConstraints(midsizeCountLabel, c);
            contentPane.add(midsizeCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            standardCountLabel = new JLabel("Standard Rented:" +  branchReportModel.categoryCounts.get("Standard"));
            gb.setConstraints(standardCountLabel, c);
            contentPane.add(standardCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            fullsizeCountLabel = new JLabel("Full-size Rented:" +  branchReportModel.categoryCounts.get("Full-size"));
            gb.setConstraints(fullsizeCountLabel, c);
            contentPane.add(fullsizeCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            suvCountLabel = new JLabel("SUV Rented: " +  branchReportModel.categoryCounts.get("SUV"));
            gb.setConstraints(suvCountLabel, c);
            contentPane.add(suvCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            truckCountLabel = new JLabel("Truck Rented: " +  branchReportModel.categoryCounts.get("Truck"));
            gb.setConstraints(truckCountLabel, c);
            contentPane.add(truckCountLabel);
        }

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        closeButton = new JButton("Close window");
        gb.setConstraints(closeButton, c);
        contentPane.add(closeButton);
        closeButton.addActionListener(this);

        this.pack();

        Dimension d = this.getToolkit().getScreenSize();
        Rectangle r = this.getBounds();
        this.setLocation((d.width - r.width) / 2, (d.height - r.height) / 2);

        this.setVisible(true);

    }

    @Override
    public void actionPerformed(ActionEvent e) {
        closeWindow();
    }

    private void closeWindow() {
        ShowGeneratedDailyRentalReport.super.dispose();
    }

}
