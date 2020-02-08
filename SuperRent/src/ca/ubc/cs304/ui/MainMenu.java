package ca.ubc.cs304.ui;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.swing.*;

import ca.ubc.cs304.controller.BranchController;
import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.delegates.LoginWindowDelegate;
import ca.ubc.cs304.error.EntryNotFoundException;
import ca.ubc.cs304.model.BranchModel;

/**
 * This is the main window that shows up once the program starts
 */
public class MainMenu extends JFrame {

    private JButton viewAvailableVehiclesButton;
    private JButton makeReservationButton;
    private JButton makeRentalButton;
    private JButton makeReturnButton;
    private JButton generateDailyRentalReportButton;
    private JButton generateDailyReturnReportButton;

    private MainMenu mainMenu = this;

    public MainMenu() {
        super("SuperRent Vehicle Rental");
    }

    public void showFrame() {

        JPanel contentPane = new JPanel();

        this.setContentPane(contentPane);
        GridBagLayout gb = new GridBagLayout();
        GridBagConstraints c = new GridBagConstraints();
        contentPane.setLayout(gb);
        contentPane.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        contentPane.setBorder(BorderFactory.createTitledBorder(
                BorderFactory.createEtchedBorder(), "Welcome to SuperRent Vehicle Rental. What would you like to do today?"));

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;


        viewAvailableVehiclesButton = new JButton("View the number of available vehicles");
        viewAvailableVehiclesButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    BranchController branchController = new BranchController();
                    ArrayList<BranchModel> branches = (ArrayList<BranchModel>) branchController.getBranches();
                    ViewAvailableVehicles viewAvailableVehicles = new ViewAvailableVehicles(branches);
                    if  (branches.size() > 0) {
                        viewAvailableVehicles.showFrame();
                    }

                } catch (SQLException sqlException) {
                    JOptionPane.showMessageDialog(mainMenu, sqlException.getMessage());
                    DatabaseConnectionHandler.getInstance().rollbackConnection();
                }
            }
        });

        gb.setConstraints(viewAvailableVehiclesButton, c);
        contentPane.add(viewAvailableVehiclesButton);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;

        makeReservationButton = new JButton("Make Reservation");
        makeReservationButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                EnterCustomerDLicense enterCustomerDLicenseWindow = new EnterCustomerDLicense();
                enterCustomerDLicenseWindow.showFrame();
            }
        });

        gb.setConstraints(makeReservationButton, c);
        contentPane.add(makeReservationButton);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;

        makeRentalButton = new JButton("Make Rental");
        makeRentalButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                MakeRental enterReservationConfirmationNumber = new MakeRental();
                enterReservationConfirmationNumber.showFrame();
            }
        });

        gb.setConstraints(makeRentalButton, c);
        contentPane.add(makeRentalButton);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;

        makeReturnButton = new JButton("Make a return");
        makeReturnButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                MakeReturn enterRentalId = new MakeReturn();
                enterRentalId.showFrame();
            }
        });

        gb.setConstraints(makeReturnButton, c);
        contentPane.add(makeReturnButton);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;

        generateDailyRentalReportButton = new JButton("Generate Daily Rental Report");
        BranchController branchController = new BranchController();

        try {
            ArrayList<BranchModel> branches = (ArrayList<BranchModel>) branchController.getBranches();
            generateDailyRentalReportButton.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    EnterBranchForGenerateDailyRentalReport enterBranchForGenerateDailyRentalReport = new EnterBranchForGenerateDailyRentalReport(branches);
                    enterBranchForGenerateDailyRentalReport.showFrame();
                }
            });
        } catch (SQLException sqlException) {
            JOptionPane.showMessageDialog(mainMenu, sqlException.getMessage());
            DatabaseConnectionHandler.getInstance().rollbackConnection();
        }

        gb.setConstraints(generateDailyRentalReportButton, c);
        contentPane.add(generateDailyRentalReportButton);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;

        generateDailyReturnReportButton = new JButton("Generate Daily Return Report");
        try {
            ArrayList<BranchModel> branches = (ArrayList<BranchModel>) branchController.getBranches();
            generateDailyReturnReportButton.addActionListener(new ActionListener() {
                @Override
                public void actionPerformed(ActionEvent e) {
                    EnterBranchForGenerateDailyReturnReport enterBranchForGenerateDailyReturnReport = new EnterBranchForGenerateDailyReturnReport(branches);
                    enterBranchForGenerateDailyReturnReport.showFrame();
                }
            });
        } catch (SQLException sqlException) {
            JOptionPane.showMessageDialog(mainMenu, sqlException.getMessage());
            DatabaseConnectionHandler.getInstance().rollbackConnection();
        }


        gb.setConstraints(generateDailyReturnReportButton, c);
        contentPane.add(generateDailyReturnReportButton);

        gb.setConstraints(generateDailyRentalReportButton, c);
        contentPane.add(generateDailyRentalReportButton);

        c.gridwidth = GridBagConstraints.REMAINDER;
        c.insets = new Insets(5, 10, 10, 10);
        c.anchor = GridBagConstraints.CENTER;


        this.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });

        Dimension d = this.getToolkit().getScreenSize();
        Rectangle r = this.getBounds();
        this.setLocation((d.width - r.width) / 2, (d.height - r.height) / 2);

        this.setSize(500, 300);

        this.setVisible(true);
    }

}
