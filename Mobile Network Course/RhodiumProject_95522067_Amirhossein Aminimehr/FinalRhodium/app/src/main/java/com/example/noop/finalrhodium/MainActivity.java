package com.example.noop.finalrhodium;

/**
 * Created by $noop on 5/14/2020.
 */

import android.annotation.TargetApi;
import android.app.ActionBar;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Build;
import android.os.Bundle;
import android.telephony.CellInfo;
import android.telephony.CellInfoCdma;
import android.telephony.CellInfoGsm;
import android.telephony.CellInfoLte;
import android.telephony.CellInfoWcdma;
import android.telephony.CellSignalStrengthWcdma;
import android.telephony.TelephonyManager;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.google.android.gms.location.FusedLocationProviderClient;


import java.util.List;

@TargetApi(Build.VERSION_CODES.KITKAT)
public class MainActivity extends Activity {
    private FusedLocationProviderClient fusedLocationClient;
    TelephonyManager telephonyManager;
    TextView textView;
    protected LocationManager locationManager;
    protected LocationListener locationListener;
    protected Context context;
    TextView txtLat;
    TextView txtLat2;
    double lat;
    double provider;
    int ss1 = 0;

    protected boolean gps_enabled,network_enabled;
    static double longitude = 1;
    static double latitude = 1;
    static int rsrp = 0;
    static int rsrq = 0;
    static double snr = 0.0;

    //MapsActivity ma = new MapsActivity();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);



        ActionBar bar = getActionBar();
        bar.setBackgroundDrawable(new ColorDrawable(Color.parseColor("#808080")));

        setTitle("Main Menu");
        //getActionBar().setIcon(R.drawable.my_icon);
    }




//        context.deleteDatabase("connectionInfo");
//        context.deleteDatabase("connectionInfo1");
//        context.deleteDatabase("connectionInfo2");
//        context.deleteDatabase("connectionInfo3");
//        context.deleteDatabase("connectionInfo4");
//        context.deleteDatabase("connectionInfo5");
//        context.deleteDatabase("connectionInfo6");





        //AppDatabase l;
        //l=AppDatabase.getAppDatabase(this);
        //Log.i("Location", "Base Station(CellInfoGsm) Info Nearbyllllllllllooooooooooooooooooo: ");
        //ConnectionInfo data1 = new ConnectionInfo(,1,1 ,"","","RAC","","",rsrp,rsrq,ss1);
        //l.conecctionDao().insertInfo(data1);

        //AppDatabase l=AppDatabase.getAppDatabase(this);
        //for (ConnectionInfo i : l.conecctionDao().getAll())
        //{
            //Log.i("aaaaaaaaaaaaaaaaaaaa","llllllllllllllllll"+i.getUid() +"\n");
        //}

        //Log.i("aaaaaaaaaaaaaaaaaaaa","locoloclocloclcolcoclocloclcocloclco"+getLat() +"\n");

        /*
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this);

        textView = (TextView) findViewById(R.id.text);
        telephonyManager = (TelephonyManager) getSystemService(Context.TELEPHONY_SERVICE);

        List<CellInfo> infos = telephonyManager.getAllCellInfo();
        if(infos!=null) {
            if(infos.size()==0)return;

            for (CellInfo i : infos) {
                if(i instanceof CellInfoGsm){
                    Log.i("Location", "Base Station(CellInfoGsm) Info Nearby: " + i.toString() + "\n");
                }else if(i instanceof CellInfoCdma){
                    Log.i("Location", "Base Station(CellInfoCdma) Info Nearby: " + i.toString() + "\n");
                }else if(i instanceof CellInfoLte) {

                    String[] parts = i.toString().split(" ");
                    GsmCellLocation gsmCellLocation = (GsmCellLocation)telephonyManager.getCellLocation();
                    Log.i("aaaaaaaaaaaaaaaaaaaaa",gsmCellLocation.getLac() +"\n");
                    Log.i("aaaaaaaaaaaaaaaaaaaaa",gsmCellLocation.getCid() +"\n");
                    Log.i("aaaaaaaaaaaaaaaaaaaaa",gsmCellLocation.toString() +"\n");
                    String[]  rsrp1 = parts[12].split("=");
                    String[] rsrq1 = parts[13].split("=");
                    String[] snr1 = parts[14].split("=");

                    rsrp = Integer.parseInt(rsrp1[1]);
                    rsrq = Integer.parseInt(rsrq1[1]);

                    snr = Integer.parseInt(snr1[1])/10D;
                    Log.i("ssssssssssssss",gsmCellLocation.toString() +"\n");
                    //Log.i("snrrrrrrrrrrrr","rrrrrrrrrrrrrrrrrrrrrrrrrrr"+  Integer.parseInt(snr,16) + "\n");
                    Log.i("Location", "Base Station(CellInfoLte) Info Nearby: " + i.toString() + "\n");
                }else if(i instanceof CellInfoWcdma){
                    Log.i("Location", "Base Station(CellInfoWcdma) Info Nearby: " + i.toString() + "\n");
                }else {
                    Log.i("Location", "Base Station(CellInfoGsm) Info Nearby: UNKNOWN" + "\n");                         }
            }
        }




        //l = AppDatabase.getAppDatabase(this);
        //int lastIndex = l.conecctionDao().getAll().size()-1;

        //Log.i("Location", "Base Station(CellInfoGsm) Info Nearbyllllllllllooooooooooooooooooo: " +  l.conecctionDao().getAll().get(lastIndex).getUid() + "\n");
    }
    */
    public void Ganesh(View View)
    {
        String button_text;
        button_text =((Button)View).getText().toString();
        if(button_text.equals("Show Map"))
        {
            Intent ganesh = new Intent(this,MapsActivity.class);
            startActivity(ganesh);
        }
        else if (button_text.equals("Show Parameters"))
        {
            Intent mass = new Intent(this,ParameterActivity.class);
            startActivity(mass);

        }
    }




/*
    @Override
    public void onLocationChanged(Location location) {
       Log.i("Location", "Base Station(CellInfoGsm) Info Nearby: " + "bubbubububububububug" + "\n");
        txtLat2 = (TextView) findViewById(R.id.textview1);
        txtLat2.setText("Latitude:" + location.getLatitude() + ", Longitude:" + location.getLongitude());

        GsmCellLocation gsmCellLocation = (GsmCellLocation)telephonyManager.getCellLocation();

        longitude = location.getLongitude();
        latitude = location.getLatitude();
        String longitude1 = Double.toString(location.getLongitude());
        String latitude1 = Double.toString(location.getLatitude());
        String plmnId = telephonyManager.getNetworkOperator();
        String lac = Integer.toString(gsmCellLocation.getLac());
        String cellId = Integer.toString(gsmCellLocation.getCid());
        AppDatabase l = AppDatabase.getAppDatabase(this);
        List<CellInfo> infos = telephonyManager.getAllCellInfo();
        if(infos!=null) {
            if(infos.size()==0)return;
            for (CellInfo i : infos) {
                if(i instanceof CellInfoGsm){
                    String[] parts = i.toString().split(" ");
                    Log.i("Location", "Base Station(CellInfoGsm) Info Nearby: " + i.toString() + "\n");
                }else if(i instanceof CellInfoCdma){
                    String[] parts = i.toString().split(" ");
                    Log.i("Location", "Base Station(CellInfoCdma) Info Nearby: " + i.toString() + "\n");
                }else if(i instanceof CellInfoLte) {
                    Log.i("Location", "Base Station(CellInfoGsm) Info Nearby: " + "bubbubububububububug2222222222222" + "\n");
                    String[] parts = i.toString().split(" ");

                    String ss2[] = parts[11].split("=");
                    String rsrp1[] = parts[12].split("=");
                    String rsrq1[] = parts[13].split("=");

                    rsrp = Integer.parseInt(rsrp1[1]);
                    rsrq = Integer.parseInt(rsrq1[1]);
                    ss1 = Integer.parseInt(ss2[1]);
                    Log.i("Location", "Base Station(CellInfoGsm) Info Nearby: " + "bubbubububububububug33333333333" + "\n");

                    Log.i("Location", "Base Station(CellInfoGsm) Info Nearby: " + "bubbubububububububug444444444" + "\n");
                    int lastIndex = l.conecctionDao().getAll().size()-1;
                    Log.i("Location", "Base Station(CellInfoGsm) Info Nearby: " + "bubbubububububububug555555555" + "\n");
                    ConnectionInfo data1 = new ConnectionInfo(lastIndex+1,longitude,latitude ,plmnId,lac,"RAC",lac,cellId,rsrp,rsrq,ss1);
                    Log.i("Location", "Base Station(CellInfoGsm) Info Nearby: " + "bubbubububububububug66666666666" + "\n");
                    l.conecctionDao().insertInfo(data1);
                    Log.i("Location", "Base Station(CellInfoGsm) Info Nearby: " + "bubbubububububububug7777777777" + "\n");
                    Log.i("Location", "Base Station(CellInfoLte) Info Nearby: " + i.toString() + "\n");
                }else if(i instanceof CellInfoWcdma){
                    String[] parts = i.toString().split(" ");
                    Log.i("Location", "Base Station(CellInfoWcdma) Info Nearby: " + i.toString() + "\n");
                }else {
                    Log.i("Location", "Base Station(CellInfoGsm) Info Nearby: UNKNOWN" + "\n");                         }
            }
        }





        //ConnectionInfo data1 = new ConnectionInfo(47,longitude,latitude,plmnId,lac,"RAC",lac,cellId,rsrp,rsrq,"CINR");
        //l.conecctionDao().insertInfo(data1);

    }

    @Override
    public void onProviderDisabled(String provider) {
        Log.d("Latitude","disable");
    }

    @Override
    public void onProviderEnabled(String provider) {
        Log.d("Latitude","enable");
    }

    @Override
    public void onStatusChanged(String provider, int status, Bundle extras) {
        Log.d("Latitude","status");
    }
*/


    public double getLat(){
        double l;

        LocationManager lm = (LocationManager) this.getSystemService(LOCATION_SERVICE);
        try {
            Location loc = lm.getLastKnownLocation(LocationManager.GPS_PROVIDER);
            return (loc.getLatitude());
        }
        catch(SecurityException e){
            return (1);
        }
        catch(Exception e){
            return (1);
        }
    }
    public double getAlt(){
        double l;
        LocationManager lm = (LocationManager) this.getSystemService(LOCATION_SERVICE);
        try {
            Location loc = lm.getLastKnownLocation(LocationManager.GPS_PROVIDER);
            return (loc.getLongitude());

        }
        catch(SecurityException e){
            return (1);
        }
        catch(Exception e){
            return (1);
        }
    }
    public double getlat()
    {
        return latitude;
    }
    public double getlon()
    {
        return longitude;
    }
    public int getrsrp() { return rsrp; }
    public int getrsrq() { return rsrq; }
}

