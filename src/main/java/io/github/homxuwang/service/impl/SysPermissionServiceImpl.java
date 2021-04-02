package io.github.homxuwang.service.impl;

import io.github.homxuwang.dao.SysPermissionMapper;
import io.github.homxuwang.entity.SysPermission;
import io.github.homxuwang.service.SysPermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysPermissionServiceImpl implements SysPermissionService {

    @Autowired
    private SysPermissionMapper permissionMapper;

    @Override
    public List<SysPermission> findAllPermission() {
        return permissionMapper.findAllPermission();
    }
}
