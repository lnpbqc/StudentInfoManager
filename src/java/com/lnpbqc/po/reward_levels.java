package com.lnpbqc.po;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class reward_levels {
    private Integer code;
    private String description;

    @Override
    public String toString() {
        return "code=" + code +
                ",description=" + description;
    }
}
