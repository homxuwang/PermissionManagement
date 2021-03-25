package io.github.homxuwang.dao;

import io.github.homxuwang.entity.UserInfo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

public interface UserInfoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserInfo record);

    int insertSelective(UserInfo record);

    UserInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserInfo record);

    int updateByPrimaryKey(UserInfo record);

    //通过username查找slat
    String findSaltByUsername(@Param("username") String username);

    //通过username查找用户信息
    UserInfo findByUsername(@Param("username") String username);

    //更新用户密码
    Integer updatePasswordByUserName(@Param("password") String newpassword,@Param("username") String username);
}