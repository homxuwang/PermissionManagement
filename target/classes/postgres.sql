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
-- Name: Sys_Permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Sys_Permission" (
    id integer NOT NULL,
    permission_description character varying(255) NOT NULL,
    permission_name character varying(255) NOT NULL,
    permission_type character varying(255) NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    parent_id integer DEFAULT 0 NOT NULL,
    url character varying(255)
);


ALTER TABLE public."Sys_Permission" OWNER TO postgres;

--
-- Name: TABLE "Sys_Permission"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."Sys_Permission" IS '权限表';


--
-- Name: COLUMN "Sys_Permission".permission_description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_Permission".permission_description IS '权限描述';


--
-- Name: COLUMN "Sys_Permission".permission_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_Permission".permission_name IS '权限名称字符串';


--
-- Name: COLUMN "Sys_Permission".permission_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_Permission".permission_type IS '权限类型： menu,button,url';


--
-- Name: COLUMN "Sys_Permission".status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_Permission".status IS '状态值：0禁用，1可用';


--
-- Name: COLUMN "Sys_Permission".parent_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_Permission".parent_id IS '父级菜单';


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

ALTER SEQUENCE public."SysPermission_id_seq" OWNED BY public."Sys_Permission".id;


--
-- Name: Sys_Role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Sys_Role" (
    id integer NOT NULL,
    role_name character varying(255) NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    description character varying(255) NOT NULL,
    remark character varying(255)
);


ALTER TABLE public."Sys_Role" OWNER TO postgres;

--
-- Name: TABLE "Sys_Role"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."Sys_Role" IS '角色表';


--
-- Name: COLUMN "Sys_Role".role_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_Role".role_name IS '角色名';


--
-- Name: COLUMN "Sys_Role".status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_Role".status IS '角色状态';


--
-- Name: COLUMN "Sys_Role".description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_Role".description IS '角色描述';


--
-- Name: COLUMN "Sys_Role".remark; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_Role".remark IS '备注';


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

ALTER SEQUENCE public."SysRole_id_seq" OWNED BY public."Sys_Role".id;


--
-- Name: Sys_UserInfo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Sys_UserInfo" (
    id integer NOT NULL,
    mobile_phone character varying(255) NOT NULL,
    user_name character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    email character varying(255),
    status integer NOT NULL,
    salt character varying(255)
);


ALTER TABLE public."Sys_UserInfo" OWNER TO postgres;

--
-- Name: TABLE "Sys_UserInfo"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."Sys_UserInfo" IS '用户表';


--
-- Name: COLUMN "Sys_UserInfo".mobile_phone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_UserInfo".mobile_phone IS '手机号';


--
-- Name: COLUMN "Sys_UserInfo".user_name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_UserInfo".user_name IS '用户名';


--
-- Name: COLUMN "Sys_UserInfo".password; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_UserInfo".password IS '密码';


--
-- Name: COLUMN "Sys_UserInfo".email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_UserInfo".email IS '邮箱';


--
-- Name: COLUMN "Sys_UserInfo".status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_UserInfo".status IS '状态： 0禁用 1正常';


--
-- Name: COLUMN "Sys_UserInfo".salt; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_UserInfo".salt IS '密码盐';


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

ALTER SEQUENCE public."SysUserInfo_id_seq" OWNED BY public."Sys_UserInfo".id;


--
-- Name: Sys_Role_Permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Sys_Role_Permission" (
    id integer NOT NULL,
    role_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public."Sys_Role_Permission" OWNER TO postgres;

--
-- Name: TABLE "Sys_Role_Permission"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."Sys_Role_Permission" IS '角色权限表';


--
-- Name: COLUMN "Sys_Role_Permission".role_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_Role_Permission".role_id IS '角色id';


--
-- Name: COLUMN "Sys_Role_Permission".permission_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_Role_Permission".permission_id IS '权限id';


--
-- Name: Sys_User_Role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Sys_User_Role" (
    id integer NOT NULL,
    user_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE public."Sys_User_Role" OWNER TO postgres;

--
-- Name: TABLE "Sys_User_Role"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public."Sys_User_Role" IS '用户角色表';


--
-- Name: COLUMN "Sys_User_Role".user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_User_Role".user_id IS '用户id';


--
-- Name: COLUMN "Sys_User_Role".role_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public."Sys_User_Role".role_id IS '角色id';


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

ALTER SEQUENCE public."Sys_User_Role_id_seq" OWNED BY public."Sys_User_Role".id;


--
-- Name: Sys_Permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sys_Permission" ALTER COLUMN id SET DEFAULT nextval('public."SysPermission_id_seq"'::regclass);


--
-- Name: Sys_Role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sys_Role" ALTER COLUMN id SET DEFAULT nextval('public."SysRole_id_seq"'::regclass);


--
-- Name: Sys_UserInfo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sys_UserInfo" ALTER COLUMN id SET DEFAULT nextval('public."SysUserInfo_id_seq"'::regclass);


--
-- Name: Sys_User_Role id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sys_User_Role" ALTER COLUMN id SET DEFAULT nextval('public."Sys_User_Role_id_seq"'::regclass);


--
-- Data for Name: Sys_Permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Sys_Permission" (id, permission_description, permission_name, permission_type, status, parent_id, url) FROM stdin;
1	系统管理	system:*	menu	1	0	\N
2	角色管理	system:role:*	menu	1	1	/role/config
3	密码修改	system:password	menu	1	1	/user/password/edition
4	操作日志	system:log:*	menu	1	1	/handle/operation/log
5	新增角色	system:role:create	url	1	1	/role/addtion
6	用户管理	system:admin:*	menu	1	1	/user/config
7	新增用户	system:user:create	url	1	1	/user/addition
\.


--
-- Data for Name: Sys_Role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Sys_Role" (id, role_name, status, description, remark) FROM stdin;
1	superAdmin	1	超级管理员	拥有所有权限
2	admin	1	系统管理员	拥有部分权限
3	user	1	普通用户	\N
\.


--
-- Data for Name: Sys_Role_Permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Sys_Role_Permission" (id, role_id, permission_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
7	1	7
8	2	2
\.


--
-- Data for Name: Sys_UserInfo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Sys_UserInfo" (id, mobile_phone, user_name, password, email, status, salt) FROM stdin;
1	13022222222	superadmin	827ccb0eea8a706c4c34a16891f84e7b	wanghongxu1994@qq.com	1	\N
2	13233333333	admin	827ccb0eea8a706c4c34a16891f84e7b	\N	1	\N
3	13026666666	user1	827ccb0eea8a706c4c34a16891f84e7b	normal@user.com	1	\N
\.


--
-- Data for Name: Sys_User_Role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Sys_User_Role" (id, user_id, role_id) FROM stdin;
1	1	1
2	2	2
3	3	3
\.


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

SELECT pg_catalog.setval('public."SysUserInfo_id_seq"', 1, false);


--
-- Name: Sys_User_Role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Sys_User_Role_id_seq"', 1, false);


--
-- Name: Sys_Role_Permission sys_role_permission_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sys_Role_Permission"
    ADD CONSTRAINT sys_role_permission_pk PRIMARY KEY (id);


--
-- Name: Sys_User_Role sys_user_role_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sys_User_Role"
    ADD CONSTRAINT sys_user_role_pk PRIMARY KEY (id);


--
-- Name: Sys_Permission syspermission_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sys_Permission"
    ADD CONSTRAINT syspermission_pk PRIMARY KEY (id);


--
-- Name: Sys_Role sysrole_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sys_Role"
    ADD CONSTRAINT sysrole_pk PRIMARY KEY (id);


--
-- Name: Sys_UserInfo sysuserinfo_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sys_UserInfo"
    ADD CONSTRAINT sysuserinfo_pk PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

