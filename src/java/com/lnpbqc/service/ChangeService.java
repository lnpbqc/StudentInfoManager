package com.lnpbqc.service;

import cn.hutool.json.JSONArray;
import com.lnpbqc.dao.BasicDAO;
import com.lnpbqc.po.change;
import jakarta.servlet.http.HttpServletRequest;
import net.sf.json.JSONObject;

import java.util.List;

public class ChangeService {
    private static BasicDAO<change> changeBasicDAO =null;
    static {
        changeBasicDAO = new BasicDAO<change>();
    }
    public JSONArray search(){
        System.out.println("search");
        List<change> changes = changeBasicDAO.queryMulti("select * from `change`", change.class, null);
        JSONArray jsonArray = null;
        if(changes!=null){
            if (changes.size()>0)jsonArray = new JSONArray();
            for(change c:changes){
                System.out.println(c);
                String[] split = c.toString().split(",");
                JSONObject jsonObject = new JSONObject();
                for(String s:split){
                    String[] split1 = s.split("=");
                    jsonObject.put(split1[0],split1[1]);
                }
                jsonArray.put(jsonObject);
            }
        }
        return jsonArray;
    }
    public boolean update(HttpServletRequest req){
//        "&id="+id+"&studentid="+studentid+"&reason="+reason+"&rec_time="+rec_time+"&description="+description;
        String id = req.getParameter("id");
        String studentid = req.getParameter("studentid");
        String reason = req.getParameter("reason");
        String rec_time = req.getParameter("rec_time");
        String description = req.getParameter("description");
        int update = changeBasicDAO.update("insert into `change` values(?,?,?,?,?)", id, studentid, reason, rec_time, description);
        return update!=0;
    }
}
