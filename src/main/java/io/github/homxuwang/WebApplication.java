package io.github.homxuwang;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @Author homxu
 * @Date 2021/3/12 13:56
 * @Version 1.0
 */
@SpringBootApplication
@MapperScan("io.github.homxuwang.dao")
public class WebApplication {
    public static void main(String[] args) {
        SpringApplication.run(WebApplication.class);
    }
}
