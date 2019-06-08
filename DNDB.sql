--
-- PostgreSQL database dump
--

-- Dumped from database version 11.3
-- Dumped by pg_dump version 11.3

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
-- Name: comps; Type: TYPE; Schema: public; Owner: spooky
--

CREATE TYPE public.comps AS ENUM (
    'none',
    'v',
    'vs',
    'vsm'
);


ALTER TYPE public.comps OWNER TO spooky;

--
-- Name: damages; Type: TYPE; Schema: public; Owner: spooky
--

CREATE TYPE public.damages AS ENUM (
    'acid',
    'cold',
    'fire',
    'force',
    'lightning',
    'necrotic',
    'poison',
    'psychic',
    'radiant',
    'thunder',
    'bludgeoning',
    'slashing',
    'piercing'
);


ALTER TYPE public.damages OWNER TO spooky;

--
-- Name: magic_schools; Type: TYPE; Schema: public; Owner: spooky
--

CREATE TYPE public.magic_schools AS ENUM (
    'abjuration',
    'conjuration',
    'divination',
    'enchantment',
    'evocation',
    'illusion',
    'necromancy',
    'transmutation'
);


ALTER TYPE public.magic_schools OWNER TO spooky;

--
-- Name: mood; Type: TYPE; Schema: public; Owner: spooky
--

CREATE TYPE public.mood AS ENUM (
    'sad',
    'ok',
    'happy'
);


ALTER TYPE public.mood OWNER TO spooky;

--
-- Name: spell_types; Type: TYPE; Schema: public; Owner: spooky
--

CREATE TYPE public.spell_types AS ENUM (
    'heal',
    'damage',
    'heal and damage',
    'control',
    'other'
);


ALTER TYPE public.spell_types OWNER TO spooky;

--
-- Name: stats; Type: TYPE; Schema: public; Owner: spooky
--

CREATE TYPE public.stats AS ENUM (
    'str',
    'dex',
    'con',
    'int',
    'wis',
    'cha'
);


ALTER TYPE public.stats OWNER TO spooky;

--
-- Name: targets; Type: TYPE; Schema: public; Owner: spooky
--

CREATE TYPE public.targets AS ENUM (
    'all',
    'enemy',
    'ally',
    'any',
    'n/a'
);


ALTER TYPE public.targets OWNER TO spooky;

--
-- Name: times; Type: TYPE; Schema: public; Owner: spooky
--

CREATE TYPE public.times AS ENUM (
    'action',
    'bonus',
    'reaction',
    '10 min',
    '1 min',
    '1 hr',
    '8 hrs'
);


ALTER TYPE public.times OWNER TO spooky;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: classes; Type: TABLE; Schema: public; Owner: spooky
--

CREATE TABLE public.classes (
    class_id integer NOT NULL,
    name character varying(20) NOT NULL,
    spellcasting_stat public.stats NOT NULL
);


ALTER TABLE public.classes OWNER TO spooky;

--
-- Name: classspellinfo; Type: TABLE; Schema: public; Owner: spooky
--

CREATE TABLE public.classspellinfo (
    class_id integer,
    class_level integer NOT NULL,
    cantrips_known integer NOT NULL,
    spells_known character varying(50),
    lvl1slots integer NOT NULL,
    lvl2slots integer NOT NULL,
    lvl3slots integer NOT NULL,
    lvl4slots integer NOT NULL,
    lvl5slots integer NOT NULL,
    lvl6slots integer NOT NULL,
    lvl7slots integer NOT NULL,
    lvl8slots integer NOT NULL,
    lvl9slots integer NOT NULL,
    CONSTRAINT classspellinfo_cantrips_known_check CHECK ((cantrips_known > '-1'::integer)),
    CONSTRAINT classspellinfo_class_level_check CHECK (((class_level > 0) AND (class_level < 21))),
    CONSTRAINT classspellinfo_lvl1slots_check CHECK ((lvl1slots > '-1'::integer)),
    CONSTRAINT classspellinfo_lvl2slots_check CHECK ((lvl2slots > '-1'::integer)),
    CONSTRAINT classspellinfo_lvl3slots_check CHECK ((lvl3slots > '-1'::integer)),
    CONSTRAINT classspellinfo_lvl4slots_check CHECK ((lvl4slots > '-1'::integer)),
    CONSTRAINT classspellinfo_lvl5slots_check CHECK ((lvl5slots > '-1'::integer)),
    CONSTRAINT classspellinfo_lvl6slots_check CHECK ((lvl6slots > '-1'::integer)),
    CONSTRAINT classspellinfo_lvl7slots_check CHECK ((lvl7slots > '-1'::integer)),
    CONSTRAINT classspellinfo_lvl8slots_check CHECK ((lvl8slots > '-1'::integer)),
    CONSTRAINT classspellinfo_lvl9slots_check CHECK ((lvl9slots > '-1'::integer))
);


ALTER TABLE public.classspellinfo OWNER TO spooky;

--
-- Name: classspelllist; Type: TABLE; Schema: public; Owner: spooky
--

CREATE TABLE public.classspelllist (
    class_id integer NOT NULL,
    spell_id integer NOT NULL
);


ALTER TABLE public.classspelllist OWNER TO spooky;

--
-- Name: components; Type: TABLE; Schema: public; Owner: spooky
--

CREATE TABLE public.components (
    comp_id integer NOT NULL,
    vsm character varying(10) NOT NULL,
    description text,
    consumed boolean
);


ALTER TABLE public.components OWNER TO spooky;

--
-- Name: conditions; Type: TABLE; Schema: public; Owner: spooky
--

CREATE TABLE public.conditions (
    cond_id integer NOT NULL,
    name character varying(15) NOT NULL,
    effect text NOT NULL
);


ALTER TABLE public.conditions OWNER TO spooky;

--
-- Name: spells; Type: TABLE; Schema: public; Owner: spooky
--

CREATE TABLE public.spells (
    spell_id integer NOT NULL,
    name character varying(50) NOT NULL,
    category public.spell_types NOT NULL,
    level integer NOT NULL,
    school public.magic_schools NOT NULL,
    cast_time public.times NOT NULL,
    range character varying(50) NOT NULL,
    comp_id integer NOT NULL,
    duration text NOT NULL,
    concentration boolean NOT NULL,
    num_targets character varying(20),
    target_types text,
    save_stat public.stats,
    save_effect text,
    damage_type public.damages,
    amount text,
    increase_per_level text,
    cond_id integer,
    description text,
    ritual boolean
);


ALTER TABLE public.spells OWNER TO spooky;

--
-- Name: subclasses; Type: TABLE; Schema: public; Owner: spooky
--

CREATE TABLE public.subclasses (
    subclass_id integer NOT NULL,
    baseclass_id integer,
    subclass_name character varying(20) NOT NULL
);


ALTER TABLE public.subclasses OWNER TO spooky;

--
-- Name: subclassspelllist; Type: TABLE; Schema: public; Owner: spooky
--

CREATE TABLE public.subclassspelllist (
    subclass_id integer NOT NULL,
    spell_id integer NOT NULL
);


ALTER TABLE public.subclassspelllist OWNER TO spooky;

--
-- Data for Name: classes; Type: TABLE DATA; Schema: public; Owner: spooky
--

COPY public.classes (class_id, name, spellcasting_stat) FROM stdin;
1	bard	cha
2	cleric	wis
3	druid	wis
4	fighter	int
6	paladin	cha
7	ranger	wis
8	rogue	int
9	sorcerer	cha
10	warlock	cha
11	wizard	int
\.


--
-- Data for Name: classspellinfo; Type: TABLE DATA; Schema: public; Owner: spooky
--

COPY public.classspellinfo (class_id, class_level, cantrips_known, spells_known, lvl1slots, lvl2slots, lvl3slots, lvl4slots, lvl5slots, lvl6slots, lvl7slots, lvl8slots, lvl9slots) FROM stdin;
1	3	2	6	4	2	0	0	0	0	0	0	0
2	3	3	wis+3	4	2	0	0	0	0	0	0	0
3	3	2	wis+3	4	2	0	0	0	0	0	0	0
4	3	2	3	2	0	0	0	0	0	0	0	0
6	3	0	cha+1	3	0	0	0	0	0	0	0	0
1	2	2	5	3	0	0	0	0	0	0	0	0
1	4	3	7	4	3	0	0	0	0	0	0	0
1	5	3	8	4	3	2	0	0	0	0	0	0
1	6	3	9	4	3	3	0	0	0	0	0	0
1	7	3	10	4	3	3	1	0	0	0	0	0
1	8	3	11	4	3	3	2	0	0	0	0	0
1	9	3	12	4	3	3	3	1	0	0	0	0
1	10	4	14	4	3	3	3	2	0	0	0	0
1	11	4	15	4	3	3	3	2	1	0	0	0
1	12	4	15	4	3	3	3	2	1	0	0	0
1	13	4	16	4	3	3	3	2	1	1	0	0
1	14	4	18	4	3	3	3	2	1	1	0	0
1	15	4	19	4	3	3	3	2	1	1	1	0
1	16	4	19	4	3	3	3	2	1	1	1	0
1	17	4	20	4	3	3	3	2	1	1	1	1
1	18	4	22	4	3	3	3	3	2	1	1	1
1	19	4	22	4	3	3	3	3	2	1	1	1
1	20	4	22	4	3	3	3	3	2	2	1	1
2	2	3	wis+2	3	0	0	0	0	0	0	0	0
2	4	4	wis+4	4	3	0	0	0	0	0	0	0
2	5	4	wis+5	4	3	2	0	0	0	0	0	0
2	6	4	wis+6	4	3	3	0	0	0	0	0	0
2	7	4	wis+7	4	3	3	1	0	0	0	0	0
2	8	4	wis+8	4	3	3	2	0	0	0	0	0
2	9	4	wis+9	4	3	3	3	1	0	0	0	0
2	10	5	wis+10	4	3	3	3	2	0	0	0	0
2	11	5	wis+11	4	3	3	3	2	1	0	0	0
2	12	5	wis+12	4	3	3	3	2	1	0	0	0
2	13	5	wis+13	4	3	3	3	2	1	1	0	0
2	15	5	wis+15	4	3	3	3	2	1	1	1	0
2	14	5	wis+14	4	3	3	3	2	1	1	0	0
2	16	5	wis+16	4	3	3	3	2	1	1	1	0
2	17	5	wis+17	4	3	3	3	2	1	1	1	1
2	18	5	wis+18	4	3	3	3	3	1	1	1	1
2	19	5	wis+19	4	3	3	3	3	2	1	1	1
2	20	5	wis+20	4	3	3	3	3	2	2	1	1
3	2	2	wis+2	3	0	0	0	0	0	0	0	0
3	4	3	wis+4	4	3	0	0	0	0	0	0	0
3	5	3	wis+5	4	3	2	0	0	0	0	0	0
3	6	3	wis+6	4	3	3	0	0	0	0	0	0
3	7	3	wis+7	4	3	3	1	0	0	0	0	0
3	8	3	wis+8	4	3	3	2	0	0	0	0	0
3	9	3	wis+9	4	3	3	3	1	0	0	0	0
3	10	4	wis+10	4	3	3	3	2	0	0	0	0
3	11	4	wis+11	4	3	3	3	2	1	0	0	0
3	12	4	wis+12	4	3	3	3	2	1	0	0	0
3	13	4	wis+13	4	3	3	3	2	1	1	0	0
3	14	4	wis+14	4	3	3	3	2	1	1	0	0
3	15	4	wis+15	4	3	3	3	2	1	1	1	0
3	16	4	wis+16	4	3	3	3	2	1	1	1	0
3	17	4	wis+17	4	3	3	3	2	1	1	1	1
3	18	4	wis+18	4	3	3	3	3	1	1	1	1
3	19	4	wis+19	4	3	3	3	3	2	1	1	1
3	20	4	wis+20	4	3	3	3	3	2	2	1	1
4	2	0	0	0	0	0	0	0	0	0	0	0
4	4	2	4	3	0	0	0	0	0	0	0	0
4	5	2	4	3	0	0	0	0	0	0	0	0
4	6	2	4	3	0	0	0	0	0	0	0	0
4	7	2	5	4	2	0	0	0	0	0	0	0
4	8	2	6	4	2	0	0	0	0	0	0	0
4	9	2	6	4	2	0	0	0	0	0	0	0
4	10	3	7	4	3	0	0	0	0	0	0	0
4	11	3	8	4	3	0	0	0	0	0	0	0
4	12	3	8	4	3	0	0	0	0	0	0	0
4	13	3	9	4	3	2	0	0	0	0	0	0
4	14	3	10	4	3	2	0	0	0	0	0	0
4	15	3	10	4	3	2	0	0	0	0	0	0
4	16	3	11	4	3	3	0	0	0	0	0	0
4	17	3	11	4	3	3	0	0	0	0	0	0
4	18	3	11	4	3	3	0	0	0	0	0	0
4	19	3	12	4	3	3	1	0	0	0	0	0
6	2	0	cha+1	2	0	0	0	0	0	0	0	0
4	20	3	13	4	3	3	1	0	0	0	0	0
6	4	0	cha+2	3	0	0	0	0	0	0	0	0
6	5	0	cha+2	4	2	0	0	0	0	0	0	0
6	6	0	cha+3	4	2	0	0	0	0	0	0	0
6	7	0	cha+3	4	3	0	0	0	0	0	0	0
6	8	0	cha+4	4	3	0	0	0	0	0	0	0
6	9	0	cha+4	4	3	2	0	0	0	0	0	0
6	10	0	cha+5	4	3	2	0	0	0	0	0	0
6	12	0	cha+6	4	2	0	0	0	0	0	0	0
6	13	0	cha+6	4	3	3	1	0	0	0	0	0
6	14	0	cha+7	4	3	3	1	0	0	0	0	0
6	15	0	cha+7	4	3	3	2	0	0	0	0	0
6	16	0	cha+8	4	3	3	2	0	0	0	0	0
6	17	0	cha+8	4	3	3	3	1	0	0	0	0
1	1	2	4	2	0	0	0	0	0	0	0	0
2	1	3	wis+1	2	0	0	0	0	0	0	0	0
3	1	2	wis+1	2	0	0	0	0	0	0	0	0
4	1	0	0	0	0	0	0	0	0	0	0	0
6	11	0	cha+5	4	3	3	0	0	0	0	0	0
6	18	0	cha+9	4	3	3	3	2	0	0	0	0
6	19	0	cha+9	4	3	3	3	2	0	0	0	0
6	20	0	cha+10	4	3	3	3	2	0	0	0	0
6	1	0	0	0	0	0	0	0	0	0	0	0
7	1	0	0	0	0	0	0	0	0	0	0	0
7	2	0	2	2	0	0	0	0	0	0	0	0
7	3	0	3	3	0	0	0	0	0	0	0	0
7	4	0	3	3	0	0	0	0	0	0	0	0
7	5	0	4	4	2	0	0	0	0	0	0	0
7	6	0	4	4	2	0	0	0	0	0	0	0
7	7	0	5	4	3	0	0	0	0	0	0	0
7	8	0	5	4	3	0	0	0	0	0	0	0
7	9	0	6	4	3	2	0	0	0	0	0	0
7	10	0	6	4	3	2	0	0	0	0	0	0
7	11	0	7	4	3	3	0	0	0	0	0	0
7	12	0	7	4	3	3	0	0	0	0	0	0
7	13	0	8	4	3	3	1	0	0	0	0	0
7	14	0	8	4	3	3	1	0	0	0	0	0
7	15	0	9	4	3	3	2	0	0	0	0	0
7	16	0	9	4	3	3	2	0	0	0	0	0
7	17	0	10	4	3	3	3	1	0	0	0	0
7	18	0	10	4	3	3	3	1	0	0	0	0
7	19	0	11	4	3	3	3	2	0	0	0	0
7	20	0	11	4	3	3	3	2	0	0	0	0
8	3	3	3	2	0	0	0	0	0	0	0	0
8	4	3	4	3	0	0	0	0	0	0	0	0
8	5	3	4	3	0	0	0	0	0	0	0	0
8	6	3	4	3	0	0	0	0	0	0	0	0
8	7	3	5	4	2	0	0	0	0	0	0	0
8	8	3	6	4	2	0	0	0	0	0	0	0
8	9	3	6	4	2	0	0	0	0	0	0	0
8	10	4	7	4	3	0	0	0	0	0	0	0
8	11	4	8	4	3	0	0	0	0	0	0	0
8	12	4	8	4	3	0	0	0	0	0	0	0
8	13	4	9	4	3	2	0	0	0	0	0	0
8	14	4	10	4	3	2	0	0	0	0	0	0
8	15	4	10	4	3	2	0	0	0	0	0	0
8	16	4	11	4	3	3	0	0	0	0	0	0
8	17	4	11	4	3	3	0	0	0	0	0	0
8	18	4	11	4	3	3	0	0	0	0	0	0
8	19	4	12	4	3	3	1	0	0	0	0	0
8	20	4	13	4	3	3	1	0	0	0	0	0
8	2	0	0	0	0	0	0	0	0	0	0	0
8	1	0	0	0	0	0	0	0	0	0	0	0
9	1	4	2	2	0	0	0	0	0	0	0	0
9	2	4	3	3	0	0	0	0	0	0	0	0
9	3	4	4	4	2	0	0	0	0	0	0	0
9	4	5	5	4	3	0	0	0	0	0	0	0
9	5	5	6	4	3	2	0	0	0	0	0	0
9	6	5	7	4	3	3	0	0	0	0	0	0
9	7	5	8	4	3	3	1	0	0	0	0	0
9	8	5	9	4	3	3	2	0	0	0	0	0
9	9	5	10	4	3	3	3	1	0	0	0	0
9	10	6	11	4	3	3	3	2	0	0	0	0
9	11	6	12	4	3	3	3	2	1	0	0	0
9	12	6	12	4	3	3	3	2	1	0	0	0
9	13	6	13	4	3	3	3	2	1	1	0	0
9	14	6	13	4	3	3	3	2	1	1	0	0
9	15	6	14	4	3	3	3	2	1	1	1	0
9	16	6	14	4	3	3	3	2	1	1	1	0
9	17	6	15	4	3	3	3	2	1	1	1	1
9	18	6	15	4	3	3	3	3	1	1	1	1
9	19	6	15	4	3	3	3	3	2	1	1	1
9	20	6	15	4	3	3	3	3	2	2	1	1
10	1	2	2	1	0	0	0	0	0	0	0	0
10	2	2	3	2	0	0	0	0	0	0	0	0
10	3	2	4	0	2	0	0	0	0	0	0	0
10	4	3	5	0	2	0	0	0	0	0	0	0
10	5	3	6	0	0	2	0	0	0	0	0	0
10	6	3	7	0	0	2	0	0	0	0	0	0
10	7	3	8	0	0	0	2	0	0	0	0	0
10	8	3	9	0	0	0	2	0	0	0	0	0
10	9	3	10	0	0	0	0	2	0	0	0	0
10	10	4	10	0	0	0	0	2	0	0	0	0
10	11	4	11	0	0	0	0	3	0	0	0	0
10	12	4	11	0	0	0	0	3	0	0	0	0
10	13	4	12	0	0	0	0	3	0	0	0	0
10	14	4	12	0	0	0	0	4	0	0	0	0
10	15	4	13	0	0	0	0	3	0	0	0	0
10	16	4	13	0	0	0	0	3	0	0	0	0
10	17	4	14	0	0	0	0	4	0	0	0	0
10	18	4	14	0	0	0	0	4	0	0	0	0
10	19	4	15	0	0	0	0	4	0	0	0	0
10	20	4	15	0	0	0	0	4	0	0	0	0
11	1	3	6	2	0	0	0	0	0	0	0	0
11	2	3	int+2	3	0	0	0	0	0	0	0	0
11	3	3	int+3	4	2	0	0	0	0	0	0	0
11	4	4	int+4	4	3	0	0	0	0	0	0	0
11	5	4	int+5	4	3	2	0	0	0	0	0	0
11	6	4	int+6	4	3	3	0	0	0	0	0	0
11	7	4	int+7	4	3	3	1	0	0	0	0	0
11	8	4	int+8	4	3	3	2	0	0	0	0	0
11	9	4	int+9	4	3	3	3	1	0	0	0	0
11	10	5	int+10	4	3	3	3	2	0	0	0	0
11	11	5	int+11	4	3	3	3	2	1	0	0	0
11	12	5	int+12	4	3	3	3	2	1	0	0	0
11	13	5	int+13	4	3	3	3	2	1	1	0	0
11	14	5	int+14	4	3	3	3	2	1	1	0	0
11	15	5	int+15	4	3	3	3	2	1	1	1	0
11	16	5	int+16	4	3	3	3	2	1	1	1	0
11	17	5	int+17	4	3	3	3	2	1	1	1	1
11	18	5	int+18	4	3	3	3	3	1	1	1	1
11	19	5	int+19	4	3	3	3	3	2	1	1	1
11	20	5	int+20	4	3	3	3	3	2	2	1	1
\.


--
-- Data for Name: classspelllist; Type: TABLE DATA; Schema: public; Owner: spooky
--

COPY public.classspelllist (class_id, spell_id) FROM stdin;
9	6
10	6
11	6
2	1
3	1
3	7
2	2
9	2
1	2
11	2
2	3
3	3
9	3
11	3
1	3
3	8
9	8
11	8
10	8
3	9
2	4
3	4
2	5
3	10
2	11
2	12
7	13
11	13
3	14
7	14
1	14
2	15
1	15
2	16
6	16
2	17
7	17
11	17
10	17
1	17
2	18
6	18
2	19
3	19
2	20
3	20
6	20
7	20
1	20
2	21
6	21
2	22
3	22
1	22
6	22
7	22
9	22
11	22
2	23
3	23
6	23
7	23
6	24
3	25
3	26
1	26
9	27
11	27
3	28
7	28
9	28
11	28
3	29
7	29
2	30
2	31
1	31
3	31
6	32
1	32
7	33
2	34
3	35
7	35
9	35
11	35
3	36
1	36
7	36
11	36
2	37
6	37
10	37
11	37
3	38
2	38
6	38
2	40
2	41
6	41
3	42
7	42
1	42
3	43
1	43
9	43
11	43
2	44
6	44
1	45
3	45
7	45
2	46
3	47
7	47
1	48
2	48
9	48
11	48
1	49
2	49
9	49
11	49
6	50
1	51
2	51
1	52
11	52
3	53
7	53
9	53
11	53
1	54
2	54
3	54
9	54
3	55
3	56
11	56
6	57
2	58
3	58
7	58
2	60
11	60
3	61
9	61
11	61
1	62
3	62
1	63
2	63
3	63
9	63
10	63
11	63
1	64
2	64
3	64
6	64
7	64
1	65
3	65
7	65
1	66
2	66
3	66
6	66
7	66
11	66
3	67
3	68
7	68
2	69
2	70
3	70
6	70
1	71
2	71
7	71
3	72
7	72
2	73
3	74
2	75
1	75
6	75
10	76
11	76
11	77
2	78
1	79
2	79
11	79
3	80
1	81
2	81
9	81
11	81
3	82
3	83
6	83
2	84
3	84
6	84
7	84
9	84
1	85
2	85
3	85
6	85
9	85
10	85
11	85
9	86
10	86
11	86
1	87
2	87
11	87
2	88
6	88
10	88
11	88
2	89
2	90
3	90
1	91
7	91
11	91
3	92
3	93
2	106
3	106
7	106
9	106
11	106
2	94
6	94
10	94
11	94
2	95
6	95
1	96
11	96
2	96
3	97
2	98
1	98
3	99
2	100
1	101
2	101
9	101
10	101
11	101
3	102
2	103
3	103
7	103
9	103
3	104
10	105
11	105
3	109
11	109
3	110
7	110
3	131
11	131
3	148
10	148
2	149
10	149
11	149
2	163
\.


--
-- Data for Name: components; Type: TABLE DATA; Schema: public; Owner: spooky
--

COPY public.components (comp_id, vsm, description, consumed) FROM stdin;
1	none	\N	f
2	v	\N	f
3	vs	\N	f
4	vm	firefly or phosphorescent moss	f
5	vsm	two lodestones	f
6	vsm	miniature cloak	f
7	vsm	mistletoe, shamrock, and club/quarterstaff	f
8	vsm	tiny bell, piece of silver wire	f
9	vsm	a morsel of food	f
10	vsm	a drop of blood	f
11	vsm	a sprinkle of holy water	f
12	vsm	drop of water if creating; a few grains of sand if destroying	f
13	vsm	a yew leaf	f
14	vsm	small amount of alcohol or distilled spirits	f
15	vsm	mistletoe	f
16	vsm	grasshoppers hind leg	f
17	vsm	a pinch of dirt	f
18	vsm	holy water or powdered silver and iron	t
19	vsm	small silver mirror	f
20	vsm	small parchment with bit of holy text written on it	f
21	vsm	tiny strip of white cloth	f
22	vsm	specially marked sticks, bones, or similar tokens worth at least 25 gp	f
23	vsm	handful of oak bark	f
24	vsm	ruby dust worth 50 gp	t
25	vsm	pinch of dried carrot or an agate	f
26	vsm	fur or feather from a beast	f
27	vsm	leaf of a sumac	f
28	vsm	bit of tallow, pinch of brimstone, and dusting of powdered iron	f
29	vsm	pinch of salt and one copper piece placed in eyes of target; must remain for duration	f
30	vsm	legume seed	f
31	vsm	piece of iron and a flame	f
32	vsm	small, strait piece of iron	f
33	vsm	a bit of fur from a bloodhound	f
34	vsm	a forked twig	f
35	vsm	several seeds of the moonbeam plant and a piece of opalescent feldspar	f
36	vsm	ashes from burned mistletoe leaf and sprig of spruce	f
37	vsm	7 sharp thorns or 7 small twigs sharpened to a point	f
38	vsm	pair of platinum rings worth at least 50 gp; must be worn by caster and target for duration	f
39	vsm	drop of blood, piece of flesh, and a pinch of bone dust	f
40	vsm	focus worth at least 100 gp: either a jeweled horn for hearing or a glass eye for seeing	f
41	vsm	a bit of gauze and a wisp of smoke	f
42	vsm	incense and a powdered diamond worth at least 200 gp	t
43	vsm	holy water or powdered silver and iron worth at least 100 gp	t
44	vsm	pinch of diamond dust worth 25 gp sprinkled over target	t
45	vsm	diamonds worth at least 300 gp	t
46	vsm	small copper wire	f
47	vsm	pinch of dust and a few drops of water	f
48	vsm	burning incense	f
49	vsm	a holy symbol	f
50	vsm	small clay model of a ziggurat	f
51	vsm	short reed or piece of straw	f
52	vsm	piece of cork	f
53	vsm	tiny fan and feather of exotic origin	f
54	vsm	one holly berry per creature summoned	f
55	vsm	burning incense for air, soft clay for earth, sulfur and phosphorus for fire, water and sand for water	f
56	vsm	one clay pot filled with grave dirt, one clay pot filled with brackish water, and one 150 gp black onyx stone for each corpse	f
\.


--
-- Data for Name: conditions; Type: TABLE DATA; Schema: public; Owner: spooky
--

COPY public.conditions (cond_id, name, effect) FROM stdin;
1	blinded	cannot see, fails checks requiring sight, disadvantage on attacks, attacks against it have advantage
2	charmed	cannot attack charmer or target them with harmful magic, charmer has advantage on ability checks to interact with charmed
3	deafened	cannot hear, fails checks requiring hearing
4	frightened	has disadvantage on ability checks and attack rolls while it can see source of fear, cannot move closer to source of fear
5	grappled	speed is 0, condition ends if grappler is incapacitated or if an effect removes them from the reach of the grappler
6	incapacitated	cannot take actions or reactions
7	invisible	cannot see creature w/out magic, creature counts as heavily obscured, can still see tracks and hear sounds it makes, attacks aginst creature have disadvantage, attacks it makes have advantage
8	paralyzed	creature is incapacitated, cannot move or speak, fails str and dex saving throws, attacks against creature have advantage and are critical if attacker is w/in 5 ft
9	petrified	transformed along w/ all nonmagical items on it into stone; ceases aging; is incapacitated, cannot move or speak, unaware of surroundings
10	poisoned	disadvantage on attack rolls and ability checks
11	prone	can crawl only it spends action to stand up, creature has disadvantage on attack rolls, attacks aganist creature have disadvantage unless attacker is w/in 5 ft
12	restrained	speed is 0, attack rolls against creature have advantage, creature has disadvantage on attacks and dex saving throws
13	stunned	incapacitated, cannot move, cannot speak, fails str and dex saving throws, attacks rolls against creature have advantage
14	unconscious	incapacitated, cannot move or speak, unaware of surroundings, is prone, fails str and dex saving throws, attack rolls aganist it have advantage and are critical if attacker is w/in 5 ft
\.


--
-- Data for Name: spells; Type: TABLE DATA; Schema: public; Owner: spooky
--

COPY public.spells (spell_id, name, category, level, school, cast_time, range, comp_id, duration, concentration, num_targets, target_types, save_stat, save_effect, damage_type, amount, increase_per_level, cond_id, description, ritual) FROM stdin;
2	light	other	0	evocation	action	touch	4	1 hr	f	1	object < 10 ft	dex	if object on enemy: no effect	\N	\N	\N	\N	object shines any color bright light for 20 ft, dim light 20 ft more; blocked by opaque covering; spell ends if cast again or dismissed; save for enemy objects only	f
3	mending	other	0	transmutation	1 min	touch	5	instant	f	1	object < 1 ft	\N	\N	\N	\N	\N	\N	heals break or tear < 1 ft; repairs magical item or construct, but not magic itself	f
4	resistance	control	0	abjuration	action	touch	6	1 min	t	1	willing	\N	\N	\N	\N	\N	\N	1x: add 1d4 to a saving throw, before or after roll	f
1	guidance	control	0	divination	action	touch	3	1 min	t	1	willing	\N	\N	\N	\N	\N	\N	1x: target adds 1d4 to ability check, before or after it is rolled	f
5	sacred flame	damage	0	evocation	action	60 ft	3	instant	f	1	any	dex	no damage	radiant	1d8	1d8 more at levels 5, 11, 17	\N	target must be seen, no benefit from cover	f
6	chill touch	damage	0	necromancy	action	120 ft	3	1 round	f	1	creature	\N	\N	necrotic	1d8	\N	\N	target regains no HP until start of your next turn; undead targets have disadvantage on attacks against you until end of your next turn	f
7	druidcraft	other	0	transmutation	action	30 ft	3	instant	f	0	\N	\N	\N	\N	\N	\N	\N	create tiny effect to predict weather for next 24 hours and lasts 1 round; cause flowers to bloom; light or snuff out small, controlled fires; create harmless sensory effect in 5 ft cube	f
8	poison spray	damage	0	conjuration	action	10 ft	3	instant	f	1	creature	con	no effect	poison	\N	\N	\N	false	\N
9	produce flame	other	0	conjuration	action	30 ft	3	10 min	f	1	creature	\N	\N	fire	1d8	\N	\N	create small flame in casters hand that sheds bright light for 10ft and dim light for 10 more feet; if using to attack, ends spell	f
10	shillelagh	control	0	transmutation	bonus	self	7	1 min	f	0	casters club or quarterstaff	\N	\N	\N	\N	\N	\N	target is counted as magical, deals 1d8 dmg, and attack ability becomes spellcasting ability, until end of spell	f
11	spare the dying	other	0	necromancy	action	touch	3	instant	f	1	living creature with 0 hp	\N	\N	\N	\N	\N	\N	target becomes stable. No effect on undead or constructs	f
12	thaumaturgy	other	0	transmutation	action	30 ft	2	1 min	f	0	\N	\N	\N	\N	\N	\N	\N	manifest some minor wonder: voice becomes 3x as loud; cause flames to brighten, flicker, change color; cause harmless tremors in ground; create instantaneous sound that originates from point of casters choosing; create unlocked door/window to open or slam shut;  alter appearance of your eyes. Can have up to 3 of these effects going at once, and can dismiss them separately	f
13	alarm	other	1	abjuration	1 min	30 ft	8	8 hrs	f	0	door, window, or area <= 20ft cube	\N	\N	\N	\N	\N	\N	caster is alerted (mental or audible) whenever Tiny or larger creature enters or touches the warded area, as long as target is within 1 mile. Caster can designate creatures that will not set off alarm; audible alarm sounds like a hand bell rung for 10 sec, and is audible for 60 ft from source	f
14	animal friendship	other	1	enchantment	action	30 ft	9	24 hrs	f	1	beast that can see and hear caster	wis	no effect; if beasts int < 4, save auto fails	\N	\N	target one additional beast for every spell slot above 1st	2	\N	f
15	bane	control	1	enchantment	action	30 ft	10	1 min	t	3	creature	cha	no effect	\N	\N	target one more creature for every spell slot above 1st	\N	target subtracts 1d4 from every attack roll and saving throw	f
16	bless	control	1	enchantment	action	30 ft	11	1 min	t	3	creature	\N	\N	\N	\N	target one more creature for every spell slot above 1st	\N	target adds 1d4 to every attack roll and saving throw	f
17	charm person	other	1	enchantment	action	30 ft	3	1 hr	f	1	humanoid	wis	no effect; target has advantage if being fought by caster	\N	\N	target one additional creature for every spell slot above 1st, as long as targets are within 30 ft of each other	2	target regards caster as friendly acquaintance and knows spell has been cast when it ends; spell ends if caster begins fighting target	f
18	command	other	1	enchantment	action	60 ft	1	1 round	f	1	creature	wis	no effect	\N	\N	target one additional creature for every spell slot above 1st, as long as targets are within 30 ft of each other	\N	speak one word of command: approach, flee, grovel, drop, halt. No effect if target is undead, cannot understand your language, or if command is directly harmful to it	f
19	create or destroy water	other	1	transmutation	action	30 ft	12	instant	f	0	open container or 30 ft cube	\N	\N	\N	\N	create or destroy additional 10 gallons of water or the size of the cube increases by 5ft, for every spell slot above 1st	\N	create: create 10 gallons of water, or falls as rain, extinguishing any open flames in area. destroy: destroy 10 gallons of water, or fog in a 30 ft cube	f
20	cure wounds	heal	1	evocation	action	touch	3	instant	f	1	creature	\N	\N	\N	1d8 + spellcasting ability modifier	for every spell slot above 1st, healing increases by 1d8	\N	no effect on constructs or undead	f
21	detect evil and good	other	1	divination	action	self	3	10 min	t	1	self	\N	\N	\N	\N	\N	\N	know presence and location of aberration, celestial, elemental, fey, and fiend; know if a site has been consecrated or desecrated. No effect through 1 ft of stone, 1 in of metal, thin sheet of lead, 3 ft of wood or dirt	f
22	detect magic	other	1	divination	action	self	3	10 min	t	1	self	\N	\N	\N	\N	\N	\N	sense magic w/in 30 ft of self; can focus for 1 action and see aura around magical creature or object. Blocked by 1 ft of stone, 1 in of metal, thin sheet of lead, 3 ft of wood or dirt	t
23	detect poison and disease	other	1	divination	action	self	13	10 min	t	1	self	\N	\N	\N	\N	\N	\N	sense location of and identify poisons, poisonous creatures, diseases. Blocked by 1ft stone, 1 in metal, thin sheet lead, 3 ft wood or dirt	t
24	divine favor	damage	1	evocation	bonus	self	3	1 min	t	1	self	\N	\N	radiant	1d4	\N	\N	casters weapon does extra damage	f
25	entangle	control	1	conjuration	action	90 ft	3	1 min	t	all	creature in area	str	no effect	\N	\N	\N	12	20 ft square w/in range is difficult terrain. Trapped creatures can use action to reroll save	f
26	faerie fire	other	1	evocation	action	60 ft	2	1 min	t	all	creatures and objects in area	dex	no effect	\N	\N	\N	\N	everything in 20 ft range is outlined in blue, green, or violet light, and shed dim light for 10 ft. Attacks against affected creatures have advantage, and target cannot benefit from invisibility	f
28	fog cloud	other	1	conjuration	action	120 ft	3	1 hr	t	1	a point in range	\N	\N	\N	\N	radius of sphere increases by 20 ft for each level this is cast at above 1st	\N	20 ft sphere around point of focus is heavily obscured until spell ends or wind disperses it	f
29	goodberry	other	1	transmutation	action	touch	15	24 hrs	f	0	\N	\N	\N	\N	\N	\N	\N	Up to 10 berries appear in your hand; creature can use action to eat 1 berry, which restores 1 hp and enough nourishment to last 1 day. Must be eaten within 24 hours	f
30	guiding bolt	damage	1	evocation	action	120 ft	3	1 round	f	1	creature	\N	\N	radiant	4d6	1d6 added damage for each spell slot above 1st this is cast at	\N	next attack made against target has advantage due to mystical dim light around target	f
31	healing word	heal	1	evocation	bonus	60 ft	2	instant	f	1	creature caster can see	\N	\N	\N	1d4+spellcasting ability modifier	added 1d4 damage for each spell slot above 1st this is cast at	\N	no effect on undead or constructs	f
32	heroism	control	1	enchantment	action	touch	3	1 min	t	1	willing creature	\N	\N	\N	\N	target 1 additional creature for every spell slot above 1st this is cast at	\N	target is immune to frightened condition and gains temp HP equal to casters spellcasting ability modifier at the start of each of its turns, which is lost when spell ends	f
33	hunters mark	damage	1	divination	bonus	90 ft	2	1 hr	t	1	creature	\N	\N	\N	1d6	cast at 3rd to 4th level: lasts up to 8 hrs; cast at 5th level: lasts up to 24 hrs	\N	caster deals extra 1d6 weapon damage against target, and has advantage on perception or survival checks to find it. If target drops below 0 HP before this spell ends, use bonus action to pick a new target	f
34	inflict wounds	damage	1	necromancy	action	touch	3	instant	f	1	creature	\N	\N	necrotic	3d10	1d10 added damage for every spell slot above 1st this is cast at	\N	\N	f
35	jump	other	1	transmutation	action	touch	16	1 min	f	1	creature	\N	\N	\N	\N	\N	\N	jump distance is tripled	f
36	longstrider	other	1	transmutation	action	touch	17	1 hr	f	1	creature	\N	\N	\N	\N	target one additional creature for each spell slot above 1st this is cast at	\N	speed increases by 10 ft	f
37	protection from evil and good	control	1	abjuration	action	touch	18	10 min	t	1	willing creature	\N	\N	\N	\N	\N	\N	aberrations, celestials, elementals, fey, fiends, undead have disadvantage on attack rolls against target; target cannot be charmed, frightened, or possessed by them; if target has one of these conditions, it has advantage to save against it	f
38	purify food and drink	other	1	transmutation	action	10 ft	3	instant	f	all	non-magical food and drink within 5 ft radius sphere of a point w/in range	\N	\N	\N	\N	\N	\N	targets rendered free of poison and disease	t
39	ray of sickness	damage	1	necromancy	action	60 ft	3	instant	f	1	creature	con	no effect	poison	2d8	1d8 added damage for every spell slot above 1st this is cast at	10	effect lasts until end of casters next turn	f
40	sanctuary	control	1	abjuration	bonus	30 ft	19	1 min	f	1	creature	\N	\N	\N	\N	\N	\N	any attacker against target must succeed against Wis saving throw, or choose new target for attack or lose spell or attack. Does not protect against area effects. Ends if target attacks enemy	f
41	shield of faith	control	1	abjuration	bonus	60 ft	20	10 min	t	1	creature	\N	\N	\N	\N	\N	\N	target gets +2 bonus to AC	f
42	speak with animals	other	1	divination	action	self	3	10 min	f	1	self	\N	\N	\N	\N	\N	\N	caster can comprehend and verbally speak with beasts. Beast can communicate information about nearby locations and monsters, including what they have perceived for last day. Beast may be able to perform small favor, at GMs discretion	f
43	thunderwave	damage	1	evocation	action	self-15ft cube	3	instant	f	all	creatures within 15 ft cube in front of caster	con	takes half damage and is not pushed	thunder	2d8	1d8 added damage for each spell slot above 1st this is cast at	\N	creatures within 15 ft of caster are pushed 10 ft away from caster along with all unsecured objects. A thunderous boom is audible for 300 ft away	f
44	aid	control	2	abjuration	action	30 ft	21	8 hrs	f	3	creature	\N	\N	\N	\N	targets gains 5 additional HP for every slot above 2nd this is cast at	\N	target max and current HP increases by 5 temporarily	f
45	animal messenger	other	2	enchantment	action	30 ft	9	24 hrs	f	1	tiny beast caster can see	\N	\N	\N	\N	duration of spell increases by 48 hrs for each spell slot above 2nd this is cast at	\N	Caster specifies location they have visited, and a recipient who matches a general description; message of up to 25 words. Target travels for the duration of the spell, covering 50 miles per 24 hrs if flying, and 25 miles if not; if target does not make it to location in time, they return and message is lost. Target replicates sound of casters voice to creature matching description	t
46	augury	other	2	divination	1 min	self	22	instant	f	1	self	\N	\N	\N	\N	\N	\N	by using components as diving tools, caster receives omen about results of specific course of action caster plans to take within next 30 minutes. Results: weal (good), woe (bad), weal and woe (good and bad), or nothing (neutral). Spell does not take into account circumstances that might change the outcome, such as casting of additional spells or the gain of a companion. When cast again before next long rest, there is a cumulative 25% chance for each casting to result in a random reading (GM rolls in secret)	t
47	barkskin	control	2	transmutation	action	touch	23	1 hr	t	1	willing creature	\N	\N	\N	\N	\N	\N	targets skin has rough, barklike appearance, and its AC is bumped to 16	f
48	blindness	control	2	necromancy	action	30 ft	2	1 min	f	1	creature caster can see	con	no effect	\N	\N	target additional creature for every spell slot above 2nd this is cast at	1	(spell_id 48, 49 is one spell (Blindness Deafness) with 2 condition effects: upon casting, choose either effect)	f
49	deafness	control	2	necromancy	action	30 ft	2	1 min	f	1	creature caster can see	con	no effect	\N	\N	target additional creature for every spell slot above 2nd this is cast at	3	(spell_id 48, 49 is one spell (Blindness Deafness) with 2 condition effects: upon casting, choose either effect)	f
50	branding smite	damage	2	evocation	bonus	self	2	1 min	t	1	self	\N	\N	radiant	2d6	damage increases by 1d6 for each spell slot above 2nd this is cast at	\N	upon attack, target of attack becomes visible if it is invisible (outlined by gleaming light)	f
51	calm emotions	other	2	enchantment	action	60 ft	3	1 min	t	all	humanoids within 20 ft radius sphere centered around point of casters choosing	cha	no effect	\N	\N	\N	\N	target can choose to fail. choose one of these effects: suppress any effect causing target to be charmed or frightened for the duration of this spell; make target indifferent about creatures of casters choice that it is hostile toward. Spell ends if target is attacked or harmed by a spell or if it witnesses any of its friends being harmed; target then becomes hostile	f
52	continual flame	other	2	evocation	action	touch	24	until dispelled	f	1	object caster touches	\N	\N	\N	\N	\N	\N	a flame as bright as torchlight springs from object, but creates no smoke and uses no oxygen. Can be covered or hidden, but not smothered or quenched	f
53	darkvision	other	2	transmutation	action	touch	25	8 hrs	f	1	willing creature	\N	\N	\N	\N	\N	\N	target has darkvision up to 60 ft	f
54	enhance ability	control	2	transmutation	action	touch	26	1 hr	t	1	creature	\N	\N	\N	\N	target 1 additional creature for every spell slot above 2nd this is cast at	\N	target gains 1 effect: Bears Endurance (advantage on con checks, gains 2d6 temp HP), Bulls Strength (advantage on str checks, carrying capacity doubles), Cats Grace (advantage on dex checks, no damage from falling <=20 ft if target is not incapacitated), Eagles Splendor (advantage on cha checks), Foxs Cunning (advantage on int checks), Owls Wisdom (advantage on wis checks)	f
55	flame blade	damage	2	evocation	bonus	self	27	10 min	t	1	casters free hand	\N	\N	fire	3d6	1d6 additional damage for every 2 spell slots above 2nd this is cast at	\N	caster evokes firey blade in hand, similar to a scimitar; if let go of, blade disappears, but can be summoned again for duration of spell. To use, make a melee spell attack against target. Sheds bright light for 10 ft and dim light for another 10 ft	f
56	flaming sphere	damage	2	conjuration	action	60 ft	28	1 min	t	1	unoccupied space of casters choice	dex	half damage	fire	2d6	1d6 additional damage for each spell slot above 2nd this is cast at	\N	creates 5 ft diameter sphere of fire; can be moved up to 30 ft on casters bonus action normally, or over barriers up to 5 ft tall and over pits 10 ft wide. Sphere stops moving if rammed into target creature. Flammable objects not worn or carried are ignited, and sheds bright light for 20 ft and dim light for 20 ft	f
57	find steed	other	2	conjuration	10 min	30 ft	3	instant	f	1	unoccupied space	\N	\N	\N	\N	\N	\N	summon a spirit with form of unusually intelligent, strong, loyal steed (warhorse, pony, camel, elk, mastiff, or other with GMs approval), creating long-lasting bond with it; steed has statistics of chosen form, but it is of type celestial, fey, or fiend. Steeds intelligence becomes 6, and it can understand one language caster speaks, and can communicate telepathically with caster up to 1 mile away. While mounted, any spells that caster casts on itself also target steed. Steed disappears if dropped to 0 HP, but can summon steed again (reappears at its HP max). As an action, steed can be released from its bond.	f
58	find traps	other	2	divination	action	120 ft	3	instant	f	0	\N	\N	\N	\N	\N	\N	\N	caster senses general nature of traps within line of sight such as alarm spells, glyph of warding, mechanical traps; caster does not sense location of traps	f
60	gentle repose	other	2	necromancy	action	touch	29	10 days	f	1	corpse	\N	\N	\N	\N	\N	\N	target is protected from decay and cannot become undead; effectively extends time limit on raising target from dead	f
61	gust of wind	other	2	evocation	action	self(60ft line)	30	1 min	t	all	creature	str	no effect	\N	\N	\N	\N	line of strong wind 60 ft long and 10 ft wide blasts from caster in a direction of choice. Targets pushed 15 ft away from caster and has half movement. Disperses gas or vapor; extinguishes candles, torches, and unprotected flames, and causes protected flames (lanterns) to dance wildly with a 50% chance to extinguish them. As a bonus action caster can change direction	f
62	heat metal	damage	2	transmutation	action	60 ft	31	1 min	t	1	manufactured metal object	\N	\N	fire	2d8	1d8 additional damage for every spell slot above 2nd this is cast at	\N	object glows red hot. Creature touching object takes damage, and must drop object or take disadvantage on attacks and ability checks until start of casters next turn	f
63	hold person	control	2	enchantment	action	60 ft	32	1 min	t	1	humanoid caster can see	wis	no effect	\N	\N	1 additional target for each spell slot above 2nd this is cast at, as long as targets are within 30 ft of each other	8	target makes additional saving throws at end of its turns	f
64	lesser restoration	control	2	abjuration	action	touch	3	instant	f	1	creature	\N	\N	\N	\N	\N	\N	end one disease or condition afflicting target: blinded, deafened, paralyzed, or poisoned	f
65	locate animals or plants	other	2	divination	action	self	33	instant	f	1	self	\N	\N	\N	\N	\N	\N	caster describes or names specific kind of animal or plant and learns direction and distance to closest animal or plant of that type within 5 miles, if it is present	t
66	locate object	other	2	divination	action	self	34	10 min	t	1	self	\N	\N	\N	\N	\N	\N	caster describes or names an object familiar to them (has been seen within 30 ft at least once), and senses the direction to the objects location if it is within 1000 ft. If object is in motion, the direction of the movement is known. Also can locate the nearest object of a particular type, such as a certain kind of tool or weapon. Any thickness of lead between caster and object causes spell to fail	f
67	moonbeam	damage	2	evocation	action	120 ft	35	1 min	t	1	point within range	con	half damage	radiant	2d10	1d10 additional damage for each spell slot above 2nd this is cast at	\N	silvery beam of pale light shines down in a 5 ft radius, 40 ft high column. Dim light fills cylinder. Creature which enters area for first time or starts its turn there is damaged; shapechangers have disadvantage on saving throw and if failed, it reverts to its original form and cannot assume a different form until it leaves spells light. Can use action to move the beam up to 60 ft in any direction	f
68	pass without trace	other	2	abjuration	action	self	36	1 hr	t	any	creatures of choice	\N	\N	\N	\N	\N	\N	veil of shadows and silence radiates from caster. Targets have +10 bonus to stealth checks and cannot be tracked by magical means, and leave no tracks or trace of passage	f
69	prayer of healing	heal	2	evocation	10 min	30 ft	2	instant	f	up to 6	creatures of choice	\N	\N	\N	2d8+spellcasting ability modifier	1d8 additional healing for each spell slot above 2nd this is cast at	\N	no effect on undead or constructs	f
70	protection from poison	control	2	abjuration	action	touch	3	1 hr	f	1	creature	\N	\N	\N	\N	\N	\N	one poison (chosen by caster or at random) afflicting target is neutralized; target is resistant to poison damage and has advantage on saving throws against being poisoned	f
71	silence	control	2	illusion	action	120 ft	3	10 min	t	1	20 ft radius sphere centered around point of casters choice	\N	\N	\N	\N	\N	3	no sound can be created within or pass through sphere. Creatures within sphere are immune to thunder damage, and cannot cast spells with verbal component	f
72	spike growth	damage	2	transmutation	action	120 ft	37	10 min	t	1	ground in 20 ft radius sphere centered around point of choice	\N	\N	piercing	2d4	\N	\N	ground becomes difficult terrain; damage is taken for every 5 ft of travel. Creatures who cannot see ground at time spell is cast need to make perception check against spell save DC to recognize terrain as hazardous	f
73	spiritual weapon	damage	2	evocation	bonus	60 ft	3	1 min	f	0	\N	\N	\N	force	1d8+spellcasting ability modifier	1d8 additional damage for every 2 spell slots above 2nd this is cast at	\N	floating weapon (appearance is choice of caster) appears; can be moved as a bonus action up to 20 ft and attack creature within 5 ft as a melee spell attack	f
74	warding bond	damage	2	abjuration	action	touch	38	1 hr	f	1	willing creature	\N	\N	\N	\N	\N	\N	while target is within 60 ft of caster, target gets +1 bonus to AC and saving throws, and is resistant to all damage; whenever target takes damage, caster takes same amount of damage. Spell ends if caster drops to 0 HP, if caster and target are separated by more than 60 ft, or if cast again on either caster or target	f
75	zone of truth	other	2	enchantment	action	60 ft	3	10 min	f	1	15 ft radius sphere centered around point of choice	cha	no effect; caster knows result	\N	\N	\N	\N	zone guards against deception; creature that enters spells area for the first time on a turn or starts its turn there makes saving throw and cannot speak deliberate lie while within radius, but is aware of spell and can avoid answering questions or be evasive as long as it is within boundaries of the truth	f
76	ray of enfeeblement	damage	2	necromancy	action	60 ft	3	1 min	t	1	creature	con	spell ends	\N	\N	\N	\N	caster makes ranged spell attack on target; if hit, target deals half damage with weapon attacks that use str. Target makes saving throw to end spell	f
77	animate dead	other	3	necromancy	1 min	10 ft	39	instant	f	1	pile of bones or corpse of Medium to Small humanoid	\N	\N	\N	\N	animate or reassert control over 2 additional undead creatures for each spell slot above 3rd this is cast at	\N	the target is imbued with a foul mimicry of life, raised as a skeleton or a zombie. Target can be mentally commanded (if there are multiple targets, they can be commanded as a group) as a bonus action if it is within 60 ft of caster. Commands can be what actions to take, where to move, or a general command such as to guard a door, and will be followed until the task is complete; if no commands are given, the target guards itself against hostile enemies. The target is under casters control for 24 hrs, after which spell must be recast to regain control of target	f
78	beacon of hope	control	3	abjuration	action	30 ft	3	1 min	t	any to all	creature	\N	\N	\N	\N	\N	\N	target has advantage on wis saving throws and death saving throws, and gains max possible HP from any healing	f
79	bestow curse	control	3	necromancy	action	touch	3	1 min	t	1	creature	wis	no effect	\N	\N	4th level spell slot: duration is Concentration, 10 min. 5th or 6th level spell slot: duration is 8 hrs. 7th level spell slot: duration is 24 hrs. 9th level spell slot: spell lasts until it is dispelled	\N	caster chooses nature of curse from these options: target has disadvantage on ability checks and saving throws with an ability score of casters choice, target has disadvantage on attack rolls against caster, target must make wis saving throw on turn or spend its turn doing nothing, casters attacks and spells do extra 1d8 necrotic damage to target. Remove curse spell ends the effect	f
80	call lightning	damage	3	conjuration	action	120 ft	3	10 min	t	all	creature in 5 ft range of lightning bolt	dex	half damage	lightning	3d10	1d10 additional damage for each spell slot above 3rd this is cast at	\N	storm cloud appears in cylinder 10 ft tall, 60 ft radius, 100 ft directly above casters head; spell fails if caster cannot see a point in the air where a storm cloud could appear. Caster chooses point in range for lightning to strike on action. If cast outdoors during a storm, the spell gives caster power over existing storm, and damage increases by 1d10	f
81	clairvoyance	other	3	divination	10 min	1 mile	40	10 min	t	0	\N	\N	\N	\N	\N	\N	\N	caster creates an invisible sensor within range in a location familiar to them (a place visited or seen before) or in an obvious location that is unfamiliar (behind a door, around a corner, etc). Sensor cannot be attacked or interacted with. Caster can use either seeing or hearing sense through the sensor as if caster were in its place, and can switch between seeing and hearing as an action. Creatures with see invisibility or truesight can see sensor as a luminous, intangible orb about the size of a fist	f
82	conjure animals	other	3	conjuration	action	60 ft	3	1 hr	t	0	\N	\N	\N	\N	\N	5th to 6th level spell slot: 2x as many creatures appear; 7th to 8th level spell slot: 3x as many creatures appear; 9th level spell slot: 4x as many creatures appear	\N	caster summons fey spirits that take the form of beasts and appear in unoccupied spaces caster can see within range. Caster chooses one of the following to appear: 1 beast of CR 2 or lower, 2 beasts of CR 1 or lower, 4 beasts of CR 1/2 or lower, 8 beasts of CR 1/4 or lower. Spirits disappear at 0 HP or when spell ends. Spirits are friendly to caster and casters allies, and roll initiative as a group, which has its own turns; spirits obey verbal commands from caster, that can be given at any time. If no commands are given, spirits will defend themselves from hostile creatures only	f
83	create food and water	other	3	conjuration	action	30 ft	3	instant	f	any	containers or ground	\N	\N	\N	\N	\N	\N	caster creates 45 lbs of food and 30 gallons of water, enough to sustain 15 humanoids or 5 steeds for 24 hrs. Food is bland bu nourishing, and spoils after 24 hrs. Water is clean and does not go bad	f
84	daylight	other	3	evocation	action	60 ft	3	1 hr	f	1	60 ft radius sphere centered around point of casters choice	\N	\N	\N	\N	\N	\N	sphere is bright light and sheds dim light for additional 60 ft. If cast on an object caster is holding or one that is not being worn or carried, light shines from object and moves with it. Completely covering object with opaque object blocks light. If area of effect overlaps with an area of darkness created by a spell of 3rd level or lower, the darkness is dispelled	f
85	dispel magic	other	3	abjuration	action	120 ft	3	instant	f	1	creature, object, or magical effect	\N	\N	\N	\N	when cast with a spell slot above 3rd, this spell automatically ends the effects of a spell on the target if the spells level is <= than the level of the spell slot chosen by the caster	\N	any spell of 3rd level or lower on the target ends. For spells of 4th level or higher on the target, make an ability check on casters spellcasting ability against DC 10+spell level. If successful, spell ends	f
86	gaseous form	control	3	transmutation	action	touch	41	1 hr	t	1	willing creature	\N	\N	\N	\N	\N	\N	Target, along with everything its wearing and carrying, turns into a misty cloud; if target drops to 0 HP, spell ends. Targets only movement as a cloud is a flying speed of 10 ft, and can pass through small holes and cracks, but not liquids; target remains airborne even when stunned or incapacitated. Target can enter and occupy the space of another creature, but cannot talk or manipulate objects; any objects it is carrying or holding cannot be used or dropped, and target cannot attack or cast spells. Target has resistance to nonmagical damage, and has advantage on str, dex, and con saving throws	f
101	tongues	other	3	divination	action	touch	50	1 hr	f	1	creature caster can touch	\N	\N	\N	\N	\N	\N	target can understand any spoken language it can hear; when target speaks, any creature that knows at least 1 language can understand	f
87	glyph or warding	damage	3	abjuration	1 hr	touch	42	until dispelled/triggered	f	1	surface (table, floor, wall) or object that can be closed (scroll, book, chest) that is < 10 ft diameter	dex	half damage	\N	5d8	explosive runes glyph: damage increases by 1d8 for every spell slot above 3rd this is cast at; spell glyph: can store a spell of same level this spell is cast at	\N	if cast on object, object must remain < 10 ft from where spell was cast, or glyph is broken and spell is lost. Glyph is nearly invisible but can be found with Investigation check with DC of spell save. Trigger of glyph is left to choice, but can include (surfaces) touching, standing on, removing object covering, approaching w/in certain distance of the glyph, or manipulating object on which glyph is inscribed; or (within object) opening the object, approaching within a certain distance of the object, and seeing or reading the glyph. Can also be triggered under specific circumstances or according to physical characteristics, creature type, or alignment, and can specify circumstances under which trigger will not happen (like speaking a password). Two types of glyphs, Explosive Runes: glyph does acid, cold, fire, lightning, or thunder damage in sphere of 20 ft radius, or Spell Glyph: store prepared spell of 3rd level or lower on the glyph (spell must target a single creature or an area, and will be cast on or centered around the creature which triggered the glyph). If the Spell requires concentration, it will last until the end of its duration	f
88	magic circle	control	3	abjuration	1 min	10 ft	43	1 hr	f	1	point on ground caster can see	cha	no effect	\N	\N	duration increases by 1 hr for each spell slot above 3rd this is cast at	\N	creates 10 ft radius, 20 ft tall cylinder of magical energy; glowing runes appear where cylinder intersects with another surface. At least one of the following types of creatures (celestials, fey, elementals, fiends, or undead) either: cannot willingly enter cylinder by nonmagical means (must succeed saving throw before attempting with a spell); cannot charm, frighten, or possess those within the cylinder. Can also be cast in reverse direction (confining creatures to the cylinder, and protecting those on outside of it)	f
89	mass healing word	heal	3	evocation	bonus	60 ft	2	instant	f	up to 6	creatures caster can see	\N	\N	\N	1d4+spellcasting ability modifier	healing increases by 1d4 for each spell slot above 3rd this is cast at	\N	no effect on undead or constructs	f
90	meld into stone	other	3	transmutation	action	touch	3	8 hrs	f	1	self	\N	\N	bludgeoning	6d6	\N	\N	caster melds self and all carried equipment into a stone object or surface large enough to fully contain them. Presence not detectably by nonmagical means. Caster cannot see out of stone, and Perception checks for sound have disadvantage, but is aware of passage of time and can cast spells on self. Caster can move out of stone where they entered it, but otherwise cannot move. Partial destruction of stone (or change in its shape) expels caster (caster falls prone in front of stone) and does damage; total destruction deals 50 damage.	t
91	nondetection	other	3	abjuration	action	touch	44	8 hrs	f	1	willing creature, or place or object  <= 10 ft in any dimension	\N	\N	\N	\N	\N	\N	target cannot be targeted by divination magic or perceived through magical scrying sensors	f
92	plant growth (immediate)	other	3	transmutation	action	150 ft	3	instant	f	1	point of choice	\N	\N	\N	\N	\N	\N	spell_id 92, 93 are same spell with 2 effects (Plant Growth). All normal plants in a 100 ft radius become thick and overgrown; creature moving through area has 1/4 movement; can exclude one or more areas	f
93	plant growth (long-term)	other	3	transmutation	8 hrs	150 ft	3	instant	f	all	plants within a half mile	\N	\N	\N	\N	\N	\N	spell_id 92, 93 are same spell with 2 effects (Plant Growth). All plants become enriched for 1 yr and yield 2x amount of food when harvested	f
106	protection from energy	control	3	abjuration	action	touch	3	1 hr	t	1	willing creature	\N	\N	\N	\N	\N	\N	target has resistance to damage type of casters choice, either acid, cold, fire, lightning, or thunder	f
94	remove curse	other	3	abjuration	action	touch	3	instant	f	1	creature or object	\N	\N	\N	\N	\N	\N	all curses affecting target ends; if target is cursed magic item, the curse remains but the spell breaks its owners attunement to object so it can be removed or discarded	f
95	revivify	heal	3	abjuration	action	touch	45	instant	f	1	creature that has died within last min, not from old age	\N	\N	\N	\N	\N	\N	target returns to life with 1 HP. Spell cannot restore missing body parts	f
96	sending	other	3	evocation	action	unlimited	46	1 round	f	1	creature that is familiar to caster	\N	\N	\N	\N	\N	\N	sends message of <= 25 words to target; target hears message in its mind and recognizes caster as sender if it knows you, and can reply in like manner immediately. Spell enables creatures with int scores of at least 1 to understand the meaning of message. Message can be sent across any distance or planes of existence, but 5% chance message will not arrive if being cast across planes	f
97	sleet storm	control	3	conjuration	action	150 ft	47	1 min	t	1	20 ft tall, 40 ft radius cylinder centered around point of casters choice	dex	no effect	\N	\N	\N	11	freezing rain and sleet fall within cylinder; area is heavily obscured and exposed flames are doused. Ground is covered with ice, making it difficult terrain; when creature enters area for first time on a turn or starts its turn there, must make save or fall prone. If creature is concentrating in spells area, must make successful con saving throw against spell save DC or lose concentration	f
98	speak with dead	other	3	necromancy	action	10 ft	48	10 min	f	1	corpse with mouth that is not undead	\N	\N	\N	\N	\N	\N	spell fails if target was target of this spell within last 10 days. Caster can ask corpse up to 5 questions; corpse knows only what it knew in life (including languages). Answers are usually brief, cryptic, or repetitive, and corpse is under no compulsion to answer truthfully; corpse can recognize caster as hostile or an enemy. Spell cannot return creatures soul to its body, only its animating spirit, so corpse cannot learn new information, cannot comprehend anything that has happened since it died, and cannot speculate about future events	f
99	speak with plants	control	3	transmutation	action	self	3	10 min	f	all	plants within 30 ft radius of caster	\N	\N	\N	\N	\N	\N	plants can communicate with caster and follow casters simple commands (though caster gains no ability to influence plants); plants can communicate events in spells area within last day, such as creatures that have passed, weather, etc. Caster can turn difficult terrain due to plant growth to ordinary terrain for the duration of spell, and vice versa. Plants cannot uproot themselves and move about, but can move branches, tendrils, and stalks; this spell can cause plants created by entangled spell to release creature	f
100	spirit guardians	control	3	conjuration	action	self	49	10 min	t	1	self	wis	half damage	radiant	3d8	1d8 additional damage for each spell slot above 3rd this is cast at	\N	caster calls forth spirits to protect them. Spirits flit around caster to a distance of 15 ft; if caster is good or neutral, spirits appear angelic or fey; if caster is evil, they appear fiendish. Caster can designate any number of creatures they see to be unaffected by it. An affected creatures speed is halved in area, and must make save or take damage; if caster is evil, damage taken is necrotic	f
102	water breathing	other	3	transmutation	action	30 ft	51	24 hrs	f	up to 10	willing creatures caster can see	\N	\N	\N	\N	\N	\N	targets gain ability to breathe underwater, using normal means of respiration	t
103	water walk	other	3	transmutation	action	30 ft	52	1 hr	f	up to 10	willing creatures caster can see	\N	\N	\N	\N	\N	\N	targets can move across any liquid surface (water, lava, snow, acid, quicksand, mud) as if it were solid land; moving across lava still causes target to take heat damage. If spell is cast on target submerged under liquid, target is propelled towards surface at rate of 60 ft per round	t
104	wind wall	damage	3	evocation	action	120 ft	53	1 min	t	1	point of casters choice	str	half damage	bludgeoning	3d8	\N	\N	wall of strong wind rises from ground, up to 50 ft long, 15 ft high, 1 ft thick, shaped any way as long as it remains in contact with ground. Fog, smoke, creatures in gaseous form, and other gases are kept at bay, along with small flying creatures or objects. Arrows, bolts, and ordinary projectiles launched at targets behind wall are deflected upwards and automatically miss. Larger objects (boulders hurled by giants or siege engines) are unaffected	f
105	vampiric touch	heal and damage	3	necromancy	action	touch	3	1 min	t	1	creature within reach	\N	\N	necrotic	3d6	1d6 additional damage for each spell slot above 3rd this is cast at	\N	touch of shadow-wreathed hand siphons life force from others to heal casters wounds. Caster gains half of damage dealt, and can make attack again on each of their turns as an action	f
109	conjure minor elementals	other	4	conjuration	action	90 ft	3	1 hr	t	1	unoccupied space caster can see	\N	\N	\N	\N	6th level spell slot: 2x as many creatures appear; 8th level spell slot: 3x as many creatures appear	\N	Casters choice of one of the following appears: 1 elemental of CR <=2, 2 elementals of CR <= 1, 4 elementals of CR <= 1/2, 8 elementals of CR <= 1/4. A summon disappears when it drops to 0 HP or when spell ends. Creatures are friendly to caster and casters companions; initiative is rolled as a group that has its own turns. They obey verbal commands issued by caster (no action needed), and automatically defend themselves from hostile creatures	f
110	conjure woodland beings	other	4	conjuration	action	60 ft	54	1 hr	t	1	unoccupied space caster can see	\N	\N	\N	\N	6th level spell slot: 2x as many creatures appear; 8th level spell slot: 3x as many creatures appear	\N	Casters choice of one of the following appears: 1 fey of CR <=2, 2 fey of CR <= 1, 4 fey of CR <= 1/2, 8 fey of CR <= 1/4. A summon disappears when it drops to 0 HP or when spell ends. Creatures are friendly to caster and casters companions; initiative is rolled as a group that has its own turns. They obey verbal commands issued by caster (no action needed), and automatically defend themselves from hostile creatures	f
131	conjure elemental	other	5	conjuration	1 min	90 ft	55	1 hr	t	1	10 ft cube within range	\N	\N	\N	\N	CR increases by 1 for each spell slot above 5th this spell is cast at	\N	Summon air, earth, fire, or water elemental of CR 5 or lower; elemental must appear next to its element of choice: fire elemental comes from bonfire, water elemental emerges from pond, etc. Elemental disappears when it drops to 0 HP or spell ends; it takes its own initiative and obeys verbal commands from caster (no action needed). If no commands are given, it will defend itself from hostile creatures only. If concentration is broken, caster loses control of elemental and it becomes hostile toward caster and their companions. An uncontrolled elemental cannot be dismissed by caster, but disappears after 1 hr	f
148	conjure fey	other	6	conjuration	1 min	90 ft	3	1 hr	t	1	unoccupied space caster can see	\N	\N	\N	\N	CR rating increases by 1 for every spell slot above 6th this spell is cast at	\N	Summon fey creature (or fey creature that takes the form of a beast) of CR 6 or lower. Fey creature disappears when it drops to 0 HP or when the spell ends. The creature has its own initiative and has its own turns. The creature is friendly to the caster and their allies and obeys verbal commands given by the caster (no action needed). If no commands are given, the creature defends itself against hostile enemies. If the casters concentration is broken, the creature becomes uncontrolled and turns hostile towards caster and their allies. An uncontrolled creature cannot be dismissed, but disappears after 1 hour	f
149	create undead	other	6	necromancy	1 min	10 ft	56	instant	f	up to 3	corpses of Medium or Small humanoids	\N	\N	\N	\N	7th level spell slot: can animate or reassert control over 4 ghouls; 8th level spell slot: can animate or reassert control over 5 ghouls or 2 ghasts or wights; 9th level spell slot: can animate or reassert control over 6 ghouls, 3 ghasts or wights, or 2 mummies	\N	This spell can only be cast at night. Each target becomes a ghoul under the casters control. Caster can mentally command any creature animated with this spell as long as creature is within 120 ft of caster; if multiple creatures are controlled, commands can be issued to all as a group. Caster decides what action the creature will take and where it will move on the next turn, or issue a general command (such as to guard a particular door). If no commands are issued, creature will defend itself against hostile enemies. Creature will follow its order until its task is complete. Creature is under casters control for 24 hours, after which it stops obeying commands issued to it. To maintain control, caster must recast this spell before the current 24 hour period ends	f
163	conjure celestial	other	7	conjuration	1 min	90 ft	3	1 hr	t	1	unoccupied space caster can see	\N	\N	\N	\N	9th level spell slot: can summon a celestial of CR <= 5	\N	Caster summons celestial, which disappears if it drops to 0 HP or when the spell ends. Celestial is friendly toward caster and their allies; celestial has its own initiative and turns. It obeys any verbal commands issued by caster (no action needed), as long as to orders do not violate its alignment. If no commands are given, celestial will defend itself from hostile creatures	f
27	false life	heal	1	necromancy	action	self	14	1 hr	f	1	self	\N	\N	\N	1d4	gain 5 temp HP more for every spell slot his is cast at above 1st	\N	gained as temp HP	f
\.


--
-- Data for Name: subclasses; Type: TABLE DATA; Schema: public; Owner: spooky
--

COPY public.subclasses (subclass_id, baseclass_id, subclass_name) FROM stdin;
1	1	college of lore
2	1	college of valor
3	2	death domain
4	2	grave domain
5	2	knowledge domain
6	2	life domain
7	2	light domain
8	2	nature domain
9	2	tempest domain
10	2	trickery domain
11	2	war domain
12	3	land: arctic
13	3	land: coast
14	3	land: desert
15	3	land: forest
16	3	land: grassland
17	3	land: mountain
18	3	land: swamp
19	3	land: underdark
20	3	circle of the moon
21	4	eldritch knight
23	6	oath of devotion
24	6	oath of the ancients
25	6	oath of vengeance
26	7	hunter
27	7	beast master
28	8	arcane trickster
29	9	draconic bloodline
30	9	wild magic
31	10	archfey patron
32	10	fiend patron
33	10	great old one patron
34	11	abjuration
35	11	conjuration
36	11	divination
37	11	enchantment
38	11	evocation
39	11	illusion
40	11	necromancy
41	11	transmutation
42	3	circle of spores
\.


--
-- Data for Name: subclassspelllist; Type: TABLE DATA; Schema: public; Owner: spooky
--

COPY public.subclassspelllist (subclass_id, spell_id) FROM stdin;
42	76
42	77
42	86
28	1
28	2
28	3
28	4
28	5
28	6
28	7
28	8
28	9
28	10
28	11
28	12
28	13
28	14
28	15
28	16
28	17
28	18
28	19
28	20
28	21
28	22
28	23
28	24
28	25
28	26
28	27
28	28
28	29
28	30
28	31
28	32
28	33
28	34
28	35
28	36
28	37
28	38
28	39
28	40
28	41
28	42
28	43
28	44
28	45
28	46
28	47
28	48
28	49
28	50
28	51
28	52
28	53
28	54
28	55
28	56
28	57
28	58
28	60
28	61
28	62
28	63
28	64
28	65
28	66
28	67
28	68
28	69
28	70
28	71
28	72
28	73
28	74
28	75
28	76
28	77
28	78
28	79
28	80
28	81
28	82
28	83
28	84
28	85
28	86
28	87
28	88
28	89
28	90
28	91
28	92
28	93
28	94
28	95
28	96
28	97
28	98
28	99
28	100
28	101
28	102
28	103
28	104
28	105
21	1
21	2
21	3
21	4
21	5
21	6
21	7
21	8
21	9
21	10
21	11
21	12
21	13
21	14
21	15
21	16
21	17
21	18
21	19
21	20
21	21
21	22
21	23
21	24
21	25
21	26
21	27
21	28
21	29
21	30
21	31
21	32
21	33
21	34
21	35
21	36
21	37
21	38
21	39
21	40
21	41
21	42
21	43
21	44
21	45
21	46
21	47
21	48
21	49
21	50
21	51
21	52
21	53
21	54
21	55
21	56
21	57
21	58
21	60
21	61
21	62
21	63
21	64
21	65
21	66
21	67
21	68
21	69
21	70
21	71
21	72
21	73
21	74
21	75
21	76
21	77
21	78
21	79
21	80
21	81
21	82
21	83
21	84
21	85
21	86
21	87
21	88
21	89
21	90
21	91
21	92
21	93
21	94
21	95
21	96
21	97
21	98
21	99
21	100
21	101
21	102
21	103
21	104
21	105
21	109
21	110
28	109
28	110
3	6
3	11
3	27
3	39
3	48
3	49
3	76
3	77
3	105
42	60
\.


--
-- Name: classes classes_name_key; Type: CONSTRAINT; Schema: public; Owner: spooky
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_name_key UNIQUE (name);


--
-- Name: classes classes_pkey; Type: CONSTRAINT; Schema: public; Owner: spooky
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (class_id);


--
-- Name: classspelllist classspelllist_pkey; Type: CONSTRAINT; Schema: public; Owner: spooky
--

ALTER TABLE ONLY public.classspelllist
    ADD CONSTRAINT classspelllist_pkey PRIMARY KEY (class_id, spell_id);


--
-- Name: components components_pkey; Type: CONSTRAINT; Schema: public; Owner: spooky
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT components_pkey PRIMARY KEY (comp_id);


--
-- Name: conditions conditions_name_key; Type: CONSTRAINT; Schema: public; Owner: spooky
--

ALTER TABLE ONLY public.conditions
    ADD CONSTRAINT conditions_name_key UNIQUE (name);


--
-- Name: conditions conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: spooky
--

ALTER TABLE ONLY public.conditions
    ADD CONSTRAINT conditions_pkey PRIMARY KEY (cond_id);


--
-- Name: spells spells_name_key; Type: CONSTRAINT; Schema: public; Owner: spooky
--

ALTER TABLE ONLY public.spells
    ADD CONSTRAINT spells_name_key UNIQUE (name);


--
-- Name: spells spells_pkey; Type: CONSTRAINT; Schema: public; Owner: spooky
--

ALTER TABLE ONLY public.spells
    ADD CONSTRAINT spells_pkey PRIMARY KEY (spell_id);


--
-- Name: subclasses subclasses_pkey; Type: CONSTRAINT; Schema: public; Owner: spooky
--

ALTER TABLE ONLY public.subclasses
    ADD CONSTRAINT subclasses_pkey PRIMARY KEY (subclass_id);


--
-- Name: subclasses subclasses_subclass_name_key; Type: CONSTRAINT; Schema: public; Owner: spooky
--

ALTER TABLE ONLY public.subclasses
    ADD CONSTRAINT subclasses_subclass_name_key UNIQUE (subclass_name);


--
-- Name: subclassspelllist subclassspelllist_pkey; Type: CONSTRAINT; Schema: public; Owner: spooky
--

ALTER TABLE ONLY public.subclassspelllist
    ADD CONSTRAINT subclassspelllist_pkey PRIMARY KEY (subclass_id, spell_id);


--
-- Name: classspelllist classspelllist_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: spooky
--

ALTER TABLE ONLY public.classspelllist
    ADD CONSTRAINT classspelllist_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(class_id) ON DELETE CASCADE;


--
-- Name: classspelllist classspelllist_spell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: spooky
--

ALTER TABLE ONLY public.classspelllist
    ADD CONSTRAINT classspelllist_spell_id_fkey FOREIGN KEY (spell_id) REFERENCES public.spells(spell_id) ON DELETE CASCADE;


--
-- Name: spells spells_comp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: spooky
--

ALTER TABLE ONLY public.spells
    ADD CONSTRAINT spells_comp_id_fkey FOREIGN KEY (comp_id) REFERENCES public.components(comp_id);


--
-- Name: spells spells_cond_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: spooky
--

ALTER TABLE ONLY public.spells
    ADD CONSTRAINT spells_cond_id_fkey FOREIGN KEY (cond_id) REFERENCES public.conditions(cond_id);


--
-- Name: subclasses subclasses_baseclass_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: spooky
--

ALTER TABLE ONLY public.subclasses
    ADD CONSTRAINT subclasses_baseclass_id_fkey FOREIGN KEY (baseclass_id) REFERENCES public.classes(class_id) ON DELETE CASCADE;


--
-- Name: subclassspelllist subclassspelllist_spell_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: spooky
--

ALTER TABLE ONLY public.subclassspelllist
    ADD CONSTRAINT subclassspelllist_spell_id_fkey FOREIGN KEY (spell_id) REFERENCES public.spells(spell_id) ON DELETE CASCADE;


--
-- Name: subclassspelllist subclassspelllist_subclass_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: spooky
--

ALTER TABLE ONLY public.subclassspelllist
    ADD CONSTRAINT subclassspelllist_subclass_id_fkey FOREIGN KEY (subclass_id) REFERENCES public.subclasses(subclass_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

