package com.lnpbqc.po;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class punish_levels {
    private Integer code;
    private String description;

    @Override
    public String toString() {
        return "code=" + code +
                ",description=" + description;
    }
}
