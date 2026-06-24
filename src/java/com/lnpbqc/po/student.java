package com.lnpbqc.po;

import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Getter
@Setter
public class student {
    private Integer studentid;
    private String name;
    private String sex;
    private Integer tclass;
    private Integer department;
    private Date birthday;
    private String native_place;

    @Override
    public String toString() {
        return
                "studentid:" + studentid +
                ",name:" + name  +
                ",sex:" + sex +
                ",tclass:" + tclass +
                ",department:" + department +
                ",birthday:" + birthday +
                ",native_place:" + native_place;
    }
}
