package ca.ubc.cs304.controller;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.error.EntryNotFoundException;
import ca.ubc.cs304.model.ReservationModel;
import ca.ubc.cs304.model.ReturnModel;
import ca.ubc.cs304.model.VehicleModel;

public class VehicleController {
    public static final String AVAILABLE_VEHICLE = "SELECT * FROM vehicle WHERE status = 'available' AND vtname = ? AND city = ? AND location = ?";
    public static final String VEHICLE_BY_ID = "SELECT * FROM vehicle WHERE id = ?";
    public static final String AVAILABLE_VEHICLE_BY_TYPE = "SELECT * FROM vehicle WHERE vtname = ? AND status = 'available'";
    public static final String AVAILABLE_VEHICLE_BY_BRANCH = "SELECT * FROM vehicle WHERE city = ? AND location = ? AND status = 'available'";
    public static final String AVAILABLE_VEHICLE_BY_TYPE_BRANCH = "SELECT * FROM vehicle WHERE vtname = ? AND city = ? AND location = ? AND status = 'available'";


    public static final String UPDATE_VEHICLE_STATUS = "UPDATE vehicle set status = ? WHERE id = ?";
    public static final String UPDATE_VEHICLE_STATUS_ODOMETER = "UPDATE vehicle set status = ?, odometer = ? WHERE id = ?";

    private DatabaseConnectionHandler db = null;

    public VehicleController() {
        this.db = DatabaseConnectionHandler.getInstance();
    }

    public VehicleModel getVehicleById(long vehicle_id) throws EntryNotFoundException, SQLException {
        VehicleModel vehicle = null;
        PreparedStatement ps = db.getConnection().prepareStatement(VEHICLE_BY_ID);
        ps.setLong(1, vehicle_id);
        ResultSet rs = ps.executeQuery();
        if (rs.next() == false) {
            ps.close();
            rs.close();
            throw new EntryNotFoundException("Error - Vehicle with ID: "+vehicle_id+" not found.");
        } else {
            vehicle = extractVehicle(rs);
        }
        ps.close();
        rs.close();
        return vehicle;
    }

    public void updateReturnedVehicle(VehicleModel vehicle, ReturnModel ret) throws SQLException {
        PreparedStatement ps = db.getConnection().prepareStatement(UPDATE_VEHICLE_STATUS_ODOMETER);
        ps.setString(1, VehicleModel.AVAILABLE_STATUS);
        ps.setLong(2, ret.getOdometer());
        ps.setLong(3, vehicle.getId());
        ps.executeUpdate();
        db.getConnection().commit();
        ps.close();
    }

    public List<VehicleModel> getAvailableVehiclesByLocation(String city, String location) throws SQLException {    
        List<VehicleModel> availableVehicles = new ArrayList<VehicleModel>();    
        PreparedStatement ps = db.getConnection().prepareStatement(AVAILABLE_VEHICLE_BY_BRANCH);
        ps.setString(1, city);
        ps.setString(2, location);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            VehicleModel vehicle = extractVehicle(rs);
            availableVehicles.add(vehicle);
        }
        ps.close();
        rs.close();
        return availableVehicles;
    }

    public List<VehicleModel> getAvailableVehiclesByTypeAndLocation(String vtname, String city, String location) throws SQLException {
        List<VehicleModel> availableVehicles = new ArrayList<VehicleModel>(); 
        PreparedStatement ps = db.getConnection().prepareStatement(AVAILABLE_VEHICLE_BY_TYPE_BRANCH);
        ps.setString(1, vtname);
        ps.setString(2, city);
        ps.setString(3, location);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            VehicleModel vehicle = extractVehicle(rs);
            availableVehicles.add(vehicle);
        }
        ps.close();
        rs.close();
        return availableVehicles;
    }

    public VehicleModel getAvailableVehicleFromReservation(ReservationModel reservation) throws SQLException, EntryNotFoundException {
        PreparedStatement ps = db.getConnection().prepareStatement(AVAILABLE_VEHICLE);
        ps.setString(1, reservation.getVtname());
        ps.setString(2, reservation.getCity());
        ps.setString(3, reservation.getLocation());
        ResultSet rs = ps.executeQuery();
        VehicleModel vehicle;
        if (rs.next() == false) {
            ps.close();
            rs.close();
            throw new EntryNotFoundException("Error - No available vehicles found");
        } else {
            vehicle = extractVehicle(rs);
        }
        ps.close();
        rs.close();
        return vehicle;
    }

    public void deleteVehicle() {
        return; // TODO
    }

    private VehicleModel extractVehicle(ResultSet result) throws SQLException {
        long id = result.getLong(1);
        String license = result.getString(2);
        String make = result.getString(3);
        String model = result.getString(4);
        int year = result.getInt(5);
        String color = result.getString(6);
        int odometer = result.getInt(7);
        String status = result.getString(8);
        String vt_name = result.getString(9);
        String location = result.getString(10);
        String city = result.getString(11);
        VehicleModel vehicle = new VehicleModel(id, license, make, model, year, color, odometer, status, vt_name, location, city);
        return vehicle;   
    }
}