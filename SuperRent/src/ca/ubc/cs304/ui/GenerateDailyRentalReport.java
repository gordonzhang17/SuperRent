package ca.ubc.cs304.ui;

import ca.ubc.cs304.model.ReportModel;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class GenerateDailyRentalReport extends JFrame implements ActionListener {

    private ReportModel reportModel;

    private JTable table;
    private JButton closeButton;

    public GenerateDailyRentalReport(ReportModel reportModel) {
        super("List Available Vehicle Details");
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
                BorderFactory.createEtchedBorder(), "Available Vehicles"));

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);
        table = new JTable(reportModel);
        table.setBounds(30, 40, 500, 500);
        JScrollPane scrollPane = new JScrollPane(table);
        gb.setConstraints(scrollPane, c);
        contentPane.add(scrollPane);

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
        GenerateDailyRentalReport.super.dispose();
    }

}
