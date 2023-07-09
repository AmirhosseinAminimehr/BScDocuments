package com.example.noop.finalrhodium;

import android.arch.persistence.room.ColumnInfo;
import android.arch.persistence.room.Dao;
import android.arch.persistence.room.Delete;
import android.arch.persistence.room.Entity;
import android.arch.persistence.room.Ignore;
import android.arch.persistence.room.Insert;
import android.arch.persistence.room.PrimaryKey;
import android.arch.persistence.room.Query;

import java.util.List;

/**
 * Created by $noop on 5/14/2020.
 */

@Entity(tableName = "connectionInfo7")
public class ConnectionInfo {

    @PrimaryKey(autoGenerate = true)
    private int uid;

    @ColumnInfo(name = "UE_longitude")
    private double UE_longitude;

    @ColumnInfo(name = "UE_latitude")
    private double UE_latitude;

    @ColumnInfo(name = "cell_PLMN")
    private String cell_PLMN;

    @ColumnInfo(name = "LAC")
    private String LAC;

    @ColumnInfo(name = "RAC")
    private String RAC;

    @ColumnInfo(name = "TAC")
    private String TAC;

    @ColumnInfo(name = "cellID")
    private String cellID;

    @ColumnInfo(name = "RSRP")
    private double RSRP;

    @ColumnInfo(name = "RSRQ")
    private double RSRQ;

    @ColumnInfo(name = "SINR")
    private double SINR;

    @ColumnInfo(name = "RSCP")
    private double RSCP;

    @ColumnInfo(name = "EC_N0")
    private double EC_N0;

    @ColumnInfo(name = "RSSI")
    private double RSSI;

    @ColumnInfo(name = "RxLev")
    private double RxLev;

    @Ignore
    public ConnectionInfo(int uid,double UE_longitude,double UE_latitude,String cell_PLMN,String LAC,String RAC,String TAC,String cellID,double RSRP,double RSRQ,double SINR, double RSCP, double EC_N0, double RSSI, double RxLev)
    {
        this.uid = uid;
        this.UE_longitude = UE_longitude;
        this.UE_latitude = UE_latitude;
        this.cell_PLMN = cell_PLMN;
        this.LAC = LAC;
        this.RAC = RAC;
        this.TAC = TAC;
        this.cellID = cellID;
        this.RSRP = RSRP;
        this.RSRQ = RSRQ;
        this.SINR = SINR;
        this.RSCP = RSCP;
        this.EC_N0 = EC_N0;
        this.RSSI = RSSI;
        this.RxLev = RxLev;
    }


    public ConnectionInfo(double UE_longitude,double UE_latitude,String cell_PLMN,String LAC,String RAC,String TAC,String cellID,double RSRP,double RSRQ,double SINR, double RSCP, double EC_N0, double RSSI, double RxLev)
    {
        this.UE_longitude = UE_longitude;
        this.UE_latitude = UE_latitude;
        this.cell_PLMN = cell_PLMN;
        this.LAC = LAC;
        this.RAC = RAC;
        this.TAC = TAC;
        this.cellID = cellID;
        this.RSRP = RSRP;
        this.RSRQ = RSRQ;
        this.SINR = SINR;
        this.RSCP = RSCP;
        this.EC_N0 = EC_N0;
        this.RSSI = RSSI;
        this.RxLev = RxLev;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }
//
    public double getUE_longitude() {
        return UE_longitude;
    }

    public void setUE_longitude(double UE_longitude) {
        this.UE_longitude = UE_longitude;
    }

    public double getUE_latitude() {
        return UE_latitude;
    }

    public void setUE_latitude(double UE_latitude) {
        this.UE_latitude = UE_latitude;
    }

    public String getLAC() {
        return LAC;
    }

    public void setLAC(String LAC) {
        this.LAC = LAC;
    }

    public String getRAC() {
        return RAC;
    }

    public void setRAC(String RAC) {
        this.RAC = RAC;
    }

    public String getTAC() {
        return TAC;
    }

    public void setTAC(String TAC) {
        this.TAC = TAC;
    }

    public String getCellID() {
        return cellID;
    }

    public void setCellID(String cellID) {
        this.cellID = cellID;
    }

    public double getRSRP() {
        return RSRP;
    }

    public void setRSRP(double RSRP) {
        this.RSRP = RSRP;
    }

    public String getCell_PLMN() {
        return cell_PLMN;
    }

    public void setCell_PLMN(String cell_PLMN) {
        this.cell_PLMN = cell_PLMN;
    }

    public double getRSRQ() {
        return RSRQ;
    }

    public void setRSRQ(double RSRQ) {
        this.RSRQ = RSRQ;
    }

    public double getSINR() {
        return SINR;
    }

    public void setSINR(double SINR) {
        this.SINR = SINR;
    }

    public double getRSCP() {
        return RSCP;
    }

    public void setRSCP(double RSCP) {
        this.RSCP = RSCP;
    }

    public double getEC_N0() {
        return EC_N0;
    }

    public void setEC_N0(double EC_N0) {
        this.EC_N0 = EC_N0;
    }

    public double getRSSI() {return RSSI;}

    public void setRSSI(double RSSI) {
        this.RSSI = RSSI;
    }

    public double getRxLev() {
        return RxLev;
    }

    public void setRxLev(double RxLev) {
        this.RxLev = RxLev;
    }

}


