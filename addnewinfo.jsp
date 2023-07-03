<%--
  Created by IntelliJ IDEA.
  User: 夜迥
  Date: 2023/6/3
  Time: 19:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        f.action='addnewinfo'
        f.submit();

    }

    function baocun(){
            return timeinputalarm();
    }

    function showImage(){
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

<form name="table2"  method="post" enctype="multipart/form-data">

    <tr>
        <th>站点名称(*)</th>
        <select name="sitename" id="portname">
            <td><option value="昌都生态监测站" selected>昌都生态监测站</td>
            <td><option value="申扎生态监测站" >申扎生态监测站</td>
            <td><option value="日喀则生态监测站" >日喀则生态监测站</td>
            <td><option value="定日生态监测站" >定日生态监测站</td>
            <td><option value="山南生态观测站" >山南生态观测站</td>
            <td><option value="那曲生态监测站" >那曲生态监测站</td>
            <td><option value="改则生态监测站" >改则生态监测站</td>
            <td><option value="芒康生态监测站" >芒康生态监测站</td>
        </select>
    </tr>
    <br>

    <tr>
        <th>设备名称(*)</th>
        <td><input type="text" name="devicename" id="devicename"/></td>
        <br>
    </tr>

    <tr>
        <td>设备编码(*)</td>
        <td><input type="text" name="num" id="num"/></td>
        <br></tr>

    <tr>
        <td>设备分类</td>
        <select name="vary" id="vary">
            <td><option value="土壤" selected>土壤</td>
            <td><option value="1" >1</td>
            <td><option value="2" >2</td>
            <td><option value="3" >3</td>
            <td><option value="4" >4</td>
            <td><option value="5" >5</td>
            <td><option value="6" >6</td>
            <td><option value="7" >7</td>
            <td><option value="8" >8</td>
            <td><option value="9" >9</td>
            <td><option value="10" >10</td>

        </select>
    </tr>
    <br>

    <tr>
        <td>设备类型</td>
        <select name="check" id="check">
            <td><option value="冻土检测" selected>冻土检测</td>
            <td><option value="1" >1</td>
            <td><option value="2" >2</td>
            <td><option value="3" >3</td>
            <td><option value="4" >4</td>
            <td><option value="5" >5</td>
            <td><option value="6" >6</td>
            <td><option value="7" >7</td>
            <td><option value="8" >8</td>
            <td><option value="9" >9</td>
            <td><option value="10" >10</td>
        </select>
    </tr> <br>

    <tr>
        <td>安装时间</td>
        <td><input type="text" name="installtime"></td>
    </tr><br>

    <tr>
        <td>设备状态</td>
        <select name="now" id="now">
            <td><option value="正常" selected>正常</td>
            <td><option value="损坏" >损坏</td>
        </select>
    </tr><br>

    <tr>
        <td>设备图片</td>
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
