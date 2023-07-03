package com.servlet;

import com.SQLconnect.DBUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "showimage", value = "/showimage")
public class showimage extends HttpServlet {
    public final long serialVersionUID = 1L;

    public byte[] getImageData(String devicecode) throws SQLException, IOException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;


            DBUtil dbUtil = new DBUtil();
            conn = dbUtil.getConnection();

            String sql = "SELECT fileName FROM deviceinfo WHERE devicecode = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1,devicecode);

            rs = stmt.executeQuery();

            if(!rs.next()){
               return null;
            }

            String filename = rs.getString("fileName");
        File file = new File("uploads/" + filename);
        FileInputStream fin = new FileInputStream(file);
        byte[] data = new byte[(int)file.length()];
        try {
            int bytesRead;
            int offset = 0;
            while (offset < data.length && (bytesRead = fin.read(data, offset, data.length - offset)) >= 0) {
                offset += bytesRead;
            }
        } finally {
            fin.close();
        }

        return data;

    }

    public String getFileName(String deviceCode) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            DBUtil dbUtil = new DBUtil();
            conn = dbUtil.getConnection();

            // 创建SQL语句并参数化设备编码
            String sql = "SELECT fileName FROM deviceinfo WHERE deviceCode = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, deviceCode);

            // 执行SQL语句并获取结果
            rs = stmt.executeQuery();

            // 如果能够获取结果，则返回文件名
            if (rs.next()) {
                String fileName = rs.getString("fileName");
                System.out.println(fileName);
                return "uploads/" + fileName;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeConnection(conn, stmt, rs);
        }

        // 如果无法获取文件名，则返回 null
        return null;
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String devicecode = request.getParameter("devicecode");

        try {
            byte[] imageData = getImageData(devicecode);
            if(imageData == null){
                response.sendError(HttpServletResponse.SC_NOT_FOUND,"Could not find PNG image for device " + devicecode);
                return;
            }

            String fileName = getFileName(devicecode);

            response.setContentType(getServletContext().getMimeType(fileName));
            response.setContentLength(imageData.length);

            OutputStream out = response.getOutputStream();
            out.write(imageData);
            out.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}