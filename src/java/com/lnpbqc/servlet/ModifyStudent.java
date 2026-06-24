package com.lnpbqc.servlet;

import com.lnpbqc.dao.BasicDAO;
import com.lnpbqc.po.student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.StringReader;

@WebServlet("/modify")
public class ModifyStudent extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }
    private String id = null;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String actionName = req.getParameter("actionName");
        BasicDAO<student> studentBasicDAO = new BasicDAO<>();
        if(actionName.equals("in")){
            id = req.getParameter("id");
            student student = studentBasicDAO.querySingle("select * from student where studentid = ?", student.class, id);
            req.setAttribute("name",student.getName());
            req.setAttribute("gender",student.getSex());
            req.setAttribute("tclass",student.getTclass());
            req.setAttribute("department",student.getDepartment());
            req.setAttribute("birthday",student.getBirthday());
            req.setAttribute("native",student.getNative_place());
            req.getRequestDispatcher("modify.jsp").forward(req,resp);
        }else if(actionName.equals("update")){
//            "&name="+name+"&sex="+sex+"&class="+c+"&department="+d+"&birthday="+b+"&native="+n;
            studentBasicDAO.update("update student set name=? where studentid=?",req.getParameter("name"), id);
            studentBasicDAO.update("update student set sex=? where studentid=?",req.getParameter("sex"), id);
            studentBasicDAO.update("update student set tclass=? where studentid=?",req.getParameter("class"), id);
            studentBasicDAO.update("update student set department=? where studentid=?",req.getParameter("department"), id);
            studentBasicDAO.update("update student set birthday=? where studentid=?",req.getParameter("birthday"), id);
            studentBasicDAO.update("update student set native_place=? where studentid=?",req.getParameter("native"), id);
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(req.getParameter("name")+req.getParameter("sex")+req.getParameter("class")+
                    req.getParameter("department")+req.getParameter("birthday")+req.getParameter("native"));
        }
    }
}
