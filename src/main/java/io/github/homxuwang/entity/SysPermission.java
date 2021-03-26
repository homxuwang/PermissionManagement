package io.github.homxuwang.entity;

import java.io.Serializable;

public class SysPermission implements Serializable {
    private Integer id;

    private String permissionDescription;

    private String permissionName;

    private String permissionType;

    private Integer status;

    private Integer parentId;

    private String url;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPermissionDescription() {
        return permissionDescription;
    }

    public void setPermissionDescription(String permissionDescription) {
        this.permissionDescription = permissionDescription == null ? null : permissionDescription.trim();
    }

    public String getPermissionName() {
        return permissionName;
    }

    public void setPermissionName(String permissionName) {
        this.permissionName = permissionName == null ? null : permissionName.trim();
    }

    public String getPermissionType() {
        return permissionType;
    }

    public void setPermissionType(String permissionType) {
        this.permissionType = permissionType == null ? null : permissionType.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    @Override
    public String toString() {
        return "SysPermission{" +
                "id=" + id +
                ", permissionDescription='" + permissionDescription + '\'' +
                ", permissionName='" + permissionName + '\'' +
                ", permissionType='" + permissionType + '\'' +
                ", status=" + status +
                ", parentId=" + parentId +
                ", url='" + url + '\'' +
                '}';
    }
}