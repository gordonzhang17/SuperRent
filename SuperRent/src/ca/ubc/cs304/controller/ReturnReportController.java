package ca.ubc.cs304.controller;

import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.model.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ReturnReportController {

    private DatabaseConnectionHandler db = null;

    private static final String COUNT_VEHICLES_RETURNED_TODAY_BY_VTYPE =
            "select count(*) from vehicle v WHERE v.vtname = ? AND v.location = ? AND exists (select * from ret rt where rt.return_date <= ? AND rt.return_date >= ? AND exists (select * from rent r where r.rent_id = rt.rent_id AND r.vehicle_id = v.id))";
    private static final String ALL_COUNT_VEHICLES_RETURNED_TODAY_BY_VTYPE =
            "select count(*) from vehicle v WHERE v.vtname = ? AND exists (select * from ret rt where rt.return_date <= ? AND rt.return_date >= ? AND exists (select * from rent r where r.rent_id = rt.rent_id AND r.vehicle_id = v.id))";

    private static final String REVENUE_PER_CATEGORY_PER_BRANCH =
            "select sum(rt.cost) from vehicle v, ret rt WHERE v.vtname = ? AND v.location = ? AND exists (select * from rent r where r.rent_id = rt.rent_id AND r.vehicle_id = v.id AND rt.return_date <= ? AND rt.return_date >= ?)";
    private static final String REVENUE_PER_CATEGORY_ALL_BRANCHES =
            "select sum(rt.cost) from vehicle v, ret rt WHERE v.vtname = ? AND exists (select * from rent r where r.rent_id = rt.rent_id AND r.vehicle_id = v.id AND rt.return_date <= ? AND rt.return_date >= ?)";

    private static final String REVENUE_ALL_BRANCHES =
            "select sum(rt.cost) from vehicle v, ret rt WHERE exists (select * from rent r where r.rent_id = rt.rent_id AND r.vehicle_id = v.id AND rt.return_date <= ? AND rt.return_date >= ?)";

    private static final String REVENUE_PER_BRANCH =
            "select sum(rt.cost) from vehicle v, ret rt WHERE v.location = ? AND exists (select * from rent r where r.rent_id = rt.rent_id AND r.vehicle_id = v.id AND rt.return_date <= ? AND rt.return_date >= ?)";
    private static final String VEHICLE_COSTS_PER_BRANCH =
            "select rt.cost from vehicle v, ret rt WHERE v.location = ? AND exists(select * from rent r where r.rent_id = rt.rent_id AND r.vehicle_id = v.id AND rt.return_date <= ? AND rt.return_date >= ?)order by v.location, v.vtname\n";
    private static final String VEHICLE_COSTS_ALL_BRANCHES =
            "select rt.cost from vehicle v, ret rt WHERE exists(select * from rent r where r.rent_id = rt.rent_id AND r.vehicle_id = v.id AND rt.return_date <= ? AND rt.return_date >= ?)order by v.location, v.vtname";

    private static final String GET_BRANCHES = "select * from branch";

    private static final String VEHICLES_WITH_RETURNS_TODAY=
            "select * from vehicle v where v.location = ? AND exists (select * from ret rt where rt.return_date <= ? AND rt.return_date >= ? AND exists (select * from rent r where r.rent_id = rt.rent_id AND r.vehicle_id = v.id)) order by v.location, v.vtname";
    private static final String ALL_VEHICLES_WITH_RETURNS_TODAY =
            "select * from vehicle v where exists (select * from ret rt where rt.return_date <= ? AND rt.return_date >= ? AND exists (select * from rent r where r.rent_id = rt.rent_id AND r.vehicle_id = v.id)) order by v.location, v.vtname";

    private static final String COUNT_VEHICLES_RETURNED_TODAY=
            "select count(*) from vehicle v where v.location = ? AND exists (select * from ret rt where rt.return_date <= ? AND rt.return_date >= ? AND exists (select * from rent r where r.rent_id = rt.rent_id AND r.vehicle_id = v.id))";
    private static final String ALL_COUNT_VEHICLES_RETURNED_TODAY=
            "select count(*) from vehicle v where exists (select * from ret rt where rt.return_date <= ? AND rt.return_date >= ? AND exists (select * from rent r where r.rent_id = rt.rent_id AND r.vehicle_id = v.id))";
    public ReturnReportController() {
        this.db = DatabaseConnectionHandler.getInstance();
    }

    public ReturnReportModel getDailyReturnReport(String location, Timestamp ts, Timestamp ds) throws SQLException {

        List<VehicleModel> availableVehicles = new ArrayList<VehicleModel>();
        List<Integer> costs = new ArrayList<Integer>();

        ArrayList<BranchModel> branches = new ArrayList<BranchModel>();

        HashMap<String, Integer> branchCounts = new HashMap<String, Integer>();
        HashMap<String, Integer> branchRevenues = new HashMap<String, Integer>();

        HashMap<String, Integer> categoryVehicleCounts = new HashMap<String, Integer>();
        HashMap<String, Integer> categoryRevenues = new HashMap<String, Integer>();



        ArrayList<String> categories = new ArrayList<String>();
        categories.add("Economy"); categories.add("Compact"); categories.add("Mid-size"); categories.add("Standard"); categories.add("Full-size");categories.add("SUV"); categories.add("Truck");

        Integer globalRevenue = 0;

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

            // revenues per vehicle
            PreparedStatement ps6 = db.getConnection().prepareStatement(VEHICLE_COSTS_ALL_BRANCHES);
            ps6.setTimestamp(1, ts);
            ps6.setTimestamp(2, ds);
            ResultSet rs6 = ps6.executeQuery();
            while (rs6.next()) {
                costs.add(rs6.getInt(1));
            }

            // regular report
            // count of vehicles PER BRANCH
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

            // regular report
            // reveneu per branch
            for(int i = 0; i<branches.size(); i++) {
                PreparedStatement ps7 = db.getConnection().prepareStatement(REVENUE_PER_BRANCH);
                ps7.setString(1, branches.get(i).getLocation());
                ps7.setTimestamp(2, ts);
                ps7.setTimestamp(3, ds);
                ResultSet rs7 = ps7.executeQuery();
                while (rs7.next()) {
                    branchRevenues.put(branches.get(i).getLocation(), rs7.getInt(1));
                }
            }

            PreparedStatement ps3 = db.getConnection().prepareStatement(REVENUE_ALL_BRANCHES);
            ps3.setTimestamp(1, ts);
            ps3.setTimestamp(2, ds);
            ResultSet rs3 = ps3.executeQuery();
            while (rs3.next()) {
                globalRevenue = rs3.getInt(1);

            }


            // get category counts
            for(int i = 0; i<categories.size(); i++) {
                PreparedStatement ps4 = db.getConnection().prepareStatement(ALL_COUNT_VEHICLES_RETURNED_TODAY_BY_VTYPE);
                ps4.setString(1, categories.get(i));
                ps4.setTimestamp(2, ts);
                ps4.setTimestamp(3, ds);

                ResultSet rs4 = ps4.executeQuery();
                while (rs4.next()) {
                    categoryVehicleCounts.put(categories.get(i), rs4.getInt(1));
                }
            }

            // get r per cat
            for(int i = 0; i<categories.size(); i++) {
                PreparedStatement ps5 = db.getConnection().prepareStatement(REVENUE_PER_CATEGORY_ALL_BRANCHES);
                ps5.setString(1, categories.get(i));
                ps5.setTimestamp(2, ts);
                ps5.setTimestamp(3, ds);

                ResultSet rs5 = ps5.executeQuery();
                while (rs5.next()) {
                    categoryRevenues.put(categories.get(i), rs5.getInt(1));
                }
            }

            ReturnReportModel report = new ReturnReportModel(availableVehicles, costs, branchCounts, categoryVehicleCounts, categoryRevenues, branchRevenues, globalRevenue);
            return report;

        } catch (SQLException e) {
            return null;
            // TODO handle SQLexception
        }
    }

    public BranchReturnReportModel getDailyReturnBranchReport(String location, Timestamp ts, Timestamp ds) {
        Integer branchRevenue = 0;

        List<VehicleModel> availableVehicles = new ArrayList<>();
        ArrayList<BranchModel> branches = new ArrayList<>();
        HashMap<String, Integer> categoryCounts = new HashMap<>();
        ArrayList<String> categories = new ArrayList<>();
        HashMap<String, Integer> categoryRevenues = new HashMap<String, Integer>();
        List<Integer> costs = new ArrayList<Integer>();

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
            // revenues per vehicle
            PreparedStatement ps6 = db.getConnection().prepareStatement(VEHICLE_COSTS_PER_BRANCH);
            ps6.setString(1, location);
            ps6.setTimestamp(2, ts);
            ps6.setTimestamp(3, ds);
            ResultSet rs6 = ps6.executeQuery();
            while (rs6.next()) {
                costs.add(rs6.getInt(1));
            }
            // get total revenue
            PreparedStatement ps2 = db.getConnection().prepareStatement(REVENUE_PER_BRANCH);
            ps2.setString(1, location);
            ps2.setTimestamp(2, ts);
            ps2.setTimestamp(3, ds);
            ResultSet rs2 = ps2.executeQuery();
            while (rs2.next()) {
                branchRevenue = rs2.getInt(1);
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

            // get category REVENUES
            for(int i = 0; i<categories.size(); i++) {
                PreparedStatement ps7 = db.getConnection().prepareStatement(REVENUE_PER_CATEGORY_PER_BRANCH);
                ps7.setString(1, categories.get(i));
                ps7.setString(2, location);
                ps7.setTimestamp(3, ts);
                ps7.setTimestamp(4, ds);
                ResultSet rs7 = ps7.executeQuery();
                while (rs7.next()) {
                    categoryRevenues.put(categories.get(i), rs7.getInt(1));
                }
            }
            BranchReturnReportModel report = new BranchReturnReportModel(availableVehicles, costs, categoryCounts, categoryRevenues, branchRevenue);
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