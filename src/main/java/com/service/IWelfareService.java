package com.service;

import com.po.Welfare;

import java.util.List;

public interface IWelfareService {
    //查询福利
    public List<Welfare> findAll();
}
