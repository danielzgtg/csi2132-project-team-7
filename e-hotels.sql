PGDMP                         {           e-hotels    15.1    15.1 )    K           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            L           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            M           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            N           1262    16526    e-hotels    DATABASE     l   CREATE DATABASE "e-hotels" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE "e-hotels";
                postgres    false            �            1259    16591    amenity    TABLE     E   CREATE TABLE public.amenity (
    name character varying NOT NULL
);
    DROP TABLE public.amenity;
       public         heap    postgres    false            �            1259    16646    booking_or_renting    TABLE       CREATE TABLE public.booking_or_renting (
    address_of_hotel character varying NOT NULL,
    room_id character varying NOT NULL,
    start_date date NOT NULL,
    customer_ssn_or_sin integer,
    end_date date,
    was_booked boolean,
    is_renting boolean
);
 &   DROP TABLE public.booking_or_renting;
       public         heap    postgres    false            �            1259    16532    chain    TABLE     �   CREATE TABLE public.chain (
    address_central_office character varying NOT NULL,
    contact_email_address character varying,
    contact_phone_num integer
);
    DROP TABLE public.chain;
       public         heap    postgres    false            �            1259    16639    customer    TABLE     �   CREATE TABLE public.customer (
    ssn_or_sin integer NOT NULL,
    full_name character varying,
    address character varying,
    registration_date date
);
    DROP TABLE public.customer;
       public         heap    postgres    false            �            1259    16615    employee    TABLE     �   CREATE TABLE public.employee (
    ssn_or_sin integer NOT NULL,
    full_name character varying,
    address character varying
);
    DROP TABLE public.employee;
       public         heap    postgres    false            �            1259    16598 
   employment    TABLE     �   CREATE TABLE public.employment (
    address_of_hotel character varying,
    employee_ssn_or_sin integer NOT NULL,
    role_name character varying NOT NULL
);
    DROP TABLE public.employment;
       public         heap    postgres    false            �            1259    16544    hotel    TABLE     �   CREATE TABLE public.hotel (
    address_of_hotel character varying NOT NULL,
    address_central_office character varying,
    ranking integer,
    contact_email_address character varying,
    contact_phone_num integer,
    manager_ssn_or_sin integer
);
    DROP TABLE public.hotel;
       public         heap    postgres    false            �            1259    16622    manager    TABLE     i   CREATE TABLE public.manager (
    manager_ssn_or_sin integer NOT NULL,
    managed_ssn_or_sin integer
);
    DROP TABLE public.manager;
       public         heap    postgres    false            �            1259    16584    offers    TABLE     �   CREATE TABLE public.offers (
    address_of_hotel character varying NOT NULL,
    room_id character varying NOT NULL,
    amenity_name character varying NOT NULL
);
    DROP TABLE public.offers;
       public         heap    postgres    false            �            1259    16632    role    TABLE     B   CREATE TABLE public.role (
    name character varying NOT NULL
);
    DROP TABLE public.role;
       public         heap    postgres    false            �            1259    16551    room    TABLE     �   CREATE TABLE public.room (
    address_of_hotel character varying,
    room_id integer NOT NULL,
    room_price_cents integer,
    capacity integer,
    extended_capacity integer,
    problems_or_damages character varying
);
    DROP TABLE public.room;
       public         heap    postgres    false            B          0    16591    amenity 
   TABLE DATA           '   COPY public.amenity (name) FROM stdin;
    public          postgres    false    218   |/       H          0    16646    booking_or_renting 
   TABLE DATA           �   COPY public.booking_or_renting (address_of_hotel, room_id, start_date, customer_ssn_or_sin, end_date, was_booked, is_renting) FROM stdin;
    public          postgres    false    224   �/       >          0    16532    chain 
   TABLE DATA           a   COPY public.chain (address_central_office, contact_email_address, contact_phone_num) FROM stdin;
    public          postgres    false    214   �/       G          0    16639    customer 
   TABLE DATA           U   COPY public.customer (ssn_or_sin, full_name, address, registration_date) FROM stdin;
    public          postgres    false    223   �/       D          0    16615    employee 
   TABLE DATA           B   COPY public.employee (ssn_or_sin, full_name, address) FROM stdin;
    public          postgres    false    220   �/       C          0    16598 
   employment 
   TABLE DATA           V   COPY public.employment (address_of_hotel, employee_ssn_or_sin, role_name) FROM stdin;
    public          postgres    false    219   0       ?          0    16544    hotel 
   TABLE DATA           �   COPY public.hotel (address_of_hotel, address_central_office, ranking, contact_email_address, contact_phone_num, manager_ssn_or_sin) FROM stdin;
    public          postgres    false    215   *0       E          0    16622    manager 
   TABLE DATA           I   COPY public.manager (manager_ssn_or_sin, managed_ssn_or_sin) FROM stdin;
    public          postgres    false    221   G0       A          0    16584    offers 
   TABLE DATA           I   COPY public.offers (address_of_hotel, room_id, amenity_name) FROM stdin;
    public          postgres    false    217   d0       F          0    16632    role 
   TABLE DATA           $   COPY public.role (name) FROM stdin;
    public          postgres    false    222   �0       @          0    16551    room 
   TABLE DATA           }   COPY public.room (address_of_hotel, room_id, room_price_cents, capacity, extended_capacity, problems_or_damages) FROM stdin;
    public          postgres    false    216   �0       �           2606    16597    amenity amenity_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.amenity
    ADD CONSTRAINT amenity_pkey PRIMARY KEY (name);
 >   ALTER TABLE ONLY public.amenity DROP CONSTRAINT amenity_pkey;
       public            postgres    false    218            �           2606    16652 *   booking_or_renting booking_or_renting_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.booking_or_renting
    ADD CONSTRAINT booking_or_renting_pkey PRIMARY KEY (address_of_hotel, room_id, start_date);
 T   ALTER TABLE ONLY public.booking_or_renting DROP CONSTRAINT booking_or_renting_pkey;
       public            postgres    false    224    224    224            �           2606    16538    chain chain_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.chain
    ADD CONSTRAINT chain_pkey PRIMARY KEY (address_central_office);
 :   ALTER TABLE ONLY public.chain DROP CONSTRAINT chain_pkey;
       public            postgres    false    214            �           2606    16645    customer customer_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (ssn_or_sin);
 @   ALTER TABLE ONLY public.customer DROP CONSTRAINT customer_pkey;
       public            postgres    false    223            �           2606    16621    employee employee_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (ssn_or_sin);
 @   ALTER TABLE ONLY public.employee DROP CONSTRAINT employee_pkey;
       public            postgres    false    220            �           2606    16604    employment employment_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.employment
    ADD CONSTRAINT employment_pkey PRIMARY KEY (employee_ssn_or_sin, role_name);
 D   ALTER TABLE ONLY public.employment DROP CONSTRAINT employment_pkey;
       public            postgres    false    219    219            �           2606    16550    hotel hotel_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_pkey PRIMARY KEY (address_of_hotel);
 :   ALTER TABLE ONLY public.hotel DROP CONSTRAINT hotel_pkey;
       public            postgres    false    215            �           2606    16626    manager manager_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_pkey PRIMARY KEY (manager_ssn_or_sin);
 >   ALTER TABLE ONLY public.manager DROP CONSTRAINT manager_pkey;
       public            postgres    false    221            �           2606    16590    offers offers_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_pkey PRIMARY KEY (address_of_hotel, room_id, amenity_name);
 <   ALTER TABLE ONLY public.offers DROP CONSTRAINT offers_pkey;
       public            postgres    false    217    217    217            �           2606    16638    role role_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (name);
 8   ALTER TABLE ONLY public.role DROP CONSTRAINT role_pkey;
       public            postgres    false    222            �           2606    16557    room room_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (room_id);
 8   ALTER TABLE ONLY public.room DROP CONSTRAINT room_pkey;
       public            postgres    false    216            �           2606    16653 >   booking_or_renting booking_or_renting_customer_ssn_or_sin_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.booking_or_renting
    ADD CONSTRAINT booking_or_renting_customer_ssn_or_sin_fkey FOREIGN KEY (customer_ssn_or_sin) REFERENCES public.customer(ssn_or_sin);
 h   ALTER TABLE ONLY public.booking_or_renting DROP CONSTRAINT booking_or_renting_customer_ssn_or_sin_fkey;
       public          postgres    false    3497    224    223            �           2606    16605 +   employment employment_address_of_hotel_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.employment
    ADD CONSTRAINT employment_address_of_hotel_fkey FOREIGN KEY (address_of_hotel) REFERENCES public.hotel(address_of_hotel);
 U   ALTER TABLE ONLY public.employment DROP CONSTRAINT employment_address_of_hotel_fkey;
       public          postgres    false    219    215    3481            �           2606    16627 '   manager manager_manager_ssn_or_sin_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.manager
    ADD CONSTRAINT manager_manager_ssn_or_sin_fkey FOREIGN KEY (manager_ssn_or_sin) REFERENCES public.employee(ssn_or_sin);
 Q   ALTER TABLE ONLY public.manager DROP CONSTRAINT manager_manager_ssn_or_sin_fkey;
       public          postgres    false    3491    220    221            �           2606    16558    room room_address_of_hotel_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_address_of_hotel_fkey FOREIGN KEY (address_of_hotel) REFERENCES public.hotel(address_of_hotel);
 I   ALTER TABLE ONLY public.room DROP CONSTRAINT room_address_of_hotel_fkey;
       public          postgres    false    3481    216    215            B      x������ � �      H      x������ � �      >      x������ � �      G      x������ � �      D      x������ � �      C      x������ � �      ?      x������ � �      E      x������ � �      A      x������ � �      F      x������ � �      @      x������ � �     