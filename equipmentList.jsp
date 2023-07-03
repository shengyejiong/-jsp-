<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@page import="java.sql.*" %>
<%@page import="com.example.time" %>
<%@ page import="com.SQLconnect.DBUtil" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我读个数据表</title>
    <style>

    .button {
        background-color: #4CAF50;
        border: none;
        color: white;
        padding: 15px 32px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 4px 2px;
        cursor: pointer;
    }

    body
    {
        background-image:url('image1.png');
    } 

    table,td,th
    {
      border: 1px solid green;
    }
    th
    {
      background-color: green;
      color: lavender;
    }

    a:link,a:visited
    {
      display:block;
      font-weight:bold;
      color:#FFFFFF;
      background-color:#98bf21;
      width:120px;
      text-align:center;
      padding:4px;
      text-decoration:none;
    }
    a:hover,a:active
    {
      background-color:#7A991A;
    }

    input[type=text], select {
      width: 100%;
      padding: 12px 20px;
      margin: 8px 0;
      display: inline-block;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box;
}
    .mingzi{
        margin-top: 50px;
        color:blue;
        font-size:20px ;
    }

    </style>
</head>

<script type="text/javascript">

    var a = 0;//定义一个判断全局变量
    function opennewWindow(url,width,height){
        var leftPosition,topPosition;
        var newWindow;

        leftPosition = (window.screen.width-width)/2;
        topPosition = (window.screen.height - height)/2;

        newWindow = window.open(url,"newWindow","width"+width+",height="+height+",top"+topPosition+",left="+leftPosition);
        if(!newWindow){
            alert("弹出窗口被拦截！");
        }
    }

</script>

<body>

    <h2 class="mingzi">查询条件</h2>
    <form action="justsearch">
        <label>
            站点名称
            <input type="text" name="sitename">
        </label>
        <label>
            设备名称
            <input type="text" name="devicename">
        </label>

        <input type="submit" value="搜索" class="button" id="search">
        <input type="button" value="新增" class="button" id="new" onclick="opennewWindow('addnewinfo.jsp',500,500)">
    </form>

    <%
        try{
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();
        Statement st = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM deviceinfo";
        st = conn.createStatement();
        rs = st.executeQuery(sql);


    %>
    <table id="myTable" border="1" width="100%" border="0" cellspacing="1" cellpadding="4" bgcolor="#cccccc" class="tabtop13" align="center">


          <tr>
            <th colspan="1" class="btbg font-center titfont" rowspan="2">站点名称</th>
            <th width="10%" class="btbg font-center titfont" rowspan="2">设备名称</th>
            <th width="10%" class="btbg font-center titfont" rowspan="2">设备编码</th>
            <th width="10%" class="btbg font-center titfont" rowspan="2">设备分类</th>
            <th>设备类型</th>
            <th>安装时间<br></th>
            <th>设备状态</th>
            <th>操作</th>
          </tr>
        <tbody id = "tbody1">
        <%while (rs.next()){
            %>
        <%
            Timestamp installTime = rs.getTimestamp("installTime");
            long timestamp = installTime.getTime();
        %>
            <tr>
                <td><%=rs.getString("siteName")%></td>
                <td><%=rs.getString("deviceName")%></td>
                <td><%=rs.getString("deviceCode")%></td>
                <td><%=rs.getString("deviceCategory")%></td>
                <td><%=rs.getString("deviceType")%></td>
                <td><%=time.formatDateTime(installTime)%></td>
                <td><%=rs.getString("deviceState")%></td>

                <td><a href="javascript:;" onclick = opennewWindow('editinfo.jsp?sitename=<%=rs.getString("siteName")%>&devicename=<%=rs.getString("deviceName")%>&devicecode=<%=rs.getString("deviceCode")%>&devicecategory=<%=rs.getString("deviceCategory")%>&devicetype=<%=rs.getString("deviceType")%>&installtime=<%=timestamp%>&devicestate=<%=rs.getString("deviceState")%>',500,500)>修改</a>
                    <a href="javascript:;" onclick = "deleteDevice('<%=rs.getString("deviceCode")%>')">删除</a></td>
            </tr>
        <%
        }
        try {
            dbUtil.closeConnection(conn, (PreparedStatement) st,rs);
        }catch (SQLException e){
            e.printStackTrace();
        }
            }catch (Exception e){
            e.printStackTrace();
        }
        %>
        </tbody>
    </table>
      <br/><br/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function deleteDevice(deviceCode) {
            if (confirm("确认删除设备信息？该操作不可撤销！")) {
                // 向服务器发送删除请求
                $.ajax({
                    url: "deleteinfo",
                    method: "POST",
                    data: {
                        deviceCode: deviceCode
                    },
                    success: function(data) {
                        // 删除成功后刷新页面
                        location.reload();
                    },
                    error: function() {
                        alert("删除设备信息失败！");
                    }
                });
            }
        }
    </script>

      


    
</body>

<script src="beijing.js"></script>
<canvas class="fireworks" style="position:fixed;left:0;top:0;z-index:99999999;pointer-events:none;"></canvas>
<script type="text/javascript" src="https://rnmcnm.com/meihua/dianjibaozha/dianjibaozha.js"></script>
<script src="https://rnmcnm.com/meihua/yinghuapiaoluo/yinghuapiaoluo.js"></script>
    
</html>