package io.github.homxuwang.controller;


import io.github.homxuwang.bean.ResponseBean;
import io.github.homxuwang.bean.StatusCode;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.apache.shiro.subject.Subject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Author homxu
 * @Date 2021/3/12 13:59
 * @Version 1.0
 */
@RestController
@RequestMapping("/test")
public class TestController {

    private static final Logger LOGGER = LogManager.getLogger(TestController.class);
    @GetMapping(value = {"/require_superadmin"})
//    @RequiresRoles(logical = Logical.OR,value = {"admin","superadmin"})
    public ResponseBean require_superadmin() {
//        Subject subject = SecurityUtils.getSubject();
//        if (subject.isAuthenticated()) {
//            return new ResponseBean(StatusCode.Success, null);
//        } else {
//            return new ResponseBean(StatusCode.Success, null);
//        }
        return new ResponseBean(200,"You are visiting require_superadmin", null);
    }

    @GetMapping(value = {"/require_admin"})
//    @RequiresRoles(logical = Logical.OR,value = {"admin","superadmin"})
    public ResponseBean require_admin() {
        Subject subject = SecurityUtils.getSubject();
        if (subject.isAuthenticated()) {
            return new ResponseBean(StatusCode.Success, null);
        } else {
            return new ResponseBean(401,"Subject does not have role [admin]", null);
        }

    }
}
