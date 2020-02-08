package ca.ubc.cs304.controller;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.error.EntryNotFoundException;
import ca.ubc.cs304.model.RentModel;
import ca.ubc.cs304.model.RentReserveModel;
import ca.ubc.cs304.model.ReservationModel;
import ca.ubc.cs304.model.VehicleModel;

public class RentController {
    /* SQL QUERIES RELATED TO THE RENT TABLE */
    public static final String INSERT_RENT = "INSERT INTO RENT (rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardName, cardNo, expDate, reservation_confNo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    public static final String RENT_FROM_ID = "SELECT * FROM rent WHERE rent_id = ?";
    private static final String DELETE_RENT = "DELETE FROM rent where rent_id = ?";

    /* SINGLETON DATABASE CONNECTION */
    private DatabaseConnectionHandler db = null;

    public RentController() {
        this.db = DatabaseConnectionHandler.getInstance();
    }

    /**
     * @param rent
     * @return rent
     */
    public RentModel createRent(RentModel rent) throws SQLException, EntryNotFoundException {
        ReservationController rc = new ReservationController();
        long reservation_confNo = rent.getReservation_confNo();
        ReservationModel reservation = rc.getReservationByID(reservation_confNo);
        if (reservation != null) {
            VehicleController vc = new VehicleController();
            VehicleModel vehicle = vc.getAvailableVehicleFromReservation(reservation);
            if (vehicle == null) throw new EntryNotFoundException("Error - No available vehicles found"); // no available vehicles found

            rent.updateRentalWithVehicleReservation(reservation, vehicle);
            this.insertRental(rent);

            // create entry in rent reserve
            RentReserveController rrc = new RentReserveController();
            RentReserveModel rentReserve = new RentReserveModel(rent.getRent_id(), reservation_confNo);
            rrc.insertRentReserve(rentReserve);

            return rent;
        } else {
            throw new EntryNotFoundException("Error - no reservation found");
        }
    }

    /**
     * Retrieves rental by given ID, if not found returns null
     * else return RentModel object.
     *
     * @param rent_id
     * @return RentModel
     */
    public RentModel getRentById(long rent_id) throws SQLException, EntryNotFoundException {
        PreparedStatement ps = db.getConnection().prepareStatement(RENT_FROM_ID);
        ps.setLong(1, rent_id);
        ResultSet rs = ps.executeQuery();

        if (rs.next() == false) {
            ps.close();
            rs.close();
            throw new EntryNotFoundException("Error - no rentals found with ID: "+rent_id);
        } else {
            long vehicle_rent_id = rs.getLong(1);
            long vehicle_id = rs.getLong(2);
            long dlicense = rs.getLong(3);
            Timestamp fromDate = rs.getTimestamp(4);
            Timestamp toDate = rs.getTimestamp(5);
            int odometer = rs.getInt(6);
            String cardName = rs.getString(7);
            long cardNo = rs.getLong(8);
            String expDate = rs.getString(9);
            long reservation_confNo = rs.getLong(10);
            RentModel rent = new RentModel(vehicle_rent_id, vehicle_id, dlicense, fromDate, toDate, odometer, cardName, cardNo, expDate, reservation_confNo);

            ps.close();
            rs.close();
            return rent;
        }
    }

    public void deleteRentById(RentModel rent) {
        try {
            PreparedStatement ps = db.getConnection().prepareStatement(DELETE_RENT);
            ps.setLong(1, rent.getRent_id());
            ps.executeUpdate();
            db.getConnection().commit();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
            db.rollbackConnection();
        }
    }

    private void insertRental(RentModel rent) throws SQLException {
        PreparedStatement ps = db.getConnection().prepareStatement(INSERT_RENT);
        ps.setLong(1, rent.getRent_id());
        ps.setLong(2, rent.getVehicle_id());
        ps.setLong(3, rent.getDlicense());
        ps.setTimestamp(4, rent.getFromDate());
        ps.setTimestamp(5, rent.getToDate());
        ps.setInt(6, rent.getOdometer());
        ps.setString(7, rent.getCardName());
        ps.setLong(8, rent.getCardNo());
        ps.setString(9, rent.getExpDate());
        ps.setLong(10, rent.getReservation_confNo());
        ps.executeUpdate();
        db.getConnection().commit();
        ps.close();
    }

}