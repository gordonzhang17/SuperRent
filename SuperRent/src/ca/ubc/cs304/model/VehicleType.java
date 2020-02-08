package ca.ubc.cs304.model;


/**
 * Valid vehicleTypes
 */


public enum VehicleType {
    None("None"),
    Economy("Economy"),
    Compact("Compact"),
    Midsize("Mid-size"),
    Standard("Standard"),
    Fullsize("Full-size"),
    SUV("SUV"),
    Truck("Truck");

    private final String vtname;

    VehicleType(String vtname) {
        this.vtname = vtname;
    }

    @Override
    public String toString() {
        return this.vtname;
    }

    public static String[] getVtnames() {
        String[] names = new String[8];
        int idx = 0;
        for (VehicleType v: VehicleType.values()) {
            names[idx] = v.toString();
            idx++;
        }
        return names;
    }


}