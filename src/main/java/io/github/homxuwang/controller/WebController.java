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
import org.apache.shiro.crypto.hash.Md5Hash;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;

@RestController
public class WebController {

    private static final Logger LOGGER = LogManager.getLogger(WebController.class);

    @Autowired
    private UserInfoMapper userInfoMapper;


    /**
     * 首先检验用户名是否存在，如果存在，获得该用户的盐，然后用该盐和用户输入的密码来计算哈希值，并和数据库中的哈希值进行比较。
     * @param username
     * @param password
     * @return
     */
    @PostMapping("/login")
    public ResponseBean login(@RequestParam("username") String username,
                              @RequestParam("password") String password) {
        String userSalt = userInfoMapper.findSaltByUsername(username);
        if(userSalt == "" || userSalt == null) {
            throw new UnauthorizedException();
        }
        UserInfo userInfo = userInfoMapper.findByUsername(username);
        if (userInfo.getPassword()
                //数据库中的密码为password+salt的组合，需要相加后再进行MD5验证
                .equals(DigestUtils.md5DigestAsHex((password+userSalt).getBytes())
                )) {
            return new ResponseBean(StatusCode.Success, JWTUtil.sign(username, password));
        } else {
            throw new UnauthorizedException();
        }
    }

    @GetMapping("/article")
    public ResponseBean article() {
        Subject subject = SecurityUtils.getSubject();
        if (subject.isAuthenticated()) {
            return new ResponseBean(StatusCode.Success, null);
        } else {
            return new ResponseBean(StatusCode.Success, null);
        }
    }

    @GetMapping("/require_auth")
    @RequiresAuthentication
    public ResponseBean requireAuth() {
        return new ResponseBean(200, "You are authenticated", null);
    }

    @GetMapping("/require_role")
    @RequiresRoles("admin")
    public ResponseBean requireRole() {
        return new ResponseBean(200, "You are visiting require_role", null);
    }

    @GetMapping("/require_permission")
    @RequiresPermissions(logical = Logical.AND, value = {"view", "edit"})
    public ResponseBean requirePermission() {
        return new ResponseBean(200, "You are visiting permission require edit,view", null);
    }

    @RequestMapping(path = "/401")
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public ResponseBean unauthorized() {
        return new ResponseBean(401, "Unauthorized", null);
    }
}
