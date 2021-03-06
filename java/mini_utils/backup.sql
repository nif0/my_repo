PGDMP         3                w            testdb1     11.2 (Ubuntu 11.2-1.pgdg18.04+1)    11.2 �    G           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            H           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            I           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            J           1262    16386    testdb1    DATABASE     �   CREATE DATABASE testdb1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'ru_RU.UTF-8' LC_CTYPE = 'ru_RU.UTF-8' TABLESPACE = test_database1;
    DROP DATABASE testdb1;
             postgres    false            K           0    0    DATABASE testdb1    ACL     /   GRANT ALL ON DATABASE testdb1 TO user_testdb1;
                  postgres    false    3146                        2615    16388    test    SCHEMA        CREATE SCHEMA test;
    DROP SCHEMA test;
             user_testdb1    false            �            1255    17039 B   create_access_level(character varying, character varying, integer) 	   PROCEDURE     V  CREATE PROCEDURE test.create_access_level(level_name character varying, comment character varying DEFAULT NULL::character varying, parrent_level integer DEFAULT NULL::integer)
    LANGUAGE plpgsql
    AS $$
begin
  insert into test.access_level(name,comment,parrent_id) 
                  values  (level_name,comment,parrent_level);
end;
$$;
 y   DROP PROCEDURE test.create_access_level(level_name character varying, comment character varying, parrent_level integer);
       test       user_testdb1    false    7            �            1255    17048    delete_access_level(integer) 	   PROCEDURE     �   CREATE PROCEDURE test.delete_access_level(acc_acc_id integer)
    LANGUAGE plpgsql
    AS $$
begin
  delete from test.access_level al where al.acc_id = acc_acc_id;
end;
$$;
 =   DROP PROCEDURE test.delete_access_level(acc_acc_id integer);
       test       user_testdb1    false    7            �            1259    16580    user_access_level    TABLE     �   CREATE TABLE public.user_access_level (
    acc_acc_id integer NOT NULL,
    usr_usr_id integer,
    usac_id integer,
    start_date date,
    end_date date,
    navi_user integer,
    usersusr_id integer NOT NULL
);
 %   DROP TABLE public.user_access_level;
       public         user_testdb1    false            �            1259    16397    users    TABLE     Q  CREATE TABLE public.users (
    usr_id integer NOT NULL,
    nickname character varying(255),
    login character varying(20) NOT NULL,
    password_hash character varying(255),
    reg_date date NOT NULL,
    access_level integer NOT NULL,
    last_act_date date,
    lock_status boolean DEFAULT false NOT NULL,
    delete_date date
);
    DROP TABLE public.users;
       public         user_testdb1    false            L           0    0    TABLE users    COMMENT     u   COMMENT ON TABLE public.users IS 'Пользователи системы. Обычные и внутренние.';
            public       user_testdb1    false    199            �            1259    16395    users_usr_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_usr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.users_usr_id_seq;
       public       user_testdb1    false    199            M           0    0    users_usr_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.users_usr_id_seq OWNED BY public.users.usr_id;
            public       user_testdb1    false    198            �            1259    16677    work_shedule    TABLE     �   CREATE TABLE public.work_shedule (
    loc_loc_id integer NOT NULL,
    weekday integer NOT NULL,
    work_time_start time(6) without time zone,
    work_time_stop time(6) without time zone,
    workshed_id integer NOT NULL
);
     DROP TABLE public.work_shedule;
       public         user_testdb1    false            N           0    0    TABLE work_shedule    COMMENT     ^   COMMENT ON TABLE public.work_shedule IS 'Рабочее расписание локаций';
            public       user_testdb1    false    230            �            1259    16675    work_shedule_workshed_id_seq    SEQUENCE     �   CREATE SEQUENCE public.work_shedule_workshed_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.work_shedule_workshed_id_seq;
       public       user_testdb1    false    230            O           0    0    work_shedule_workshed_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.work_shedule_workshed_id_seq OWNED BY public.work_shedule.workshed_id;
            public       user_testdb1    false    229            �            1259    16467    access_level    TABLE     �   CREATE TABLE test.access_level (
    acc_id integer NOT NULL,
    name character varying(255) NOT NULL,
    comment character varying(255),
    parrent_id integer
);
    DROP TABLE test.access_level;
       test         user_testdb1    false    7            P           0    0    TABLE access_level    COMMENT     E   COMMENT ON TABLE test.access_level IS 'уровни доступа';
            test       user_testdb1    false    204            �            1259    16465    access_level_acc_id_seq    SEQUENCE     �   CREATE SEQUENCE test.access_level_acc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE test.access_level_acc_id_seq;
       test       user_testdb1    false    204    7            Q           0    0    access_level_acc_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE test.access_level_acc_id_seq OWNED BY test.access_level.acc_id;
            test       user_testdb1    false    203            �            1259    16425 
   activities    TABLE       CREATE TABLE test.activities (
    act_id integer NOT NULL,
    name character varying(255) NOT NULL,
    description jsonb,
    start_time date NOT NULL,
    end_time date NOT NULL,
    despat_despat_id integer NOT NULL,
    loc_loc_id integer,
    parrent_act_id integer NOT NULL
);
    DROP TABLE test.activities;
       test         user_testdb1    false    7            R           0    0    TABLE activities    COMMENT     i   COMMENT ON TABLE test.activities IS 'различные акции, меропириятия и т.п.';
            test       user_testdb1    false    202            S           0    0 "   COLUMN activities.despat_despat_id    COMMENT     _   COMMENT ON COLUMN test.activities.despat_despat_id IS 'ссылка на description_pattern';
            test       user_testdb1    false    202            �            1259    16597    activities_feedback    TABLE       CREATE TABLE test.activities_feedback (
    act_act_id integer NOT NULL,
    usr_usr_id integer NOT NULL,
    date date NOT NULL,
    usr_rating integer,
    text character varying(255),
    acfeed_id integer NOT NULL,
    feedback_rating integer,
    parent_id integer
);
 %   DROP TABLE test.activities_feedback;
       test         user_testdb1    false    7            T           0    0    TABLE activities_feedback    COMMENT     r   COMMENT ON TABLE test.activities_feedback IS 'Отзывы и оценки по различным акциям';
            test       user_testdb1    false    222            �            1259    16595 !   activities_feedback_acfeed_id_seq    SEQUENCE     �   CREATE SEQUENCE test.activities_feedback_acfeed_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE test.activities_feedback_acfeed_id_seq;
       test       user_testdb1    false    222    7            U           0    0 !   activities_feedback_acfeed_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE test.activities_feedback_acfeed_id_seq OWNED BY test.activities_feedback.acfeed_id;
            test       user_testdb1    false    221            �            1259    17051    commentaries    TABLE     �   CREATE TABLE test.commentaries (
    com_id integer NOT NULL,
    act_act_id integer,
    soc_soc_id integer,
    usr_usr_id integer,
    loc_loc_id integer,
    text text,
    com_com_id integer
);
    DROP TABLE test.commentaries;
       test         user_testdb1    false    7            V           0    0    TABLE commentaries    COMMENT     V   COMMENT ON TABLE test.commentaries IS 'комментарии к сущностям';
            test       user_testdb1    false    234            W           0    0    COLUMN commentaries.com_id    COMMENT     I   COMMENT ON COLUMN test.commentaries.com_id IS 'id коментария';
            test       user_testdb1    false    234            X           0    0    COLUMN commentaries.act_act_id    COMMENT     M   COMMENT ON COLUMN test.commentaries.act_act_id IS 'id активности';
            test       user_testdb1    false    234            Y           0    0    COLUMN commentaries.soc_soc_id    COMMENT     ^   COMMENT ON COLUMN test.commentaries.soc_soc_id IS 'код социальной группы';
            test       user_testdb1    false    234            Z           0    0    COLUMN commentaries.usr_usr_id    COMMENT     Q   COMMENT ON COLUMN test.commentaries.usr_usr_id IS 'id пользователя';
            test       user_testdb1    false    234            [           0    0    COLUMN commentaries.loc_loc_id    COMMENT     K   COMMENT ON COLUMN test.commentaries.loc_loc_id IS 'код локации';
            test       user_testdb1    false    234            \           0    0    COLUMN commentaries.text    COMMENT     Q   COMMENT ON COLUMN test.commentaries.text IS 'текст комментария';
            test       user_testdb1    false    234            ]           0    0    COLUMN commentaries.com_com_id    COMMENT     O   COMMENT ON COLUMN test.commentaries.com_com_id IS 'id комментария';
            test       user_testdb1    false    234            �            1259    17049    commentaries_com_id_seq    SEQUENCE     �   CREATE SEQUENCE test.commentaries_com_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE test.commentaries_com_id_seq;
       test       user_testdb1    false    7    234            ^           0    0    commentaries_com_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE test.commentaries_com_id_seq OWNED BY test.commentaries.com_id;
            test       user_testdb1    false    233            �            1259    16484    description_pattern    TABLE     �   CREATE TABLE test.description_pattern (
    name character varying(255) NOT NULL,
    despat_id integer NOT NULL,
    parrent_id integer,
    json_pattern jsonb
);
 %   DROP TABLE test.description_pattern;
       test         user_testdb1    false    7            _           0    0    TABLE description_pattern    COMMENT     ]   COMMENT ON TABLE test.description_pattern IS 'хранит шаблоны описаний';
            test       user_testdb1    false    206            �            1259    16482 !   description_pattern_despat_id_seq    SEQUENCE     �   CREATE SEQUENCE test.description_pattern_despat_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE test.description_pattern_despat_id_seq;
       test       user_testdb1    false    7    206            `           0    0 !   description_pattern_despat_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE test.description_pattern_despat_id_seq OWNED BY test.description_pattern.despat_id;
            test       user_testdb1    false    205            �            1259    16624    location_feedback    TABLE       CREATE TABLE test.location_feedback (
    loc_loc_id integer NOT NULL,
    usr_usr_id integer NOT NULL,
    date date NOT NULL,
    usr_rating integer,
    text character varying(255),
    locfeed_id integer NOT NULL,
    feedback_rating integer,
    parrent_id integer
);
 #   DROP TABLE test.location_feedback;
       test         user_testdb1    false    7            a           0    0    TABLE location_feedback    COMMENT     p   COMMENT ON TABLE test.location_feedback IS 'Хранит отызывы и оценки по локациям';
            test       user_testdb1    false    228            �            1259    16622     location_feedback_locfeed_id_seq    SEQUENCE     �   CREATE SEQUENCE test.location_feedback_locfeed_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE test.location_feedback_locfeed_id_seq;
       test       user_testdb1    false    7    228            b           0    0     location_feedback_locfeed_id_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE test.location_feedback_locfeed_id_seq OWNED BY test.location_feedback.locfeed_id;
            test       user_testdb1    false    227            �            1259    16515 	   locations    TABLE     �   CREATE TABLE test.locations (
    loc_id integer NOT NULL,
    geo_point point,
    address character varying(255) NOT NULL,
    name character varying(255),
    description bytea,
    despat_despat_id integer NOT NULL
);
    DROP TABLE test.locations;
       test         user_testdb1    false    7            c           0    0    TABLE locations    COMMENT       COMMENT ON TABLE test.locations IS 'Какие-то места. Это межет быть здание, офис, квартира или площаь. В общем, это какое-то место на карте, с описанием как до него добраться';
            test       user_testdb1    false    208            d           0    0    COLUMN locations.geo_point    COMMENT     U   COMMENT ON COLUMN test.locations.geo_point IS 'gps координаты места';
            test       user_testdb1    false    208            e           0    0    COLUMN locations.address    COMMENT     >   COMMENT ON COLUMN test.locations.address IS 'аддресс';
            test       user_testdb1    false    208            f           0    0    COLUMN locations.description    COMMENT     n   COMMENT ON COLUMN test.locations.description IS 'карточка заведения в json формате';
            test       user_testdb1    false    208            �            1259    16513    locations_loc_id_seq    SEQUENCE     �   CREATE SEQUENCE test.locations_loc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE test.locations_loc_id_seq;
       test       user_testdb1    false    7    208            g           0    0    locations_loc_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE test.locations_loc_id_seq OWNED BY test.locations.loc_id;
            test       user_testdb1    false    207            �            1259    16563    module    TABLE     �   CREATE TABLE test.module (
    mod_id integer NOT NULL,
    name character varying(255) NOT NULL,
    bin bytea NOT NULL,
    description character varying(255)
);
    DROP TABLE test.module;
       test         user_testdb1    false    7            h           0    0    TABLE module    COMMENT     �   COMMENT ON TABLE test.module IS 'програмные модули. Рассчитано на то, что в этой таблице они будут храниться и из неё же загражаться при необходимости.';
            test       user_testdb1    false    214            �            1259    16561    module_mod_id_seq    SEQUENCE     �   CREATE SEQUENCE test.module_mod_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE test.module_mod_id_seq;
       test       user_testdb1    false    214    7            i           0    0    module_mod_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE test.module_mod_id_seq OWNED BY test.module.mod_id;
            test       user_testdb1    false    213            �            1259    16605 
   operations    TABLE     �   CREATE TABLE test.operations (
    oper_id integer NOT NULL,
    name integer NOT NULL,
    mod_mod_id integer NOT NULL,
    argument_list bytea,
    result character varying(255)
);
    DROP TABLE test.operations;
       test         user_testdb1    false    7            j           0    0    TABLE operations    COMMENT     T   COMMENT ON TABLE test.operations IS 'процедуры бизнес-модели';
            test       user_testdb1    false    224            �            1259    16616    operations_access_levels    TABLE     �   CREATE TABLE test.operations_access_levels (
    oper_oper_id integer NOT NULL,
    acc_acc_id integer NOT NULL,
    opac_id integer NOT NULL
);
 *   DROP TABLE test.operations_access_levels;
       test         user_testdb1    false    7            k           0    0    TABLE operations_access_levels    COMMENT     x   COMMENT ON TABLE test.operations_access_levels IS 'связывает уровни доступа и операции';
            test       user_testdb1    false    226            �            1259    16614 $   operations_access_levels_opac_id_seq    SEQUENCE     �   CREATE SEQUENCE test.operations_access_levels_opac_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE test.operations_access_levels_opac_id_seq;
       test       user_testdb1    false    226    7            l           0    0 $   operations_access_levels_opac_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE test.operations_access_levels_opac_id_seq OWNED BY test.operations_access_levels.opac_id;
            test       user_testdb1    false    225            �            1259    16603    operations_oper_id_seq    SEQUENCE     �   CREATE SEQUENCE test.operations_oper_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE test.operations_oper_id_seq;
       test       user_testdb1    false    7    224            m           0    0    operations_oper_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE test.operations_oper_id_seq OWNED BY test.operations.oper_id;
            test       user_testdb1    false    223            �            1259    16526 
   parameters    TABLE     R  CREATE TABLE test.parameters (
    prmt_id integer NOT NULL,
    name character varying(255) NOT NULL,
    comment integer,
    number_value numeric(19,0) DEFAULT NULL::numeric,
    string_value integer,
    char_value character varying(1) DEFAULT NULL::character varying,
    json_value text,
    xml_value text,
    blob_value bytea
);
    DROP TABLE test.parameters;
       test         user_testdb1    false    7            �            1259    16524    parameters_prmt_id_seq    SEQUENCE     �   CREATE SEQUENCE test.parameters_prmt_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE test.parameters_prmt_id_seq;
       test       user_testdb1    false    7    210            n           0    0    parameters_prmt_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE test.parameters_prmt_id_seq OWNED BY test.parameters.prmt_id;
            test       user_testdb1    false    209            �            1259    16541    social    TABLE     �   CREATE TABLE test.social (
    soc_id integer NOT NULL,
    name integer NOT NULL,
    comment character varying(255),
    prmt_list character varying(255),
    description integer,
    despat_despat_id integer
);
    DROP TABLE test.social;
       test         user_testdb1    false    7            o           0    0    TABLE social    COMMENT     X   COMMENT ON TABLE test.social IS 'различные социальные группы';
            test       user_testdb1    false    212            �            1259    16588    social_approved_activities    TABLE     �   CREATE TABLE test.social_approved_activities (
    act_act_id integer NOT NULL,
    insert_user integer NOT NULL,
    insert_date date NOT NULL,
    comment character varying(255),
    soc_soc_id integer NOT NULL,
    saac_id integer NOT NULL
);
 ,   DROP TABLE test.social_approved_activities;
       test         user_testdb1    false    7            �            1259    16586 &   social_approved_activities_saac_id_seq    SEQUENCE     �   CREATE SEQUENCE test.social_approved_activities_saac_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE test.social_approved_activities_saac_id_seq;
       test       user_testdb1    false    220    7            p           0    0 &   social_approved_activities_saac_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE test.social_approved_activities_saac_id_seq OWNED BY test.social_approved_activities.saac_id;
            test       user_testdb1    false    219            �            1259    16574    social_approved_locations    TABLE     &  CREATE TABLE test.social_approved_locations (
    loc_loc_id integer NOT NULL,
    insert_user integer NOT NULL,
    insert_date date NOT NULL,
    comment character varying(255),
    soc_soc_id integer NOT NULL,
    soap_id integer NOT NULL,
    end_date date,
    history integer NOT NULL
);
 +   DROP TABLE test.social_approved_locations;
       test         user_testdb1    false    7            q           0    0    TABLE social_approved_locations    COMMENT     �   COMMENT ON TABLE test.social_approved_locations IS 'Отметки об одобрении локаций какой-либо социальной группой.';
            test       user_testdb1    false    216            �            1259    16572 %   social_approved_locations_soap_id_seq    SEQUENCE     �   CREATE SEQUENCE test.social_approved_locations_soap_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 :   DROP SEQUENCE test.social_approved_locations_soap_id_seq;
       test       user_testdb1    false    7    216            r           0    0 %   social_approved_locations_soap_id_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE test.social_approved_locations_soap_id_seq OWNED BY test.social_approved_locations.soap_id;
            test       user_testdb1    false    215            �            1259    16539    social_soc_id_seq    SEQUENCE     �   CREATE SEQUENCE test.social_soc_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE test.social_soc_id_seq;
       test       user_testdb1    false    212    7            s           0    0    social_soc_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE test.social_soc_id_seq OWNED BY test.social.soc_id;
            test       user_testdb1    false    211            �            1259    16389    test    TABLE     *   CREATE TABLE test.test (
    text text
);
    DROP TABLE test.test;
       test         user_testdb1    false    7            �            1259    16583    user_access_level    TABLE     �   CREATE TABLE test.user_access_level (
    acc_acc_id integer NOT NULL,
    usr_usr_id integer,
    usac_id integer,
    start_date date,
    end_date date,
    navi_user integer,
    usersusr_id integer NOT NULL
);
 #   DROP TABLE test.user_access_level;
       test         user_testdb1    false    7            �            1259    16413    users    TABLE     O  CREATE TABLE test.users (
    usr_id integer NOT NULL,
    nickname character varying(255),
    login character varying(20) NOT NULL,
    password_hash character varying(255),
    reg_date date NOT NULL,
    access_level integer NOT NULL,
    last_act_date date,
    lock_status boolean DEFAULT false NOT NULL,
    delete_date date
);
    DROP TABLE test.users;
       test         user_testdb1    false    7            �            1259    16411    users_usr_id_seq    SEQUENCE     �   CREATE SEQUENCE test.users_usr_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE test.users_usr_id_seq;
       test       user_testdb1    false    7    201            t           0    0    users_usr_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE test.users_usr_id_seq OWNED BY test.users.usr_id;
            test       user_testdb1    false    200            �            1259    16711    work_shedule    TABLE     �   CREATE TABLE test.work_shedule (
    loc_loc_id integer NOT NULL,
    weekday integer NOT NULL,
    work_time_start time(6) without time zone,
    work_time_stop time(6) without time zone,
    workshed_id integer NOT NULL
);
    DROP TABLE test.work_shedule;
       test         user_testdb1    false    7            u           0    0    TABLE work_shedule    COMMENT     \   COMMENT ON TABLE test.work_shedule IS 'Рабочее расписание локаций';
            test       user_testdb1    false    232            �            1259    16709    work_shedule_workshed_id_seq    SEQUENCE     �   CREATE SEQUENCE test.work_shedule_workshed_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE test.work_shedule_workshed_id_seq;
       test       user_testdb1    false    7    232            v           0    0    work_shedule_workshed_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE test.work_shedule_workshed_id_seq OWNED BY test.work_shedule.workshed_id;
            test       user_testdb1    false    231            L           2604    16400    users usr_id    DEFAULT     l   ALTER TABLE ONLY public.users ALTER COLUMN usr_id SET DEFAULT nextval('public.users_usr_id_seq'::regclass);
 ;   ALTER TABLE public.users ALTER COLUMN usr_id DROP DEFAULT;
       public       user_testdb1    false    198    199    199            ^           2604    16680    work_shedule workshed_id    DEFAULT     �   ALTER TABLE ONLY public.work_shedule ALTER COLUMN workshed_id SET DEFAULT nextval('public.work_shedule_workshed_id_seq'::regclass);
 G   ALTER TABLE public.work_shedule ALTER COLUMN workshed_id DROP DEFAULT;
       public       user_testdb1    false    230    229    230            P           2604    16470    access_level acc_id    DEFAULT     v   ALTER TABLE ONLY test.access_level ALTER COLUMN acc_id SET DEFAULT nextval('test.access_level_acc_id_seq'::regclass);
 @   ALTER TABLE test.access_level ALTER COLUMN acc_id DROP DEFAULT;
       test       user_testdb1    false    204    203    204            Z           2604    16600    activities_feedback acfeed_id    DEFAULT     �   ALTER TABLE ONLY test.activities_feedback ALTER COLUMN acfeed_id SET DEFAULT nextval('test.activities_feedback_acfeed_id_seq'::regclass);
 J   ALTER TABLE test.activities_feedback ALTER COLUMN acfeed_id DROP DEFAULT;
       test       user_testdb1    false    222    221    222            `           2604    17054    commentaries com_id    DEFAULT     v   ALTER TABLE ONLY test.commentaries ALTER COLUMN com_id SET DEFAULT nextval('test.commentaries_com_id_seq'::regclass);
 @   ALTER TABLE test.commentaries ALTER COLUMN com_id DROP DEFAULT;
       test       user_testdb1    false    233    234    234            Q           2604    16487    description_pattern despat_id    DEFAULT     �   ALTER TABLE ONLY test.description_pattern ALTER COLUMN despat_id SET DEFAULT nextval('test.description_pattern_despat_id_seq'::regclass);
 J   ALTER TABLE test.description_pattern ALTER COLUMN despat_id DROP DEFAULT;
       test       user_testdb1    false    205    206    206            ]           2604    16627    location_feedback locfeed_id    DEFAULT     �   ALTER TABLE ONLY test.location_feedback ALTER COLUMN locfeed_id SET DEFAULT nextval('test.location_feedback_locfeed_id_seq'::regclass);
 I   ALTER TABLE test.location_feedback ALTER COLUMN locfeed_id DROP DEFAULT;
       test       user_testdb1    false    228    227    228            R           2604    16518    locations loc_id    DEFAULT     p   ALTER TABLE ONLY test.locations ALTER COLUMN loc_id SET DEFAULT nextval('test.locations_loc_id_seq'::regclass);
 =   ALTER TABLE test.locations ALTER COLUMN loc_id DROP DEFAULT;
       test       user_testdb1    false    207    208    208            W           2604    16566    module mod_id    DEFAULT     j   ALTER TABLE ONLY test.module ALTER COLUMN mod_id SET DEFAULT nextval('test.module_mod_id_seq'::regclass);
 :   ALTER TABLE test.module ALTER COLUMN mod_id DROP DEFAULT;
       test       user_testdb1    false    214    213    214            [           2604    16608    operations oper_id    DEFAULT     t   ALTER TABLE ONLY test.operations ALTER COLUMN oper_id SET DEFAULT nextval('test.operations_oper_id_seq'::regclass);
 ?   ALTER TABLE test.operations ALTER COLUMN oper_id DROP DEFAULT;
       test       user_testdb1    false    224    223    224            \           2604    16619     operations_access_levels opac_id    DEFAULT     �   ALTER TABLE ONLY test.operations_access_levels ALTER COLUMN opac_id SET DEFAULT nextval('test.operations_access_levels_opac_id_seq'::regclass);
 M   ALTER TABLE test.operations_access_levels ALTER COLUMN opac_id DROP DEFAULT;
       test       user_testdb1    false    225    226    226            S           2604    16529    parameters prmt_id    DEFAULT     t   ALTER TABLE ONLY test.parameters ALTER COLUMN prmt_id SET DEFAULT nextval('test.parameters_prmt_id_seq'::regclass);
 ?   ALTER TABLE test.parameters ALTER COLUMN prmt_id DROP DEFAULT;
       test       user_testdb1    false    210    209    210            V           2604    16544    social soc_id    DEFAULT     j   ALTER TABLE ONLY test.social ALTER COLUMN soc_id SET DEFAULT nextval('test.social_soc_id_seq'::regclass);
 :   ALTER TABLE test.social ALTER COLUMN soc_id DROP DEFAULT;
       test       user_testdb1    false    211    212    212            Y           2604    16591 "   social_approved_activities saac_id    DEFAULT     �   ALTER TABLE ONLY test.social_approved_activities ALTER COLUMN saac_id SET DEFAULT nextval('test.social_approved_activities_saac_id_seq'::regclass);
 O   ALTER TABLE test.social_approved_activities ALTER COLUMN saac_id DROP DEFAULT;
       test       user_testdb1    false    219    220    220            X           2604    16577 !   social_approved_locations soap_id    DEFAULT     �   ALTER TABLE ONLY test.social_approved_locations ALTER COLUMN soap_id SET DEFAULT nextval('test.social_approved_locations_soap_id_seq'::regclass);
 N   ALTER TABLE test.social_approved_locations ALTER COLUMN soap_id DROP DEFAULT;
       test       user_testdb1    false    215    216    216            N           2604    16416    users usr_id    DEFAULT     h   ALTER TABLE ONLY test.users ALTER COLUMN usr_id SET DEFAULT nextval('test.users_usr_id_seq'::regclass);
 9   ALTER TABLE test.users ALTER COLUMN usr_id DROP DEFAULT;
       test       user_testdb1    false    201    200    201            _           2604    16714    work_shedule workshed_id    DEFAULT     �   ALTER TABLE ONLY test.work_shedule ALTER COLUMN workshed_id SET DEFAULT nextval('test.work_shedule_workshed_id_seq'::regclass);
 E   ALTER TABLE test.work_shedule ALTER COLUMN workshed_id DROP DEFAULT;
       test       user_testdb1    false    232    231    232            3          0    16580    user_access_level 
   TABLE DATA                     public       user_testdb1    false    217   ��       !          0    16397    users 
   TABLE DATA                     public       user_testdb1    false    199   ��       @          0    16677    work_shedule 
   TABLE DATA                     public       user_testdb1    false    230   ��       &          0    16467    access_level 
   TABLE DATA                     test       user_testdb1    false    204   ��       $          0    16425 
   activities 
   TABLE DATA                     test       user_testdb1    false    202   l�       8          0    16597    activities_feedback 
   TABLE DATA                     test       user_testdb1    false    222   ��       D          0    17051    commentaries 
   TABLE DATA                     test       user_testdb1    false    234   ��       (          0    16484    description_pattern 
   TABLE DATA                     test       user_testdb1    false    206   ��       >          0    16624    location_feedback 
   TABLE DATA                     test       user_testdb1    false    228   ��       *          0    16515 	   locations 
   TABLE DATA                     test       user_testdb1    false    208   ��       0          0    16563    module 
   TABLE DATA                     test       user_testdb1    false    214   �       :          0    16605 
   operations 
   TABLE DATA                     test       user_testdb1    false    224   "�       <          0    16616    operations_access_levels 
   TABLE DATA                     test       user_testdb1    false    226   <�       ,          0    16526 
   parameters 
   TABLE DATA                     test       user_testdb1    false    210   V�       .          0    16541    social 
   TABLE DATA                     test       user_testdb1    false    212   p�       6          0    16588    social_approved_activities 
   TABLE DATA                     test       user_testdb1    false    220   ��       2          0    16574    social_approved_locations 
   TABLE DATA                     test       user_testdb1    false    216   ��                 0    16389    test 
   TABLE DATA                     test       user_testdb1    false    197   ��       4          0    16583    user_access_level 
   TABLE DATA                     test       user_testdb1    false    218   �       #          0    16413    users 
   TABLE DATA                     test       user_testdb1    false    201   4�       B          0    16711    work_shedule 
   TABLE DATA                     test       user_testdb1    false    232   N�       w           0    0    users_usr_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.users_usr_id_seq', 1, false);
            public       user_testdb1    false    198            x           0    0    work_shedule_workshed_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.work_shedule_workshed_id_seq', 1, false);
            public       user_testdb1    false    229            y           0    0    access_level_acc_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('test.access_level_acc_id_seq', 6, true);
            test       user_testdb1    false    203            z           0    0 !   activities_feedback_acfeed_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('test.activities_feedback_acfeed_id_seq', 1, false);
            test       user_testdb1    false    221            {           0    0    commentaries_com_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('test.commentaries_com_id_seq', 1, false);
            test       user_testdb1    false    233            |           0    0 !   description_pattern_despat_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('test.description_pattern_despat_id_seq', 1, false);
            test       user_testdb1    false    205            }           0    0     location_feedback_locfeed_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('test.location_feedback_locfeed_id_seq', 1, false);
            test       user_testdb1    false    227            ~           0    0    locations_loc_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('test.locations_loc_id_seq', 1, false);
            test       user_testdb1    false    207                       0    0    module_mod_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('test.module_mod_id_seq', 1, false);
            test       user_testdb1    false    213            �           0    0 $   operations_access_levels_opac_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('test.operations_access_levels_opac_id_seq', 1, false);
            test       user_testdb1    false    225            �           0    0    operations_oper_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('test.operations_oper_id_seq', 1, false);
            test       user_testdb1    false    223            �           0    0    parameters_prmt_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('test.parameters_prmt_id_seq', 1, false);
            test       user_testdb1    false    209            �           0    0 &   social_approved_activities_saac_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('test.social_approved_activities_saac_id_seq', 1, false);
            test       user_testdb1    false    219            �           0    0 %   social_approved_locations_soap_id_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('test.social_approved_locations_soap_id_seq', 1, false);
            test       user_testdb1    false    215            �           0    0    social_soc_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('test.social_soc_id_seq', 1, false);
            test       user_testdb1    false    211            �           0    0    users_usr_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('test.users_usr_id_seq', 1, false);
            test       user_testdb1    false    200            �           0    0    work_shedule_workshed_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('test.work_shedule_workshed_id_seq', 1, false);
            test       user_testdb1    false    231            b           2606    16408    users users_login_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key UNIQUE (login);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_login_key;
       public         user_testdb1    false    199            d           2606    16406    users usr_id_pk 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT usr_id_pk PRIMARY KEY (usr_id);
 9   ALTER TABLE ONLY public.users DROP CONSTRAINT usr_id_pk;
       public         user_testdb1    false    199            �           2606    16682    work_shedule work_shedule_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.work_shedule
    ADD CONSTRAINT work_shedule_pkey PRIMARY KEY (workshed_id);
 H   ALTER TABLE ONLY public.work_shedule DROP CONSTRAINT work_shedule_pkey;
       public         user_testdb1    false    230            p           2606    16475    access_level access_level_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY test.access_level
    ADD CONSTRAINT access_level_pkey PRIMARY KEY (acc_id);
 F   ALTER TABLE ONLY test.access_level DROP CONSTRAINT access_level_pkey;
       test         user_testdb1    false    204            j           2606    16434 *   activities activities_despat_despat_id_key 
   CONSTRAINT     o   ALTER TABLE ONLY test.activities
    ADD CONSTRAINT activities_despat_despat_id_key UNIQUE (despat_despat_id);
 R   ALTER TABLE ONLY test.activities DROP CONSTRAINT activities_despat_despat_id_key;
       test         user_testdb1    false    202            �           2606    16602 ,   activities_feedback activities_feedback_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY test.activities_feedback
    ADD CONSTRAINT activities_feedback_pkey PRIMARY KEY (acfeed_id);
 T   ALTER TABLE ONLY test.activities_feedback DROP CONSTRAINT activities_feedback_pkey;
       test         user_testdb1    false    222            m           2606    16432    activities activities_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY test.activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (act_id);
 B   ALTER TABLE ONLY test.activities DROP CONSTRAINT activities_pkey;
       test         user_testdb1    false    202            r           2606    16492 ,   description_pattern description_pattern_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY test.description_pattern
    ADD CONSTRAINT description_pattern_pkey PRIMARY KEY (despat_id);
 T   ALTER TABLE ONLY test.description_pattern DROP CONSTRAINT description_pattern_pkey;
       test         user_testdb1    false    206            �           2606    16629 (   location_feedback location_feedback_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY test.location_feedback
    ADD CONSTRAINT location_feedback_pkey PRIMARY KEY (locfeed_id);
 P   ALTER TABLE ONLY test.location_feedback DROP CONSTRAINT location_feedback_pkey;
       test         user_testdb1    false    228            u           2606    16523    locations locations_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY test.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (loc_id);
 @   ALTER TABLE ONLY test.locations DROP CONSTRAINT locations_pkey;
       test         user_testdb1    false    208            |           2606    16571    module module_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY test.module
    ADD CONSTRAINT module_pkey PRIMARY KEY (mod_id);
 :   ALTER TABLE ONLY test.module DROP CONSTRAINT module_pkey;
       test         user_testdb1    false    214            �           2606    16621 6   operations_access_levels operations_access_levels_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY test.operations_access_levels
    ADD CONSTRAINT operations_access_levels_pkey PRIMARY KEY (opac_id);
 ^   ALTER TABLE ONLY test.operations_access_levels DROP CONSTRAINT operations_access_levels_pkey;
       test         user_testdb1    false    226            �           2606    16613    operations operations_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY test.operations
    ADD CONSTRAINT operations_pkey PRIMARY KEY (oper_id);
 B   ALTER TABLE ONLY test.operations DROP CONSTRAINT operations_pkey;
       test         user_testdb1    false    224            x           2606    16536    parameters parameters_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY test.parameters
    ADD CONSTRAINT parameters_pkey PRIMARY KEY (prmt_id);
 B   ALTER TABLE ONLY test.parameters DROP CONSTRAINT parameters_pkey;
       test         user_testdb1    false    210            �           2606    17056 #   commentaries pk_commentaries_com_id 
   CONSTRAINT     c   ALTER TABLE ONLY test.commentaries
    ADD CONSTRAINT pk_commentaries_com_id PRIMARY KEY (com_id);
 K   ALTER TABLE ONLY test.commentaries DROP CONSTRAINT pk_commentaries_com_id;
       test         user_testdb1    false    234            �           2606    16593 :   social_approved_activities social_approved_activities_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY test.social_approved_activities
    ADD CONSTRAINT social_approved_activities_pkey PRIMARY KEY (saac_id);
 b   ALTER TABLE ONLY test.social_approved_activities DROP CONSTRAINT social_approved_activities_pkey;
       test         user_testdb1    false    220            ~           2606    16579 8   social_approved_locations social_approved_locations_pkey 
   CONSTRAINT     y   ALTER TABLE ONLY test.social_approved_locations
    ADD CONSTRAINT social_approved_locations_pkey PRIMARY KEY (soap_id);
 `   ALTER TABLE ONLY test.social_approved_locations DROP CONSTRAINT social_approved_locations_pkey;
       test         user_testdb1    false    216            z           2606    16549    social social_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY test.social
    ADD CONSTRAINT social_pkey PRIMARY KEY (soc_id);
 :   ALTER TABLE ONLY test.social DROP CONSTRAINT social_pkey;
       test         user_testdb1    false    212            f           2606    16424    users users_login_key 
   CONSTRAINT     O   ALTER TABLE ONLY test.users
    ADD CONSTRAINT users_login_key UNIQUE (login);
 =   ALTER TABLE ONLY test.users DROP CONSTRAINT users_login_key;
       test         user_testdb1    false    201            h           2606    16422    users usr_id_pk 
   CONSTRAINT     O   ALTER TABLE ONLY test.users
    ADD CONSTRAINT usr_id_pk PRIMARY KEY (usr_id);
 7   ALTER TABLE ONLY test.users DROP CONSTRAINT usr_id_pk;
       test         user_testdb1    false    201            �           2606    16716    work_shedule work_shedule_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY test.work_shedule
    ADD CONSTRAINT work_shedule_pkey PRIMARY KEY (workshed_id);
 F   ALTER TABLE ONLY test.work_shedule DROP CONSTRAINT work_shedule_pkey;
       test         user_testdb1    false    232            �           1259    16683    work_shedule_loc_loc_id    INDEX     V   CREATE INDEX work_shedule_loc_loc_id ON public.work_shedule USING btree (loc_loc_id);
 +   DROP INDEX public.work_shedule_loc_loc_id;
       public         user_testdb1    false    230            n           1259    16476    access_level_parrent_id    INDEX     T   CREATE INDEX access_level_parrent_id ON test.access_level USING btree (parrent_id);
 )   DROP INDEX test.access_level_parrent_id;
       test         user_testdb1    false    204            k           1259    16435    activities_loc_loc_id    INDEX     P   CREATE INDEX activities_loc_loc_id ON test.activities USING btree (loc_loc_id);
 '   DROP INDEX test.activities_loc_loc_id;
       test         user_testdb1    false    202            v           1259    16537    parameters_name    INDEX     K   CREATE UNIQUE INDEX parameters_name ON test.parameters USING btree (name);
 !   DROP INDEX test.parameters_name;
       test         user_testdb1    false    210            s           1259    17037    parrent_idx    INDEX     O   CREATE INDEX parrent_idx ON test.description_pattern USING btree (parrent_id);
    DROP INDEX test.parrent_idx;
       test         user_testdb1    false    206                       1259    16594 %   social_approved_activities_act_act_id    INDEX     p   CREATE INDEX social_approved_activities_act_act_id ON test.social_approved_activities USING btree (act_act_id);
 7   DROP INDEX test.social_approved_activities_act_act_id;
       test         user_testdb1    false    220            �           2606    16640 &   operations_access_levels acc_acc_id_cs    FK CONSTRAINT     �   ALTER TABLE ONLY test.operations_access_levels
    ADD CONSTRAINT acc_acc_id_cs FOREIGN KEY (acc_acc_id) REFERENCES test.access_level(acc_id) ON DELETE SET NULL;
 N   ALTER TABLE ONLY test.operations_access_levels DROP CONSTRAINT acc_acc_id_cs;
       test       user_testdb1    false    2928    204    226            �           2606    16645    access_level acc_parent_id_cs    FK CONSTRAINT     �   ALTER TABLE ONLY test.access_level
    ADD CONSTRAINT acc_parent_id_cs FOREIGN KEY (parrent_id) REFERENCES test.access_level(acc_id) ON DELETE SET NULL;
 E   ALTER TABLE ONLY test.access_level DROP CONSTRAINT acc_parent_id_cs;
       test       user_testdb1    false    2928    204    204            �           2606    16947    users access_level_cs    FK CONSTRAINT     �   ALTER TABLE ONLY test.users
    ADD CONSTRAINT access_level_cs FOREIGN KEY (access_level) REFERENCES test.access_level(acc_id) ON DELETE SET NULL;
 =   ALTER TABLE ONLY test.users DROP CONSTRAINT access_level_cs;
       test       user_testdb1    false    204    201    2928            �           2606    16767 (   social_approved_activities act_act_id_cs    FK CONSTRAINT     �   ALTER TABLE ONLY test.social_approved_activities
    ADD CONSTRAINT act_act_id_cs FOREIGN KEY (act_act_id) REFERENCES test.activities(act_id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY test.social_approved_activities DROP CONSTRAINT act_act_id_cs;
       test       user_testdb1    false    202    220    2925            �           2606    16967 !   activities_feedback act_act_id_cs    FK CONSTRAINT     �   ALTER TABLE ONLY test.activities_feedback
    ADD CONSTRAINT act_act_id_cs FOREIGN KEY (act_act_id) REFERENCES test.activities(act_id) ON DELETE CASCADE;
 I   ALTER TABLE ONLY test.activities_feedback DROP CONSTRAINT act_act_id_cs;
       test       user_testdb1    false    202    2925    222            �           2606    16977    activities despat_despat_id_cs    FK CONSTRAINT     �   ALTER TABLE ONLY test.activities
    ADD CONSTRAINT despat_despat_id_cs FOREIGN KEY (despat_despat_id) REFERENCES test.description_pattern(despat_id) ON DELETE SET NULL;
 F   ALTER TABLE ONLY test.activities DROP CONSTRAINT despat_despat_id_cs;
       test       user_testdb1    false    2930    206    202            �           2606    16992    locations despat_despat_id_cs    FK CONSTRAINT     �   ALTER TABLE ONLY test.locations
    ADD CONSTRAINT despat_despat_id_cs FOREIGN KEY (despat_despat_id) REFERENCES test.description_pattern(despat_id) ON DELETE SET NULL;
 E   ALTER TABLE ONLY test.locations DROP CONSTRAINT despat_despat_id_cs;
       test       user_testdb1    false    208    206    2930            �           2606    16957    location_feedback loc_loc_id_cs    FK CONSTRAINT     �   ALTER TABLE ONLY test.location_feedback
    ADD CONSTRAINT loc_loc_id_cs FOREIGN KEY (loc_loc_id) REFERENCES test.locations(loc_id) ON DELETE CASCADE;
 G   ALTER TABLE ONLY test.location_feedback DROP CONSTRAINT loc_loc_id_cs;
       test       user_testdb1    false    228    2933    208            �           2606    16972    work_shedule loc_loc_id_cs    FK CONSTRAINT     �   ALTER TABLE ONLY test.work_shedule
    ADD CONSTRAINT loc_loc_id_cs FOREIGN KEY (loc_loc_id) REFERENCES test.locations(loc_id) ON DELETE CASCADE;
 B   ALTER TABLE ONLY test.work_shedule DROP CONSTRAINT loc_loc_id_cs;
       test       user_testdb1    false    232    2933    208            �           2606    16982    activities loc_loc_id_cs    FK CONSTRAINT     �   ALTER TABLE ONLY test.activities
    ADD CONSTRAINT loc_loc_id_cs FOREIGN KEY (loc_loc_id) REFERENCES test.locations(loc_id) ON DELETE SET NULL;
 @   ALTER TABLE ONLY test.activities DROP CONSTRAINT loc_loc_id_cs;
       test       user_testdb1    false    208    202    2933            �           2606    16997 '   social_approved_locations loc_loc_id_cs    FK CONSTRAINT     �   ALTER TABLE ONLY test.social_approved_locations
    ADD CONSTRAINT loc_loc_id_cs FOREIGN KEY (loc_loc_id) REFERENCES test.locations(loc_id) ON DELETE CASCADE;
 O   ALTER TABLE ONLY test.social_approved_locations DROP CONSTRAINT loc_loc_id_cs;
       test       user_testdb1    false    216    208    2933            �           2606    16635 (   operations_access_levels oper_oper_id_cs    FK CONSTRAINT     �   ALTER TABLE ONLY test.operations_access_levels
    ADD CONSTRAINT oper_oper_id_cs FOREIGN KEY (oper_oper_id) REFERENCES test.operations(oper_id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY test.operations_access_levels DROP CONSTRAINT oper_oper_id_cs;
       test       user_testdb1    false    226    224    2949            �           2606    16630    operations operation_in_module    FK CONSTRAINT     �   ALTER TABLE ONLY test.operations
    ADD CONSTRAINT operation_in_module FOREIGN KEY (mod_mod_id) REFERENCES test.module(mod_id) ON DELETE CASCADE;
 F   ALTER TABLE ONLY test.operations DROP CONSTRAINT operation_in_module;
       test       user_testdb1    false    224    2940    214            �           2606    16987    activities parrent_act_id_cs    FK CONSTRAINT     �   ALTER TABLE ONLY test.activities
    ADD CONSTRAINT parrent_act_id_cs FOREIGN KEY (parrent_act_id) REFERENCES test.activities(act_id) ON DELETE SET NULL;
 D   ALTER TABLE ONLY test.activities DROP CONSTRAINT parrent_act_id_cs;
       test       user_testdb1    false    202    202    2925            �           2606    17022    activities parrent_act_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY test.activities
    ADD CONSTRAINT parrent_act_id_fk FOREIGN KEY (parrent_act_id) REFERENCES test.activities(act_id) ON UPDATE CASCADE ON DELETE SET NULL;
 D   ALTER TABLE ONLY test.activities DROP CONSTRAINT parrent_act_id_fk;
       test       user_testdb1    false    2925    202    202            �           2606    17032 !   description_pattern parrent_id_cs    FK CONSTRAINT     �   ALTER TABLE ONLY test.description_pattern
    ADD CONSTRAINT parrent_id_cs FOREIGN KEY (parrent_id) REFERENCES test.description_pattern(despat_id) ON UPDATE CASCADE ON DELETE SET NULL;
 I   ALTER TABLE ONLY test.description_pattern DROP CONSTRAINT parrent_id_cs;
       test       user_testdb1    false    2930    206    206            �           2606    17027    access_level parrent_id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY test.access_level
    ADD CONSTRAINT parrent_id_fk FOREIGN KEY (parrent_id) REFERENCES test.access_level(acc_id) ON UPDATE CASCADE ON DELETE SET NULL;
 B   ALTER TABLE ONLY test.access_level DROP CONSTRAINT parrent_id_fk;
       test       user_testdb1    false    204    204    2928            �           2606    17002 '   social_approved_locations soc_soc_id_cs    FK CONSTRAINT     �   ALTER TABLE ONLY test.social_approved_locations
    ADD CONSTRAINT soc_soc_id_cs FOREIGN KEY (soc_soc_id) REFERENCES test.social(soc_id) ON DELETE CASCADE;
 O   ALTER TABLE ONLY test.social_approved_locations DROP CONSTRAINT soc_soc_id_cs;
       test       user_testdb1    false    216    2938    212            �           2606    17007 (   social_approved_activities soc_soc_id_cs    FK CONSTRAINT     �   ALTER TABLE ONLY test.social_approved_activities
    ADD CONSTRAINT soc_soc_id_cs FOREIGN KEY (soc_soc_id) REFERENCES test.social(soc_id) ON DELETE CASCADE;
 P   ALTER TABLE ONLY test.social_approved_activities DROP CONSTRAINT soc_soc_id_cs;
       test       user_testdb1    false    2938    220    212            �           2606    16952    location_feedback usr_usr_id_cs    FK CONSTRAINT     �   ALTER TABLE ONLY test.location_feedback
    ADD CONSTRAINT usr_usr_id_cs FOREIGN KEY (usr_usr_id) REFERENCES test.users(usr_id) ON DELETE CASCADE;
 G   ALTER TABLE ONLY test.location_feedback DROP CONSTRAINT usr_usr_id_cs;
       test       user_testdb1    false    228    201    2920            �           2606    16962 !   activities_feedback usr_usr_id_cs    FK CONSTRAINT     �   ALTER TABLE ONLY test.activities_feedback
    ADD CONSTRAINT usr_usr_id_cs FOREIGN KEY (usr_usr_id) REFERENCES test.users(usr_id) ON DELETE CASCADE;
 I   ALTER TABLE ONLY test.activities_feedback DROP CONSTRAINT usr_usr_id_cs;
       test       user_testdb1    false    201    2920    222            3   
   x���          !   
   x���          @   
   x���          &   m   x���v
Q���W(I-.�KLNN-.��I-K�Q� ��3St�sSu��ssS�Jt
������B��O�k������:�u���i��I5;L��02��6pq sf>|      $   
   x���          8   
   x���          D   
   x���          (   
   x���          >   
   x���          *   
   x���          0   
   x���          :   
   x���          <   
   x���          ,   
   x���          .   
   x���          6   
   x���          2   
   x���             L   x���v
Q���W(I-.�
%�%�
a�>���
�ŉ�)�)i��\��pi0��� �ʍ��A��� ^��1      4   
   x���          #   
   x���          B   
   x���         