package ca.ubc.cs304.model;

/**
 * The intent for this class is to update/store information about a single branch
 */
public class BranchModel {
    private String location;
    private String city;

    public BranchModel() {
    }

    public BranchModel(String location, String city) {
        this.location = location;
        this.city = city;
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

    public BranchModel location(String location) {
        this.location = location;
        return this;
    }

    public BranchModel city(String city) {
        this.city = city;
        return this;
    }

    @Override
    public String toString() {
        return this.city + " - " + this.location;
    }
}
