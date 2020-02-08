package ca.ubc.cs304.model;

public class Cost {

    private double weeklyCost;
    private double dailyCost;
    private double hourlyCost;
    private double weeklyInsuranceCost;
    private double dailyInsuranceCost;
    private double hourlyInsuranceCost;

    public Cost() {
    }

    public Cost(double weeklyCost, double dailyCost, double hourlyCost, double weeklyInsuranceCost, double dailyInsuranceCost, double hourlyInsuranceCost) {
        this.weeklyCost = weeklyCost;
        this.dailyCost = dailyCost;
        this.hourlyCost = hourlyCost;
        this.weeklyInsuranceCost = weeklyInsuranceCost;
        this.dailyInsuranceCost = dailyInsuranceCost;
        this.hourlyInsuranceCost = hourlyInsuranceCost;
    }

    public double getWeeklyCost() {
        return this.weeklyCost;
    }

    public void setWeeklyCost(double weeklyCost) {
        this.weeklyCost = weeklyCost;
    }

    public double getDailyCost() {
        return this.dailyCost;
    }

    public void setDailyCost(double dailyCost) {
        this.dailyCost = dailyCost;
    }

    public double getHourlyCost() {
        return this.hourlyCost;
    }

    public void setHourlyCost(double hourlyCost) {
        this.hourlyCost = hourlyCost;
    }

    public double getWeeklyInsuranceCost() {
        return this.weeklyInsuranceCost;
    }

    public void setWeeklyInsuranceCost(double weeklyInsuranceCost) {
        this.weeklyInsuranceCost = weeklyInsuranceCost;
    }

    public double getDailyInsuranceCost() {
        return this.dailyInsuranceCost;
    }

    public void setDailyInsuranceCost(double dailyInsuranceCost) {
        this.dailyInsuranceCost = dailyInsuranceCost;
    }

    public double getHourlyInsuranceCost() {
        return this.hourlyInsuranceCost;
    }

    public void setHourlyInsuranceCost(double hourlyInsuranceCost) {
        this.hourlyInsuranceCost = hourlyInsuranceCost;
    }

    public double computeCost(RentModel rent, VehicleTypeModel vtype, ReturnModel ret) {
        long rentalLengthMilliseconds = ret.getReturn_date().getTime() - rent.getFromDate().getTime();

        // Get number of weeks, days, hours, and minutes for duration of rental
        long diffWeeks = rentalLengthMilliseconds / (7 * 24 * 60 * 60 * 1000);
        rentalLengthMilliseconds %= (7 * 24 * 60 * 60 * 1000);
        long diffDays = rentalLengthMilliseconds / (24 * 60 * 60 * 1000);
        rentalLengthMilliseconds %= (24 * 60 * 60 * 1000);
        long diffHours = rentalLengthMilliseconds / (60 * 60 * 1000);
        rentalLengthMilliseconds %= (60 * 60 * 1000);
        long diffMinutes = rentalLengthMilliseconds / (60 * 1000);

        // TODO consider kilo_rate?
        return computeVehicleCost(vtype, diffWeeks, diffDays, diffHours, diffMinutes) + computeInsuranceCost(vtype, diffWeeks, diffDays, diffHours, diffMinutes);
    }

    private double computeVehicleCost(VehicleTypeModel vtype, long weeks, long days, long hours, long minutes) {
        weeklyCost = vtype.getWeekly_rate() * weeks;
        dailyCost = vtype.getDaily_rate() * days;
        hourlyCost = vtype.getHourly_rate() * (hours + (minutes > 0 ? 1 : 0));
        return  weeklyCost+ dailyCost + hourlyCost;
    }

    private double computeInsuranceCost(VehicleTypeModel vtype, long weeks, long days, long hours, long minutes) {
        weeklyInsuranceCost = vtype.getWeekly_insurance_rate() * weeks;
        dailyInsuranceCost = vtype.getDaily_insurance_rate() * days;
        hourlyInsuranceCost = vtype.getHourly_insurance_rate() * (hours + (minutes > 0 ? 1 : 0));
        return  weeklyInsuranceCost+ dailyInsuranceCost + hourlyInsuranceCost;
    }
}