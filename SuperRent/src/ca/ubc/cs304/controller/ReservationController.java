package ca.ubc.cs304.controller;

import java.sql.*;
import java.util.List;

import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.error.EntryNotFoundException;
import ca.ubc.cs304.model.ReservationModel;
import ca.ubc.cs304.model.VehicleModel;
import ca.ubc.cs304.utils.Utility;

public class ReservationController {
    private static final String INSERT_RESERVATION = "INSERT INTO reservation (confNo, vtname, location, city, dlicense, fromDate, toDate) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String RESERVATION_BY_ID = "SELECT * FROM reservation WHERE confNo = ?";
    private DatabaseConnectionHandler db = null;
    private VehicleController vehicleController;

    public ReservationController() {
        this.db = DatabaseConnectionHandler.getInstance();
        vehicleController = new VehicleController();
    }

    public ReservationModel makeReservation(ReservationModel reservation) throws EntryNotFoundException, SQLException {
        List<VehicleModel> availableVehicles = vehicleController.getAvailableVehiclesByTypeAndLocation(reservation.getVtname(), reservation.getCity(), reservation.getLocation());
        if (availableVehicles.isEmpty()) throw new EntryNotFoundException("Error - No available vehicles found");
        long reservationID = Utility.generateID();
        reservation.setConfNo(reservationID);
        insertReservation(reservation);
        return reservation;
    }

    public void insertReservation(ReservationModel reservation) throws SQLException {
        PreparedStatement ps = this.db.getConnection().prepareStatement(INSERT_RESERVATION);
        ps.setLong(1, reservation.getConfNo());
        ps.setString(2, reservation.getVtname());
        ps.setString(3, reservation.getLocation());
        ps.setString(4, reservation.getCity());
        ps.setLong(5, reservation.getDlicense());
        ps.setTimestamp(6, reservation.getFromDate());
        ps.setTimestamp(7, reservation.getToDate());
        ps.executeUpdate();
        db.getConnection().commit();
        ps.close();
    }

    public ReservationModel getReservationByID(long reservation_confNo) throws EntryNotFoundException, SQLException {
        PreparedStatement ps = this.db.getConnection().prepareStatement(RESERVATION_BY_ID);
        ps.setLong(1, reservation_confNo);
        ResultSet result = ps.executeQuery();
        if (result.next() == false) {
            ps.close();
            result.close();
            throw new EntryNotFoundException("Error - No reservations found with ID: " + reservation_confNo);
        } else {
            long confNo = result.getLong(1);
            String vtName = result.getString(2);
            String location = result.getString(3);
            String city = result.getString(4);
            long dlicense = result.getLong(5);
            Timestamp fromDate = result.getTimestamp(6);
            Timestamp toDate = result.getTimestamp(7);
            ReservationModel reservation = new ReservationModel(confNo, vtName, location, city, dlicense, fromDate, toDate);
            ps.close();
            result.close();
            return reservation;
        }
    }
}