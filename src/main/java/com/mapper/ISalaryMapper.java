package com.mapper;

import com.po.Salary;
import org.springframework.stereotype.Service;

@Service("ISalaryMapper")
public interface ISalaryMapper {
    //保存薪资
    public int save(Salary sa);
    //修改薪资
    public  int updateByEid(Salary sa);
    //删除薪资
    public int delByEid(Integer eid);
    //查找薪资
    public Salary findByEid(Integer eid);
}
