package com.lnpbqc.servlet;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import com.lnpbqc.service.PunishService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@WebServlet("/punish")
public class PunishServlet extends HttpServlet {
    private static PunishService punishService = null;
    static {
        punishService = new PunishService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String actionName = req.getParameter("actionName");
        resp.setCharacterEncoding("UTF-8");
        if ("update".equals(actionName)){
            boolean update = punishService.update(req);
            if(update){
                resp.getWriter().write("Done");
            }else resp.getWriter().write("Wrong");
        }else if("search".equals(actionName)){
            JSONArray search = punishService.search();
            resp.setCharacterEncoding("UTF-8");
            resp.setContentType("application/json");
            if(search!=null){
                resp.getWriter().write(search.toString());
            }else{
                resp.getWriter().write(new JSONObject().toString());
            }
        }
    }
}
