--
-- PostgreSQL database dump
--

-- Dumped from database version 14.16
-- Dumped by pg_dump version 14.16

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
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO postgres;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_attachments_id_seq OWNER TO postgres;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO postgres;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_blobs_id_seq OWNER TO postgres;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO postgres;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_variant_records_id_seq OWNER TO postgres;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cart_items (
    id bigint NOT NULL,
    cart_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.cart_items OWNER TO postgres;

--
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cart_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cart_items_id_seq OWNER TO postgres;

--
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
-- Name: carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.carts OWNER TO postgres;

--
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.carts_id_seq OWNER TO postgres;

--
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carts_id_seq OWNED BY public.carts.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id bigint NOT NULL,
    product_name character varying,
    price numeric,
    quantity integer,
    order_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_items_id_seq OWNER TO postgres;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    total_price numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    state integer,
    last_name character varying,
    first_name character varying,
    email character varying,
    address2 character varying,
    zip character varying,
    card_name character varying,
    card_expiration character varying,
    card_cvv character varying,
    billing_address character varying,
    credit_card_number character varying,
    user_id bigint
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    name character varying NOT NULL,
    price integer NOT NULL,
    description text NOT NULL,
    original_price integer,
    published boolean DEFAULT true NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    sku character varying,
    is_related boolean DEFAULT false NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: promotion_codes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.promotion_codes (
    id bigint NOT NULL,
    code character varying,
    discount_amount integer,
    used boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.promotion_codes OWNER TO postgres;

--
-- Name: promotion_codes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.promotion_codes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.promotion_codes_id_seq OWNER TO postgres;

--
-- Name: promotion_codes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.promotion_codes_id_seq OWNED BY public.promotion_codes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id bigint NOT NULL,
    session_id character varying NOT NULL,
    data text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sessions_id_seq OWNER TO postgres;

--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    id bigint NOT NULL,
    title character varying,
    description text,
    status integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tasks_id_seq OWNER TO postgres;

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- Name: carts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts ALTER COLUMN id SET DEFAULT nextval('public.carts_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: promotion_codes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion_codes ALTER COLUMN id SET DEFAULT nextval('public.promotion_codes_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
1	image	Product	1	1	2025-03-06 02:01:40.241158
2	image	Product	2	2	2025-03-06 02:01:40.44324
3	image	Product	3	3	2025-03-06 02:01:40.74256
4	image	Product	4	4	2025-03-06 02:01:40.974658
5	image	Product	5	5	2025-03-06 02:01:41.277148
6	image	Product	6	6	2025-03-06 02:01:41.497325
7	image	Product	7	7	2025-03-06 02:01:41.762013
8	image	Product	8	8	2025-03-06 02:01:41.955706
9	image	Product	9	9	2025-03-06 02:01:42.18514
10	image	Product	10	10	2025-03-06 02:01:42.338833
11	image	Product	11	11	2025-03-06 02:01:42.616014
12	image	Product	12	12	2025-03-06 02:01:42.861915
13	image	Product	13	13	2025-03-06 02:01:52.086778
14	image	Product	14	14	2025-03-06 02:01:52.27243
15	image	Product	15	15	2025-03-06 02:01:52.467798
16	image	Product	16	16	2025-03-06 02:01:52.74223
17	image	Product	17	17	2025-03-06 02:01:52.935234
18	image	Product	18	18	2025-03-06 02:01:53.193145
19	image	Product	19	19	2025-03-06 02:01:53.374898
20	image	Product	20	20	2025-03-06 02:01:53.616473
21	image	Product	21	21	2025-03-06 02:01:53.830015
22	image	Product	22	22	2025-03-06 02:01:53.991844
23	image	Product	23	23	2025-03-06 02:01:54.451738
24	image	Product	24	24	2025-03-06 02:01:54.609023
25	image	ActiveStorage::VariantRecord	3	25	2025-03-06 02:02:45.249865
26	image	ActiveStorage::VariantRecord	1	26	2025-03-06 02:02:45.250812
27	image	ActiveStorage::VariantRecord	2	27	2025-03-06 02:02:45.251629
28	image	ActiveStorage::VariantRecord	4	28	2025-03-06 02:02:45.914932
29	image	ActiveStorage::VariantRecord	5	29	2025-03-06 02:02:46.025701
30	image	ActiveStorage::VariantRecord	6	30	2025-03-06 02:02:57.260282
31	image	ActiveStorage::VariantRecord	7	31	2025-03-06 02:02:57.261137
32	image	ActiveStorage::VariantRecord	8	32	2025-03-06 02:09:46.169253
33	image	ActiveStorage::VariantRecord	11	33	2025-03-06 02:29:23.575036
34	image	ActiveStorage::VariantRecord	10	34	2025-03-06 02:29:23.57597
35	image	ActiveStorage::VariantRecord	9	35	2025-03-06 02:29:23.576786
36	image	ActiveStorage::VariantRecord	12	36	2025-03-06 02:29:24.151218
37	image	ActiveStorage::VariantRecord	13	37	2025-03-06 02:29:26.202801
38	image	ActiveStorage::VariantRecord	14	38	2025-03-06 02:29:29.10552
39	image	ActiveStorage::VariantRecord	15	39	2025-03-06 02:29:32.013904
40	image	ActiveStorage::VariantRecord	16	40	2025-03-06 02:29:52.928453
41	image	ActiveStorage::VariantRecord	17	41	2025-03-06 02:29:52.949352
42	image	ActiveStorage::VariantRecord	18	42	2025-03-06 02:29:52.98936
43	image	ActiveStorage::VariantRecord	19	43	2025-03-06 02:29:53.465975
44	image	ActiveStorage::VariantRecord	20	44	2025-03-06 02:29:53.467134
\.


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, service_name, byte_size, checksum, created_at) FROM stdin;
11	x1g6oy6lppp8x1443n0921t3cf4j	.png	image/png	{"identified":true}	amazon	158601	REs6K61A/HLZPgI/JCOGMQ==	2025-03-06 02:01:42.613312
12	8qyuckvl59agghexj6zu9p9rp9w6	.png	image/png	{"identified":true}	amazon	22039	C2WBn35LraDpXy7Iyu3hmA==	2025-03-06 02:01:42.860722
1	u2jl97kdzsewvzg1djrfarwtnplz	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	43012	Wztl/tiGuOFGhng2tB9EbA==	2025-03-06 02:01:40.239831
2	2o0zl3ckytkcju5q4ckhckhgnefq	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	28452	0LaWx0q9yEjruT78o2DxbQ==	2025-03-06 02:01:40.441043
3	nt943bed2825ecwcirha9a0c9in6	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	29356	eu2pw+1HPXAho2CNKA9yvw==	2025-03-06 02:01:40.738862
4	69u9cjp92w1rxraoa3x80vn77044	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	28106	Ln1EZBFfQeFIWB3ByDlOJQ==	2025-03-06 02:01:40.97235
5	8vxl0rn5ia6i4q69gr69rjyz7l6b	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	27361	kVkczeqD/eK35XaxM/Zkzg==	2025-03-06 02:01:41.274731
6	14j38hpnztr0mqxln7eqwszsk0pw	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	35682	HTQ5AvsVfjrDY1Ev/U8Fuw==	2025-03-06 02:01:41.494248
7	qepupfuf1cpu1hll6ok39trj1i7x	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	23030	5IsCJz2uJLEXb6/+PhZjMQ==	2025-03-06 02:01:41.758969
8	358tnpiirhibfnbmguq17yvtg5ej	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	34874	2zQJHLuxiCtBc4/i0/e9Jw==	2025-03-06 02:01:41.954134
9	uazqtqvcrv9289bln7jzrzbslp2k	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	22414	F2jBLb3sneTQS3VhI3vXSA==	2025-03-06 02:01:42.182285
10	8n0oy0z3s2ctr73fvz8kci1gfthy	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	21395	KO7JunJ//GScyHWs6QPNDg==	2025-03-06 02:01:42.336882
23	23y73hrsv5lj6d9hvx7ipnpdw6t1	.png	image/png	{"identified":true}	amazon	158601	REs6K61A/HLZPgI/JCOGMQ==	2025-03-06 02:01:54.449149
24	a9nkegjupro15bo61dr0jjxry6xg	.png	image/png	{"identified":true}	amazon	22039	C2WBn35LraDpXy7Iyu3hmA==	2025-03-06 02:01:54.606809
13	zzp5hrqari11qsm2ydozkyd1kwr0	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	43012	Wztl/tiGuOFGhng2tB9EbA==	2025-03-06 02:01:52.085641
14	o7ehxmw2lw7mjgq80smbrc3icqth	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	28452	0LaWx0q9yEjruT78o2DxbQ==	2025-03-06 02:01:52.270485
15	ipe2ajr59x47aqcozcv21oudg7ov	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	29356	eu2pw+1HPXAho2CNKA9yvw==	2025-03-06 02:01:52.464846
16	tw2j4xy4fyl6qgnxyzsbi0l4drx4	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	28106	Ln1EZBFfQeFIWB3ByDlOJQ==	2025-03-06 02:01:52.739722
17	t6y3amuir0ggiohwgjiezlahhfmg	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	27361	kVkczeqD/eK35XaxM/Zkzg==	2025-03-06 02:01:52.93352
18	kjwywsxeysry6l8ysicevckjc7jy	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	35682	HTQ5AvsVfjrDY1Ev/U8Fuw==	2025-03-06 02:01:53.190448
19	oh6ws83p9hdvren3b35gp8n0jrhr	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	23030	5IsCJz2uJLEXb6/+PhZjMQ==	2025-03-06 02:01:53.364171
20	d2935302bdwnig0sn96nqsa6op0q	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	34874	2zQJHLuxiCtBc4/i0/e9Jw==	2025-03-06 02:01:53.614762
21	suflbkhgxbvfje8g5r9ib5svu1ui	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	22414	F2jBLb3sneTQS3VhI3vXSA==	2025-03-06 02:01:53.827484
22	vjhujc6ylij6858mdljp3pg58h39	.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	21395	KO7JunJ//GScyHWs6QPNDg==	2025-03-06 02:01:53.989777
27	odaroow4unu0r5vkmkyfyy42bp9r	.png.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	17688	BMlcejLDMwbMTmRpL6/vZA==	2025-03-06 02:02:45.248892
25	o8f4esehvwh8l741bx81ugz5l072	.png.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	26081	5Imo3ZjkGfzeDx1qTnxhYw==	2025-03-06 02:02:45.246681
26	ihmkp6hvvjawc9bvkh17vdbjtg3b	.png.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	19944	gLWyuvK6KnZojXyEyuixog==	2025-03-06 02:02:45.247955
28	owzcbgq6saqtdo2p4jp98nby4ue8	.png.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	21177	MLrPw8eYFGk7Qfy8m+yCpA==	2025-03-06 02:02:45.913581
29	u37tkeynctm9nz8rym8xyatgc2m9	.png.png	image/png	{"identified":true,"width":243,"height":200,"analyzed":true}	amazon	46431	y2JE5wVqd/wyvpUQG/vKmw==	2025-03-06 02:02:46.024587
31	yax1ipwxhsdco7v36uc0utfzz14s	.png.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	21177	MLrPw8eYFGk7Qfy8m+yCpA==	2025-03-06 02:02:57.259166
30	xkvfv2bb2swgcv9nxffz6z4vfyk7	.png.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	44787	JceyPFRebr4D1JWPcB3hJw==	2025-03-06 02:02:57.257875
32	tge1l3s8yh2ifhv01l8t8rwdwma6	.png.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	44787	JceyPFRebr4D1JWPcB3hJw==	2025-03-06 02:09:46.166189
33	arp1hqsqi5clj6xnne8kctgyuyze	.png.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	17688	BMlcejLDMwbMTmRpL6/vZA==	2025-03-06 02:29:23.571751
34	y2fm1q8235sa9a44ennpqrfsvmlq	.png.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	19944	gLWyuvK6KnZojXyEyuixog==	2025-03-06 02:29:23.573102
35	1pkeunvrsfzmzlje1vifelgyz14h	.png.png	image/png	{"identified":true,"width":243,"height":200,"analyzed":true}	amazon	46431	y2JE5wVqd/wyvpUQG/vKmw==	2025-03-06 02:29:23.57406
36	b3915rak6hrm861b71i5zow6lem3	.png.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	21177	MLrPw8eYFGk7Qfy8m+yCpA==	2025-03-06 02:29:24.149777
37	v8yvh0w1iwr2feqmrbchd3axv0za	.png.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	21177	MLrPw8eYFGk7Qfy8m+yCpA==	2025-03-06 02:29:26.201078
38	i6lthmccvvguvj59iva8tiv7re37	.png.png	image/png	{"identified":true,"width":365,"height":300,"analyzed":true}	amazon	91112	i5BFMBFNv/eYqZe0MABmFg==	2025-03-06 02:29:29.103343
39	rs3wxtd4x38autvd0alog1nmqejw	.png.png	image/png	{"identified":true,"width":180,"height":180,"analyzed":true}	amazon	17688	BMlcejLDMwbMTmRpL6/vZA==	2025-03-06 02:29:32.012036
42	21exizkl8ypp62hs8uqhhzd5f3n2	.png.png	image/png	{"identified":true,"width":50,"height":41,"analyzed":true}	amazon	4609	XGXPaVsAzioG72taVkaBWA==	2025-03-06 02:29:52.987685
44	tqmrjy7r29u7b5n6rotq4bbi7q1f	.png.png	image/png	{"identified":true,"width":50,"height":50,"analyzed":true}	amazon	4570	z09pUZ+JTyP2KpnZ5DzmPA==	2025-03-06 02:29:53.463954
40	dz7apgfhxa7azcvzuirg5s70sztl	.png.png	image/png	{"identified":true,"width":50,"height":50,"analyzed":true}	amazon	6553	fE8HmkjVrBaX5tOgD16uhw==	2025-03-06 02:29:52.926355
41	8pd6is3sicvp8jq0txob3tch361h	.png.png	image/png	{"identified":true,"width":50,"height":41,"analyzed":true}	amazon	4609	XGXPaVsAzioG72taVkaBWA==	2025-03-06 02:29:52.948276
43	iwduto5ed5w0nols9ed7ps7075gz	.png.png	image/png	{"identified":true,"width":50,"height":50,"analyzed":true}	amazon	4676	Yli3pD/CJ7Y5O/Gwfdldgg==	2025-03-06 02:29:53.462593
\.


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
1	9	bD387SGF+QkwI+vaW49ulv5YQsg=
2	10	bD387SGF+QkwI+vaW49ulv5YQsg=
3	5	5gM+tAVQoO5S8rpyH80ThsJq+OM=
4	12	bD387SGF+QkwI+vaW49ulv5YQsg=
5	11	bD387SGF+QkwI+vaW49ulv5YQsg=
6	13	bD387SGF+QkwI+vaW49ulv5YQsg=
7	12	5gM+tAVQoO5S8rpyH80ThsJq+OM=
8	1	5gM+tAVQoO5S8rpyH80ThsJq+OM=
9	23	bD387SGF+QkwI+vaW49ulv5YQsg=
10	21	bD387SGF+QkwI+vaW49ulv5YQsg=
11	22	bD387SGF+QkwI+vaW49ulv5YQsg=
12	24	bD387SGF+QkwI+vaW49ulv5YQsg=
13	24	5gM+tAVQoO5S8rpyH80ThsJq+OM=
14	23	5gM+tAVQoO5S8rpyH80ThsJq+OM=
15	22	5gM+tAVQoO5S8rpyH80ThsJq+OM=
16	1	ZmDfamq3DaAOqmqEnqBAWE4VJTE=
17	23	ZmDfamq3DaAOqmqEnqBAWE4VJTE=
18	11	ZmDfamq3DaAOqmqEnqBAWE4VJTE=
19	5	ZmDfamq3DaAOqmqEnqBAWE4VJTE=
20	24	ZmDfamq3DaAOqmqEnqBAWE4VJTE=
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2025-03-06 02:01:39.807832	2025-03-06 02:01:39.807832
schema_sha1	62cd2c133c664702024a8403a6a3c8847ced1331	2025-03-06 02:01:39.81226	2025-03-06 02:01:39.81226
\.


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cart_items (id, cart_id, product_id, quantity, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carts (id, created_at, updated_at) FROM stdin;
2	2025-03-07 06:57:39.739785	2025-03-07 06:57:39.739785
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, product_name, price, quantity, order_id, created_at, updated_at) FROM stdin;
1	高菜おにぎり	2000.0	1	1	2025-03-07 06:57:39.554526	2025-03-07 06:57:39.554526
2	スパムおにぎり	4000.0	1	1	2025-03-07 06:57:39.559534	2025-03-07 06:57:39.559534
3	天むすおにぎり	5000.0	5	1	2025-03-07 06:57:39.564313	2025-03-07 06:57:39.564313
4	台湾おにぎり	4000.0	5	1	2025-03-07 06:57:39.567182	2025-03-07 06:57:39.567182
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, total_price, created_at, updated_at, state, last_name, first_name, email, address2, zip, card_name, card_expiration, card_cvv, billing_address, credit_card_number, user_id) FROM stdin;
1	51000.0	2025-03-07 06:57:39.535172	2025-03-07 06:57:39.535172	43	上村	龍太	longtaishangcun@gmail.com	2-11-10	862-0922	RYUTA UEMURA	12/26	123	三郎	1234123412341234	\N
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, price, description, original_price, published, created_at, updated_at, sku, is_related) FROM stdin;
1	高菜おにぎり	2000	高菜をふんだんに使ったおにぎり	\N	t	2025-03-06 02:01:39.868122	2025-03-06 02:01:40.24206	\N	f
2	鮭おにぎり	3000	新鮮な鮭を使ったおにぎり	\N	t	2025-03-06 02:01:40.242414	2025-03-06 02:01:40.44508	\N	f
3	たらこおにぎり	3000	風味豊かなタラコを使ったおにぎり	\N	t	2025-03-06 02:01:40.445878	2025-03-06 02:01:40.744984	\N	f
4	梅おにぎり	2000	さっぱりとした梅の酸味が楽しめるおにぎり	\N	t	2025-03-06 02:01:40.747395	2025-03-06 02:01:40.97623	\N	f
5	天むすおにぎり	5000	海老の天ぷらが入ったおにぎり	\N	t	2025-03-06 02:01:40.976859	2025-03-06 02:01:41.27944	\N	f
6	焼きおにぎり	2000	香ばしい焼きおにぎり	\N	t	2025-03-06 02:01:41.280161	2025-03-06 02:01:41.499413	\N	f
7	ゆかりおにぎり	2000	ゆかりをまぶしたおにぎり	\N	t	2025-03-06 02:01:41.500204	2025-03-06 02:01:41.763665	\N	f
8	赤飯おにぎり	2500	もち米を使用した赤飯おにぎり	\N	t	2025-03-06 02:01:41.76475	2025-03-06 02:01:41.956665	\N	f
9	シーチキンおにぎり	3000	シーチキンを使用したおにぎり	\N	t	2025-03-06 02:01:41.957233	2025-03-06 02:01:42.188041	\N	f
10	わかめおにぎり	2000	わかめを使用したおにぎり	\N	t	2025-03-06 02:01:42.188865	2025-03-06 02:01:42.340275	\N	f
11	スパムおにぎり	4000	スパムを使用したおにぎり	\N	t	2025-03-06 02:01:42.34098	2025-03-06 02:01:42.64263	\N	f
12	台湾おにぎり	4000	本格的な台湾おにぎり	\N	t	2025-03-06 02:01:42.647259	2025-03-06 02:01:42.862751	\N	f
13	高菜おにぎり	2000	高菜をふんだんに使ったおにぎり	\N	t	2025-03-06 02:01:51.735355	2025-03-06 02:01:52.087713	\N	f
14	鮭おにぎり	3000	新鮮な鮭を使ったおにぎり	\N	t	2025-03-06 02:01:52.088125	2025-03-06 02:01:52.274108	\N	f
15	たらこおにぎり	3000	風味豊かなタラコを使ったおにぎり	\N	t	2025-03-06 02:01:52.27474	2025-03-06 02:01:52.469174	\N	f
16	梅おにぎり	2000	さっぱりとした梅の酸味が楽しめるおにぎり	\N	t	2025-03-06 02:01:52.470109	2025-03-06 02:01:52.743991	\N	f
17	天むすおにぎり	5000	海老の天ぷらが入ったおにぎり	\N	t	2025-03-06 02:01:52.744807	2025-03-06 02:01:52.936522	\N	f
18	焼きおにぎり	2000	香ばしい焼きおにぎり	\N	t	2025-03-06 02:01:52.937172	2025-03-06 02:01:53.194825	\N	f
19	ゆかりおにぎり	2000	ゆかりをまぶしたおにぎり	\N	t	2025-03-06 02:01:53.195616	2025-03-06 02:01:53.383448	\N	f
20	赤飯おにぎり	2500	もち米を使用した赤飯おにぎり	\N	t	2025-03-06 02:01:53.383999	2025-03-06 02:01:53.617673	\N	f
21	シーチキンおにぎり	3000	シーチキンを使用したおにぎり	\N	t	2025-03-06 02:01:53.618094	2025-03-06 02:01:53.83214	\N	f
22	わかめおにぎり	2000	わかめを使用したおにぎり	\N	t	2025-03-06 02:01:53.832839	2025-03-06 02:01:53.993313	\N	f
23	スパムおにぎり	4000	スパムを使用したおにぎり	\N	t	2025-03-06 02:01:53.994067	2025-03-06 02:01:54.454872	\N	f
24	台湾おにぎり	4000	本格的な台湾おにぎり	\N	t	2025-03-06 02:01:54.455582	2025-03-06 02:01:54.610401	\N	f
\.


--
-- Data for Name: promotion_codes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.promotion_codes (id, code, discount_amount, used, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20250305101107
20250304104315
20250304104317
20250304104320
20250304104322
20250304104324
20250305101106
20250307054121
20250307064952
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, session_id, data, created_at, updated_at) FROM stdin;
1	2::182fca95b49b4ccbe782a977076b2de0dbc1bc4e62549d0827b304fdb4f9d012	BAh7B0kiEF9jc3JmX3Rva2VuBjoGRUZJIjBtQzE4OUJON2hKRXg5TWJqc2lz\nS3NpT1dwa2syS0JmWVg4NFA4SEt0TW84BjsARkkiDGNhcnRfaWQGOwBGaQc=\n	2025-03-06 02:02:27.654879	2025-03-07 06:57:39.923791
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (id, title, description, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at) FROM stdin;
\.


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 44, true);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 44, true);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 20, true);


--
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cart_items_id_seq', 5, true);


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carts_id_seq', 2, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 4, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 24, true);


--
-- Name: promotion_codes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.promotion_codes_id_seq', 1, false);


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sessions_id_seq', 1, true);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tasks_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: promotion_codes promotion_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.promotion_codes
    ADD CONSTRAINT promotion_codes_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_cart_items_on_cart_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_cart_items_on_cart_id ON public.cart_items USING btree (cart_id);


--
-- Name: index_cart_items_on_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_cart_items_on_product_id ON public.cart_items USING btree (product_id);


--
-- Name: index_order_items_on_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_order_items_on_order_id ON public.order_items USING btree (order_id);


--
-- Name: index_orders_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_orders_on_user_id ON public.orders USING btree (user_id);


--
-- Name: index_sessions_on_session_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_sessions_on_session_id ON public.sessions USING btree (session_id);


--
-- Name: index_sessions_on_updated_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_sessions_on_updated_at ON public.sessions USING btree (updated_at);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: order_items fk_rails_e3cb28f071; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT fk_rails_e3cb28f071 FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: orders fk_rails_f868b47f6a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_rails_f868b47f6a FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

