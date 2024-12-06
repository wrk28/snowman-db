--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-11-29 05:13:13 MSK

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
-- TOC entry 5 (class 2615 OID 21022)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 868 (class 1247 OID 21030)
-- Name: ability_level; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.ability_level AS ENUM (
    '1',
    '2'
);


--
-- TOC entry 874 (class 1247 OID 21040)
-- Name: completion_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.completion_status AS ENUM (
    'Scheduled'
);


--
-- TOC entry 865 (class 1247 OID 21024)
-- Name: course_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.course_type AS ENUM (
    'Ski',
    'Snowboard'
);


--
-- TOC entry 871 (class 1247 OID 21036)
-- Name: invoice_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.invoice_status AS ENUM (
    'Send'
);


--
-- TOC entry 240 (class 1255 OID 21221)
-- Name: on_booking_delete_fn(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.on_booking_delete_fn() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
end;
$$;


--
-- TOC entry 239 (class 1255 OID 21220)
-- Name: on_booking_insert_fn(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.on_booking_insert_fn() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
end;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 231 (class 1259 OID 21198)
-- Name: available_date_time; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.available_date_time (
    instructor_id integer NOT NULL,
    operating_day_id integer NOT NULL,
    setting_time_id integer NOT NULL
);


--
-- TOC entry 233 (class 1259 OID 21350)
-- Name: booking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking (
    booking_id integer NOT NULL,
    customer_name character varying(50) NOT NULL,
    phone_number character varying(20) NOT NULL,
    days_of_lesson smallint NOT NULL,
    number_of_people smallint NOT NULL,
    duration time without time zone NOT NULL,
    completion_status public.completion_status NOT NULL,
    ability_level public.ability_level NOT NULL,
    course_id integer NOT NULL,
    slope_id integer NOT NULL,
    country_id integer NOT NULL,
    instructor_id integer,
    operating_day integer NOT NULL,
    setting_time_id integer NOT NULL
);


--
-- TOC entry 232 (class 1259 OID 21349)
-- Name: booking_booking_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3759 (class 0 OID 0)
-- Dependencies: 232
-- Name: booking_booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_booking_id_seq OWNED BY public.booking.booking_id;


--
-- TOC entry 220 (class 1259 OID 21058)
-- Name: country; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.country (
    country_id integer NOT NULL,
    country_name character varying(50) NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 21057)
-- Name: country_country_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.country_country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3760 (class 0 OID 0)
-- Dependencies: 219
-- Name: country_country_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.country_country_id_seq OWNED BY public.country.country_id;


--
-- TOC entry 218 (class 1259 OID 21051)
-- Name: course; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course (
    course_id integer NOT NULL,
    course_name character varying(50) NOT NULL,
    course_type public.course_type NOT NULL,
    ability_level public.ability_level NOT NULL,
    days_of_lesson smallint NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 21050)
-- Name: course_course_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.course_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3761 (class 0 OID 0)
-- Dependencies: 217
-- Name: course_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.course_course_id_seq OWNED BY public.course.course_id;


--
-- TOC entry 225 (class 1259 OID 21079)
-- Name: course_setting_time; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_setting_time (
    course_id integer NOT NULL,
    setting_time_id integer NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 21065)
-- Name: instructor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.instructor (
    instructor_id integer NOT NULL,
    instructor_name character varying(50) NOT NULL,
    active boolean DEFAULT true,
    ability_level public.ability_level NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 21064)
-- Name: instructor_instructor_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.instructor_instructor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3762 (class 0 OID 0)
-- Dependencies: 221
-- Name: instructor_instructor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.instructor_instructor_id_seq OWNED BY public.instructor.instructor_id;


--
-- TOC entry 235 (class 1259 OID 21418)
-- Name: invoice; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invoice (
    invoice_id integer NOT NULL,
    invoice_status public.invoice_status DEFAULT 'Send'::public.invoice_status,
    booking_id integer
);


--
-- TOC entry 234 (class 1259 OID 21417)
-- Name: invoice_invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.invoice_invoice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3763 (class 0 OID 0)
-- Dependencies: 234
-- Name: invoice_invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.invoice_invoice_id_seq OWNED BY public.invoice.invoice_id;


--
-- TOC entry 227 (class 1259 OID 21095)
-- Name: operating_day; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.operating_day (
    operating_day_id integer NOT NULL,
    operating_day date NOT NULL
);


--
-- TOC entry 226 (class 1259 OID 21094)
-- Name: operating_day_operating_day_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.operating_day_operating_day_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3764 (class 0 OID 0)
-- Dependencies: 226
-- Name: operating_day_operating_day_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.operating_day_operating_day_id_seq OWNED BY public.operating_day.operating_day_id;


--
-- TOC entry 236 (class 1259 OID 21432)
-- Name: school; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.school (
    school_id integer NOT NULL,
    school_name character varying(50) NOT NULL
);


--
-- TOC entry 238 (class 1259 OID 21444)
-- Name: school_operating_day; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.school_operating_day (
    school_id integer NOT NULL,
    operating_day_id integer NOT NULL
);


--
-- TOC entry 237 (class 1259 OID 21437)
-- Name: school_school_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.school_school_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3765 (class 0 OID 0)
-- Dependencies: 237
-- Name: school_school_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.school_school_id_seq OWNED BY public.school.school_id;


--
-- TOC entry 224 (class 1259 OID 21073)
-- Name: setting_time; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.setting_time (
    setting_time_id integer NOT NULL,
    setting_time character varying(50) NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 21072)
-- Name: setting_time_setting_time_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.setting_time_setting_time_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3766 (class 0 OID 0)
-- Dependencies: 223
-- Name: setting_time_setting_time_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.setting_time_setting_time_id_seq OWNED BY public.setting_time.setting_time_id;


--
-- TOC entry 216 (class 1259 OID 21044)
-- Name: slope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.slope (
    slope_id integer NOT NULL,
    slope_name character varying(50) NOT NULL,
    school_id integer NOT NULL
);


--
-- TOC entry 228 (class 1259 OID 21153)
-- Name: slope_course; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.slope_course (
    slope_id integer NOT NULL,
    course_id integer NOT NULL
);


--
-- TOC entry 229 (class 1259 OID 21168)
-- Name: slope_instructor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.slope_instructor (
    slope_id integer NOT NULL,
    instructor_id integer NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 21183)
-- Name: slope_operating_day; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.slope_operating_day (
    slope_id integer NOT NULL,
    operating_day_id integer NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 21043)
-- Name: slope_slope_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.slope_slope_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3767 (class 0 OID 0)
-- Dependencies: 215
-- Name: slope_slope_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.slope_slope_id_seq OWNED BY public.slope.slope_id;


--
-- TOC entry 3528 (class 2604 OID 21353)
-- Name: booking booking_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking ALTER COLUMN booking_id SET DEFAULT nextval('public.booking_booking_id_seq'::regclass);


--
-- TOC entry 3523 (class 2604 OID 21061)
-- Name: country country_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.country ALTER COLUMN country_id SET DEFAULT nextval('public.country_country_id_seq'::regclass);


--
-- TOC entry 3522 (class 2604 OID 21054)
-- Name: course course_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course ALTER COLUMN course_id SET DEFAULT nextval('public.course_course_id_seq'::regclass);


--
-- TOC entry 3524 (class 2604 OID 21068)
-- Name: instructor instructor_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instructor ALTER COLUMN instructor_id SET DEFAULT nextval('public.instructor_instructor_id_seq'::regclass);


--
-- TOC entry 3529 (class 2604 OID 21421)
-- Name: invoice invoice_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoice ALTER COLUMN invoice_id SET DEFAULT nextval('public.invoice_invoice_id_seq'::regclass);


--
-- TOC entry 3527 (class 2604 OID 21098)
-- Name: operating_day operating_day_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.operating_day ALTER COLUMN operating_day_id SET DEFAULT nextval('public.operating_day_operating_day_id_seq'::regclass);


--
-- TOC entry 3531 (class 2604 OID 21438)
-- Name: school school_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.school ALTER COLUMN school_id SET DEFAULT nextval('public.school_school_id_seq'::regclass);


--
-- TOC entry 3526 (class 2604 OID 21076)
-- Name: setting_time setting_time_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.setting_time ALTER COLUMN setting_time_id SET DEFAULT nextval('public.setting_time_setting_time_id_seq'::regclass);


--
-- TOC entry 3521 (class 2604 OID 21047)
-- Name: slope slope_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.slope ALTER COLUMN slope_id SET DEFAULT nextval('public.slope_slope_id_seq'::regclass);


--
-- TOC entry 3745 (class 0 OID 21198)
-- Dependencies: 231
-- Data for Name: available_date_time; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.available_date_time (instructor_id, operating_day_id, setting_time_id) FROM stdin;
\.


--
-- TOC entry 3747 (class 0 OID 21350)
-- Dependencies: 233
-- Data for Name: booking; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.booking (booking_id, customer_name, phone_number, days_of_lesson, number_of_people, duration, completion_status, ability_level, course_id, slope_id, country_id, instructor_id, operating_day, setting_time_id) FROM stdin;
\.


--
-- TOC entry 3734 (class 0 OID 21058)
-- Dependencies: 220
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.country (country_id, country_name) FROM stdin;
\.


--
-- TOC entry 3732 (class 0 OID 21051)
-- Dependencies: 218
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.course (course_id, course_name, course_type, ability_level, days_of_lesson) FROM stdin;
\.


--
-- TOC entry 3739 (class 0 OID 21079)
-- Dependencies: 225
-- Data for Name: course_setting_time; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.course_setting_time (course_id, setting_time_id) FROM stdin;
\.


--
-- TOC entry 3736 (class 0 OID 21065)
-- Dependencies: 222
-- Data for Name: instructor; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.instructor (instructor_id, instructor_name, active, ability_level) FROM stdin;
\.


--
-- TOC entry 3749 (class 0 OID 21418)
-- Dependencies: 235
-- Data for Name: invoice; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.invoice (invoice_id, invoice_status, booking_id) FROM stdin;
\.


--
-- TOC entry 3741 (class 0 OID 21095)
-- Dependencies: 227
-- Data for Name: operating_day; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.operating_day (operating_day_id, operating_day) FROM stdin;
\.


--
-- TOC entry 3750 (class 0 OID 21432)
-- Dependencies: 236
-- Data for Name: school; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.school (school_id, school_name) FROM stdin;
\.


--
-- TOC entry 3752 (class 0 OID 21444)
-- Dependencies: 238
-- Data for Name: school_operating_day; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.school_operating_day (school_id, operating_day_id) FROM stdin;
\.


--
-- TOC entry 3738 (class 0 OID 21073)
-- Dependencies: 224
-- Data for Name: setting_time; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.setting_time (setting_time_id, setting_time) FROM stdin;
\.


--
-- TOC entry 3730 (class 0 OID 21044)
-- Dependencies: 216
-- Data for Name: slope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.slope (slope_id, slope_name, school_id) FROM stdin;
\.


--
-- TOC entry 3742 (class 0 OID 21153)
-- Dependencies: 228
-- Data for Name: slope_course; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.slope_course (slope_id, course_id) FROM stdin;
\.


--
-- TOC entry 3743 (class 0 OID 21168)
-- Dependencies: 229
-- Data for Name: slope_instructor; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.slope_instructor (slope_id, instructor_id) FROM stdin;
\.


--
-- TOC entry 3744 (class 0 OID 21183)
-- Dependencies: 230
-- Data for Name: slope_operating_day; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.slope_operating_day (slope_id, operating_day_id) FROM stdin;
\.


--
-- TOC entry 3768 (class 0 OID 0)
-- Dependencies: 232
-- Name: booking_booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.booking_booking_id_seq', 1, false);


--
-- TOC entry 3769 (class 0 OID 0)
-- Dependencies: 219
-- Name: country_country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.country_country_id_seq', 1, false);


--
-- TOC entry 3770 (class 0 OID 0)
-- Dependencies: 217
-- Name: course_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.course_course_id_seq', 1, false);


--
-- TOC entry 3771 (class 0 OID 0)
-- Dependencies: 221
-- Name: instructor_instructor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.instructor_instructor_id_seq', 1, false);


--
-- TOC entry 3772 (class 0 OID 0)
-- Dependencies: 234
-- Name: invoice_invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.invoice_invoice_id_seq', 1, false);


--
-- TOC entry 3773 (class 0 OID 0)
-- Dependencies: 226
-- Name: operating_day_operating_day_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.operating_day_operating_day_id_seq', 1, false);


--
-- TOC entry 3774 (class 0 OID 0)
-- Dependencies: 237
-- Name: school_school_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.school_school_id_seq', 1, false);


--
-- TOC entry 3775 (class 0 OID 0)
-- Dependencies: 223
-- Name: setting_time_setting_time_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.setting_time_setting_time_id_seq', 1, false);


--
-- TOC entry 3776 (class 0 OID 0)
-- Dependencies: 215
-- Name: slope_slope_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.slope_slope_id_seq', 1, false);


--
-- TOC entry 3553 (class 2606 OID 21202)
-- Name: available_date_time available_date_time_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.available_date_time
    ADD CONSTRAINT available_date_time_pkey PRIMARY KEY (instructor_id, operating_day_id, setting_time_id);


--
-- TOC entry 3555 (class 2606 OID 21355)
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (booking_id);


--
-- TOC entry 3537 (class 2606 OID 21063)
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_id);


--
-- TOC entry 3535 (class 2606 OID 21056)
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (course_id);


--
-- TOC entry 3543 (class 2606 OID 21083)
-- Name: course_setting_time course_setting_time_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_setting_time
    ADD CONSTRAINT course_setting_time_pkey PRIMARY KEY (course_id, setting_time_id);


--
-- TOC entry 3539 (class 2606 OID 21071)
-- Name: instructor instructor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instructor
    ADD CONSTRAINT instructor_pkey PRIMARY KEY (instructor_id);


--
-- TOC entry 3557 (class 2606 OID 21426)
-- Name: invoice invoice_booking_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_booking_id_key UNIQUE (booking_id);


--
-- TOC entry 3559 (class 2606 OID 21424)
-- Name: invoice invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_pkey PRIMARY KEY (invoice_id);


--
-- TOC entry 3545 (class 2606 OID 21100)
-- Name: operating_day operating_day_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.operating_day
    ADD CONSTRAINT operating_day_pkey PRIMARY KEY (operating_day_id);


--
-- TOC entry 3563 (class 2606 OID 21463)
-- Name: school_operating_day school_operating_day_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.school_operating_day
    ADD CONSTRAINT school_operating_day_pk PRIMARY KEY (school_id, operating_day_id);


--
-- TOC entry 3561 (class 2606 OID 21443)
-- Name: school school_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.school
    ADD CONSTRAINT school_pk PRIMARY KEY (school_id);


--
-- TOC entry 3541 (class 2606 OID 21078)
-- Name: setting_time setting_time_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.setting_time
    ADD CONSTRAINT setting_time_pkey PRIMARY KEY (setting_time_id);


--
-- TOC entry 3547 (class 2606 OID 21157)
-- Name: slope_course slope_course_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.slope_course
    ADD CONSTRAINT slope_course_pkey PRIMARY KEY (slope_id, course_id);


--
-- TOC entry 3549 (class 2606 OID 21172)
-- Name: slope_instructor slope_instructor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.slope_instructor
    ADD CONSTRAINT slope_instructor_pkey PRIMARY KEY (slope_id, instructor_id);


--
-- TOC entry 3551 (class 2606 OID 21187)
-- Name: slope_operating_day slope_operating_day_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.slope_operating_day
    ADD CONSTRAINT slope_operating_day_pkey PRIMARY KEY (slope_id, operating_day_id);


--
-- TOC entry 3533 (class 2606 OID 21049)
-- Name: slope slope_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.slope
    ADD CONSTRAINT slope_pkey PRIMARY KEY (slope_id);


--
-- TOC entry 3585 (class 2620 OID 21356)
-- Name: booking on_booking_insert_tg; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER on_booking_insert_tg BEFORE DELETE ON public.booking FOR EACH ROW EXECUTE FUNCTION public.on_booking_delete_fn();


--
-- TOC entry 3573 (class 2606 OID 21203)
-- Name: available_date_time available_date_time_instructor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.available_date_time
    ADD CONSTRAINT available_date_time_instructor_id_fkey FOREIGN KEY (instructor_id) REFERENCES public.instructor(instructor_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3574 (class 2606 OID 21208)
-- Name: available_date_time available_date_time_operating_day_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.available_date_time
    ADD CONSTRAINT available_date_time_operating_day_id_fkey FOREIGN KEY (operating_day_id) REFERENCES public.operating_day(operating_day_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3575 (class 2606 OID 21213)
-- Name: available_date_time available_date_time_setting_time_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.available_date_time
    ADD CONSTRAINT available_date_time_setting_time_id_fkey FOREIGN KEY (setting_time_id) REFERENCES public.setting_time(setting_time_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3576 (class 2606 OID 21387)
-- Name: booking booking_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.country(country_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3577 (class 2606 OID 21392)
-- Name: booking booking_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(course_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3578 (class 2606 OID 21397)
-- Name: booking booking_instructor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_instructor_id_fkey FOREIGN KEY (instructor_id) REFERENCES public.instructor(instructor_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3579 (class 2606 OID 21402)
-- Name: booking booking_operating_day_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_operating_day_fkey FOREIGN KEY (operating_day) REFERENCES public.operating_day(operating_day_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3580 (class 2606 OID 21407)
-- Name: booking booking_setting_time_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_setting_time_id_fkey FOREIGN KEY (setting_time_id) REFERENCES public.setting_time(setting_time_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3581 (class 2606 OID 21412)
-- Name: booking booking_slope_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_slope_id_fkey FOREIGN KEY (slope_id) REFERENCES public.slope(slope_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3565 (class 2606 OID 21084)
-- Name: course_setting_time course_setting_time_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_setting_time
    ADD CONSTRAINT course_setting_time_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(course_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3566 (class 2606 OID 21089)
-- Name: course_setting_time course_setting_time_setting_time_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_setting_time
    ADD CONSTRAINT course_setting_time_setting_time_id_fkey FOREIGN KEY (setting_time_id) REFERENCES public.setting_time(setting_time_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3582 (class 2606 OID 21427)
-- Name: invoice invoice_booking_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoice
    ADD CONSTRAINT invoice_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.booking(booking_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3583 (class 2606 OID 21452)
-- Name: school_operating_day school_operating_day_operating_day_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.school_operating_day
    ADD CONSTRAINT school_operating_day_operating_day_fk FOREIGN KEY (operating_day_id) REFERENCES public.operating_day(operating_day_id) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 3584 (class 2606 OID 21447)
-- Name: school_operating_day school_operating_day_school_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.school_operating_day
    ADD CONSTRAINT school_operating_day_school_fk FOREIGN KEY (school_id) REFERENCES public.school(school_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3567 (class 2606 OID 21163)
-- Name: slope_course slope_course_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.slope_course
    ADD CONSTRAINT slope_course_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course(course_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3568 (class 2606 OID 21158)
-- Name: slope_course slope_course_slope_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.slope_course
    ADD CONSTRAINT slope_course_slope_id_fkey FOREIGN KEY (slope_id) REFERENCES public.slope(slope_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3569 (class 2606 OID 21178)
-- Name: slope_instructor slope_instructor_instructor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.slope_instructor
    ADD CONSTRAINT slope_instructor_instructor_id_fkey FOREIGN KEY (instructor_id) REFERENCES public.instructor(instructor_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3570 (class 2606 OID 21173)
-- Name: slope_instructor slope_instructor_slope_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.slope_instructor
    ADD CONSTRAINT slope_instructor_slope_id_fkey FOREIGN KEY (slope_id) REFERENCES public.slope(slope_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3571 (class 2606 OID 21193)
-- Name: slope_operating_day slope_operating_day_operating_day_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.slope_operating_day
    ADD CONSTRAINT slope_operating_day_operating_day_id_fkey FOREIGN KEY (operating_day_id) REFERENCES public.operating_day(operating_day_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3572 (class 2606 OID 21188)
-- Name: slope_operating_day slope_operating_day_slope_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.slope_operating_day
    ADD CONSTRAINT slope_operating_day_slope_id_fkey FOREIGN KEY (slope_id) REFERENCES public.slope(slope_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3564 (class 2606 OID 21457)
-- Name: slope slope_school_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.slope
    ADD CONSTRAINT slope_school_fk FOREIGN KEY (school_id) REFERENCES public.school(school_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 3758 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2024-11-29 05:13:13 MSK

--
-- PostgreSQL database dump complete
--

