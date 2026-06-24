package com.lnpbqc.service;

import cn.hutool.crypto.digest.DigestUtil;
import com.lnpbqc.dao.AdminDAO;
import com.lnpbqc.po.admin;
public class UserService {
    public boolean login(String name ,String pwd){
        admin admin = AdminDAO.querySingle("select * from admin where name = ?", name);
        System.out.println(admin.getName());
        if(admin==null)return false;
        return DigestUtil.md5Hex(pwd).equals(admin.getPwd());
    }
    public boolean register(String name,String pwd){
        int update = AdminDAO.update("insert into admin values(?,?)", name, DigestUtil.md5Hex(pwd));
        return update != 0;
    }

}
