package com.example;

import com.SQLconnect.DBUtil;

import java.sql.*;

public class getImage {

    public static String getImageURL(String devicecode)throws SQLException,ClassNotFoundException{
        String fileName = "";

        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

        String sql="SELECT fileName FROM deviceinfo WHERE deviceCode= ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1,devicecode);
        ResultSet rs = stmt.executeQuery();

        if(rs.next()){
            fileName = rs.getString("fileName");
        }

        DBUtil.closeConnection(conn,stmt,rs);
        return "/uploads/" + fileName;
    }

}
