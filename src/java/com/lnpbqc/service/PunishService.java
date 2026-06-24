package com.lnpbqc.service;

import cn.hutool.json.JSONArray;
import com.lnpbqc.dao.BasicDAO;
import com.lnpbqc.po.punishment;
import com.lnpbqc.po.reward;
import jakarta.servlet.http.HttpServletRequest;
import net.sf.json.JSONObject;

import java.util.List;

public class PunishService {
    private static BasicDAO<punishment> punishmentBasicDAO = null;
    static {
        punishmentBasicDAO = new BasicDAO<>();
    }
    public boolean update(HttpServletRequest req){
//        "&id="+id+"&studentid="+studentid+"&reason="+reason+"&rec_time="+rec_time+"&enable="+enable+"&description="+description;
        String id = req.getParameter("id");
        String studentid = req.getParameter("studentid");
        String reason = req.getParameter("reason");
        String rec_time = req.getParameter("rec_time");
        String enable = req.getParameter("enable");
        String description = req.getParameter("description");
        int update = punishmentBasicDAO.update("insert into `punishment` values(?,?,?,?,?,?)", id, studentid, reason, rec_time, enable, description);
        return update!=0;
    }
    public JSONArray search(){
        List<punishment> punishments = punishmentBasicDAO.queryMulti("select * from `punishment`", punishment.class, null);
        JSONArray jsonArray = null;
        if(punishments!=null){
            if (punishments.size()>0)jsonArray = new JSONArray();
            for(punishment p:punishments){
                System.out.println(p);
                String[] split = p.toString().split(",");
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
}
