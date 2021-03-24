package io.github.homxuwang.controller;

import io.github.homxuwang.bean.ResponseBean;
import io.github.homxuwang.bean.StatusCode;
import io.github.homxuwang.dao.UserInfoMapper;
import io.github.homxuwang.entity.UserInfo;
import io.github.homxuwang.utils.SaltUtil;
import io.swagger.annotations.Api;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.regex.Pattern;

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

    @PostMapping("/register")
    public ResponseBean userRegister(@RequestParam("username") String username,
                                     @RequestParam("password") String password,
                                     @RequestParam("phonenumber") String phoneNumber,
                                     @RequestParam("email") String email,
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
        if(phoneNumber != null && !phonePattern.matcher(phoneNumber).matches()){
            return new ResponseBean(StatusCode.InvalidParams,"your phonenumber is invalid!");
        }

        Pattern emailPattern = Pattern.compile("^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$");
        if(email != null && emailPattern.matcher(email).matches()){
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
            userInfoMapper.insert(newUser);
        }catch (Exception e){
            String message = e.getMessage();
            return new ResponseBean(StatusCode.UnknownError,message);
        }
        return new ResponseBean(StatusCode.Success,"register success!");
    }
}
