package com.lnpbqc.servlet;

import com.lnpbqc.dao.BasicDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@WebServlet("/modifyTable")
public class ModifyTable extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String actionName = req.getParameter("actionName");
        if(actionName.equals("update")){
            req.setCharacterEncoding("UTF-8");
            String table = req.getParameter("table");
            String code = req.getParameter("code");
            String description = req.getParameter("description");
            BasicDAO<Object> dao =new BasicDAO<>();
            int update = 0;
            switch (table){
                case "change_code":
                    update = dao.update("insert into change_code values(?,?)", code, description);
                    break;
                case "punish_levels":
                    update = dao.update("insert into punish_levels values(?,?)", code, description);
                    break;
                case "reward_levels":
                    update = dao.update("insert into reward_levels values(?,?)", code, description);
                    break;
            }

            resp.setCharacterEncoding("UTF-8");
            if(update!=0){
                resp.getWriter().write("Done");
            }else resp.getWriter().write("Wrong");
        }
    }
}
