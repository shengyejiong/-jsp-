package com.servlet;

import com.SQLconnect.DBUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "deleteinfo", value = "/deleteinfo")
public class deleteinfo extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String devicecode = request.getParameter("deviceCode");
        Connection conn = null;
        PreparedStatement ps = null;
        DBUtil dbUtil = new DBUtil();

        try{
            conn = dbUtil.getConnection();
            String sql = "DELETE FROM deviceinfo WHERE deviceCode = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1,devicecode);
            int rowCount = ps.executeUpdate();
            if(rowCount > 0){
                response.setStatus(HttpServletResponse.SC_OK);
            }else{
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }

        }catch (SQLException e){
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }finally {
            try {
                DBUtil.closeConnection(conn,ps,null);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}