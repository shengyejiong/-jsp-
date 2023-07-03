<%--
  Created by IntelliJ IDEA.
  User: 夜迥
  Date: 2023/6/3
  Time: 16:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.* "%>
<%@ page import="java.util.ArrayList" %>
<html>
<head>
    <title>搜索结果</title>
</head>
<body>

<h1>查询结果：</h1>
<table>
  <tr>
    <th colspan="1" class="btbg font-center titfont" rowspan="2">站点名称</th>
    <th width="10%" class="btbg font-center titfont" rowspan="2">设备名称</th>
    <th width="10%" class="btbg font-center titfont" rowspan="2">设备编码</th>
    <th width="10%" class="btbg font-center titfont" rowspan="2">设备分类</th>
    <th>设备类型</th>
    <th>安装时间<br></th>
    <th>设备状态</th>
  </tr>
  <tbody id ="body1">
  <%
    ArrayList<String[]>records = (ArrayList<String[]>) request.getAttribute("record");
    for(String[]record:records){
   %>
  <tr>
    <td><%=record[0]%></td>
    <td><%=record[1]%></td>
    <td><%=record[2]%></td>
    <td><%=record[3]%></td>
    <td><%=record[4]%></td>
    <td><%=record[5]%></td>
    <td><%=record[6]%></td>
  </tr>
  <%
    }
  %>

  </tbody>
</table>
  <form action="${pageContext.request.contextPath}/equipmentList.jsp">
    <input type="submit" value="返回">
  </form>

</body>
</html>
