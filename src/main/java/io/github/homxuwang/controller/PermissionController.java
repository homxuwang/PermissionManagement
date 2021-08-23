package io.github.homxuwang.controller;

import io.github.homxuwang.bean.ResponseBean;
import io.github.homxuwang.bean.StatusCode;
import io.github.homxuwang.dao.SysPermissionMapper;
import io.github.homxuwang.dao.SysRoleMapper;
import io.github.homxuwang.dao.SysRolePermissionMapper;
import io.github.homxuwang.entity.SysPermission;
import io.github.homxuwang.entity.SysRole;
import io.github.homxuwang.entity.SysRolePermission;
import io.swagger.annotations.Api;
import org.apache.ibatis.annotations.Param;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author homxu
 * @Date 2021/3/26 16:06
 * @Version 1.0
 */
@Api(tags = "Permission")
@RestController
@RequestMapping("/permission")
public class PermissionController {

    private static final Logger LOGGER = LogManager.getLogger(WebController.class);

    @Autowired
    private SysRoleMapper roleMapper;

    @Autowired
    private SysPermissionMapper permissionMapper;

    @Autowired
    private SysRolePermissionMapper rolePermissionMapper;

    /**
     * 获取当前role拥有的premission
     * @param roleName
     * @return
     */
    @Transactional
    @PostMapping("/get_permissions_by_role_name")
//    @RequiresRoles(logical = Logical.OR,value = {"admin","superadmin"})
    public List<SysPermission> getPermissions(@Param("roleName") String roleName){
        LOGGER.info("roleName ----> " + roleName);
        try{
            //检查role是否存在
            SysRole role = roleMapper.findRoleByRoleName(roleName);
            if(role == null) {
                throw new Exception("role: " +roleName +" does not exists!");
            }
            return permissionMapper.findPermissionByRoleId(role.getId());
        } catch (Exception exception) {
            exception.printStackTrace();
            return null;
        }
    }

    /**
     * 更改用户的权限许可 身份为admin或superadmin可以修改用户的permission
     * @param role_and_permissions 用户名和要修改为的permission（数组）
     * @return
     */
    @Transactional
    @PostMapping("/change_permissions")
    public ResponseBean changePermissions(@RequestBody HashMap<String,Object> role_and_permissions){

        LOGGER.info("role_permissions ----> " + role_and_permissions.toString());

        String inputrole = (String) role_and_permissions.get("rolename");

        List<String> permissions = (List<String>) role_and_permissions.get("permissions");
        //目前role拥有的permissionId
        List<Integer> currentPermissionsId = null;
        //删除role对应的permission集合
        List<Integer> toDeletePermissions = new ArrayList<>();
        //更新role对应的permission集合
        List<Integer> toAddPermissions = new ArrayList<>();
        try {
            //检查role是否存在
            SysRole role = roleMapper.findRoleByRoleName(inputrole);
            if(role == null) {
                return new ResponseBean(StatusCode.AccountNotExist,"role: " +role +" does not exists!");
            }

            //---------对比需要删除和需要增加的permission-----------
            //前台传来的 permission 的 id集合
            List<Integer> receviedPermissionList = permissionMapper.findPermissionsByPermissionNames(permissions).stream().map(SysPermission::getId).collect(Collectors.toList());
            //目前role拥有的permission
            List<SysRolePermission> rolePermissions = rolePermissionMapper.findRolePermissionsByRoleId(role.getId());

            currentPermissionsId = rolePermissions.stream().map(SysRolePermission::getPermissionId).collect(Collectors.toList());

            for(Integer PermissionId:receviedPermissionList){
                if(currentPermissionsId.contains(PermissionId)){

                }
            }


        }catch (Exception e){
            LOGGER.info(e.getMessage());
        }

        return new ResponseBean(StatusCode.Success,role_and_permissions.toString());
    }
}
