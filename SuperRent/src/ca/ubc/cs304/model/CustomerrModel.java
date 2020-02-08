package ca.ubc.cs304.model;

public class CustomerrModel {

    private long cellphone;
    private String name;
    private String address;
    private long dlicense;

    public CustomerrModel() {
    }

    public CustomerrModel(long cellphone, String name, String address, long dlicense) {
        this.cellphone = cellphone;
        this.name = name;
        this.address = address;
        this.dlicense = dlicense;
    }

    public long getCellphone() {
        return this.cellphone;
    }

    public void setCellphone(long cellphone) {
        this.cellphone = cellphone;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return this.address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public long getDlicense() {
        return this.dlicense;
    }

    public void setDlicense(long dlicense) {
        this.dlicense = dlicense;
    }

    public CustomerrModel cellphone(long cellphone) {
        this.cellphone = cellphone;
        return this;
    }

    public CustomerrModel name(String name) {
        this.name = name;
        return this;
    }

    public CustomerrModel address(String address) {
        this.address = address;
        return this;
    }

    public CustomerrModel dlicense(long dlicense) {
        this.dlicense = dlicense;
        return this;
    }
}
