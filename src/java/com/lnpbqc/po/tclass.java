package com.lnpbqc.po;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class tclass {
    private Integer id;
    private String name;
    private Integer monitor;

    @Override
    public String toString() {
        return  "id=" + id +
                ",name=" + name +
                ",monitor=" + monitor;
    }
}
