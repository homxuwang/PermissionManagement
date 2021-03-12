package io.github.homxuwang.service;

import io.github.homxuwang.entity.UserInfo;

/**
 * @Author homxu
 * @Date 2021/3/12 17:05
 * @Version 1.0
 */
public interface UserInfoService {

    /**
     * 通过username查找用户信息
     * @param username
     * @return
     */
    UserInfo findByUsername(String username);
}
