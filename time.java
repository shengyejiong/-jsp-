package com.example;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class time {
    public static String formatDateTime(Timestamp timestamp) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return dateFormat.format(timestamp);
    }

}
