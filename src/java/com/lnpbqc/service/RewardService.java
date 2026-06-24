package com.lnpbqc.service;

import cn.hutool.json.JSONArray;
import com.lnpbqc.dao.BasicDAO;
import com.lnpbqc.po.change;
import com.lnpbqc.po.reward;
import jakarta.servlet.http.HttpServletRequest;
import net.sf.json.JSONObject;

import java.util.List;

public class RewardService {
    private static BasicDAO<reward> rewardBasicDAO = null;
    static {
        rewardBasicDAO = new BasicDAO<>();
    }
    public boolean update(HttpServletRequest req){
//        "&id="+id+"&studentid="+studentid+"&reason="+reason+"&rec_time="+rec_time+"&description="+description;
        String id = req.getParameter("id");
        String studentid = req.getParameter("studentid");
        String reason = req.getParameter("reason");
        String rec_time = req.getParameter("rec_time");
        String description = req.getParameter("description");
        int update = rewardBasicDAO.update("insert into `reward` values(?,?,?,?,?)", id, studentid, reason, rec_time, description);
        return update!=0;
    }
    public JSONArray search(){
        List<reward> rewards = rewardBasicDAO.queryMulti("select * from `reward`", reward.class, null);
        JSONArray jsonArray = null;
        if(rewards!=null){
            if (rewards.size()>0)jsonArray = new JSONArray();
            for(reward r:rewards){
                System.out.println(r);
                String[] split = r.toString().split(",");
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
