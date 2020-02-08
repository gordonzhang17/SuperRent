package ca.ubc.cs304.model;

import javax.swing.table.AbstractTableModel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

// model needed for rent and return reports
public class ReturnReportModel extends AbstractTableModel {
    // queries needed:  get all vehicles which have rentals that were today, where timestamp includes date, regex?
    // get count of today's rentals, no group
    // get count of each today's rentals, group by branch
    // query for all branches

    public ArrayList<VehicleModel> vehicles;

    public  HashMap<String, Integer> branchCounts; //all branches strings, counts for each branch
    public HashMap<String, Integer> branchRevenues;
    public HashMap<String, Integer> categoryCounts; //all branches strings, counts for each branch

    public ArrayList<Integer> costs;

    public HashMap<String, Integer> categoryRevenues;

    private Integer globalCost;


    // where to display total vehicles rented across all branches?? top? sidebar or smth?
    private String[] columnNames = {"Total Revenue", "Return Cost", "Branch", "Total Branch Returns", "Vehicle Category", "Branch Revenue", "Vehicle Id", "Vehicle license", "make", "model",
            "Year", "Colour", "Odometer"};

    public ReturnReportModel(List<VehicleModel> vehicles, List<Integer> costs, HashMap<String, Integer> branchCounts, HashMap<String, Integer> categoryCounts, HashMap<String, Integer> categoryRevenues, HashMap<String, Integer> branchRevenues, Integer globalCost) {
        this.vehicles = new ArrayList<>(vehicles);
        this.branchCounts = new HashMap<>(branchCounts);
        this.categoryCounts = new HashMap<>(categoryCounts);
        this.categoryRevenues = new HashMap<String, Integer>(categoryRevenues);
        this.costs = new ArrayList<Integer>(costs);
        this.globalCost = globalCost;
        this.branchRevenues = new HashMap<String, Integer>(branchRevenues);
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
        return 13;
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        Object value = null;
        VehicleModel vehicleModel = vehicles.get(rowIndex);
        Integer cost = costs.get(rowIndex);
        switch (columnIndex) {
            case 0:
                if(rowIndex == 0){
                    value = globalCost;
                    break;
                }
                else{
                    value = "";
                    break;
                }
            case 1:
                value = cost;
                break;
            case 2:
                value = vehicleModel.getLocation() + ", " + vehicleModel.getCity();
                break;
            case 3:
                value = branchCounts.get(vehicleModel.getLocation());
                break;
            case 4:
                value = vehicleModel.getVt_name();
                break;
            case 5:
                value = branchRevenues.get(vehicleModel.getLocation());
                break;
            case 6:
                value = vehicleModel.getId();
                break;
            case 7:
                value = vehicleModel.getLicense();
                break;
            case 8:
                value = vehicleModel.getMake();
                break;
            case 9:
                value = vehicleModel.getModel();
                break;
            case 10:
                value = vehicleModel.getYear();
                break;
            case 11:
                value = vehicleModel.getColor();
                break;
            case 12:
                value = vehicleModel.getOdometer();
                break;
        }

        return value;
    }
}