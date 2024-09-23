--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-09-23 05:54:45

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

--
-- TOC entry 5097 (class 1262 OID 20070)
-- Name: shoppe; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE shoppe WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';


ALTER DATABASE shoppe OWNER TO postgres;

\connect shoppe

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

--
-- TOC entry 10 (class 2615 OID 20113)
-- Name: financials; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA financials;


ALTER SCHEMA financials OWNER TO postgres;

--
-- TOC entry 7 (class 2615 OID 20110)
-- Name: products; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA products;


ALTER SCHEMA products OWNER TO postgres;

--
-- TOC entry 9 (class 2615 OID 20112)
-- Name: promotions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA promotions;


ALTER SCHEMA promotions OWNER TO postgres;

--
-- TOC entry 8 (class 2615 OID 20111)
-- Name: stores; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA stores;


ALTER SCHEMA stores OWNER TO postgres;

--
-- TOC entry 6 (class 2615 OID 20109)
-- Name: users; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA users;


ALTER SCHEMA users OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 247 (class 1259 OID 20320)
-- Name: categories; Type: TABLE; Schema: products; Owner: postgres
--

CREATE TABLE products.categories (
    category_id bigint NOT NULL,
    store_id bigint NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(100),
    parent_id bigint,
    created_on timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_on timestamp with time zone,
    updated_by bigint
);


ALTER TABLE products.categories OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 20319)
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: products; Owner: postgres
--

CREATE SEQUENCE products.categories_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE products.categories_category_id_seq OWNER TO postgres;

--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 246
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: products; Owner: postgres
--

ALTER SEQUENCE products.categories_category_id_seq OWNED BY products.categories.category_id;


--
-- TOC entry 249 (class 1259 OID 20335)
-- Name: products; Type: TABLE; Schema: products; Owner: postgres
--

CREATE TABLE products.products (
    product_id bigint NOT NULL,
    branch_id bigint NOT NULL,
    name character varying NOT NULL,
    description character varying,
    sku character varying(100),
    slug character varying,
    status boolean DEFAULT true,
    created_on timestamp with time zone DEFAULT now(),
    updated_on timestamp with time zone
);


ALTER TABLE products.products OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 20371)
-- Name: products_categories; Type: TABLE; Schema: products; Owner: postgres
--

CREATE TABLE products.products_categories (
    branch_id bigint NOT NULL,
    product_id bigint NOT NULL,
    category_id bigint NOT NULL
);


ALTER TABLE products.products_categories OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 20412)
-- Name: products_images; Type: TABLE; Schema: products; Owner: postgres
--

CREATE TABLE products.products_images (
    product_image_id bigint NOT NULL,
    product_id bigint NOT NULL,
    img character varying NOT NULL,
    is_primary boolean
);


ALTER TABLE products.products_images OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 20411)
-- Name: products_images_product_image_id_seq; Type: SEQUENCE; Schema: products; Owner: postgres
--

CREATE SEQUENCE products.products_images_product_image_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE products.products_images_product_image_id_seq OWNER TO postgres;

--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 253
-- Name: products_images_product_image_id_seq; Type: SEQUENCE OWNED BY; Schema: products; Owner: postgres
--

ALTER SEQUENCE products.products_images_product_image_id_seq OWNED BY products.products_images.product_image_id;


--
-- TOC entry 251 (class 1259 OID 20356)
-- Name: products_pricing; Type: TABLE; Schema: products; Owner: postgres
--

CREATE TABLE products.products_pricing (
    product_price_id bigint NOT NULL,
    product_id bigint NOT NULL,
    price numeric,
    currency character varying(5)
);


ALTER TABLE products.products_pricing OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 20355)
-- Name: products_pricing_product_price_id_seq; Type: SEQUENCE; Schema: products; Owner: postgres
--

CREATE SEQUENCE products.products_pricing_product_price_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE products.products_pricing_product_price_id_seq OWNER TO postgres;

--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 250
-- Name: products_pricing_product_price_id_seq; Type: SEQUENCE OWNED BY; Schema: products; Owner: postgres
--

ALTER SEQUENCE products.products_pricing_product_price_id_seq OWNED BY products.products_pricing.product_price_id;


--
-- TOC entry 248 (class 1259 OID 20334)
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: products; Owner: postgres
--

CREATE SEQUENCE products.products_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE products.products_product_id_seq OWNER TO postgres;

--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 248
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: products; Owner: postgres
--

ALTER SEQUENCE products.products_product_id_seq OWNED BY products.products.product_id;


--
-- TOC entry 256 (class 1259 OID 20426)
-- Name: products_stock; Type: TABLE; Schema: products; Owner: postgres
--

CREATE TABLE products.products_stock (
    product_stock_id bigint NOT NULL,
    branch_id bigint,
    product_id bigint NOT NULL,
    quantity numeric,
    updated_on time with time zone DEFAULT now()
);


ALTER TABLE products.products_stock OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 20425)
-- Name: products_stock_product_stock_id_seq; Type: SEQUENCE; Schema: products; Owner: postgres
--

CREATE SEQUENCE products.products_stock_product_stock_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE products.products_stock_product_stock_id_seq OWNER TO postgres;

--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 255
-- Name: products_stock_product_stock_id_seq; Type: SEQUENCE OWNED BY; Schema: products; Owner: postgres
--

ALTER SEQUENCE products.products_stock_product_stock_id_seq OWNED BY products.products_stock.product_stock_id;


--
-- TOC entry 241 (class 1259 OID 20258)
-- Name: offer_condition_types; Type: TABLE; Schema: promotions; Owner: postgres
--

CREATE TABLE promotions.offer_condition_types (
    offer_condition_type_id integer NOT NULL,
    condition_type character varying NOT NULL
);


ALTER TABLE promotions.offer_condition_types OWNER TO postgres;

--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE offer_condition_types; Type: COMMENT; Schema: promotions; Owner: postgres
--

COMMENT ON TABLE promotions.offer_condition_types IS 'Conditions for an offer (e.g., specific products, categories, or customer groups).';


--
-- TOC entry 240 (class 1259 OID 20257)
-- Name: offer_condition_types_offer_condition_type_id_seq; Type: SEQUENCE; Schema: promotions; Owner: postgres
--

CREATE SEQUENCE promotions.offer_condition_types_offer_condition_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE promotions.offer_condition_types_offer_condition_type_id_seq OWNER TO postgres;

--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 240
-- Name: offer_condition_types_offer_condition_type_id_seq; Type: SEQUENCE OWNED BY; Schema: promotions; Owner: postgres
--

ALTER SEQUENCE promotions.offer_condition_types_offer_condition_type_id_seq OWNED BY promotions.offer_condition_types.offer_condition_type_id;


--
-- TOC entry 243 (class 1259 OID 20267)
-- Name: offer_conditions; Type: TABLE; Schema: promotions; Owner: postgres
--

CREATE TABLE promotions.offer_conditions (
    offer_condition_id bigint NOT NULL,
    offer_id bigint NOT NULL,
    offer_condition_type_id bigint NOT NULL,
    condition_value numeric NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE promotions.offer_conditions OWNER TO postgres;

--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE offer_conditions; Type: COMMENT; Schema: promotions; Owner: postgres
--

COMMENT ON TABLE promotions.offer_conditions IS 'Conditions under which an offer can be applied (e.g., specific products, categories, or customer groups).';


--
-- TOC entry 242 (class 1259 OID 20266)
-- Name: offer_conditions_offer_condition_id_seq; Type: SEQUENCE; Schema: promotions; Owner: postgres
--

CREATE SEQUENCE promotions.offer_conditions_offer_condition_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE promotions.offer_conditions_offer_condition_id_seq OWNER TO postgres;

--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 242
-- Name: offer_conditions_offer_condition_id_seq; Type: SEQUENCE OWNED BY; Schema: promotions; Owner: postgres
--

ALTER SEQUENCE promotions.offer_conditions_offer_condition_id_seq OWNED BY promotions.offer_conditions.offer_condition_id;


--
-- TOC entry 237 (class 1259 OID 20224)
-- Name: offer_types; Type: TABLE; Schema: promotions; Owner: postgres
--

CREATE TABLE promotions.offer_types (
    offer_type_id integer NOT NULL,
    offer_type character varying(50) NOT NULL
);


ALTER TABLE promotions.offer_types OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 20223)
-- Name: offer_types_offer_type_id_seq; Type: SEQUENCE; Schema: promotions; Owner: postgres
--

CREATE SEQUENCE promotions.offer_types_offer_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE promotions.offer_types_offer_type_id_seq OWNER TO postgres;

--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 236
-- Name: offer_types_offer_type_id_seq; Type: SEQUENCE OWNED BY; Schema: promotions; Owner: postgres
--

ALTER SEQUENCE promotions.offer_types_offer_type_id_seq OWNED BY promotions.offer_types.offer_type_id;


--
-- TOC entry 239 (class 1259 OID 20231)
-- Name: offers; Type: TABLE; Schema: promotions; Owner: postgres
--

CREATE TABLE promotions.offers (
    offer_id bigint NOT NULL,
    store_id bigint,
    branch_id bigint,
    name character varying(100) NOT NULL,
    description character varying,
    start_date timestamp without time zone DEFAULT CURRENT_DATE NOT NULL,
    end_date timestamp without time zone NOT NULL,
    is_active boolean DEFAULT true,
    offer_type_id integer,
    discount_value numeric,
    max_discount numeric,
    min_order_value numeric,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    created_by bigint,
    updated_by bigint,
    offer_poster character varying
);


ALTER TABLE promotions.offers OWNER TO postgres;

--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE offers; Type: COMMENT; Schema: promotions; Owner: postgres
--

COMMENT ON TABLE promotions.offers IS 'General information about each offer or promotion';


--
-- TOC entry 238 (class 1259 OID 20230)
-- Name: offers_offer_id_seq; Type: SEQUENCE; Schema: promotions; Owner: postgres
--

CREATE SEQUENCE promotions.offers_offer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE promotions.offers_offer_id_seq OWNER TO postgres;

--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 238
-- Name: offers_offer_id_seq; Type: SEQUENCE OWNED BY; Schema: promotions; Owner: postgres
--

ALTER SEQUENCE promotions.offers_offer_id_seq OWNED BY promotions.offers.offer_id;


--
-- TOC entry 245 (class 1259 OID 20289)
-- Name: user_offers; Type: TABLE; Schema: promotions; Owner: postgres
--

CREATE TABLE promotions.user_offers (
    user_offer_id bigint NOT NULL,
    user_id bigint NOT NULL,
    offer_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE promotions.user_offers OWNER TO postgres;

--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 245
-- Name: TABLE user_offers; Type: COMMENT; Schema: promotions; Owner: postgres
--

COMMENT ON TABLE promotions.user_offers IS 'If there are user-specific promotions, this table will track which users are eligible for which promotions.';


--
-- TOC entry 244 (class 1259 OID 20288)
-- Name: user_offers_user_offer_id_seq; Type: SEQUENCE; Schema: promotions; Owner: postgres
--

CREATE SEQUENCE promotions.user_offers_user_offer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE promotions.user_offers_user_offer_id_seq OWNER TO postgres;

--
-- TOC entry 5111 (class 0 OID 0)
-- Dependencies: 244
-- Name: user_offers_user_offer_id_seq; Type: SEQUENCE OWNED BY; Schema: promotions; Owner: postgres
--

ALTER SEQUENCE promotions.user_offers_user_offer_id_seq OWNED BY promotions.user_offers.user_offer_id;


--
-- TOC entry 220 (class 1259 OID 20074)
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    country_id integer NOT NULL,
    country character varying(30) NOT NULL,
    a2 character varying(2),
    a3 character varying(3),
    dial character varying(4),
    currency character varying(4)
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 20077)
-- Name: countries_country_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.countries_country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.countries_country_id_seq OWNER TO postgres;

--
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 221
-- Name: countries_country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.countries_country_id_seq OWNED BY public.countries.country_id;


--
-- TOC entry 225 (class 1259 OID 20100)
-- Name: tenants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tenants (
    tenant_id integer NOT NULL,
    tenant_name character varying(100) NOT NULL,
    token character varying(50),
    slug character varying(100),
    is_active boolean,
    created_on timestamp with time zone DEFAULT now()
);


ALTER TABLE public.tenants OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 20099)
-- Name: tenants_tenant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tenants_tenant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tenants_tenant_id_seq OWNER TO postgres;

--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 224
-- Name: tenants_tenant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tenants_tenant_id_seq OWNED BY public.tenants.tenant_id;


--
-- TOC entry 222 (class 1259 OID 20085)
-- Name: towns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.towns (
    town_id bigint NOT NULL,
    town character varying(100) NOT NULL,
    country_id bigint NOT NULL,
    sort_order bigint
);


ALTER TABLE public.towns OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 20088)
-- Name: towns_town_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.towns_town_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.towns_town_id_seq OWNER TO postgres;

--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 223
-- Name: towns_town_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.towns_town_id_seq OWNED BY public.towns.town_id;


--
-- TOC entry 235 (class 1259 OID 20190)
-- Name: branches; Type: TABLE; Schema: stores; Owner: postgres
--

CREATE TABLE stores.branches (
    branch_id bigint NOT NULL,
    store_id integer NOT NULL,
    name character varying NOT NULL,
    address character varying,
    town_id integer,
    icon character varying(100),
    open_time time without time zone,
    close_time time without time zone,
    is_24_hrs boolean DEFAULT false,
    gps_coordinates point,
    is_enabled boolean DEFAULT true,
    created_on timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_on timestamp with time zone,
    updated_by bigint
);


ALTER TABLE stores.branches OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 20189)
-- Name: branches_branch_id_seq; Type: SEQUENCE; Schema: stores; Owner: postgres
--

CREATE SEQUENCE stores.branches_branch_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE stores.branches_branch_id_seq OWNER TO postgres;

--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 234
-- Name: branches_branch_id_seq; Type: SEQUENCE OWNED BY; Schema: stores; Owner: postgres
--

ALTER SEQUENCE stores.branches_branch_id_seq OWNED BY stores.branches.branch_id;


--
-- TOC entry 233 (class 1259 OID 20160)
-- Name: stores; Type: TABLE; Schema: stores; Owner: postgres
--

CREATE TABLE stores.stores (
    store_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(100),
    country_id integer NOT NULL,
    town_id integer,
    logo character varying(100),
    is_enabled boolean,
    created_on timestamp with time zone DEFAULT now(),
    created_by bigint,
    updated_on timestamp with time zone,
    updated_by bigint
);


ALTER TABLE stores.stores OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 20159)
-- Name: stores_store_id_seq; Type: SEQUENCE; Schema: stores; Owner: postgres
--

CREATE SEQUENCE stores.stores_store_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE stores.stores_store_id_seq OWNER TO postgres;

--
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 232
-- Name: stores_store_id_seq; Type: SEQUENCE OWNED BY; Schema: stores; Owner: postgres
--

ALTER SEQUENCE stores.stores_store_id_seq OWNED BY stores.stores.store_id;


--
-- TOC entry 229 (class 1259 OID 20132)
-- Name: admin_users; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.admin_users (
    admin_user_id bigint NOT NULL,
    active boolean DEFAULT true,
    last_active timestamp with time zone DEFAULT now(),
    pwd character varying NOT NULL,
    token character varying,
    created_on timestamp with time zone DEFAULT now() NOT NULL,
    updated_on timestamp with time zone
);


ALTER TABLE users.admin_users OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 20131)
-- Name: admin_users_admin_user_id_seq; Type: SEQUENCE; Schema: users; Owner: postgres
--

CREATE SEQUENCE users.admin_users_admin_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE users.admin_users_admin_user_id_seq OWNER TO postgres;

--
-- TOC entry 5117 (class 0 OID 0)
-- Dependencies: 228
-- Name: admin_users_admin_user_id_seq; Type: SEQUENCE OWNED BY; Schema: users; Owner: postgres
--

ALTER SEQUENCE users.admin_users_admin_user_id_seq OWNED BY users.admin_users.admin_user_id;


--
-- TOC entry 231 (class 1259 OID 20146)
-- Name: app_user_profile; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.app_user_profile (
    app_user_profile_id bigint NOT NULL,
    app_user_id bigint NOT NULL,
    user_name character varying,
    email character varying,
    phone character varying,
    updated_on timestamp with time zone,
    last_gps_location point
);


ALTER TABLE users.app_user_profile OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 20145)
-- Name: app_user_profile_app_user_profile_id_seq; Type: SEQUENCE; Schema: users; Owner: postgres
--

CREATE SEQUENCE users.app_user_profile_app_user_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE users.app_user_profile_app_user_profile_id_seq OWNER TO postgres;

--
-- TOC entry 5118 (class 0 OID 0)
-- Dependencies: 230
-- Name: app_user_profile_app_user_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: users; Owner: postgres
--

ALTER SEQUENCE users.app_user_profile_app_user_profile_id_seq OWNED BY users.app_user_profile.app_user_profile_id;


--
-- TOC entry 227 (class 1259 OID 20115)
-- Name: app_users; Type: TABLE; Schema: users; Owner: postgres
--

CREATE TABLE users.app_users (
    app_user_id bigint NOT NULL,
    active boolean DEFAULT true,
    last_active timestamp with time zone DEFAULT now(),
    pwd character varying NOT NULL,
    token character varying,
    created_on timestamp with time zone DEFAULT now() NOT NULL,
    updated_on timestamp with time zone
);


ALTER TABLE users.app_users OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 20114)
-- Name: app_users_app_user_id_seq; Type: SEQUENCE; Schema: users; Owner: postgres
--

CREATE SEQUENCE users.app_users_app_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE users.app_users_app_user_id_seq OWNER TO postgres;

--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 226
-- Name: app_users_app_user_id_seq; Type: SEQUENCE OWNED BY; Schema: users; Owner: postgres
--

ALTER SEQUENCE users.app_users_app_user_id_seq OWNED BY users.app_users.app_user_id;


--
-- TOC entry 4811 (class 2604 OID 20323)
-- Name: categories category_id; Type: DEFAULT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.categories ALTER COLUMN category_id SET DEFAULT nextval('products.categories_category_id_seq'::regclass);


--
-- TOC entry 4813 (class 2604 OID 20338)
-- Name: products product_id; Type: DEFAULT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products ALTER COLUMN product_id SET DEFAULT nextval('products.products_product_id_seq'::regclass);


--
-- TOC entry 4817 (class 2604 OID 20415)
-- Name: products_images product_image_id; Type: DEFAULT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products_images ALTER COLUMN product_image_id SET DEFAULT nextval('products.products_images_product_image_id_seq'::regclass);


--
-- TOC entry 4816 (class 2604 OID 20359)
-- Name: products_pricing product_price_id; Type: DEFAULT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products_pricing ALTER COLUMN product_price_id SET DEFAULT nextval('products.products_pricing_product_price_id_seq'::regclass);


--
-- TOC entry 4818 (class 2604 OID 20429)
-- Name: products_stock product_stock_id; Type: DEFAULT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products_stock ALTER COLUMN product_stock_id SET DEFAULT nextval('products.products_stock_product_stock_id_seq'::regclass);


--
-- TOC entry 4806 (class 2604 OID 20261)
-- Name: offer_condition_types offer_condition_type_id; Type: DEFAULT; Schema: promotions; Owner: postgres
--

ALTER TABLE ONLY promotions.offer_condition_types ALTER COLUMN offer_condition_type_id SET DEFAULT nextval('promotions.offer_condition_types_offer_condition_type_id_seq'::regclass);


--
-- TOC entry 4807 (class 2604 OID 20270)
-- Name: offer_conditions offer_condition_id; Type: DEFAULT; Schema: promotions; Owner: postgres
--

ALTER TABLE ONLY promotions.offer_conditions ALTER COLUMN offer_condition_id SET DEFAULT nextval('promotions.offer_conditions_offer_condition_id_seq'::regclass);


--
-- TOC entry 4801 (class 2604 OID 20227)
-- Name: offer_types offer_type_id; Type: DEFAULT; Schema: promotions; Owner: postgres
--

ALTER TABLE ONLY promotions.offer_types ALTER COLUMN offer_type_id SET DEFAULT nextval('promotions.offer_types_offer_type_id_seq'::regclass);


--
-- TOC entry 4802 (class 2604 OID 20234)
-- Name: offers offer_id; Type: DEFAULT; Schema: promotions; Owner: postgres
--

ALTER TABLE ONLY promotions.offers ALTER COLUMN offer_id SET DEFAULT nextval('promotions.offers_offer_id_seq'::regclass);


--
-- TOC entry 4809 (class 2604 OID 20292)
-- Name: user_offers user_offer_id; Type: DEFAULT; Schema: promotions; Owner: postgres
--

ALTER TABLE ONLY promotions.user_offers ALTER COLUMN user_offer_id SET DEFAULT nextval('promotions.user_offers_user_offer_id_seq'::regclass);


--
-- TOC entry 4782 (class 2604 OID 20078)
-- Name: countries country_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries ALTER COLUMN country_id SET DEFAULT nextval('public.countries_country_id_seq'::regclass);


--
-- TOC entry 4784 (class 2604 OID 20103)
-- Name: tenants tenant_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenants ALTER COLUMN tenant_id SET DEFAULT nextval('public.tenants_tenant_id_seq'::regclass);


--
-- TOC entry 4783 (class 2604 OID 20089)
-- Name: towns town_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.towns ALTER COLUMN town_id SET DEFAULT nextval('public.towns_town_id_seq'::regclass);


--
-- TOC entry 4797 (class 2604 OID 20193)
-- Name: branches branch_id; Type: DEFAULT; Schema: stores; Owner: postgres
--

ALTER TABLE ONLY stores.branches ALTER COLUMN branch_id SET DEFAULT nextval('stores.branches_branch_id_seq'::regclass);


--
-- TOC entry 4795 (class 2604 OID 20163)
-- Name: stores store_id; Type: DEFAULT; Schema: stores; Owner: postgres
--

ALTER TABLE ONLY stores.stores ALTER COLUMN store_id SET DEFAULT nextval('stores.stores_store_id_seq'::regclass);


--
-- TOC entry 4790 (class 2604 OID 20135)
-- Name: admin_users admin_user_id; Type: DEFAULT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.admin_users ALTER COLUMN admin_user_id SET DEFAULT nextval('users.admin_users_admin_user_id_seq'::regclass);


--
-- TOC entry 4794 (class 2604 OID 20149)
-- Name: app_user_profile app_user_profile_id; Type: DEFAULT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.app_user_profile ALTER COLUMN app_user_profile_id SET DEFAULT nextval('users.app_user_profile_app_user_profile_id_seq'::regclass);


--
-- TOC entry 4786 (class 2604 OID 20118)
-- Name: app_users app_user_id; Type: DEFAULT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.app_users ALTER COLUMN app_user_id SET DEFAULT nextval('users.app_users_app_user_id_seq'::regclass);


--
-- TOC entry 5082 (class 0 OID 20320)
-- Dependencies: 247
-- Data for Name: categories; Type: TABLE DATA; Schema: products; Owner: postgres
--

INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (1, 1, 'Alcohol', 'alcohol', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (2, 1, 'Dairy', 'dairy', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (3, 1, 'Poultry', 'poultry', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (4, 1, 'Baby', 'baby', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (5, 1, 'Bakery', 'bakery', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (6, 1, 'Bedding', 'bedding', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (7, 1, 'Beverages', 'beverages', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (8, 1, 'Breakfast', 'breakfast', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (9, 1, 'Cleaning', 'cleaning', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (10, 1, 'Condiments & Sauces', 'condiments-sauces', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (11, 1, 'Cooking', 'cooking', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (12, 1, 'Deli', 'deli', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (13, 1, 'Groceries', 'groceries', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (14, 1, 'Kitchenware', 'kitchenware', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (15, 1, 'Meats', 'meats', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (16, 1, 'Medical', 'medical', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (17, 1, 'Personal Care', 'personal-care', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (18, 1, 'Pets', 'pets', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (19, 1, 'Snacks', 'snacks', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);
INSERT INTO products.categories (category_id, store_id, name, slug, parent_id, created_on, created_by, updated_on, updated_by) VALUES (20, 1, 'Spices & Seasoning', 'spices-seasoning', NULL, '2024-09-21 23:46:13.878132+03', NULL, NULL, NULL);


--
-- TOC entry 5084 (class 0 OID 20335)
-- Dependencies: 249
-- Data for Name: products; Type: TABLE DATA; Schema: products; Owner: postgres
--

INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (1, 1, 'Item 1', 'Description for Item 1', 'ITM1', 'item-1', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (2, 1, 'Item 2', 'Description for Item 2', 'ITM2', 'item-2', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (3, 1, 'Item 3', 'Description for Item 3', 'ITM3', 'item-3', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (4, 1, 'Item 4', 'Description for Item 4', 'ITM4', 'item-4', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (5, 1, 'Item 5', 'Description for Item 5', 'ITM5', 'item-5', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (6, 1, 'Item 6', 'Description for Item 6', 'ITM6', 'item-6', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (7, 1, 'Item 7', 'Description for Item 7', 'ITM7', 'item-7', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (8, 1, 'Item 8', 'Description for Item 8', 'ITM8', 'item-8', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (9, 1, 'Item 9', 'Description for Item 9', 'ITM9', 'item-9', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (10, 1, 'Item 10', 'Description for Item 10', 'ITM10', 'item-10', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (11, 1, 'Item 11', 'Description for Item 11', 'ITM11', 'item-11', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (12, 1, 'Item 12', 'Description for Item 12', 'ITM12', 'item-12', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (13, 1, 'Item 13', 'Description for Item 13', 'ITM13', 'item-13', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (14, 1, 'Item 14', 'Description for Item 14', 'ITM14', 'item-14', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (15, 1, 'Item 15', 'Description for Item 15', 'ITM15', 'item-15', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (16, 1, 'Item 16', 'Description for Item 16', 'ITM16', 'item-16', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (17, 1, 'Item 17', 'Description for Item 17', 'ITM17', 'item-17', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (18, 1, 'Item 18', 'Description for Item 18', 'ITM18', 'item-18', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (19, 1, 'Item 19', 'Description for Item 19', 'ITM19', 'item-19', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (20, 1, 'Item 20', 'Description for Item 20', 'ITM20', 'item-20', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (21, 1, 'Item 21', 'Description for Item 21', 'ITM21', 'item-21', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (22, 1, 'Item 22', 'Description for Item 22', 'ITM22', 'item-22', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (23, 1, 'Item 23', 'Description for Item 23', 'ITM23', 'item-23', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (24, 1, 'Item 24', 'Description for Item 24', 'ITM24', 'item-24', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (25, 1, 'Item 25', 'Description for Item 25', 'ITM25', 'item-25', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (26, 1, 'Item 26', 'Description for Item 26', 'ITM26', 'item-26', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (27, 1, 'Item 27', 'Description for Item 27', 'ITM27', 'item-27', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (28, 1, 'Item 28', 'Description for Item 28', 'ITM28', 'item-28', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (29, 1, 'Item 29', 'Description for Item 29', 'ITM29', 'item-29', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (30, 1, 'Item 30', 'Description for Item 30', 'ITM30', 'item-30', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (31, 1, 'Item 31', 'Description for Item 31', 'ITM31', 'item-31', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (32, 1, 'Item 32', 'Description for Item 32', 'ITM32', 'item-32', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (33, 1, 'Item 33', 'Description for Item 33', 'ITM33', 'item-33', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (34, 1, 'Item 34', 'Description for Item 34', 'ITM34', 'item-34', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (35, 1, 'Item 35', 'Description for Item 35', 'ITM35', 'item-35', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (36, 1, 'Item 36', 'Description for Item 36', 'ITM36', 'item-36', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (37, 1, 'Item 37', 'Description for Item 37', 'ITM37', 'item-37', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (38, 1, 'Item 38', 'Description for Item 38', 'ITM38', 'item-38', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (39, 1, 'Item 39', 'Description for Item 39', 'ITM39', 'item-39', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (40, 1, 'Item 40', 'Description for Item 40', 'ITM40', 'item-40', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (41, 1, 'Item 41', 'Description for Item 41', 'ITM41', 'item-41', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (42, 1, 'Item 42', 'Description for Item 42', 'ITM42', 'item-42', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (43, 1, 'Item 43', 'Description for Item 43', 'ITM43', 'item-43', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (44, 1, 'Item 44', 'Description for Item 44', 'ITM44', 'item-44', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (45, 1, 'Item 45', 'Description for Item 45', 'ITM45', 'item-45', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (46, 1, 'Item 46', 'Description for Item 46', 'ITM46', 'item-46', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (47, 1, 'Item 47', 'Description for Item 47', 'ITM47', 'item-47', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (48, 1, 'Item 48', 'Description for Item 48', 'ITM48', 'item-48', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (49, 1, 'Item 49', 'Description for Item 49', 'ITM49', 'item-49', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (50, 1, 'Item 50', 'Description for Item 50', 'ITM50', 'item-50', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (51, 1, 'Item 51', 'Description for Item 51', 'ITM51', 'item-51', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (52, 1, 'Item 52', 'Description for Item 52', 'ITM52', 'item-52', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (53, 1, 'Item 53', 'Description for Item 53', 'ITM53', 'item-53', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (54, 1, 'Item 54', 'Description for Item 54', 'ITM54', 'item-54', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (55, 1, 'Item 55', 'Description for Item 55', 'ITM55', 'item-55', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (56, 1, 'Item 56', 'Description for Item 56', 'ITM56', 'item-56', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (57, 1, 'Item 57', 'Description for Item 57', 'ITM57', 'item-57', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (58, 1, 'Item 58', 'Description for Item 58', 'ITM58', 'item-58', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (59, 1, 'Item 59', 'Description for Item 59', 'ITM59', 'item-59', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (60, 1, 'Item 60', 'Description for Item 60', 'ITM60', 'item-60', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (61, 1, 'Item 61', 'Description for Item 61', 'ITM61', 'item-61', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (62, 1, 'Item 62', 'Description for Item 62', 'ITM62', 'item-62', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (63, 1, 'Item 63', 'Description for Item 63', 'ITM63', 'item-63', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (64, 1, 'Item 64', 'Description for Item 64', 'ITM64', 'item-64', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (65, 1, 'Item 65', 'Description for Item 65', 'ITM65', 'item-65', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (66, 1, 'Item 66', 'Description for Item 66', 'ITM66', 'item-66', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (67, 1, 'Item 67', 'Description for Item 67', 'ITM67', 'item-67', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (68, 1, 'Item 68', 'Description for Item 68', 'ITM68', 'item-68', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (69, 1, 'Item 69', 'Description for Item 69', 'ITM69', 'item-69', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (70, 1, 'Item 70', 'Description for Item 70', 'ITM70', 'item-70', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (71, 1, 'Item 71', 'Description for Item 71', 'ITM71', 'item-71', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (72, 1, 'Item 72', 'Description for Item 72', 'ITM72', 'item-72', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (73, 1, 'Item 73', 'Description for Item 73', 'ITM73', 'item-73', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (74, 1, 'Item 74', 'Description for Item 74', 'ITM74', 'item-74', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (75, 1, 'Item 75', 'Description for Item 75', 'ITM75', 'item-75', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (76, 1, 'Item 76', 'Description for Item 76', 'ITM76', 'item-76', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (77, 1, 'Item 77', 'Description for Item 77', 'ITM77', 'item-77', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (78, 1, 'Item 78', 'Description for Item 78', 'ITM78', 'item-78', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (79, 1, 'Item 79', 'Description for Item 79', 'ITM79', 'item-79', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (80, 1, 'Item 80', 'Description for Item 80', 'ITM80', 'item-80', true, '2024-09-22 19:16:15.287858+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (81, 2, 'Item 1', 'Description for Item 1', 'ITM1', 'item-12', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (82, 2, 'Item 2', 'Description for Item 2', 'ITM2', 'item-22', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (83, 2, 'Item 3', 'Description for Item 3', 'ITM3', 'item-32', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (84, 2, 'Item 4', 'Description for Item 4', 'ITM4', 'item-42', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (85, 2, 'Item 5', 'Description for Item 5', 'ITM5', 'item-52', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (86, 2, 'Item 6', 'Description for Item 6', 'ITM6', 'item-62', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (87, 2, 'Item 7', 'Description for Item 7', 'ITM7', 'item-72', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (88, 2, 'Item 8', 'Description for Item 8', 'ITM8', 'item-82', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (89, 2, 'Item 9', 'Description for Item 9', 'ITM9', 'item-92', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (90, 2, 'Item 10', 'Description for Item 10', 'ITM10', 'item-102', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (91, 2, 'Item 11', 'Description for Item 11', 'ITM11', 'item-112', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (92, 2, 'Item 12', 'Description for Item 12', 'ITM12', 'item-122', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (93, 2, 'Item 13', 'Description for Item 13', 'ITM13', 'item-132', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (94, 2, 'Item 14', 'Description for Item 14', 'ITM14', 'item-142', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (95, 2, 'Item 15', 'Description for Item 15', 'ITM15', 'item-152', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (96, 2, 'Item 16', 'Description for Item 16', 'ITM16', 'item-162', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (97, 2, 'Item 17', 'Description for Item 17', 'ITM17', 'item-172', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (98, 2, 'Item 18', 'Description for Item 18', 'ITM18', 'item-182', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (99, 2, 'Item 19', 'Description for Item 19', 'ITM19', 'item-192', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (100, 2, 'Item 20', 'Description for Item 20', 'ITM20', 'item-202', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (101, 2, 'Item 21', 'Description for Item 21', 'ITM21', 'item-212', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (102, 2, 'Item 22', 'Description for Item 22', 'ITM22', 'item-222', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (103, 2, 'Item 23', 'Description for Item 23', 'ITM23', 'item-232', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (104, 2, 'Item 24', 'Description for Item 24', 'ITM24', 'item-242', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (105, 2, 'Item 25', 'Description for Item 25', 'ITM25', 'item-252', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (106, 2, 'Item 26', 'Description for Item 26', 'ITM26', 'item-262', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (107, 2, 'Item 27', 'Description for Item 27', 'ITM27', 'item-272', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (108, 2, 'Item 28', 'Description for Item 28', 'ITM28', 'item-282', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (109, 2, 'Item 29', 'Description for Item 29', 'ITM29', 'item-292', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (110, 2, 'Item 30', 'Description for Item 30', 'ITM30', 'item-302', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (111, 2, 'Item 31', 'Description for Item 31', 'ITM31', 'item-312', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (112, 2, 'Item 32', 'Description for Item 32', 'ITM32', 'item-322', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (113, 2, 'Item 33', 'Description for Item 33', 'ITM33', 'item-332', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (114, 2, 'Item 34', 'Description for Item 34', 'ITM34', 'item-342', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (115, 2, 'Item 35', 'Description for Item 35', 'ITM35', 'item-352', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (116, 2, 'Item 36', 'Description for Item 36', 'ITM36', 'item-362', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (117, 2, 'Item 37', 'Description for Item 37', 'ITM37', 'item-372', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (118, 2, 'Item 38', 'Description for Item 38', 'ITM38', 'item-382', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (119, 2, 'Item 39', 'Description for Item 39', 'ITM39', 'item-392', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (120, 2, 'Item 40', 'Description for Item 40', 'ITM40', 'item-402', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (121, 2, 'Item 41', 'Description for Item 41', 'ITM41', 'item-412', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (122, 2, 'Item 42', 'Description for Item 42', 'ITM42', 'item-422', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (123, 2, 'Item 43', 'Description for Item 43', 'ITM43', 'item-432', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (124, 2, 'Item 44', 'Description for Item 44', 'ITM44', 'item-442', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (125, 2, 'Item 45', 'Description for Item 45', 'ITM45', 'item-452', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (126, 2, 'Item 46', 'Description for Item 46', 'ITM46', 'item-462', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (127, 2, 'Item 47', 'Description for Item 47', 'ITM47', 'item-472', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (128, 2, 'Item 48', 'Description for Item 48', 'ITM48', 'item-482', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (129, 2, 'Item 49', 'Description for Item 49', 'ITM49', 'item-492', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (130, 2, 'Item 50', 'Description for Item 50', 'ITM50', 'item-502', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (131, 2, 'Item 51', 'Description for Item 51', 'ITM51', 'item-512', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (132, 2, 'Item 52', 'Description for Item 52', 'ITM52', 'item-522', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (133, 2, 'Item 53', 'Description for Item 53', 'ITM53', 'item-532', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (134, 2, 'Item 54', 'Description for Item 54', 'ITM54', 'item-542', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (135, 2, 'Item 55', 'Description for Item 55', 'ITM55', 'item-552', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (136, 2, 'Item 56', 'Description for Item 56', 'ITM56', 'item-562', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (137, 2, 'Item 57', 'Description for Item 57', 'ITM57', 'item-572', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (138, 2, 'Item 58', 'Description for Item 58', 'ITM58', 'item-582', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (139, 2, 'Item 59', 'Description for Item 59', 'ITM59', 'item-592', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (140, 2, 'Item 60', 'Description for Item 60', 'ITM60', 'item-602', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (141, 2, 'Item 61', 'Description for Item 61', 'ITM61', 'item-612', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (142, 2, 'Item 62', 'Description for Item 62', 'ITM62', 'item-622', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (143, 2, 'Item 63', 'Description for Item 63', 'ITM63', 'item-632', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (144, 2, 'Item 64', 'Description for Item 64', 'ITM64', 'item-642', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (145, 2, 'Item 65', 'Description for Item 65', 'ITM65', 'item-652', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (146, 2, 'Item 66', 'Description for Item 66', 'ITM66', 'item-662', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (147, 2, 'Item 67', 'Description for Item 67', 'ITM67', 'item-672', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (148, 2, 'Item 68', 'Description for Item 68', 'ITM68', 'item-682', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (149, 2, 'Item 69', 'Description for Item 69', 'ITM69', 'item-692', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (150, 2, 'Item 70', 'Description for Item 70', 'ITM70', 'item-702', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (151, 2, 'Item 71', 'Description for Item 71', 'ITM71', 'item-712', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (152, 2, 'Item 72', 'Description for Item 72', 'ITM72', 'item-722', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (153, 2, 'Item 73', 'Description for Item 73', 'ITM73', 'item-732', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (154, 2, 'Item 74', 'Description for Item 74', 'ITM74', 'item-742', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (155, 2, 'Item 75', 'Description for Item 75', 'ITM75', 'item-752', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (156, 2, 'Item 76', 'Description for Item 76', 'ITM76', 'item-762', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (157, 2, 'Item 77', 'Description for Item 77', 'ITM77', 'item-772', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (158, 2, 'Item 78', 'Description for Item 78', 'ITM78', 'item-782', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (159, 2, 'Item 79', 'Description for Item 79', 'ITM79', 'item-792', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (160, 2, 'Item 80', 'Description for Item 80', 'ITM80', 'item-802', true, '2024-09-22 19:20:01.399472+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (161, 3, 'Item 1', 'Description for Item 1', 'ITM1', 'item-13', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (162, 3, 'Item 2', 'Description for Item 2', 'ITM2', 'item-23', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (163, 3, 'Item 3', 'Description for Item 3', 'ITM3', 'item-33', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (164, 3, 'Item 4', 'Description for Item 4', 'ITM4', 'item-43', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (165, 3, 'Item 5', 'Description for Item 5', 'ITM5', 'item-53', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (166, 3, 'Item 6', 'Description for Item 6', 'ITM6', 'item-63', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (167, 3, 'Item 7', 'Description for Item 7', 'ITM7', 'item-73', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (168, 3, 'Item 8', 'Description for Item 8', 'ITM8', 'item-83', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (169, 3, 'Item 9', 'Description for Item 9', 'ITM9', 'item-93', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (170, 3, 'Item 10', 'Description for Item 10', 'ITM10', 'item-103', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (171, 3, 'Item 11', 'Description for Item 11', 'ITM11', 'item-113', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (172, 3, 'Item 12', 'Description for Item 12', 'ITM12', 'item-123', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (173, 3, 'Item 13', 'Description for Item 13', 'ITM13', 'item-133', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (174, 3, 'Item 14', 'Description for Item 14', 'ITM14', 'item-143', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (175, 3, 'Item 15', 'Description for Item 15', 'ITM15', 'item-153', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (176, 3, 'Item 16', 'Description for Item 16', 'ITM16', 'item-163', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (177, 3, 'Item 17', 'Description for Item 17', 'ITM17', 'item-173', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (178, 3, 'Item 18', 'Description for Item 18', 'ITM18', 'item-183', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (179, 3, 'Item 19', 'Description for Item 19', 'ITM19', 'item-193', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (180, 3, 'Item 20', 'Description for Item 20', 'ITM20', 'item-203', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (181, 3, 'Item 21', 'Description for Item 21', 'ITM21', 'item-213', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (182, 3, 'Item 22', 'Description for Item 22', 'ITM22', 'item-223', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (183, 3, 'Item 23', 'Description for Item 23', 'ITM23', 'item-233', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (184, 3, 'Item 24', 'Description for Item 24', 'ITM24', 'item-243', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (185, 3, 'Item 25', 'Description for Item 25', 'ITM25', 'item-253', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (186, 3, 'Item 26', 'Description for Item 26', 'ITM26', 'item-263', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (187, 3, 'Item 27', 'Description for Item 27', 'ITM27', 'item-273', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (188, 3, 'Item 28', 'Description for Item 28', 'ITM28', 'item-283', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (189, 3, 'Item 29', 'Description for Item 29', 'ITM29', 'item-293', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (190, 3, 'Item 30', 'Description for Item 30', 'ITM30', 'item-303', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (191, 3, 'Item 31', 'Description for Item 31', 'ITM31', 'item-313', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (192, 3, 'Item 32', 'Description for Item 32', 'ITM32', 'item-323', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (193, 3, 'Item 33', 'Description for Item 33', 'ITM33', 'item-333', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (194, 3, 'Item 34', 'Description for Item 34', 'ITM34', 'item-343', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (195, 3, 'Item 35', 'Description for Item 35', 'ITM35', 'item-353', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (196, 3, 'Item 36', 'Description for Item 36', 'ITM36', 'item-363', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (197, 3, 'Item 37', 'Description for Item 37', 'ITM37', 'item-373', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (198, 3, 'Item 38', 'Description for Item 38', 'ITM38', 'item-383', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (199, 3, 'Item 39', 'Description for Item 39', 'ITM39', 'item-393', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (200, 3, 'Item 40', 'Description for Item 40', 'ITM40', 'item-403', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (201, 3, 'Item 41', 'Description for Item 41', 'ITM41', 'item-413', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (202, 3, 'Item 42', 'Description for Item 42', 'ITM42', 'item-423', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (203, 3, 'Item 43', 'Description for Item 43', 'ITM43', 'item-433', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (204, 3, 'Item 44', 'Description for Item 44', 'ITM44', 'item-443', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (205, 3, 'Item 45', 'Description for Item 45', 'ITM45', 'item-453', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (206, 3, 'Item 46', 'Description for Item 46', 'ITM46', 'item-463', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (207, 3, 'Item 47', 'Description for Item 47', 'ITM47', 'item-473', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (208, 3, 'Item 48', 'Description for Item 48', 'ITM48', 'item-483', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (209, 3, 'Item 49', 'Description for Item 49', 'ITM49', 'item-493', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (210, 3, 'Item 50', 'Description for Item 50', 'ITM50', 'item-503', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (211, 3, 'Item 51', 'Description for Item 51', 'ITM51', 'item-513', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (212, 3, 'Item 52', 'Description for Item 52', 'ITM52', 'item-523', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (213, 3, 'Item 53', 'Description for Item 53', 'ITM53', 'item-533', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (214, 3, 'Item 54', 'Description for Item 54', 'ITM54', 'item-543', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (215, 3, 'Item 55', 'Description for Item 55', 'ITM55', 'item-553', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (216, 3, 'Item 56', 'Description for Item 56', 'ITM56', 'item-563', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (217, 3, 'Item 57', 'Description for Item 57', 'ITM57', 'item-573', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (218, 3, 'Item 58', 'Description for Item 58', 'ITM58', 'item-583', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (219, 3, 'Item 59', 'Description for Item 59', 'ITM59', 'item-593', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (220, 3, 'Item 60', 'Description for Item 60', 'ITM60', 'item-603', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (221, 3, 'Item 61', 'Description for Item 61', 'ITM61', 'item-613', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (222, 3, 'Item 62', 'Description for Item 62', 'ITM62', 'item-623', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (223, 3, 'Item 63', 'Description for Item 63', 'ITM63', 'item-633', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (224, 3, 'Item 64', 'Description for Item 64', 'ITM64', 'item-643', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (225, 3, 'Item 65', 'Description for Item 65', 'ITM65', 'item-653', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (226, 3, 'Item 66', 'Description for Item 66', 'ITM66', 'item-663', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (227, 3, 'Item 67', 'Description for Item 67', 'ITM67', 'item-673', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (228, 3, 'Item 68', 'Description for Item 68', 'ITM68', 'item-683', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (229, 3, 'Item 69', 'Description for Item 69', 'ITM69', 'item-693', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (230, 3, 'Item 70', 'Description for Item 70', 'ITM70', 'item-703', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (231, 3, 'Item 71', 'Description for Item 71', 'ITM71', 'item-713', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (232, 3, 'Item 72', 'Description for Item 72', 'ITM72', 'item-723', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (233, 3, 'Item 73', 'Description for Item 73', 'ITM73', 'item-733', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (234, 3, 'Item 74', 'Description for Item 74', 'ITM74', 'item-743', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (235, 3, 'Item 75', 'Description for Item 75', 'ITM75', 'item-753', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (236, 3, 'Item 76', 'Description for Item 76', 'ITM76', 'item-763', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (237, 3, 'Item 77', 'Description for Item 77', 'ITM77', 'item-773', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (238, 3, 'Item 78', 'Description for Item 78', 'ITM78', 'item-783', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (239, 3, 'Item 79', 'Description for Item 79', 'ITM79', 'item-793', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (240, 3, 'Item 80', 'Description for Item 80', 'ITM80', 'item-803', true, '2024-09-22 19:20:14.690263+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (241, 4, 'Item 1', 'Description for Item 1', 'ITM1', 'item-14', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (242, 4, 'Item 2', 'Description for Item 2', 'ITM2', 'item-24', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (243, 4, 'Item 3', 'Description for Item 3', 'ITM3', 'item-34', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (244, 4, 'Item 4', 'Description for Item 4', 'ITM4', 'item-44', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (245, 4, 'Item 5', 'Description for Item 5', 'ITM5', 'item-54', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (246, 4, 'Item 6', 'Description for Item 6', 'ITM6', 'item-64', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (247, 4, 'Item 7', 'Description for Item 7', 'ITM7', 'item-74', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (248, 4, 'Item 8', 'Description for Item 8', 'ITM8', 'item-84', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (249, 4, 'Item 9', 'Description for Item 9', 'ITM9', 'item-94', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (250, 4, 'Item 10', 'Description for Item 10', 'ITM10', 'item-104', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (251, 4, 'Item 11', 'Description for Item 11', 'ITM11', 'item-114', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (252, 4, 'Item 12', 'Description for Item 12', 'ITM12', 'item-124', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (253, 4, 'Item 13', 'Description for Item 13', 'ITM13', 'item-134', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (254, 4, 'Item 14', 'Description for Item 14', 'ITM14', 'item-144', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (255, 4, 'Item 15', 'Description for Item 15', 'ITM15', 'item-154', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (256, 4, 'Item 16', 'Description for Item 16', 'ITM16', 'item-164', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (257, 4, 'Item 17', 'Description for Item 17', 'ITM17', 'item-174', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (258, 4, 'Item 18', 'Description for Item 18', 'ITM18', 'item-184', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (259, 4, 'Item 19', 'Description for Item 19', 'ITM19', 'item-194', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (260, 4, 'Item 20', 'Description for Item 20', 'ITM20', 'item-204', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (261, 4, 'Item 21', 'Description for Item 21', 'ITM21', 'item-214', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (262, 4, 'Item 22', 'Description for Item 22', 'ITM22', 'item-224', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (263, 4, 'Item 23', 'Description for Item 23', 'ITM23', 'item-234', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (264, 4, 'Item 24', 'Description for Item 24', 'ITM24', 'item-244', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (265, 4, 'Item 25', 'Description for Item 25', 'ITM25', 'item-254', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (266, 4, 'Item 26', 'Description for Item 26', 'ITM26', 'item-264', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (267, 4, 'Item 27', 'Description for Item 27', 'ITM27', 'item-274', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (268, 4, 'Item 28', 'Description for Item 28', 'ITM28', 'item-284', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (269, 4, 'Item 29', 'Description for Item 29', 'ITM29', 'item-294', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (270, 4, 'Item 30', 'Description for Item 30', 'ITM30', 'item-304', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (271, 4, 'Item 31', 'Description for Item 31', 'ITM31', 'item-314', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (272, 4, 'Item 32', 'Description for Item 32', 'ITM32', 'item-324', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (273, 4, 'Item 33', 'Description for Item 33', 'ITM33', 'item-334', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (274, 4, 'Item 34', 'Description for Item 34', 'ITM34', 'item-344', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (275, 4, 'Item 35', 'Description for Item 35', 'ITM35', 'item-354', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (276, 4, 'Item 36', 'Description for Item 36', 'ITM36', 'item-364', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (277, 4, 'Item 37', 'Description for Item 37', 'ITM37', 'item-374', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (278, 4, 'Item 38', 'Description for Item 38', 'ITM38', 'item-384', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (279, 4, 'Item 39', 'Description for Item 39', 'ITM39', 'item-394', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (280, 4, 'Item 40', 'Description for Item 40', 'ITM40', 'item-404', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (281, 4, 'Item 41', 'Description for Item 41', 'ITM41', 'item-414', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (282, 4, 'Item 42', 'Description for Item 42', 'ITM42', 'item-424', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (283, 4, 'Item 43', 'Description for Item 43', 'ITM43', 'item-434', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (284, 4, 'Item 44', 'Description for Item 44', 'ITM44', 'item-444', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (285, 4, 'Item 45', 'Description for Item 45', 'ITM45', 'item-454', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (286, 4, 'Item 46', 'Description for Item 46', 'ITM46', 'item-464', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (287, 4, 'Item 47', 'Description for Item 47', 'ITM47', 'item-474', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (288, 4, 'Item 48', 'Description for Item 48', 'ITM48', 'item-484', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (289, 4, 'Item 49', 'Description for Item 49', 'ITM49', 'item-494', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (290, 4, 'Item 50', 'Description for Item 50', 'ITM50', 'item-504', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (291, 4, 'Item 51', 'Description for Item 51', 'ITM51', 'item-514', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (292, 4, 'Item 52', 'Description for Item 52', 'ITM52', 'item-524', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (293, 4, 'Item 53', 'Description for Item 53', 'ITM53', 'item-534', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (294, 4, 'Item 54', 'Description for Item 54', 'ITM54', 'item-544', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (295, 4, 'Item 55', 'Description for Item 55', 'ITM55', 'item-554', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (296, 4, 'Item 56', 'Description for Item 56', 'ITM56', 'item-564', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (297, 4, 'Item 57', 'Description for Item 57', 'ITM57', 'item-574', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (298, 4, 'Item 58', 'Description for Item 58', 'ITM58', 'item-584', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (299, 4, 'Item 59', 'Description for Item 59', 'ITM59', 'item-594', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (300, 4, 'Item 60', 'Description for Item 60', 'ITM60', 'item-604', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (301, 4, 'Item 61', 'Description for Item 61', 'ITM61', 'item-614', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (302, 4, 'Item 62', 'Description for Item 62', 'ITM62', 'item-624', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (303, 4, 'Item 63', 'Description for Item 63', 'ITM63', 'item-634', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (304, 4, 'Item 64', 'Description for Item 64', 'ITM64', 'item-644', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (305, 4, 'Item 65', 'Description for Item 65', 'ITM65', 'item-654', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (306, 4, 'Item 66', 'Description for Item 66', 'ITM66', 'item-664', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (307, 4, 'Item 67', 'Description for Item 67', 'ITM67', 'item-674', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (308, 4, 'Item 68', 'Description for Item 68', 'ITM68', 'item-684', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (309, 4, 'Item 69', 'Description for Item 69', 'ITM69', 'item-694', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (310, 4, 'Item 70', 'Description for Item 70', 'ITM70', 'item-704', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (311, 4, 'Item 71', 'Description for Item 71', 'ITM71', 'item-714', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (312, 4, 'Item 72', 'Description for Item 72', 'ITM72', 'item-724', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (313, 4, 'Item 73', 'Description for Item 73', 'ITM73', 'item-734', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (314, 4, 'Item 74', 'Description for Item 74', 'ITM74', 'item-744', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (315, 4, 'Item 75', 'Description for Item 75', 'ITM75', 'item-754', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (316, 4, 'Item 76', 'Description for Item 76', 'ITM76', 'item-764', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (317, 4, 'Item 77', 'Description for Item 77', 'ITM77', 'item-774', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (318, 4, 'Item 78', 'Description for Item 78', 'ITM78', 'item-784', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (319, 4, 'Item 79', 'Description for Item 79', 'ITM79', 'item-794', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (320, 4, 'Item 80', 'Description for Item 80', 'ITM80', 'item-804', true, '2024-09-22 19:20:24.736455+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (321, 5, 'Item 1', 'Description for Item 1', 'ITM1', 'item-15', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (322, 5, 'Item 2', 'Description for Item 2', 'ITM2', 'item-25', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (323, 5, 'Item 3', 'Description for Item 3', 'ITM3', 'item-35', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (324, 5, 'Item 4', 'Description for Item 4', 'ITM4', 'item-45', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (325, 5, 'Item 5', 'Description for Item 5', 'ITM5', 'item-55', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (326, 5, 'Item 6', 'Description for Item 6', 'ITM6', 'item-65', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (327, 5, 'Item 7', 'Description for Item 7', 'ITM7', 'item-75', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (328, 5, 'Item 8', 'Description for Item 8', 'ITM8', 'item-85', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (329, 5, 'Item 9', 'Description for Item 9', 'ITM9', 'item-95', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (330, 5, 'Item 10', 'Description for Item 10', 'ITM10', 'item-105', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (331, 5, 'Item 11', 'Description for Item 11', 'ITM11', 'item-115', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (332, 5, 'Item 12', 'Description for Item 12', 'ITM12', 'item-125', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (333, 5, 'Item 13', 'Description for Item 13', 'ITM13', 'item-135', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (334, 5, 'Item 14', 'Description for Item 14', 'ITM14', 'item-145', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (335, 5, 'Item 15', 'Description for Item 15', 'ITM15', 'item-155', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (336, 5, 'Item 16', 'Description for Item 16', 'ITM16', 'item-165', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (337, 5, 'Item 17', 'Description for Item 17', 'ITM17', 'item-175', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (338, 5, 'Item 18', 'Description for Item 18', 'ITM18', 'item-185', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (339, 5, 'Item 19', 'Description for Item 19', 'ITM19', 'item-195', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (340, 5, 'Item 20', 'Description for Item 20', 'ITM20', 'item-205', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (341, 5, 'Item 21', 'Description for Item 21', 'ITM21', 'item-215', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (342, 5, 'Item 22', 'Description for Item 22', 'ITM22', 'item-225', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (343, 5, 'Item 23', 'Description for Item 23', 'ITM23', 'item-235', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (344, 5, 'Item 24', 'Description for Item 24', 'ITM24', 'item-245', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (345, 5, 'Item 25', 'Description for Item 25', 'ITM25', 'item-255', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (346, 5, 'Item 26', 'Description for Item 26', 'ITM26', 'item-265', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (347, 5, 'Item 27', 'Description for Item 27', 'ITM27', 'item-275', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (348, 5, 'Item 28', 'Description for Item 28', 'ITM28', 'item-285', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (349, 5, 'Item 29', 'Description for Item 29', 'ITM29', 'item-295', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (350, 5, 'Item 30', 'Description for Item 30', 'ITM30', 'item-305', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (351, 5, 'Item 31', 'Description for Item 31', 'ITM31', 'item-315', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (352, 5, 'Item 32', 'Description for Item 32', 'ITM32', 'item-325', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (353, 5, 'Item 33', 'Description for Item 33', 'ITM33', 'item-335', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (354, 5, 'Item 34', 'Description for Item 34', 'ITM34', 'item-345', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (355, 5, 'Item 35', 'Description for Item 35', 'ITM35', 'item-355', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (356, 5, 'Item 36', 'Description for Item 36', 'ITM36', 'item-365', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (357, 5, 'Item 37', 'Description for Item 37', 'ITM37', 'item-375', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (358, 5, 'Item 38', 'Description for Item 38', 'ITM38', 'item-385', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (359, 5, 'Item 39', 'Description for Item 39', 'ITM39', 'item-395', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (360, 5, 'Item 40', 'Description for Item 40', 'ITM40', 'item-405', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (361, 5, 'Item 41', 'Description for Item 41', 'ITM41', 'item-415', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (362, 5, 'Item 42', 'Description for Item 42', 'ITM42', 'item-425', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (363, 5, 'Item 43', 'Description for Item 43', 'ITM43', 'item-435', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (364, 5, 'Item 44', 'Description for Item 44', 'ITM44', 'item-445', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (365, 5, 'Item 45', 'Description for Item 45', 'ITM45', 'item-455', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (366, 5, 'Item 46', 'Description for Item 46', 'ITM46', 'item-465', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (367, 5, 'Item 47', 'Description for Item 47', 'ITM47', 'item-475', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (368, 5, 'Item 48', 'Description for Item 48', 'ITM48', 'item-485', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (369, 5, 'Item 49', 'Description for Item 49', 'ITM49', 'item-495', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (370, 5, 'Item 50', 'Description for Item 50', 'ITM50', 'item-505', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (371, 5, 'Item 51', 'Description for Item 51', 'ITM51', 'item-515', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (372, 5, 'Item 52', 'Description for Item 52', 'ITM52', 'item-525', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (373, 5, 'Item 53', 'Description for Item 53', 'ITM53', 'item-535', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (374, 5, 'Item 54', 'Description for Item 54', 'ITM54', 'item-545', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (375, 5, 'Item 55', 'Description for Item 55', 'ITM55', 'item-555', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (376, 5, 'Item 56', 'Description for Item 56', 'ITM56', 'item-565', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (377, 5, 'Item 57', 'Description for Item 57', 'ITM57', 'item-575', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (378, 5, 'Item 58', 'Description for Item 58', 'ITM58', 'item-585', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (379, 5, 'Item 59', 'Description for Item 59', 'ITM59', 'item-595', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (380, 5, 'Item 60', 'Description for Item 60', 'ITM60', 'item-605', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (381, 5, 'Item 61', 'Description for Item 61', 'ITM61', 'item-615', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (382, 5, 'Item 62', 'Description for Item 62', 'ITM62', 'item-625', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (383, 5, 'Item 63', 'Description for Item 63', 'ITM63', 'item-635', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (384, 5, 'Item 64', 'Description for Item 64', 'ITM64', 'item-645', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (385, 5, 'Item 65', 'Description for Item 65', 'ITM65', 'item-655', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (386, 5, 'Item 66', 'Description for Item 66', 'ITM66', 'item-665', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (387, 5, 'Item 67', 'Description for Item 67', 'ITM67', 'item-675', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (388, 5, 'Item 68', 'Description for Item 68', 'ITM68', 'item-685', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (389, 5, 'Item 69', 'Description for Item 69', 'ITM69', 'item-695', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (390, 5, 'Item 70', 'Description for Item 70', 'ITM70', 'item-705', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (391, 5, 'Item 71', 'Description for Item 71', 'ITM71', 'item-715', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (392, 5, 'Item 72', 'Description for Item 72', 'ITM72', 'item-725', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (393, 5, 'Item 73', 'Description for Item 73', 'ITM73', 'item-735', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (394, 5, 'Item 74', 'Description for Item 74', 'ITM74', 'item-745', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (395, 5, 'Item 75', 'Description for Item 75', 'ITM75', 'item-755', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (396, 5, 'Item 76', 'Description for Item 76', 'ITM76', 'item-765', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (397, 5, 'Item 77', 'Description for Item 77', 'ITM77', 'item-775', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (398, 5, 'Item 78', 'Description for Item 78', 'ITM78', 'item-785', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (399, 5, 'Item 79', 'Description for Item 79', 'ITM79', 'item-795', true, '2024-09-22 19:20:33.143182+03', NULL);
INSERT INTO products.products (product_id, branch_id, name, description, sku, slug, status, created_on, updated_on) VALUES (400, 5, 'Item 80', 'Description for Item 80', 'ITM80', 'item-805', true, '2024-09-22 19:20:33.143182+03', NULL);


--
-- TOC entry 5087 (class 0 OID 20371)
-- Dependencies: 252
-- Data for Name: products_categories; Type: TABLE DATA; Schema: products; Owner: postgres
--

INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 1, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 2, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 3, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 4, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 81, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 82, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 83, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 84, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 161, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 162, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 163, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 164, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 241, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 242, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 243, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 244, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 321, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 322, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 323, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 324, 1);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 5, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 6, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 7, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 8, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 85, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 86, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 87, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 88, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 165, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 166, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 167, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 168, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 245, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 246, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 247, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 248, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 325, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 326, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 327, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 328, 2);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 9, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 10, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 11, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 12, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 89, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 90, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 91, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 92, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 169, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 170, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 171, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 172, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 249, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 250, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 251, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 252, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 329, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 330, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 331, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 332, 3);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 13, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 14, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 15, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 16, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 93, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 94, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 95, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 96, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 173, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 174, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 175, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 176, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 253, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 254, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 255, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 256, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 333, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 334, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 335, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 336, 4);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 17, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 18, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 19, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 20, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 97, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 98, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 99, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 100, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 177, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 178, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 179, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 180, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 257, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 258, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 259, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 260, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 337, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 338, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 339, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 340, 5);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 21, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 22, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 23, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 24, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 101, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 102, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 103, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 104, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 181, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 182, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 183, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 184, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 261, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 262, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 263, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 264, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 341, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 342, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 343, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 344, 6);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 25, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 26, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 27, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 28, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 105, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 106, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 107, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 108, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 185, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 186, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 187, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 188, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 265, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 266, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 267, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 268, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 345, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 346, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 347, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 348, 7);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 29, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 30, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 31, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 32, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 109, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 110, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 111, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 112, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 189, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 190, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 191, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 192, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 269, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 270, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 271, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 272, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 349, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 350, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 351, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 352, 8);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 33, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 34, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 35, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 36, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 113, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 114, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 115, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 116, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 193, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 194, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 195, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 196, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 273, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 274, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 275, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 276, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 353, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 354, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 355, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 356, 9);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 37, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 38, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 39, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 40, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 117, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 118, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 119, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 120, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 197, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 198, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 199, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 200, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 277, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 278, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 279, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 280, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 357, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 358, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 359, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 360, 10);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 41, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 42, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 43, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 44, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 121, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 122, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 123, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 124, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 201, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 202, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 203, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 204, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 281, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 282, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 283, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 284, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 361, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 362, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 363, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 364, 11);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 45, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 46, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 47, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 48, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 125, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 126, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 127, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 128, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 205, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 206, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 207, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 208, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 285, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 286, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 287, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 288, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 365, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 366, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 367, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 368, 12);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 49, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 50, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 51, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 52, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 129, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 130, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 131, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 132, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 209, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 210, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 211, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 212, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 289, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 290, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 291, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 292, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 369, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 370, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 371, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 372, 13);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 53, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 54, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 55, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 56, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 133, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 134, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 135, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 136, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 213, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 214, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 215, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 216, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 293, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 294, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 295, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 296, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 373, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 374, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 375, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 376, 14);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 57, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 58, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 59, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 60, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 137, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 138, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 139, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 140, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 217, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 218, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 219, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 220, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 297, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 298, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 299, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 300, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 377, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 378, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 379, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 380, 15);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 61, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 62, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 63, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 64, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 141, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 142, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 143, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 144, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 221, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 222, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 223, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 224, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 301, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 302, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 303, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 304, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 381, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 382, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 383, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 384, 16);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 65, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 66, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 67, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 68, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 145, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 146, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 147, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 148, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 225, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 226, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 227, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 228, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 305, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 306, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 307, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 308, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 385, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 386, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 387, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 388, 17);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 69, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 70, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 71, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 72, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 149, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 150, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 151, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 152, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 229, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 230, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 231, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 232, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 309, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 310, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 311, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 312, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 389, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 390, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 391, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 392, 18);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 73, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 74, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 75, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 76, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 153, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 154, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 155, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 156, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 233, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 234, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 235, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 236, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 313, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 314, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 315, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 316, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 393, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 394, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 395, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 396, 19);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 77, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 78, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 79, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (1, 80, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 157, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 158, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 159, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (2, 160, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 237, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 238, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 239, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (3, 240, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 317, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 318, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 319, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (4, 320, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 397, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 398, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 399, 20);
INSERT INTO products.products_categories (branch_id, product_id, category_id) VALUES (5, 400, 20);


--
-- TOC entry 5089 (class 0 OID 20412)
-- Dependencies: 254
-- Data for Name: products_images; Type: TABLE DATA; Schema: products; Owner: postgres
--

INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (1, 1, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (2, 3, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (3, 5, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (4, 7, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (5, 9, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (6, 11, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (7, 13, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (8, 15, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (9, 17, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (10, 19, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (11, 21, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (12, 23, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (13, 25, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (14, 27, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (15, 29, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (16, 31, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (17, 33, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (18, 35, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (19, 37, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (20, 39, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (21, 41, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (22, 43, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (23, 45, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (24, 47, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (25, 49, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (26, 51, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (27, 53, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (28, 55, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (29, 57, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (30, 59, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (31, 61, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (32, 63, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (33, 65, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (34, 67, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (35, 69, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (36, 71, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (37, 73, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (38, 75, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (39, 77, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (40, 79, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (41, 81, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (42, 83, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (43, 85, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (44, 87, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (45, 89, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (46, 91, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (47, 93, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (48, 95, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (49, 97, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (50, 99, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (51, 101, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (52, 103, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (53, 105, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (54, 107, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (55, 109, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (56, 111, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (57, 113, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (58, 115, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (59, 117, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (60, 119, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (61, 121, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (62, 123, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (63, 125, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (64, 127, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (65, 129, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (66, 131, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (67, 133, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (68, 135, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (69, 137, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (70, 139, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (71, 141, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (72, 143, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (73, 145, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (74, 147, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (75, 149, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (76, 151, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (77, 153, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (78, 155, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (79, 157, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (80, 159, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (81, 161, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (82, 163, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (83, 165, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (84, 167, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (85, 169, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (86, 171, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (87, 173, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (88, 175, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (89, 177, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (90, 179, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (91, 181, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (92, 183, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (93, 185, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (94, 187, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (95, 189, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (96, 191, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (97, 193, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (98, 195, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (99, 197, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (100, 199, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (101, 201, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (102, 203, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (103, 205, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (104, 207, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (105, 209, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (106, 211, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (107, 213, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (108, 215, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (109, 217, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (110, 219, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (111, 221, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (112, 223, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (113, 225, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (114, 227, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (115, 229, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (116, 231, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (117, 233, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (118, 235, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (119, 237, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (120, 239, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (121, 241, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (122, 243, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (123, 245, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (124, 247, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (125, 249, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (126, 251, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (127, 253, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (128, 255, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (129, 257, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (130, 259, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (131, 261, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (132, 263, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (133, 265, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (134, 267, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (135, 269, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (136, 271, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (137, 273, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (138, 275, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (139, 277, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (140, 279, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (141, 281, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (142, 283, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (143, 285, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (144, 287, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (145, 289, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (146, 291, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (147, 293, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (148, 295, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (149, 297, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (150, 299, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (151, 301, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (152, 303, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (153, 305, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (154, 307, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (155, 309, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (156, 311, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (157, 313, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (158, 315, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (159, 317, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (160, 319, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (161, 321, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (162, 323, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (163, 325, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (164, 327, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (165, 329, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (166, 331, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (167, 333, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (168, 335, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (169, 337, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (170, 339, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (171, 341, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (172, 343, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (173, 345, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (174, 347, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (175, 349, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (176, 351, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (177, 353, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (178, 355, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (179, 357, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (180, 359, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (181, 361, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (182, 363, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (183, 365, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (184, 367, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (185, 369, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (186, 371, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (187, 373, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (188, 375, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (189, 377, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (190, 379, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (191, 381, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (192, 383, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (193, 385, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (194, 387, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (195, 389, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (196, 391, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (197, 393, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (198, 395, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (199, 397, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (200, 399, 'default-product-1.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (201, 2, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (202, 4, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (203, 6, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (204, 8, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (205, 10, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (206, 12, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (207, 14, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (208, 16, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (209, 18, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (210, 20, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (211, 22, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (212, 24, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (213, 26, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (214, 28, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (215, 30, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (216, 32, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (217, 34, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (218, 36, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (219, 38, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (220, 40, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (221, 42, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (222, 44, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (223, 46, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (224, 48, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (225, 50, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (226, 52, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (227, 54, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (228, 56, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (229, 58, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (230, 60, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (231, 62, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (232, 64, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (233, 66, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (234, 68, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (235, 70, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (236, 72, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (237, 74, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (238, 76, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (239, 78, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (240, 80, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (241, 82, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (242, 84, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (243, 86, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (244, 88, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (245, 90, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (246, 92, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (247, 94, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (248, 96, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (249, 98, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (250, 100, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (251, 102, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (252, 104, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (253, 106, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (254, 108, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (255, 110, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (256, 112, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (257, 114, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (258, 116, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (259, 118, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (260, 120, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (261, 122, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (262, 124, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (263, 126, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (264, 128, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (265, 130, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (266, 132, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (267, 134, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (268, 136, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (269, 138, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (270, 140, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (271, 142, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (272, 144, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (273, 146, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (274, 148, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (275, 150, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (276, 152, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (277, 154, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (278, 156, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (279, 158, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (280, 160, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (281, 162, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (282, 164, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (283, 166, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (284, 168, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (285, 170, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (286, 172, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (287, 174, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (288, 176, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (289, 178, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (290, 180, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (291, 182, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (292, 184, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (293, 186, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (294, 188, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (295, 190, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (296, 192, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (297, 194, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (298, 196, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (299, 198, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (300, 200, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (301, 202, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (302, 204, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (303, 206, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (304, 208, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (305, 210, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (306, 212, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (307, 214, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (308, 216, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (309, 218, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (310, 220, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (311, 222, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (312, 224, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (313, 226, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (314, 228, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (315, 230, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (316, 232, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (317, 234, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (318, 236, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (319, 238, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (320, 240, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (321, 242, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (322, 244, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (323, 246, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (324, 248, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (325, 250, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (326, 252, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (327, 254, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (328, 256, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (329, 258, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (330, 260, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (331, 262, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (332, 264, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (333, 266, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (334, 268, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (335, 270, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (336, 272, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (337, 274, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (338, 276, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (339, 278, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (340, 280, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (341, 282, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (342, 284, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (343, 286, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (344, 288, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (345, 290, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (346, 292, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (347, 294, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (348, 296, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (349, 298, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (350, 300, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (351, 302, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (352, 304, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (353, 306, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (354, 308, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (355, 310, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (356, 312, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (357, 314, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (358, 316, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (359, 318, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (360, 320, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (361, 322, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (362, 324, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (363, 326, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (364, 328, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (365, 330, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (366, 332, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (367, 334, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (368, 336, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (369, 338, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (370, 340, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (371, 342, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (372, 344, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (373, 346, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (374, 348, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (375, 350, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (376, 352, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (377, 354, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (378, 356, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (379, 358, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (380, 360, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (381, 362, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (382, 364, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (383, 366, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (384, 368, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (385, 370, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (386, 372, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (387, 374, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (388, 376, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (389, 378, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (390, 380, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (391, 382, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (392, 384, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (393, 386, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (394, 388, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (395, 390, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (396, 392, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (397, 394, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (398, 396, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (399, 398, 'default-product-2.png', NULL);
INSERT INTO products.products_images (product_image_id, product_id, img, is_primary) VALUES (400, 400, 'default-product-2.png', NULL);


--
-- TOC entry 5086 (class 0 OID 20356)
-- Dependencies: 251
-- Data for Name: products_pricing; Type: TABLE DATA; Schema: products; Owner: postgres
--

INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (1, 1, 1021, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (2, 2, 313, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (3, 3, 1369, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (4, 4, 225, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (5, 5, 1101, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (6, 6, 1904, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (7, 7, 1151, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (8, 8, 1634, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (9, 9, 1304, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (10, 10, 1395, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (11, 11, 1986, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (12, 12, 702, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (13, 13, 1916, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (14, 14, 957, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (15, 15, 518, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (16, 16, 1120, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (17, 17, 1107, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (18, 18, 314, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (19, 19, 1731, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (20, 20, 873, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (21, 21, 1177, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (22, 22, 1450, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (23, 23, 1818, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (24, 24, 987, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (25, 25, 1140, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (26, 26, 323, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (27, 27, 1758, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (28, 28, 1782, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (29, 29, 1110, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (30, 30, 1217, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (31, 31, 157, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (32, 32, 874, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (33, 33, 1687, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (34, 34, 1281, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (35, 35, 1746, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (36, 36, 328, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (37, 37, 959, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (38, 38, 1128, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (39, 39, 380, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (40, 40, 1889, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (41, 41, 554, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (42, 42, 1858, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (43, 43, 657, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (44, 44, 1879, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (45, 45, 1110, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (46, 46, 474, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (47, 47, 1505, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (48, 48, 1584, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (49, 49, 1789, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (50, 50, 1408, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (51, 51, 1602, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (52, 52, 77, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (53, 53, 1498, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (54, 54, 1175, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (55, 55, 1904, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (56, 56, 1611, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (57, 57, 75, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (58, 58, 1468, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (59, 59, 1000, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (60, 60, 1765, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (61, 61, 1844, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (62, 62, 1740, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (63, 63, 1280, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (64, 64, 1487, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (65, 65, 1538, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (66, 66, 1156, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (67, 67, 1616, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (68, 68, 1256, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (69, 69, 883, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (70, 70, 647, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (71, 71, 943, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (72, 72, 478, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (73, 73, 1280, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (74, 74, 793, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (75, 75, 1637, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (76, 76, 797, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (77, 77, 1197, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (78, 78, 275, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (79, 79, 329, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (80, 80, 1149, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (81, 81, 657, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (82, 82, 618, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (83, 83, 868, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (84, 84, 407, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (85, 85, 1222, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (86, 86, 1980, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (87, 87, 965, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (88, 88, 688, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (89, 89, 554, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (90, 90, 97, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (91, 91, 1016, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (92, 92, 1419, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (93, 93, 51, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (94, 94, 1337, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (95, 95, 241, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (96, 96, 1006, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (97, 97, 450, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (98, 98, 285, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (99, 99, 1439, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (100, 100, 1456, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (101, 101, 1058, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (102, 102, 1179, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (103, 103, 1428, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (104, 104, 338, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (105, 105, 1098, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (106, 106, 709, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (107, 107, 1877, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (108, 108, 1128, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (109, 109, 1018, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (110, 110, 1096, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (111, 111, 950, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (112, 112, 1308, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (113, 113, 1205, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (114, 114, 1361, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (115, 115, 1810, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (116, 116, 1931, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (117, 117, 1359, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (118, 118, 1700, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (119, 119, 1268, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (120, 120, 1701, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (121, 121, 1670, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (122, 122, 1396, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (123, 123, 1773, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (124, 124, 1455, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (125, 125, 574, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (126, 126, 756, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (127, 127, 177, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (128, 128, 278, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (129, 129, 346, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (130, 130, 1920, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (131, 131, 335, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (132, 132, 1954, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (133, 133, 560, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (134, 134, 1552, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (135, 135, 1138, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (136, 136, 1848, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (137, 137, 116, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (138, 138, 761, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (139, 139, 1075, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (140, 140, 153, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (141, 141, 1627, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (142, 142, 776, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (143, 143, 62, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (144, 144, 1056, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (145, 145, 1743, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (146, 146, 1164, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (147, 147, 1326, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (148, 148, 310, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (149, 149, 268, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (150, 150, 1399, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (151, 151, 107, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (152, 152, 1676, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (153, 153, 1691, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (154, 154, 229, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (155, 155, 1989, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (156, 156, 766, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (157, 157, 1638, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (158, 158, 1692, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (159, 159, 1445, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (160, 160, 1787, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (161, 161, 1725, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (162, 162, 1170, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (163, 163, 1417, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (164, 164, 625, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (165, 165, 772, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (166, 166, 1877, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (167, 167, 64, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (168, 168, 882, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (169, 169, 1284, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (170, 170, 1686, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (171, 171, 1506, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (172, 172, 1272, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (173, 173, 1279, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (174, 174, 1071, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (175, 175, 980, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (176, 176, 950, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (177, 177, 1263, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (178, 178, 1260, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (179, 179, 1142, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (180, 180, 1586, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (181, 181, 997, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (182, 182, 475, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (183, 183, 973, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (184, 184, 1104, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (185, 185, 1915, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (186, 186, 985, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (187, 187, 1294, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (188, 188, 674, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (189, 189, 1527, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (190, 190, 184, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (191, 191, 313, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (192, 192, 803, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (193, 193, 1214, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (194, 194, 1370, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (195, 195, 1526, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (196, 196, 1674, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (197, 197, 1744, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (198, 198, 833, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (199, 199, 1172, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (200, 200, 896, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (201, 201, 1858, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (202, 202, 1962, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (203, 203, 1058, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (204, 204, 329, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (205, 205, 1207, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (206, 206, 1086, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (207, 207, 1009, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (208, 208, 241, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (209, 209, 1396, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (210, 210, 1275, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (211, 211, 1573, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (212, 212, 177, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (213, 213, 53, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (214, 214, 1172, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (215, 215, 428, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (216, 216, 606, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (217, 217, 854, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (218, 218, 209, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (219, 219, 281, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (220, 220, 125, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (221, 221, 715, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (222, 222, 833, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (223, 223, 753, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (224, 224, 917, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (225, 225, 1914, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (226, 226, 381, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (227, 227, 1294, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (228, 228, 1912, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (229, 229, 1962, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (230, 230, 1915, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (231, 231, 1111, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (232, 232, 1388, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (233, 233, 1593, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (234, 234, 1158, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (235, 235, 569, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (236, 236, 1895, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (237, 237, 1796, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (238, 238, 970, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (239, 239, 774, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (240, 240, 1242, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (241, 241, 1762, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (242, 242, 598, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (243, 243, 1859, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (244, 244, 1727, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (245, 245, 886, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (246, 246, 438, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (247, 247, 522, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (248, 248, 711, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (249, 249, 617, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (250, 250, 983, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (251, 251, 584, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (252, 252, 916, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (253, 253, 715, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (254, 254, 543, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (255, 255, 596, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (256, 256, 629, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (257, 257, 233, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (258, 258, 836, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (259, 259, 1733, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (260, 260, 960, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (261, 261, 1195, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (262, 262, 1090, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (263, 263, 1111, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (264, 264, 1220, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (265, 265, 158, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (266, 266, 499, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (267, 267, 1023, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (268, 268, 918, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (269, 269, 166, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (270, 270, 1201, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (271, 271, 1560, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (272, 272, 1285, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (273, 273, 98, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (274, 274, 1436, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (275, 275, 337, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (276, 276, 55, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (277, 277, 875, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (278, 278, 244, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (279, 279, 541, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (280, 280, 1830, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (281, 281, 1461, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (282, 282, 1764, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (283, 283, 1443, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (284, 284, 207, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (285, 285, 642, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (286, 286, 1669, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (287, 287, 1980, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (288, 288, 922, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (289, 289, 1421, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (290, 290, 1362, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (291, 291, 1419, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (292, 292, 656, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (293, 293, 329, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (294, 294, 269, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (295, 295, 1102, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (296, 296, 1807, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (297, 297, 1691, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (298, 298, 371, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (299, 299, 183, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (300, 300, 944, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (301, 301, 853, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (302, 302, 1564, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (303, 303, 1599, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (304, 304, 114, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (305, 305, 924, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (306, 306, 577, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (307, 307, 1766, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (308, 308, 1948, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (309, 309, 1681, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (310, 310, 653, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (311, 311, 1082, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (312, 312, 1347, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (313, 313, 832, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (314, 314, 585, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (315, 315, 1153, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (316, 316, 1711, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (317, 317, 1572, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (318, 318, 722, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (319, 319, 427, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (320, 320, 104, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (321, 321, 137, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (322, 322, 1721, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (323, 323, 1185, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (324, 324, 1149, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (325, 325, 1393, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (326, 326, 1957, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (327, 327, 754, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (328, 328, 397, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (329, 329, 1451, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (330, 330, 1035, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (331, 331, 1785, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (332, 332, 1275, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (333, 333, 1595, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (334, 334, 280, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (335, 335, 265, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (336, 336, 1644, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (337, 337, 960, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (338, 338, 307, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (339, 339, 1986, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (340, 340, 468, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (341, 341, 1867, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (342, 342, 1501, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (343, 343, 610, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (344, 344, 59, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (345, 345, 1672, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (346, 346, 1867, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (347, 347, 1975, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (348, 348, 849, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (349, 349, 1735, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (350, 350, 1321, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (351, 351, 753, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (352, 352, 693, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (353, 353, 1352, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (354, 354, 939, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (355, 355, 1138, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (356, 356, 1868, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (357, 357, 1019, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (358, 358, 1073, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (359, 359, 862, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (360, 360, 790, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (361, 361, 249, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (362, 362, 1166, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (363, 363, 1005, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (364, 364, 1820, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (365, 365, 1638, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (366, 366, 1298, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (367, 367, 1171, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (368, 368, 1723, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (369, 369, 1955, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (370, 370, 1800, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (371, 371, 388, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (372, 372, 972, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (373, 373, 1429, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (374, 374, 1395, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (375, 375, 1371, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (376, 376, 1506, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (377, 377, 1696, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (378, 378, 584, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (379, 379, 367, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (380, 380, 322, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (381, 381, 1861, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (382, 382, 947, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (383, 383, 1602, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (384, 384, 462, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (385, 385, 1664, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (386, 386, 341, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (387, 387, 520, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (388, 388, 349, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (389, 389, 1108, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (390, 390, 1142, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (391, 391, 1257, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (392, 392, 1690, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (393, 393, 1376, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (394, 394, 1127, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (395, 395, 1590, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (396, 396, 1311, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (397, 397, 674, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (398, 398, 1451, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (399, 399, 939, 'KES');
INSERT INTO products.products_pricing (product_price_id, product_id, price, currency) VALUES (400, 400, 1058, 'KES');


--
-- TOC entry 5091 (class 0 OID 20426)
-- Dependencies: 256
-- Data for Name: products_stock; Type: TABLE DATA; Schema: products; Owner: postgres
--

INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (1, 1, 1, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (2, 1, 2, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (3, 1, 3, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (4, 1, 4, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (5, 1, 5, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (6, 1, 6, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (7, 1, 7, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (8, 1, 8, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (9, 1, 9, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (10, 1, 10, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (11, 1, 11, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (12, 1, 12, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (13, 1, 13, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (14, 1, 14, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (15, 1, 15, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (16, 1, 16, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (17, 1, 17, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (18, 1, 18, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (19, 1, 19, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (20, 1, 20, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (21, 1, 21, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (22, 1, 22, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (23, 1, 23, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (24, 1, 24, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (25, 1, 25, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (26, 1, 26, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (27, 1, 27, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (28, 1, 28, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (29, 1, 29, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (30, 1, 30, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (31, 1, 31, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (32, 1, 32, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (33, 1, 33, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (34, 1, 34, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (35, 1, 35, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (36, 1, 36, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (37, 1, 37, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (38, 1, 38, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (39, 1, 39, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (40, 1, 40, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (41, 1, 41, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (42, 1, 42, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (43, 1, 43, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (44, 1, 44, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (45, 1, 45, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (46, 1, 46, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (47, 1, 47, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (48, 1, 48, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (49, 1, 49, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (50, 1, 50, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (51, 1, 51, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (52, 1, 52, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (53, 1, 53, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (54, 1, 54, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (55, 1, 55, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (56, 1, 56, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (57, 1, 57, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (58, 1, 58, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (59, 1, 59, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (60, 1, 60, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (61, 1, 61, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (62, 1, 62, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (63, 1, 63, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (64, 1, 64, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (65, 1, 65, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (66, 1, 66, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (67, 1, 67, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (68, 1, 68, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (69, 1, 69, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (70, 1, 70, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (71, 1, 71, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (72, 1, 72, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (73, 1, 73, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (74, 1, 74, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (75, 1, 75, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (76, 1, 76, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (77, 1, 77, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (78, 1, 78, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (79, 1, 79, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (80, 1, 80, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (81, 2, 81, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (82, 2, 82, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (83, 2, 83, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (84, 2, 84, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (85, 2, 85, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (86, 2, 86, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (87, 2, 87, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (88, 2, 88, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (89, 2, 89, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (90, 2, 90, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (91, 2, 91, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (92, 2, 92, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (93, 2, 93, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (94, 2, 94, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (95, 2, 95, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (96, 2, 96, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (97, 2, 97, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (98, 2, 98, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (99, 2, 99, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (100, 2, 100, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (101, 2, 101, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (102, 2, 102, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (103, 2, 103, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (104, 2, 104, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (105, 2, 105, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (106, 2, 106, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (107, 2, 107, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (108, 2, 108, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (109, 2, 109, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (110, 2, 110, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (111, 2, 111, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (112, 2, 112, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (113, 2, 113, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (114, 2, 114, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (115, 2, 115, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (116, 2, 116, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (117, 2, 117, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (118, 2, 118, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (119, 2, 119, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (120, 2, 120, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (121, 2, 121, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (122, 2, 122, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (123, 2, 123, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (124, 2, 124, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (125, 2, 125, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (126, 2, 126, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (127, 2, 127, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (128, 2, 128, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (129, 2, 129, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (130, 2, 130, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (131, 2, 131, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (132, 2, 132, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (133, 2, 133, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (134, 2, 134, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (135, 2, 135, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (136, 2, 136, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (137, 2, 137, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (138, 2, 138, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (139, 2, 139, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (140, 2, 140, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (141, 2, 141, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (142, 2, 142, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (143, 2, 143, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (144, 2, 144, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (145, 2, 145, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (146, 2, 146, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (147, 2, 147, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (148, 2, 148, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (149, 2, 149, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (150, 2, 150, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (151, 2, 151, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (152, 2, 152, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (153, 2, 153, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (154, 2, 154, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (155, 2, 155, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (156, 2, 156, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (157, 2, 157, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (158, 2, 158, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (159, 2, 159, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (160, 2, 160, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (161, 3, 161, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (162, 3, 162, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (163, 3, 163, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (164, 3, 164, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (165, 3, 165, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (166, 3, 166, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (167, 3, 167, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (168, 3, 168, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (169, 3, 169, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (170, 3, 170, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (171, 3, 171, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (172, 3, 172, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (173, 3, 173, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (174, 3, 174, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (175, 3, 175, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (176, 3, 176, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (177, 3, 177, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (178, 3, 178, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (179, 3, 179, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (180, 3, 180, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (181, 3, 181, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (182, 3, 182, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (183, 3, 183, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (184, 3, 184, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (185, 3, 185, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (186, 3, 186, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (187, 3, 187, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (188, 3, 188, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (189, 3, 189, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (190, 3, 190, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (191, 3, 191, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (192, 3, 192, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (193, 3, 193, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (194, 3, 194, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (195, 3, 195, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (196, 3, 196, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (197, 3, 197, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (198, 3, 198, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (199, 3, 199, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (200, 3, 200, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (201, 3, 201, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (202, 3, 202, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (203, 3, 203, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (204, 3, 204, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (205, 3, 205, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (206, 3, 206, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (207, 3, 207, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (208, 3, 208, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (209, 3, 209, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (210, 3, 210, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (211, 3, 211, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (212, 3, 212, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (213, 3, 213, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (214, 3, 214, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (215, 3, 215, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (216, 3, 216, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (217, 3, 217, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (218, 3, 218, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (219, 3, 219, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (220, 3, 220, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (221, 3, 221, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (222, 3, 222, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (223, 3, 223, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (224, 3, 224, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (225, 3, 225, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (226, 3, 226, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (227, 3, 227, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (228, 3, 228, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (229, 3, 229, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (230, 3, 230, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (231, 3, 231, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (232, 3, 232, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (233, 3, 233, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (234, 3, 234, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (235, 3, 235, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (236, 3, 236, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (237, 3, 237, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (238, 3, 238, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (239, 3, 239, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (240, 3, 240, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (241, 4, 241, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (242, 4, 242, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (243, 4, 243, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (244, 4, 244, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (245, 4, 245, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (246, 4, 246, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (247, 4, 247, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (248, 4, 248, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (249, 4, 249, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (250, 4, 250, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (251, 4, 251, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (252, 4, 252, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (253, 4, 253, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (254, 4, 254, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (255, 4, 255, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (256, 4, 256, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (257, 4, 257, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (258, 4, 258, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (259, 4, 259, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (260, 4, 260, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (261, 4, 261, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (262, 4, 262, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (263, 4, 263, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (264, 4, 264, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (265, 4, 265, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (266, 4, 266, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (267, 4, 267, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (268, 4, 268, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (269, 4, 269, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (270, 4, 270, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (271, 4, 271, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (272, 4, 272, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (273, 4, 273, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (274, 4, 274, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (275, 4, 275, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (276, 4, 276, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (277, 4, 277, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (278, 4, 278, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (279, 4, 279, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (280, 4, 280, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (281, 4, 281, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (282, 4, 282, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (283, 4, 283, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (284, 4, 284, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (285, 4, 285, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (286, 4, 286, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (287, 4, 287, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (288, 4, 288, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (289, 4, 289, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (290, 4, 290, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (291, 4, 291, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (292, 4, 292, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (293, 4, 293, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (294, 4, 294, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (295, 4, 295, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (296, 4, 296, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (297, 4, 297, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (298, 4, 298, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (299, 4, 299, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (300, 4, 300, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (301, 4, 301, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (302, 4, 302, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (303, 4, 303, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (304, 4, 304, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (305, 4, 305, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (306, 4, 306, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (307, 4, 307, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (308, 4, 308, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (309, 4, 309, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (310, 4, 310, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (311, 4, 311, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (312, 4, 312, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (313, 4, 313, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (314, 4, 314, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (315, 4, 315, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (316, 4, 316, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (317, 4, 317, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (318, 4, 318, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (319, 4, 319, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (320, 4, 320, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (321, 5, 321, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (322, 5, 322, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (323, 5, 323, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (324, 5, 324, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (325, 5, 325, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (326, 5, 326, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (327, 5, 327, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (328, 5, 328, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (329, 5, 329, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (330, 5, 330, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (331, 5, 331, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (332, 5, 332, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (333, 5, 333, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (334, 5, 334, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (335, 5, 335, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (336, 5, 336, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (337, 5, 337, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (338, 5, 338, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (339, 5, 339, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (340, 5, 340, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (341, 5, 341, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (342, 5, 342, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (343, 5, 343, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (344, 5, 344, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (345, 5, 345, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (346, 5, 346, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (347, 5, 347, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (348, 5, 348, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (349, 5, 349, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (350, 5, 350, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (351, 5, 351, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (352, 5, 352, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (353, 5, 353, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (354, 5, 354, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (355, 5, 355, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (356, 5, 356, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (357, 5, 357, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (358, 5, 358, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (359, 5, 359, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (360, 5, 360, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (361, 5, 361, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (362, 5, 362, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (363, 5, 363, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (364, 5, 364, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (365, 5, 365, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (366, 5, 366, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (367, 5, 367, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (368, 5, 368, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (369, 5, 369, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (370, 5, 370, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (371, 5, 371, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (372, 5, 372, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (373, 5, 373, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (374, 5, 374, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (375, 5, 375, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (376, 5, 376, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (377, 5, 377, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (378, 5, 378, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (379, 5, 379, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (380, 5, 380, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (381, 5, 381, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (382, 5, 382, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (383, 5, 383, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (384, 5, 384, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (385, 5, 385, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (386, 5, 386, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (387, 5, 387, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (388, 5, 388, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (389, 5, 389, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (390, 5, 390, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (391, 5, 391, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (392, 5, 392, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (393, 5, 393, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (394, 5, 394, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (395, 5, 395, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (396, 5, 396, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (397, 5, 397, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (398, 5, 398, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (399, 5, 399, 200, '20:00:09.726821+03');
INSERT INTO products.products_stock (product_stock_id, branch_id, product_id, quantity, updated_on) VALUES (400, 5, 400, 200, '20:00:09.726821+03');


--
-- TOC entry 5076 (class 0 OID 20258)
-- Dependencies: 241
-- Data for Name: offer_condition_types; Type: TABLE DATA; Schema: promotions; Owner: postgres
--

INSERT INTO promotions.offer_condition_types (offer_condition_type_id, condition_type) VALUES (1, 'Product');
INSERT INTO promotions.offer_condition_types (offer_condition_type_id, condition_type) VALUES (2, 'Category');
INSERT INTO promotions.offer_condition_types (offer_condition_type_id, condition_type) VALUES (3, 'Cart Total');


--
-- TOC entry 5078 (class 0 OID 20267)
-- Dependencies: 243
-- Data for Name: offer_conditions; Type: TABLE DATA; Schema: promotions; Owner: postgres
--



--
-- TOC entry 5072 (class 0 OID 20224)
-- Dependencies: 237
-- Data for Name: offer_types; Type: TABLE DATA; Schema: promotions; Owner: postgres
--

INSERT INTO promotions.offer_types (offer_type_id, offer_type) VALUES (1, 'Percentage');
INSERT INTO promotions.offer_types (offer_type_id, offer_type) VALUES (2, 'Price Discount');
INSERT INTO promotions.offer_types (offer_type_id, offer_type) VALUES (3, 'Quantity Discount');
INSERT INTO promotions.offer_types (offer_type_id, offer_type) VALUES (4, 'Buy One Get One Free');


--
-- TOC entry 5074 (class 0 OID 20231)
-- Dependencies: 239
-- Data for Name: offers; Type: TABLE DATA; Schema: promotions; Owner: postgres
--

INSERT INTO promotions.offers (offer_id, store_id, branch_id, name, description, start_date, end_date, is_active, offer_type_id, discount_value, max_discount, min_order_value, created_at, updated_at, created_by, updated_by, offer_poster) VALUES (1, 1, NULL, 'Back To School Sale', 'Get 20% off on all school items', '2024-06-01 00:00:00', '2024-12-31 23:59:59', true, 1, 20.00, 100.00, 2000.00, '2024-09-21 13:46:38.561209+03', '2024-09-21 13:46:38.561209+03', NULL, NULL, 'default-landscape-bg-1.png');
INSERT INTO promotions.offers (offer_id, store_id, branch_id, name, description, start_date, end_date, is_active, offer_type_id, discount_value, max_discount, min_order_value, created_at, updated_at, created_by, updated_by, offer_poster) VALUES (2, 1, NULL, 'Buy 1 Get 1 Free', 'Buy one item and get another one for free on selected products.', '2024-07-01 00:00:00', '2024-12-31 23:59:59', true, 4, NULL, NULL, 0.00, '2024-09-21 13:46:38.561209+03', '2024-09-21 13:46:38.561209+03', NULL, NULL, 'default-landscape-bg-2.png');
INSERT INTO promotions.offers (offer_id, store_id, branch_id, name, description, start_date, end_date, is_active, offer_type_id, discount_value, max_discount, min_order_value, created_at, updated_at, created_by, updated_by, offer_poster) VALUES (3, 1, NULL, 'Black Friday', 'Flat KSh. 2,000 off on all orders above KSh. 10,000', '2024-11-01 00:00:00', '2024-12-31 23:59:59', true, 2, 2000.00, NULL, 10000.00, '2024-09-21 13:46:38.561209+03', '2024-09-21 13:46:38.561209+03', NULL, NULL, 'default-landscape-bg-1.png');
INSERT INTO promotions.offers (offer_id, store_id, branch_id, name, description, start_date, end_date, is_active, offer_type_id, discount_value, max_discount, min_order_value, created_at, updated_at, created_by, updated_by, offer_poster) VALUES (4, 1, NULL, 'New User Discount', 'KSh. 500 off on the first order for new users.', '2024-01-01 00:00:00', '2024-12-31 23:59:59', true, 1, 500.00, 500.00, 0.00, '2024-09-21 13:46:38.561209+03', '2024-09-21 13:46:38.561209+03', NULL, NULL, 'default-landscape-bg-3.png');


--
-- TOC entry 5080 (class 0 OID 20289)
-- Dependencies: 245
-- Data for Name: user_offers; Type: TABLE DATA; Schema: promotions; Owner: postgres
--



--
-- TOC entry 5055 (class 0 OID 20074)
-- Dependencies: 220
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (34, 'MAYOTTE', 'YT', 'MYT', '262', NULL);
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (55, 'WESTERN SAHARA', 'EH', 'ESH', '212', NULL);
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (1, 'ALGERIA', 'DZ', 'DZA', '213', 'DZD');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (2, 'ANGOLA', 'AO', 'AGO', '244', 'AOA');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (3, 'BENIN', 'BJ', 'BEN', '229', 'XOF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (4, 'BOTSWANA', 'BW', 'BWA', '267', 'BWP');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (5, 'BURKINA FASO', 'BF', 'BFA', '226', 'XOF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (6, 'BURUNDI', 'BI', 'BDI', '257', 'BIF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (7, 'CAMEROON', 'CM', 'CMR', '237', 'XAF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (8, 'CAPE VERDE', 'CV', 'CPV', '238', 'CVE');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (9, 'CENTRAL AFRICAN REPUBLIC', 'CF', 'CAF', '236', 'XAF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (10, 'CHAD', 'TD', 'TCD', '235', 'XAF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (11, 'COMOROS', 'KM', 'COM', '269', 'KMF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (13, 'CONGO, THE DEMOCRATIC REPUBLIC', 'CD', 'COD', '243', 'CDF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (14, 'COTE D’IVOIRE', 'CI', 'CIV', '225', 'XOF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (15, 'DJIBOUTI', 'DJ', 'DJI', '253', 'DJF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (16, 'EGYPT', 'EG', 'EGY', '20', 'EGP');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (17, 'EQUATORIAL GUINEA', 'GQ', 'GNQ', '240', 'XAF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (18, 'ERITREA', 'ER', 'ERI', '291', 'ERN');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (19, 'ETHIOPIA', 'ET', 'ETH', '251', 'ETB');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (20, 'GABON', 'GA', 'GAB', '241', 'XAF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (21, 'GAMBIA', 'GM', 'GMB', '220', 'GMD');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (22, 'GHANA', 'GH', 'GHA', '233', 'GHS');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (23, 'GUINEA', 'GN', 'GIN', '224', 'GNF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (24, 'GUINEA-BISSAU', 'GW', 'GNB', '245', 'GWP');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (25, 'KENYA', 'KE', 'KEN', '254', 'KES');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (26, 'LESOTHO', 'LS', 'LSO', '266', 'LSL');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (27, 'LIBERIA', 'LR', 'LBR', '231', 'LRD');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (28, 'LIBYAN ARAB JAMAHIRIYA', 'LY', 'LBY', '218', 'LYD');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (29, 'MADAGASCAR', 'MG', 'MDG', '261', 'MGA');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (12, 'CONGO', 'CG', 'COG', '242', 'XAF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (30, 'MALI', 'ML', 'MLI', '223', 'XOF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (31, 'MALAWI', 'MW', 'MWI', '265', 'MWK');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (32, 'MAURITANIA', 'MR', 'MRT', '222', 'MRO');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (33, 'MAURITIUS', 'MU', 'MUS', '230', 'MUR');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (35, 'MOROCCO', 'MA', 'MAR', '212', 'MAD');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (36, 'MOZAMBIQUE', 'MZ', 'MOZ', '258', 'MZN');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (37, 'NAMIBIA', 'NA', 'NAM', '264', 'NAD');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (38, 'NIGER', 'NE', 'NER', '227', 'XOF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (39, 'NIGERIA', 'NG', 'NGA', '234', 'NGN');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (40, 'REUNION ISLAND', 'RE', 'REU', '262', 'EUR');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (41, 'RWANDA', 'RW', 'RWA', '250', 'RWF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (42, 'SAO TOME AND PRINCIPE', 'ST', 'STP', '239', 'STD');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (43, 'SENEGAL', 'SN', 'SEN', '221', 'XOF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (44, 'SEYCHELLES', 'SC', 'SYC', '248', 'SCR');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (45, 'SIERRA LEONE', 'SL', 'SLE', '232', 'SLL');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (46, 'SOMALIA', 'SO', 'SOM', '252', 'SOS');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (47, 'SOUTH AFRICA', 'ZA', 'ZAF', '27', 'ZAR');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (48, 'SOUTH SUDAN', 'SS', 'SSD', '211', 'SSP');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (49, 'SUDAN', 'SD', 'SDN', '249', 'SDG');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (50, 'SWAZILAND', 'SZ', 'SWZ', '268', 'SZL');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (51, 'TANZANIA, UNITED REPUBLIC OF', 'TZ', 'TZA', '255', 'TZS');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (52, 'TOGO', 'TG', 'TGO', '228', 'XOF');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (53, 'TUNISIA', 'TN', 'TUN', '216', 'TND');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (54, 'UGANDA', 'UG', 'UGA', '256', 'UGX');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (56, 'ZAMBIA', 'ZM', 'ZMB', '260', 'ZMW');
INSERT INTO public.countries (country_id, country, a2, a3, dial, currency) VALUES (57, 'ZIMBABWE', 'ZW', 'ZWE', '263', 'ZWD');


--
-- TOC entry 5060 (class 0 OID 20100)
-- Dependencies: 225
-- Data for Name: tenants; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5057 (class 0 OID 20085)
-- Dependencies: 222
-- Data for Name: towns; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (12, 'Meru', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (13, 'Tharaka-Nithi', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (14, 'Embu', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (18, 'Nyandarua', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (19, 'Nyeri', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (20, 'Kirinyaga', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (21, 'Murang''a', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (24, 'West Pokot', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (26, 'Trans-Nzoia', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (28, 'Elgeyo-Marakwet', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (39, 'Bungoma', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (40, 'Busia', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (44, 'Migori', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (45, 'Kisii', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (46, 'Nyamira', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (1, 'Mombasa', 25, 2);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (2, 'Kwale', 25, 8);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (3, 'Kilifi', 25, 9);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (4, 'Tana River', 25, 21);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (5, 'Lamu', 25, 10);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (6, 'Taita–Taveta', 25, 22);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (7, 'Garissa', 25, 23);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (8, 'Wajir', 25, 27);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (9, 'Mandera', 25, 24);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (10, 'Marsabit', 25, 25);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (11, 'Isiolo', 25, 26);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (15, 'Kitui', 25, 29);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (16, 'Machakos', 25, 5);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (17, 'Makueni', 25, 28);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (22, 'Kiambu', 25, 4);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (23, 'Turkana', 25, 30);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (25, 'Samburu', 25, 31);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (27, 'Uasin Gishu', 25, 11);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (29, 'Nandi', 25, 32);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (30, 'Baringo', 25, 12);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (31, 'Laikipia', 25, 14);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (32, 'Nakuru', 25, 13);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (33, 'Narok', 25, 7);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (34, 'Kajiado', 25, 6);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (35, 'Kericho', 25, 15);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (36, 'Bomet', 25, 16);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (37, 'Kakamega', 25, 17);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (38, 'Vihiga', 25, 18);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (41, 'Siaya', 25, 19);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (42, 'Kisumu', 25, 3);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (43, 'Homa Bay', 25, 20);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (47, 'Nairobi', 25, 1);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (199, 'Dar es Salaam', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (200, 'Dodoma', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (201, 'Mwanza', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (202, 'Tanga', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (203, 'Zanzibar', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (204, 'Mbeya', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (205, 'Morogoro', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (206, 'Tabora', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (207, 'Moshi', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (208, 'Lindi', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (209, 'Kigoma', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (210, 'Iringa', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (211, 'Mtwara', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (212, 'Shinyanga', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (213, 'Bukoba', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (214, 'Kahama', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (215, 'Songea', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (216, 'Sumbawanga', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (217, 'Mpanda', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (218, 'Musoma', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (219, 'Korogwe', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (220, 'Singida', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (221, 'Kasulu', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (222, 'Babati Urban', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (223, 'Makambako', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (224, 'Kibaha', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (225, 'Nansio', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (226, 'Mafinga', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (227, 'Handeni', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (228, 'Tunduma', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (229, 'Njombe', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (230, 'Stone Town', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (231, 'Likonde', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (232, 'Bagamoyo', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (233, 'Vwawa', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (234, 'Kilosa', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (235, 'Ifakara', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (236, 'Wete', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (237, 'Koani', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (238, 'Longido', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (239, 'Lukuledi', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (113, 'Ruiru', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (114, 'Eldoret', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (115, 'Kikuyu', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (116, 'Ngong', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (117, 'Mavoko', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (118, 'Thika', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (119, 'Naivasha', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (120, 'Karuri', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (121, 'Juja', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (122, 'Kitengela', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (123, 'Malindi', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (124, 'Mtwapa', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (125, 'Lodwar', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (126, 'Limuru', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (127, 'Ukunda', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (128, 'Kiserian', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (129, 'Nanyuki', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (130, 'El Wak', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (131, 'Gilgil', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (132, 'Kimilili', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (133, 'Voi', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (134, 'Wanguru', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (135, 'Habaswein', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (136, 'Turi', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (137, 'Moyale', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (138, 'Kenol', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (139, 'Masalani', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (140, 'Webuye', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (141, 'Njoro', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (142, 'Kapsabet', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (143, 'Mumias', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (144, 'Kerugoya-Kutus', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (145, 'Nyahururu', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (146, 'Rhamu', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (147, 'Mariakani', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (148, 'Maralal', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (149, 'Mairo-Inya', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (150, 'Makutano', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (151, 'Elburgon', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (152, 'Watamu', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (153, 'Isebania', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (154, 'Karatina', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (155, 'Kakuma', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (156, 'Lafey', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (157, 'Bondo', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (158, 'Kabarnet', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (159, 'Chuka', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (160, 'Kehancha', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (161, 'Maua', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (162, 'Taveta Town', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (163, 'Takaba', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (164, 'Eldama Ravine', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (165, 'Hola', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (166, 'Mai Mahiu', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (167, 'Rongo', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (168, 'Oyugis', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (169, 'Wote', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (170, 'Emali', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (171, 'Garbatula', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (172, 'Mbale', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (173, 'Mwingi', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (174, 'Awendo', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (175, 'Kiminini', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (176, 'Moi''s Bridge', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (177, 'Mazeras', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (178, 'Malaba', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (179, 'Makindu', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (180, 'Banissa', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (181, 'Msambweni', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (182, 'Namanga', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (183, 'Mbita', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (184, 'Isinya', 25, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (240, 'Kongwa', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (241, 'Kiwengwa', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (242, 'Geita', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (243, 'Lamadi', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (244, 'Chake Chake', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (245, 'Mto Wa Mbu', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (246, 'Biharamulo', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (247, 'Uvinza', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (248, 'Nzega', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (249, 'Tarime', 51, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (250, 'Gulu', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (251, 'Mbarara', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (255, 'Arua', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (256, 'Lira', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (257, 'Hoima', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (258, 'Soroti', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (259, 'Fort Portal', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (260, 'Nakasongola', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (264, 'Kabale', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (265, 'Mityana', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (266, 'Moroto', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (267, 'Masindi', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (268, 'Kitgum', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (269, 'Mubende', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (270, 'Wakiso', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (271, 'Njeru', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (272, 'Nansana', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (273, 'Lugazi', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (274, 'Kira Town', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (275, 'Masaka', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (276, 'Isingiro', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (277, 'Tororo', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (278, 'Buikwe', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (279, 'Apac', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (280, 'Iganga', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (281, 'Adjumani', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (282, 'Bundibugyo', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (283, 'Kalungu', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (284, 'Kisoro', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (285, 'Yumbe', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (286, 'Ntungamo', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (287, 'Kiboga', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (288, 'Bugiri', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (289, 'Nebbi', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (290, 'Pallisa', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (291, 'Mpigi', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (292, 'Kanungu', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (293, 'Kotido', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (294, 'Kamwenge', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (295, 'Luweero', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (296, 'Kyenjojo', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (297, 'Lyantonde', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (298, 'Rukungiri', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (299, 'Sironko', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (300, 'Mayuge', 54, NULL);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (261, 'Entebbe', 54, 2);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (254, 'Kampala', 54, 1);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (263, 'Mukono', 54, 4);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (262, 'Kasese', 54, 3);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (253, 'Jinja', 54, 5);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (252, 'Mbale', 54, 6);
INSERT INTO public.towns (town_id, town, country_id, sort_order) VALUES (331, 'Arusha', 51, NULL);


--
-- TOC entry 5070 (class 0 OID 20190)
-- Dependencies: 235
-- Data for Name: branches; Type: TABLE DATA; Schema: stores; Owner: postgres
--

INSERT INTO stores.branches (branch_id, store_id, name, address, town_id, icon, open_time, close_time, is_24_hrs, gps_coordinates, is_enabled, created_on, created_by, updated_on, updated_by) VALUES (1, 1, 'XYZ Rongai', 'Magadi Rd, Rongai', 116, 'test-branch.png', '06:00:00', '22:30:00', false, '(-1.3963431242797872,36.74757834736024)', true, '2024-08-25 17:10:22.456274+03', NULL, NULL, NULL);
INSERT INTO stores.branches (branch_id, store_id, name, address, town_id, icon, open_time, close_time, is_24_hrs, gps_coordinates, is_enabled, created_on, created_by, updated_on, updated_by) VALUES (2, 1, 'XYZ Kamakis', 'Eastern Bypass, Ruiru', 113, 'test-branch.png', '07:30:00', '22:00:00', false, '(-1.168167331605313,36.96802394197952)', true, '2024-08-25 17:10:22.456274+03', NULL, NULL, NULL);
INSERT INTO stores.branches (branch_id, store_id, name, address, town_id, icon, open_time, close_time, is_24_hrs, gps_coordinates, is_enabled, created_on, created_by, updated_on, updated_by) VALUES (3, 1, 'XYZ Tom Mboya', 'Tom Mboya St, Nairobi', 47, 'test-branch.png', '06:00:00', '21:00:00', false, '(-1.2839574736741637,36.82548204619486)', true, '2024-08-25 17:10:22.456274+03', NULL, NULL, NULL);
INSERT INTO stores.branches (branch_id, store_id, name, address, town_id, icon, open_time, close_time, is_24_hrs, gps_coordinates, is_enabled, created_on, created_by, updated_on, updated_by) VALUES (4, 1, 'XYZ Kisumu', 'Mito Jura Rd, Kisumu', 42, 'test-branch.png', '08:00:00', '21:30:00', false, '(-0.08963979399560908,34.76615623233824)', true, '2024-08-25 17:10:22.456274+03', NULL, NULL, NULL);
INSERT INTO stores.branches (branch_id, store_id, name, address, town_id, icon, open_time, close_time, is_24_hrs, gps_coordinates, is_enabled, created_on, created_by, updated_on, updated_by) VALUES (5, 1, 'XYZ Mombasa', 'Beach Rd., Mombasa', 1, 'test-branch.png', '07:30:00', '22:00:00', false, '(-4.042114248738183,39.7012117706202)', true, '2024-08-25 17:10:22.456274+03', NULL, NULL, NULL);


--
-- TOC entry 5068 (class 0 OID 20160)
-- Dependencies: 233
-- Data for Name: stores; Type: TABLE DATA; Schema: stores; Owner: postgres
--

INSERT INTO stores.stores (store_id, name, description, country_id, town_id, logo, is_enabled, created_on, created_by, updated_on, updated_by) VALUES (1, 'XYZ Mart KE', 'One stop store for everything', 25, 47, 'business-store-test-image.jpg', true, '2024-08-25 15:35:50.414123+03', NULL, NULL, NULL);
INSERT INTO stores.stores (store_id, name, description, country_id, town_id, logo, is_enabled, created_on, created_by, updated_on, updated_by) VALUES (2, 'XYZ Mart UG', 'One stop store for everything', 54, 254, 'business-store-test-image.jpg', true, '2024-08-25 16:44:15.98415+03', NULL, NULL, NULL);


--
-- TOC entry 5064 (class 0 OID 20132)
-- Dependencies: 229
-- Data for Name: admin_users; Type: TABLE DATA; Schema: users; Owner: postgres
--



--
-- TOC entry 5066 (class 0 OID 20146)
-- Dependencies: 231
-- Data for Name: app_user_profile; Type: TABLE DATA; Schema: users; Owner: postgres
--

INSERT INTO users.app_user_profile (app_user_profile_id, app_user_id, user_name, email, phone, updated_on, last_gps_location) VALUES (1, 1, 'Clint', 'andrewarianda@gmail.com', '0740334102', NULL, '(-1.2808897938744512,36.81750140002561)');


--
-- TOC entry 5062 (class 0 OID 20115)
-- Dependencies: 227
-- Data for Name: app_users; Type: TABLE DATA; Schema: users; Owner: postgres
--

INSERT INTO users.app_users (app_user_id, active, last_active, pwd, token, created_on, updated_on) VALUES (1, true, '2024-08-24 16:35:06.305644+03', '$2a$12$v6KqKyhjZ2Xd2Xb24bQVQOUFvdUrIpsC8d0oI9C7VL9evQwuZIqBe', NULL, '2024-08-24 16:35:06.305644+03', NULL);


--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 246
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: products; Owner: postgres
--

SELECT pg_catalog.setval('products.categories_category_id_seq', 20, true);


--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 253
-- Name: products_images_product_image_id_seq; Type: SEQUENCE SET; Schema: products; Owner: postgres
--

SELECT pg_catalog.setval('products.products_images_product_image_id_seq', 400, true);


--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 250
-- Name: products_pricing_product_price_id_seq; Type: SEQUENCE SET; Schema: products; Owner: postgres
--

SELECT pg_catalog.setval('products.products_pricing_product_price_id_seq', 400, true);


--
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 248
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: products; Owner: postgres
--

SELECT pg_catalog.setval('products.products_product_id_seq', 400, true);


--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 255
-- Name: products_stock_product_stock_id_seq; Type: SEQUENCE SET; Schema: products; Owner: postgres
--

SELECT pg_catalog.setval('products.products_stock_product_stock_id_seq', 400, true);


--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 240
-- Name: offer_condition_types_offer_condition_type_id_seq; Type: SEQUENCE SET; Schema: promotions; Owner: postgres
--

SELECT pg_catalog.setval('promotions.offer_condition_types_offer_condition_type_id_seq', 3, true);


--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 242
-- Name: offer_conditions_offer_condition_id_seq; Type: SEQUENCE SET; Schema: promotions; Owner: postgres
--

SELECT pg_catalog.setval('promotions.offer_conditions_offer_condition_id_seq', 1, false);


--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 236
-- Name: offer_types_offer_type_id_seq; Type: SEQUENCE SET; Schema: promotions; Owner: postgres
--

SELECT pg_catalog.setval('promotions.offer_types_offer_type_id_seq', 4, true);


--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 238
-- Name: offers_offer_id_seq; Type: SEQUENCE SET; Schema: promotions; Owner: postgres
--

SELECT pg_catalog.setval('promotions.offers_offer_id_seq', 4, true);


--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 244
-- Name: user_offers_user_offer_id_seq; Type: SEQUENCE SET; Schema: promotions; Owner: postgres
--

SELECT pg_catalog.setval('promotions.user_offers_user_offer_id_seq', 1, false);


--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 221
-- Name: countries_country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.countries_country_id_seq', 1, false);


--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 224
-- Name: tenants_tenant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tenants_tenant_id_seq', 1, false);


--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 223
-- Name: towns_town_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.towns_town_id_seq', 331, true);


--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 234
-- Name: branches_branch_id_seq; Type: SEQUENCE SET; Schema: stores; Owner: postgres
--

SELECT pg_catalog.setval('stores.branches_branch_id_seq', 5, true);


--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 232
-- Name: stores_store_id_seq; Type: SEQUENCE SET; Schema: stores; Owner: postgres
--

SELECT pg_catalog.setval('stores.stores_store_id_seq', 2, true);


--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 228
-- Name: admin_users_admin_user_id_seq; Type: SEQUENCE SET; Schema: users; Owner: postgres
--

SELECT pg_catalog.setval('users.admin_users_admin_user_id_seq', 1, false);


--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 230
-- Name: app_user_profile_app_user_profile_id_seq; Type: SEQUENCE SET; Schema: users; Owner: postgres
--

SELECT pg_catalog.setval('users.app_user_profile_app_user_profile_id_seq', 1, true);


--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 226
-- Name: app_users_app_user_id_seq; Type: SEQUENCE SET; Schema: users; Owner: postgres
--

SELECT pg_catalog.setval('users.app_users_app_user_id_seq', 1, true);


--
-- TOC entry 4865 (class 2606 OID 20326)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- TOC entry 4881 (class 2606 OID 20419)
-- Name: products_images products_images_pkey; Type: CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products_images
    ADD CONSTRAINT products_images_pkey PRIMARY KEY (product_image_id);


--
-- TOC entry 4869 (class 2606 OID 20344)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- TOC entry 4875 (class 2606 OID 20363)
-- Name: products_pricing products_pricing_pkey; Type: CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products_pricing
    ADD CONSTRAINT products_pricing_pkey PRIMARY KEY (product_price_id);


--
-- TOC entry 4883 (class 2606 OID 20434)
-- Name: products_stock products_stock_pkey; Type: CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products_stock
    ADD CONSTRAINT products_stock_pkey PRIMARY KEY (product_stock_id);


--
-- TOC entry 4879 (class 2606 OID 20375)
-- Name: products_categories unique_branch_product_category; Type: CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products_categories
    ADD CONSTRAINT unique_branch_product_category UNIQUE (branch_id, product_id, category_id) INCLUDE (branch_id, product_id, category_id);


--
-- TOC entry 4871 (class 2606 OID 20346)
-- Name: products unique_branch_product_name; Type: CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products
    ADD CONSTRAINT unique_branch_product_name UNIQUE (branch_id, name) INCLUDE (branch_id, name);


--
-- TOC entry 4873 (class 2606 OID 20348)
-- Name: products unique_branch_product_sku; Type: CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products
    ADD CONSTRAINT unique_branch_product_sku UNIQUE (branch_id, sku) INCLUDE (branch_id, sku);


--
-- TOC entry 4877 (class 2606 OID 20365)
-- Name: products_pricing unique_product_price; Type: CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products_pricing
    ADD CONSTRAINT unique_product_price UNIQUE (product_id) INCLUDE (product_id);


--
-- TOC entry 4885 (class 2606 OID 20436)
-- Name: products_stock unique_product_stock; Type: CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products_stock
    ADD CONSTRAINT unique_product_stock UNIQUE (branch_id, product_id) INCLUDE (branch_id, product_id);


--
-- TOC entry 4867 (class 2606 OID 20328)
-- Name: categories unique_store_category; Type: CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.categories
    ADD CONSTRAINT unique_store_category UNIQUE (store_id, name) INCLUDE (store_id, name);


--
-- TOC entry 4857 (class 2606 OID 20265)
-- Name: offer_condition_types offer_condition_types_pkey; Type: CONSTRAINT; Schema: promotions; Owner: postgres
--

ALTER TABLE ONLY promotions.offer_condition_types
    ADD CONSTRAINT offer_condition_types_pkey PRIMARY KEY (offer_condition_type_id);


--
-- TOC entry 4859 (class 2606 OID 20275)
-- Name: offer_conditions offer_conditions_pkey; Type: CONSTRAINT; Schema: promotions; Owner: postgres
--

ALTER TABLE ONLY promotions.offer_conditions
    ADD CONSTRAINT offer_conditions_pkey PRIMARY KEY (offer_condition_id);


--
-- TOC entry 4853 (class 2606 OID 20229)
-- Name: offer_types offer_types_pkey; Type: CONSTRAINT; Schema: promotions; Owner: postgres
--

ALTER TABLE ONLY promotions.offer_types
    ADD CONSTRAINT offer_types_pkey PRIMARY KEY (offer_type_id);


--
-- TOC entry 4855 (class 2606 OID 20241)
-- Name: offers offers_pkey; Type: CONSTRAINT; Schema: promotions; Owner: postgres
--

ALTER TABLE ONLY promotions.offers
    ADD CONSTRAINT offers_pkey PRIMARY KEY (offer_id);


--
-- TOC entry 4861 (class 2606 OID 20277)
-- Name: offer_conditions unique_offer_condition; Type: CONSTRAINT; Schema: promotions; Owner: postgres
--

ALTER TABLE ONLY promotions.offer_conditions
    ADD CONSTRAINT unique_offer_condition UNIQUE (offer_id, offer_condition_type_id) INCLUDE (offer_id, offer_condition_type_id);


--
-- TOC entry 4863 (class 2606 OID 20295)
-- Name: user_offers user_offers_pkey; Type: CONSTRAINT; Schema: promotions; Owner: postgres
--

ALTER TABLE ONLY promotions.user_offers
    ADD CONSTRAINT user_offers_pkey PRIMARY KEY (user_offer_id);


--
-- TOC entry 4821 (class 2606 OID 20080)
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (country_id);


--
-- TOC entry 4831 (class 2606 OID 20106)
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (tenant_id);


--
-- TOC entry 4827 (class 2606 OID 20091)
-- Name: towns towns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.towns
    ADD CONSTRAINT towns_pkey PRIMARY KEY (town_id);


--
-- TOC entry 4823 (class 2606 OID 20082)
-- Name: countries unique_a2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT unique_a2 UNIQUE (a2) INCLUDE (a2);


--
-- TOC entry 4825 (class 2606 OID 20084)
-- Name: countries unique_a3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT unique_a3 UNIQUE (a3) INCLUDE (a3);


--
-- TOC entry 4829 (class 2606 OID 20093)
-- Name: towns unique_country_town; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.towns
    ADD CONSTRAINT unique_country_town UNIQUE (town, country_id) INCLUDE (town, country_id);


--
-- TOC entry 4833 (class 2606 OID 20108)
-- Name: tenants unique_tenant_token; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenants
    ADD CONSTRAINT unique_tenant_token UNIQUE (token) INCLUDE (token);


--
-- TOC entry 4849 (class 2606 OID 20200)
-- Name: branches branches_pkey; Type: CONSTRAINT; Schema: stores; Owner: postgres
--

ALTER TABLE ONLY stores.branches
    ADD CONSTRAINT branches_pkey PRIMARY KEY (branch_id);


--
-- TOC entry 4845 (class 2606 OID 20166)
-- Name: stores stores_pkey; Type: CONSTRAINT; Schema: stores; Owner: postgres
--

ALTER TABLE ONLY stores.stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (store_id);


--
-- TOC entry 4847 (class 2606 OID 20168)
-- Name: stores unique_country_store; Type: CONSTRAINT; Schema: stores; Owner: postgres
--

ALTER TABLE ONLY stores.stores
    ADD CONSTRAINT unique_country_store UNIQUE (name, country_id) INCLUDE (name, country_id);


--
-- TOC entry 4851 (class 2606 OID 20202)
-- Name: branches unique_store_branch; Type: CONSTRAINT; Schema: stores; Owner: postgres
--

ALTER TABLE ONLY stores.branches
    ADD CONSTRAINT unique_store_branch UNIQUE (store_id, name, town_id) INCLUDE (store_id, name, town_id);


--
-- TOC entry 4839 (class 2606 OID 20142)
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (admin_user_id);


--
-- TOC entry 4843 (class 2606 OID 20153)
-- Name: app_user_profile app_user_profile_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.app_user_profile
    ADD CONSTRAINT app_user_profile_pkey PRIMARY KEY (app_user_profile_id);


--
-- TOC entry 4835 (class 2606 OID 20125)
-- Name: app_users app_users_pkey; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.app_users
    ADD CONSTRAINT app_users_pkey PRIMARY KEY (app_user_id);


--
-- TOC entry 4841 (class 2606 OID 20144)
-- Name: admin_users unique_admin_user_token; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.admin_users
    ADD CONSTRAINT unique_admin_user_token UNIQUE (token) INCLUDE (token);


--
-- TOC entry 4837 (class 2606 OID 20127)
-- Name: app_users unique_app_user_token; Type: CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.app_users
    ADD CONSTRAINT unique_app_user_token UNIQUE (token) INCLUDE (token);


--
-- TOC entry 4903 (class 2606 OID 20329)
-- Name: categories category_store_fk; Type: FK CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.categories
    ADD CONSTRAINT category_store_fk FOREIGN KEY (store_id) REFERENCES stores.stores(store_id);


--
-- TOC entry 4909 (class 2606 OID 20420)
-- Name: products_images images_product_fk; Type: FK CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products_images
    ADD CONSTRAINT images_product_fk FOREIGN KEY (product_id) REFERENCES products.products(product_id);


--
-- TOC entry 4904 (class 2606 OID 20349)
-- Name: products product_branch_fk; Type: FK CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products
    ADD CONSTRAINT product_branch_fk FOREIGN KEY (branch_id) REFERENCES stores.branches(branch_id);


--
-- TOC entry 4905 (class 2606 OID 20366)
-- Name: products_pricing product_price_fk; Type: FK CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products_pricing
    ADD CONSTRAINT product_price_fk FOREIGN KEY (product_id) REFERENCES products.products(product_id);


--
-- TOC entry 4906 (class 2606 OID 20376)
-- Name: products_categories products_categories_branch_fk; Type: FK CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products_categories
    ADD CONSTRAINT products_categories_branch_fk FOREIGN KEY (branch_id) REFERENCES stores.branches(branch_id);


--
-- TOC entry 4907 (class 2606 OID 20381)
-- Name: products_categories products_categories_category_fk; Type: FK CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products_categories
    ADD CONSTRAINT products_categories_category_fk FOREIGN KEY (category_id) REFERENCES products.categories(category_id);


--
-- TOC entry 4908 (class 2606 OID 20386)
-- Name: products_categories products_categories_product_fk; Type: FK CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products_categories
    ADD CONSTRAINT products_categories_product_fk FOREIGN KEY (product_id) REFERENCES products.products(product_id);


--
-- TOC entry 4910 (class 2606 OID 20437)
-- Name: products_stock products_stock_branch_fk; Type: FK CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products_stock
    ADD CONSTRAINT products_stock_branch_fk FOREIGN KEY (branch_id) REFERENCES stores.branches(branch_id);


--
-- TOC entry 4911 (class 2606 OID 20442)
-- Name: products_stock products_stock_product_fk; Type: FK CONSTRAINT; Schema: products; Owner: postgres
--

ALTER TABLE ONLY products.products_stock
    ADD CONSTRAINT products_stock_product_fk FOREIGN KEY (product_id) REFERENCES products.products(product_id);


--
-- TOC entry 4899 (class 2606 OID 20278)
-- Name: offer_conditions condition_offer_id_fk; Type: FK CONSTRAINT; Schema: promotions; Owner: postgres
--

ALTER TABLE ONLY promotions.offer_conditions
    ADD CONSTRAINT condition_offer_id_fk FOREIGN KEY (offer_id) REFERENCES promotions.offers(offer_id);


--
-- TOC entry 4900 (class 2606 OID 20283)
-- Name: offer_conditions offer_condition_type_fk; Type: FK CONSTRAINT; Schema: promotions; Owner: postgres
--

ALTER TABLE ONLY promotions.offer_conditions
    ADD CONSTRAINT offer_condition_type_fk FOREIGN KEY (offer_condition_type_id) REFERENCES promotions.offer_condition_types(offer_condition_type_id);


--
-- TOC entry 4896 (class 2606 OID 20252)
-- Name: offers offers_branch_fk; Type: FK CONSTRAINT; Schema: promotions; Owner: postgres
--

ALTER TABLE ONLY promotions.offers
    ADD CONSTRAINT offers_branch_fk FOREIGN KEY (branch_id) REFERENCES stores.branches(branch_id);


--
-- TOC entry 4897 (class 2606 OID 20242)
-- Name: offers offers_offer_type_fk; Type: FK CONSTRAINT; Schema: promotions; Owner: postgres
--

ALTER TABLE ONLY promotions.offers
    ADD CONSTRAINT offers_offer_type_fk FOREIGN KEY (offer_type_id) REFERENCES promotions.offer_types(offer_type_id);


--
-- TOC entry 4898 (class 2606 OID 20247)
-- Name: offers offers_store_fk; Type: FK CONSTRAINT; Schema: promotions; Owner: postgres
--

ALTER TABLE ONLY promotions.offers
    ADD CONSTRAINT offers_store_fk FOREIGN KEY (store_id) REFERENCES stores.stores(store_id);


--
-- TOC entry 4901 (class 2606 OID 20301)
-- Name: user_offers user_offers_offer_fk; Type: FK CONSTRAINT; Schema: promotions; Owner: postgres
--

ALTER TABLE ONLY promotions.user_offers
    ADD CONSTRAINT user_offers_offer_fk FOREIGN KEY (offer_id) REFERENCES promotions.offers(offer_id);


--
-- TOC entry 4902 (class 2606 OID 20296)
-- Name: user_offers user_offers_user_fk; Type: FK CONSTRAINT; Schema: promotions; Owner: postgres
--

ALTER TABLE ONLY promotions.user_offers
    ADD CONSTRAINT user_offers_user_fk FOREIGN KEY (user_id) REFERENCES users.app_users(app_user_id);


--
-- TOC entry 4886 (class 2606 OID 20094)
-- Name: towns towns_country; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.towns
    ADD CONSTRAINT towns_country FOREIGN KEY (country_id) REFERENCES public.countries(country_id) NOT VALID;


--
-- TOC entry 4892 (class 2606 OID 20213)
-- Name: branches branch_creator_fk; Type: FK CONSTRAINT; Schema: stores; Owner: postgres
--

ALTER TABLE ONLY stores.branches
    ADD CONSTRAINT branch_creator_fk FOREIGN KEY (created_by) REFERENCES users.admin_users(admin_user_id);


--
-- TOC entry 4893 (class 2606 OID 20203)
-- Name: branches branch_store_fk; Type: FK CONSTRAINT; Schema: stores; Owner: postgres
--

ALTER TABLE ONLY stores.branches
    ADD CONSTRAINT branch_store_fk FOREIGN KEY (store_id) REFERENCES stores.stores(store_id);


--
-- TOC entry 4894 (class 2606 OID 20208)
-- Name: branches branch_town_fk; Type: FK CONSTRAINT; Schema: stores; Owner: postgres
--

ALTER TABLE ONLY stores.branches
    ADD CONSTRAINT branch_town_fk FOREIGN KEY (town_id) REFERENCES public.towns(town_id);


--
-- TOC entry 4895 (class 2606 OID 20218)
-- Name: branches branch_updator_fk; Type: FK CONSTRAINT; Schema: stores; Owner: postgres
--

ALTER TABLE ONLY stores.branches
    ADD CONSTRAINT branch_updator_fk FOREIGN KEY (updated_by) REFERENCES users.admin_users(admin_user_id);


--
-- TOC entry 4888 (class 2606 OID 20169)
-- Name: stores store_country_fk; Type: FK CONSTRAINT; Schema: stores; Owner: postgres
--

ALTER TABLE ONLY stores.stores
    ADD CONSTRAINT store_country_fk FOREIGN KEY (country_id) REFERENCES public.countries(country_id);


--
-- TOC entry 4889 (class 2606 OID 20179)
-- Name: stores store_creator_fk; Type: FK CONSTRAINT; Schema: stores; Owner: postgres
--

ALTER TABLE ONLY stores.stores
    ADD CONSTRAINT store_creator_fk FOREIGN KEY (created_by) REFERENCES users.admin_users(admin_user_id);


--
-- TOC entry 4890 (class 2606 OID 20174)
-- Name: stores store_town_fk; Type: FK CONSTRAINT; Schema: stores; Owner: postgres
--

ALTER TABLE ONLY stores.stores
    ADD CONSTRAINT store_town_fk FOREIGN KEY (town_id) REFERENCES public.towns(town_id);


--
-- TOC entry 4891 (class 2606 OID 20184)
-- Name: stores store_updator_fk; Type: FK CONSTRAINT; Schema: stores; Owner: postgres
--

ALTER TABLE ONLY stores.stores
    ADD CONSTRAINT store_updator_fk FOREIGN KEY (updated_by) REFERENCES users.admin_users(admin_user_id);


--
-- TOC entry 4887 (class 2606 OID 20154)
-- Name: app_user_profile app_user_profile_fk; Type: FK CONSTRAINT; Schema: users; Owner: postgres
--

ALTER TABLE ONLY users.app_user_profile
    ADD CONSTRAINT app_user_profile_fk FOREIGN KEY (app_user_id) REFERENCES users.app_users(app_user_id);


-- Completed on 2024-09-23 05:54:45

--
-- PostgreSQL database dump complete
--

