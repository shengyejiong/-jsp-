package com.amos.servlet;

import bean.Company;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@WebServlet(name = "EquipmentEditServlet", value = "/EquipmentEditServlet")
public class EquipmentEditServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

       request.setCharacterEncoding("utf-8");

            PrintWriter out = response.getWriter();//用来测试的文本句

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

            String code = request.getParameter("device-code");
            String cut = strB.toString();
            String[] inputs = cut.split(" ");
            int length = inputs.length;//切割字符串
            int temp = 0;//中间变量作为行首的序号
            for (int i = 2; i < length; i = i + 8) {
                if (Objects.equals(inputs[i], code)) {
                    temp = i - 2;

                }
            }

            HttpSession session = request.getSession();
        List<Company> editinfo_old = (List<Company>) session.getAttribute("oldinfo") ;
        List<Company> editinfo_new = (List<Company>) session.getAttribute("newinfo");
        if(editinfo_old == null){
            editinfo_old = new ArrayList<>();
        }
        if(editinfo_new == null){
            editinfo_new = new ArrayList<>();
        }

            String time = request.getParameter("install time");
            String[] cuttime = time.split(" ");
            Company oldinfo = new Company();
            Company newinfo = new Company();

            oldinfo.setDesname(inputs[temp]);
            inputs[temp] = request.getParameter("company");
            newinfo.setDesname(inputs[temp]);
            temp +=1;
            oldinfo.setMacname(inputs[temp]);
            inputs[temp] = request.getParameter("device-name");
            newinfo.setMacname(inputs[temp]);
            temp +=1;
            oldinfo.setMaccode(inputs[temp]);
            inputs[temp] = request.getParameter("device-code");
            newinfo.setMaccode(inputs[temp]);
            temp +=1;
            oldinfo.setMacvary(inputs[temp]);
            inputs[temp] = request.getParameter("selection");
            newinfo.setMacvary(inputs[temp]);
            temp +=1;
            oldinfo.setMactype(inputs[temp]);
            inputs[temp] = request.getParameter("ice test");
            newinfo.setMactype(inputs[temp]);
            temp +=1;
            oldinfo.setInstalltime(inputs[temp]+" "+inputs[temp+1]);
            inputs[temp] = cuttime[0];
            temp +=1;
            inputs[temp] = cuttime[1];
            newinfo.setInstalltime(inputs[temp-1]+" "+inputs[temp]);
            temp +=1;
            oldinfo.setMacstate(inputs[temp]);
            inputs[temp] = request.getParameter("state");
            newinfo.setMacstate(inputs[temp]);

            editinfo_old.add(oldinfo);
            editinfo_new.add(newinfo);

            session.setAttribute("oldinfo",editinfo_old);
            session.setAttribute("newinfo",editinfo_new);

            String updatetxt = String.join(" ", inputs);


            try(BufferedWriter writer = new BufferedWriter(new FileWriter(path))){
                writer.write(updatetxt);
                writer.write(" ");
            }

        response.sendRedirect("/equipmentList.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}