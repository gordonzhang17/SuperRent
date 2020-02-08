package ca.ubc.cs304.model;

/**
 * The intent for this class is to update/store information about a single vehicle type
 */
public class VehicleTypeModel {
    private String vtname;
    private String features;
    private double weekly_rate;
    private double daily_rate;
    private double hourly_rate;
    private double kilo_rate;
    private double hourly_insurance_rate;
    private double daily_insurance_rate;
    private double weekly_insurance_rate;


    public VehicleTypeModel() {
    }

    public VehicleTypeModel(String vtname, String features, double weekly_rate, double daily_rate, double hourly_rate, double kilo_rate, double hourly_insurance_rate, double daily_insurance_rate, double weekly_insurance_rate) {
        this.vtname = vtname;
        this.features = features;
        this.weekly_rate = weekly_rate;
        this.daily_rate = daily_rate;
        this.hourly_rate = hourly_rate;
        this.kilo_rate = kilo_rate;
        this.hourly_insurance_rate = hourly_insurance_rate;
        this.daily_insurance_rate = daily_insurance_rate;
        this.weekly_insurance_rate = weekly_insurance_rate;
    }

    public String getVtname() {
        return this.vtname;
    }

    public void setVtname(String vtname) {
        this.vtname = vtname;
    }

    public String getFeatures() {
        return this.features;
    }

    public void setFeatures(String features) {
        this.features = features;
    }

    public double getWeekly_rate() {
        return this.weekly_rate;
    }

    public void setWeekly_rate(double weekly_rate) {
        this.weekly_rate = weekly_rate;
    }

    public double getDaily_rate() {
        return this.daily_rate;
    }

    public void setDaily_rate(double daily_rate) {
        this.daily_rate = daily_rate;
    }

    public double getHourly_rate() {
        return this.hourly_rate;
    }

    public void setHourly_rate(double hourly_rate) {
        this.hourly_rate = hourly_rate;
    }

    public double getKilo_rate() {
        return this.kilo_rate;
    }

    public void setKilo_rate(double kilo_rate) {
        this.kilo_rate = kilo_rate;
    }

    public double getHourly_insurance_rate() {
        return this.hourly_insurance_rate;
    }

    public void setHourly_insurance_rate(double hourly_insurance_rate) {
        this.hourly_insurance_rate = hourly_insurance_rate;
    }

    public double getDaily_insurance_rate() {
        return this.daily_insurance_rate;
    }

    public void setDaily_insurance_rate(double daily_insurance_rate) {
        this.daily_insurance_rate = daily_insurance_rate;
    }

    public double getWeekly_insurance_rate() {
        return this.weekly_insurance_rate;
    }

    public void setWeekly_insurance_rate(double weekly_insurance_rate) {
        this.weekly_insurance_rate = weekly_insurance_rate;
    }

    public VehicleTypeModel vtname(String vtname) {
        this.vtname = vtname;
        return this;
    }

    public VehicleTypeModel features(String features) {
        this.features = features;
        return this;
    }

    public VehicleTypeModel weekly_rate(double weekly_rate) {
        this.weekly_rate = weekly_rate;
        return this;
    }

    public VehicleTypeModel daily_rate(double daily_rate) {
        this.daily_rate = daily_rate;
        return this;
    }

    public VehicleTypeModel hourly_rate(double hourly_rate) {
        this.hourly_rate = hourly_rate;
        return this;
    }

    public VehicleTypeModel kilo_rate(double kilo_rate) {
        this.kilo_rate = kilo_rate;
        return this;
    }

    public VehicleTypeModel hourly_insurance_rate(double hourly_insurance_rate) {
        this.hourly_insurance_rate = hourly_insurance_rate;
        return this;
    }

    public VehicleTypeModel daily_insurance_rate(double daily_insurance_rate) {
        this.daily_insurance_rate = daily_insurance_rate;
        return this;
    }

    public VehicleTypeModel weekly_insurance_rate(double weekly_insurance_rate) {
        this.weekly_insurance_rate = weekly_insurance_rate;
        return this;
    }
}
