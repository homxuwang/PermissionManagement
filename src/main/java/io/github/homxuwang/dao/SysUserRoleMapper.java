package io.github.homxuwang.dao;

import io.github.homxuwang.entity.SysUserRole;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

public interface SysUserRoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(SysUserRole record);

    int insertSelective(SysUserRole record);

    SysUserRole selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(SysUserRole record);

    int updateByPrimaryKey(SysUserRole record);

    //插入（不传入id,因为sys_user_role 表是自增的）
//    int insertExceptId(@Param("userId") Integer userId,@Param("roleId") Integer roleId);

    int insertExceptId(SysUserRole record);
}