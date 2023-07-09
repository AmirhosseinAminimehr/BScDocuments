package com.example.noop.finalrhodium;

import android.annotation.TargetApi;
import android.app.ActionBar;
import android.content.Context;
import android.content.Intent;
import android.content.res.Resources;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Build;
import android.os.Handler;
import android.support.v4.app.FragmentActivity;
import android.os.Bundle;
import android.telephony.CellInfo;
import android.telephony.CellInfoCdma;
import android.telephony.CellInfoGsm;
import android.telephony.CellInfoLte;
import android.telephony.CellInfoWcdma;
import android.telephony.CellSignalStrengthCdma;
import android.telephony.CellSignalStrengthGsm;
import android.telephony.CellSignalStrengthLte;
import android.telephony.CellSignalStrengthWcdma;
import android.telephony.TelephonyManager;
import android.telephony.gsm.GsmCellLocation;
import android.util.Log;
import android.view.KeyEvent;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.android.gms.maps.model.PolylineOptions;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

@TargetApi(Build.VERSION_CODES.KITKAT)
public class MapsActivity extends FragmentActivity implements OnMapReadyCallback {
    private GoogleMap mGoogleMap;

    Handler handler = new Handler();
    int delay = 8000;
    double longitude = 0.0;
    double latitude = 0.0;
    int rsrp = 0;
    int rsrq = 0;
    int lastIndex = 0;
    TelephonyManager telephonyManager;
    int ss1 = 0;
    int lastind = 0;
    double rxlev = 0;
    double rssi = 0;
    double rscp = 0;
    double ec_n0 = 0;
    Button MyLoc;
    TextView type;
    AppDatabase l;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        LocationManager locationManager = (LocationManager) this.getSystemService(Context.LOCATION_SERVICE);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_maps);

        ActionBar bar = getActionBar();
        bar.setBackgroundDrawable(new ColorDrawable(Color.parseColor("#808080")));
        bar.setDisplayHomeAsUpEnabled(true);

        final TextView textLongitude = (TextView) findViewById(R.id.longitude);
        final TextView textLatitude = (TextView) findViewById(R.id.latitude);

        telephonyManager = (TelephonyManager) getSystemService(Context.TELEPHONY_SERVICE);
        LocationListener locationListenerGPS = new LocationListener() {
            final TextView textLongitude1 = (TextView) findViewById(R.id.HELP);


//            Location mLastLocation;

            //            public locationListenerGPS(String provider) {
//                Log.e(TAG, "LocationListener " + provider);
//                mLastLocation = new Location(provider);
//            }
            @Override
            public void onLocationChanged(Location location) {

                long time = location.getTime();
                Date date = new Date(time);
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String textofDate = sdf.format(date);
                longitude = location.getLongitude();
                latitude = location.getLatitude();
                textLatitude.setText(""+latitude);
                textLongitude.setText(""+longitude);
                Log.i("laaaaaaaaaaat",""+latitude);
                Log.i("looooooooon",""+longitude);
                Log.i("","lllllllllllllllloooooooooooooooooooooccccccccccccccccccccccc");

//        loct = location;
            }



            @Override
            public void onStatusChanged(String provider, int status, Bundle extras) {
            }

            @Override
            public void onProviderEnabled(String provider) {
            }

            @Override
            public void onProviderDisabled(String provider) {
            }

        };
        try {
//            TextView tvSSID = (TextView) findViewById(R.id.textViewSSID);
//            tvSSID.setText("hi");
            locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 0, 0, locationListenerGPS);
        } catch (SecurityException e) {
//            TextView tvSSID = (TextView) findViewById(R.id.textViewSSID);
//            tvSSID.setText("hi");
        }


        // Obtain the SupportMapFragment and get notified when the map is ready to be used.
        SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager()
                .findFragmentById(R.id.map);
        mapFragment.getMapAsync(this);

        l=AppDatabase.getAppDatabase(this);


        lastIndex = l.conecctionDao().getAll().size();
        if(lastIndex == 0)
        {
            ConnectionInfo data1 = new ConnectionInfo(0, longitude, latitude, "", "", "RAC", "", "", 0, 0, 0, 0, 0, 0, rxlev);
            l.conecctionDao().insertInfo(data1);
        }

        MyLoc = (Button) findViewById(R.id.MYLOC);
        type = (TextView) findViewById(R.id.TYPE);

        if(latitude == 0)
        {
            MyLoc.setEnabled(false);
            MyLoc.setAlpha(.5f);
        }

        if(latitude != 0)
        {
            MyLoc.setEnabled(true);
            MyLoc.setAlpha(1);
        }



    }


    @Override
    public void onMapReady(final GoogleMap googleMap) {
//
        if(latitude == 0)
        {
            MyLoc.setEnabled(false);
            MyLoc.setAlpha(.5f);
        }

        if(latitude != 0)
        {
            MyLoc.setEnabled(true);
            MyLoc.setAlpha(1);
        }


        l = AppDatabase.getAppDatabase(this);
        mGoogleMap = googleMap;

        MyLoc.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {
                LatLng latLng = new LatLng(latitude, longitude);
                CameraUpdate cameraUpdate = CameraUpdateFactory.newLatLngZoom(latLng, 18);
                googleMap.animateCamera(cameraUpdate);
            }
        });

//        // Add a marker in Sydney and move the camera
//        LatLng sydney = new LatLng(-34, 151);
//        mMap.addMarker(new MarkerOptions().position(sydney).title("Marker in Sydney"));
//        mMap.moveCamera(CameraUpdateFactory.newLatLng(sydney));

        handler.postDelayed(new Runnable(){

            public void run() {

                if(latitude == 0)
                {
                    MyLoc.setEnabled(false);
                    MyLoc.setAlpha(.5f);
                }

                if(latitude != 0)
                {
                    MyLoc.setEnabled(true);
                    MyLoc.setAlpha(1);
                }

                try {



                    GsmCellLocation gsmCellLocation = (GsmCellLocation) telephonyManager.getCellLocation();
                    String plmnId = telephonyManager.getNetworkOperator();
                    String lac = Integer.toString(gsmCellLocation.getLac());
                    String cellId = Integer.toString(gsmCellLocation.getCid());

                    List<CellInfo> infos = telephonyManager.getAllCellInfo();
                    CellInfo i = infos.get(0);
                    if (infos != null) {
                        if (infos.size() == 0) return;


                        if (i instanceof CellInfoGsm) {

                            type.setText("" + "GSM");
                            CellInfoGsm cellinfoGsm = null;

                            cellinfoGsm = (CellInfoGsm) telephonyManager.getAllCellInfo().get(0);
                            CellSignalStrengthGsm cellSignalStrengthGsm = cellinfoGsm.getCellSignalStrength();
                            if (Build.VERSION.SDK_INT >= 18) {
                                rxlev = cellSignalStrengthGsm.getDbm();
                            }


                            l = getDataBase();
                            lastind = l.conecctionDao().getAll().size() - 1;
                            double lat1 = l.conecctionDao().getAll().get(lastind).getUE_latitude();
                            double lon1 = l.conecctionDao().getAll().get(lastind).getUE_longitude();
                            List<ColoredPoint> sourcePoints = new ArrayList<>();

                            if (latitude==0 || lat1==0) {
                                type.setText("" + "GSM" + " (Location Not Found Yet)");
                            }

                            if (latitude!=0 && lat1!=0) {

                                type.setText("" + "GSM" );

                                if (rxlev <= -110) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.RED));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.RED));
                                } else if (rxlev <= -100) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.GRAY));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.GRAY));
                                } else if (rxlev <= -86) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.YELLOW));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.YELLOW));
                                } else if (rxlev <= -70) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.GREEN));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.GREEN));
                                } else if (rxlev > -70) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.BLUE));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.BLUE));
                                }
                            }


                            lastIndex = l.conecctionDao().getAll().size() - 1;
                            int lastUid = l.conecctionDao().getAll().get(lastIndex).getUid();
                            ConnectionInfo data1 = new ConnectionInfo(lastUid + 1, longitude, latitude, plmnId, lac, "RAC", lac, cellId, 0, 0, 0, 0, 0, 0, rxlev);
                            l.conecctionDao().insertInfo(data1);

                            showPolyline(sourcePoints);

                            handler.postDelayed(this, delay);
                        } else if (i instanceof CellInfoCdma) {

                            type.setText("" + "UMTS CDMA");
                            CellInfoCdma cellinfoCdma = null;

                            cellinfoCdma = (CellInfoCdma) telephonyManager.getAllCellInfo().get(0);
                            CellSignalStrengthCdma cellSignalStrengthCdma = cellinfoCdma.getCellSignalStrength();
                            if (Build.VERSION.SDK_INT >= 18) {
                                ec_n0 = cellSignalStrengthCdma.getEvdoEcio();
                                rssi = cellSignalStrengthCdma.getEvdoDbm();
                            }


                            l = getDataBase();
                            lastind = l.conecctionDao().getAll().size() - 1;
                            double lat1 = l.conecctionDao().getAll().get(lastind).getUE_latitude();
                            double lon1 = l.conecctionDao().getAll().get(lastind).getUE_longitude();
                            List<ColoredPoint> sourcePoints = new ArrayList<>();

                            if (latitude==0 || lat1==0) {
                                type.setText("" + "UMTS CDMA" + " (Location Not Found Yet)");
                            }


                            if (latitude!=0 && lat1!=0) {

                                type.setText("" + "UMTS CDMA");

                                if (rssi <= -110 || ec_n0 <= -11) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.RED));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.RED));
                                } else if (rssi <= -100 || ec_n0 <= -11) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.GRAY));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.GRAY));
                                } else if (rssi <= -86 || ec_n0 <= -7) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.YELLOW));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.YELLOW));
                                } else if (rssi <= -70 || ec_n0 <= -7) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.GREEN));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.GREEN));
                                } else if (rssi > -70 || ec_n0 >= -6) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.BLUE));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.BLUE));
                                }
                            }
                            lastIndex = l.conecctionDao().getAll().size() - 1;
                            int lastUid = l.conecctionDao().getAll().get(lastIndex).getUid();
                            ConnectionInfo data1 = new ConnectionInfo(lastUid + 1, longitude, latitude, plmnId, lac, "RAC", lac, cellId, 0, 0, 0, 0, ec_n0, rssi, 0);
                            l.conecctionDao().insertInfo(data1);

                            showPolyline(sourcePoints);

                            handler.postDelayed(this, delay);


                        } else if (i instanceof CellInfoLte) {

                            type.setText("" + "LTE");

                            CellInfoLte cellinfoLte = null;

                            cellinfoLte = (CellInfoLte) telephonyManager.getAllCellInfo().get(0);
                            CellSignalStrengthLte cellSignalStrengthLte = cellinfoLte.getCellSignalStrength();
                            if (Build.VERSION.SDK_INT >= 18) {
                                rsrp = cellSignalStrengthLte.getRsrp();
                                rsrq = cellSignalStrengthLte.getRsrq();
                                ss1 = cellSignalStrengthLte.getDbm();

                            }


                            l = getDataBase();
                            lastind = l.conecctionDao().getAll().size() - 1;
                            double lat1 = l.conecctionDao().getAll().get(lastind).getUE_latitude();
                            double lon1 = l.conecctionDao().getAll().get(lastind).getUE_longitude();
                            List<ColoredPoint> sourcePoints = new ArrayList<>();

                            if (latitude==0 || lat1==0) {
                                type.setText("" + "LTE" + " (Location Not Found Yet)");
                            }

                            if (latitude!=0 && lat1!=0) {

                                type.setText("" + "LTE" );

                                if (rsrp <= -111 || rsrq <= -12) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.RED));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.RED));
                                } else if (rsrp <= -103 || rsrq <= -9) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.YELLOW));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.YELLOW));
                                } else if (rsrp <= -85 || rsrq < -5) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.GREEN));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.GREEN));
                                } else if (rsrp >= -84 & rsrq >= -5) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.BLUE));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.BLUE));
                                }
                            }


                            lastIndex = l.conecctionDao().getAll().size() - 1;
                            int lastUid = l.conecctionDao().getAll().get(lastIndex).getUid();
                            ConnectionInfo data1 = new ConnectionInfo(lastUid + 1, longitude, latitude, plmnId, lac, "RAC", lac, cellId, rsrp, rsrq, ss1, 0, 0, 0, 0);
                            l.conecctionDao().insertInfo(data1);

                            showPolyline(sourcePoints);

                            handler.postDelayed(this, delay);


                        } else if (i instanceof CellInfoWcdma) {

                            type.setText("" + "UMTS WCDMA");
                            CellInfoWcdma cellinfoWcdma = null;

                            cellinfoWcdma = (CellInfoWcdma) telephonyManager.getAllCellInfo().get(0);
                            CellSignalStrengthWcdma cellSignalStrengthWcdma = cellinfoWcdma.getCellSignalStrength();
                            if (Build.VERSION.SDK_INT >= 18) {
                                rscp = cellSignalStrengthWcdma.getDbm();
                            }


                            l = getDataBase();
                            lastind = l.conecctionDao().getAll().size() - 1;
                            double lat1 = l.conecctionDao().getAll().get(lastind).getUE_latitude();
                            double lon1 = l.conecctionDao().getAll().get(lastind).getUE_longitude();
                            List<ColoredPoint> sourcePoints = new ArrayList<>();

                            if (latitude==0 || lat1==0) {
                                type.setText("" + "UMTS WCDMA" + " (Location Not Found Yet)");
                            }

                            if (latitude!=0 && lat1!=0) {

                                type.setText("" + "UMTS WCDMA");

                                if (rscp <= -95) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.RED));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.RED));
                                } else if (rscp <= -85) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.GRAY));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.GRAY));
                                } else if (rscp <= -75) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.YELLOW));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.YELLOW));
                                } else if (rscp < -60) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.GREEN));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.GREEN));
                                } else if (rscp >= -60) {

                                    sourcePoints.add(new ColoredPoint(new LatLng(lat1, lon1), Color.BLUE));
                                    sourcePoints.add(new ColoredPoint(new LatLng(latitude, longitude), Color.BLUE));
                                }
                            }
                            lastIndex = l.conecctionDao().getAll().size() - 1;
                            int lastUid = l.conecctionDao().getAll().get(lastIndex).getUid();
                            ConnectionInfo data1 = new ConnectionInfo(lastUid + 1, longitude, latitude, plmnId, lac, "RAC", lac, cellId, 0, 0, 0, rscp, 0, 0, 0);
                            l.conecctionDao().insertInfo(data1);

                            showPolyline(sourcePoints);

                            handler.postDelayed(this, delay);


                        } else {
                        }


                    }


                }
                catch (Exception e)
                {
                    type.setText("" + "Location Have Not Been Loaded Yet");
                }
            }

        }, delay);
    }




    public boolean onOptionsItemSelected(MenuItem item){
        onBackPressed();
        return true;
    }

    private void showPolyline(List<ColoredPoint> points) {

        if (points.size() < 2)
            return;

        int ix = 0;
        ColoredPoint currentPoint  = points.get(ix);
        int currentColor = currentPoint.color;
        List<LatLng> currentSegment = new ArrayList<>();
        currentSegment.add(currentPoint.coords);
        ix++;

        while (ix < points.size()) {
            currentPoint = points.get(ix);

            if (currentPoint.color == currentColor) {
                currentSegment.add(currentPoint.coords);
            } else {
                currentSegment.add(currentPoint.coords);
                mGoogleMap.addPolyline(new PolylineOptions()
                        .addAll(currentSegment)
                        .color(currentColor)
                        .width(20));
                currentColor = currentPoint.color;
                currentSegment.clear();
                currentSegment.add(currentPoint.coords);
            }

            ix++;
        }

        mGoogleMap.addPolyline(new PolylineOptions()
                .addAll(currentSegment)
                .color(currentColor)
                .width(20));

    }

    private AppDatabase getDataBase (){
        AppDatabase l=AppDatabase.getAppDatabase(this);


        return l;
    }

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
    }


}

class ColoredPoint {
    public LatLng coords;
    public int color;

    public ColoredPoint(LatLng coords, int color) {
        this.coords = coords;
        this.color = color;
    }
}

