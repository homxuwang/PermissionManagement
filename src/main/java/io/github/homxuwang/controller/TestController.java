package io.github.homxuwang.controller;


import io.github.homxuwang.bean.ResponseBean;
import io.github.homxuwang.bean.StatusCode;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Author homxu
 * @Date 2021/3/12 13:59
 * @Version 1.0
 */
@Controller
@RequestMapping("/test")
public class TestController {

    private static final Logger LOGGER = LogManager.getLogger(TestController.class);
    @GetMapping("/require_supreadmin")
    public ResponseBean require_superadmin() {
        Subject subject = SecurityUtils.getSubject();
        if (subject.isAuthenticated()) {
            return new ResponseBean(StatusCode.Success, null);
        } else {
            return new ResponseBean(StatusCode.Success, null);
        }
    }
}
