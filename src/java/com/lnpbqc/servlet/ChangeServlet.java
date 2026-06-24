package com.lnpbqc.servlet;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.lnpbqc.service.ChangeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/change")
public class ChangeServlet extends HttpServlet {
    private static ChangeService changeService = null;
    static {
        changeService = new ChangeService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String actionName = req.getParameter("actionName");
        if("search".equals(actionName)){
            JSONArray search = changeService.search();
            resp.setCharacterEncoding("UTF-8");
            resp.setContentType("application/json");
            if(search!=null){
                resp.getWriter().write(search.toString());
            }else{
                resp.getWriter().write(new JSONObject().toString());
            }
        }else if("update".equals(actionName)){
            boolean update = changeService.update(req);
            resp.setCharacterEncoding("UTF-8");
            PrintWriter writer = resp.getWriter();
            if(update)writer.write("Done");
            else writer.write("Wrong");
        }
    }
}
