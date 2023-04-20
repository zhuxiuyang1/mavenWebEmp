package com.service.Impl;

import com.po.Welfare;
import com.service.IWelfareService;
import com.util.MapperUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
@Service("WelfareServiceImpl")
@Transactional
public class WelfareServiceImpl implements IWelfareService {
    @Resource(name = "DaoService")
    private MapperUtil mapperService;

    public MapperUtil getMapperService() {
        return mapperService;
    }

    public void setMapperService(MapperUtil mapperService) {
        this.mapperService = mapperService;
    }
    @Override
    public List<Welfare> findAll() {
        return mapperService.getWelfareMapper().findAll();
    }
}
