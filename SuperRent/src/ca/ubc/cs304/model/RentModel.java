package ca.ubc.cs304.model;

import java.sql.Timestamp;

import ca.ubc.cs304.utils.Utility;

public class RentModel {
    private long rent_id;
    private long vehicle_id;
    private long dlicense;
    private Timestamp fromDate;
    private Timestamp toDate;
    private int odometer;
    private String cardName;
    private long cardNo;
    private String expDate;
    private long reservation_confNo;


    public RentModel() {
    }

    public RentModel(long rent_id, long vehicle_id, long dlicense, Timestamp fromDate, Timestamp toDate, int odometer, String cardName, long cardNo, String expDate, long reservation_confNo) {
        this.rent_id = rent_id;
        this.vehicle_id = vehicle_id;
        this.dlicense = dlicense;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.odometer = odometer;
        this.cardName = cardName;
        this.cardNo = cardNo;
        this.expDate = expDate;
        this.reservation_confNo = reservation_confNo;
    }

    public RentModel updateRentalWithVehicleReservation(ReservationModel reservation, VehicleModel vehicle) {
        this.rent_id = Utility.generateID();
        this.vehicle_id = vehicle.getId();
        this.fromDate = reservation.getFromDate();
        this.toDate = reservation.getToDate();
        this.dlicense = reservation.getDlicense();
        this.odometer = vehicle.getOdometer();
        return this;
    }

    public long getRent_id() {
        return this.rent_id;
    }

    public void setRent_id(long rent_id) {
        this.rent_id = rent_id;
    }

    public long getVehicle_id() {
        return this.vehicle_id;
    }

    public void setVehicle_id(long vehicle_id) {
        this.vehicle_id = vehicle_id;
    }

    public long getDlicense() {
        return this.dlicense;
    }

    public void setDlicense(long dlicense) {
        this.dlicense = dlicense;
    }

    public Timestamp getFromDate() {
        return this.fromDate;
    }

    public void setFromDate(Timestamp fromDate) {
        this.fromDate = fromDate;
    }

    public Timestamp getToDate() {
        return this.toDate;
    }

    public void setToDate(Timestamp toDate) {
        this.toDate = toDate;
    }

    public int getOdometer() {
        return this.odometer;
    }

    public void setOdometer(int odometer) {
        this.odometer = odometer;
    }

    public String getCardName() {
        return this.cardName;
    }

    public void setCardName(String cardName) {
        this.cardName = cardName;
    }

    public long getCardNo() {
        return this.cardNo;
    }

    public void setCardNo(int cardNo) {
        this.cardNo = cardNo;
    }

    public String getExpDate() {
        return this.expDate;
    }

    public void setExpDate(String expDate) {
        this.expDate = expDate;
    }

    public long getReservation_confNo() {
        return this.reservation_confNo;
    }

    public void setReservation_confNo(long reservation_confNo) {
        this.reservation_confNo = reservation_confNo;
    }

    public RentModel rent_id(int rent_id) {
        this.rent_id = rent_id;
        return this;
    }

    public RentModel vehicle_id(int vehicle_id) {
        this.vehicle_id = vehicle_id;
        return this;
    }

    public RentModel dlicense(int dlicense) {
        this.dlicense = dlicense;
        return this;
    }

    public RentModel fromDate(Timestamp fromDate) {
        this.fromDate = fromDate;
        return this;
    }

    public RentModel toDate(Timestamp toDate) {
        this.toDate = toDate;
        return this;
    }

    public RentModel odometer(int odometer) {
        this.odometer = odometer;
        return this;
    }

    public RentModel cardName(String cardName) {
        this.cardName = cardName;
        return this;
    }

    public RentModel cardNo(int cardNo) {
        this.cardNo = cardNo;
        return this;
    }

    public RentModel expDate(String expDate) {
        this.expDate = expDate;
        return this;
    }

    public RentModel reservation_confNo(int reservation_confNo) {
        this.reservation_confNo = reservation_confNo;
        return this;
    }
}