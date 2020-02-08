package ca.ubc.cs304.controller;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import ca.ubc.cs304.database.DatabaseConnectionHandler;
import ca.ubc.cs304.model.BranchModel;

public class BranchController {
    private static final String BRANCHES = "SELECT * FROM branch";
    private DatabaseConnectionHandler db = null;

    public BranchController() {
        this.db = DatabaseConnectionHandler.getInstance();
    }

    public List<BranchModel> getBranches() throws SQLException {
        List<BranchModel> branches = new ArrayList<>();
        PreparedStatement ps = db.getConnection().prepareStatement(BRANCHES);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            String location = rs.getString(1);
            String city = rs.getString(2);
            BranchModel branch = new BranchModel(location, city);
            branches.add(branch);
        }
        ps.close();
        rs.close();
        return branches;
    }
}
