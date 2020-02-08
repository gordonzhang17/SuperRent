package ca.ubc.cs304.controller;

import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.model.BranchModel;
import ca.ubc.cs304.model.BranchReportModel;
import ca.ubc.cs304.model.ReportModel;
import ca.ubc.cs304.model.VehicleModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ReportController {

    private DatabaseConnectionHandler db = null;

    private static final String COUNT_VEHICLES_RENTED_TODAY_BY_VTYPE =
            "select count(*) from vehicle v where v.vtname = ? AND v.location = ? AND exists (select * from rent r where r.vehicle_id = v.id AND r.fromDate <= ? AND r.fromDate >= ?)";
    private static final String ALL_COUNT_VEHICLES_RENTED_TODAY_BY_VTYPE =
            "select count(*) from vehicle v where v.vtname = ? AND exists (select * from rent r where r.vehicle_id = v.id AND r.fromDate <= ? AND r.fromDate >= ?)";

    private static final String COUNT_VEHICLES_RETURNED_TODAY_BY_VTYPE =
            "select count(*) from vehicle v WHERE v.vtname = ? AND v.location = ? AND exists (select * from ret rt where rt.return_date <= ? AND rt.return_date >= ? AND exists (select * from rent r where r.rent_id = rt.rent_id AND r.vehicle_id = v.id))";
    private static final String ALL_COUNT_VEHICLES_RETURNED_TODAY_BY_VTYPE =
            "select count(*) from vehicle v WHERE v.vtname = ? AND exists (select * from ret rt where rt.return_date <= ? AND rt.return_date >= ? AND exists (select * from rent r where r.rent_id = rt.rent_id AND r.vehicle_id = v.id))";

    private static final String GET_BRANCHES = "select * from branch";

    private static final String VEHICLES_WITH_RENTALS_TODAY = "select * from vehicle v where v.location = ? AND exists (select * from rent r where r.vehicle_id = v.id AND r.fromDate <= ? AND r.fromDate >= ?) order by v.location, v.vtname";
    private static final String ALL_VEHICLES_WITH_RENTALS_TODAY = "select * from vehicle v where exists (select * from rent r where r.vehicle_id = v.id AND r.fromDate <= ? AND r.fromDate >= ?) order by v.location, v.vtname";

    private static final String COUNT_VEHICLES_RENTED_TODAY =
            "select count(*) from vehicle v where v.location = ? AND exists (select * from rent r where r.vehicle_id = v.id AND r.fromDate <= ? AND r.fromDate >= ?)";
    private static final String ALL_COUNT_VEHICLES_RENTED_TODAY =
            "select count(*) from vehicle v where exists (select * from rent r where r.vehicle_id = v.id AND r.fromDate <= ? AND r.fromDate >= ?)";

    private static final String VEHICLES_WITH_RETURNS_TODAY=
            "select * from vehicle v where v.location = ? AND exists (select * from ret rt where rt.return_date <= ? AND rt.return_date >= ? AND exists (select * from rent r where r.rent_id = rt.rent_id AND r.vehicle_id = v.id)) order by v.location, v.vtname";
    private static final String ALL_VEHICLES_WITH_RETURNS_TODAY =
            "select * from vehicle v where exists (select * from ret rt where rt.return_date <= ? AND rt.return_date >= ? AND exists (select * from rent r where r.rent_id = rt.rent_id AND r.vehicle_id = v.id)) order by v.location, v.vtname";

    private static final String COUNT_VEHICLES_RETURNED_TODAY=
            "select count(*) from vehicle v where v.location = ? AND exists (select * from ret rt where rt.return_date <= ? AND rt.return_date >= ? AND exists (select * from rent r where r.rent_id = rt.rent_id AND r.vehicle_id = v.id))";
    private static final String ALL_COUNT_VEHICLES_RETURNED_TODAY=
            "select count(*) from vehicle v where exists (select * from ret rt where rt.return_date <= ? AND rt.return_date >= ? AND exists (select * from rent r where r.rent_id = rt.rent_id AND r.vehicle_id = v.id))";
    public ReportController() {
        this.db = DatabaseConnectionHandler.getInstance();
    }

    public ReportModel getDailyRentalReport(String location, Timestamp ts, Timestamp ds) {

        List<VehicleModel> availableVehicles = new ArrayList<VehicleModel>();
        ArrayList<BranchModel> branches = new ArrayList<BranchModel>();

        HashMap<String, Integer> branchCounts = new HashMap<String, Integer>();
        HashMap<String, Integer> categoryCounts = new HashMap<String, Integer>();


        ArrayList<String> categories = new ArrayList<String>();
        categories.add("Economy"); categories.add("Compact"); categories.add("Mid-size"); categories.add("Standard"); categories.add("Full-size");categories.add("SUV"); categories.add("Truck");

        Integer globalCount = 0;

        try {
            // get branches
            PreparedStatement ps = db.getConnection().prepareStatement(GET_BRANCHES);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                branches.add(extractBranch(rs));
            }

            // vehicles
            PreparedStatement ps1 = db.getConnection().prepareStatement(ALL_VEHICLES_WITH_RENTALS_TODAY);
            ps1.setTimestamp(1, ts);
            ps1.setTimestamp(2, ds);


            ResultSet rs1 = ps1.executeQuery();
            while (rs1.next()) {
                availableVehicles.add(extractVehicle(rs1));
            }

            // regular report
            // count of vehicles per branch
            for(int i = 0; i<branches.size(); i++) {
                PreparedStatement ps2 = db.getConnection().prepareStatement(COUNT_VEHICLES_RENTED_TODAY);
                ps2.setString(1, branches.get(i).getLocation());
                ps2.setTimestamp(2, ts);
                ps2.setTimestamp(3, ds);
                ResultSet rs2 = ps2.executeQuery();
                while (rs2.next()) {
                    branchCounts.put(branches.get(i).getLocation(), rs2.getInt(1));
                }
            }
            PreparedStatement ps3 = db.getConnection().prepareStatement(ALL_COUNT_VEHICLES_RENTED_TODAY);
            ps3.setTimestamp(1, ts);
            ps3.setTimestamp(2, ds);

            ResultSet rs3 = ps3.executeQuery();
            while (rs3.next()) {
                globalCount = rs3.getInt(1);
            }

            // get category counts
            for(int i = 0; i<categories.size(); i++) {
                PreparedStatement ps4 = db.getConnection().prepareStatement(ALL_COUNT_VEHICLES_RENTED_TODAY_BY_VTYPE);
                ps4.setString(1, categories.get(i));
                ps4.setTimestamp(2, ts);
                ps4.setTimestamp(3, ds);

                ResultSet rs4 = ps4.executeQuery();
                while (rs4.next()) {
                    categoryCounts.put(categories.get(i), rs4.getInt(1));
                }
            }

            ReportModel report = new ReportModel(availableVehicles, branchCounts, categoryCounts, globalCount);
            return report;

        } catch (SQLException e) {
            return null;
            // TODO handle SQLexception
        }
    }

    public BranchReportModel getDailyRentalBranchReport(String location, Timestamp ts, Timestamp ds) {
        Integer branchCount = 0;
        List<VehicleModel> availableVehicles = new ArrayList<>();
        ArrayList<BranchModel> branches = new ArrayList<>();
        HashMap<String, Integer> categoryCounts = new HashMap<>();
        ArrayList<String> categories = new ArrayList<>();
        categories.add("Economy"); categories.add("Compact"); categories.add("Mid-size"); categories.add("Standard"); categories.add("Full-size");categories.add("SUV"); categories.add("Truck");

        try {
            // get branches
            PreparedStatement ps = db.getConnection().prepareStatement(GET_BRANCHES);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                branches.add(extractBranch(rs));
            }

            // vehicles
            PreparedStatement ps1 = db.getConnection().prepareStatement(VEHICLES_WITH_RENTALS_TODAY);
            ps1.setString(1, location);
            ps1.setTimestamp(2, ts);
            ps1.setTimestamp(3, ds);

            ResultSet rs1 = ps1.executeQuery();
            while (rs1.next()) {
                availableVehicles.add(extractVehicle(rs1));
            }

            // if branch report
            PreparedStatement ps2 = db.getConnection().prepareStatement(COUNT_VEHICLES_RENTED_TODAY);
            ps2.setString(1, location);
            ps2.setTimestamp(2, ts);
            ps2.setTimestamp(3, ds);

            ResultSet rs2 = ps2.executeQuery();
            while (rs2.next()) {
                branchCount = rs2.getInt(1);
            }


            // get category counts
            for(int i = 0; i<categories.size(); i++) {
                PreparedStatement ps4 = db.getConnection().prepareStatement(COUNT_VEHICLES_RENTED_TODAY_BY_VTYPE);
                ps4.setString(1, categories.get(i));
                ps4.setString(2, location);
                ps4.setTimestamp(3, ts);
                ps4.setTimestamp(4, ds);

                ResultSet rs4 = ps4.executeQuery();
                while (rs4.next()) {
                    categoryCounts.put(categories.get(i), rs4.getInt(1));
                }
            }
            BranchReportModel report = new BranchReportModel(availableVehicles, categoryCounts, branchCount);
            return report;

        } catch (SQLException e) {
            return null;
            // TODO handle SQLexception
        }
    }

    public ReportModel getDailyReturnReport(String location, Timestamp ts, Timestamp ds) throws SQLException {

        List<VehicleModel> availableVehicles = new ArrayList<VehicleModel>();
        ArrayList<BranchModel> branches = new ArrayList<BranchModel>();

        HashMap<String, Integer> branchCounts = new HashMap<String, Integer>();
        HashMap<String, Integer> categoryCounts = new HashMap<String, Integer>();


        ArrayList<String> categories = new ArrayList<String>();
        categories.add("Economy"); categories.add("Compact"); categories.add("Mid-size"); categories.add("Standard"); categories.add("Full-size");categories.add("SUV"); categories.add("Truck");

        Integer globalCount = 0;

        try {
            // get branches
            PreparedStatement ps = db.getConnection().prepareStatement(GET_BRANCHES);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                branches.add(extractBranch(rs));
            }

            // vehicles
            PreparedStatement ps1 = db.getConnection().prepareStatement(ALL_VEHICLES_WITH_RETURNS_TODAY);
            ps1.setTimestamp(1, ts);
            ps1.setTimestamp(2, ds);


            ResultSet rs1 = ps1.executeQuery();
            while (rs1.next()) {
                availableVehicles.add(extractVehicle(rs1));
            }

            // regular report
            // count of vehicles per branch
            for(int i = 0; i<branches.size(); i++) {
                PreparedStatement ps2 = db.getConnection().prepareStatement(COUNT_VEHICLES_RETURNED_TODAY);
                ps2.setString(1, branches.get(i).getLocation());
                ps2.setTimestamp(2, ts);
                ps2.setTimestamp(3, ds);
                ResultSet rs2 = ps2.executeQuery();
                while (rs2.next()) {
                    branchCounts.put(branches.get(i).getLocation(), rs2.getInt(1));
                }
            }
            PreparedStatement ps3 = db.getConnection().prepareStatement(ALL_COUNT_VEHICLES_RETURNED_TODAY);
            ps3.setTimestamp(1, ts);
            ps3.setTimestamp(2, ds);
            ResultSet rs3 = ps3.executeQuery();
            while (rs3.next()) {
                globalCount = rs3.getInt(1);

            }


            // get category counts
            for(int i = 0; i<categories.size(); i++) {
                PreparedStatement ps4 = db.getConnection().prepareStatement(ALL_COUNT_VEHICLES_RETURNED_TODAY_BY_VTYPE);
                ps4.setString(1, categories.get(i));
                ps4.setTimestamp(2, ts);
                ps4.setTimestamp(3, ds);

                ResultSet rs4 = ps4.executeQuery();
                while (rs4.next()) {
                    categoryCounts.put(categories.get(i), rs4.getInt(1));
                }
            }

            ReportModel report = new ReportModel(availableVehicles, branchCounts, categoryCounts, globalCount);
            return report;

        } catch (SQLException e) {
            return null;
            // TODO handle SQLexception
        }
    }

    public BranchReportModel getDailyReturnBranchReport(String location, Timestamp ts, Timestamp ds) {
        Integer branchCount = 0;
        List<VehicleModel> availableVehicles = new ArrayList<>();
        ArrayList<BranchModel> branches = new ArrayList<>();
        HashMap<String, Integer> categoryCounts = new HashMap<>();
        ArrayList<String> categories = new ArrayList<>();
        categories.add("Economy"); categories.add("Compact"); categories.add("Mid-size"); categories.add("Standard"); categories.add("Full-size");categories.add("SUV"); categories.add("Truck");

        try {
            // get branches
            PreparedStatement ps = db.getConnection().prepareStatement(GET_BRANCHES);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                branches.add(extractBranch(rs));
            }

            // vehicles
            PreparedStatement ps1 = db.getConnection().prepareStatement(VEHICLES_WITH_RETURNS_TODAY);
            ps1.setString(1, location);
            ps1.setTimestamp(2, ts);
            ps1.setTimestamp(3, ds);
            ResultSet rs1 = ps1.executeQuery();
            while (rs1.next()) {
                availableVehicles.add(extractVehicle(rs1));
            }

            // if branch report
            PreparedStatement ps2 = db.getConnection().prepareStatement(COUNT_VEHICLES_RETURNED_TODAY);
            ps2.setString(1, location);
            ps2.setTimestamp(2, ts);
            ps2.setTimestamp(3, ds);
            ResultSet rs2 = ps2.executeQuery();
            while (rs2.next()) {
                branchCount = rs2.getInt(1);
            }


            // get category counts
            for(int i = 0; i<categories.size(); i++) {
                PreparedStatement ps4 = db.getConnection().prepareStatement(COUNT_VEHICLES_RETURNED_TODAY_BY_VTYPE);
                ps4.setString(1, categories.get(i));
                ps4.setString(2, location);
                ps4.setTimestamp(3, ts);
                ps4.setTimestamp(4, ds);
                ResultSet rs4 = ps4.executeQuery();
                while (rs4.next()) {
                    categoryCounts.put(categories.get(i), rs4.getInt(1));
                }
            }
            BranchReportModel report = new BranchReportModel(availableVehicles, categoryCounts, branchCount);
            return report;

        } catch (SQLException e) {
            return null;
            // TODO handle SQLexception
        }
    }

    private VehicleModel extractVehicle(ResultSet result) {
        try {
            long id = result.getLong(1);
            String license = result.getString(2);
            String make = result.getString(3);
            String model = result.getString(4);
            int year = result.getInt(5);
            String color = result.getString(6);
            int odometer = result.getInt(7);
            String status = result.getString(8);
            String vt_name = result.getString(9);
            String location = result.getString(10);
            String city = result.getString(11);
            VehicleModel vehicle = new VehicleModel(id, license, make, model, year, color, odometer, status, vt_name, location, city);
            return vehicle;
        } catch (SQLException e) {
            return null; // TODO
        }
    }

    private BranchModel extractBranch(ResultSet result) {
        try {
            String location = result.getString(1);
            String city = result.getString(2);
            BranchModel branch = new BranchModel(location, city);
            return branch;
        } catch (SQLException e) {
            return null; // TODO
        }
    }
}