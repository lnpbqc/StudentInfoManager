package com.lnpbqc.service;

import com.lnpbqc.dao.BasicDAO;
import com.lnpbqc.po.*;

import java.util.HashMap;
import java.util.List;

public class DBInfo {
    public HashMap<String,Object> getDBInfo(){
        HashMap<String, Object> result = new HashMap<>();
        result.put("studentNum",new BasicDAO<Integer>().queryScalar("select count(*) from student", null));
        result.put("classNum",new BasicDAO<Integer>().queryScalar("select count(*) from tclass", null));
        result.put("rewardNum",new BasicDAO<Integer>().queryScalar("select count(*) from reward", null));
        result.put("punishmentNum",new BasicDAO<Integer>().queryScalar("select count(*) from punishment", null));
        result.put("changeNum",new BasicDAO<Integer>().queryScalar("select count(*) from `change`", null));
        result.put("departmentNum",new BasicDAO<Integer>().queryScalar("select count(*) from department", null));
        result.put("changeCodeNum",new BasicDAO<Integer>().queryScalar("select count(*) from change_code", null));
        result.put("rewardLevelNum",new BasicDAO<Integer>().queryScalar("select count(*) from reward_levels", null));
        result.put("punishLevelNum",new BasicDAO<Integer>().queryScalar("select count(*) from punish_levels", null));
        return result;
    }
    public List<tclass> getClassName(){
        BasicDAO<tclass> tclassBasicDAO = new BasicDAO<>();
        return tclassBasicDAO.queryMulti("select * from tclass",tclass.class,null);
    }
    public List<department> getDepartment(){
        return new BasicDAO<department>().queryMulti("select * from department",department.class,null);
    }
    public List<change_code> getChangeCode(){
        return new BasicDAO<change_code>().queryMulti("select * from change_code",change_code.class,null);
    }
    public List<reward_levels> getRewardCode(){
        return new BasicDAO<reward_levels>().queryMulti("select * from reward_levels",reward_levels.class,null);
    }
    public List<punish_levels> getPunishCode(){
        return new BasicDAO<punish_levels>().queryMulti("select * from punish_levels",punish_levels.class,null);
    }
}
