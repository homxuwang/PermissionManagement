/*
 Navicat Premium Data Transfer

 Source Server         : postgresql
 Source Server Type    : PostgreSQL
 Source Server Version : 120006
 Source Host           : localhost:5432
 Source Catalog        : permission_management
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 120006
 File Encoding         : 65001

 Date: 25/04/2021 13:52:45
*/


-- ----------------------------
-- Sequence structure for SysPermission_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."SysPermission_id_seq";
CREATE SEQUENCE "public"."SysPermission_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for SysRole_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."SysRole_id_seq";
CREATE SEQUENCE "public"."SysRole_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for SysUserInfo_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."SysUserInfo_id_seq";
CREATE SEQUENCE "public"."SysUserInfo_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for Sys_User_Role_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."Sys_User_Role_id_seq";
CREATE SEQUENCE "public"."Sys_User_Role_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_permission";
CREATE TABLE "public"."sys_permission" (
  "id" int4 NOT NULL DEFAULT nextval('"SysPermission_id_seq"'::regclass),
  "permission_description" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "permission_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "permission_type" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "status" int4 NOT NULL DEFAULT 1,
  "parent_id" int4 NOT NULL DEFAULT 0,
  "url" varchar(255) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_permission"."permission_description" IS '????????????';
COMMENT ON COLUMN "public"."sys_permission"."permission_name" IS '?????????????????????';
COMMENT ON COLUMN "public"."sys_permission"."permission_type" IS '??????????????? menu,button,url';
COMMENT ON COLUMN "public"."sys_permission"."status" IS '????????????0?????????1??????';
COMMENT ON COLUMN "public"."sys_permission"."parent_id" IS '????????????';
COMMENT ON TABLE "public"."sys_permission" IS '?????????';

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO "public"."sys_permission" VALUES (2, '????????????', 'system:role:*', 'menu', 1, 1, '/role/config');
INSERT INTO "public"."sys_permission" VALUES (3, '????????????', 'system:password', 'menu', 1, 1, '/user/password/edition');
INSERT INTO "public"."sys_permission" VALUES (4, '????????????', 'system:log:*', 'menu', 1, 1, '/handle/operation/log');
INSERT INTO "public"."sys_permission" VALUES (5, '????????????', 'system:role:create', 'url', 1, 1, '/role/addtion');
INSERT INTO "public"."sys_permission" VALUES (6, '????????????', 'system:admin:*', 'menu', 1, 1, '/user/config');
INSERT INTO "public"."sys_permission" VALUES (7, '????????????', 'system:user:create', 'url', 1, 1, '/user/addition');
INSERT INTO "public"."sys_permission" VALUES (8, 'test', 'system:test:require_superadmin', 'url', 1, 1, '/test/require_superadmin');
INSERT INTO "public"."sys_permission" VALUES (1, '????????????', 'system:*', 'menu', 1, 1, '/system/*');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_role";
CREATE TABLE "public"."sys_role" (
  "id" int4 NOT NULL DEFAULT nextval('"SysRole_id_seq"'::regclass),
  "role_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "status" int4 NOT NULL DEFAULT 1,
  "description" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "remark" varchar(255) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_role"."role_name" IS '?????????';
COMMENT ON COLUMN "public"."sys_role"."status" IS '????????????';
COMMENT ON COLUMN "public"."sys_role"."description" IS '????????????';
COMMENT ON COLUMN "public"."sys_role"."remark" IS '??????';
COMMENT ON TABLE "public"."sys_role" IS '?????????';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO "public"."sys_role" VALUES (2, 'admin', 1, '???????????????', '??????????????????');
INSERT INTO "public"."sys_role" VALUES (3, 'user', 1, '????????????', NULL);
INSERT INTO "public"."sys_role" VALUES (1, 'superadmin', 1, '???????????????', '??????????????????');

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_role_permission";
CREATE TABLE "public"."sys_role_permission" (
  "id" int4 NOT NULL,
  "role_id" int4 NOT NULL,
  "permission_id" int4 NOT NULL
)
;
COMMENT ON COLUMN "public"."sys_role_permission"."role_id" IS '??????id';
COMMENT ON COLUMN "public"."sys_role_permission"."permission_id" IS '??????id';
COMMENT ON TABLE "public"."sys_role_permission" IS '???????????????';

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO "public"."sys_role_permission" VALUES (1, 1, 1);
INSERT INTO "public"."sys_role_permission" VALUES (2, 1, 2);
INSERT INTO "public"."sys_role_permission" VALUES (3, 1, 3);
INSERT INTO "public"."sys_role_permission" VALUES (4, 1, 4);
INSERT INTO "public"."sys_role_permission" VALUES (5, 1, 5);
INSERT INTO "public"."sys_role_permission" VALUES (6, 1, 6);
INSERT INTO "public"."sys_role_permission" VALUES (7, 1, 7);
INSERT INTO "public"."sys_role_permission" VALUES (8, 2, 2);
INSERT INTO "public"."sys_role_permission" VALUES (9, 2, 3);
INSERT INTO "public"."sys_role_permission" VALUES (10, 3, 2);
INSERT INTO "public"."sys_role_permission" VALUES (11, 1, 8);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user_role";
CREATE TABLE "public"."sys_user_role" (
  "id" int4 NOT NULL DEFAULT nextval('"Sys_User_Role_id_seq"'::regclass),
  "user_id" int4 NOT NULL,
  "role_id" int4 NOT NULL
)
;
COMMENT ON COLUMN "public"."sys_user_role"."user_id" IS '??????id';
COMMENT ON COLUMN "public"."sys_user_role"."role_id" IS '??????id';
COMMENT ON TABLE "public"."sys_user_role" IS '???????????????';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO "public"."sys_user_role" VALUES (1, 1, 1);
INSERT INTO "public"."sys_user_role" VALUES (2, 2, 2);
INSERT INTO "public"."sys_user_role" VALUES (3, 3, 3);
INSERT INTO "public"."sys_user_role" VALUES (4, 5, 2);
INSERT INTO "public"."sys_user_role" VALUES (5, 6, 2);
INSERT INTO "public"."sys_user_role" VALUES (7, 26, 3);
INSERT INTO "public"."sys_user_role" VALUES (8, 28, 3);
INSERT INTO "public"."sys_user_role" VALUES (9, 29, 3);

-- ----------------------------
-- Table structure for sys_userinfo
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_userinfo";
CREATE TABLE "public"."sys_userinfo" (
  "id" int4 NOT NULL DEFAULT nextval('"SysUserInfo_id_seq"'::regclass),
  "mobile_phone" varchar(255) COLLATE "pg_catalog"."default",
  "user_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(255) COLLATE "pg_catalog"."default",
  "status" int4 NOT NULL,
  "salt" varchar(255) COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "public"."sys_userinfo"."mobile_phone" IS '?????????';
COMMENT ON COLUMN "public"."sys_userinfo"."user_name" IS '?????????';
COMMENT ON COLUMN "public"."sys_userinfo"."password" IS '??????';
COMMENT ON COLUMN "public"."sys_userinfo"."email" IS '??????';
COMMENT ON COLUMN "public"."sys_userinfo"."status" IS '????????? 0?????? 1??????';
COMMENT ON COLUMN "public"."sys_userinfo"."salt" IS '?????????';
COMMENT ON TABLE "public"."sys_userinfo" IS '?????????';

-- ----------------------------
-- Records of sys_userinfo
-- ----------------------------
INSERT INTO "public"."sys_userinfo" VALUES (2, '13233333333', 'admin', '7e7ceff66661e095f103b8fc6c7deaa5', NULL, 1, 'e37f454961d2dfd4897525b7ec2a8957');
INSERT INTO "public"."sys_userinfo" VALUES (3, '13026666666', 'user1', 'a096132c608d04b9811d089f76ab4073', 'normal@user.com', 1, 'af7262898217d04c1f16e136614066ec');
INSERT INTO "public"."sys_userinfo" VALUES (5, '13026329718', 'admin1', '3b9678894aab34dd9e34c97a3a935941', 'normal1@user.com', 1, '872466f0e78298d8293f7af3824d5c22');
INSERT INTO "public"."sys_userinfo" VALUES (6, '13026329718', 'admin2register', '6b0d203403c038fb520a556c8928027b', 'wanghongxu1994@qq.com', 1, '1e0144c6a4466469fa5255415fcfb2b9');
INSERT INTO "public"."sys_userinfo" VALUES (26, NULL, 'user12', 'b1843cf7dd73bf641cc413452fbb0afa', NULL, 1, '043318650989d14908ec25b74bc499c3');
INSERT INTO "public"."sys_userinfo" VALUES (28, NULL, 'user13', '86b7a54adcdf9b652336bd68f78a4f06', NULL, 1, '3a4f34415cad7e738c7cfa0b1a6ea622');
INSERT INTO "public"."sys_userinfo" VALUES (1, '13022222222', 'superadmin', '1138e159e99aece609e9830dabf3854e', 'wanghongxu1994@qq.com', 1, '84b7c9de798ffaa5dbd137233c76db4c');

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."SysPermission_id_seq"
OWNED BY "public"."sys_permission"."id";
SELECT setval('"public"."SysPermission_id_seq"', 2, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."SysRole_id_seq"
OWNED BY "public"."sys_role"."id";
SELECT setval('"public"."SysRole_id_seq"', 2, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."SysUserInfo_id_seq"
OWNED BY "public"."sys_userinfo"."id";
SELECT setval('"public"."SysUserInfo_id_seq"', 30, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."Sys_User_Role_id_seq"
OWNED BY "public"."sys_user_role"."id";
SELECT setval('"public"."Sys_User_Role_id_seq"', 10, true);

-- ----------------------------
-- Primary Key structure for table sys_permission
-- ----------------------------
ALTER TABLE "public"."sys_permission" ADD CONSTRAINT "syspermission_pk" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_role
-- ----------------------------
ALTER TABLE "public"."sys_role" ADD CONSTRAINT "sysrole_pk" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_role_permission
-- ----------------------------
ALTER TABLE "public"."sys_role_permission" ADD CONSTRAINT "sys_role_permission_pk" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_user_role
-- ----------------------------
ALTER TABLE "public"."sys_user_role" ADD CONSTRAINT "sys_user_role_pk" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table sys_userinfo
-- ----------------------------
ALTER TABLE "public"."sys_userinfo" ADD CONSTRAINT "sysuserinfo_pk" PRIMARY KEY ("id");
