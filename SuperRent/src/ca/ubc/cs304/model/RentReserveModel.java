package ca.ubc.cs304.model;

/**
 * The intent for this class is to update/store information about a single branch
 */
public class RentReserveModel {
    private long rent_id;
    private long reservation_confNo;


    public RentReserveModel() {
    }

    public RentReserveModel(long rent_id, long reservation_confNo) {
        this.rent_id = rent_id;
        this.reservation_confNo = reservation_confNo;
    }

    public long getRent_id() {
        return this.rent_id;
    }

    public void setRent_id(long rent_id) {
        this.rent_id = rent_id;
    }

    public long getReservation_confNo() {
        return this.reservation_confNo;
    }

    public void setReservation_confNo(long reservation_confNo) {
        this.reservation_confNo = reservation_confNo;
    }

    public RentReserveModel rent_id(long rent_id) {
        this.rent_id = rent_id;
        return this;
    }

    public RentReserveModel reservation_confNo(long reservation_confNo) {
        this.reservation_confNo = reservation_confNo;
        return this;
    }
}
