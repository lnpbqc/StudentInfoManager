package com.lnpbqc.po;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class punishment {
    private Integer id;
    private Integer studentid;
    private Integer levels;
    private String rec_time;
    private String enable;
    private String description;

    @Override
    public String toString() {
        return "id=" + id +
                ",studentid=" + studentid +
                ",levels=" + levels +
                ",rec_time=" + rec_time +
                ",enable=" + enable +
                ",description='" + description;
    }
}
