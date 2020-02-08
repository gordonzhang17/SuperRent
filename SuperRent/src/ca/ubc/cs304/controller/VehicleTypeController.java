package ca.ubc.cs304.controller;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.error.EntryNotFoundException;
import ca.ubc.cs304.model.VehicleTypeModel;

public class VehicleTypeController {
        private static final String VTYPE_BY_NAME = "SELECT * FROM vehicle_type WHERE vtname = ?";

        public DatabaseConnectionHandler db = null;

        public VehicleTypeController() {
            this.db = DatabaseConnectionHandler.getInstance();
        }

        public VehicleTypeModel getVehicleTypeByName(String vtypeName) throws EntryNotFoundException, SQLException {
            VehicleTypeModel vehicleType = null;
            PreparedStatement ps = db.getConnection().prepareStatement(VTYPE_BY_NAME);
            ps.setString(1, vtypeName);
            ResultSet rs = ps.executeQuery();
            if (rs.next() == false) {
                throw new EntryNotFoundException("Error - No vehicle types found with name: "+vtypeName);
            } else {
                String vtname = rs.getString(1);
                String features = rs.getString(2);
                double weekly_rate = rs.getDouble(3);
                double daily_rate = rs.getDouble(4);
                double hourly_rate = rs.getDouble(5);
                double kilo_rate = rs.getDouble(6);
                double hourly_insurance_rate = rs.getDouble(7);
                double daily_insurance_rate = rs.getDouble(8);
                double weekly_insurance_rate = rs.getDouble(9);
                vehicleType =  new VehicleTypeModel(vtname, features, weekly_rate, daily_rate, hourly_rate, kilo_rate, hourly_insurance_rate, daily_insurance_rate, weekly_insurance_rate);
            }
            ps.close();
            rs.close();
            return vehicleType;
        }
}