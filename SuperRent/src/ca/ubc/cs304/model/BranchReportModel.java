package ca.ubc.cs304.model;

import ca.ubc.cs304.model.VehicleModel;

import javax.swing.table.AbstractTableModel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

// model needed for rent and return reports for specific branches
public class BranchReportModel extends AbstractTableModel {

    // queries needed:  get all vehicles which have rentals that were today, where timestamp includes date, regex?
    // get count of today's rentals, no group
    // get count of each today's rentals, group by branch
    // query for all branches

    private ArrayList<VehicleModel> vehicles;

    public HashMap<String, Integer> categoryCounts; //all branches strings, counts for each branch

    private Integer branchCount;

    private String[] columnNames = {"Total Branch Rentals", "Branch", "Vehicle Type Name", "Vehicles Rented Per Category", "Vehicle Id", "Vehicle license", "make", "model",
            "Year", "Colour", "Odometer"};

    public BranchReportModel(List<VehicleModel> vehicles, HashMap<String, Integer> categoryCounts, Integer branchCount) {
        this.vehicles = new ArrayList<>(vehicles);
        this.categoryCounts = new HashMap<>(categoryCounts);
        this.branchCount = branchCount;
    }
    @Override
    public String getColumnName(int index) {
        return columnNames[index];
    }
    @Override
    public int getRowCount() {
        return vehicles.size();
    }

    @Override
    public int getColumnCount() {
        return 11;
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        Object value = null;
        VehicleModel vehicleModel = vehicles.get(rowIndex);
        switch (columnIndex) {
            case 0:
                if(rowIndex == 0){
                    value = branchCount;
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
                value = vehicleModel.getVt_name();
                break;
            case 3:
                value = categoryCounts.get(vehicleModel.getVt_name());
                break;
            case 4:
                value = vehicleModel.getId();
                break;
            case 5:
                value = vehicleModel.getLicense();
                break;
            case 6:
                value = vehicleModel.getMake();
                break;
            case 7:
                value = vehicleModel.getModel();
                break;
            case 8:
                value = vehicleModel.getYear();
                break;
            case 9:
                value = vehicleModel.getColor();
                break;
            case 10:
                value = vehicleModel.getOdometer();
                break;
        }

        return value;
    }
}