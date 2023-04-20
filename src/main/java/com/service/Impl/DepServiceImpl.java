package com.service.Impl;

import com.po.Dep;
import com.service.IDepService;
import com.util.MapperUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
@Service("DepServiceImpl")
@Transactional
public class DepServiceImpl implements IDepService {
    @Resource(name = "DaoService")
    private MapperUtil mapperService;

    public MapperUtil getMapperService() {
        return mapperService;
    }

    public void setMapperService(MapperUtil mapperService) {
        this.mapperService = mapperService;
    }

    @Override
    public List<Dep> findAll() {
        return mapperService.getDepMapper().findAll();
    }
}
