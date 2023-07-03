package com.servlet;

import com.SQLconnect.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet("/justsearch")
public class justsearch extends HttpServlet {


    private static final long serialVersionUID = 1L;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String site = request.getParameter("sitename");
        String device = request.getParameter("devicename");

        ArrayList<String[]> records = queryDatabase(site,device);

        request.setAttribute("record",records);

        request.getRequestDispatcher("/search.jsp").forward(request,response);

    }
        private ArrayList<String[]> queryDatabase(String site,String device){
            ArrayList<String[]> records = new ArrayList<String[]>();


        String sql = "SELECT * FROM deviceinfo WHERE siteName = ? OR deviceName = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try{
            DBUtil dbUtil = new DBUtil();
            conn = dbUtil.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1,site);
            ps.setString(2,device);
            rs = ps.executeQuery();

            while(rs.next()){
                String[] record = new String[7];
                record[0] = rs.getString("siteName");
                record[1] = rs.getString("deviceName");
                record[2] = rs.getString("deviceCode");
                record[3] = rs.getString("deviceCategory");
                record[4] = rs.getString("deviceType");
                record[5] = rs.getString("installTime");
                record[6] = rs.getString("deviceState");
                records.add(record);

            }

        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            try{
                DBUtil.closeConnection(conn,ps,rs);
            }catch (SQLException e){
                e.printStackTrace();
            }
        }
        return records;
        }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}