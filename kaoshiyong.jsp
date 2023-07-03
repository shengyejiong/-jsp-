<%--
  Created by IntelliJ IDEA.
  User: 夜迥
  Date: 2023/6/27
  Time: 16:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%! double a = 1;%>
<%  double b= 0;%>
<%!
    double increase(double x, double y) { return x+y; }
%>
<html>
<head>
    <h1> <%="local counter1:" + (++b) %></h1>
    <h1> <%="member counter2:" + increase(a,b) %></h1>
</head>
<body>

</body>
</html>
