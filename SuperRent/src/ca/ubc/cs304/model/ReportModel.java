package ca.ubc.cs304.model;

import javax.swing.table.AbstractTableModel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

// model needed for rent and return reports
public class ReportModel extends AbstractTableModel {
    // queries needed:  get all vehicles which have rentals that were today, where timestamp includes date, regex?
    // get count of today's rentals, no group
    // get count of each today's rentals, group by branch
    // query for all branches

    private ArrayList<VehicleModel> vehicles;

    private HashMap<String, Integer> branchCounts; //all branches strings, counts for each branch

    public HashMap<String, Integer> categoryCounts; //all branches strings, counts for each branch

    private Integer globalCount;


    // where to display total vehicles rented across all branches?? top? sidebar or smth?
    private String[] columnNames = {"Total Global Rentals", "Branch", "Total Branch Rentals", "Vehicle Type Name", "Vehicles Rented Per Category", "Vehicle Id", "Vehicle license", "make", "model",
            "Year", "Colour", "Odometer"};

    public ReportModel(List<VehicleModel> vehicles, HashMap<String, Integer> branchCounts, HashMap<String, Integer> categoryCounts, Integer globalCount) {
        this.vehicles = new ArrayList<>(vehicles);
        this.branchCounts = new HashMap<>(branchCounts);
        this.categoryCounts = new HashMap<>(categoryCounts);
        this.globalCount = globalCount;
    }

    @Override
    public int getRowCount() {
        return vehicles.size();
    }

    @Override
    public String getColumnName(int index) {
        return columnNames[index];
    }

    @Override
    public int getColumnCount() {
        return 12;
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        Object value = null;
        VehicleModel vehicleModel = vehicles.get(rowIndex);
        switch (columnIndex) {
            case 0:
                if(rowIndex == 0){
                    value = globalCount;
                    break;
                }
                else{
                    value = "";
                    break;
                }
            case 1:
                value = vehicleModel.getLocation() + ", " + vehicleModel.getCity();
                break;
            case 2:
                value = branchCounts.get(vehicleModel.getLocation());
                break;
            case 3:
                value = vehicleModel.getVt_name();
                break;
            case 4:
                value = "";
                break;
            case 5:
                value = vehicleModel.getId();
                break;
            case 6:
                value = vehicleModel.getLicense();
                break;
            case 7:
                value = vehicleModel.getMake();
                break;
            case 8:
                value = vehicleModel.getModel();
                break;
            case 9:
                value = vehicleModel.getYear();
                break;
            case 10:
                value = vehicleModel.getColor();
                break;
            case 11:
                value = vehicleModel.getOdometer();
                break;
        }

        return value;
    }
}