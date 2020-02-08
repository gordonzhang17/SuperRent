package ca.ubc.cs304.model;

import java.sql.Timestamp;

public class ReturnModel {

    private long rent_id;
    private Timestamp return_date;
    private long odometer;
    private char fullTank;
    private double cost;
    private Cost costObject;

    public ReturnModel() {
    }

    public ReturnModel(long rent_id, Timestamp return_date, long odometer, char fullTank, double cost) {
        this.rent_id = rent_id;
        this.return_date = return_date;
        this.odometer = odometer;
        this.fullTank = fullTank;
        this.cost = cost;
        this.costObject = new Cost();
    }

    public double computeCost(RentModel rent, VehicleTypeModel vtype) {
        return costObject.computeCost(rent, vtype, this);
    }


    public long getRent_id() {
        return this.rent_id;
    }

    public void setRent_id(int rent_id) {
        this.rent_id = rent_id;
    }

    public Timestamp getReturn_date() {
        return this.return_date;
    }

    public void setReturn_date(Timestamp return_date) {
        this.return_date = return_date;
    }

    public long getOdometer() {
        return this.odometer;
    }

    public void setOdometer(int odometer) {
        this.odometer = odometer;
    }

    public char getFullTank() {
        return this.fullTank;
    }

    public void setFullTank(char fullTank) {
        this.fullTank = fullTank;
    }

    public double getCost() {
        return this.cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    public ReturnModel rent_id(int rent_id) {
        this.rent_id = rent_id;
        return this;
    }

    public ReturnModel return_date(Timestamp return_date) {
        this.return_date = return_date;
        return this;
    }

    public ReturnModel odomter(int odomter) {
        this.odometer = odomter;
        return this;
    }

    public ReturnModel fullTank(char fullTank) {
        this.fullTank = fullTank;
        return this;
    }

    public ReturnModel cost(double cost) {
        this.cost = cost;
        return this;
    }

    public Cost getCostObject() {
        return this.costObject;
    }
}