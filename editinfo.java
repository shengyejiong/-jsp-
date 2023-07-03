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

@WebServlet(name = "editinfo", value = "/editinfo")
@MultipartConfig
public class editinfo extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String sitename = request.getParameter("portname");
        String devicename = request.getParameter("devicename");
        String devicecode = request.getParameter("num");
        String vary = request.getParameter("vary");
        String type = request.getParameter("check");
        String installtime = request.getParameter("installtime");
        String state = request.getParameter("now");

        InputStream inputStream = null;
        String filename = null;
        Part filePart = request.getPart("imageFile");
        if(filePart!=null){
            filename = filePart.getSubmittedFileName();
            inputStream = filePart.getInputStream();
        }

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int deviceID = -1;//先初始化为无效ID
        DBUtil dbUtil = new DBUtil();
        try{
            conn = dbUtil.getConnection();
            String sql = "SELECT deviceId from deviceinfo WHERE deviceCode=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1,devicecode);
            rs = ps.executeQuery();
            if(rs.next()){
                deviceID = rs.getInt("deviceId");
            }
        }catch (SQLException e){
            e.printStackTrace();;
        }finally {
            try {
                DBUtil.closeConnection(conn,ps,rs);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        if (deviceID == -1) {
            // 如果设备不存在，则给出错误提示
            System.out.println("设备不存在！");
            request.getRequestDispatcher("/equipmentList.jsp").forward(request, response);
        }else{
            conn = null;
            ps = null;
            rs = null;

            try{
                conn = dbUtil.getConnection();
                String sql = "UPDATE deviceinfo SET siteName=?,deviceName=?,devicecode=?,deviceCategory=?,deviceType=?,installTime=?,fileName=?,deviceState=? WHERE deviceId=?";
                ps = conn.prepareStatement(sql);
                ps.setString(1,sitename);
                ps.setString(2,devicename);
                ps.setString(3,devicecode);
                ps.setString(4,vary);
                ps.setString(5,type);
                ps.setString(6,installtime);
                ps.setString(7,filename);
                ps.setString(8,state);
                ps.setInt(9,deviceID);
                ps.executeUpdate();

                if(filename!=null&&inputStream!=null){
                    File uploadedFile = new File(getServletContext().getRealPath("/uploads"),filename);
                    try(OutputStream outputStream = new FileOutputStream(uploadedFile)){
                        byte[] buffer = new byte[1024];
                        int byteRead = 0;
                        while ((byteRead = inputStream.read(buffer))!=-1){
                            outputStream.write(buffer,0,byteRead);
                        }
                    }
                }
            }catch (SQLException e){
                e.printStackTrace();
            }finally {
                if(inputStream!=null){
                    inputStream.close();
                }
                try {
                    DBUtil.closeConnection(conn,ps,rs);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }

            response.setContentType("text/html;chaset=UTF-8");
            PrintWriter writer = response.getWriter();
            writer.println("<html>");
            writer.println("<head>");
            writer.println("<meta charset=\"UTF-8\">");
            writer.println("<title>修改成功</title>");
            writer.println("</head>");
            writer.println("<body>");
            writer.println("<script type=\"text/javascript\">");
            writer.println("alert('修改成功！');");
            writer.println("window.close();"); // 关闭当前窗口
            writer.println("window.opener.location.reload();"); // 刷新父窗口
            writer.println("</script>");
            writer.println("</body>");
            writer.println("</html>");
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}