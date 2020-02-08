package ca.ubc.cs304.controller;


import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.error.EntryNotFoundException;
import ca.ubc.cs304.model.RentReserveModel;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RentReserveController {

    private final String RENT_RESERVE_BY_RENT = "SELECT * from rent_reserve WHERE rent_id = ?";
    private final String RENT_RESERVE_BY_RESERVE = "SELECT * FROM rent_reserve WHERE reservation_confNo = ?";
    private final String INSERT_RENTRESERVE = "INSERT INTO rent_reserve (rent_id, reservation_confNo) VALUES (?, ?)";


    private DatabaseConnectionHandler db;


    public RentReserveController() {
        db = DatabaseConnectionHandler.getInstance();
    }


    public RentReserveModel getRentReserveByRentID(long rent_id) throws EntryNotFoundException, SQLException {
        PreparedStatement ps = db.getConnection().prepareStatement(RENT_RESERVE_BY_RENT);
        ps.setLong(1, rent_id);
        ResultSet rs = ps.executeQuery();
        if (rs.next() == false) {
            ps.close();
            rs.close();
            throw new EntryNotFoundException("Error - No rent-reserve relations found with rent ID: "+rent_id);
        } else {
            long r_id = rs.getLong(1);
            long reservationConfNo = rs.getLong(2);
            ps.close();
            rs.close();
            return new RentReserveModel(r_id, reservationConfNo);
        }

    }

    public RentReserveModel getRentReserveByReservationConfNo(long reservation_confNo) throws EntryNotFoundException, SQLException {
        PreparedStatement ps = db.getConnection().prepareStatement(RENT_RESERVE_BY_RESERVE);
        ps.setLong(1, reservation_confNo);
        ResultSet rs = ps.executeQuery();
        if (rs.next() == false) {
            ps.close();
            rs.close();
            throw new EntryNotFoundException("Error - No rent-reserve relations found with reservation number: "+reservation_confNo);
        } else {
            long r_id = rs.getLong(1);
            long reservationConfNo = rs.getLong(2);
            ps.close();
            rs.close();
            return new RentReserveModel(r_id, reservationConfNo);
        }
    }

    public void insertRentReserve(RentReserveModel rentReserve) throws SQLException {
        PreparedStatement ps = db.getConnection().prepareStatement(INSERT_RENTRESERVE);
        ps.setLong(1, rentReserve.getRent_id());
        ps.setLong(2, rentReserve.getReservation_confNo());
        ps.executeUpdate();
        db.getConnection().commit();
        ps.close();
    }
}
