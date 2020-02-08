package ca.ubc.cs304.model;

import java.sql.Timestamp;
import java.util.Date;

/**
 * The intent for this class is to update/store information about a single reservation
 */

public class ReservationModel {

    private long confNo;
    private String vtname;
    private String location;
    private String city;
    private long dlicense;
    private Timestamp fromDate;
    private Timestamp toDate;

    public ReservationModel(long confNo, String vtname, String location, String city, long dlicense, Timestamp fromDate, Timestamp toDate) {
        this.confNo = confNo;
        this.vtname = vtname;
        this.location = location;
        this.city = city;
        this.dlicense = dlicense;
        this.fromDate = fromDate;
        this.toDate = toDate;
    }

    public long getConfNo() {
        return this.confNo;
    }

    public void setConfNo(long confNo) {
        this.confNo = confNo;
    }

    public String getVtname() {
        return this.vtname;
    }

    public void setVtname(String vtname) {
        this.vtname = vtname;
    }

    public String getLocation() {
        return this.location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getCity() {
        return this.city;
    }

    public void setCity(String city) {
        this.city = city;
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

    public ReservationModel confNo(int confNo) {
        this.confNo = confNo;
        return this;
    }

    public ReservationModel vtname(String vtname) {
        this.vtname = vtname;
        return this;
    }

    public ReservationModel location(String location) {
        this.location = location;
        return this;
    }

    public ReservationModel city(String city) {
        this.city = city;
        return this;
    }

    public ReservationModel dlicense(int dlicense) {
        this.dlicense = dlicense;
        return this;
    }

    public ReservationModel fromDate(Timestamp fromDate) {
        this.fromDate = fromDate;
        return this;
    }

    public ReservationModel toDate(Timestamp toDate) {
        this.toDate = toDate;
        return this;
    }
}

