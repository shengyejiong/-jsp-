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

@WebServlet(name = "addnewinfo", value = "/addnewinfo")
@MultipartConfig
public class addnewinfo extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String portname = request.getParameter("sitename");
        String devicename = request.getParameter("devicename");
        String number = request.getParameter("num");
        String vary = request.getParameter("vary");
        String type = request.getParameter("check");
        String time = request.getParameter("installtime");
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
        try{
            DBUtil dbUtil = new DBUtil();
            conn = dbUtil.getConnection();
            String checksql = "SELECT COUNT(*) FROM deviceinfo WHERE deviceCode=?";
            PreparedStatement checkps = conn.prepareStatement(checksql);
            checkps.setString(1,number);
            ResultSet rs = checkps.executeQuery();
            rs.next();
            int count = rs.getInt(1);
            if(count>0){
                PrintWriter writer = response.getWriter();
                writer.println("<html>");
                writer.println("<head>");
                writer.println("<meta charset=\"UTF-8\">");
                writer.println("<title>插入失败</title>");
                writer.println("</head>");
                writer.println("<body>");
                writer.println("<script type=\"text/javascript\">");
                writer.println("alert('设备编号已经存在，请检查后再试！');");
                writer.println("window.history.back();"); // 返回上一页
                writer.println("</script>");
                writer.println("</body>");
                writer.println("</html>");
                return;
            }
        }catch (SQLException e){
            e.printStackTrace();
        }


        try{

            String sql = "INSERT INTO deviceinfo(siteName,deviceName,deviceCode,deviceCategory,deviceType,installTime,fileName,deviceState) values (?,?,?,?,?,?,?,?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1,portname);
            ps.setString(2,devicename);
            ps.setString(3,number);
            ps.setString(4,vary);
            ps.setString(5,type);
            ps.setString(6,time);
            ps.setString(7,filename);
            ps.setString(8,state);
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

            response.setContentType("text/html;chaset=UTF-8");
            PrintWriter writer = response.getWriter();
            writer.println("<html>");
            writer.println("<head>");
            writer.println("<meta charset=\"UTF-8\">");
            writer.println("<title>插入成功</title>");
            writer.println("</head>");
            writer.println("<body>");
            writer.println("<script type=\"text/javascript\">");
            writer.println("alert('插入成功！');");
            writer.println("window.close();"); // 关闭当前窗口
            writer.println("window.opener.location.reload();"); // 刷新父窗口
            writer.println("</script>");
            writer.println("</body>");
            writer.println("</html>");
        }catch (SQLException e){
                e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "插入数据失败：" + e.getMessage());
        }finally {
            if(inputStream!=null){
                inputStream.close();
            }
        }
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}