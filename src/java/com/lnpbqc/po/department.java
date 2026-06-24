package com.lnpbqc.po;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class department {
    private Integer id;
    private String name;

    @Override
    public String toString() {
        return "id=" + id +
                ",name=" + name;
    }
}
