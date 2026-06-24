package com.lnpbqc.servlet;

import cn.hutool.json.JSONArray;
import com.lnpbqc.po.student;
import com.lnpbqc.service.DBInfo;
import com.lnpbqc.service.StudentService;
import com.lnpbqc.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import net.sf.json.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        System.out.println("进来了");
        String actionName = req.getParameter("actionName");
        if("logout".equals(actionName)){
            req.getSession().setAttribute("admin",null);
            Cookie cookie = new Cookie("user",null);
            cookie.setMaxAge(0);
            resp.addCookie(cookie);
            req.getRequestDispatcher("index.jsp").forward(req,resp);
        }else{
            doPost(req,resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String actionName = req.getParameter("actionName");
        System.out.println(actionName);
        String name = req.getParameter("name");
        String pwd = req.getParameter("pwd");
        UserService userService = new UserService();
        if(name==null){
            Cookie[] cookies = req.getCookies();
            for(Cookie c:cookies){
                if(c.getName().equals("user")){
                    String[] split = c.getValue().split("-");
                    name = split[0];
                    pwd = split[1];
                }
            }
        }
        if ("login".equals(actionName)) {

            if (userService.login(name, pwd)) {
                Cookie cookie = new Cookie("user",name+"-"+pwd);
                cookie.setMaxAge(7*24*60*60);
                resp.addCookie(cookie);

                HttpSession session = req.getSession();
                session.setAttribute("admin", name);
                session.setAttribute("DBInfo", new DBInfo().getDBInfo());
                session.setAttribute("classs",new DBInfo().getClassName());
                session.setAttribute("department",new DBInfo().getDepartment());
                session.setAttribute("change_code",new DBInfo().getChangeCode());
                session.setAttribute("reward_code",new DBInfo().getRewardCode());
                session.setAttribute("punish_code",new DBInfo().getPunishCode());
                req.getRequestDispatcher("main.jsp").forward(req, resp);
            } else resp.sendRedirect("index.jsp");
        } else if ("register".equals(actionName)) {
            if (userService.register(name, pwd)) {
                req.setAttribute("name", name);
                req.setAttribute("pwd", pwd);
                req.getRequestDispatcher("index.jsp").forward(req, resp);
            } else resp.sendRedirect("index.jsp");
        }else if("updateStudent".equals(actionName)){
            boolean b = new StudentService().updateStudent(req, resp);
            resp.setCharacterEncoding("UTF-8");
            if(b)resp.getWriter().write("已接收");
            else resp.getWriter().write("错误");
        }else if("logout".equals(actionName)) {
            System.out.println(req.getSession().getAttribute("1admin"));
            req.getSession().setAttribute("admin", null);
            System.out.println(req.getSession().getAttribute("2admin"));
            Cookie cookie = new Cookie("user", null);
            cookie.setMaxAge(0);
            resp.addCookie(cookie);
            resp.getWriter().write("已退出");
        }else if("searchById".equals(actionName)){
            System.out.println("进来了");
            student student = new StudentService().searchById(req);
            System.out.println(student);
            if(student==null){
                resp.getWriter().write("None");
                return;
            }
            String[] split = student.toString().split(",");
            JSONObject jsonObject = new JSONObject();
            for(String s:split){
                String[] split1 = s.split(":");
                jsonObject.put(split1[0],split1[1]);
            }
            resp.setCharacterEncoding("UTF-8");
            resp.setContentType("application/json");
            resp.getWriter().write(jsonObject.toString());
        }else{
            resp.setCharacterEncoding("UTF-8");
            resp.setContentType("text/html");
            resp.getWriter().write("请重新进入:<a href='index.jsp'>点击我</a>");
        }
    }
}
