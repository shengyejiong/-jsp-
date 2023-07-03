package com.SQLconnect;

import java.sql.*;

public class DBUtil {

    final String driver ="com.mysql.jdbc.Driver";
    final String url = "jdbc:mysql://localhost:3306/deviceinfo?characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai&rewriteBatchedStatements=true";
    final String user = "test";
    final String pwd = "123456";

    public void load(){
        try {
            Class.forName(driver);
        }catch (ClassNotFoundException e){
            e.printStackTrace();
        }
    }

    public Connection getConnection(){
        load();

        Connection conn = null;

        try{
            conn = DriverManager.getConnection(url,user,pwd);
            return conn;
        }catch (SQLException e){
            throw new RuntimeException("连接数据库失败",e);
        }
    }

    public static void closeConnection(Connection con, PreparedStatement ps, ResultSet rs)throws SQLException{
        if(rs!=null){
            rs.close();
        }
        if(ps!=null){
            ps.close();
        }
        if(con!=null){
            con.close();
        }
    }

}
