package com.lnpbqc.service;

import com.lnpbqc.dao.BasicDAO;
import com.lnpbqc.po.student;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;

public class StudentService {
    private static BasicDAO<student> studentBasicDAO = new BasicDAO<student>();
    public boolean updateStudent(HttpServletRequest req, HttpServletResponse resp){
//         "&id="+id+&name="+name+"&sex="+sex+"&class="+c+"&department="+d+"&birthday="+b+"&native="+n;
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String sex = req.getParameter("sex");
        String tclass = req.getParameter("class");
        String department = req.getParameter("department");
        String birthday = req.getParameter("birthday");
        String aNative = req.getParameter("native");
        int update = studentBasicDAO.update("insert into student values(?,?,?,?,?,?,?)", id, name, sex, tclass, department, birthday, aNative);
        return update!=0;
    }
    public student searchById(HttpServletRequest req){
        String studentid = req.getParameter("studentid");
        student student = studentBasicDAO.querySingle("select * from student where studentid = ?", student.class, studentid);
        return student;
    }
}
