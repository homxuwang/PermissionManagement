--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6
-- Dumped by pg_dump version 12.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: sys_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_permission (
    id integer NOT NULL,
    permission_description character varying(255) NOT NULL,
    permission_name character varying(255) NOT NULL,
    permission_type character varying(255) NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    parent_id integer DEFAULT 0 NOT NULL,
    url character varying(255)
);


ALTER TABLE public.sys_permission OWNER TO postgres;

--
-- Name: TABLE sys_permission; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_permission IS '权限表';


--
-- Name: COLUMN sys_permission.permission_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_permission.permission_description IS '权限描述';


--
-- Name: COLUMN sys_permission.permission_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_permission.permission_name IS '权限名称字符串';


--
-- Name: COLUMN sys_permission.permission_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_permission.permission_type IS '权限类型： menu,button,url';


--
-- Name: COLUMN sys_permission.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_permission.status IS '状态值：0禁用，1可用';


--
-- Name: COLUMN sys_permission.parent_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_permission.parent_id IS '父级菜单';


--
-- Name: SysPermission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."SysPermission_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."SysPermission_id_seq" OWNER TO postgres;

--
-- Name: SysPermission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."SysPermission_id_seq" OWNED BY public.sys_permission.id;


--
-- Name: sys_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_role (
    id integer NOT NULL,
    role_name character varying(255) NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    description character varying(255) NOT NULL,
    remark character varying(255)
);


ALTER TABLE public.sys_role OWNER TO postgres;

--
-- Name: TABLE sys_role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_role IS '角色表';


--
-- Name: COLUMN sys_role.role_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role.role_name IS '角色名';


--
-- Name: COLUMN sys_role.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role.status IS '角色状态';


--
-- Name: COLUMN sys_role.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role.description IS '角色描述';


--
-- Name: COLUMN sys_role.remark; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role.remark IS '备注';


--
-- Name: SysRole_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."SysRole_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."SysRole_id_seq" OWNER TO postgres;

--
-- Name: SysRole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."SysRole_id_seq" OWNED BY public.sys_role.id;


--
-- Name: sys_userinfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_userinfo (
    id integer NOT NULL,
    mobile_phone character varying(255),
    user_name character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(255),
    status integer NOT NULL,
    salt character varying(255)
);


ALTER TABLE public.sys_userinfo OWNER TO postgres;

--
-- Name: TABLE sys_userinfo; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_userinfo IS '用户表';


--
-- Name: COLUMN sys_userinfo.mobile_phone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_userinfo.mobile_phone IS '手机号';


--
-- Name: COLUMN sys_userinfo.user_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_userinfo.user_name IS '用户名';


--
-- Name: COLUMN sys_userinfo.password; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_userinfo.password IS '密码';


--
-- Name: COLUMN sys_userinfo.email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_userinfo.email IS '邮箱';


--
-- Name: COLUMN sys_userinfo.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_userinfo.status IS '状态： 0禁用 1正常';


--
-- Name: COLUMN sys_userinfo.salt; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_userinfo.salt IS '密码盐';


--
-- Name: SysUserInfo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."SysUserInfo_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."SysUserInfo_id_seq" OWNER TO postgres;

--
-- Name: SysUserInfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."SysUserInfo_id_seq" OWNED BY public.sys_userinfo.id;


--
-- Name: sys_user_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_user_role (
    id integer NOT NULL,
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public.sys_user_role OWNER TO postgres;

--
-- Name: TABLE sys_user_role; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_user_role IS '用户角色表';


--
-- Name: COLUMN sys_user_role.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_user_role.user_id IS '用户id';


--
-- Name: COLUMN sys_user_role.role_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_user_role.role_id IS '角色id';


--
-- Name: Sys_User_Role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Sys_User_Role_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Sys_User_Role_id_seq" OWNER TO postgres;

--
-- Name: Sys_User_Role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Sys_User_Role_id_seq" OWNED BY public.sys_user_role.id;


--
-- Name: sys_role_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sys_role_permission (
    id integer NOT NULL,
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.sys_role_permission OWNER TO postgres;

--
-- Name: TABLE sys_role_permission; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.sys_role_permission IS '角色权限表';


--
-- Name: COLUMN sys_role_permission.role_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role_permission.role_id IS '角色id';


--
-- Name: COLUMN sys_role_permission.permission_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.sys_role_permission.permission_id IS '权限id';


--
-- Name: sys_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission ALTER COLUMN id SET DEFAULT nextval('public."SysPermission_id_seq"'::regclass);


--
-- Name: sys_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role ALTER COLUMN id SET DEFAULT nextval('public."SysRole_id_seq"'::regclass);


--
-- Name: sys_user_role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user_role ALTER COLUMN id SET DEFAULT nextval('public."Sys_User_Role_id_seq"'::regclass);


--
-- Name: sys_userinfo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_userinfo ALTER COLUMN id SET DEFAULT nextval('public."SysUserInfo_id_seq"'::regclass);


--
-- Data for Name: sys_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_permission VALUES (1, '系统管理', 'system:*', 'menu', 1, 0, NULL);
INSERT INTO public.sys_permission VALUES (2, '角色管理', 'system:role:*', 'menu', 1, 1, '/role/config');
INSERT INTO public.sys_permission VALUES (3, '密码修改', 'system:password', 'menu', 1, 1, '/user/password/edition');
INSERT INTO public.sys_permission VALUES (4, '操作日志', 'system:log:*', 'menu', 1, 1, '/handle/operation/log');
INSERT INTO public.sys_permission VALUES (5, '新增角色', 'system:role:create', 'url', 1, 1, '/role/addtion');
INSERT INTO public.sys_permission VALUES (6, '用户管理', 'system:admin:*', 'menu', 1, 1, '/user/config');
INSERT INTO public.sys_permission VALUES (7, '新增用户', 'system:user:create', 'url', 1, 1, '/user/addition');


--
-- Data for Name: sys_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_role VALUES (2, 'admin', 1, '系统管理员', '拥有部分权限');
INSERT INTO public.sys_role VALUES (3, 'user', 1, '普通用户', NULL);
INSERT INTO public.sys_role VALUES (1, 'superadmin', 1, '超级管理员', '拥有所有权限');


--
-- Data for Name: sys_role_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_role_permission VALUES (1, 1, 1);
INSERT INTO public.sys_role_permission VALUES (2, 1, 2);
INSERT INTO public.sys_role_permission VALUES (3, 1, 3);
INSERT INTO public.sys_role_permission VALUES (4, 1, 4);
INSERT INTO public.sys_role_permission VALUES (5, 1, 5);
INSERT INTO public.sys_role_permission VALUES (6, 1, 6);
INSERT INTO public.sys_role_permission VALUES (7, 1, 7);
INSERT INTO public.sys_role_permission VALUES (8, 2, 2);
INSERT INTO public.sys_role_permission VALUES (9, 2, 3);
INSERT INTO public.sys_role_permission VALUES (10, 3, 2);


--
-- Data for Name: sys_user_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_user_role VALUES (1, 1, 1);
INSERT INTO public.sys_user_role VALUES (2, 2, 2);
INSERT INTO public.sys_user_role VALUES (3, 3, 3);
INSERT INTO public.sys_user_role VALUES (4, 5, 2);
INSERT INTO public.sys_user_role VALUES (5, 6, 2);
INSERT INTO public.sys_user_role VALUES (7, 26, 3);
INSERT INTO public.sys_user_role VALUES (8, 28, 3);


--
-- Data for Name: sys_userinfo; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sys_userinfo VALUES (1, '13022222222', 'superadmin', '827ccb0eea8a706c4c34a16891f84e7b', 'wanghongxu1994@qq.com', 1, NULL);
INSERT INTO public.sys_userinfo VALUES (2, '13233333333', 'admin', '7e7ceff66661e095f103b8fc6c7deaa5', NULL, 1, 'e37f454961d2dfd4897525b7ec2a8957');
INSERT INTO public.sys_userinfo VALUES (3, '13026666666', 'user1', 'a096132c608d04b9811d089f76ab4073', 'normal@user.com', 1, 'af7262898217d04c1f16e136614066ec');
INSERT INTO public.sys_userinfo VALUES (5, '13026329718', 'admin1', '3b9678894aab34dd9e34c97a3a935941', 'normal1@user.com', 1, '872466f0e78298d8293f7af3824d5c22');
INSERT INTO public.sys_userinfo VALUES (6, '13026329718', 'admin2register', '6b0d203403c038fb520a556c8928027b', 'wanghongxu1994@qq.com', 1, '1e0144c6a4466469fa5255415fcfb2b9');
INSERT INTO public.sys_userinfo VALUES (26, NULL, 'user12', 'b1843cf7dd73bf641cc413452fbb0afa', NULL, 1, '043318650989d14908ec25b74bc499c3');
INSERT INTO public.sys_userinfo VALUES (28, NULL, 'user13', '86b7a54adcdf9b652336bd68f78a4f06', NULL, 1, '3a4f34415cad7e738c7cfa0b1a6ea622');


--
-- Name: SysPermission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."SysPermission_id_seq"', 1, false);


--
-- Name: SysRole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."SysRole_id_seq"', 1, false);


--
-- Name: SysUserInfo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."SysUserInfo_id_seq"', 28, true);


--
-- Name: Sys_User_Role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Sys_User_Role_id_seq"', 8, true);


--
-- Name: sys_role_permission sys_role_permission_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role_permission
    ADD CONSTRAINT sys_role_permission_pk PRIMARY KEY (id);


--
-- Name: sys_user_role sys_user_role_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_user_role
    ADD CONSTRAINT sys_user_role_pk PRIMARY KEY (id);


--
-- Name: sys_permission syspermission_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_permission
    ADD CONSTRAINT syspermission_pk PRIMARY KEY (id);


--
-- Name: sys_role sysrole_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_role
    ADD CONSTRAINT sysrole_pk PRIMARY KEY (id);


--
-- Name: sys_userinfo sysuserinfo_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sys_userinfo
    ADD CONSTRAINT sysuserinfo_pk PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

