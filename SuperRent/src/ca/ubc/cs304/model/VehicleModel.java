package ca.ubc.cs304.model;

/**
 * The intent for this class is to update/store information about a single vehicle
 */
public class VehicleModel {
    private long id;
    private String license;
    private String make;
    private String model;
    private int year;
    private String color;
    private int odometer;
    private String status;
    private String vt_name;
    private String location;
    private String city;

    public static final String AVAILABLE_STATUS = "available";
    public static final String RENTED_STATUS = "rented";
    public static final String MAINTENANCE_STATUS = "maintenance";

    public VehicleModel() {
    }

    public VehicleModel(long id, String license, String make, String model, int year, String color, int odometer, String status, String vt_name, String location, String city) {
        this.id = id;
        this.license = license;
        this.make = make;
        this.model = model;
        this.year = year;
        this.color = color;
        this.odometer = odometer;
        this.status = status;
        this.vt_name = vt_name;
        this.location = location;
        this.city = city;
    }

    public long getId() {
        return this.id;
    }


    public String getLicense() {
        return this.license;
    }


    public String getMake() {
        return this.make;
    }


    public String getModel() {
        return this.model;
    }


    public int getYear() {
        return this.year;
    }


    public String getColor() {
        return this.color;
    }


    public int getOdometer() {
        return this.odometer;
    }


    public String getStatus() {
        return this.status;
    }


    public String getVt_name() {
        return this.vt_name;
    }


    public String getLocation() {
        return this.location;
    }


    public String getCity() {
        return this.city;
    }

    @Override
    public String toString() {
        return "{" +
            " id='" + getId() + "'" +
            ", license='" + getLicense() + "'" +
            ", make='" + getMake() + "'" +
            ", model='" + getModel() + "'" +
            ", year='" + getYear() + "'" +
            ", color='" + getColor() + "'" +
            ", odometer='" + getOdometer() + "'" +
            ", status='" + getStatus() + "'" +
            ", vt_name='" + getVt_name() + "'" +
            ", location='" + getLocation() + "'" +
            ", city='" + getCity() + "'" +
            "}";
    }
}
