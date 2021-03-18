package io.github.homxuwang.utils;

import org.apache.shiro.crypto.SecureRandomNumberGenerator;

/**
 * @Author homxu
 * @Date 2021/3/18 10:08
 * @Version 1.0
 */
public class SaltUtil {
    public static String generatorSalt() {
        return new SecureRandomNumberGenerator().nextBytes(16).toHex();
    }
}
