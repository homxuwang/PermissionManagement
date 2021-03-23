package io.github.homxuwang.shiro;

import io.github.homxuwang.dao.SysPermissionMapper;
import io.github.homxuwang.dao.SysRoleMapper;
import io.github.homxuwang.dao.UserInfoMapper;
import io.github.homxuwang.entity.SysPermission;
import io.github.homxuwang.entity.SysRole;
import io.github.homxuwang.entity.UserInfo;
import io.github.homxuwang.utils.JWTUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class MyRealm extends AuthorizingRealm {

    private static final Logger LOGGER = LogManager.getLogger(MyRealm.class);

    @Autowired
    private UserInfoMapper userInfoMapper;

    @Autowired
    private SysRoleMapper roleMapper;

    @Autowired
    private SysPermissionMapper sysPermissionMapper;

    /**
     * 大坑！，必须重写此方法，不然Shiro会报错
     */
    @Override
    public boolean supports(AuthenticationToken token) {
        return token instanceof JWTToken;
    }

    /**
     * 只有当需要检测用户权限的时候才会调用此方法，例如checkRole,checkPermission之类的
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        System.out.println("————权限认证————");
        try{
            String username = JWTUtil.getUsername(principals.toString());
            UserInfo user = userInfoMapper.findByUsername(username);
            SysRole userRole = roleMapper.findRoleByUsername(user.getUserName());
            SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
            simpleAuthorizationInfo.addRole(userRole.getRoleName());
            System.out.println("userRole --->"+userRole.getRoleName());
            //先通过user对应的roleid获取它对应的permission集合
            //然后提取出permissionName的集合
            List<SysPermission> sysPermissions = sysPermissionMapper.findPermissionByRoleId(userRole.getId());

            List<String> permissionList = new ArrayList<>();
            for (SysPermission syspermission:sysPermissions
                 ) {
                permissionList.add(syspermission.getPermissionName());
            }

            Set<String> permission = new HashSet<>(permissionList);
            System.out.println("permissions --->"+permission);
            simpleAuthorizationInfo.addStringPermissions(permission);
            System.out.println("simpleAuthorizationInfo --->"+simpleAuthorizationInfo);
            return simpleAuthorizationInfo;
        }catch(Exception e){
            System.out.println(e.getMessage());
            return null;
        }
    }

    /**
     * 默认使用此方法进行用户名正确与否验证，错误抛出异常即可。
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken auth) throws AuthenticationException {
        System.out.println("————身份认证方法————");
//        String token = (String) auth.getCredentials();
        String token = (String) auth.getPrincipal();
        // 解密获得username，用于和数据库进行对比
        String username = JWTUtil.getUsername(token);
        if (username == null) {
            throw new AuthenticationException("token invalid");
        }

        UserInfo user = userInfoMapper.findByUsername(username);
        if (user == null) {
            throw new AuthenticationException("User didn't existed!");
        }

        if (! JWTUtil.verify(token, username, user.getPassword())) {
            throw new AuthenticationException("Username or password error");
        }

        return new SimpleAuthenticationInfo(token, token, getName());
    }
}
