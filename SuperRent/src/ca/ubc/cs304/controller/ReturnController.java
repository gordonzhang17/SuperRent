package ca.ubc.cs304.controller;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.error.EntryNotFoundException;
import ca.ubc.cs304.model.RentModel;
import ca.ubc.cs304.model.ReturnModel;
import ca.ubc.cs304.model.VehicleModel;
import ca.ubc.cs304.model.VehicleTypeModel;

public class ReturnController {

    public static final String INSERT_RENT = "INSERT INTO ret (rent_id, return_date, odometer, fullTank, cost) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_RETURN = "SELECT * FROM ret WHERE rent_id = ?";
    private DatabaseConnectionHandler db = null;
    private VehicleController vehicleController;
    private VehicleTypeController vehicleTypeController;

    public ReturnController() {
        this.db = DatabaseConnectionHandler.getInstance();
        this.vehicleController = new VehicleController();
        this.vehicleTypeController = new VehicleTypeController();
    }

    public ReturnModel returnVehicle(ReturnModel ret) throws EntryNotFoundException, SQLException {
        RentController rentController = new RentController();
        long rent_id = ret.getRent_id();
        RentModel rental = rentController.getRentById(rent_id);
        if (rental != null && !isReturned(ret)) {
            VehicleModel vehicle = vehicleController.getVehicleById(rental.getVehicle_id());
            VehicleTypeModel vtype = vehicleTypeController.getVehicleTypeByName(vehicle.getVt_name());
            double cost = ret.computeCost(rental, vtype);
            ret.setCost(cost);
            insertReturn(ret);
            vehicleController.updateReturnedVehicle(vehicle, ret);
            return ret;
        } else {
            throw new EntryNotFoundException("Error - Rental with ID: "+ret.getRent_id()+" not found.");
        }
    }

    public void insertReturn(ReturnModel ret) throws SQLException{
        PreparedStatement ps = db.getConnection().prepareStatement(INSERT_RENT);
        ps.setLong(1, ret.getRent_id());
        ps.setTimestamp(2, ret.getReturn_date());
        ps.setLong(3, ret.getOdometer());
        ps.setString(4, Character.toString(ret.getFullTank()));
        ps.setDouble(5, ret.getCost());
        ps.executeUpdate();
        ps.close();
    }

    public boolean isReturned(ReturnModel ret) throws EntryNotFoundException {
        try {
            PreparedStatement ps = db.getConnection().prepareStatement(SELECT_RETURN);
            ps.setLong(1, ret.getRent_id());
            ResultSet rs = ps.executeQuery();

            if (rs.next() == true) {
                ps.close();
                rs.close();
                throw new EntryNotFoundException("Error - Rental already returned");
            } else {
                ps.close();
                rs.close();
                return false;
            }
        } catch (SQLException e) {
            System.out.println("System error");
            return true;
        }
    }
}