package io.github.homxuwang.service.impl;

import io.github.homxuwang.dao.UserInfoMapper;
import io.github.homxuwang.entity.UserInfo;
import io.github.homxuwang.service.UserInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Author homxu
 * @Date 2021/3/12 17:03
 * @Version 1.0
 */
@Service("UserInfoService")
public class UserServiceImpl implements UserInfoService {

    @Autowired
    UserInfoMapper userInfoMapper;

    @Override
    public UserInfo findByUsername(String username) {
        return userInfoMapper.findByUsername(username);
    }
}
