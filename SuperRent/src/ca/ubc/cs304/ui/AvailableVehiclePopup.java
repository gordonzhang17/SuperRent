package ca.ubc.cs304.ui;

import ca.ubc.cs304.model.VehicleTableModel;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
public class AvailableVehiclePopup extends JFrame implements ActionListener {

    private VehicleTableModel vehicleTableModel;

    private JTable table;

    private JButton closeButton;

    public AvailableVehiclePopup(VehicleTableModel vehicleTableModel) {
        super("List Available Vehicle Details");
        this.vehicleTableModel = vehicleTableModel;
    }

    public void showFrame() {

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
        table = new JTable(vehicleTableModel);
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

        table.setBounds(500, 500, 10000, 1000);
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
        AvailableVehiclePopup.super.dispose();
    }

}
