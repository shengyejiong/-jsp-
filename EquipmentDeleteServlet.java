package com.amos.servlet;

import bean.Company;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "EquipmentDeleteServlet", value = "/EquipmentDeleteServlet")
public class EquipmentDeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");

        String filename = "equipmentList.txt";
        String path = request.getServletContext().getRealPath(filename);
        File file = new File(path);
        FileReader fr = new FileReader(file);//字符输入流
        BufferedReader br = new BufferedReader(fr);//使文件可按行读取并具有缓冲功能
        StringBuffer strB = new StringBuffer(); //strB用来存储jsp.txt文件里的内容
        String str = br.readLine();
        while (str != null) {
            strB.append(str);
            str = br.readLine();
        }
        br.close();

        String inline = request.getParameter("rowIndex");
        int line = Integer.parseInt(inline);
        String cut = strB.toString();
        String[] inputs = cut.split(" ");
        int length = inputs.length;
        int i = (line-1)*8;//这个i用来选择开头
        String[] newarray = new String[length-8];//创建一个新数组来储存旧数组里没被删除的数据
        int temp = 0;
       for(int a=0;a<length;a++){
           if(a<i||a>=i+8) {
               newarray[temp] = inputs[a];
               temp++;
           }

       }

       HttpSession session = request.getSession();
       List<Company> deleteinfo = (List<Company>) session.getAttribute("deletedongxi");
       if(deleteinfo == null){
           deleteinfo = new ArrayList<>();
       }
       Company huanchong = new Company();

       huanchong.setDesname(inputs[i++]);
       huanchong.setMacname(inputs[i++]);
       huanchong.setMaccode(inputs[i++]);
       huanchong.setMacvary(inputs[i++]);
       huanchong.setMactype(inputs[i++]);
       huanchong.setInstalltime(inputs[i++]+" "+inputs[i++]);
       huanchong.setMacstate(inputs[i++]);

       deleteinfo.add(huanchong);
        session.setAttribute("deletedongxi",deleteinfo);


        String deletetxt = String.join(" ", newarray);

       try(BufferedWriter writer = new BufferedWriter((new FileWriter(path)))){
           writer.write(deletetxt);
           writer.write(" ");
       }

        response.sendRedirect("/equipmentList.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}