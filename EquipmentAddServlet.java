package com.amos.servlet;

import bean.Company;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "EquipmentAddServlet", value = "/EquipmentAddServlet")
public class EquipmentAddServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    request.setCharacterEncoding("utf-8");
    String name = request.getParameter("company");
    String finalname = new String(name.getBytes(StandardCharsets.ISO_8859_1), StandardCharsets.UTF_8);
    String device = request.getParameter("device-name");
    String code = request.getParameter("device-code");
    String select = request.getParameter("selection");
    String test = request.getParameter("ice test");
    String install = request.getParameter("install time");
    String now = request.getParameter("state");

        Company addinfo = new Company();
        addinfo.setDesname(name);
        addinfo.setMacname(device);
        addinfo.setMaccode(code);
        addinfo.setMacvary(select);
        addinfo.setMactype(test);
        addinfo.setInstalltime(install);
        addinfo.setMacstate(now);
        HttpSession session = request.getSession();
        List<Company> addinfos = (List<Company>) session.getAttribute("addinfos");
        if(addinfos == null){
            addinfos = new ArrayList<>();
        }
        addinfos.add(addinfo);
        session.setAttribute("addinfos",addinfos);




    response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        String filename = "equipmentList.txt";
        String realpath = request.getServletContext().getRealPath(filename);
        File file = new File(realpath);
        FileWriter writer = new FileWriter(file,true);
        BufferedWriter bufferedWriter = new BufferedWriter(writer);
        bufferedWriter.write(name+" ");
        bufferedWriter.write(device + " ");
        bufferedWriter.write(code+" ");
        bufferedWriter.write(select+" ");
        bufferedWriter.write(test+" ");
        bufferedWriter.write(install+" ");
        bufferedWriter.write(now+" ");

        bufferedWriter.flush();
        bufferedWriter.close();
        response.sendRedirect("/equipmentList.jsp");
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}