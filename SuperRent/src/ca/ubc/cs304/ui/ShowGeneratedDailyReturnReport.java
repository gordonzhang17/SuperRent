package ca.ubc.cs304.ui;

import ca.ubc.cs304.model.BranchReturnReportModel;
import ca.ubc.cs304.model.ReturnReportModel;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ShowGeneratedDailyReturnReport extends JFrame implements ActionListener {

    private  BranchReturnReportModel branchReturnReportModel;
    private  ReturnReportModel returnReportModel;
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

    public ShowGeneratedDailyReturnReport(BranchReturnReportModel branchReturnReportModel) {
        super("Daily return report");
        this.branchReturnReportModel = branchReturnReportModel;
    }

    public ShowGeneratedDailyReturnReport(ReturnReportModel returnReportModel) {
        super("Daily return report");
        this.returnReportModel = returnReportModel;
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
                BorderFactory.createEtchedBorder(), "Returned Vehicles"));

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        if (branchReturnReportModel != null) {
            table = new JTable(branchReturnReportModel);
        } else {
            table = new JTable(returnReportModel);
        }
        table.setBounds(30, 40, 500, 500);
        table.setRowHeight(30);

        table.getColumnModel().getColumn(0).setPreferredWidth(100);
        table.getColumnModel().getColumn(1).setPreferredWidth(100);
        table.getColumnModel().getColumn(2).setPreferredWidth(100);
        table.getColumnModel().getColumn(3).setPreferredWidth(100);
        table.getColumnModel().getColumn(4).setPreferredWidth(100);
        table.getColumnModel().getColumn(5).setPreferredWidth(100);
        table.getColumnModel().getColumn(6).setPreferredWidth(100);
        table.getColumnModel().getColumn(7).setPreferredWidth(100);
        table.getColumnModel().getColumn(8).setPreferredWidth(100);
        table.getColumnModel().getColumn(9).setPreferredWidth(100);
        table.getColumnModel().getColumn(11).setPreferredWidth(100);
        table.getColumnModel().getColumn(12).setPreferredWidth(100);


        table.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);

        JScrollPane scrollPane = new JScrollPane(table);
        gb.setConstraints(scrollPane, c);
        contentPane.add(scrollPane);
        if (returnReportModel != null) {
            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            economyCountLabel = new JLabel("Economy Count:" +  returnReportModel.categoryCounts.get("Economy") + "    Revenue: $" + returnReportModel.categoryRevenues.get("Economy"));
            gb.setConstraints(economyCountLabel, c);
            contentPane.add(economyCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            compactCountLabel = new JLabel("Compact Count:" +  returnReportModel.categoryCounts.get("Compact") +"    Revenue: $" + returnReportModel.categoryRevenues.get("Compact"));
            gb.setConstraints(compactCountLabel, c);
            contentPane.add(compactCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            midsizeCountLabel = new JLabel("Mid-size Count:" +  returnReportModel.categoryCounts.get("Mid-size") + "    Revenue: $" +returnReportModel.categoryRevenues.get("Mid-size"));
            gb.setConstraints(midsizeCountLabel, c);
            contentPane.add(midsizeCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            standardCountLabel = new JLabel("Standard Count:" +  returnReportModel.categoryCounts.get("Standard") + "    Revenue: $" +returnReportModel.categoryRevenues.get("Standard"));
            gb.setConstraints(standardCountLabel, c);
            contentPane.add(standardCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            fullsizeCountLabel = new JLabel("Full-size Count:" +  returnReportModel.categoryCounts.get("Full-size") +"    Revenue: $" + returnReportModel.categoryRevenues.get("Full-size"));
            gb.setConstraints(fullsizeCountLabel, c);
            contentPane.add(fullsizeCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            suvCountLabel = new JLabel("SUV Count: " +  returnReportModel.categoryCounts.get("SUV") + "    Revenue: $" +returnReportModel.categoryRevenues.get("SUV"));
            gb.setConstraints(suvCountLabel, c);
            contentPane.add(suvCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            truckCountLabel = new JLabel("Truck Count: " +  returnReportModel.categoryCounts.get("Truck") + "    Revenue: $" + returnReportModel.categoryRevenues.get("Truck"));
            gb.setConstraints(truckCountLabel, c);
            contentPane.add(truckCountLabel);
        }

        if (branchReturnReportModel != null) {
            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            economyCountLabel = new JLabel("Economy Count:" +  branchReturnReportModel.categoryCounts.get("Economy") + "    Revenue: $" + branchReturnReportModel.categoryRevenues.get("Economy"));
            gb.setConstraints(economyCountLabel, c);
            contentPane.add(economyCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            compactCountLabel = new JLabel("Compact Count:" +  branchReturnReportModel.categoryCounts.get("Compact") +"    Revenue: $" + branchReturnReportModel.categoryRevenues.get("Compact"));
            gb.setConstraints(compactCountLabel, c);
            contentPane.add(compactCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            midsizeCountLabel = new JLabel("Mid-size Count:" +  branchReturnReportModel.categoryCounts.get("Mid-size") + "    Revenue: $" +branchReturnReportModel.categoryRevenues.get("Mid-size"));
            gb.setConstraints(midsizeCountLabel, c);
            contentPane.add(midsizeCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            standardCountLabel = new JLabel("Standard Count:" +  branchReturnReportModel.categoryCounts.get("Standard") + "    Revenue: $" +branchReturnReportModel.categoryRevenues.get("Standard"));
            gb.setConstraints(standardCountLabel, c);
            contentPane.add(standardCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            fullsizeCountLabel = new JLabel("Full-size Count:" +  branchReturnReportModel.categoryCounts.get("Full-size") +"    Revenue: $" + + branchReturnReportModel.categoryRevenues.get("Full-size"));
            gb.setConstraints(fullsizeCountLabel, c);
            contentPane.add(fullsizeCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            suvCountLabel = new JLabel("SUV Count: " +  branchReturnReportModel.categoryCounts.get("SUV") + "    Revenue: $" +branchReturnReportModel.categoryRevenues.get("SUV"));
            gb.setConstraints(suvCountLabel, c);
            contentPane.add(suvCountLabel);

            c.gridwidth = GridBagConstraints.REMAINDER;
            c.insets = new Insets(10, 0, 5, 10);
            truckCountLabel = new JLabel("Truck Count: " +  branchReturnReportModel.categoryCounts.get("Truck") + "    Revenue: $" +branchReturnReportModel.categoryRevenues.get("Truck"));
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
        ShowGeneratedDailyReturnReport.super.dispose();
    }

}
