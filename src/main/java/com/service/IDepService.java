package com.service;

import com.po.Dep;

import java.util.List;

public interface IDepService {
    //查询部门所有
    public List<Dep> findAll();
}
