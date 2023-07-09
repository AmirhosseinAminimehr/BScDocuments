package com.example.noop.finalrhodium;

/**
 * Created by $noop on 5/14/2020.
 */

import android.annotation.TargetApi;
import android.app.ActionBar;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.IntentSender;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
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
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.google.android.gms.common.api.ResolvableApiException;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationServices;
import com.google.android.gms.location.LocationSettingsRequest;
import com.google.android.gms.location.LocationSettingsResponse;
import com.google.android.gms.location.SettingsClient;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.android.gms.tasks.Task;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * Created by For on 4/14/2017.
 */
@TargetApi(Build.VERSION_CODES.KITKAT)
public class ParameterActivity extends Activity {

    Handler handler = new Handler();
    int delay = 10000;
    double longitude = 0.0;
    double latitude = 0.0;
    int rsrp = 0;
    int rsrq = 0;
    double rxlev = 0;
    double ec_n0 = 0;
    double rssi = 0;
    double rscp = 0;
    TelephonyManager telephonyManager;
    int ss1 = 0;
    int lastind = 0;
    AppDatabase l;
    int lastIndex = 0;
    TextView test;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        LocationManager locationManager = (LocationManager) this.getSystemService(Context.LOCATION_SERVICE);
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_parameter);



        ActionBar bar = getActionBar();
        bar.setBackgroundDrawable(new ColorDrawable(Color.parseColor("#808080")));
        bar.setDisplayHomeAsUpEnabled(true);

        telephonyManager = (TelephonyManager) getSystemService(Context.TELEPHONY_SERVICE);
        l=AppDatabase.getAppDatabase(this);
        lastIndex = l.conecctionDao().getAll().size();
        if(lastIndex == 0)
        {
            ConnectionInfo data1 = new ConnectionInfo(0, longitude, latitude, "", "", "RAC", "", "", 0, 0, 0, 0, 0, 0, rxlev);
            l.conecctionDao().insertInfo(data1);
        }


        final TextView textLongitude = (TextView) findViewById(R.id.longitude);
        final TextView textLatitude = (TextView) findViewById(R.id.latitude);

        LocationListener locationListenerGPS = new LocationListener() {

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


        final TextView textPLMN = (TextView) findViewById(R.id.PLMN);
        final TextView textLAC = (TextView) findViewById(R.id.LAC);
        final TextView textCellID = (TextView) findViewById(R.id.cellID);
        final TextView textRSRP = (TextView) findViewById(R.id.RSRP);
        final TextView textRSRQ = (TextView) findViewById(R.id.RSRQ);
        final TextView textSINR = (TextView) findViewById(R.id.SINR);
        final TextView textRxLev = (TextView) findViewById(R.id.RxLev);
        final TextView textRSSI = (TextView) findViewById(R.id.RSSI);
        final TextView textEC_N0 = (TextView) findViewById(R.id.EC_N0);
        final TextView textRSCP = (TextView) findViewById(R.id.RSCP);

        final TextView textLongitude0 = (TextView) findViewById(R.id.longitude0);
        final TextView textLatitude0 = (TextView) findViewById(R.id.latitude0);
        final TextView textPLMN0 = (TextView) findViewById(R.id.PLMN0);
        final TextView textLAC0 = (TextView) findViewById(R.id.LAC0);
        final TextView textCellID0 = (TextView) findViewById(R.id.cellID0);
        final TextView textRSRP0 = (TextView) findViewById(R.id.RSRP0);
        final TextView textRSRQ0 = (TextView) findViewById(R.id.RSRQ0);
        final TextView textSINR0 = (TextView) findViewById(R.id.SINR0);
        final TextView textRxLev0 = (TextView) findViewById(R.id.RxLev0);
        final TextView textRSSI0 = (TextView) findViewById(R.id.RSSI0);
        final TextView textEC_N00 = (TextView) findViewById(R.id.EC_N00);
        final TextView textRSCP0 = (TextView) findViewById(R.id.RSCP0);

        final TextView textStatus = (TextView) findViewById(R.id.Status);



        List<CellInfo> infos = telephonyManager.getAllCellInfo();
        CellInfo i = infos.get(0);
        if(infos!=null) {
            if(infos.size()==0)return;


            if(i instanceof CellInfoGsm){

                textStatus.setText(""+"GSM");

                textRxLev.setVisibility(View.VISIBLE);
                textRxLev0.setVisibility(View.VISIBLE);

                textRSCP.setVisibility(View.GONE);
                textRSCP0.setVisibility(View.GONE);

                textRSSI.setVisibility(View.GONE);
                textRSSI0.setVisibility(View.GONE);

                textEC_N0.setVisibility(View.GONE);
                textEC_N00.setVisibility(View.GONE);

                textRSRP.setVisibility(View.GONE);
                textRSRP0.setVisibility(View.GONE);

                textRSRQ.setVisibility(View.GONE);
                textRSRQ0.setVisibility(View.GONE);

                textSINR.setVisibility(View.GONE);
                textSINR0.setVisibility(View.GONE);

                setTitle("GSM Parameters");


                textLongitude0.setBackgroundColor(Color.parseColor("#8B4513"));
                textLongitude.setBackgroundColor(Color.parseColor("#8B4513"));

                textLatitude0.setBackgroundColor(Color.parseColor("#A0522D"));
                textLatitude.setBackgroundColor(Color.parseColor("#A0522D"));

                textCellID0.setBackgroundColor(Color.parseColor("#8B4513"));
                textCellID.setBackgroundColor(Color.parseColor("#8B4513"));

                textPLMN0.setBackgroundColor(Color.parseColor("#A0522D"));
                textPLMN.setBackgroundColor(Color.parseColor("#A0522D"));

                textRxLev0.setBackgroundColor(Color.parseColor("#8B4513"));
                textRxLev.setBackgroundColor(Color.parseColor("#8B4513"));

                textLAC0.setBackgroundColor(Color.parseColor("#A0522D"));
                textLAC.setBackgroundColor(Color.parseColor("#A0522D"));







            }else if(i instanceof CellInfoCdma){

                textStatus.setText(""+"UMTS CDMA");

                textRxLev.setVisibility(View.GONE);
                textRxLev0.setVisibility(View.GONE);

                textRSCP.setVisibility(View.GONE);
                textRSCP0.setVisibility(View.GONE);

                textRSSI.setVisibility(View.VISIBLE);
                textRSSI0.setVisibility(View.VISIBLE);

                textEC_N0.setVisibility(View.VISIBLE);
                textEC_N00.setVisibility(View.VISIBLE);

                textRSRP.setVisibility(View.GONE);
                textRSRP0.setVisibility(View.GONE);

                textRSRQ.setVisibility(View.GONE);
                textRSRQ0.setVisibility(View.GONE);

                textSINR.setVisibility(View.GONE);
                textSINR0.setVisibility(View.GONE);

                setTitle("UMTS CDMA Parameters");

                textLongitude0.setBackgroundColor(Color.parseColor("#8B4513"));
                textLongitude.setBackgroundColor(Color.parseColor("#8B4513"));

                textLatitude0.setBackgroundColor(Color.parseColor("#A0522D"));
                textLatitude.setBackgroundColor(Color.parseColor("#A0522D"));

                textCellID0.setBackgroundColor(Color.parseColor("#8B4513"));
                textCellID.setBackgroundColor(Color.parseColor("#8B4513"));

                textPLMN0.setBackgroundColor(Color.parseColor("#A0522D"));
                textPLMN.setBackgroundColor(Color.parseColor("#A0522D"));

                textEC_N00.setBackgroundColor(Color.parseColor("#8B4513"));
                textEC_N0.setBackgroundColor(Color.parseColor("#8B4513"));

                textRSSI0.setBackgroundColor(Color.parseColor("#A0522D"));
                textRSSI.setBackgroundColor(Color.parseColor("#A0522D"));

                textLAC0.setBackgroundColor(Color.parseColor("#8B4513"));
                textLAC.setBackgroundColor(Color.parseColor("#8B4513"));


            }else if(i instanceof CellInfoLte) {

                textStatus.setText(""+"LTE");

                textRxLev.setVisibility(View.GONE);
                textRxLev0.setVisibility(View.GONE);

                textRSCP.setVisibility(View.GONE);
                textRSCP0.setVisibility(View.GONE);

                textRSSI.setVisibility(View.GONE);
                textRSSI0.setVisibility(View.GONE);

                textEC_N0.setVisibility(View.GONE);
                textEC_N00.setVisibility(View.GONE);

                textRSRP.setVisibility(View.VISIBLE);
                textRSRP0.setVisibility(View.VISIBLE);

                textRSRQ.setVisibility(View.VISIBLE);
                textRSRQ0.setVisibility(View.VISIBLE);

                textSINR.setVisibility(View.VISIBLE);
                textSINR0.setVisibility(View.VISIBLE);

                setTitle("LTE Parameters");

                textLongitude0.setBackgroundColor(Color.parseColor("#8B4513"));
                textLongitude.setBackgroundColor(Color.parseColor("#8B4513"));

                textLatitude0.setBackgroundColor(Color.parseColor("#A0522D"));
                textLatitude.setBackgroundColor(Color.parseColor("#A0522D"));

                textCellID0.setBackgroundColor(Color.parseColor("#8B4513"));
                textCellID.setBackgroundColor(Color.parseColor("#8B4513"));

                textPLMN0.setBackgroundColor(Color.parseColor("#A0522D"));
                textPLMN.setBackgroundColor(Color.parseColor("#A0522D"));

                textRSRP0.setBackgroundColor(Color.parseColor("#8B4513"));
                textRSRP.setBackgroundColor(Color.parseColor("#8B4513"));

                textRSRQ0.setBackgroundColor(Color.parseColor("#A0522D"));
                textRSRQ.setBackgroundColor(Color.parseColor("#A0522D"));

                textSINR0.setBackgroundColor(Color.parseColor("#8B4513"));
                textSINR.setBackgroundColor(Color.parseColor("#8B4513"));

                textLAC0.setBackgroundColor(Color.parseColor("#A0522D"));
                textLAC.setBackgroundColor(Color.parseColor("#A0522D"));

                textLAC0.setText("RAC");

            }else if(i instanceof CellInfoWcdma){

                textStatus.setText(""+"UMTS WCDMA");

                textRxLev.setVisibility(View.GONE);
                textRxLev0.setVisibility(View.GONE);

                textRSCP.setVisibility(View.VISIBLE);
                textRSCP0.setVisibility(View.VISIBLE);

                textRSSI.setVisibility(View.GONE);
                textRSSI0.setVisibility(View.GONE);

                textEC_N0.setVisibility(View.GONE);
                textEC_N00.setVisibility(View.GONE);

                textRSRP.setVisibility(View.GONE);
                textRSRP0.setVisibility(View.GONE);

                textRSRQ.setVisibility(View.GONE);
                textRSRQ0.setVisibility(View.GONE);

                textSINR.setVisibility(View.GONE);
                textSINR0.setVisibility(View.GONE);

                setTitle("UMTS WCDMA Parameters");

                textLongitude0.setBackgroundColor(Color.parseColor("#8B4513"));
                textLongitude.setBackgroundColor(Color.parseColor("#8B4513"));

                textLatitude0.setBackgroundColor(Color.parseColor("#A0522D"));
                textLatitude.setBackgroundColor(Color.parseColor("#A0522D"));

                textCellID0.setBackgroundColor(Color.parseColor("#8B4513"));
                textCellID.setBackgroundColor(Color.parseColor("#8B4513"));

                textPLMN0.setBackgroundColor(Color.parseColor("#A0522D"));
                textPLMN.setBackgroundColor(Color.parseColor("#A0522D"));

                textRSCP0.setBackgroundColor(Color.parseColor("#8B4513"));
                textRSCP.setBackgroundColor(Color.parseColor("#8B4513"));

                textLAC0.setBackgroundColor(Color.parseColor("#A0522D"));
                textLAC.setBackgroundColor(Color.parseColor("#A0522D"));

            }else {
            }

        }

        handler.postDelayed(new Runnable(){

            public void run(){



                    GsmCellLocation gsmCellLocation = (GsmCellLocation) telephonyManager.getCellLocation();

                    String plmnId = telephonyManager.getNetworkOperator();
                    String lac = Integer.toString(gsmCellLocation.getLac());
                    String cellId = Integer.toString(gsmCellLocation.getCid());

                    List<CellInfo> infos = telephonyManager.getAllCellInfo();
                    CellInfo i = infos.get(0);
                    if (infos != null) {
                        if (infos.size() == 0) return;


                        if (i instanceof CellInfoGsm) {

                            textStatus.setText("" + "GSM");

                            textRxLev.setVisibility(View.VISIBLE);
                            textRxLev0.setVisibility(View.VISIBLE);

                            textRSCP.setVisibility(View.GONE);
                            textRSCP0.setVisibility(View.GONE);

                            textRSSI.setVisibility(View.GONE);
                            textRSSI0.setVisibility(View.GONE);

                            textEC_N0.setVisibility(View.GONE);
                            textEC_N00.setVisibility(View.GONE);

                            textRSRP.setVisibility(View.GONE);
                            textRSRP0.setVisibility(View.GONE);

                            textRSRQ.setVisibility(View.GONE);
                            textRSRQ0.setVisibility(View.GONE);

                            textSINR.setVisibility(View.GONE);
                            textSINR0.setVisibility(View.GONE);

                            setTitle("GSM Parameters");

                            textLongitude0.setBackgroundColor(Color.parseColor("#8B4513"));
                            textLongitude.setBackgroundColor(Color.parseColor("#8B4513"));

                            textLatitude0.setBackgroundColor(Color.parseColor("#A0522D"));
                            textLatitude.setBackgroundColor(Color.parseColor("#A0522D"));

                            textCellID0.setBackgroundColor(Color.parseColor("#8B4513"));
                            textCellID.setBackgroundColor(Color.parseColor("#8B4513"));

                            textPLMN0.setBackgroundColor(Color.parseColor("#A0522D"));
                            textPLMN.setBackgroundColor(Color.parseColor("#A0522D"));

                            textRxLev0.setBackgroundColor(Color.parseColor("#8B4513"));
                            textRxLev.setBackgroundColor(Color.parseColor("#8B4513"));

                            textLAC0.setBackgroundColor(Color.parseColor("#A0522D"));
                            textLAC.setBackgroundColor(Color.parseColor("#A0522D"));

                            CellInfoGsm cellinfoGsm = null;

                            cellinfoGsm = (CellInfoGsm) telephonyManager.getAllCellInfo().get(0);
                            CellSignalStrengthGsm cellSignalStrengthGsm = cellinfoGsm.getCellSignalStrength();
                            if (Build.VERSION.SDK_INT >= 18) {
                                rxlev = cellSignalStrengthGsm.getDbm();
                            }

                            l = getDataBase();
                            lastind = l.conecctionDao().getAll().size() - 1;
                            double lastUid1 = l.conecctionDao().getAll().get(lastind).getUid();
                            double lon1 = l.conecctionDao().getAll().get(lastind).getUE_longitude();
                            double lat1 = l.conecctionDao().getAll().get(lastind).getUE_latitude();
                            String lastPlmnId = l.conecctionDao().getAll().get(lastind).getCell_PLMN();
                            String lastLac = l.conecctionDao().getAll().get(lastind).getLAC();
                            String lastCellId = l.conecctionDao().getAll().get(lastind).getCellID();
                            double lastRxLev = l.conecctionDao().getAll().get(lastind).getRxLev();


                            textLongitude.setText("" + lon1);
                            textLatitude.setText("" + lat1);
                            textPLMN.setText("" + lastPlmnId);
                            textCellID.setText("" + lastCellId);
                            textLAC.setText("" + lastLac);


                            if (lastRxLev == 0) {
                                textRxLev.setText("" + "Loading...");
                            } else {
                                textRxLev.setText("" + lastRxLev);
                            }

                            lastIndex = l.conecctionDao().getAll().size() - 1;
                            int lastUid = l.conecctionDao().getAll().get(lastIndex).getUid();
                            ConnectionInfo data1 = new ConnectionInfo(lastUid + 1, longitude, latitude, plmnId, lac, "RAC", lac, cellId, 0, 0, 0, 0, 0, 0, rxlev);
                            l.conecctionDao().insertInfo(data1);

                        } else if (i instanceof CellInfoCdma) {

                            textStatus.setText("" + "UMTS CDMA");

                            textRxLev.setVisibility(View.GONE);
                            textRxLev0.setVisibility(View.GONE);

                            textRSCP.setVisibility(View.GONE);
                            textRSCP0.setVisibility(View.GONE);

                            textRSSI.setVisibility(View.VISIBLE);
                            textRSSI0.setVisibility(View.VISIBLE);

                            textEC_N0.setVisibility(View.VISIBLE);
                            textEC_N00.setVisibility(View.VISIBLE);

                            textRSRP.setVisibility(View.GONE);
                            textRSRP0.setVisibility(View.GONE);

                            textRSRQ.setVisibility(View.GONE);
                            textRSRQ0.setVisibility(View.GONE);

                            textSINR.setVisibility(View.GONE);
                            textSINR0.setVisibility(View.GONE);

                            setTitle("UMTS CDMA Parameters");

                            textLongitude0.setBackgroundColor(Color.parseColor("#8B4513"));
                            textLongitude.setBackgroundColor(Color.parseColor("#8B4513"));

                            textLatitude0.setBackgroundColor(Color.parseColor("#A0522D"));
                            textLatitude.setBackgroundColor(Color.parseColor("#A0522D"));

                            textCellID0.setBackgroundColor(Color.parseColor("#8B4513"));
                            textCellID.setBackgroundColor(Color.parseColor("#8B4513"));

                            textPLMN0.setBackgroundColor(Color.parseColor("#A0522D"));
                            textPLMN.setBackgroundColor(Color.parseColor("#A0522D"));

                            textEC_N00.setBackgroundColor(Color.parseColor("#8B4513"));
                            textEC_N0.setBackgroundColor(Color.parseColor("#8B4513"));

                            textRSSI0.setBackgroundColor(Color.parseColor("#A0522D"));
                            textRSSI.setBackgroundColor(Color.parseColor("#A0522D"));

                            textLAC0.setBackgroundColor(Color.parseColor("#8B4513"));
                            textLAC.setBackgroundColor(Color.parseColor("#8B4513"));

                            CellInfoCdma cellinfoCdma = null;

                            cellinfoCdma = (CellInfoCdma) telephonyManager.getAllCellInfo().get(0);
                            CellSignalStrengthCdma cellSignalStrengthCdma = cellinfoCdma.getCellSignalStrength();
                            if (Build.VERSION.SDK_INT >= 18) {
                                ec_n0 = cellSignalStrengthCdma.getEvdoEcio();
                                rssi = cellSignalStrengthCdma.getEvdoDbm();
                            }

                            l = getDataBase();
                            lastind = l.conecctionDao().getAll().size() - 1;
                            double lastUid1 = l.conecctionDao().getAll().get(lastind).getUid();
                            double lon1 = l.conecctionDao().getAll().get(lastind).getUE_longitude();
                            double lat1 = l.conecctionDao().getAll().get(lastind).getUE_latitude();
                            String lastPlmnId = l.conecctionDao().getAll().get(lastind).getCell_PLMN();
                            String lastLac = l.conecctionDao().getAll().get(lastind).getLAC();
                            String lastCellId = l.conecctionDao().getAll().get(lastind).getCellID();
                            double lastEc_N0 = l.conecctionDao().getAll().get(lastind).getEC_N0();
                            double lastRssi = l.conecctionDao().getAll().get(lastind).getRSSI();


                            textLongitude.setText("" + lon1);
                            textLatitude.setText("" + lat1);
                            textPLMN.setText("" + lastPlmnId);
                            textCellID.setText("" + lastCellId);
                            textLAC.setText("" + lastLac);


                            if (lastRssi == 0) {
                                textRSSI.setText("" + "Loading...");
                            } else {
                                textRSSI.setText("" + lastRssi);
                            }

                            if (lastEc_N0 == 0) {
                                textEC_N0.setText("" + "Loading...");
                            } else {
                                textEC_N0.setText("" + lastEc_N0);
                            }


                            lastIndex = l.conecctionDao().getAll().size() - 1;
                            int lastUid = l.conecctionDao().getAll().get(lastIndex).getUid();
                            ConnectionInfo data1 = new ConnectionInfo(lastUid + 1, longitude, latitude, plmnId, lac, "RAC", lac, cellId, 0, 0, 0, 0, ec_n0, rssi, 0);
                            l.conecctionDao().insertInfo(data1);


                        } else if (i instanceof CellInfoLte) {

                            textStatus.setText("" + "LTE");

                            textRxLev.setVisibility(View.GONE);
                            textRxLev0.setVisibility(View.GONE);

                            textRSCP.setVisibility(View.GONE);
                            textRSCP0.setVisibility(View.GONE);

                            textRSSI.setVisibility(View.GONE);
                            textRSSI0.setVisibility(View.GONE);

                            textEC_N0.setVisibility(View.GONE);
                            textEC_N00.setVisibility(View.GONE);

                            textRSRP.setVisibility(View.VISIBLE);
                            textRSRP0.setVisibility(View.VISIBLE);

                            textRSRQ.setVisibility(View.VISIBLE);
                            textRSRQ0.setVisibility(View.VISIBLE);

                            textSINR.setVisibility(View.VISIBLE);
                            textSINR0.setVisibility(View.VISIBLE);

                            setTitle("LTE Parameters");


                            textLongitude0.setBackgroundColor(Color.parseColor("#8B4513"));
                            textLongitude.setBackgroundColor(Color.parseColor("#8B4513"));

                            textLatitude0.setBackgroundColor(Color.parseColor("#A0522D"));
                            textLatitude.setBackgroundColor(Color.parseColor("#A0522D"));

                            textCellID0.setBackgroundColor(Color.parseColor("#8B4513"));
                            textCellID.setBackgroundColor(Color.parseColor("#8B4513"));

                            textPLMN0.setBackgroundColor(Color.parseColor("#A0522D"));
                            textPLMN.setBackgroundColor(Color.parseColor("#A0522D"));

                            textRSRP0.setBackgroundColor(Color.parseColor("#8B4513"));
                            textRSRP.setBackgroundColor(Color.parseColor("#8B4513"));

                            textRSRQ0.setBackgroundColor(Color.parseColor("#A0522D"));
                            textRSRQ.setBackgroundColor(Color.parseColor("#A0522D"));

                            textSINR0.setBackgroundColor(Color.parseColor("#8B4513"));
                            textSINR.setBackgroundColor(Color.parseColor("#8B4513"));

                            textLAC0.setBackgroundColor(Color.parseColor("#A0522D"));
                            textLAC.setBackgroundColor(Color.parseColor("#A0522D"));

                            textLAC0.setText("RAC");

                            CellInfoLte cellinfoLte = null;

                            cellinfoLte = (CellInfoLte) telephonyManager.getAllCellInfo().get(0);
                            CellSignalStrengthLte cellSignalStrengthLte = cellinfoLte.getCellSignalStrength();
                            if (Build.VERSION.SDK_INT >= 18) {
                                rsrp = cellSignalStrengthLte.getRsrp();
                                rsrq = cellSignalStrengthLte.getRsrq();
                                ss1 = Integer.parseInt(infos.get(0).toString().split(" ")[11].split("=")[1]);

                            }


                            l = getDataBase();
                            lastind = l.conecctionDao().getAll().size() - 1;
                            double lastUid1 = l.conecctionDao().getAll().get(lastind).getUid();
                            double lon1 = l.conecctionDao().getAll().get(lastind).getUE_longitude();
                            double lat1 = l.conecctionDao().getAll().get(lastind).getUE_latitude();
                            String lastPlmnId = l.conecctionDao().getAll().get(lastind).getCell_PLMN();
                            String lastLac = l.conecctionDao().getAll().get(lastind).getLAC();
                            String lastCellId = l.conecctionDao().getAll().get(lastind).getCellID();
                            double lastRsrp = l.conecctionDao().getAll().get(lastind).getRSRP();
                            double lastRsrq = l.conecctionDao().getAll().get(lastind).getRSRQ();
                            double lastSinr = l.conecctionDao().getAll().get(lastind).getSINR();


                            textLongitude.setText("" + lon1);
                            textLatitude.setText("" + lat1);
                            textPLMN.setText("" + lastPlmnId);
                            textCellID.setText("" + lastCellId);
                            textLAC.setText("" + lastLac);

                            if (lastRsrp == 0) {
                                textRSRP.setText("" + "Loading...");
                            } else {
                                textRSRP.setText("" + lastRsrp);
                            }

                            if (lastRsrq == 0) {
                                textRSRQ.setText("" + "Loading...");
                            } else {
                                textRSRQ.setText("" + lastRsrq);
                            }

                            if (lastSinr <= 0) {
                                textSINR.setText("" + "Loading...");
                            } else {
                                textSINR.setText("" + lastSinr);
                            }


                            lastIndex = l.conecctionDao().getAll().size() - 1;
                            int lastUid = l.conecctionDao().getAll().get(lastIndex).getUid();
                            ConnectionInfo data1 = new ConnectionInfo(lastUid + 1, longitude, latitude, plmnId, lac, "RAC", lac, cellId, rsrp, rsrq, ss1, 0, 0, 0, 0);
                            l.conecctionDao().insertInfo(data1);


                        } else if (i instanceof CellInfoWcdma) {

                            textStatus.setText("" + "UMTS WCDMA");

                            textRxLev.setVisibility(View.GONE);
                            textRxLev0.setVisibility(View.GONE);

                            textRSCP.setVisibility(View.VISIBLE);
                            textRSCP0.setVisibility(View.VISIBLE);

                            textRSSI.setVisibility(View.GONE);
                            textRSSI0.setVisibility(View.GONE);

                            textEC_N0.setVisibility(View.GONE);
                            textEC_N00.setVisibility(View.GONE);

                            textRSRP.setVisibility(View.GONE);
                            textRSRP0.setVisibility(View.GONE);

                            textRSRQ.setVisibility(View.GONE);
                            textRSRQ0.setVisibility(View.GONE);

                            textSINR.setVisibility(View.GONE);
                            textSINR0.setVisibility(View.GONE);

                            setTitle("UMTS WCDMA Parameters");

                            textLongitude0.setBackgroundColor(Color.parseColor("#8B4513"));
                            textLongitude.setBackgroundColor(Color.parseColor("#8B4513"));

                            textLatitude0.setBackgroundColor(Color.parseColor("#A0522D"));
                            textLatitude.setBackgroundColor(Color.parseColor("#A0522D"));

                            textCellID0.setBackgroundColor(Color.parseColor("#8B4513"));
                            textCellID.setBackgroundColor(Color.parseColor("#8B4513"));

                            textPLMN0.setBackgroundColor(Color.parseColor("#A0522D"));
                            textPLMN.setBackgroundColor(Color.parseColor("#A0522D"));

                            textRSCP0.setBackgroundColor(Color.parseColor("#8B4513"));
                            textRSCP.setBackgroundColor(Color.parseColor("#8B4513"));

                            textLAC0.setBackgroundColor(Color.parseColor("#A0522D"));
                            textLAC.setBackgroundColor(Color.parseColor("#A0522D"));

                            CellInfoWcdma cellinfoWcdma = null;

                            cellinfoWcdma = (CellInfoWcdma) telephonyManager.getAllCellInfo().get(0);
                            CellSignalStrengthWcdma cellSignalStrengthWcdma = cellinfoWcdma.getCellSignalStrength();
                            if (Build.VERSION.SDK_INT >= 18) {
                                rscp = cellSignalStrengthWcdma.getDbm();
                            }


                            l = getDataBase();
                            lastind = l.conecctionDao().getAll().size() - 1;
                            double lastUid1 = l.conecctionDao().getAll().get(lastind).getUid();
                            double lon1 = l.conecctionDao().getAll().get(lastind).getUE_longitude();
                            double lat1 = l.conecctionDao().getAll().get(lastind).getUE_latitude();
                            String lastPlmnId = l.conecctionDao().getAll().get(lastind).getCell_PLMN();
                            String lastLac = l.conecctionDao().getAll().get(lastind).getLAC();
                            String lastCellId = l.conecctionDao().getAll().get(lastind).getCellID();
                            double lastRscp = l.conecctionDao().getAll().get(lastind).getRSCP();

                            textLongitude.setText("" + lon1);
                            textLatitude.setText("" + lat1);
                            textPLMN.setText("" + lastPlmnId);
                            textCellID.setText("" + lastCellId);
                            textLAC.setText("" + lastLac);
                            if (lastRscp == 0) {
                                textRSCP.setText("" + "Loading...");
                            } else {
                                textRSCP.setText("" + lastRscp);
                            }


                            lastIndex = l.conecctionDao().getAll().size() - 1;
                            int lastUid = l.conecctionDao().getAll().get(lastIndex).getUid();
                            ConnectionInfo data1 = new ConnectionInfo(lastUid + 1, longitude, latitude, plmnId, lac, "RAC", lac, cellId, 0, 0, 0, rscp, 0, 0, 0);
                            l.conecctionDao().insertInfo(data1);


                        } else {
                        }

                    }


                    handler.postDelayed(this, delay);


            }
        }, delay);

    }



    public boolean onOptionsItemSelected(MenuItem item){
        onBackPressed();
        return true;
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


//        if ( ContextCompat.checkSelfPermission( this, android.Manifest.permission.ACCESS_COARSE_LOCATION ) != PackageManager.PERMISSION_GRANTED ) {
//
//                    ActivityCompat.requestPermissions( this, new String[] {  android.Manifest.permission.ACCESS_COARSE_LOCATION  },
//                    LocationService.MY_PERMISSION_ACCESS_COURSE_LOCATION );
//        }







}