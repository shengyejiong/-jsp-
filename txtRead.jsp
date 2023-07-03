<%--
  Created by IntelliJ IDEA.
  User: 夜迥
  Date: 2023/5/15
  Time: 14:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Objects" %>

<html>
<head>
    <title>Read</title>
</head>
<body>

    <%
        String path = request.getSession().getServletContext().getRealPath("/");
            File file = new File(path, "equipmentList.txt");


        FileReader fr = new FileReader(file);//字符输入流
        BufferedReader br = new BufferedReader(fr);//使文件可按行读取并具有缓冲功能
        StringBuffer strB = new StringBuffer(); //strB用来存储jsp.txt文件里的内容
        String str = br.readLine();

        while(str!=null){
            strB.append(str).append("<br>");
            str = br.readLine();
        }
        br.close();
    %>

    <div style="text-align: center;">
        <%=strB%>
    </div>


</body>
</html>
