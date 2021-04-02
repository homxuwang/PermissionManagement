package io.github.homxuwang.service;

import io.github.homxuwang.entity.SysPermission;

import java.util.List;

public interface SysPermissionService {
    //查找所有
    List<SysPermission> findAllPermission();
}
