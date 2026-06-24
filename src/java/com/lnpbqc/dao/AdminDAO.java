package com.lnpbqc.dao;

import com.lnpbqc.po.admin;

import java.util.List;

public class AdminDAO {
    private static BasicDAO<admin> basicDAO = new BasicDAO<>();
    public static int update(String sql,Object... params){
        return basicDAO.update(sql,params);
    }
    public static List<admin> queryMulti(String sql,Object... parameters){
        return basicDAO.queryMulti(sql,admin.class,parameters);
    }
    public static admin querySingle(String sql,Object... parameters){
        return basicDAO.querySingle(sql,admin.class,parameters);
    }
}
