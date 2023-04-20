package com.po;

import org.springframework.web.multipart.MultipartFile;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class Emp implements Serializable {
    private Integer eid;
    private String ename;
    private String sex;
    private String address;
    private Date birthday;
    private String photo="default.jpg";
    private Integer depid;
    //与界面属性相关
    private  String depname;//部门名称
    private Float emoney;//员工薪资
    private String[] wids;//福利编号数组
    private List<Welfare> lswf;//福利对象集合
    private MultipartFile pic;//文件上传
    private String sdate;//生日转换

    public Emp() {
    }

    public Emp(Integer eid, String ename, String sex, String address, Date birthday, String photo, Integer depid, String depname, Float emoney, String[] wids, List<Welfare> lswf, MultipartFile pic, String sdate) {
        this.eid = eid;
        this.ename = ename;
        this.sex = sex;
        this.address = address;
        this.birthday = birthday;
        this.photo = photo;
        this.depid = depid;
        this.depname = depname;
        this.emoney = emoney;
        this.wids = wids;
        this.lswf = lswf;
        this.pic = pic;
        this.sdate = sdate;
    }

    public Integer getEid() {
        return eid;
    }

    public void setEid(Integer eid) {
        this.eid = eid;
    }

    public String getEname() {
        return ename;
    }

    public void setEname(String ename) {
        this.ename = ename;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public Integer getDepid() {
        return depid;
    }

    public void setDepid(Integer depid) {
        this.depid = depid;
    }

    public String getDepname() {
        return depname;
    }

    public void setDepname(String depname) {
        this.depname = depname;
    }

    public Float getEmoney() {
        return emoney;
    }

    public void setEmoney(Float emoney) {
        this.emoney = emoney;
    }

    public String[] getWids() {
        return wids;
    }

    public void setWids(String[] wids) {
        this.wids = wids;
    }

    public List<Welfare> getLswf() {
        return lswf;
    }

    public void setLswf(List<Welfare> lswf) {
        this.lswf = lswf;
    }

    public MultipartFile getPic() {
        return pic;
    }

    public void setPic(MultipartFile pic) {
        this.pic = pic;
    }

    public String getSdate() {
        sdate = new SimpleDateFormat("yyyy-MM-dd").format(birthday);
        return sdate;
    }

    public void setSdate(String sdate) throws ParseException {
        birthday = new SimpleDateFormat("yyyy-MM-dd").parse(sdate);
        this.sdate = sdate;
    }

    @Override
    public String toString() {
        return "Emp{" +
                "eid=" + eid +
                ", ename='" + ename + '\'' +
                ", sex='" + sex + '\'' +
                ", address='" + address + '\'' +
                ", birthday=" + birthday +
                ", photo='" + photo + '\'' +
                ", depid=" + depid +
                ", depname='" + depname + '\'' +
                ", emoney=" + emoney +
                ", wids=" + Arrays.toString(wids) +
                ", lswf=" + lswf +
                ", pic=" + pic +
                ", sdate='" + sdate + '\'' +
                '}';
    }
}
