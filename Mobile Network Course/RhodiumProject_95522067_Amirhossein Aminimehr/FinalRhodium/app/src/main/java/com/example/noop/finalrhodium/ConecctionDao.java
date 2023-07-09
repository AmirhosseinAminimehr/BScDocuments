package com.example.noop.finalrhodium;

import android.arch.persistence.room.Dao;
import android.arch.persistence.room.Database;
import android.arch.persistence.room.Delete;
import android.arch.persistence.room.Insert;
import android.arch.persistence.room.Query;
import android.arch.persistence.room.Room;
import android.arch.persistence.room.RoomDatabase;
import android.arch.persistence.room.Update;
import android.content.Context;

import java.util.List;

/**
 * Created by $noop on 5/14/2020.
 */


@Dao
public interface ConecctionDao {

    @Query("SELECT * FROM connectionInfo7")
    List<ConnectionInfo> getAll();

    //@Query("SELECT * FROM connectionInfo where first_name LIKE  :firstName AND last_name LIKE :lastName")
    //ConnectionInfo findByName(String firstName, String lastName);

    @Query("SELECT COUNT(*) from connectionInfo7")
    int countUsers();

    @Insert
    void insertInfo(ConnectionInfo connectionInfo);

    @Update
    void updateInfo(ConnectionInfo connectionInfo);

    @Delete
    void deleteInfo(ConnectionInfo connectionInfo);

    @Insert
    void insertAll(ConnectionInfo... connectionInfos);

    @Delete
    void delete(ConnectionInfo connectionInfo);
}


