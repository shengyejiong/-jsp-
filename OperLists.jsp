<%@ page import="java.util.List" %>
<%@ page import="bean.Company" %><%--
  Created by IntelliJ IDEA.
  User: 夜迥
  Date: 2023/5/17
  Time: 14:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>操作信息</title>
</head>
<body>
<%
    List<Company> addinfos = (List<Company>) session.getAttribute("addinfos");
%>
<%
    List<Company> olddata = (List<Company>) session.getAttribute("oldinfo");
    List<Company> newdata = (List<Company>) session.getAttribute("newinfo");
%>
<%
    List<Company> delete = (List<Company>) session.getAttribute("deletedongxi");
%>
<h2>新增操作信息</h2>
<table>
   <thead>
   <tr>
       <th>站点名称</th>
       <th>设备名称</th>
       <th>设备编码</th>
       <th>设备分类</th>
       <th>设备类型</th>
       <th>安装时间<br></th>
       <th>设备状态</th>
   </tr>
   </thead>
    <tbody>
    <%
        if(addinfos != null){
            for(int i=0;i<addinfos.size();i++){
                Company addinfo = addinfos.get(i);
    %>

    <tr>
        <td><%=addinfo.getDesname()%></td>
        <td><%=addinfo.getMacname()%></td>
        <td><%=addinfo.getMaccode()%></td>
        <td><%=addinfo.getMacvary()%></td>
        <td><%=addinfo.getMactype()%></td>
        <td><%=addinfo.getInstalltime()%></td>
        <td><%=addinfo.getMacstate()%></td>
    </tr>

       <%     }
        }
    %>

    </tbody>
</table>

<h2>删除操作信息</h2>
<table>
    <thead>
    <tr>
        <th>站点名称</th>
        <th>设备名称</th>
        <th>设备编码</th>
        <th>设备分类</th>
        <th>设备类型</th>
        <th>安装时间<br></th>
        <th>设备状态</th>
    </tr>
    </thead>
    <tbody>
        <%
            if(delete != null){
                for(int i= i =0;i<delete.size();i++){
                    Company shanchu = delete.get(i);%>
        <tr>
            <td><%=shanchu.getDesname()%></td>
            <td><%=shanchu.getMacname()%></td>
            <td><%=shanchu.getMaccode()%></td>
            <td><%=shanchu.getMacvary()%></td>
            <td><%=shanchu.getMactype()%></td>
            <td><%=shanchu.getInstalltime()%></td>
            <td><%=shanchu.getMacstate()%></td>
        </tr>
        <%    }
        }
        %>
    </tbody>
</table>
<h2>编辑操作信息</h2>
    <table>
        <thead>
        <tr>
            <th>站点名称</th>
            <th>设备名称</th>
            <th>设备编码</th>
            <th>设备分类</th>
            <th>设备类型</th>
            <th>安装时间<br></th>
            <th>设备状态</th>
        </tr>
        </thead>
        <tbody>
        <%
            if(olddata != null){
                for(int i=0;i<olddata.size();i++){
                    Company laodongxi = olddata.get(i);
                %>
            <tr>
                <td><%=laodongxi.getDesname()%></td>
                <td><%=laodongxi.getMacname()%></td>
                <td><%=laodongxi.getMaccode()%></td>
                <td><%=laodongxi.getMacvary()%></td>
                <td><%=laodongxi.getMactype()%></td>
                <td><%=laodongxi.getInstalltime()%></td>
                <td><%=laodongxi.getMacstate()%></td>
                <td>旧值</td>
            </tr>

           <%     }
            }
        %>
        <%
            if(newdata != null){
                for (int i =0;i< newdata.size();i++){
                    Company xiaodongxi = newdata.get(i);
                %>
             <tr>
                 <td><%=xiaodongxi.getDesname()%></td>
                 <td><%=xiaodongxi.getMacname()%></td>
                 <td><%=xiaodongxi.getMaccode()%></td>
                 <td><%=xiaodongxi.getMacvary()%></td>
                 <td><%=xiaodongxi.getMactype()%></td>
                 <td><%=xiaodongxi.getInstalltime()%></td>
                 <td><%=xiaodongxi.getMacstate()%></td>
                 <td>新值</td>
             </tr>
        <%
                }
            }
        %>


        </tbody>
    </table>

</body>
</html>
