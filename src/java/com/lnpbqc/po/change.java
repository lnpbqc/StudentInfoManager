package com.lnpbqc.po;

import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class change {
    private Integer id;
    private Integer studentid;
    private Integer change;
    private String  rec_time;
    private String description;

    @Override
    public String toString() {
        return "id=" + id +
                ",studentid=" + studentid +
                ",change=" + change +
                ",rec_time=" + rec_time +
                ",description=" + description;
    }
}
