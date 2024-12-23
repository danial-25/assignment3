PGDMP                  
    |            assignment_db    17.0    17.0 3    @           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            A           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            B           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            C           1262    17497    assignment_db    DATABASE     �   CREATE DATABASE assignment_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1251';
    DROP DATABASE assignment_db;
                     postgres    false            �            1259    17498    country    TABLE     a   CREATE TABLE public.country (
    cname character varying(50) NOT NULL,
    population bigint
);
    DROP TABLE public.country;
       public         heap r       postgres    false            �            1259    17538    discover    TABLE     �   CREATE TABLE public.discover (
    cname character varying(50) NOT NULL,
    disease_code character varying(50) NOT NULL,
    first_enc_date date
);
    DROP TABLE public.discover;
       public         heap r       postgres    false            �            1259    17528    disease    TABLE     �   CREATE TABLE public.disease (
    disease_code character varying(50) NOT NULL,
    pathogen character varying(20),
    description character varying(140),
    disease_id integer
);
    DROP TABLE public.disease;
       public         heap r       postgres    false            �            1259    17523    diseasetype    TABLE     e   CREATE TABLE public.diseasetype (
    id integer NOT NULL,
    description character varying(140)
);
    DROP TABLE public.diseasetype;
       public         heap r       postgres    false            �            1259    17578    doctor    TABLE     k   CREATE TABLE public.doctor (
    email character varying(60) NOT NULL,
    degree character varying(20)
);
    DROP TABLE public.doctor;
       public         heap r       postgres    false            �            1259    17553    patientdisease    TABLE     �   CREATE TABLE public.patientdisease (
    email character varying(60) NOT NULL,
    disease_code character varying(50) NOT NULL
);
 "   DROP TABLE public.patientdisease;
       public         heap r       postgres    false            �            1259    17513    patients    TABLE     K   CREATE TABLE public.patients (
    email character varying(60) NOT NULL
);
    DROP TABLE public.patients;
       public         heap r       postgres    false            �            1259    17568    publicservant    TABLE     v   CREATE TABLE public.publicservant (
    email character varying(60) NOT NULL,
    department character varying(50)
);
 !   DROP TABLE public.publicservant;
       public         heap r       postgres    false            �            1259    17603    record    TABLE     �   CREATE TABLE public.record (
    email character varying(60) NOT NULL,
    cname character varying(50) NOT NULL,
    disease_code character varying(50) NOT NULL,
    total_deaths integer,
    total_patients integer
);
    DROP TABLE public.record;
       public         heap r       postgres    false            �            1259    17588 
   specialize    TABLE     n   CREATE TABLE public.specialize (
    disease_id integer NOT NULL,
    email character varying(60) NOT NULL
);
    DROP TABLE public.specialize;
       public         heap r       postgres    false            �            1259    17503    users    TABLE     �   CREATE TABLE public.users (
    email character varying(60) NOT NULL,
    first_name character varying(30),
    surname character varying(40),
    salary integer,
    phone character varying(20),
    cname character varying(50)
);
    DROP TABLE public.users;
       public         heap r       postgres    false            3          0    17498    country 
   TABLE DATA           4   COPY public.country (cname, population) FROM stdin;
    public               postgres    false    217   R>       8          0    17538    discover 
   TABLE DATA           G   COPY public.discover (cname, disease_code, first_enc_date) FROM stdin;
    public               postgres    false    222   �>       7          0    17528    disease 
   TABLE DATA           R   COPY public.disease (disease_code, pathogen, description, disease_id) FROM stdin;
    public               postgres    false    221   a?       6          0    17523    diseasetype 
   TABLE DATA           6   COPY public.diseasetype (id, description) FROM stdin;
    public               postgres    false    220   @       ;          0    17578    doctor 
   TABLE DATA           /   COPY public.doctor (email, degree) FROM stdin;
    public               postgres    false    225   �@       9          0    17553    patientdisease 
   TABLE DATA           =   COPY public.patientdisease (email, disease_code) FROM stdin;
    public               postgres    false    223   �@       5          0    17513    patients 
   TABLE DATA           )   COPY public.patients (email) FROM stdin;
    public               postgres    false    219   -A       :          0    17568    publicservant 
   TABLE DATA           :   COPY public.publicservant (email, department) FROM stdin;
    public               postgres    false    224   \A       =          0    17603    record 
   TABLE DATA           Z   COPY public.record (email, cname, disease_code, total_deaths, total_patients) FROM stdin;
    public               postgres    false    227   �A       <          0    17588 
   specialize 
   TABLE DATA           7   COPY public.specialize (disease_id, email) FROM stdin;
    public               postgres    false    226   �B       4          0    17503    users 
   TABLE DATA           Q   COPY public.users (email, first_name, surname, salary, phone, cname) FROM stdin;
    public               postgres    false    218   �B                  2606    17502    country country_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (cname);
 >   ALTER TABLE ONLY public.country DROP CONSTRAINT country_pkey;
       public                 postgres    false    217            �           2606    17542    discover discover_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.discover
    ADD CONSTRAINT discover_pkey PRIMARY KEY (cname, disease_code);
 @   ALTER TABLE ONLY public.discover DROP CONSTRAINT discover_pkey;
       public                 postgres    false    222    222            �           2606    17532    disease disease_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.disease
    ADD CONSTRAINT disease_pkey PRIMARY KEY (disease_code);
 >   ALTER TABLE ONLY public.disease DROP CONSTRAINT disease_pkey;
       public                 postgres    false    221            �           2606    17527    diseasetype diseasetype_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.diseasetype
    ADD CONSTRAINT diseasetype_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.diseasetype DROP CONSTRAINT diseasetype_pkey;
       public                 postgres    false    220            �           2606    17582    doctor doctor_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_pkey PRIMARY KEY (email);
 <   ALTER TABLE ONLY public.doctor DROP CONSTRAINT doctor_pkey;
       public                 postgres    false    225            �           2606    17557 "   patientdisease patientdisease_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.patientdisease
    ADD CONSTRAINT patientdisease_pkey PRIMARY KEY (email, disease_code);
 L   ALTER TABLE ONLY public.patientdisease DROP CONSTRAINT patientdisease_pkey;
       public                 postgres    false    223    223            �           2606    17517    patients patients_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (email);
 @   ALTER TABLE ONLY public.patients DROP CONSTRAINT patients_pkey;
       public                 postgres    false    219            �           2606    17572     publicservant publicservant_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.publicservant
    ADD CONSTRAINT publicservant_pkey PRIMARY KEY (email);
 J   ALTER TABLE ONLY public.publicservant DROP CONSTRAINT publicservant_pkey;
       public                 postgres    false    224            �           2606    17607    record record_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.record
    ADD CONSTRAINT record_pkey PRIMARY KEY (email, cname, disease_code);
 <   ALTER TABLE ONLY public.record DROP CONSTRAINT record_pkey;
       public                 postgres    false    227    227    227            �           2606    17592    specialize specialize_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.specialize
    ADD CONSTRAINT specialize_pkey PRIMARY KEY (disease_id, email);
 D   ALTER TABLE ONLY public.specialize DROP CONSTRAINT specialize_pkey;
       public                 postgres    false    226    226            �           2606    17507    users users_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (email);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 postgres    false    218            �           2606    17543    discover discover_cname_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.discover
    ADD CONSTRAINT discover_cname_fkey FOREIGN KEY (cname) REFERENCES public.country(cname) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.discover DROP CONSTRAINT discover_cname_fkey;
       public               postgres    false    217    4735    222            �           2606    17548 #   discover discover_disease_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.discover
    ADD CONSTRAINT discover_disease_code_fkey FOREIGN KEY (disease_code) REFERENCES public.disease(disease_code) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.discover DROP CONSTRAINT discover_disease_code_fkey;
       public               postgres    false    4743    222    221            �           2606    17533    disease disease_disease_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.disease
    ADD CONSTRAINT disease_disease_id_fkey FOREIGN KEY (disease_id) REFERENCES public.diseasetype(id) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.disease DROP CONSTRAINT disease_disease_id_fkey;
       public               postgres    false    220    4741    221            �           2606    17583    doctor doctor_email_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_email_fkey FOREIGN KEY (email) REFERENCES public.users(email) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.doctor DROP CONSTRAINT doctor_email_fkey;
       public               postgres    false    225    4737    218            �           2606    17563 /   patientdisease patientdisease_disease_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.patientdisease
    ADD CONSTRAINT patientdisease_disease_code_fkey FOREIGN KEY (disease_code) REFERENCES public.disease(disease_code) ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public.patientdisease DROP CONSTRAINT patientdisease_disease_code_fkey;
       public               postgres    false    4743    223    221            �           2606    17558 (   patientdisease patientdisease_email_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.patientdisease
    ADD CONSTRAINT patientdisease_email_fkey FOREIGN KEY (email) REFERENCES public.users(email) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.patientdisease DROP CONSTRAINT patientdisease_email_fkey;
       public               postgres    false    223    4737    218            �           2606    17518    patients patients_email_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_email_fkey FOREIGN KEY (email) REFERENCES public.users(email) ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.patients DROP CONSTRAINT patients_email_fkey;
       public               postgres    false    4737    218    219            �           2606    17573 &   publicservant publicservant_email_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.publicservant
    ADD CONSTRAINT publicservant_email_fkey FOREIGN KEY (email) REFERENCES public.users(email) ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.publicservant DROP CONSTRAINT publicservant_email_fkey;
       public               postgres    false    218    224    4737            �           2606    17613    record record_cname_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.record
    ADD CONSTRAINT record_cname_fkey FOREIGN KEY (cname) REFERENCES public.country(cname) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.record DROP CONSTRAINT record_cname_fkey;
       public               postgres    false    227    4735    217            �           2606    17608    record record_disease_code_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.record
    ADD CONSTRAINT record_disease_code_fkey FOREIGN KEY (disease_code) REFERENCES public.disease(disease_code) ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.record DROP CONSTRAINT record_disease_code_fkey;
       public               postgres    false    227    4743    221            �           2606    17618    record record_email_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.record
    ADD CONSTRAINT record_email_fkey FOREIGN KEY (email) REFERENCES public.publicservant(email) ON DELETE CASCADE;
 B   ALTER TABLE ONLY public.record DROP CONSTRAINT record_email_fkey;
       public               postgres    false    224    227    4749            �           2606    17593 %   specialize specialize_disease_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.specialize
    ADD CONSTRAINT specialize_disease_id_fkey FOREIGN KEY (disease_id) REFERENCES public.diseasetype(id) ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.specialize DROP CONSTRAINT specialize_disease_id_fkey;
       public               postgres    false    226    4741    220            �           2606    17598     specialize specialize_email_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.specialize
    ADD CONSTRAINT specialize_email_fkey FOREIGN KEY (email) REFERENCES public.doctor(email) ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.specialize DROP CONSTRAINT specialize_email_fkey;
       public               postgres    false    226    4751    225            �           2606    17508    users users_cname_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_cname_fkey FOREIGN KEY (cname) REFERENCES public.country(cname) ON DELETE SET NULL;
 @   ALTER TABLE ONLY public.users DROP CONSTRAINT users_cname_fkey;
       public               postgres    false    217    218    4735            3   p   x��N�J��(.I��4�4 .��ļ�TNs(�=�(71���&��X Ro�zs�Asy�$�Tr��T$f�q��dK�K�s29�L�B��y@�p�s��1z\\\ P.&�      8      x�5̱�0E�9�#�M��G ���X������q֣�ޠ?}�?�f��	�Y�z����#Ed�Y�mt�1�H�%8��[��%o�"5(���P�P�}����f�I���q���Rg�U�� `��&L      7   �   x�E��
�0D��~E@i�fq骛$H�Ҥ����
��3�!��� �/�cRSXu��A:�~�s�� ��z2�����E�y:�*��7WH�I[��b?|�E�l��g��н D��S�y���L�h��
�="� �88?      6   �   x�M�K�0D��)8���+1�"��v+���tv�ߛX��u�Ma't򴇑M�>�t��VXG�<T��t#��a�M�>����9c]z�B��<�$/�$E��P��/�v��M��'�����<�Ô%ȃe�Y��6��/�K�      ;   5   x�K�O6t�K����H�J�O6��\@<c��1A昢�3C�2GH��qqq �b�      9   :   x�+H,1t�K���t1�*@p�A#d��1�rL�9���,�eP�6A�q��qqq N5%|      5      x�+H,1t�K���*H,1���!�=... ʣ
3      :   H   x�+N-*3t�K���tM)MN,����*
A=RsJ2��R���XEM���BD��3S�!Bf�6��qqq �],�      =   �   x�����0�ۇ1��գF�Q�ƛ�!��P4�������x���W�T7��ŗ6�8�P����3�b��6�
���b���=�h!T 4a�x~�� 6��hWc�PXR��xz(1�D�ص'�����R[��p�w<���uA7�=���鿿N3���&���>-�E�������E�[�3Ƨc���x<      <   L   x�M�;�0Й�"���q�vE�������ɲ��\ï4�cY\�LWq��W��}���������2������0      4   m  x�e��n�0����D@�OnM����!ɡU/�±#����چB��=̧���e�=�2y�/�<ˊ�-p��_o�0��.��cU�
'��o�v��-���x�R��F�����,/��(X >�5�;6ط\`_Vu�	A��U��!��T�࠰�9�%��=S7�Hh�O�Ā��#w����*�}����صu����ܱ�$:��Uu'�!\��9%�mv��MUe]0R/�
��a�=b���;t��;"x)J�N��Ú:4H��x�	�ܥ>��� �,a�����[xǻ��WH��[��'�}v"��6�F��R��)���I����u�����CH����X�s~���i�ܱ     