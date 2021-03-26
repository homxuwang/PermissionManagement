package io.github.homxuwang.dao;

import io.github.homxuwang.entity.SysRolePermission;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysRolePermissionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SysRolePermission record);

    int insertSelective(SysRolePermission record);

    SysRolePermission selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysRolePermission record);

    int updateByPrimaryKey(SysRolePermission record);

    List<SysRolePermission> findRolePermissionsByRoleId(@Param("roleId") Integer roleId);
}