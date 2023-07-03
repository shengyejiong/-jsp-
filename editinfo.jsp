<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.SQLconnect.DBUtil" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@page import="com.example.getImage" %><%--
  Created by IntelliJ IDEA.
  User: 夜迥
  Date: 2023/6/4
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>fuck u</title>
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
<body>
<h1>请输入</h1>
<script src="beijing.js"></script>
<canvas class="fireworks" style="position:fixed;left:0;top:0;z-index:99999999;pointer-events:none;"></canvas>
<script type="text/javascript" src="https://rnmcnm.com/meihua/dianjibaozha/dianjibaozha.js"></script>
<script src="https://rnmcnm.com/meihua/yinghuapiaoluo/yinghuapiaoluo.js"></script>
<script type="text/javascript">

    function isLoopYear(x){
        if((x%4==0 && x%100!=0)||(x%100==0 && x%400==0)){
            return 1;
        }else{
            return 0;
        }
    }

    function timeinputalarm(){
//添加数据函数
        var device = document.getElementById('devicename').value;
        var bianma = document.getElementById('num').value;

        if(device == ""){
            alert("设备名称不能为空！")
            return false;
        }

        if(bianma == ""){
            alert("设备编码不能为空！")
            return false;
        }

        var strinputdate=document.forms["table2"]["installtime"].value;
        var DA = [0,31,28,31,30,31,30,31,31,30,31,30,31];
        var strdate = strinputdate.replace(/-/g,"/");// /g代表全局,即全部都要替换 双引号里则是替换后的字符


        //解决格式不是年月日的情况
        if(strdate.indexOf("/") == -1){
            alert("安装时间格式必须是yyyy-MM-dd HH:mm:ss")
            return false;
        }

        //检查时间
        if(strdate.indexOf(":") == -1){
            alert("时间格式错误！（请检查是否输入的是英文冒号）")
            return false;
        }
        main = strdate.split(" ");
        //解决有一个中文冒号或者格式错误的情况
        arrt = main[1].split(":");
        if(arrt.length!=3){
            alert("时间格式错误！（请检查是否输入的是英文冒号）")
            return false
        }

        //分解年月日 解决年月日不齐的情况
        arrD = main[0].split("/");
        if(arrD.length!=3){
            alert("安装时间格式必须是yyyy-MM-dd HH:mm:ss")
            return false
        }

        y = parseInt(arrD[0],10);
        m = parseInt(arrD[1],10);
        d = parseInt(arrD[2],10);//把日期转换为整数

        //解决日期中输入字母的情况
        if(isNaN(arrD[0])||isNaN(arrD[1])||isNaN(arrD[2])){
            alert("日期只能是数字！")
            return false;
        }
        //月份是否在1-12之间
        if(m>12||m<1){
            alert("月份错误！")
            return false;
        }
        //判断输入天数是否超过当月总天数
        if(d > DA[m]){
            alert("日期错误！")
            return false;
        }
        console.log("Hello, world!");
        var f = document.forms[0];
        f.action="editinfo"
        f.submit();

    }

    function baocun(){
        return timeinputalarm();
    }

    function showImage(){
        console.log("imageFile")
        var file = document.getElementById("imageFile").files[0];
        var reader = new FileReader();
        reader.onload = function (e){
            var img = document.createElement("img");
            img.src = e.target.result;
            img.id = "uploadedImage";
            document.body.appendChild(img);
        }
        reader.readAsDataURL(file);
    }

    function removeImage(){
        var imgElem = document.getElementById("uploadedImage");
        if(imgElem){
            imgElem.parentNode.removeChild(imgElem);
            var fileElem = document.getElementById("imageFile");
            fileElem.value = "";
        }
    }

</script>

<form name="table2"  method="post" action="editinfo" enctype="multipart/form-data">

    <tr>
        <th>站点名称(*)</th>
        <select name="portname" id="portname">
            <option value="昌都生态监测站" <%= request.getParameter("sitename").equals("昌都生态监测站") ? "selected" : "" %>>昌都生态监测站</option>
            <option value="申扎生态监测站" <%= request.getParameter("sitename").equals("申扎生态监测站") ? "selected" : "" %>>申扎生态监测站</option>
            <option value="日喀则生态监测站" <%= request.getParameter("sitename").equals("日喀则生态监测站") ? "selected" : "" %>>日喀则生态监测站</option>
            <option value="定日生态监测站" <%= request.getParameter("sitename").equals("定日生态监测站") ? "selected" : "" %>>定日生态监测站</option>
            <option value="山南生态观测站" <%= request.getParameter("sitename").equals("山南生态观测站") ? "selected" : "" %>>山南生态观测站</option>
            <option value="那曲生态监测站" <%= request.getParameter("sitename").equals("那曲生态监测站") ? "selected" : "" %>>那曲生态监测站</option>
            <option value="改则生态监测站" <%= request.getParameter("sitename").equals("改则生态监测站") ? "selected" : "" %>>改则生态监测站</option>
            <option value="芒康生态监测站" <%= request.getParameter("sitename").equals("芒康生态监测站") ? "selected" : "" %>>芒康生态监测站</option>
        </select>
    </tr>
    <br>

    <tr>
        <th>设备名称(*)</th>
        <td><input type="text" name="devicename" id="devicename" value="<%=request.getParameter("devicename")%>"/></td>
        <br>
    </tr>

    <tr>
        <td>设备编码(*)(不支持修改！）</td>
        <td><input type="text" name="num" id="num" value="<%=request.getParameter("devicecode")%>"/></td>
        <br></tr>

    <tr>
        <td>设备分类</td>
        <select name="vary" id="vary">
            <option value="土壤" <%= request.getParameter("devicecategory").equals("土壤") ? "selected" : "" %>>土壤</option>
            <option value="1" <%= request.getParameter("devicecategory").equals("1") ? "selected" : "" %>>1</option>
            <option value="2" <%= request.getParameter("devicecategory").equals("2") ? "selected" : "" %>>2</option>
            <option value="3" <%= request.getParameter("devicecategory").equals("3") ? "selected" : "" %>>3</option>
            <option value="4" <%= request.getParameter("devicecategory").equals("4") ? "selected" : "" %>>4</option>
            <option value="5" <%= request.getParameter("devicecategory").equals("5") ? "selected" : "" %>>5</option>
            <option value="6" <%= request.getParameter("devicecategory").equals("6") ? "selected" : "" %>>6</option>
            <option value="7" <%= request.getParameter("devicecategory").equals("7") ? "selected" : "" %>>7</option>
            <option value="8" <%= request.getParameter("devicecategory").equals("8") ? "selected" : "" %>>8</option>
            <option value="9" <%= request.getParameter("devicecategory").equals("9") ? "selected" : "" %>>9</option>
            <option value="10" <%= request.getParameter("devicecategory").equals("10") ? "selected" : "" %>>10</option>
        </select>
    </tr>
    <br>

    <tr>
        <td>设备类型</td>
        <select name="check" id="check">
            <option value="冻土检测" <%= request.getParameter("devicetype").equals("冻土检测") ? "selected" : "" %>>冻土检测</option>
            <option value="1" <%= request.getParameter("devicetype").equals("1") ? "selected" : "" %>>1</option>
            <option value="2" <%= request.getParameter("devicetype").equals("2") ? "selected" : "" %>>2</option>
            <option value="3" <%= request.getParameter("devicetype").equals("3") ? "selected" : "" %>>3</option>
            <option value="4" <%= request.getParameter("devicetype").equals("4") ? "selected" : "" %>>4</option>
            <option value="5" <%= request.getParameter("devicetype").equals("5") ? "selected" : "" %>>5</option>
            <option value="6" <%= request.getParameter("devicetype").equals("6") ? "selected" : "" %>>6</option>
            <option value="7" <%= request.getParameter("devicetype").equals("7") ? "selected" : "" %>>7</option>
            <option value="8" <%= request.getParameter("devicetype").equals("8") ? "selected" : "" %>>8</option>
            <option value="9" <%= request.getParameter("devicetype").equals("9") ? "selected" : "" %>>9</option>
            <option value="10" <%= request.getParameter("devicetype").equals("10") ? "selected" : "" %>>10</option>
        </select>
    </tr> <br>

    <%
        long timestamp = Long.parseLong(request.getParameter("installtime"));
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String installTimestr = df.format(new Date(timestamp));
    %>
    <tr>
        <td>安装时间</td>
        <td><input type="text" name="installtime" value="<%=installTimestr%>"></td>
    </tr><br>

    <tr>
        <td>设备状态</td>
        <select name="now" id="now" value="<%=request.getParameter("devicestate")%>">
            <td><option value="正常" selected>正常</td>
            <td><option value="损坏" >损坏</td>
        </select>
    </tr><br>

    <tr>
        <td>设备图片</td>
        <img id="uploadedImage" src="<%=getImage.getImageURL(request.getParameter("devicecode"))%>"/>
        <input type="file" name="imageFile" id="imageFile" accept="image/*" onchange="showImage()"/>
        <button type="button" onclick="removeImage()">删除图片</button>
    </tr>

    <tr>
        <td colspan="2">
            <input type="reset" value="取消" class="button" id="reset">
            <input type="button" value="保存" class="button" id="add" onclick="baocun()">
        </td>
    </tr> <br>


</form>



</body>
</html>
