package io.github.homxuwang.controller;

import io.github.homxuwang.bean.ResponseBean;
import io.github.homxuwang.bean.StatusCode;
import io.github.homxuwang.dao.UserInfoMapper;
import io.github.homxuwang.entity.UserInfo;
import io.github.homxuwang.exception.UnauthorizedException;
import io.github.homxuwang.utils.JWTUtil;
import io.github.homxuwang.utils.SaltUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/web")
public class WebController {

    private static final Logger LOGGER = LogManager.getLogger(WebController.class);

    @Autowired
    private UserInfoMapper userInfoMapper;

    @GetMapping(value= {"/article"})
    public ResponseBean article() {
        Subject subject = SecurityUtils.getSubject();
        if (subject.isAuthenticated()) {
            return new ResponseBean(StatusCode.Success, null);
        } else {
            return new ResponseBean(StatusCode.Success, null);
        }
    }

    @GetMapping(value= {"/require_auth"})
    @RequiresAuthentication
    public ResponseBean requireAuth() {
        return new ResponseBean(200, "You are authenticated", null);
    }

    @GetMapping(value= {"/require_role"})
    @RequiresRoles("admin")
    public ResponseBean requireRole() {
        return new ResponseBean(200, "You are visiting require_role", null);
    }

    @GetMapping(value= {"/require_permission"})
//    @RequiresPermissions(logical = Logical.AND, value = {"system:role:*"})
    public ResponseBean requirePermission() {
        return new ResponseBean(200, "You are visiting permission require system:role:*", null);
    }

    @RequestMapping(path = "/401")
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public ResponseBean unauthorized() {
        return new ResponseBean(401, "Unauthorized", null);
    }
}
