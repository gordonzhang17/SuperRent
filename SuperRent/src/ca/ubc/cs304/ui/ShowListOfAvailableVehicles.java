package ca.ubc.cs304.ui;

import ca.ubc.cs304.model.VehicleModel;
import ca.ubc.cs304.model.VehicleTableModel;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.ArrayList;

public class ShowListOfAvailableVehicles extends JFrame implements ActionListener {

    private ArrayList<VehicleModel> vehicleModels;

    private JLabel numAvailableVehiclesLabel;

    private JButton closeButton;

    public ShowListOfAvailableVehicles(ArrayList<VehicleModel> vehicleModels) {
        super("List Available Vehicle Details");
        this.vehicleModels = vehicleModels;
    }

    public void showFrame() {

        JPanel contentPane = new JPanel();

        this.setContentPane(contentPane);
        GridBagLayout gb = new GridBagLayout();
        GridBagConstraints c = new GridBagConstraints();
        contentPane.setLayout(gb);
        contentPane.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        contentPane.setBorder(BorderFactory.createTitledBorder(
                BorderFactory.createEtchedBorder(), "List Available Details"));


        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(10, 0, 5, 10);

        if (vehicleModels.size() > 0) {
            numAvailableVehiclesLabel = new JLabel("There are: " + vehicleModels.size() + " available vehicles. Click the number of vehicles to see their details");
            numAvailableVehiclesLabel.addMouseListener(new MouseListener() {
                @Override
                public void mouseClicked(MouseEvent e) {

                    VehicleTableModel vehicleTableModel = new VehicleTableModel(vehicleModels);

                    AvailableVehiclePopup availableVehiclePopup = new AvailableVehiclePopup(vehicleTableModel);
                    availableVehiclePopup.showFrame();

                    closeWindow();

                }

                @Override
                public void mousePressed(MouseEvent e) {

                }

                @Override
                public void mouseReleased(MouseEvent e) {

                }

                @Override
                public void mouseEntered(MouseEvent e) {

                }

                @Override
                public void mouseExited(MouseEvent e) {

                }
            });
        } else {
            numAvailableVehiclesLabel = new JLabel("There are no available vehicles. Change the search to see vehicles");
            closeWindow();
            return;

        }

        gb.setConstraints(numAvailableVehiclesLabel, c);
        contentPane.add(numAvailableVehiclesLabel);

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
        ShowListOfAvailableVehicles.super.dispose();
    }

}
