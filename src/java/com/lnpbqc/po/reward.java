package com.lnpbqc.po;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class reward {
    private Integer id;
    private Integer studentid;
    private Integer levels;
    private String  rec_time;
    private String description;

    @Override
    public String toString() {
        return "id=" + id +
                ",studentid=" + studentid +
                ",levels=" + levels +
                ",rec_time=" + rec_time +
                ",description=" + description;
    }
}
