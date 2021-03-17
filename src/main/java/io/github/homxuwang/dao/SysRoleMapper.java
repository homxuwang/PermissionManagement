package io.github.homxuwang.dao;

import io.github.homxuwang.entity.SysRole;
import org.apache.ibatis.annotations.Param;

public interface SysRoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SysRole record);

    int insertSelective(SysRole record);

    SysRole selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysRole record);

    int updateByPrimaryKey(SysRole record);

    SysRole findRolebyUserName(@Param("username") String username);
}