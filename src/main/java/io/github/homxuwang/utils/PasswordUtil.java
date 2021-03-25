package io.github.homxuwang.utils;

import org.springframework.util.DigestUtils;

/**
 * @Author homxu
 * @Date 2021/3/25 11:43
 * @Version 1.0
 */
public class PasswordUtil {
    public static String getSaltPassword(String password,String salt) {
        return DigestUtils.md5DigestAsHex((password+salt).getBytes());
    }
}
