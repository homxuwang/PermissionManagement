package io.github.homxuwang.dao;

import io.github.homxuwang.entity.SysPermission;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysPermissionMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SysPermission record);

    int insertSelective(SysPermission record);

    SysPermission selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysPermission record);

    int updateByPrimaryKey(SysPermission record);

    //根据roleId
    List<SysPermission> findPermissionByRoleId(@Param("roleId") Integer roleId);

    //根据premission_name 集合 查找对应的id集合
    List<SysPermission> findPermissionsByPermissionNames(@Param("permissionnames") List<String> psermissions);
}