package ca.ubc.cs304.model;

import javax.swing.table.AbstractTableModel;
import java.util.ArrayList;

public class VehicleTableModel extends AbstractTableModel {

//    private int id;
//    private String license;
//    private String make;
//    private String model;
//    private int year;
//    private String color;
//    private int odometer;
//    private String status;
//    private String vt_name;
//    private String location;
//    private String city;


    private ArrayList<VehicleModel> vehicleModels;
    private String[] columnNames = {"Vehicle Id", "Vehicle license", "make", "model",
            "Year", "Colour", "odometer", "status", "Vehicle Type name", "location", "city"};

    public VehicleTableModel(ArrayList<VehicleModel> vehicleModels) {
        this.vehicleModels = vehicleModels;
    }

    @Override
    public int getRowCount() {
        return vehicleModels.size();
    }

    @Override
    public int getColumnCount() {
        return 11;
    }

    @Override
    public Object getValueAt(int rowIndex, int columnIndex) {
        Object value = null;
        VehicleModel vehicleModel = vehicleModels.get(rowIndex);
        switch (columnIndex) {
            case 0:
                value = vehicleModel.getId();
                break;
            case 1:
                value = vehicleModel.getLicense();
                break;
            case 2:
                value = vehicleModel.getMake();
                break;
            case 3:
                value = vehicleModel.getModel();
                break;
            case 4:
                value = vehicleModel.getYear();
                break;
            case 5:
                value = vehicleModel.getColor();
                break;
            case 6:
                value = vehicleModel.getOdometer();
                break;
            case 7:
                value = vehicleModel.getStatus();
                break;
            case 8:
                value = vehicleModel.getVt_name();
                break;
            case 9:
                value = vehicleModel.getLocation();
                break;
            case 10:
                value = vehicleModel.getCity();
                break;
        }

        return value;
    }

    @Override
    public String getColumnName(int index) {
        return columnNames[index];
    }
}
