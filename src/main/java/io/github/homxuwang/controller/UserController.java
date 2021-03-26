package io.github.homxuwang.controller;

import io.github.homxuwang.bean.ResponseBean;
import io.github.homxuwang.bean.StatusCode;
import io.github.homxuwang.dao.*;
import io.github.homxuwang.entity.*;
import io.github.homxuwang.exception.UnauthorizedException;
import io.github.homxuwang.utils.JWTUtil;
import io.github.homxuwang.utils.PasswordUtil;
import io.github.homxuwang.utils.SaltUtil;
import io.swagger.annotations.Api;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * @Author homxu
 * @Date 2021/3/24 9:26
 * @Version 1.0
 */
@Api(tags = "User")
@RestController
@RequestMapping("/user")
public class UserController {
    private static final Logger LOGGER = LogManager.getLogger(WebController.class);

    @Autowired
    private UserInfoMapper userInfoMapper;

    @Autowired
    private SysUserRoleMapper userRoleMapper;

    @Autowired
    private SysRoleMapper roleMapper;

    @Autowired
    private SysPermissionMapper permissionMapper;

    @Autowired
    private SysRolePermissionMapper rolePermissionMapper;

    /**
     * 用户注册
     * @param username 用户名（需大于等于4个字符）
     * @param password 密码（需大于等于8个字符）
     * @param phoneNumber 手机号
     * @param email email地址
     * @param confirmPassword 确认输入密码
     * @return
     */
    @PostMapping("/register")
    @Transactional
    public ResponseBean userRegister(@RequestParam("username") String username,
                                     @RequestParam("password") String password,
                                     @RequestParam(value = "phonenumber",required = false) String phoneNumber,
                                     @RequestParam(value = "email",required = false) String email,
                                     @RequestParam("confirmPassword") String confirmPassword){
        if(username.length() < 4 ) {
            return new ResponseBean(StatusCode.InvalidParams,"length of username must >= 4!");
        }
        if(password.length() < 8 ) {
            return new ResponseBean(StatusCode.InvalidParams,"length of password must >= 8!");
        }
        if(!password.equals(confirmPassword)) {
            return new ResponseBean(StatusCode.InvalidParams,"confirm password is not equal to your password!");
        }
        Pattern phonePattern = Pattern.compile("^[1]([3-9])[0-9]{9}$");
        if(phoneNumber != null && !phoneNumber.equals("") &&!phonePattern.matcher(phoneNumber).matches()){
            return new ResponseBean(StatusCode.InvalidParams,"your phonenumber is invalid!");
        }

        Pattern emailPattern = Pattern.compile("^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$");
        if(email != null && !email.equals("") &&!emailPattern.matcher(email).matches()){
            return new ResponseBean(StatusCode.InvalidParams,"your email is invalid!");
        }

        //检查用户名是否已经存在
        UserInfo ifExistUser = userInfoMapper.findByUsername(username);

        if(ifExistUser != null) {
            return new ResponseBean(StatusCode.UnknownError,"username: " +username +" already exists!");
        }
        String salt = SaltUtil.generatorSalt();
        String saltPasswordAddMd5 = DigestUtils.md5DigestAsHex((password+salt).getBytes());
        //user在数据库中的id是自增的，所以不需要设置
        UserInfo newUser = new UserInfo(username,phoneNumber,saltPasswordAddMd5,email,1,salt);

        try {
            //向用户表中插入改用户
            if(userInfoMapper.insert(newUser) == 1){ //如果插入成功
                //同时还应在user_role表中为用户设置role身份
                UserInfo insertedUser = userInfoMapper.findByUsername(username);
                //注册的用户都为普通用户
                userRoleMapper.insert(new SysUserRole(insertedUser.getId(), 3));
            }
        }catch (Exception e){
            String message = e.getMessage();
            return new ResponseBean(StatusCode.UnknownError,message);
        }
        return new ResponseBean(StatusCode.Success,"register success!");
    }

    /**
     * 首先检验用户名是否存在，如果存在，获得该用户的盐，然后用该盐和用户输入的密码来计算哈希值，并和数据库中的哈希值进行比较。
     * @param username 用户名
     * @param password 密码
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
        if(userInfo.getStatus() == 0){
            return new ResponseBean(StatusCode.AccountHasBeenLocked,"your account is not avaliable, please connect the admin!");
        }
        if (userInfo.getPassword()
                //数据库中的密码为password+salt的组合，需要相加后再进行MD5验证
                .equals(DigestUtils.md5DigestAsHex((password+userSalt).getBytes())
                )) {
            return new ResponseBean(StatusCode.Success, JWTUtil.sign(username, password,userSalt));
        } else {
            return new ResponseBean(StatusCode.AccountPasswordNotMatch, "your username or password is uncorrect");
        }
    }


    /**
     * 更改密码
     * @param username
     * @param oldpassword
     * @param newpassword
     * @param confirmnewpassword
     * @return
     */
    @PostMapping("/change_password")
    @Transactional
    @RequiresAuthentication
    public ResponseBean changePassword(  @RequestParam("username") String username,
                                         @RequestParam("oldpassword") String oldpassword,
                                         @RequestParam("newpassword") String newpassword,
                                         @RequestParam("confirmnewpassword") String confirmnewpassword){
        //检查用户名是否已经存在
        UserInfo user = userInfoMapper.findByUsername(username);

        if(user == null) {
            return new ResponseBean(StatusCode.AccountNotExist,"username: " +username +" does not exists!");
        }

        if(!user.getPassword().equals(
                PasswordUtil.getSaltPassword(oldpassword,user.getSalt()))
            ){
            return new ResponseBean(StatusCode.OldPasswordNotMatch,"your oldpassword is not current,please check it out!");
        }

        if(!newpassword.equals(confirmnewpassword)){
            return new ResponseBean(StatusCode.RetypePasswordNotMatch,"The password did not match the re-typed password,please check it out!");
        }
        //如果用户新密码和旧密码一致
        if (user.getPassword().equals(
                PasswordUtil.getSaltPassword(newpassword,user.getSalt())
        )){
            return new ResponseBean(StatusCode.InvalidParams,"the new password is equal to you old password,please check it out!");
        }

        newpassword = PasswordUtil.getSaltPassword(newpassword,user.getSalt());

        Integer result = userInfoMapper.updatePasswordByUserName(newpassword,username);
        if(result == 1){
            return new ResponseBean(StatusCode.Success,"change password success!");
        }else{
            return new ResponseBean(StatusCode.UpdatePasswordFail,"change password failed!");
        }
    }

}
