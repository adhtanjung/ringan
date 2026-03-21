SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict eExbfGlpsLCMi1UM8lcuububVRT4MoOZ3OSIVgqi2tkzhDuWEYJsrBzPfZ0BPex

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."audit_log_entries" ("instance_id", "id", "payload", "created_at", "ip_address") FROM stdin;
00000000-0000-0000-0000-000000000000	1097a713-77d5-4e99-869a-da77367f993d	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"anjoe@msa.com","user_id":"18b21873-eb44-47b2-9dd5-6357f3f9d3b2","user_phone":""}}	2025-09-13 13:16:26.608702+00	
00000000-0000-0000-0000-000000000000	d03cef5f-9d69-4fea-b8c5-178c8ddfabd1	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"raheli@ringan.com","user_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","user_phone":""}}	2025-12-11 12:00:09.326134+00	
00000000-0000-0000-0000-000000000000	75cc98ff-1c31-460a-a576-f7246d639787	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-26 03:06:29.840995+00	
00000000-0000-0000-0000-000000000000	41fd6654-9d07-4304-bbdc-e6bcdcb476c9	{"action":"logout","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account"}	2025-12-26 03:06:41.073392+00	
00000000-0000-0000-0000-000000000000	a7e04a2e-9066-45f5-ac90-a619d020c6c8	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-26 03:10:06.5996+00	
00000000-0000-0000-0000-000000000000	d5fd7dbd-0166-4a5d-93a1-cc60885e8c9b	{"action":"logout","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account"}	2025-12-26 04:05:45.246726+00	
00000000-0000-0000-0000-000000000000	7857cd80-6a0b-4bc3-8f0f-dc1e3d528c9c	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-26 04:07:08.377789+00	
00000000-0000-0000-0000-000000000000	2bd30cd4-aba8-41f6-8109-756758bf0d75	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-26 04:07:39.213785+00	
00000000-0000-0000-0000-000000000000	a35889f7-8db6-4352-a0dc-d3ce127da658	{"action":"logout","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account"}	2025-12-26 04:29:25.168674+00	
00000000-0000-0000-0000-000000000000	eeffa313-bcee-4fa6-a1e5-37eeb0fd157a	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-26 04:29:26.763123+00	
00000000-0000-0000-0000-000000000000	eb9a8a02-68e7-4471-ab6b-d556b11c7acf	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-26 05:27:27.788924+00	
00000000-0000-0000-0000-000000000000	b67706ee-c043-453e-a015-0e41ceb02e6a	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-26 05:27:27.810064+00	
00000000-0000-0000-0000-000000000000	ec782857-b984-469b-9bf5-3cd730713d1b	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-26 06:35:39.820168+00	
00000000-0000-0000-0000-000000000000	8d686616-e526-455b-ad68-aba6981d3704	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-26 06:35:39.836928+00	
00000000-0000-0000-0000-000000000000	ec2b792d-1968-4ad1-a074-189dc6ce5b78	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-26 07:36:50.978605+00	
00000000-0000-0000-0000-000000000000	98361e78-0fe0-46ba-ba8d-cd63c4b252e1	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-26 07:36:50.989038+00	
00000000-0000-0000-0000-000000000000	7a21da87-4127-4ff5-9bd3-ac5ad0654371	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-26 08:34:57.32072+00	
00000000-0000-0000-0000-000000000000	81b38fbe-1558-40e9-9341-cb33c995d8f4	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-26 08:34:57.335572+00	
00000000-0000-0000-0000-000000000000	7fb28bc4-f902-42b7-bafa-33d79e013c8a	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-26 09:35:27.074906+00	
00000000-0000-0000-0000-000000000000	5150a5b5-7b7b-4389-84a8-6683747dde4e	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-26 09:35:27.084782+00	
00000000-0000-0000-0000-000000000000	e17ec893-aeed-4915-ab7c-28a4817d6866	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-26 10:33:57.025641+00	
00000000-0000-0000-0000-000000000000	c2ced09a-76f5-41f0-9758-6c03d849aa7c	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-26 10:33:57.028538+00	
00000000-0000-0000-0000-000000000000	eaede508-2fcd-447a-9a85-539cc197a268	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-26 11:31:58.30602+00	
00000000-0000-0000-0000-000000000000	0b484da5-e5cb-477b-877e-20d30be2a6e3	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-26 11:31:58.329314+00	
00000000-0000-0000-0000-000000000000	fd4b5886-b02a-4ee2-bda5-36cef88a7e17	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-26 12:32:06.271927+00	
00000000-0000-0000-0000-000000000000	c356a4d0-da45-4fbd-a55d-a79db9c0eba0	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-26 12:32:06.292213+00	
00000000-0000-0000-0000-000000000000	7a2c4868-e69b-4faf-ac64-05e31612518d	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-26 14:00:56.07824+00	
00000000-0000-0000-0000-000000000000	991195b6-29e4-4a20-bcb5-3ff61269b33b	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-26 14:00:56.09332+00	
00000000-0000-0000-0000-000000000000	e0a8e7cc-7f64-458c-b2ed-7d69909f5745	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-27 15:02:04.892141+00	
00000000-0000-0000-0000-000000000000	dfb6ff3b-40d0-4623-98c4-dd6e03693723	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-27 15:02:04.917067+00	
00000000-0000-0000-0000-000000000000	5e8973ff-b8bd-40cd-b707-4f8b404a1f33	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-28 08:40:37.612061+00	
00000000-0000-0000-0000-000000000000	5a82a27a-80a0-461c-ab18-88745848d651	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-28 08:46:23.15047+00	
00000000-0000-0000-0000-000000000000	a7b5fd17-637b-45ac-a142-c44f7f97941c	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-12-28 09:25:45.173591+00	
00000000-0000-0000-0000-000000000000	2d1c2d57-4101-4947-ac01-b815d0e06d20	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-28 13:59:55.103676+00	
00000000-0000-0000-0000-000000000000	037770d0-42f7-4f68-9f05-f6ae830c2385	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-28 13:59:55.106907+00	
00000000-0000-0000-0000-000000000000	f16b3ef9-5867-4900-92f5-8c915e3bf631	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-28 13:59:55.126446+00	
00000000-0000-0000-0000-000000000000	9af81e95-57a8-4ec6-bdbd-d8a5d15eb9ee	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-28 13:59:55.128704+00	
00000000-0000-0000-0000-000000000000	e45bde8d-067f-4102-996d-b37d9f21e8a2	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 03:07:56.881427+00	
00000000-0000-0000-0000-000000000000	bfbc2be4-cf60-4272-92e2-8670333b3f6f	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 03:07:56.90205+00	
00000000-0000-0000-0000-000000000000	9360497d-7f93-4d63-8ca4-440118751f28	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 03:17:32.75086+00	
00000000-0000-0000-0000-000000000000	7bfd2010-927d-47d5-9c1f-50e178656afa	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 03:17:32.756692+00	
00000000-0000-0000-0000-000000000000	76d605e9-5c0e-46bf-8d37-42a4ea5b7fef	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 04:12:35.356689+00	
00000000-0000-0000-0000-000000000000	77e47794-fb90-42e0-9725-eb1380f3a8cd	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 04:12:35.380759+00	
00000000-0000-0000-0000-000000000000	54cf94b2-784a-4bb6-9646-1fb0d1d33098	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 04:15:39.556913+00	
00000000-0000-0000-0000-000000000000	182f434a-939d-4f2a-b79e-4a3c41fae135	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 04:15:39.56483+00	
00000000-0000-0000-0000-000000000000	a3d35757-2f57-4115-b317-a631a3e39247	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 05:10:39.737241+00	
00000000-0000-0000-0000-000000000000	49bb9f89-2cd9-499c-b61d-9b83b2a8bcc5	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 05:10:39.754394+00	
00000000-0000-0000-0000-000000000000	6b40c71d-7f84-4fe9-a196-6127eb3e94a1	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 05:13:39.616399+00	
00000000-0000-0000-0000-000000000000	2642fc23-29bc-4ed8-9049-34a2c4cb939e	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 05:13:39.61739+00	
00000000-0000-0000-0000-000000000000	7ba9df1d-eeeb-468b-b7dc-3473a44fad77	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 06:09:10.229593+00	
00000000-0000-0000-0000-000000000000	7a535aaf-4ec0-406c-8b6d-f9a874c97cbd	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 06:09:10.242966+00	
00000000-0000-0000-0000-000000000000	2260c85e-214a-403d-b1be-bf2d1bff2ccb	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 06:11:39.489401+00	
00000000-0000-0000-0000-000000000000	18eca827-6910-47d4-961a-fc1a55946461	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 06:11:39.490346+00	
00000000-0000-0000-0000-000000000000	48ea9361-d76f-436b-bc7d-66fcc803c43c	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 07:09:40.054736+00	
00000000-0000-0000-0000-000000000000	08205600-8d16-4ab5-8284-39e6649c803e	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 07:09:40.073005+00	
00000000-0000-0000-0000-000000000000	4a926cd0-2398-4333-b2ab-ea6becdd79f4	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 07:42:44.766637+00	
00000000-0000-0000-0000-000000000000	4e2d3d5e-c7a5-46c1-b689-fc2798065a11	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 07:42:44.781567+00	
00000000-0000-0000-0000-000000000000	99ff135f-e20c-4251-952c-6a3369e3d3f6	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 07:42:45.011635+00	
00000000-0000-0000-0000-000000000000	faec7973-80bf-4809-a8ce-037b6de47ff2	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 08:07:55.911974+00	
00000000-0000-0000-0000-000000000000	79564a13-ee48-43b5-9c2c-7255221e7909	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 08:07:55.92592+00	
00000000-0000-0000-0000-000000000000	a75c5260-49eb-4b22-9477-7272dc662809	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 08:21:43.32602+00	
00000000-0000-0000-0000-000000000000	566c3930-0bc9-44b1-bd91-ef3313d18ba5	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 08:21:43.332319+00	
00000000-0000-0000-0000-000000000000	7d0fc19e-2be4-4864-b893-16444785b2d3	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 09:05:56.639806+00	
00000000-0000-0000-0000-000000000000	0380acbc-d36d-442e-9f35-1f8a8188e0c0	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 09:05:56.656265+00	
00000000-0000-0000-0000-000000000000	70c34f45-a973-4e04-822f-403b8e460c69	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 10:03:56.977261+00	
00000000-0000-0000-0000-000000000000	cb3870e9-e8ba-473a-83af-32750e9a0a89	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 10:03:56.991416+00	
00000000-0000-0000-0000-000000000000	a35d1cf3-087e-49dc-affe-80b1b056121c	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 10:46:21.75187+00	
00000000-0000-0000-0000-000000000000	a1ea9097-00df-4358-bdb9-7e5d80ee23c3	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 10:46:21.776483+00	
00000000-0000-0000-0000-000000000000	3d5836f9-f7c5-492d-bf75-56027aa5bfbc	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 11:01:59.342241+00	
00000000-0000-0000-0000-000000000000	022bdd49-d83d-44b7-951d-aa64c0df7d9e	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 11:01:59.351135+00	
00000000-0000-0000-0000-000000000000	57d709ac-1cac-4910-b482-11d1581d1e50	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 11:44:31.04939+00	
00000000-0000-0000-0000-000000000000	7e291e90-1efe-4c12-b9f4-1fa49287c3b2	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 11:44:31.063715+00	
00000000-0000-0000-0000-000000000000	94590849-f869-449c-b917-d11c100da48b	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 12:00:00.158648+00	
00000000-0000-0000-0000-000000000000	c1651173-ac29-4192-9bf5-3c75b1b931a4	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 12:00:00.160403+00	
00000000-0000-0000-0000-000000000000	75167dc3-45c9-409f-aab0-8ae46d1a7a0b	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 12:42:37.403609+00	
00000000-0000-0000-0000-000000000000	2be9c691-3ed2-4f10-b61a-3d4da32166c5	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 12:42:37.423072+00	
00000000-0000-0000-0000-000000000000	2b4e0991-d735-46a2-a343-ed5cd60a269c	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 12:46:07.65546+00	
00000000-0000-0000-0000-000000000000	a5864536-81b7-4d83-a27e-a26992801041	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 12:46:07.665478+00	
00000000-0000-0000-0000-000000000000	1a6829fc-3441-42a7-9d1c-1818a2577328	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 12:58:03.037294+00	
00000000-0000-0000-0000-000000000000	cb0e761f-57a1-428e-a232-7604156b672b	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 12:58:03.04345+00	
00000000-0000-0000-0000-000000000000	e442cae9-6d5a-418d-88f8-0a20c09fd518	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 13:56:04.109547+00	
00000000-0000-0000-0000-000000000000	77373fe9-eb74-4dee-9291-a53c1dd58bea	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 13:56:04.12171+00	
00000000-0000-0000-0000-000000000000	ea622b2f-4cdc-4015-83d2-083901ddbd00	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 14:34:37.057077+00	
00000000-0000-0000-0000-000000000000	66fd664e-d8f5-49bc-bd09-23342c2ae714	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 14:34:37.069786+00	
00000000-0000-0000-0000-000000000000	a0e84024-dee3-44ff-8b89-318787cd7820	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 14:35:45.907061+00	
00000000-0000-0000-0000-000000000000	e64027e1-886f-400b-bf3e-a95faad06739	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 14:35:45.908079+00	
00000000-0000-0000-0000-000000000000	224a9d87-4781-4b40-9958-50f30f7bac2c	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 15:34:04.429367+00	
00000000-0000-0000-0000-000000000000	ec8a12f8-ef3a-48ea-997c-2cb3bec324d9	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 15:34:04.447932+00	
00000000-0000-0000-0000-000000000000	24911e90-9aa5-4595-a1a0-10502f63fbee	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 16:32:34.72784+00	
00000000-0000-0000-0000-000000000000	afb3a949-e54f-4c1d-9cbc-6a53a34185f9	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 16:32:34.740872+00	
00000000-0000-0000-0000-000000000000	6d6b03b9-0460-411c-8f94-7491a3e6cb1a	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 17:31:04.465604+00	
00000000-0000-0000-0000-000000000000	c0087b5a-1c33-4842-8168-d44a1fad26e6	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 17:31:04.477549+00	
00000000-0000-0000-0000-000000000000	e5534482-c26e-4b4e-ba32-28876768c3d6	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 18:29:34.471384+00	
00000000-0000-0000-0000-000000000000	3633e95f-4349-42cb-b7d8-ede1847b9819	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 18:29:34.481812+00	
00000000-0000-0000-0000-000000000000	bc4e1a39-46e4-4225-8ab5-6534a77dc55a	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 19:28:04.412791+00	
00000000-0000-0000-0000-000000000000	c8cd1d77-7ca8-4a39-8384-4b031a99efd3	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 19:28:04.429308+00	
00000000-0000-0000-0000-000000000000	b6924191-7d25-4101-a1b0-c92606958aeb	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 20:26:34.437905+00	
00000000-0000-0000-0000-000000000000	77038bab-4618-4167-b675-d60021f16522	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 20:26:34.451324+00	
00000000-0000-0000-0000-000000000000	d3079e46-24b6-4e30-8fdc-764b762216b6	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 21:25:04.41361+00	
00000000-0000-0000-0000-000000000000	b768d758-15ea-46f0-a9ba-147cd59ac6e7	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 21:25:04.425009+00	
00000000-0000-0000-0000-000000000000	bd8b2b26-2e84-4175-b79f-fc4c53303d7f	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 22:23:34.492978+00	
00000000-0000-0000-0000-000000000000	4564d77e-609d-40ab-93fe-9a2e0b6e7a93	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 22:23:34.510878+00	
00000000-0000-0000-0000-000000000000	19a11e7f-e7ed-497a-acac-eab0c6bdb32b	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 23:22:04.442584+00	
00000000-0000-0000-0000-000000000000	4db90a58-6221-4f59-99cf-11dd3504b866	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-29 23:22:04.454511+00	
00000000-0000-0000-0000-000000000000	b13f3b88-5c73-4b79-a853-06389a8a6a49	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 00:20:34.34467+00	
00000000-0000-0000-0000-000000000000	b9b32bb3-8a99-40ee-ac32-314d4d496afe	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 00:20:34.354192+00	
00000000-0000-0000-0000-000000000000	77005c85-7e35-412c-ad65-0b8ac19d6a00	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 01:19:04.399872+00	
00000000-0000-0000-0000-000000000000	edd9e975-7faa-4330-8eb0-5f38c93ee8de	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 01:19:04.416721+00	
00000000-0000-0000-0000-000000000000	1052c378-c4a0-4eb4-b6e3-7b3221e170e8	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 02:17:34.379786+00	
00000000-0000-0000-0000-000000000000	0a318cc5-1855-4c74-9c9c-be83c676f46c	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 02:17:34.391759+00	
00000000-0000-0000-0000-000000000000	a9536bab-b28c-4b2a-8f90-aa29fb156b46	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 03:16:04.329635+00	
00000000-0000-0000-0000-000000000000	49c95c4c-e27d-4cb8-9fc2-68be7d505fbd	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 03:16:04.339984+00	
00000000-0000-0000-0000-000000000000	2365e876-b32d-4943-8e33-2b2063c0cf53	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 04:14:34.657861+00	
00000000-0000-0000-0000-000000000000	e9d4a065-a1ac-44c1-aaaa-536a5b7df9fc	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 04:14:34.675326+00	
00000000-0000-0000-0000-000000000000	c4015c68-ee4b-4f46-ba47-a44f6dc3c4c7	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 05:13:04.754645+00	
00000000-0000-0000-0000-000000000000	31034d9a-7ba5-48ac-b0e8-27f6e808b1a0	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 05:13:04.771578+00	
00000000-0000-0000-0000-000000000000	3125588f-2969-487d-a32e-a2d25e41c6d3	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 06:11:34.519014+00	
00000000-0000-0000-0000-000000000000	1886dcc1-83c7-45c5-88c9-de7d5033746e	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 06:11:34.532571+00	
00000000-0000-0000-0000-000000000000	5c16baa3-9054-4b44-9dab-7be165b6c348	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 07:10:04.443918+00	
00000000-0000-0000-0000-000000000000	66ab371d-90ac-410a-8579-1be42d1a54f9	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 07:10:04.455232+00	
00000000-0000-0000-0000-000000000000	fb4e8ded-e25d-49ac-bfc0-0c703e8187fb	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 08:08:23.468372+00	
00000000-0000-0000-0000-000000000000	65db8b2f-f53c-4bd6-8efb-d9f34c844b61	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 08:08:23.478514+00	
00000000-0000-0000-0000-000000000000	8c402f8e-a6b9-490e-bef8-ce7acb4fd437	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 10:03:14.144293+00	
00000000-0000-0000-0000-000000000000	4e8acf74-375f-47c5-9338-162e00bc5fd2	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2025-12-30 10:03:14.157965+00	
00000000-0000-0000-0000-000000000000	a6a55b75-9572-4cb0-a900-84ddac1c0787	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-03 13:51:08.774764+00	
00000000-0000-0000-0000-000000000000	13474de0-c8db-4e8f-8b6b-5c23b67e4ec1	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-03 14:54:24.866964+00	
00000000-0000-0000-0000-000000000000	0d0f8e97-5ca9-4fe8-91a4-f8437ded5146	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-03 14:54:24.881056+00	
00000000-0000-0000-0000-000000000000	6541cfb7-954f-4385-89bc-c384bc9d4cb2	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-03 15:10:27.090667+00	
00000000-0000-0000-0000-000000000000	bb7674ef-827e-4071-a0f1-0ad8fca850e1	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-03 16:27:34.270113+00	
00000000-0000-0000-0000-000000000000	c0b82d6b-339f-45a4-b9f3-bddc76fe24fa	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-03 16:27:34.282144+00	
00000000-0000-0000-0000-000000000000	84ef592b-fd29-45d8-8f11-c61b3e7c3728	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 09:56:25.412729+00	
00000000-0000-0000-0000-000000000000	ba9c2042-9d25-4fe1-9d76-3cbaffbccc38	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 09:56:25.429871+00	
00000000-0000-0000-0000-000000000000	e388c424-925b-40ed-94af-bd6eb694abee	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 10:06:27.251603+00	
00000000-0000-0000-0000-000000000000	d1a9d06c-8485-4cfc-b706-8903dcbcf6f9	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 10:06:27.262966+00	
00000000-0000-0000-0000-000000000000	83aa954d-7caf-4d5a-bc00-87537c92c3ac	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-04 10:06:41.427451+00	
00000000-0000-0000-0000-000000000000	d8d8ee67-a67e-4abb-a3c7-82f428f6995e	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 10:55:05.085846+00	
00000000-0000-0000-0000-000000000000	c5982983-8673-4a47-996c-758669c28dea	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 10:55:05.099349+00	
00000000-0000-0000-0000-000000000000	90b8a792-4002-4ff2-a193-af374dde149e	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 11:16:20.113681+00	
00000000-0000-0000-0000-000000000000	5e663fe5-3bc2-49bd-8a90-5734d9be715c	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 11:16:20.120109+00	
00000000-0000-0000-0000-000000000000	26e64a97-b4ef-433c-820a-6665ad5cf7a5	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 12:05:44.336206+00	
00000000-0000-0000-0000-000000000000	fe4ed612-1a67-437e-a760-2e951f75eacd	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 12:05:44.348599+00	
00000000-0000-0000-0000-000000000000	add38a2b-119a-4a42-a3e6-d14621f46023	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 12:22:17.792472+00	
00000000-0000-0000-0000-000000000000	8143a6d5-e3e7-4324-b37e-ad2da1005522	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 12:22:17.810498+00	
00000000-0000-0000-0000-000000000000	96e1c21a-6900-4e62-8bc4-cf87a6e6a948	{"action":"logout","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account"}	2026-01-04 12:22:22.379312+00	
00000000-0000-0000-0000-000000000000	7755faf9-6186-48a2-87f4-9470aac35587	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-04 12:47:47.526634+00	
00000000-0000-0000-0000-000000000000	8fcfeb02-9ff3-4004-8900-a5dca860c0d5	{"action":"logout","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account"}	2026-01-04 12:47:54.374103+00	
00000000-0000-0000-0000-000000000000	5aa9e0d5-4d2e-4f6b-b34e-687cfe682cfe	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-04 12:50:44.275323+00	
00000000-0000-0000-0000-000000000000	ce9505f3-a02e-4161-be25-6fcaaaa80e17	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-04 13:14:09.764457+00	
00000000-0000-0000-0000-000000000000	44c751de-b1ba-4547-9c37-c22a042f5702	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-04 13:38:00.130015+00	
00000000-0000-0000-0000-000000000000	c0c84ec6-4a84-43f0-ab83-f479b31bb936	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 13:59:12.542221+00	
00000000-0000-0000-0000-000000000000	78f171a6-47ea-400b-9995-859175a41e3c	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 13:59:12.548946+00	
00000000-0000-0000-0000-000000000000	372bb3dc-d4eb-4177-8f55-e465cbeab10a	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 15:06:13.485495+00	
00000000-0000-0000-0000-000000000000	14e22f2d-60ee-440c-bdac-d68bba22cea7	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 15:06:13.507912+00	
00000000-0000-0000-0000-000000000000	4929103b-bab0-416a-b58b-6f14b00934b8	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 15:06:23.009719+00	
00000000-0000-0000-0000-000000000000	bfd40611-2ecc-46bf-885e-bbef09e49f5c	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 15:06:23.011051+00	
00000000-0000-0000-0000-000000000000	c0a8f28b-cf9d-4b6b-b984-b14128ff3247	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 16:18:54.117637+00	
00000000-0000-0000-0000-000000000000	99b5212b-9410-4604-b698-b7472d7c63e5	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 16:18:54.137758+00	
00000000-0000-0000-0000-000000000000	088036da-a7f1-4085-aaa0-013daa3e145d	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 16:49:58.631257+00	
00000000-0000-0000-0000-000000000000	b78e9f98-4b49-47cb-a2e7-cffd44b4fcaa	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 16:49:58.647044+00	
00000000-0000-0000-0000-000000000000	4ffe35a5-8ad0-43d7-98bd-9f67784efd54	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 17:17:15.557763+00	
00000000-0000-0000-0000-000000000000	37b28b7a-fa43-497c-8e44-af32bb832be3	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 17:17:15.568593+00	
00000000-0000-0000-0000-000000000000	2da9a4eb-1e60-46db-9ef4-d7112613739e	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 18:03:50.092609+00	
00000000-0000-0000-0000-000000000000	c2593ee5-2ec6-44d3-8627-038d1fb05284	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 18:03:50.109444+00	
00000000-0000-0000-0000-000000000000	3da5cde7-8e9a-485f-bce0-a4a2c29fd109	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 18:21:19.668533+00	
00000000-0000-0000-0000-000000000000	9a1ed2c1-8c5e-4cd6-ba01-824a2b5fbbcf	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 18:21:19.678123+00	
00000000-0000-0000-0000-000000000000	cc5b9827-745b-4480-9edd-89774f2a9a91	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 19:04:46.704611+00	
00000000-0000-0000-0000-000000000000	39cbb8a1-8f28-46a5-9d4c-3f4b32e5470b	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 19:04:46.719907+00	
00000000-0000-0000-0000-000000000000	b851a7cd-1dfa-4466-85df-0a13423f2d1e	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 20:05:33.258387+00	
00000000-0000-0000-0000-000000000000	de821eb7-ea1e-4d34-9436-85b2742d4ea1	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 20:05:33.27215+00	
00000000-0000-0000-0000-000000000000	cc2f9ee6-ee18-45ff-8d2e-e5d52eebae44	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 20:05:42.863393+00	
00000000-0000-0000-0000-000000000000	586e5ad9-d502-4735-80ad-798ef780992d	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 20:05:42.865386+00	
00000000-0000-0000-0000-000000000000	4e48082a-70fd-456e-9b92-51139cc31336	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 21:06:30.058577+00	
00000000-0000-0000-0000-000000000000	23fd2bf4-fdd2-416d-9ce6-579d2b154151	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 21:06:30.068828+00	
00000000-0000-0000-0000-000000000000	55b81f04-503c-4b34-837a-1b05c174bf36	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 21:06:39.706831+00	
00000000-0000-0000-0000-000000000000	baf227ee-3ab1-4e33-a4af-01199a8d0cad	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 21:06:39.708197+00	
00000000-0000-0000-0000-000000000000	f92e77b7-03a0-4772-9eb3-39fe9119af1c	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 22:07:45.286843+00	
00000000-0000-0000-0000-000000000000	85065d9a-23f7-4096-be25-7c1c896867c2	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 22:07:45.294959+00	
00000000-0000-0000-0000-000000000000	a4351546-91c2-470e-be03-f3bbb6f096c7	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 22:07:54.946762+00	
00000000-0000-0000-0000-000000000000	16cab4df-ec0e-42a5-8569-c0df488e223e	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 22:07:54.948526+00	
00000000-0000-0000-0000-000000000000	8ca69c36-49eb-4c33-9a9e-338dbf515ca0	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 23:10:43.728535+00	
00000000-0000-0000-0000-000000000000	9310bbcd-db22-491b-b0d2-0bab8d213fb6	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 23:10:43.741809+00	
00000000-0000-0000-0000-000000000000	822dca8a-db3e-46f8-88b2-b9434bc0d76e	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 23:10:53.010923+00	
00000000-0000-0000-0000-000000000000	66265d8a-b483-4ce2-aab5-dd4284724803	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-04 23:10:53.011623+00	
00000000-0000-0000-0000-000000000000	744c4041-dd62-42ce-81bf-b4ac60c945af	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 00:09:41.170972+00	
00000000-0000-0000-0000-000000000000	656e9f22-683e-4504-ae75-63605634793d	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 00:09:41.189939+00	
00000000-0000-0000-0000-000000000000	67fcf5a2-d7a5-4736-83bc-529c98450061	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 00:09:50.815452+00	
00000000-0000-0000-0000-000000000000	502a1627-193d-4ccb-b797-143ea6188252	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 00:09:50.816148+00	
00000000-0000-0000-0000-000000000000	2abbb2ef-37fe-402e-a1b1-122ee9d19d7c	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 01:07:42.375272+00	
00000000-0000-0000-0000-000000000000	fe74e346-da57-41fb-9fba-07b9d2998252	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 01:07:42.386101+00	
00000000-0000-0000-0000-000000000000	a448ef45-2273-4fa5-9f10-895d8bbb92ce	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 01:10:22.417623+00	
00000000-0000-0000-0000-000000000000	f48950f8-2beb-454a-b8dc-6f1d4152c3ed	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 01:10:22.420329+00	
00000000-0000-0000-0000-000000000000	9d98d429-72fb-4afc-bee3-0a18b954914b	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 02:09:06.663447+00	
00000000-0000-0000-0000-000000000000	cd4af033-7581-4e20-8700-bc4131bea31a	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 02:09:06.683382+00	
00000000-0000-0000-0000-000000000000	bdbc1ba4-0aad-40e8-9fc3-2e4bd77ee729	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 02:09:16.239856+00	
00000000-0000-0000-0000-000000000000	6eccca2d-5206-48ab-bbcf-d34b39087385	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 02:09:16.244211+00	
00000000-0000-0000-0000-000000000000	3f6b86ef-60e8-45da-a394-66bbb396d644	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 03:12:24.087167+00	
00000000-0000-0000-0000-000000000000	8d9260f7-1664-41f9-a181-32acb1b9a60b	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 03:12:24.096703+00	
00000000-0000-0000-0000-000000000000	b8dc8c25-5e02-47bc-b45f-9ec0f6e5a8cb	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 03:12:33.81794+00	
00000000-0000-0000-0000-000000000000	bbb83379-522e-4c4e-8dd4-9c41e3e8e402	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 03:12:33.819967+00	
00000000-0000-0000-0000-000000000000	314f3b0f-5259-4932-b2b9-0ee0d73931d7	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 04:13:39.455312+00	
00000000-0000-0000-0000-000000000000	46e69704-ad69-420f-a7a4-5a3ef53ca2d3	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 04:13:39.470915+00	
00000000-0000-0000-0000-000000000000	6fa1069b-97fc-4f38-9d5a-fa6118f5a108	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 04:13:49.067489+00	
00000000-0000-0000-0000-000000000000	cf345c13-408a-4ce9-b87d-6808d315731a	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 04:13:49.071068+00	
00000000-0000-0000-0000-000000000000	bfe60650-4eba-4daa-b50d-692b562ec0d4	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-05 04:59:14.88831+00	
00000000-0000-0000-0000-000000000000	f61796fd-6a53-4f04-bb24-aee4551584dc	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 05:15:23.308904+00	
00000000-0000-0000-0000-000000000000	788c0df4-352c-4d1d-a18c-95168c1c70aa	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 05:15:23.319052+00	
00000000-0000-0000-0000-000000000000	c4dd5330-5b6c-4058-bce3-e9543e6b3ea8	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 05:15:32.958538+00	
00000000-0000-0000-0000-000000000000	9c4f0ddb-505a-44a1-ba0d-46c7273a8a90	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 05:15:32.960276+00	
00000000-0000-0000-0000-000000000000	4f487e61-5943-43e7-9a4b-a5082633cf2b	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 06:13:25.15789+00	
00000000-0000-0000-0000-000000000000	490c0cb4-9292-41e4-96b8-5be113dcc0f2	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 06:13:25.17391+00	
00000000-0000-0000-0000-000000000000	7b66854b-c33c-4c4e-a2a6-30beec42b875	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 06:13:32.898811+00	
00000000-0000-0000-0000-000000000000	ae0c9c95-0d20-448b-a493-9b0b6b8447c6	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 06:13:32.901541+00	
00000000-0000-0000-0000-000000000000	9bf63984-c7a4-46f7-a1c7-a21a19efb251	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 06:48:57.906547+00	
00000000-0000-0000-0000-000000000000	fdec99c5-aae6-42b0-93b2-56c2397024d0	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 06:48:57.918614+00	
00000000-0000-0000-0000-000000000000	6a3e0a54-4ad7-43d9-a409-bd950f53a0a0	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 07:11:39.707293+00	
00000000-0000-0000-0000-000000000000	513ef372-1719-45b5-ace2-94eb9faa0a6e	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 07:11:39.710264+00	
00000000-0000-0000-0000-000000000000	86b0a185-c843-4e7f-879e-58ce5781b318	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 07:47:21.310498+00	
00000000-0000-0000-0000-000000000000	d049b023-e202-440e-9e42-f474dd4d2471	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-05 07:47:21.328674+00	
00000000-0000-0000-0000-000000000000	9f63d82c-fc56-46fa-aac8-faa55cd59597	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 03:29:51.912968+00	
00000000-0000-0000-0000-000000000000	be859e66-c5d7-4608-ae22-666e49359c20	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 03:29:51.939077+00	
00000000-0000-0000-0000-000000000000	937a2282-4d59-46b6-9cb9-bb3b5d06d79b	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 03:34:51.684406+00	
00000000-0000-0000-0000-000000000000	51f250c2-049c-4e6e-bbda-b4ad3815992b	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 03:34:51.690601+00	
00000000-0000-0000-0000-000000000000	308c0519-95da-4eba-ac7c-4937a005cd74	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 04:31:35.470679+00	
00000000-0000-0000-0000-000000000000	9607f3e1-c207-40e7-9a66-3d9d889cbd57	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 04:31:35.48327+00	
00000000-0000-0000-0000-000000000000	4b1740da-902e-457c-96c5-b2f9dcc7d0a6	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 04:32:52.830683+00	
00000000-0000-0000-0000-000000000000	fb745f26-9c79-46ae-a3e7-9a0371ba5cdb	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 04:32:52.831849+00	
00000000-0000-0000-0000-000000000000	847fe034-e245-4d5d-be65-0b757dbc26f0	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 05:30:05.576927+00	
00000000-0000-0000-0000-000000000000	f1ac98ce-e442-4711-bc95-924b6cbd45ee	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 05:30:05.591641+00	
00000000-0000-0000-0000-000000000000	39d5f7c0-78bb-4f0e-bc41-b201542a9495	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 05:30:53.880004+00	
00000000-0000-0000-0000-000000000000	6063bbac-df57-40a6-a7de-f5efdb7bf082	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 05:30:53.881753+00	
00000000-0000-0000-0000-000000000000	b300ff1d-a290-4343-b4ea-1ea8adbd4167	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 05:40:56.002766+00	
00000000-0000-0000-0000-000000000000	95d3233e-999f-4be5-ac3c-6fd4f19fe5a6	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 05:40:56.011324+00	
00000000-0000-0000-0000-000000000000	0bf67f32-e6b1-4c03-91b3-5f5f24632008	{"action":"logout","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account"}	2026-01-06 06:18:57.872878+00	
00000000-0000-0000-0000-000000000000	a502cba5-843d-4ae4-a755-9a0594c0c312	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-06 06:18:59.217529+00	
00000000-0000-0000-0000-000000000000	dfe684aa-68da-4742-b15b-aed632b77ade	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 07:17:00.329517+00	
00000000-0000-0000-0000-000000000000	07ab4d3e-d368-4996-9858-c6cf4e196ae4	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 07:17:00.346414+00	
00000000-0000-0000-0000-000000000000	cb55fa3c-5043-492f-a66e-a4b9bc3f7989	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-06 07:36:18.913744+00	
00000000-0000-0000-0000-000000000000	09128b97-0c80-488c-85a0-fbb65f07528b	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 08:34:20.068508+00	
00000000-0000-0000-0000-000000000000	d4995812-3ecd-4e5a-8aa3-eb1c3b11b499	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 08:34:20.084448+00	
00000000-0000-0000-0000-000000000000	ba1f17df-4755-498d-9726-2ff1c67360f9	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 09:32:22.607249+00	
00000000-0000-0000-0000-000000000000	9a6bbd83-d29d-4842-a389-6c81d5711b8b	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 09:32:22.624033+00	
00000000-0000-0000-0000-000000000000	a7ddae04-a0c2-4d73-b760-36637c0469f9	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-06 10:16:45.133556+00	
00000000-0000-0000-0000-000000000000	b4439258-0e55-4880-bc10-2c5fc7ebda18	{"action":"logout","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account"}	2026-01-06 10:17:15.559985+00	
00000000-0000-0000-0000-000000000000	d869ffb7-deb6-4c5d-a311-3377db01ef52	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-06 10:17:16.878669+00	
00000000-0000-0000-0000-000000000000	71dd3ca9-3863-401f-a118-4e681fb34c6b	{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"provider":"email","user_email":"ayelet@ringan.com","user_id":"532d536e-a390-421d-a265-e5a1253624c8","user_phone":""}}	2026-01-06 10:35:15.428796+00	
00000000-0000-0000-0000-000000000000	b7b76dc2-2ae1-42d3-9d87-e2b32d31f185	{"action":"login","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-06 10:35:22.328726+00	
00000000-0000-0000-0000-000000000000	d0046e49-9422-458c-b4ac-77881aff30a0	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-06 10:51:12.868485+00	
00000000-0000-0000-0000-000000000000	f9c8e501-a826-476f-b9ff-bd0cd8ebff56	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-06 10:58:27.595381+00	
00000000-0000-0000-0000-000000000000	abf791a7-a947-4296-bd6c-e72c20bb4299	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 11:22:03.161817+00	
00000000-0000-0000-0000-000000000000	35161f6c-b85c-4176-be28-f2bbe2c359a8	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 11:22:03.173865+00	
00000000-0000-0000-0000-000000000000	faf891b9-b817-45de-9d04-ff428b5bab9d	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 11:33:31.478374+00	
00000000-0000-0000-0000-000000000000	1182a5df-8ad9-4177-8278-12fe86432e25	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 11:33:31.493556+00	
00000000-0000-0000-0000-000000000000	b26e1980-6e0f-4cc3-a4ee-d579a4ca9890	{"action":"logout","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account"}	2026-01-06 11:42:31.291953+00	
00000000-0000-0000-0000-000000000000	407e24e2-bd5e-401b-8e39-2cce75e0b6cc	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-06 11:42:32.418517+00	
00000000-0000-0000-0000-000000000000	b8b76b61-d384-4d99-b791-08edc0ab2381	{"action":"login","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-06 12:20:06.079555+00	
00000000-0000-0000-0000-000000000000	d74e1b0e-7f5e-4854-8eae-a8312736eb81	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 12:32:01.215591+00	
00000000-0000-0000-0000-000000000000	042818ea-d3bf-4867-9884-6a9b98889a19	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 12:32:01.236+00	
00000000-0000-0000-0000-000000000000	09423ec7-f408-4229-8467-b56284a2674f	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 14:36:38.019086+00	
00000000-0000-0000-0000-000000000000	d8a7925a-f6c9-4d2e-9156-f4579302a1da	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 14:36:38.03777+00	
00000000-0000-0000-0000-000000000000	375a766f-d26f-4e14-8e63-886bbdf15f20	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 17:28:56.908205+00	
00000000-0000-0000-0000-000000000000	f8bddeae-6ebe-4b03-8a72-0c613c5413be	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 17:28:56.928124+00	
00000000-0000-0000-0000-000000000000	0abb1fa0-30cb-4541-a65e-5b2113a489c5	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 18:27:26.605546+00	
00000000-0000-0000-0000-000000000000	e51bfa8c-2789-446e-b205-298e362027e9	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-06 18:27:26.620937+00	
00000000-0000-0000-0000-000000000000	372f19dd-f7a4-44ff-a4db-7aea55a8ff35	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-11 07:06:50.589163+00	
00000000-0000-0000-0000-000000000000	c2d8121d-e6b1-4ac3-932c-70e591cc5771	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-11 07:06:50.616323+00	
00000000-0000-0000-0000-000000000000	60777bc8-505b-4e17-8020-8ed7dd06e3ad	{"action":"logout","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account"}	2026-01-11 07:06:55.495593+00	
00000000-0000-0000-0000-000000000000	6398a922-7125-4da2-bf78-968d38e92bae	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-11 07:15:10.571387+00	
00000000-0000-0000-0000-000000000000	a6dc33e5-7133-42c5-9ea2-e464c607e6ba	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-11 08:14:19.342122+00	
00000000-0000-0000-0000-000000000000	9753b799-bc19-43d6-81e0-7bc697561df8	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-11 08:14:19.356889+00	
00000000-0000-0000-0000-000000000000	3e2dba3e-4e20-4fa4-891c-6eab648a2ff4	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-11 08:40:09.756073+00	
00000000-0000-0000-0000-000000000000	d3412ddf-5188-4a1a-bfe3-2639beb56b80	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 04:35:36.691551+00	
00000000-0000-0000-0000-000000000000	4686514e-9309-484a-952a-ac66835c207a	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 04:35:36.714245+00	
00000000-0000-0000-0000-000000000000	815fae30-ab80-4122-8b25-89a32c69c0aa	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 04:47:12.373511+00	
00000000-0000-0000-0000-000000000000	68240541-6b52-4cb5-87d6-80af6739ee9d	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 04:47:12.377625+00	
00000000-0000-0000-0000-000000000000	aeb1afc2-745d-4d05-a2a8-a95bf128f536	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 05:59:59.090737+00	
00000000-0000-0000-0000-000000000000	6f583ef9-2637-4772-abbd-2634e6ff628c	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 05:59:59.114932+00	
00000000-0000-0000-0000-000000000000	606251f4-10dd-4053-b452-8812f2382146	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 06:58:00.696377+00	
00000000-0000-0000-0000-000000000000	16b5d3e3-5b06-4737-bf35-0a02201fcd28	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 06:58:00.719565+00	
00000000-0000-0000-0000-000000000000	e52e833b-6ee1-4edc-9a9b-92f20fb7a23e	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 07:00:19.403239+00	
00000000-0000-0000-0000-000000000000	6ee9dad4-848d-47f5-8eb8-404077876e85	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 07:00:19.404262+00	
00000000-0000-0000-0000-000000000000	e5713fe9-98dc-4713-a2db-46fbd7aff4ef	{"action":"login","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-13 07:56:28.00967+00	
00000000-0000-0000-0000-000000000000	c31bebbe-511a-47a2-8e68-67854a0b0d9a	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-01-13 11:04:19.256196+00	
00000000-0000-0000-0000-000000000000	049af96d-b16d-4a96-8b1a-e1fa878f7b83	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 11:45:51.031411+00	
00000000-0000-0000-0000-000000000000	7e113664-e3f8-48c1-a878-31a55f922fbe	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 11:45:51.048938+00	
00000000-0000-0000-0000-000000000000	db77c4d7-ac2a-4fc3-8463-8b76625f3b2d	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 12:06:55.966973+00	
00000000-0000-0000-0000-000000000000	91dc403c-5285-4f4c-b2fb-cf4033f17624	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 12:06:55.980208+00	
00000000-0000-0000-0000-000000000000	357c26e8-0400-4b01-8dcb-e434925a0cba	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 12:06:58.769358+00	
00000000-0000-0000-0000-000000000000	f0826bea-e812-4c9d-8e55-ccf3c0f973d0	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 12:06:58.769972+00	
00000000-0000-0000-0000-000000000000	99b0c953-44f9-4e1b-a9c9-94f7faff097f	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 12:10:30.640288+00	
00000000-0000-0000-0000-000000000000	351599b1-6b0f-4154-b17a-472ba0fe4c38	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 12:10:30.64464+00	
00000000-0000-0000-0000-000000000000	799872f5-52d7-4b6a-9904-9b5f5fe41c66	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 12:50:43.825716+00	
00000000-0000-0000-0000-000000000000	d221ebb0-a13e-4c32-9ed1-0946030b2edb	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 12:50:43.84381+00	
00000000-0000-0000-0000-000000000000	5a65018c-da1e-4e0d-94a6-82e3816b7c08	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 13:08:35.123691+00	
00000000-0000-0000-0000-000000000000	5850b333-db50-49bb-a543-fbdfa8ec9ed7	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 13:08:35.132116+00	
00000000-0000-0000-0000-000000000000	1a67d6b5-745c-48f0-80ee-de430d13898b	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 13:23:22.514408+00	
00000000-0000-0000-0000-000000000000	18236d9a-85bd-4af5-85e9-089868ecf137	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 13:23:22.520585+00	
00000000-0000-0000-0000-000000000000	2cd5b68c-5221-4a25-bffc-5c19b9776382	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 13:48:47.402252+00	
00000000-0000-0000-0000-000000000000	608be0f5-6e39-4550-85b9-011cef8e04d3	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 13:48:47.420068+00	
00000000-0000-0000-0000-000000000000	7fa8456f-98b5-429d-aff1-29467d47dbc1	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 20:01:35.453376+00	
00000000-0000-0000-0000-000000000000	88735949-4984-4a79-b943-c7b05684f113	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-13 20:01:35.477549+00	
00000000-0000-0000-0000-000000000000	640d5bf2-b3bb-41b0-ad8b-459e10f9cfa5	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-17 13:58:08.233133+00	
00000000-0000-0000-0000-000000000000	58d0e2c3-1616-41aa-aab8-23e61b7a95e0	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-17 13:58:08.261916+00	
00000000-0000-0000-0000-000000000000	e729c6d0-3ef1-43fb-821f-5bfed47609b3	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-17 14:56:44.406472+00	
00000000-0000-0000-0000-000000000000	9ba5580b-5957-456a-b5a6-f1ed9fba848b	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-17 14:56:44.420216+00	
00000000-0000-0000-0000-000000000000	24dbfacd-c006-4f71-b7b4-751d073a0f2e	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-24 06:19:54.694498+00	
00000000-0000-0000-0000-000000000000	a7f45f39-663d-4763-b414-5a3c05a8f90c	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-24 06:19:54.723726+00	
00000000-0000-0000-0000-000000000000	e165add1-c1fa-4d08-97fd-328481d1e00b	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-24 13:37:06.085988+00	
00000000-0000-0000-0000-000000000000	25e59c64-0b00-4c0c-889c-d662851bf185	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-24 13:37:06.109422+00	
00000000-0000-0000-0000-000000000000	a92173e2-2f06-44f3-835a-68d72c620ebc	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-24 14:54:54.074543+00	
00000000-0000-0000-0000-000000000000	a3ac7122-dc7a-4193-8a56-eb457f3db223	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-24 14:54:54.084603+00	
00000000-0000-0000-0000-000000000000	d93a57ac-8ff1-487b-a087-0a45a8ad1468	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-24 17:18:09.8119+00	
00000000-0000-0000-0000-000000000000	503b55b9-68f0-4957-93b7-4e4f1b863fb0	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-24 17:18:09.838785+00	
00000000-0000-0000-0000-000000000000	eda94172-6565-4218-bb45-c83aa952b006	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 09:54:30.121232+00	
00000000-0000-0000-0000-000000000000	d913e496-ad87-4d6e-9531-d88e8ca0faf0	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 09:54:30.149915+00	
00000000-0000-0000-0000-000000000000	88d3a33b-dd57-4953-9b7d-a3d275e56376	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 10:00:08.629153+00	
00000000-0000-0000-0000-000000000000	9c97cc5c-eea5-4165-ba52-ce0e6c79d8aa	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 10:00:08.630195+00	
00000000-0000-0000-0000-000000000000	98567ec5-a9c4-4bd1-91e7-e419d119ed36	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 11:02:22.92452+00	
00000000-0000-0000-0000-000000000000	40429eb8-2e78-4b58-a2eb-0d5ddac88243	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 11:02:22.943537+00	
00000000-0000-0000-0000-000000000000	acf8b2cc-3dae-41da-853c-8d5099c073b2	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 11:10:27.302878+00	
00000000-0000-0000-0000-000000000000	362f86ab-9b1b-40ef-b887-e7571e37c784	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 11:10:27.315371+00	
00000000-0000-0000-0000-000000000000	b47602b2-348c-4212-b790-d2606fec08ff	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 11:11:33.416438+00	
00000000-0000-0000-0000-000000000000	d5e751ae-fee3-44d0-af36-c2a81b77a474	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 11:11:33.423971+00	
00000000-0000-0000-0000-000000000000	845341da-bd90-4dac-893b-2f543d827bb8	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 12:09:43.684652+00	
00000000-0000-0000-0000-000000000000	2cec2b13-3d0b-4a3a-913a-56131e2011d9	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 12:09:43.69571+00	
00000000-0000-0000-0000-000000000000	8a5944fa-7122-4e49-ae72-ca01c94dbf2f	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 13:11:30.561936+00	
00000000-0000-0000-0000-000000000000	0ef821c1-e34b-495d-8321-9005bdec034b	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 13:11:30.585468+00	
00000000-0000-0000-0000-000000000000	47debe16-2f16-4708-8f31-93c11e17242d	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 14:09:32.702385+00	
00000000-0000-0000-0000-000000000000	2ff5da87-4db8-42e4-911c-4e59355c712c	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-27 14:09:32.727147+00	
00000000-0000-0000-0000-000000000000	9e8a3354-ad09-40ac-9258-1bcda59bc9d0	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-28 05:23:58.70955+00	
00000000-0000-0000-0000-000000000000	cfadc315-37de-4ebc-9511-bab2667dd0b1	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-01-28 05:23:58.73626+00	
00000000-0000-0000-0000-000000000000	68d0fd8d-78fe-4578-88da-036e6acc6e51	{"action":"login","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-10 07:11:20.975665+00	
00000000-0000-0000-0000-000000000000	0d9f8e6a-6ec5-4e7f-9395-d808fe8863f2	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-02-10 07:11:41.121972+00	
00000000-0000-0000-0000-000000000000	de3d09c4-e85b-413a-9d28-a13f442c2495	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-02-10 07:11:41.130079+00	
00000000-0000-0000-0000-000000000000	9e249912-fb32-47af-98d0-425d051617bd	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-02-10 08:09:47.884062+00	
00000000-0000-0000-0000-000000000000	f77081d8-b0cd-4964-ae8b-85fa92e99861	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-02-10 08:09:47.894585+00	
00000000-0000-0000-0000-000000000000	ec61f446-38c1-4639-a2a0-f4d9e43bc47e	{"action":"login","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-02-24 07:52:17.243434+00	
00000000-0000-0000-0000-000000000000	ea966e66-909a-4515-854a-6ea0e803d5ce	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-02-24 12:01:27.31785+00	
00000000-0000-0000-0000-000000000000	67a3553d-3770-4a87-8881-3d326a5c5d1f	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-02-24 12:01:27.341192+00	
00000000-0000-0000-0000-000000000000	7a82e9e4-b95e-40e1-82fd-59a1b6446e71	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-02-24 13:18:08.163194+00	
00000000-0000-0000-0000-000000000000	91d635cb-a0c3-46cf-b5d3-5b6e87ed1424	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-02-24 13:18:08.172791+00	
00000000-0000-0000-0000-000000000000	ea211a56-9571-495d-b5c0-a562e365e686	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-02-26 08:00:46.276629+00	
00000000-0000-0000-0000-000000000000	175cd179-ec49-49a0-bbbe-1c360e70db5e	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-02-26 08:00:46.296662+00	
00000000-0000-0000-0000-000000000000	fc81060b-2ed7-4d95-9109-ea598bf27295	{"action":"token_refreshed","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-17 08:18:40.129733+00	
00000000-0000-0000-0000-000000000000	854e0544-0f5a-444c-bb23-05fe7f706a5a	{"action":"token_revoked","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-17 08:18:40.142015+00	
00000000-0000-0000-0000-000000000000	a5122921-feff-4ab9-b396-24edd65247cf	{"action":"logout","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"account"}	2026-03-17 08:18:43.476789+00	
00000000-0000-0000-0000-000000000000	ddc7f06f-4eee-47a3-a158-467c08cc9e36	{"action":"login","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-03-17 08:18:45.342999+00	
00000000-0000-0000-0000-000000000000	76667754-638a-4a66-b93d-7ea8b4a600d4	{"action":"logout","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"account"}	2026-03-17 08:20:45.987062+00	
00000000-0000-0000-0000-000000000000	de9368d4-8d1d-4cfd-abd6-c959069c8810	{"action":"login","actor_id":"532d536e-a390-421d-a265-e5a1253624c8","actor_username":"ayelet@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-03-17 08:20:47.179156+00	
00000000-0000-0000-0000-000000000000	3956fa28-648b-4e74-85b6-712d69bb77a6	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-17 10:34:31.993764+00	
00000000-0000-0000-0000-000000000000	3f266b32-fb01-42e5-83dc-4aaddb362056	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-17 10:34:32.012923+00	
00000000-0000-0000-0000-000000000000	1fba6ca3-6080-486e-89e4-15cfdcbaad62	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-17 11:32:43.684645+00	
00000000-0000-0000-0000-000000000000	6d1a4cb6-e4a4-4eb8-9123-fa26b1e92a91	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-17 11:32:43.696963+00	
00000000-0000-0000-0000-000000000000	401b1064-6ef4-4752-b2aa-73dbf3cda914	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-17 12:30:43.894433+00	
00000000-0000-0000-0000-000000000000	509d03ba-0662-4ea6-9b9f-19b5f8fc1480	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-17 12:30:43.908098+00	
00000000-0000-0000-0000-000000000000	d70423a2-c459-4d77-83d1-ec7803cfd7d1	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-17 13:30:51.431993+00	
00000000-0000-0000-0000-000000000000	e6e46278-8119-453e-88cb-d959598f66c2	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-17 13:30:51.44388+00	
00000000-0000-0000-0000-000000000000	25666448-d48d-4736-a63f-9f06cc592a53	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-17 14:55:51.795644+00	
00000000-0000-0000-0000-000000000000	c58fe413-5545-45ee-ad13-c148e512b10f	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-17 14:55:51.81506+00	
00000000-0000-0000-0000-000000000000	5c71be13-3620-4456-971f-651de762ce35	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-17 22:00:04.497827+00	
00000000-0000-0000-0000-000000000000	ba9ad78f-4088-4017-be32-45ea87d82636	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-17 22:00:04.520215+00	
00000000-0000-0000-0000-000000000000	bbb6959f-df2b-4d55-82c3-b8b751eaa049	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-17 22:58:04.685556+00	
00000000-0000-0000-0000-000000000000	8ab27b13-84ae-48f6-90bb-527d9bbef4f5	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-17 22:58:04.716625+00	
00000000-0000-0000-0000-000000000000	577d4107-5c45-4347-81c6-f3251c76328f	{"action":"logout","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account"}	2026-03-17 23:36:10.019334+00	
00000000-0000-0000-0000-000000000000	f2187f9b-b773-4e00-9339-262cb4f24d0b	{"action":"login","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2026-03-17 23:41:56.670282+00	
00000000-0000-0000-0000-000000000000	dbffee9c-0e17-4373-b2fc-252f441aac0a	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-18 04:55:46.948277+00	
00000000-0000-0000-0000-000000000000	c4557943-702a-42b4-bbca-df202a47ea55	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-18 04:55:46.972883+00	
00000000-0000-0000-0000-000000000000	45b7c7fa-81af-40c1-9e71-e0d92395209f	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-19 09:00:50.815723+00	
00000000-0000-0000-0000-000000000000	ed37f576-4f49-45a3-8761-97a44ecb80dc	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-19 09:00:50.841837+00	
00000000-0000-0000-0000-000000000000	2836d6e6-11f4-4edb-95f1-e96023d88509	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-19 10:43:12.584616+00	
00000000-0000-0000-0000-000000000000	c007a902-432a-47c6-b0fd-f97cc93ba920	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-19 10:43:12.605348+00	
00000000-0000-0000-0000-000000000000	9aee10de-f186-45c8-b12a-2888b1c9b965	{"action":"token_refreshed","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-19 17:22:44.879802+00	
00000000-0000-0000-0000-000000000000	7c974978-c43c-47b2-9a0d-f32618bc6268	{"action":"token_revoked","actor_id":"e9d8d519-8bb2-4be2-b276-674bdf554017","actor_username":"raheli@ringan.com","actor_via_sso":false,"log_type":"token"}	2026-03-19 17:22:44.888292+00	
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."custom_oauth_providers" ("id", "provider_type", "identifier", "name", "client_id", "client_secret", "acceptable_client_ids", "scopes", "pkce_enabled", "attribute_mapping", "authorization_params", "enabled", "email_optional", "issuer", "discovery_url", "skip_nonce_check", "cached_discovery", "discovery_cached_at", "authorization_url", "token_url", "userinfo_url", "jwks_uri", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."flow_state" ("id", "user_id", "auth_code", "code_challenge_method", "code_challenge", "provider_type", "provider_access_token", "provider_refresh_token", "created_at", "updated_at", "authentication_method", "auth_code_issued_at", "invite_token", "referrer", "oauth_client_state_id", "linking_target_id", "email_optional") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") FROM stdin;
00000000-0000-0000-0000-000000000000	18b21873-eb44-47b2-9dd5-6357f3f9d3b2	authenticated	authenticated	anjoe@msa.com	$2a$10$sQA/bvfnlKMkzKu36pr76O0v3zkCpp2paJOhchQoPq8mXUuk7FPm2	2025-09-13 13:16:26.622526+00	\N		\N		\N			\N	\N	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-09-13 13:16:26.58213+00	2025-09-13 13:16:26.623578+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	532d536e-a390-421d-a265-e5a1253624c8	authenticated	authenticated	ayelet@ringan.com	$2a$10$4h4qhYTGObW/X8oxdlPQjOlDPHz6OO1opiQCCkzyM0H.RUbS3i74i	2026-01-06 10:35:15.438138+00	\N		\N		\N			\N	2026-03-17 08:20:47.179933+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2026-01-06 10:35:15.397677+00	2026-03-17 08:20:47.18533+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	e9d8d519-8bb2-4be2-b276-674bdf554017	authenticated	authenticated	raheli@ringan.com	$2a$10$2DWOFJ294ayNmbC/ZWlVCeZOowx.E.Xie12f.YVBExXMdV6PduIHG	2025-12-11 12:00:09.349407+00	\N		\N		\N			\N	2026-03-17 23:41:56.67937+00	{"provider": "email", "providers": ["email"]}	{"email_verified": true}	\N	2025-12-11 12:00:09.284491+00	2026-03-19 17:22:44.902521+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") FROM stdin;
18b21873-eb44-47b2-9dd5-6357f3f9d3b2	18b21873-eb44-47b2-9dd5-6357f3f9d3b2	{"sub": "18b21873-eb44-47b2-9dd5-6357f3f9d3b2", "email": "anjoe@msa.com", "email_verified": false, "phone_verified": false}	email	2025-09-13 13:16:26.602167+00	2025-09-13 13:16:26.602234+00	2025-09-13 13:16:26.602234+00	7e26adb8-0ae8-480a-bb65-edd3c5614d47
e9d8d519-8bb2-4be2-b276-674bdf554017	e9d8d519-8bb2-4be2-b276-674bdf554017	{"sub": "e9d8d519-8bb2-4be2-b276-674bdf554017", "email": "raheli@ringan.com", "email_verified": false, "phone_verified": false}	email	2025-12-11 12:00:09.314614+00	2025-12-11 12:00:09.314677+00	2025-12-11 12:00:09.314677+00	7947a176-f989-463e-8021-a98f38aa5760
532d536e-a390-421d-a265-e5a1253624c8	532d536e-a390-421d-a265-e5a1253624c8	{"sub": "532d536e-a390-421d-a265-e5a1253624c8", "email": "ayelet@ringan.com", "email_verified": false, "phone_verified": false}	email	2026-01-06 10:35:15.420113+00	2026-01-06 10:35:15.420176+00	2026-01-06 10:35:15.420176+00	7a0104b3-7d65-4fde-98a7-ef6e84598587
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."instances" ("id", "uuid", "raw_base_config", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_clients" ("id", "client_secret_hash", "registration_type", "redirect_uris", "grant_types", "client_name", "client_uri", "logo_uri", "created_at", "updated_at", "deleted_at", "client_type", "token_endpoint_auth_method") FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag", "oauth_client_id", "refresh_token_hmac_key", "refresh_token_counter", "scopes") FROM stdin;
a1860585-3d46-4de6-8d0f-9ff6302e84dd	532d536e-a390-421d-a265-e5a1253624c8	2026-03-17 08:20:47.180932+00	2026-03-17 08:20:47.180932+00	\N	aal1	\N	\N	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0	180.245.160.12	\N	\N	\N	\N	\N
6c67be93-fa56-4dae-bcc7-3c39fc50e279	e9d8d519-8bb2-4be2-b276-674bdf554017	2026-03-17 23:41:56.68005+00	2026-03-19 17:22:44.913191+00	\N	aal1	\N	2026-03-19 17:22:44.912604	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0	180.245.160.12	\N	\N	\N	\N	\N
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") FROM stdin;
a1860585-3d46-4de6-8d0f-9ff6302e84dd	2026-03-17 08:20:47.185954+00	2026-03-17 08:20:47.185954+00	password	71220104-a376-4e9c-9f79-bc8a597bae01
6c67be93-fa56-4dae-bcc7-3c39fc50e279	2026-03-17 23:41:56.716259+00	2026-03-17 23:41:56.716259+00	password	4ab7d58b-b159-4a31-aa53-ef465e21f517
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_factors" ("id", "user_id", "friendly_name", "factor_type", "status", "created_at", "updated_at", "secret", "phone", "last_challenged_at", "web_authn_credential", "web_authn_aaguid", "last_webauthn_challenge_data") FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."mfa_challenges" ("id", "factor_id", "created_at", "verified_at", "ip_address", "otp_code", "web_authn_session_data") FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_authorizations" ("id", "authorization_id", "client_id", "user_id", "redirect_uri", "scope", "state", "resource", "code_challenge", "code_challenge_method", "response_type", "status", "authorization_code", "created_at", "expires_at", "approved_at", "nonce") FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_client_states" ("id", "provider_type", "code_verifier", "created_at") FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."oauth_consents" ("id", "user_id", "client_id", "scopes", "granted_at", "revoked_at") FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."one_time_tokens" ("id", "user_id", "token_type", "token_hash", "relates_to", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") FROM stdin;
00000000-0000-0000-0000-000000000000	190	lb5gu3q4qm52	e9d8d519-8bb2-4be2-b276-674bdf554017	t	2026-03-17 23:41:56.697524+00	2026-03-18 04:55:46.975269+00	\N	6c67be93-fa56-4dae-bcc7-3c39fc50e279
00000000-0000-0000-0000-000000000000	191	aslihixajmdh	e9d8d519-8bb2-4be2-b276-674bdf554017	t	2026-03-18 04:55:47.001455+00	2026-03-19 09:00:50.844795+00	lb5gu3q4qm52	6c67be93-fa56-4dae-bcc7-3c39fc50e279
00000000-0000-0000-0000-000000000000	192	2ipv2zpdxjze	e9d8d519-8bb2-4be2-b276-674bdf554017	t	2026-03-19 09:00:50.868474+00	2026-03-19 10:43:12.60745+00	aslihixajmdh	6c67be93-fa56-4dae-bcc7-3c39fc50e279
00000000-0000-0000-0000-000000000000	193	kv67tojjw25n	e9d8d519-8bb2-4be2-b276-674bdf554017	t	2026-03-19 10:43:12.622123+00	2026-03-19 17:22:44.89373+00	2ipv2zpdxjze	6c67be93-fa56-4dae-bcc7-3c39fc50e279
00000000-0000-0000-0000-000000000000	194	nzyxg5ig74ia	e9d8d519-8bb2-4be2-b276-674bdf554017	f	2026-03-19 17:22:44.900001+00	2026-03-19 17:22:44.900001+00	kv67tojjw25n	6c67be93-fa56-4dae-bcc7-3c39fc50e279
00000000-0000-0000-0000-000000000000	182	yte6rju7ocgn	532d536e-a390-421d-a265-e5a1253624c8	f	2026-03-17 08:20:47.183446+00	2026-03-17 08:20:47.183446+00	\N	a1860585-3d46-4de6-8d0f-9ff6302e84dd
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sso_providers" ("id", "resource_id", "created_at", "updated_at", "disabled") FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."saml_providers" ("id", "sso_provider_id", "entity_id", "metadata_xml", "metadata_url", "attribute_mapping", "created_at", "updated_at", "name_id_format") FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."saml_relay_states" ("id", "sso_provider_id", "request_id", "for_email", "redirect_to", "created_at", "updated_at", "flow_state_id") FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY "auth"."sso_domains" ("id", "sso_provider_id", "domain", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."users" ("id", "email", "name", "role", "hourly_rate", "department", "created_at", "updated_at") FROM stdin;
550e8400-e29b-41d4-a716-446655440001	anjoe@msa.com	Adhi Tanjung	admin	\N	Manager	2025-09-13 12:40:40.656738+00	2025-09-13 12:40:40.656738+00
550e8400-e29b-41d4-a716-446655440002	rival@msa.com	Rival	admin	\N	HR	2025-09-13 12:40:40.656738+00	2025-09-13 12:40:40.656738+00
550e8400-e29b-41d4-a716-446655440003	pm@msa.com	Mike Manager	project_manager	\N	Operations	2025-09-13 12:40:40.656738+00	2025-09-13 12:40:40.656738+00
550e8400-e29b-41d4-a716-446655440004	talent@msa.com	Jane Smith	talent	1275000	Design	2025-09-13 12:40:40.656738+00	2025-09-13 12:40:40.656738+00
550e8400-e29b-41d4-a716-446655440005	developer@msa.com	John Developer	talent	160000	Engineering	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00
\.


--
-- Data for Name: admin_dashboard_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."admin_dashboard_settings" ("id", "user_id", "dashboard_layout", "widget_preferences", "notification_settings", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: analytics_insights; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."analytics_insights" ("id", "insight_type", "data", "period_start", "period_end", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: assessments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."assessments" ("id", "question_id", "sub_category_id", "question_text", "response_type", "scale_min", "scale_max", "scale_labels", "next_step", "clusters", "batch_id", "is_active", "created_at", "updated_at", "scale_label_1", "scale_label_2", "scale_label_3", "scale_label_4", "order_number") FROM stdin;
7699ade6-fbd2-4208-8794-3df58b3201fa	Q00000001	AMAT_001	I feel motivated to complete my school or study tasks on time.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C1	BATCH_001	t	2026-01-13 12:21:22.12968+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	1
ebec7083-3425-4374-9b8d-c05fa1691274	Q00000002	AMAT_001	I believe I can improve my school performance with effort.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C1	BATCH_001	t	2026-01-13 12:21:22.12968+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	2
3d8c0c58-b5ca-4418-8c17-eb371a964e14	Q00000003	AMAT_001	I can focus on schoolwork even when it feels challenging.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C1	BATCH_001	t	2026-01-13 12:21:22.12968+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	3
235a88b4-fa3a-4e58-a5b8-983cd893846e	Q00000004	AMAT_001	I start my academic tasks without waiting too long.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C1	BATCH_001	t	2026-01-13 12:21:22.12968+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	4
dc0b1fe2-96fc-40b9-a371-6a71df2aff97	Q00000005	AMAT_001	I try to understand the material, not just finish it quickly.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C1	BATCH_001	t	2026-01-13 12:21:22.12968+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	5
b8e255dd-597e-488e-a60d-090ad008de6b	Q00000006	AMAT_001	I put effort into studying even when I don’t feel like it.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C1	BATCH_001	t	2026-01-13 12:21:22.12968+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	6
08ed1b93-e715-43b0-b705-3616dd3b5dea	Q00000013	AMAT_001	I continue studying even after facing setbacks or low grades.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C1	BATCH_002	t	2026-01-13 12:25:44.017821+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	3
9a6ac10a-843f-4653-bbff-4f9f677c429b	Q00000014	AMAT_001	I actively participate in class or group learning.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C1	BATCH_002	t	2026-01-13 12:25:44.017821+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	4
f59b95fe-967b-4a90-9f0b-bf2ad070bbf1	Q00000015	AMAT_001	When I study, I use strategies that help me understand better.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C1	BATCH_002	t	2026-01-13 12:25:44.017821+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	5
ad78829b-dcb8-49b9-97f2-d6bfe9d37fd1	Q00000009	AMAT_001	I can manage distractions (phone, boredom, noise) while studying.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C1	BATCH_001	t	2026-01-13 12:21:22.12968+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	9
8740e36e-8f8a-4450-bc1a-35dee1690c8c	Q00000010	AMAT_001	I stay motivated even when the subject is boring or difficult.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	end_assess	C1	BATCH_001	t	2026-01-13 12:21:22.12968+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	10
6c3c6ed9-1935-4a45-a3ba-6859575c8bbb	Q00000011	AMAT_001	I can plan my study time effectively to meet deadlines.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C1	BATCH_002	t	2026-01-13 12:25:44.017821+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	1
f742a945-82cc-4957-b876-50242a2e4b4c	Q00000012	AMAT_001	I feel that school or learning is meaningful for my future.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C1	BATCH_002	t	2026-01-13 12:25:44.017821+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	2
149370ed-52ae-41b2-be28-3430775fc54a	Q00000016	AMAT_001	I review material on my own, not just when teachers tell me to.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C1	BATCH_002	t	2026-01-13 12:25:44.017821+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	6
3ff85810-49d6-4254-85f2-8ada4cee343a	Q00000017	AMAT_001	When I am stressed about school, I can still stay engaged.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C1	BATCH_002	t	2026-01-13 12:25:44.017821+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	7
90174cba-4435-4ba5-91ee-caee2f7535aa	Q00000018	AMAT_001	I feel a sense of satisfaction when I complete school tasks.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C1	BATCH_002	t	2026-01-13 12:25:44.017821+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	8
4c6942eb-aed2-4987-a99d-53dd8f70c7ce	Q00000019	AMAT_001	I can motivate myself to study even without pressure from others.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C1	BATCH_002	t	2026-01-13 12:25:44.017821+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	9
8b90f281-371d-49f0-9355-dbd5e2e3967f	Q00000020	AMAT_001	I feel responsible for my own learning and progress.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	end_assess	C1	BATCH_002	t	2026-01-13 12:25:44.017821+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	10
ad1e5178-85ff-4327-b407-d7c8380565d2	Q00000021	SMPE_001	I feel motivated to spend time with friends or peers.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C2	BATCH_001	t	2026-01-13 12:40:24.023868+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	1
57cd13c5-ddb1-4e2c-b30a-a101795db408	Q00000022	SMPE_001	I feel comfortable starting conversations with people my age.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C2	BATCH_001	t	2026-01-13 12:40:24.023868+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	2
e6b22619-5f54-4591-8239-12eaefcdb6dd	Q00000023	SMPE_001	I try to join social activities or group events when invited.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C2	BATCH_001	t	2026-01-13 12:40:24.023868+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	3
3a749e0b-77b1-4fab-89a9-f1417e3856b4	Q00000024	SMPE_001	I feel confident that others my age will accept me.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C2	BATCH_001	t	2026-01-13 12:40:24.023868+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	4
3a6c37f5-5753-4b15-a242-d6a687b307be	Q00000025	SMPE_001	I make an effort to stay connected with people who matter to me.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C2	BATCH_001	t	2026-01-13 12:40:24.023868+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	5
e6a000fc-c376-4318-a562-40490b468451	Q00000026	SMPE_001	I try to communicate clearly when talking to friends or classmates.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C2	BATCH_001	t	2026-01-13 12:40:24.023868+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	6
9c306f51-7f90-41d4-a5d3-01ac6c0f565b	Q00000027	SMPE_001	I feel motivated to solve conflicts or misunderstandings with friends.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C2	BATCH_001	t	2026-01-13 12:40:24.023868+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	7
94ad1746-0f52-4d49-8467-85b7cb186071	Q00000028	SMPE_001	I can ask for help or support from people my age when needed.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C2	BATCH_001	t	2026-01-13 12:40:24.023868+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	8
9e441b6f-173a-4cc0-89f6-b838f417227d	Q00000007	AMAT_001	I ask for help when I don’t understand something.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C1	BATCH_001	t	2026-01-13 12:21:22.12968+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	7
406ad36b-d422-4c73-8d76-96ca717d3e1b	Q00000008	AMAT_001	I feel confident I can do well on exams or assignments.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C1	BATCH_001	t	2026-01-13 12:21:22.12968+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	8
54f3f94e-c5ae-4c70-9a79-7c2b83f1d62c	Q00000029	SMPE_001	I feel energized after spending time with people I trust.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	next_question	C2	BATCH_001	t	2026-01-13 12:40:24.023868+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	9
74e62e20-645e-454f-ac16-2e6b9edeface	Q00000030	SMPE_001	I take initiative to reach out first when I want to connect socially.	scale	\N	\N	{"1": "Not at all", "2": "A little", "3": "Quite a bit", "4": "Very much"}	end_assess	C2	BATCH_001	t	2026-01-13 12:40:24.023868+00	2026-01-13 12:55:52.454+00	Never	Sometimes	Often	Always	10
\.


--
-- Data for Name: audit_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."audit_log" ("id", "table_name", "record_id", "action", "field_name", "old_value", "new_value", "changed_by_email", "changed_at") FROM stdin;
3c25cc97-dc21-440e-ab4d-8756af9d0c17	problem_types	5741d506-af09-4790-91b3-7949655a4efe	UPDATE	description	General anxiety disorders and anxiety-related conditionssss	General anxiety disorders and anxiety-related conditions	raheli@ringan.com	2026-01-04 10:43:58.592007+00
9e6ea1c4-71e6-4063-8dd5-dfb21f85941d	problem_types	5741d506-af09-4790-91b3-7949655a4efe	UPDATE	description	General anxiety disorders and anxiety-related conditions	General anxiety disorders and anxiety-related conditionss	raheli@ringan.com	2026-01-04 10:44:24.61216+00
baff91a8-3f92-460f-afaa-e463a0f4540a	assessments	5f1c998d-ae07-4193-a476-dab1eab0098a	UPDATE	response_type	scale (0–4)	scale	raheli@ringan.com	2026-01-05 05:00:48.455896+00
561de725-d7d9-4b8e-b079-381344adad6c	assessments	5f1c998d-ae07-4193-a476-dab1eab0098a	UPDATE	scale_label_1	\N	heelo	raheli@ringan.com	2026-01-05 05:00:48.455896+00
01816d5e-3245-416c-8379-7413cb5ce839	assessments	5f1c998d-ae07-4193-a476-dab1eab0098a	UPDATE	scale_label_2	\N	hellow	raheli@ringan.com	2026-01-05 05:00:48.455896+00
a908c370-741e-43ca-ab7c-2d301f0bdb39	assessments	6b969f2e-6f57-4319-951a-c0430e07f448	UPDATE	response_type	scale (0–10)	scale	raheli@ringan.com	2026-01-05 06:50:05.873043+00
e1e04588-544b-46c1-802c-a0ac213301ee	assessments	86e78746-6346-408a-8166-ae21dedc1640	UPDATE	response_type	text	scale	raheli@ringan.com	2026-01-05 06:50:06.133931+00
26483757-ced1-44c7-906d-bca0c6e9865a	assessments	327bb876-6feb-4c62-9632-925f9a5cd7c0	UPDATE	response_type	yes_no	scale	raheli@ringan.com	2026-01-05 06:50:06.264504+00
bd5c6340-9ef4-439b-a6d3-f3a0830cd5db	assessments	0e153004-4ca6-4924-be28-5b5c51db0759	UPDATE	scale_label_1	\N	a	raheli@ringan.com	2026-01-05 06:50:41.60018+00
2bfe9f00-0cb8-4f9f-b9e1-0826f2a59343	assessments	0e153004-4ca6-4924-be28-5b5c51db0759	UPDATE	scale_label_2	\N	a	raheli@ringan.com	2026-01-05 06:50:41.60018+00
e7bc19b5-5c00-46e0-be3d-32b9852b3fc9	assessments	0e153004-4ca6-4924-be28-5b5c51db0759	UPDATE	scale_label_3	\N	a	raheli@ringan.com	2026-01-05 06:50:41.60018+00
96dd37f8-343c-492f-8351-84f11e3b3e57	assessments	0e153004-4ca6-4924-be28-5b5c51db0759	UPDATE	scale_label_4	\N	a	raheli@ringan.com	2026-01-05 06:50:41.60018+00
858c1e6c-f6fe-4468-8b21-17e83d4e1826	assessments	b80b5cd4-3593-43f2-b2d5-cc385ca842db	UPDATE	response_type	yes_no	free_text	raheli@ringan.com	2026-01-05 07:08:22.366572+00
a6f4ea1a-0894-423e-8d92-f1639d96c519	assessments	17548c03-dab6-4335-b3df-01577711e6ee	UPDATE	response_type	yes_no	scale	raheli@ringan.com	2026-01-05 07:08:22.626913+00
2557fef8-4284-4a8c-a11a-481665aafdd4	assessments	17548c03-dab6-4335-b3df-01577711e6ee	UPDATE	scale_label_1	\N	asd	raheli@ringan.com	2026-01-05 07:08:22.626913+00
064a296f-8d67-48b2-9534-f62793e305a0	assessments	17548c03-dab6-4335-b3df-01577711e6ee	UPDATE	scale_label_2	\N	a	raheli@ringan.com	2026-01-05 07:08:22.626913+00
38be4e43-fee3-4ecd-9352-1f75ef67500f	assessments	17548c03-dab6-4335-b3df-01577711e6ee	UPDATE	scale_label_3	\N	asd	raheli@ringan.com	2026-01-05 07:08:22.626913+00
0c219651-e4c0-48f3-bc4f-25b96363629e	assessments	17548c03-dab6-4335-b3df-01577711e6ee	UPDATE	scale_label_4	\N	asd	raheli@ringan.com	2026-01-05 07:08:22.626913+00
02a93359-af5e-4d23-93e7-064ece2119ad	assessments	dd206f44-3b9e-4b45-ab9e-fcd6af9dd207	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-05 07:08:39.227249+00
51923029-d992-4d4d-b4f1-4f303afb0f1e	assessments	86e78746-6346-408a-8166-ae21dedc1640	UPDATE	scale_label_1	\N	hellow	raheli@ringan.com	2026-01-05 07:30:19.870661+00
bd67ab69-7cac-4465-891c-13e5be7ec374	assessments	6b969f2e-6f57-4319-951a-c0430e07f448	UPDATE	scale_label_1	\N	hellow	raheli@ringan.com	2026-01-05 07:30:20.223951+00
4c56c32b-92ac-4582-b269-e783eda35b8c	assessments	6b969f2e-6f57-4319-951a-c0430e07f448	UPDATE	scale_label_2	\N	hellow	raheli@ringan.com	2026-01-05 07:30:20.223951+00
15ad8e49-76d6-49a6-a90d-8c577dd825f8	assessments	6b969f2e-6f57-4319-951a-c0430e07f448	UPDATE	scale_label_3	\N	hellow	raheli@ringan.com	2026-01-05 07:30:20.223951+00
d55d5787-b060-4155-a0a1-63973bd0b405	assessments	6b969f2e-6f57-4319-951a-c0430e07f448	UPDATE	scale_label_4	\N	hellow	raheli@ringan.com	2026-01-05 07:30:20.223951+00
5504b901-28c4-4474-a7a3-147dda69dd51	assessments	5f1c998d-ae07-4193-a476-dab1eab0098a	UPDATE	scale_label_1	heelo	hellow	raheli@ringan.com	2026-01-05 07:30:20.473075+00
34dfed5c-8ed5-438a-897f-ae634c0a0bed	assessments	5f1c998d-ae07-4193-a476-dab1eab0098a	UPDATE	scale_label_3	\N	hellow	raheli@ringan.com	2026-01-05 07:30:20.473075+00
ac7cb18a-3e02-4882-a547-8c2873affd71	assessments	5f1c998d-ae07-4193-a476-dab1eab0098a	UPDATE	scale_label_4	\N	hellow	raheli@ringan.com	2026-01-05 07:30:20.473075+00
e79d9c65-8c51-413b-8309-9e77e2873762	assessments	86e78746-6346-408a-8166-ae21dedc1640	UPDATE	scale_label_2	\N	hellow	raheli@ringan.com	2026-01-05 07:30:29.252086+00
caeef5bd-548b-400c-baa4-0ef2691e36aa	assessments	86e78746-6346-408a-8166-ae21dedc1640	UPDATE	scale_label_3	\N	hellow	raheli@ringan.com	2026-01-05 07:30:29.252086+00
fc923889-2bff-4e91-a8fe-64fe10e33d04	assessments	86e78746-6346-408a-8166-ae21dedc1640	UPDATE	scale_label_4	\N	hellow	raheli@ringan.com	2026-01-05 07:30:29.252086+00
40558eaf-f34f-4945-bc30-1615782685d9	assessments	17548c03-dab6-4335-b3df-01577711e6ee	UPDATE	scale_label_1	asd	hellow	raheli@ringan.com	2026-01-05 07:30:40.789213+00
1a561d9f-fed3-43e8-84f3-4b810d40c337	assessments	17548c03-dab6-4335-b3df-01577711e6ee	UPDATE	scale_label_2	a	hellow	raheli@ringan.com	2026-01-05 07:30:40.789213+00
074a0128-a506-4d9c-9b55-64f036df323b	assessments	17548c03-dab6-4335-b3df-01577711e6ee	UPDATE	scale_label_3	asd	hellow	raheli@ringan.com	2026-01-05 07:30:40.789213+00
92f33e30-36ed-4f83-8016-8fabe1faaaff	assessments	17548c03-dab6-4335-b3df-01577711e6ee	UPDATE	scale_label_4	asd	hellow	raheli@ringan.com	2026-01-05 07:30:40.789213+00
92c28aa9-ecf1-4746-ab54-eee9ca95db81	assessments	0246e271-5b53-4494-8907-23f875095779	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-06 05:36:07.220985+00
5d047856-233d-4702-b137-47792fa1eeb4	problem_types	ef240793-ccef-4681-8cd3-d9616ba20561	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-06 12:19:35.04935+00
5d9bd5ee-d438-4968-9317-4079c05107a5	problems	22476d41-5953-4dd2-a8bb-b9ed61042120	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-06 12:20:57.806627+00
d1ddd8fc-84e5-4228-abfc-a362449ad05d	assessments	8ea62baa-9fa0-4d15-9470-556237787696	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-06 12:34:22.909385+00
7de8f7bd-d3a1-48c7-b91a-324f261101bf	problem_types	ff583ec7-5dd8-4a4b-b347-629a29edf8d0	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-06 12:42:02.41689+00
cc58c24a-a154-41de-9395-b69c65677d9a	problems	ef89aeda-c953-4850-a918-378a2aec7cf9	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-06 12:43:14.429098+00
11b4712e-f8e6-4fc8-8dbb-12f84c910ed8	assessments	02538baa-d0cf-44b5-a875-732bbf096903	UPDATE	response_type	yes_no	scale	ayelet@ringan.com	2026-01-06 12:48:21.77202+00
c96fcb9a-1384-4e66-9798-70e82c24af39	assessments	02538baa-d0cf-44b5-a875-732bbf096903	UPDATE	scale_label_1	\N	Never	ayelet@ringan.com	2026-01-06 12:48:21.77202+00
bda22247-41c9-403e-8c8f-37cd79e8c8db	assessments	02538baa-d0cf-44b5-a875-732bbf096903	UPDATE	scale_label_2	\N	Sometimes	ayelet@ringan.com	2026-01-06 12:48:21.77202+00
31278ea9-438c-4d1e-ace2-1a287a1c2bec	assessments	02538baa-d0cf-44b5-a875-732bbf096903	UPDATE	scale_label_3	\N	Often	ayelet@ringan.com	2026-01-06 12:48:21.77202+00
c8028a3e-a024-428d-a69d-1e656d52fd23	assessments	02538baa-d0cf-44b5-a875-732bbf096903	UPDATE	scale_label_4	\N	Always	ayelet@ringan.com	2026-01-06 12:48:21.77202+00
9d744a55-ae90-4670-a8ad-2c6e1e03f8f2	assessments	c64017f7-fe5c-45ae-9585-81d13764ad9b	UPDATE	response_type	yes/no	scale	ayelet@ringan.com	2026-01-06 12:48:22.470054+00
35f6e398-256a-40a0-bec7-6da81fb3b1b0	assessments	c64017f7-fe5c-45ae-9585-81d13764ad9b	UPDATE	scale_label_1	\N	Never	ayelet@ringan.com	2026-01-06 12:48:22.470054+00
4814e118-477f-4412-87c3-21c0952ba5fa	assessments	c64017f7-fe5c-45ae-9585-81d13764ad9b	UPDATE	scale_label_2	\N	Sometimes	ayelet@ringan.com	2026-01-06 12:48:22.470054+00
6f64b8f1-9c1b-4f22-9080-64f53738ac42	assessments	c64017f7-fe5c-45ae-9585-81d13764ad9b	UPDATE	scale_label_3	\N	Often	ayelet@ringan.com	2026-01-06 12:48:22.470054+00
6f09dc95-bf59-4ca2-b641-a7ddf7565f55	assessments	c64017f7-fe5c-45ae-9585-81d13764ad9b	UPDATE	scale_label_4	\N	Always	ayelet@ringan.com	2026-01-06 12:48:22.470054+00
a3a3b0da-8568-4a45-b975-00817598abd4	assessments	3ce9c80c-ea76-4740-85de-0bf6ad6af0ff	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
c2b12123-816b-4b57-b904-b98b65f6b858	assessments	21f7046a-25e8-4d07-b02e-2f592076ea8c	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5f544bb9-1dd1-4bf9-aaf1-bf293834899f	assessments	ee77a32b-f46d-4f4f-ba90-cbc86212fd1b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
525f6647-a075-468f-944a-52aba48ca6bd	assessments	8bebf80a-5d18-40a9-93d9-7142c18991c0	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
2783200c-5e43-4bba-940d-aad5a7d6656b	assessments	3256a75a-c45c-41c8-8ab8-afc489c31a81	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
bed29a3f-cf7c-4d7d-8276-7b7544ef87a7	assessments	f56d3ca1-2a07-4ad1-986b-b1ab091038a7	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
90eeab67-ff0b-47f7-bcd3-05c4da109e3f	assessments	2e6ad49c-3ae4-4b03-8629-4d73453ccc15	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
1fdb620e-c078-4408-99dc-ba21b56ca765	assessments	52651211-4c4c-4c67-93b9-090beb4ad528	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
06091f99-4f41-4502-9f83-3065873c535b	assessments	909a1ab3-52ad-4330-8171-8a316524089f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
0776dd08-a135-4adb-8417-8d5654d65644	assessments	6d7ba4ac-c7ff-41c8-bf3e-fd41c269d494	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
224ce1e8-d630-41e8-99da-def83ddab12d	assessments	74b14af2-f966-4ec7-ab44-6c3842e6febd	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
c286dd44-1d3a-47ea-9c35-6ee0cf3d00cc	assessments	6ea7eab9-6c2e-4ec9-9090-9da83f4c453e	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
04dba1e7-d6a4-4e61-bcbe-d25ea07503a6	assessments	dd63872a-bd93-4725-8078-1693b6417b5e	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
47c72caa-dad9-44d5-826f-f5bf5b762e96	assessments	7cd86331-99cd-4790-a2de-f7e93e9cce87	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
d21fd5ff-cbe3-44a2-90c3-f665d39b7526	assessments	cd5378b4-b455-44a5-ab7b-8f05629f3d55	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
f9cd5186-fa1b-4dcc-85f4-51bb1f56dd5a	assessments	5854f97f-b553-4d37-87a3-5d173c94a6ae	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
d60c8098-8b45-4826-990e-14e4d03f300d	assessments	823e96e7-de32-404f-b286-547dcc2262e5	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
a603cb4e-638f-40a7-97c1-74fe9384412e	assessments	67192ddf-f2c5-49e2-87f8-2681d7fade6b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
f0436e3f-23bf-40f1-af1a-7bb14f78af13	assessments	02ec6628-6072-42cd-82d3-0722d11ad6ca	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6f91581a-de87-4edc-8087-9b95ac2a7023	assessments	9cc52c29-176c-4885-a020-f801b1e45ecd	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
ea6836db-ef4b-4965-8244-5668afe6a135	assessments	da1a065b-e491-410d-a8b4-026997754ada	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
ccdee650-3955-4aa5-a69d-2b807936c367	assessments	57bf14fd-0455-488b-90ac-6af80106e3d9	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
eb506bd1-0024-4fba-a5f8-a3c3f432896d	assessments	ff66417a-d658-484d-ab9c-d4302dfdfd90	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
a59a66ce-a325-424a-b0ee-503e77585bba	assessments	7b534255-5080-493b-819d-61288d8a7ae8	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
9b2b14a1-2cd0-41c7-a433-d38050c91660	assessments	2a6c62a0-e0c6-48b9-a3a3-c791d1ed7c96	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
27111a84-a057-4c7d-ba36-6c3f44e9c06f	assessments	ccd2ac2c-47af-4045-8520-a0941ee3d868	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5f83210b-b35d-41ff-829c-83004bec783c	assessments	f5f03eb5-e8c5-4bb2-8c88-332950ea4ee7	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
fe535b10-b6d7-4e1c-b3c8-9750233eadf0	assessments	39f47589-daee-44a2-8133-4d2fca2c0677	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
d16bd9f7-8f50-4443-b5f8-d3cdab2def77	assessments	41a4bde2-824c-4880-831b-304997a2f6cb	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
d64e524e-3f20-4ffc-af9f-b48af4cc323a	assessments	db98a22f-b76e-4060-9e12-18184c811445	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
52cd6337-d796-4d02-b730-1ebaa0b225d7	assessments	ccd2aa32-f663-498d-be38-abc2b5611930	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
278608fb-67b7-4818-b693-8dbd534f3573	assessments	1fdab464-f247-4578-9789-75b70f36ace0	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
1ac00dfe-28fb-4e77-9477-bd346c357509	assessments	e4190839-2532-4e95-820c-1a3ad1ef9244	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5db489b1-0919-44fc-8fad-3c3c8a484cd5	assessments	3d188708-8060-4e5f-a4aa-5ad50c48f53d	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
cbbcbcf5-211e-450d-ae94-54782ce0d97d	assessments	4ea7f956-0276-480c-a07e-58c97df5f5bf	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
e4c12775-a6de-4832-87e4-01a827e178ef	assessments	a4f81f46-b6fb-46ee-bed2-89ac43045014	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5b9baf99-c90d-43c2-94ab-dae4d393eafc	assessments	f117a8a0-ca5f-4084-bc23-e8186f1df78c	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
79c13a59-1052-4e7b-8051-8f093462b1a2	assessments	b9df8463-d859-44ae-8052-3eaf61f664ec	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
084ae90a-223d-4de6-8ac5-9d02531a8cf8	assessments	f8186ca5-2f40-49a8-adf7-8a8e7b4a1b0b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
4cb3f6c8-9cba-4178-a680-27a89977491d	assessments	e3f8e2f4-42eb-45cb-a3d0-6e9ba9d09845	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
94855ec5-e2fa-458c-ae40-5699d78f84dc	assessments	a8c47564-cd4a-4a64-9042-da00978456dd	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
e409f0f7-36e6-4aef-8eb6-04b34f182b05	assessments	913eb686-3571-49a8-bc66-93be554e0fbd	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
7eef9676-788b-45fe-85d0-c5a480531a29	assessments	5a12f00c-bae3-4267-ac20-81d0aea00d90	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
84bb4143-ce7a-4285-a971-c7374db9d1d8	assessments	dcc404f6-c15e-4e10-acb4-4b6f31c76670	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
8e178b3a-31ec-45a9-93c5-c7311a98939d	assessments	fc05d1cc-701b-423e-8f01-67db9ff047b1	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
224fe372-6a52-4f0d-b482-56f151ed9410	assessments	bcad96ea-b587-4d06-9777-0b8adcb9199b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
d395c464-397c-4fef-8bc9-b90588edc911	assessments	5d5de239-ac03-4981-88a0-fbf01cdd09b5	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
7e8c2211-3ecc-4d93-8c67-0b3b682241fc	assessments	f9d3a913-e19a-4316-9980-0de75fc14e38	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
aaba0656-7ae3-48d3-a72d-52fc5dde5b4f	assessments	61151a12-bcdc-4701-be57-54d9ea23ee8a	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
4dac70ab-3f4e-46df-9f49-ce8aec6d50eb	assessments	24f5b26c-b9fb-4f24-bb75-8fcdc1591dcf	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5609c2d1-b09f-4254-8661-4bb71840f679	assessments	55403782-1594-4dd9-8e82-8c7beb53d77f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
31ea417f-b5c2-4280-831f-94fdf470633a	assessments	59f6b878-c769-41d3-b430-abdb031b38dc	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
41a25d2d-3ece-44f5-85f8-d402eb3beca6	assessments	e5299347-aa8c-4e54-a2a2-4645c9823293	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
d0a45f8e-903c-443f-89f1-08d71452b29a	assessments	eb1ba2db-2402-4a36-81d3-53a1ed8eb4dd	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
725886e7-b744-4078-993b-3d1a634af524	assessments	43643fb3-c690-4268-8f0f-266b65fc69d1	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
20c4ca3a-f1f5-4be3-b6d3-addf643abf1d	assessments	d4635812-537d-461e-9542-58b908e557c7	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
a11cbec5-6767-4074-8838-b79f531ad8c0	assessments	97765872-e274-4c94-ba13-d02e91c6ced0	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
06c0cbe1-156d-4120-9914-3219566d2832	assessments	ee27e39c-e5f3-47c0-a397-6c547fbd0fc0	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5d87afb0-0fc9-4c6f-b36f-4e00c5a6684e	assessments	919b48a5-6114-48f4-87b3-e59cc1f1e204	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
402fa5cd-fccb-4369-a887-b08228dbe81b	assessments	4ed0e63d-b4f5-4e54-902c-3f7218ffd489	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
1db0f308-0883-458f-bd3c-0a529cf2cdd6	assessments	91b8b540-2e12-419d-a4cc-84bf402c4841	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6e950b55-7e31-46b9-9b76-160aa5115554	assessments	6e68a2b8-75a7-424a-addf-4f1cbf31e6b2	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
bd2c55b8-8f0f-4e88-bcc8-683defada869	assessments	79a5b0f9-c17a-48f2-be28-98ddbab2c2da	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
8ec3c04e-f31a-4f56-a72c-e3566a2270d3	assessments	6594df58-82ca-463f-aba4-3cbe02febdcf	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
94ff4941-f1a7-44d4-b9d4-88cb33037c75	assessments	acc5fae1-9a7c-4af7-a464-3d710a69b80b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
170c9280-2a78-4e7a-9c60-6180f8617bcc	assessments	877681b3-5e5f-4c7d-b468-6a5028b8205d	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
ec50bdae-cf60-4ec2-967d-7e1ba8f3cffb	assessments	6822e7c7-dc60-4a54-9495-f2ac0c7c384b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
1d0f7912-ec3f-43ea-bb12-cf78452d4bdc	assessments	69ced858-b7b6-4f77-9b9d-baa8106172ee	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
cb2dd6df-a276-4bfe-bbe2-58f279097204	assessments	6a220870-8364-4675-ae5d-63adb84bf893	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
8a24fa3f-d77d-4e4e-9b0f-ba0e2e44b2cb	assessments	a93584cc-35cb-4952-87e1-6468a9a0e3f8	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
3b124fbf-5f83-413f-a051-4eb06fa0e54f	assessments	29b80b9b-b6ef-4f5c-bf70-a7cdec9f98a9	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
1dbb1257-dcf3-4f72-ac09-e0640e227c5a	assessments	e3d6f8e3-ca7e-4093-bd15-0e67d85fc90e	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
7eb77e1c-ff6f-4a51-802d-4b3dd09209bc	assessments	6d79e974-d076-4e1a-83b9-147307e5afa8	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
c0f039b3-30f6-48c7-9e1a-cc690c8e7301	assessments	d5b3bfa6-2090-4cfe-b625-acf8ea8360e6	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
2b7ac6a1-9049-496b-a054-015712bb2de8	assessments	e0feff7f-78c8-4699-94f7-0bdbf06883d0	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
917fcb43-fc85-498a-b7ec-4be044080342	assessments	d1cf0c05-d468-4d80-831e-c39b60396d85	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
98b21a37-8e79-4955-a9fe-83d80c2b8b2b	assessments	411ca305-1b33-487e-894d-09a7a7c75af7	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
2b0230e0-556b-4132-b4f2-5511dac64de3	assessments	002c2e21-6080-4aa6-a1a0-a71eeab607ca	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
05578696-4d8b-418b-a365-caeb990a3c8f	assessments	9fb1ece3-1d9b-4f8c-8dde-66fd13c117c4	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
505dc991-6299-435a-b61e-ac5848c3cb2e	assessments	1d2830de-8ea1-4cef-9497-8953bee0a113	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
32da3520-3c5d-4437-b99b-f671755bb712	assessments	3e18796b-9633-481a-8f7f-bb507cede702	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6c97edbe-ce8c-46b4-9253-b0b394dd35c5	assessments	cf7fe610-286a-49ff-910e-601c81b4ef2d	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
0f2e74e0-7635-496c-9776-b61eb9965bd5	assessments	3d8b7968-fa8d-44da-b6fa-c3b8bb5966fd	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
3067a974-169c-49ad-929f-80aaa258c0d0	assessments	4b4f07d5-904b-4fbe-bbe3-dfadd5a0651f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
68573327-fddd-4e99-b018-a59266700b16	assessments	d1444fed-3338-40a3-9699-d658fc379a78	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
8a18d4c7-6e68-4570-921d-0f1f887c9920	assessments	68ff5cfe-e314-4adb-8497-a04f4962441f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
732e1fb6-f4fc-4060-b4ad-368a633e46b5	assessments	d3eded4d-e7fb-4464-bd47-44e8153dfa95	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
e4991acc-4ccd-46bd-8240-e0f3aa1cd8fc	assessments	59a7ab9d-86ca-47ff-a294-aede0c4c2f3d	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
ea6ac2e1-4f44-41b3-980f-403c377fa7aa	assessments	db461fc8-f275-4a54-b463-e980393be584	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
09b5cae2-590d-4416-8ba3-e9e778bf31af	assessments	bb07685b-ff42-4ca8-846b-b50c15c0d2da	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
7d2be41b-5ff8-46f7-857b-621ed73f9240	assessments	b96afd28-076e-479a-9649-c00a8af5acc5	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
e093a39c-8ab6-4e47-b674-55af70158867	assessments	0a615e79-ad9c-4f20-b206-c310029c580a	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
afde8cc6-ebe5-47ce-a9ef-e0495456cf41	assessments	d8b92a77-786b-43b2-9d42-56a9f5c907eb	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
df789368-bccf-4536-ba67-27de7ff3d58f	assessments	7c90209b-61b2-4276-9483-6aa18154cf78	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
04a2da6a-0958-4cea-a0a1-1283467bdef8	assessments	6d08e0eb-8b90-4004-aa22-b765d660f249	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
20c68602-b1c3-4ca8-abf5-3c2383fc9fe1	assessments	0e35864b-158c-46b6-a42e-35c7eefde2b9	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6f971f95-53c3-4b5a-be15-2aa912c4e07e	assessments	f7d73db2-c48d-4c34-bc9d-2419e24eba9d	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
097e415f-922d-447c-90cc-b3d1046e3c91	assessments	71b06b1a-9e1a-4a8f-a9e0-665a4f8fd4b2	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
91fcef24-356d-46b9-849f-f4e1665e2166	assessments	2bd49204-5739-4e3a-a121-077c13c34108	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
0a9d26d0-9f68-4919-9465-2df81800712a	assessments	09586cf4-66a3-4e27-8142-d4e1aee09184	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
a803e2e2-b7a9-49f1-a49f-0c93afdb3e00	assessments	1f3a4afa-3242-4c0a-ac6b-6ad88e78db4b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
44c93b38-a553-4c36-92f0-79a2a18a8436	assessments	60994fc9-061c-4279-b606-3790eb8703ea	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
2c74c41c-8595-4ab1-800f-c44799c4db61	assessments	19c5deae-ed2e-48f5-82c3-1c1afa8198c9	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
0ed51a23-8602-43e3-96df-9a7e323fe0a4	assessments	9d9e43e6-1f7e-490c-98b7-87147ab030dd	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
ef6e53d6-20a6-4849-8abd-5e3db019febb	assessments	0246e271-5b53-4494-8907-23f875095779	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
67164ad3-ccf9-4c35-aa06-d6bd5e9e32a6	assessments	c64017f7-fe5c-45ae-9585-81d13764ad9b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
9835e926-f8a5-4e73-ac52-a3e04783f39f	assessments	84c8fadc-e4c8-445a-b07b-a799f2e2b712	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
96dbaff8-3429-4fc1-82d3-3fe97dc7c6d3	assessments	ba3af83b-6bd1-4a26-9c2f-5338a1d6c699	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
a2c8def7-9e32-4ba3-8a3e-d668150d06b6	assessments	ec7721c9-257d-4dc9-be58-d1e25d8332e6	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
041e1b9f-dcb5-4b6c-8f7f-df820be2186e	assessments	a8002fad-55f1-449a-809f-7bb7c5a9755c	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6b98bfda-01ea-4ea6-b3ae-3601083ccff1	assessments	042d2516-3751-45e5-bf13-8963f6552613	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
20020fbd-46b6-48b0-83ad-e7051984ce29	assessments	12d90c58-96cc-4229-ad0f-c4090451c3d5	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
11c33b5a-4007-45ec-a819-c5a905de1a7e	assessments	281afde0-dde9-4a44-813b-bab622c0589c	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6cee2fc0-4049-4453-8fdf-528f526fea0a	assessments	6a39db5e-eb82-4a6f-b677-e5db44c5c633	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
40a43169-d2b5-426d-8184-270f1b64eab2	assessments	351135d6-d646-4b1a-827e-97e327d089a7	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
80b940fa-7481-48fc-bd53-4aed69b864ac	assessments	f77901a5-c325-43d0-91ab-2c91e03afb9f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
50aa4bfb-2dde-4be9-bad2-ae54ca04cb5d	assessments	c7d80087-7cd5-477d-a697-bd7197e8b6ac	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
18b94b3e-21d4-46d2-9d19-d68f630c0490	assessments	77186913-ac98-4a09-8677-f03c05497ee4	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
096e8871-0ba9-48eb-9af4-a0a79cc9246b	assessments	5498d196-51db-44ba-bbe3-1693a0cf9032	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6f9deab1-d779-4d44-848c-42106f68e1f0	assessments	3b690323-d9ab-4875-ba8c-f02f58e16c19	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
2345753e-c8ea-42fa-942e-bf563c7dc7e7	assessments	209b008e-8f7c-4ed5-a298-02b33af1b26a	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5f0a2f35-fc87-4bd7-a4af-7ca4040f0c4f	assessments	d1e2ce2b-a781-40d5-8f64-5fdf6989ca35	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
965645f6-1a18-4676-a9ae-9f3fee597abc	assessments	97bfcafe-3714-4b2d-a4fa-1eb612ab4855	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
8e79cc64-cc46-441c-a62b-896a82666d31	assessments	a69d62b6-3eb1-40d3-ac7d-dc1e27cf3aec	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
56e1d91a-d49c-41ef-9ee7-e80047fa85ec	assessments	a8ebeb77-5d53-4d2f-926c-e546a0ded6c7	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
e07a30d3-55b3-4a96-95f5-85404cd93c4a	assessments	8b7eecbd-8ff5-4795-b0b2-9c90c36330da	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
d0273837-bcc1-4a5e-81f6-592d64cbd0b4	assessments	dc0d7b0f-478f-4ef4-a803-88ad8fae9518	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
bc643a04-b36a-4408-b9f4-1a23ae2dfeb4	assessments	6e1ec100-214f-4ad4-bc45-afbd24e03381	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
29949131-444d-4e0a-911b-08f69e819ff8	assessments	5e8abd95-d73e-4fa0-a4b4-26503950d35e	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5c1ee05b-9ca8-453d-8a86-ed4b792c8ac7	assessments	52b80164-4f4d-4857-99e4-7bb9f9eca13f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
7a7ad4eb-9274-4e6b-8146-820964fba077	assessments	0db983bc-016c-4a31-97ca-d6af2ff7e22f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
1b5fd8a9-a23c-407d-8412-3747ec6d68ff	assessments	1e3f313c-3d90-4842-8e25-dfca5a995dec	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
55d665d0-8ff8-4b3c-9e19-ee948b502593	assessments	ad3db3ea-84f7-48ef-a896-4b8a833b9df4	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
dce4b786-f6a6-45f8-83c5-d8415d3afe63	assessments	ed1e600d-ecb3-469d-9e76-5aff1c3f18a4	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6dbe72bf-3579-4d90-8bd7-95c9a48db213	assessments	c392ba99-4904-4090-b9fe-8133300c9a22	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
56bdbb88-9b2e-4614-9cc4-a70faa25a4b4	assessments	a6fdcaf1-6584-4e9f-8fe7-00c74a994f22	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
61e5d739-73f4-491d-82b5-f1aab68e8dcd	assessments	4ad1407b-9273-481d-8537-093e8889f8b4	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
28938815-8749-4567-aa34-13a23750926b	assessments	7656522c-4749-4961-a3da-12a7cab6ec13	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
b37fecc8-4fa1-4004-ac43-2533d22c6bbf	assessments	5e8ea2ea-703e-4d66-93ce-c2365c8cac18	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
4fc347ec-26ac-4385-be4a-fa3305a983bc	assessments	70842f06-5c46-4a90-b2e5-936679ad6152	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
bf49d522-71b1-46cc-b285-dec13e0a8aa7	assessments	95b97efd-e969-44d2-8cc5-84a31ea2154f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
891fc969-da41-426d-9453-49a145562fc9	assessments	92826f1d-9535-46d4-a08b-a4aa6aae27fe	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
ef6673d3-4e25-4e76-947d-e85e4e590930	assessments	4f03e20b-2c58-4f2c-9f7c-bd48ce3f60d2	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5339c19c-3ae9-406b-b8e7-abe21dd0053d	assessments	4e93a536-0c1c-4f5f-9b85-0e0f57e046e1	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
0c4e0877-a364-476b-954a-2941f741bb6a	assessments	d27e99ee-e7e2-43d0-be82-76603b5f2771	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
00de5d05-8328-4623-befe-f0934962a983	assessments	b8125f37-61a6-41f0-a06d-e605a21f4e16	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
fe80604a-20f9-48ef-83f7-d26a1c5190fb	assessments	d7f215cb-34d1-4aa6-a6e7-c01e96c731b8	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
16ce16db-5d44-4360-b95f-1043eaee5d8e	assessments	dc29a0fc-9b4e-4a1b-9c2f-f242b9f89b74	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
b952f295-816e-435f-9ea5-cf02772d7e97	assessments	a10bdecf-73fd-4360-881f-0cf689e1c1f2	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
28abdd9e-497c-473b-a884-7ec84446074c	assessments	8d579de6-9c3d-4a03-9ce1-b5621b93902d	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
ad9b0ef3-aece-4701-99b2-be9835b72486	assessments	ea9768bc-823b-42d8-b1b6-bb38347c0667	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
d365a870-fb73-46e3-a431-dc8840320f2f	assessments	4e5a5934-8035-464b-a6b5-caba456840aa	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
90a95023-a665-49c4-9a23-770f28fdffc1	assessments	6da041c2-e199-41c5-8cbd-438e9c615554	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
88def1f0-64f4-46a5-9651-f0290bb3f3a3	assessments	7816383c-3c1f-422e-a402-d9fcce115788	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
ae17dbb6-7233-488d-8007-20c618d6f259	assessments	16463289-0c11-4223-ba02-1e43c6c49dac	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
dbe9e0e9-0ff3-4a0e-85b0-8db8d9be623b	assessments	0e628bd2-a05a-451b-97b7-ab538319ca83	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
e8b8bcd4-e37a-4592-bcb3-b645fbf38bb8	assessments	f29fcc6a-f9a5-441f-82c7-7e6b722945c8	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
12dabe1b-33bd-4553-b6a3-8076a4f35b2d	assessments	f8d07b4c-7ecf-4065-b2e9-730ce00306a6	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
7bdbb801-2154-4008-948b-1aa950cc1d44	assessments	6e00e2bf-8418-4792-8bef-8c0a6b634c11	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
c68b82d1-89af-4a0e-a750-2bc09203f8fa	assessments	7c09bac4-6854-4746-96a5-7047a827ffe7	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
be0c7a27-fc70-408e-855d-afe7f4a4f4c7	assessments	6341a8b8-0835-46e0-a767-4fc409ef2511	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
693aa039-b3ab-442d-b5fb-29345c6d5434	assessments	8dc82a9a-ca27-4309-8a0c-4c0cea6c3720	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
b9476187-1b39-4c92-afff-dcf609226e31	assessments	96a4f412-1bd7-4840-9021-6595f3e5d0f3	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
633be36b-3823-4a44-8a04-8f8da47288d7	assessments	84aadee4-ec2b-4274-b6a8-e7ded3975beb	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
b7c9b7ed-7e90-4c42-9554-90ccb6bd6a1f	assessments	9ef51b41-b8cc-4791-8f20-e77a73a9acd1	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
3b89c15d-0333-44fe-b27e-be2e6f97232f	assessments	93839018-f6c3-44da-8e10-f508a05b4d32	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
7ca1b01b-72f6-4fbd-98eb-73f929a02e63	assessments	f7a8196e-7080-4721-bfd0-9dee9e6ab076	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
53320b3e-ecf1-4344-9558-46b6ca0988f2	assessments	ecddd480-2f14-422e-9c2a-870e9aeb4c6e	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
177843ea-7ca4-4478-8f61-1bdbba3d05e2	assessments	c5b5114c-52fc-47dc-85bb-119611a182d7	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
3f8b0997-aa32-4ba9-94e2-7cdb847227d6	assessments	a58c28f3-281e-428f-b2ce-443be21bd777	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
dfc816b3-93cb-43b0-8b1b-80a9056efd93	assessments	ff6500e0-9014-4cbb-88ed-999ebf4c0d25	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6b7bd5a0-ed69-4e14-8475-94f56460ecab	assessments	c0304773-c9ac-4ae5-8a7b-9aa07bc55941	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
d1f2bda9-9b4a-48a1-a8f1-537cc3259c79	assessments	c826ccbc-091b-4424-bc0e-532320f8db66	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
a0dc61ee-7176-444b-9b66-c9f43fc0845d	assessments	590665a3-06a3-4672-9ce1-a02a274bcbf8	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
db13a87e-b291-4d02-9bcc-573262616022	assessments	752ffafa-0e4a-41e3-beed-024c4aa8735d	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
35642175-a0c1-4596-8b0b-0c0bc6886f2a	assessments	239476c1-8861-4c9d-a4a3-6ee88a56a55d	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
86acf613-d282-457c-8e0b-302ddc2927d2	assessments	9b655c20-2a66-4989-b4cd-423e975184d1	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
3ccfeda7-2e24-4535-92b0-d55c0ef81371	assessments	6a681b8c-4a19-47c6-8093-bd31b23a85d8	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
1e5c828a-45c8-41e1-845f-bee8f4ca6f18	assessments	d798e2ca-5a37-4195-b463-f0a25d1fabf8	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
511e9415-5110-4e64-a466-fd7daeac1674	assessments	3ad984be-abfa-4f4e-abf1-fa5d52e08427	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
05de81c8-3136-4d4f-aed0-32cf33db9edb	assessments	8129180f-f52a-4c67-97ac-503bd8915f5b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
adf6db67-94e9-489c-a304-f7cc91be060d	assessments	aa74e15b-580f-4731-b9d8-df1702e8cc1e	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
1b8d4635-dde7-43a0-b6ef-b3fb8955db94	assessments	4a50e87e-7aba-4b60-8100-cc10e419b242	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
3c868db0-0977-40ac-b5b8-4ac667c25af0	assessments	baef5c23-e93d-42b5-841f-8d299b066879	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
942035ca-b1c2-4d23-9a43-1a854fe9a2c6	assessments	9342489a-6355-455c-9947-5b871fc1542a	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
87e66fa3-368c-4163-adf6-254cada88144	assessments	a4889c65-87c2-40c9-af16-bdf5274a81c0	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
c5b8c3b5-f28a-404d-a493-b902281ef881	assessments	c1a73332-e598-4581-9a09-9fdfec490c88	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
1a78b058-3416-4c7a-b428-6f81bc61b813	assessments	40c0ce16-c077-414f-a601-449347db69d2	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
a91225b1-ae9b-41ff-9e15-551b3bdaecea	assessments	2f9cc9e4-5e08-45a5-abc1-9f35a9354a77	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
262bb7e6-8ce9-48b0-91f0-5a87babcd2c3	assessments	67ee23ac-0f6c-4438-862a-a4e0aeb1a1fb	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
d22e884f-3ad6-4a76-ba9c-675de7c71c5b	assessments	af78bf4e-dc32-417f-acdd-47f8101bc57f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
aa5f4e59-3675-4d31-a3a3-3d8604248456	assessments	0692db92-6fc1-4d9d-b76e-e628ca791f1e	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
d13301b5-e0b5-4a0f-83b0-3b16e2e821a9	assessments	2b451583-9679-44f2-936e-09f11558a171	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
e9e5ec32-8790-4348-b6c4-40a9dd8f6d9d	assessments	b8a88ea2-18ca-489f-8ed5-7d483e9d0e13	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
fb63cc61-2a21-4253-9ccf-22238145d3b6	assessments	3455bafa-6dd3-4c67-a51c-5e91a7e417e2	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
89a09f4a-4c86-4655-b1c2-0c9b4b2f7697	assessments	3c12e8bf-ef62-4325-9059-1e54ea65dda7	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
413ebae4-d625-4c17-bcd8-7062b77a3c99	assessments	e40f4250-659e-4113-844f-bfc33cf0fe60	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
beba88cb-3e5b-49be-b57f-33b4e5a8727a	assessments	d6333c3d-85ad-435a-a9e0-c4cca5c6e892	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
1c7852c2-22d3-4630-9410-137f835c770c	assessments	a84a4138-04f4-48ca-8076-eabbf0e04222	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5e8d0ef3-ca4b-4017-b0d1-72506d1da9d7	assessments	d87a5192-6ad2-4bc4-982e-00749dc12be7	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6c9eb9d9-ba69-4726-a760-b4aa926fefb4	assessments	57670519-96fd-4721-a796-a1bbbeacf3e6	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
b891eab4-b3ee-42ec-8407-c648990cdfe0	assessments	f4ff89c0-1590-4920-9bbe-eaa5ad95b4b8	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
172e8397-7a13-44fd-bd2e-17dda974589a	assessments	b527c145-3fb5-475a-a06b-1e6a6423f7c5	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
0611714b-d36f-4535-8c3f-af106ce23c7e	assessments	1180e11a-b7ab-4db3-a9c1-f2849f538f17	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
18ab3d59-4b00-470a-ab96-f64812484b3b	assessments	009cc7d6-3242-4676-8711-0e00d87bbb62	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
8f635be4-34cb-47b6-bc1c-16865acafa51	assessments	1f7ecf2d-8b5d-4645-9b9c-88ae66953fe8	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
dbf47b5a-340b-45b9-86d7-6047d4d51a47	assessments	110c6c55-5ec1-4243-96e7-1557164db55d	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
ecae4be9-ac8c-4889-ab2b-ab5af76524c2	assessments	18d33d3d-3a4a-4156-bda6-069873f047c3	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
efa4a12d-17e4-4664-989f-adcb571e91cd	assessments	f6207dfb-eabb-4f0c-852a-e95d7032cbc9	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
98aa3660-1d34-4190-8252-d0e2e87139f8	assessments	aa68f23f-11cd-479e-97b5-deb4dabd3f07	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
f70845ef-d651-4794-90a1-5c46eb3a8f57	assessments	3270552f-fd09-4b94-b6f9-1054f1f3d8aa	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
16471e7d-44e0-490b-8cdd-cbffff28f340	assessments	0458a8ad-f204-46ec-a99e-a448a4d8a00c	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
9fe233d8-9355-4747-a078-05327297a999	assessments	50982745-f2db-418a-b080-9e13b9cf970a	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
7c1e2a4b-6d23-4440-889f-eac89063c3c7	assessments	a66dd581-ff04-49a3-81a4-5b18935187ba	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
1a8a407b-bffc-4965-b219-d6c496f49d8d	assessments	65793d48-2258-42c6-a0c8-c73976e5f10b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
114e1e35-101a-4fe1-a1d1-a984a0232523	assessments	268fa31e-2315-47ab-8520-2547d919cce8	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
24b4c9ed-0343-44bd-ad0e-726dfacd8279	assessments	fc0f54cd-7a85-446c-b715-ee9d3bbe1558	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
c8256d7d-2e61-4771-9d0e-2a4206869567	assessments	a51ec255-f4f9-4db0-8b96-e40a3c61ebcb	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
ab8d6b05-a378-4074-a529-3a1acfb1eac2	assessments	42ad3c54-c56b-4a79-bb4c-6ef18e3035e9	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
43667241-934e-4ddb-88f3-de245b3165b4	assessments	d6d15832-9f58-4b29-b41e-46b438e65488	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
3348fcf8-2286-4dae-b846-8652b58d4f0c	assessments	bbc1d29d-3e90-4127-93d1-8898db1b32ba	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
9f4727f8-da4e-4d12-8c6e-959a89b16a39	assessments	49d2188a-b195-41a7-87fe-2d8ab093d31b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5f359ce9-bded-4ae7-8055-809f9f1593f7	assessments	80ae7a0d-6e2f-4e41-a9d9-544d2f0e3683	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
79adecad-089b-46ca-b10d-6932b0950833	assessments	12fd8f2a-6198-4f53-a5dd-a361fcb6f101	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5ad64583-0cdc-49bc-b09c-49986f3da572	assessments	0f67ae61-6355-4e40-b003-328e26718354	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
3458d42a-2c45-4726-87b8-ba3cd50d78b9	assessments	db56f8c7-dcad-4703-b1cb-dd4c7cd19fea	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
09c39564-9743-4ccb-9277-e6cd72b442ba	assessments	78ebc450-5226-4d7c-9fae-6e4dd114f465	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6db515bd-84ac-4b0f-a10d-9d6a129120f2	assessments	61ee4480-63ef-49ff-964e-437bec1d5d5a	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
a0d2ed78-044d-44c7-ab8b-9960ad522f56	assessments	0efb7513-7897-4a9f-8bc4-ba82abf9def3	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
3e6d6cd1-a494-4a27-be99-d041c48d24c1	assessments	6aee896f-d778-4662-9a08-afdd6dad0bf2	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
00ad40cf-034e-465c-b472-e5cc03356394	assessments	998578ec-491e-4bd9-8575-e531b1ee2e47	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
b8e409a5-07db-425f-a16b-146793db0c9a	assessments	4345bd51-824d-42ca-9e3a-024d0e05d242	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
326e8400-6c9f-459c-aff6-dd2f04bbe092	assessments	be9cc4ce-56d0-4b11-bea3-4198efa6806b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
91dabd77-e9a1-428a-84dd-d7951d0d5d47	assessments	aada01ef-9b90-432a-9f98-e8dc0dcb0e44	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
e556d05d-59be-4fcd-9683-8a0240792532	assessments	a3289a5b-6afd-4a48-b754-4d7aa6b7c78f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
c0f39cfb-4110-4175-9ca9-0e2340cd96bf	assessments	fa86a07f-7f09-44d6-8571-6e7318cad58f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
c6e45b24-bd3e-4508-afc2-d0e0fd290cbe	assessments	898760ff-e630-4072-afaa-9a9bbc064470	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
59cc9990-0cd2-4ee1-a8c9-a0dc29aa18e6	assessments	7ff1c614-0488-4785-bae4-7c0acc1fb24b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
4a526133-2754-4196-a7b2-67b6b1f0d855	assessments	cbb3398f-75ff-43e3-92dd-2ec73c6bfeaf	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
403ca506-f2f2-4d17-82eb-c5db9f5d6061	assessments	4d0103c3-2b83-4b38-ad2e-163793b4a9a6	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
be9671bf-ec1e-490a-8022-11402fe1f138	assessments	271d80f7-023e-4abb-8633-b74af0f06971	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
a574b2d7-bcae-426f-b271-e27cd96cc25d	assessments	7fea63b3-aa68-4bf4-ae70-648d94e8b29d	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
ae2e3cd8-a4a2-44af-89e9-441d47fe4642	assessments	c956818b-0006-4893-b97f-cdc4f745b375	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
b241107d-9dd3-4356-8e24-e161b67c0a51	assessments	d34e9e36-1a57-4ead-ac25-16abb2c9d4a1	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
aff5e8f4-507b-4639-b0a8-cc8150c1b8e3	assessments	2367c628-4e7f-481b-a917-7d029b78b2d7	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
ee27b640-cddc-4b2e-8d8c-ae5417ff26cc	assessments	46c6d6fb-c4c7-446a-a169-0c89aeb6bec2	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
4e182883-7d30-4712-9218-41405037bdd9	assessments	ef8ca3f5-057d-4c80-bc4a-a72ad825d956	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
97d85ee1-f374-4698-9aae-6bcb3e1cb0a3	assessments	e84b5be3-948a-49cd-bd0f-3b9074a7eb35	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
a3f9961d-d2e6-4db5-8921-65b5df52ccba	assessments	18782a1a-df6f-4866-8bf0-d292772c22a7	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
4d2fb1f1-1bd7-4387-8d4b-16640c82a189	assessments	228cd364-90c0-45d8-b5f9-b976c26abacd	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
b2d3a351-b3bf-4aa3-8031-4465e1d1ea2c	assessments	e79489ab-9a53-4c34-8f75-03422b35a36a	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
7dfe0e0e-e474-4721-89d3-8a32cb228b88	assessments	220ef198-d669-43f5-bb91-e6c3454128e9	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
b896ac86-2aa5-4f33-9d5f-6460b40dd681	assessments	2abbc9c8-39ca-4365-8d89-f6b5ebc54122	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
396bae25-cd1d-4ecb-9aec-82c7f66d0ce9	assessments	cea11c89-c24e-4039-a468-426d67c12875	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5f3e81f7-b964-4159-98d9-49d5fca7ce15	assessments	79cada9c-050f-41f3-baed-b641b69e30f7	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
80def7ea-7823-491c-ab66-79529e302393	assessments	01a57ebe-036d-4b5b-a4ca-4793a29efd4b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
bdd0e18a-a699-4237-854d-bff34b2ca895	assessments	fee52319-bf7a-4c6a-9838-133498076218	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6571a985-4fcc-4cad-9d03-2a1906b984be	assessments	bda16c6c-753b-4615-959e-7fdd1cfd74c4	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
9c3210f6-88bd-4795-9ca4-6ad6cab34f11	assessments	782b691c-6fa6-49cb-9a03-ba47fb1cf33b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
c55b3908-d2eb-4c94-886f-7a5e5db7fbef	assessments	84875ad4-4b59-485b-aac9-0c77b5ea88a1	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5d5ca867-7785-4dd8-b411-699907339daf	assessments	30fc6786-1e08-4744-b69e-04b75a2efe62	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
8050a4d6-cb38-4e24-abb2-8ec10d372943	assessments	d52f5604-1a83-4f1b-8f57-bcc4bc293f9f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
305a7cb3-a202-4e76-a2be-24f82cdf62cf	assessments	0ef66cad-4e0a-41eb-bd66-dd2427ed49d5	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
b444e2aa-b62e-42a0-90ef-96b7e177dbe8	assessments	db20f1c6-f40d-4bc9-aa8e-ebca75681639	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
4daa0ee6-2048-4fed-aaab-976503d6de56	assessments	1302a29b-2c26-4cd8-8bf4-7fd70733dca8	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6b22ff9d-360f-49b3-95e8-918483c32f64	assessments	ead2e648-8476-4835-8ec5-7c85782e38a9	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
3f87f849-3ea9-4c9b-8569-2a2d664d4d16	assessments	7778b919-f402-43f1-b38d-6d97b484bca8	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
c29e7cc6-a7e4-44ab-83e2-3fb7975d309b	assessments	8ce74645-6b7b-4ed2-9b4b-01bddb52c13b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
8aff3284-db1b-42cd-bbba-bcd758fc7bfe	assessments	cc177e49-07dd-4ea2-8bc6-0fe3ee15fa24	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5aadf0f4-d203-4cf7-995c-d2d474e73d14	assessments	56747b3d-e919-4a48-80e9-3bcf568937d3	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
ac4e1b72-82ef-43b5-b105-99a00d705078	assessments	05342a46-3b4d-444c-8448-651afe809297	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
b9688072-b7da-4fd4-9658-9aac87420a14	assessments	8c25822d-d59a-452d-806c-3e2b09f1d117	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
2c77ed80-3515-4daa-b7c2-f373962422f1	assessments	6a1c22fc-4260-4e5a-8af4-5de8bdb16034	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
e0dfdff0-14fa-4463-b4cc-9c38ad6b3df3	assessments	fbafe22a-1ee1-4bd6-bfcf-6fe5d10a00eb	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
a4e35c1c-e7c3-4373-8830-7cc968527d74	assessments	ef080a83-b30b-4a5b-a4f7-d0040e96418d	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
88d41f88-3bb7-4720-a9b5-ccfeda2068d7	assessments	636b663e-7b75-49dd-8185-b4b824504732	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
1afebda9-73b8-49f6-b51c-a6838317ab04	assessments	5c219d2b-c961-4d36-aea1-ce8c6c6d2703	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
8f4e0304-7911-4d31-b037-21d3a931bc37	assessments	8908f28d-3361-43de-8a82-0fefa948f307	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6377e9c6-c131-4558-bf36-453582e13a7d	assessments	ce7dbae6-a63c-42a6-a845-dc3c654fc9db	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
55183226-aa3c-4bb8-a477-4370e2773ecb	assessments	680f5efe-28ed-4c5a-b52f-a0368d600b14	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
45f53676-e002-497f-a5d3-4da6fe8fa37f	assessments	0c022288-9f08-416e-99bf-5f587aa47ee5	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
add5d8e4-fb0e-4ea5-89e4-8c9178a24b38	assessments	53e12149-9411-457a-900f-612006fc0c4a	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
dc205cd4-627b-4150-95e3-c8e3ac18d1e7	assessments	34b75abd-fcd4-4919-b214-8b0752e39a97	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
fb1a6837-67fc-49d9-9b87-887dff997930	assessments	75caa6bf-0720-42ef-97ca-6336b7841776	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
0b16a642-53a0-4bbd-86b0-79214c283e0d	assessments	c3b1294a-1119-4b62-a798-ae30d7fc7ff6	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
3d9037c1-9672-4d80-b9b1-d5aa60e6fa7a	assessments	3a18bbe0-92a5-4586-b350-eafd9cbb9866	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5ffd7a33-9d94-40d7-b6a5-cb9f8c9db980	assessments	8baa0ca8-7c68-449e-8033-8d8d4f706f4c	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
04478cfa-7ce5-4db8-96d6-7bd9f1e32355	assessments	1cee7f88-adb8-457d-a5ff-991d115d8424	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
063acfd6-7af9-4a77-82d8-5e746b003c52	assessments	0409b727-8cd2-4f15-b83d-75c3810984db	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6aa2e5b7-0152-47df-b660-df15aaa193c9	assessments	31ca75d0-1640-43e4-8ce0-07c4f035df75	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6f964161-9100-4f5e-8002-ef140efe370f	assessments	1c6858bc-3b23-4041-b8ab-99590177b675	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
2f92b5de-20bd-43be-8cf5-e9353761db84	assessments	36ec8da3-9d7b-4b3f-86c2-d105e6bbb0d3	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
8d4b5e34-1596-4150-a970-9e712bcbe0e6	assessments	e28d1ffb-9dda-49b7-af4b-f147bb389aa8	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
9a4d8cf9-9178-446c-9901-560f5ab2c56b	assessments	852d535b-be1d-4ad4-9051-c079a50b5da5	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
af71358a-016a-4734-a29a-b6939717f71b	assessments	14cbd372-4b21-4aba-94db-b31af3e04b79	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
af300ea9-4296-48ed-a722-631804b835ef	assessments	a47fc649-d596-4390-b69a-ea627c1c8940	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
2afa9f07-b541-414e-9a64-cd68c0520067	assessments	6c818f3d-f838-4cdb-aa6d-587af2be7b66	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
438a8964-cdc6-46c1-8865-eeb3716202f0	assessments	e917bc8c-3def-4620-babe-65e82790c9b4	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
950163d4-30b9-426b-9408-96ae5e99208b	assessments	aaaab743-3502-47c1-89bc-e1b24dcd06d8	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
2bb1b01b-7bd4-4a21-8df7-564261347131	assessments	dab65ba1-139b-4997-8472-568cc15e4a77	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
d7062fab-5315-42ac-8b72-7d2a8302f8f1	assessments	24107f7d-f2da-4874-854c-82eabe65923f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
fdd20cc0-4f8b-43b0-bfed-5d815bfa0134	assessments	bd919ee6-9061-498c-8c37-2f45640110ce	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
4dcc24c0-56d1-4679-863c-9cc3abb72737	assessments	72be8eaf-5de2-4892-994f-c80b7cb77dc9	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
1bf6fe56-5ece-43b8-9ebd-d4216fe4b182	assessments	b050c8f5-765e-4d52-b531-a9fa70d6ba6f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
efcb1fe0-b699-4bd5-a3fd-6db6b1194743	assessments	d0d6f517-9c72-4457-a12b-850536e2c1d4	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
fc33fd77-7356-423f-aef7-004fb32224ce	assessments	820e14a7-0ce1-428f-867b-c4e4c1971fbc	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6a5873f9-450a-44ec-a5ec-d5e2febdaad8	assessments	ab87dac9-1038-456e-9c1c-0be8a3b85dfc	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
42323dcd-e516-403f-8b0c-8f049a1dfb80	assessments	e305a27e-0326-4c96-8779-063dcdbac1d4	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
70c3f65a-7011-4dc5-b853-ca791847a187	assessments	f53f419e-dbda-44b5-bd4a-ac006bd0700d	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5886c525-c209-4d65-adaf-3f7388bcaee3	assessments	8ea62baa-9fa0-4d15-9470-556237787696	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
d5c2b9d8-f6fe-48fb-a93e-f08fd823f56a	assessments	02538baa-d0cf-44b5-a875-732bbf096903	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
2d4d1620-2760-458e-8c44-c506c86ab844	assessments	0a5d33e6-85ec-4292-aa45-acdf3ef466f3	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
d3cbb2ba-f3dd-472c-b176-88678500ac9b	assessments	62ea43ca-04e8-42e3-a4ec-bb0b62a634bc	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
b0fa4a28-fe35-4f93-8d73-91afd66c2ff6	assessments	f08afcfd-6063-48dc-b034-7d70ba0aa836	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
73c357fa-244b-4cb4-8b42-4e146b2a11b4	assessments	aa4c26ac-26e3-483e-9771-806e23e8b708	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
61fd2bdc-2fc8-4237-95f4-de4350aa6341	assessments	958255b9-ac39-45b9-a6f8-d4f80fc386c9	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
63983fe3-41cb-4aa6-9efd-6d22841fc6b3	assessments	a2e5801c-a9c3-44d0-b985-e2f04f71e96f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
55ff7e09-5a66-4168-991d-30ff3f3e9ac6	assessments	69a29cae-347a-4105-af27-27b0206ae948	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
8b5949f2-053e-421b-b2de-dfe8f46c58a4	assessments	e58fe579-33b8-4c64-930c-e0f538520a89	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
2787fa80-9e0c-45ae-a343-d700c0d8c552	assessments	7159b9aa-35b5-48bd-a44f-34acd58ea02c	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
3238e516-ed96-4a96-88f5-8f6fbf10722e	assessments	a49f83ae-437d-4574-b377-856ae532c715	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
9f2b8364-1436-4d5a-8c7e-997cc2985b82	assessments	ecfd1771-f232-4a4f-aafe-ed0cfedb7bd7	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
e23c4d18-dde7-4cbf-8eb0-5e89d1e5ee0a	assessments	eba3b710-1dd0-473e-a4ab-165d4d53ed6f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
60e1529f-0fec-4071-b8b5-63d16af7370b	assessments	225f4f20-048a-4183-b4fb-d72ac62db96c	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5de67fa9-7860-43d6-8b56-e4452a80a71f	assessments	6713c341-1620-437c-9078-3e13eb23c606	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
1b5b176c-d236-4ece-b14b-6fcce469ef4c	assessments	764def1f-8182-4e6a-87fd-67186a2ae0ae	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
4db4c60a-c9a0-4672-adc6-f82dfdc4b08d	assessments	d703f252-141d-4ec3-a5ed-93de38d920f6	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
7cd4f53d-b150-4bbe-9d7e-195bc01e8447	assessments	8e8346dc-969f-495b-8f9c-47151885fe75	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
9dabbe54-9eea-4aa0-88b4-3586683255bb	assessments	3e6a97f3-b173-4e26-9dc0-46e339974d59	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
1074a584-f3dc-4454-8cd0-d3fc1e46a8ce	assessments	c4c04a75-a0f7-4f88-ba7c-a6d21b2dee24	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
cce56c1d-0099-4962-bf75-5007b7e3631a	assessments	de9676f4-07ff-4ffb-b9da-c2dd5695a3ee	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
3bb07013-9d44-4ab3-af4f-a4d900f93d26	assessments	5362aa64-fcfe-4476-b0ff-7f9b1777ae70	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
4546500f-c63a-4e49-9550-c2ebbb592014	assessments	953fe5e8-81f1-4dc6-9ecf-a43f6b316312	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
4f1a0998-f883-49f9-a47e-14a5c8c2fd4c	assessments	77333c8a-b1d2-47d9-a2b4-392ee42d4bb8	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
bd8c128d-1402-4287-9006-4910bc3e1ffe	assessments	c33d9fcd-3e41-44ed-9e94-a162b100f54b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
0c2b83c4-56e3-4e25-805e-5dc8180205e3	assessments	e42239b0-6f58-4ff6-af31-1e2961c4a2fd	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
8bbdc8a1-0d5f-4104-874f-d3189781c266	assessments	b142bbd6-fd4b-4bfb-a0a6-99b4c95c73b1	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
20e614c7-ed3e-4a68-ad0f-a356112cc5e2	assessments	171e7c7e-8b6b-4d59-9d8d-be373640ef8e	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
0ad17f11-8bd3-4be0-ba6e-148aba3442b0	assessments	1ddb225a-7f6b-4f6c-85c3-aa42723fa846	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6d01892b-7170-48d7-be43-a96afe1997d7	assessments	007364f7-f496-4ba6-adf0-e4eaae3b8c31	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5cf3b51f-0573-4fe6-aa72-53ce383cabc5	assessments	ce2892d1-0115-4a9a-b4aa-4b301c3a675d	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
21bd941e-ae3a-4616-b4c0-b994240ae0b5	assessments	e7a02150-bc66-4435-bd03-c80f7a423f17	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
bb08f834-d5dc-4284-b3f6-0ac4aa0b0a2b	assessments	c4caee67-5be9-4706-8a37-97ebf34e3cf0	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
ee619cf5-ea3b-43b4-982f-982b0d099678	assessments	4c2df4f9-ea99-4e7c-bb01-61c28dc00ef2	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
66212900-0e04-41ff-bc0f-c0205e2f1c05	assessments	6c60c2de-d5e7-4569-8795-2f876c50a708	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
a48a6e6a-bc7c-4ea2-9364-eaf34074ba35	assessments	322648d4-89dd-4289-9c72-6197400997b2	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
e806d82a-de0e-42cb-8c0c-847ab5731b05	assessments	63df10d1-c0ed-40d5-b5f8-1a9d1964b9c2	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
08cfe88a-73c4-4acf-9075-4061c0462bcc	assessments	936f5fca-f620-4090-8b46-095b6156976b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
7b4c52bf-0a7e-49df-a17f-a334167dbe71	assessments	8e29a6b2-0ac0-4798-b7f3-bd058bc19be6	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
163169d6-5041-4b20-849d-85ce96d71fde	assessments	c4a893fc-b0db-471b-914a-df62e14fff1e	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
4ac41d7e-81c5-447e-9263-43e5143e4d28	assessments	4574ec2d-b35a-479d-b0aa-8a143d424791	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
d96c043c-f86f-4e20-bfa4-5cf1fd1482a7	assessments	dc077fd3-a7e6-44df-8f26-4493642b9aec	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
17b2e91a-0832-4804-ba56-e4bb5178388f	assessments	6c72f3eb-961f-4e71-bbbb-555833872b03	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
f1bfbd3d-eaaa-43d1-9d3b-4393897332cd	assessments	5fc88ff1-d8c2-406a-84bf-f7d71b29adb5	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
a17192f4-cb2e-4cc4-bfbc-66be90697798	assessments	c3926673-c295-4e21-972f-743a48f01003	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
10d26a88-b3b7-48bf-b63c-a531d994a3d5	assessments	96198b1c-0eb5-48ae-a1d3-81901aa4a4db	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
e01dac38-332c-4682-bf5e-1769533ce659	assessments	cc467957-7b6c-4acd-a3a3-2fc032f8a2ae	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
dfbc6316-638d-4ec4-a0ef-5a8791be1979	assessments	b9a486bb-8cca-4fa1-9d60-91044ad2e808	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5edc8486-a65f-4e3a-bdaa-88e12d258f9e	assessments	541cb293-8278-4411-933d-479e3738bcf7	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
3278dc38-b45a-40d0-861a-ad25ccdb28be	assessments	c3f7629e-2a88-4ee8-88ef-16a464b9ce05	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
17b1730f-0613-4715-b9b2-0987deef0ecb	assessments	0e153004-4ca6-4924-be28-5b5c51db0759	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
1d4aa8e5-6d28-4f98-b879-65adb5cf51fa	assessments	e548e8e6-b510-4436-b38b-6923482c66db	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
adc67b98-6172-4ebc-b617-2af58d947c29	assessments	ca2cbb19-58d5-4511-81d6-42845dac0cd2	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
7a036a1b-02eb-49ef-95c7-346d691210d5	assessments	c8ebeaa3-6595-460c-b01a-0eef19c11e75	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
9b1182a2-9e60-4073-9ac7-9905493e3ad5	assessments	633bc89a-ebcd-480b-ac23-adb2d707212d	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
eaa1a228-5288-48e0-9a92-27029ee70590	assessments	222c47e8-e36d-45ea-b8e0-dd91ca685914	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
a52cba20-05b6-4909-abea-1d951779d962	assessments	f3f0e897-6f77-403c-b44e-03cfb5a3c2ec	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
ece159ec-6383-4c7e-98bc-89a366f58696	assessments	61276b9a-14f0-4430-b763-e0134211ec2f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
a88a646e-84e7-4392-8ffe-47cf637c61fc	assessments	2acd22db-2bc5-4e85-b28c-422651f31fa9	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
c8e088c7-0348-467e-8f80-5c825b9d17c0	assessments	024e99cf-943a-4087-9744-1dfcedf2e54b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
a79bacf5-a797-493b-bae3-59b6fc05b760	assessments	99a62266-8aa1-48dd-8a66-6d97b6dfe407	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
8a95f5e2-f472-47df-941b-f3be1716c4a9	assessments	13a04202-4c85-48b9-85cf-9fa0871fce22	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
0119f433-39b9-44ba-a776-dc7c332b0a79	assessments	c7a07cb4-4f58-4aeb-a6a8-d3d002162d99	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
f828f792-50c5-418f-a3ea-7cd5d08b924b	assessments	30b7110d-0d63-4085-a005-534636cf3c68	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
417f9463-eb16-4b66-a836-5a48fd27018f	assessments	d4db7d9b-5970-45e6-9a18-7b2192f1ee2c	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
0f83a68e-b5ca-4aeb-bfcd-274915a375af	assessments	1c8d762a-6428-411b-a87f-6be56f0f8f3c	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
4dd0b528-8851-41fd-9e80-4c6b5fe3341a	assessments	6248141d-b507-4e6b-b59e-cd6195660778	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
d4423dd6-ac16-4169-9801-0aca20d3c32d	assessments	273b51ff-a3dc-4313-8497-8e7d80640638	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
4a03ada2-a62e-4cac-9d82-d09490b2f4c4	assessments	9927962a-61e8-484f-8513-88f2c12f9a28	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
f8509693-b62e-455d-8673-eb2606eb0482	assessments	e2b145dd-9384-412e-9abb-2316628c6e3f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
462366e8-3411-47ea-891b-fa4e50882c76	assessments	b4caf890-64f7-4b3c-9c18-113a9f02d413	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
b7157359-757b-4128-a084-d2a50258d33c	assessments	25d8c728-010c-45e7-a270-7550ec9fd281	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
de348517-dc7b-4bcc-a0e5-b17519db7b49	assessments	0084f2e8-b67f-432d-b85d-e131bc5936cd	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
940f1276-8744-42ce-81e3-dbf2418d1d3c	assessments	953ca961-ce05-412e-a20d-ac88cb7b5bc3	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6f147f37-e9d7-4c13-b584-b4173a4b675f	assessments	7c84fb8b-28eb-46da-a8fd-cca96ec39f18	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
bd13d9f5-8371-4f62-b9e2-daa22f435751	assessments	8a2699e3-3b5f-422f-9a66-2da38cf71ca5	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
235289d7-f0b9-49c4-a683-536eaa8ad8eb	assessments	52e2e4f8-371d-44fe-9b1f-1a0e94be6ff8	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
6f7ea690-336e-463e-88bf-fff3cb2d5471	assessments	500c3a67-c1de-45f2-8aab-b365b6f71871	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
c47d9d22-6343-4c61-9dac-e5f23e0c0902	assessments	860c4f31-b482-41c3-9b6d-d4a283a96114	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
5aeccba4-b19d-40c6-ae45-6b88aa4da663	assessments	e9da80c9-4d4f-4e7e-bd28-a33e67466997	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
e5e65c8e-c3c0-469a-bb9c-355d0b4e32c7	assessments	4218f6f8-095f-463f-b4a0-be4a4321faad	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
81be6ccd-eb52-4481-99bf-5696af89d378	assessments	cf9048eb-00da-422e-a3f8-99d22875ceba	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
d2a37eaf-3d4c-4996-8c17-e6b5f02ef942	assessments	b588e8bc-0a96-4717-b832-5e5ce25fa8de	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
1c7544ee-8170-498a-a357-73d7ca975017	assessments	6aea16c6-15de-4336-bcbd-bd5d9d6d3ba2	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
86ad005c-0f8d-4575-8c65-082c8eea6656	assessments	ff708bab-c69d-45e5-beb3-8f5666ed0b3b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
fcab74e2-370d-49fb-ad69-24f7af0a64f2	assessments	2e955df7-53bc-4d3f-9c39-57fe6d5a457f	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
c99aa5ee-16d3-45e0-b066-22e7fc28b55b	assessments	294740a9-d203-4316-a948-f9307ea820d5	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
2e200b9c-ebdc-416c-be8f-8d4312db0c02	assessments	6fc11daa-1627-44d0-b030-b1db508f23ad	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
fc0dadbd-5fc0-4302-b384-9c31afb9a364	assessments	5c42c426-347c-42b4-91ed-817c6090eca5	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
983a4b9b-966e-434c-bc50-1ef4e90b1a5f	assessments	7b8fbdfd-6e62-4d91-970b-7fa778c15f71	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
a79e5edf-0fb2-476e-97e8-1f7fc6d0eaa3	assessments	923ff7c8-2dd4-43be-8a05-7d51413ee8a2	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
0e40b09a-68df-4efe-bfce-29b782827de2	assessments	eb71f510-cce9-4502-9270-236e7317e9a9	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
246ff276-59ce-4011-be9d-72bfcac2a281	assessments	38c7cb94-5409-4c54-ab13-c9aec7bbfce0	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
dc1eb597-a0cb-4df0-b055-74f4d60fd247	assessments	17548c03-dab6-4335-b3df-01577711e6ee	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
a7d474e0-83cd-46d3-acb8-a3949f6a0231	assessments	327bb876-6feb-4c62-9632-925f9a5cd7c0	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
bb8a188c-20a1-4894-baba-0806c662adec	assessments	b80b5cd4-3593-43f2-b2d5-cc385ca842db	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
b49a2352-2480-4789-9efa-b659a76ede1d	assessments	6b969f2e-6f57-4319-951a-c0430e07f448	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
d5582585-aa7f-4b15-bf22-bc8c679444c9	assessments	5f1c998d-ae07-4193-a476-dab1eab0098a	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
01ec0d28-3d2a-44f7-b84e-bc55fec70711	assessments	86e78746-6346-408a-8166-ae21dedc1640	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:44:47.758814+00
ff497492-ce6c-4ee4-a58f-2cd1aab2c2db	assessments	ec89f67a-3d5a-41c2-ac56-1f31ef3328c0	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:49:40.781666+00
a4e96d42-30d5-4dd5-a6b1-d1353e85c2e7	assessments	8f8cd9cb-4aa3-4480-9c29-749fe190a00e	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:49:40.781666+00
c59a4bc2-751f-4809-a38c-da8dfbaa638b	assessments	06a3612e-9a2a-40e1-bc74-ea4239e7036c	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:49:40.781666+00
fee47386-5186-4dbf-8a62-02ec3cff3148	assessments	a1bff143-2f0f-4e87-a8fd-01a29afaf8a6	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:49:40.781666+00
2519c742-0655-49db-b662-f80b0a499a5f	assessments	814acd05-7efd-4267-b0a9-5df3a4afd04d	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:49:40.781666+00
6173c6a4-ae63-4f82-8e53-a2090b7ae597	assessments	ea54da76-b9f3-4ab5-803f-c933d2791567	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:49:40.781666+00
88126bfc-7658-45cf-8e14-72daacbd71db	assessments	cfbc5123-753d-4f83-80d3-81e7bb244db7	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:49:40.781666+00
cbb9dd86-555d-4966-905b-e4fa1769f3cc	assessments	50fe15ad-a712-483e-82c2-dde5f0843dc9	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:49:40.781666+00
9c61c0b6-b411-42d2-a8b4-dff306a9ea3e	assessments	a815ec8f-51ba-44ad-a656-7b9e0a8315fc	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:49:40.781666+00
0afe7bd5-242b-42e1-b2dd-3460128009ca	assessments	be2190b4-39c6-464e-a5f8-dc847f074008	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:49:40.781666+00
e8f53583-f729-48cd-9d24-54b785059f2e	assessments	ec89f67a-3d5a-41c2-ac56-1f31ef3328c0	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.607725+00
97e18fec-2e30-43ab-86ca-c09b7f860e6d	assessments	8f8cd9cb-4aa3-4480-9c29-749fe190a00e	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.607725+00
b7051273-2486-4cb3-8626-2634421e5478	assessments	06a3612e-9a2a-40e1-bc74-ea4239e7036c	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.607725+00
e64c6d1b-ef34-4491-864e-b79f2790f38f	assessments	a1bff143-2f0f-4e87-a8fd-01a29afaf8a6	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.607725+00
b8bd4042-77f1-497f-bab3-341862c07640	assessments	814acd05-7efd-4267-b0a9-5df3a4afd04d	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.607725+00
075e0ad3-9088-4871-8f89-31ab28659bd4	assessments	ea54da76-b9f3-4ab5-803f-c933d2791567	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.607725+00
2be3e861-2287-4d3c-bb71-3d2744ce6640	assessments	cfbc5123-753d-4f83-80d3-81e7bb244db7	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.607725+00
18bcce3d-2307-47c0-9a81-7b6cf1651402	assessments	50fe15ad-a712-483e-82c2-dde5f0843dc9	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.607725+00
45419da8-035d-4ea0-ab48-9d8f55bef5a0	assessments	a815ec8f-51ba-44ad-a656-7b9e0a8315fc	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.607725+00
f7faa768-b4ab-4719-8f20-019e627674b0	assessments	be2190b4-39c6-464e-a5f8-dc847f074008	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.607725+00
4df6bb66-45e7-4fa7-96e5-a1a29b4987af	assessments	7a71c310-dc9e-4f2c-add3-65191eb2b379	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.797387+00
a49d5026-c90c-454c-92cb-e91a19df7bf2	assessments	2b28e76b-a904-4f07-9fc0-61c3b66079c9	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.797387+00
210cb31d-a6a0-4a34-9259-40e832a5399a	assessments	1b7b0929-27bd-4cf6-982b-b087a3cda348	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.797387+00
d98b8ee6-fd3e-4165-b6ae-9c273d0127ab	assessments	f14cde70-a61a-423a-83fb-194d0058c7f5	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.797387+00
e48c52f0-80e3-41fe-b171-fdd22e3d85d9	assessments	acc4f6a5-9eb4-4928-adfa-8930e5153df5	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.797387+00
02843b84-180b-4bc8-a185-b1d1ba5ce656	assessments	157e68fc-c153-4f7c-89a1-a6765a72600d	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.797387+00
db3efc55-7d1d-4c97-97b9-f5ccd6574370	assessments	c1afb0ec-1642-4f9f-9bc9-c5921947a813	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.797387+00
583e5ffb-4aaa-455f-91f6-22c998c2ac85	assessments	fd44c4c9-abc2-4a5e-9cd0-029f051e258d	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.797387+00
d7d5beda-781d-41e2-8efd-e60b7ded914e	assessments	93d9cd2f-a4ff-4dc1-8431-eca9b1cbe7e7	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.797387+00
edf7fccd-4e71-431c-9c74-2e5c75a199eb	assessments	77e99d7f-517a-44c6-a728-62189d272e0b	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:07.797387+00
88bdf48b-d160-44ba-be15-f179d359f4e9	assessments	e411070e-907b-404b-b614-1a0b58e2d780	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:29.093277+00
22f479f9-18f1-407a-b4f7-00826e0b0a6b	assessments	e411070e-907b-404b-b614-1a0b58e2d780	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-11 08:50:49.89971+00
4dd822fc-ecdf-4ce1-a56c-abc82ac584be	problems	721d9999-1178-4fab-9580-e1bec12cbcf6	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 04:43:01.779348+00
1e34a6aa-f9ca-4a5a-91d4-ea3efd507d02	problems	d91dc941-4959-4e3c-8822-d24dc1da0d5b	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-13 05:24:44.607051+00
01f85f7a-e7e8-4742-b1d3-eaaa003bca2e	problems	0791a8a6-d46f-48e1-99de-0425c7321189	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-13 05:25:04.75938+00
657eb711-6d49-417e-b4b3-abd4c222d5a6	problems	60b444f8-34d4-403b-b673-b7ec392de729	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-13 05:25:04.75938+00
d3903676-f551-4710-9f99-cfc1de1331cd	problems	13316a10-02b3-4104-ae98-0e42c53a09fe	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-13 05:25:04.75938+00
832d9a84-0a0c-4af4-a962-6230d0ce0a6a	problems	e3920695-2095-49e3-8986-8da7582f6932	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-13 05:25:10.780249+00
8af932ee-78fe-46f8-84a4-c5c3d3e3d1f4	problems	4aed7207-eb4f-48c7-ba1c-dc06e4a405ea	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-13 05:25:10.780249+00
ec999b11-91b2-48f8-8b94-7631c6803cdf	problems	7c46ffdc-123f-4825-8b8f-724d5adf2833	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-13 05:25:10.780249+00
571056d6-4dc7-459a-a4f7-08449bb5167c	problems	c893793a-e6c2-45bc-a54d-24231bc2f411	DELETE	\N	\N	\N	raheli@ringan.com	2026-01-13 05:25:14.348112+00
77b81b34-49fb-45ee-9ead-c9ddfcae8541	problems	f94dc5c9-0ceb-4b3b-8945-c1a7cc523f3b	UPDATE	problem_name	P001-2 Exam/Test Anxiety	Exam/Test Anxiety	raheli@ringan.com	2026-01-13 06:09:27.485299+00
35347f25-4f1a-491e-8dbe-3021a3848551	assessments	7a71c310-dc9e-4f2c-add3-65191eb2b379	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.144555+00
87728262-ec65-4238-a1b2-d67b27c7f405	assessments	2b28e76b-a904-4f07-9fc0-61c3b66079c9	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.144555+00
49165eba-6bf4-4a28-9bba-26005c69aa6b	assessments	1b7b0929-27bd-4cf6-982b-b087a3cda348	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.144555+00
66c082f8-1485-4900-bb73-6f8b7ca640f4	assessments	f14cde70-a61a-423a-83fb-194d0058c7f5	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.144555+00
edb96db9-3fbd-490a-8387-044a7ecde9ae	assessments	acc4f6a5-9eb4-4928-adfa-8930e5153df5	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.144555+00
2421b0f1-abb3-4e97-87f1-62d6755fce5e	assessments	157e68fc-c153-4f7c-89a1-a6765a72600d	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.144555+00
daade08f-ddeb-428a-b176-809258735b67	assessments	c1afb0ec-1642-4f9f-9bc9-c5921947a813	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.144555+00
d8e477db-0d5c-4bf6-af16-70e28e5c367b	assessments	fd44c4c9-abc2-4a5e-9cd0-029f051e258d	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.144555+00
bf124401-3979-47b1-b6c3-3841f2a20ba2	assessments	93d9cd2f-a4ff-4dc1-8431-eca9b1cbe7e7	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.144555+00
bb7890ff-d7b3-4d70-9a76-b66602ff371c	assessments	77e99d7f-517a-44c6-a728-62189d272e0b	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.144555+00
2c049526-ab03-40d4-8553-1122007bfe3e	assessments	114adfa7-602d-430b-9e81-90df69dc3ec5	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.540153+00
b2aedb29-5847-467c-8664-2ecab72c2912	assessments	6720b0c4-896a-441d-813b-65a9b34d6510	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.540153+00
e429bc15-1977-49d1-b603-0952061fc72e	assessments	42875c3c-a8af-4a7d-ab65-f421da74e43f	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.540153+00
760564b9-fd59-4427-b036-e5a23cf48f8a	assessments	7797d03c-68d6-4ac8-9229-c5c10f73b70d	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.540153+00
ae81407e-36f0-4061-a73d-82ec3317ab24	assessments	816accb7-9dc4-459c-bae6-107cc3efafc2	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.540153+00
3a3ab5ca-4eff-4b8c-a4ca-18005db9e29a	assessments	609be6ca-7d40-4618-a152-e080406e8f6b	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.540153+00
82ddf82a-799e-402c-a302-85c7b389de17	assessments	8f1f1337-a992-4878-a318-c9771d9dab5d	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.540153+00
1445cc79-fcc2-4ce0-9578-c98198620720	assessments	7b3cc73c-2c60-40b7-9286-68dacc3b353e	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.540153+00
21c3d64f-c78f-41c2-98d8-54870ae220b6	assessments	dcb168a7-5b54-4a62-8630-2c18c238f26f	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.540153+00
d7117323-5240-457e-b68f-b6d27e81f074	assessments	16c31186-66ff-4ae8-951a-2d721a05455a	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:19:44.540153+00
bd306c6f-7893-4529-a8c3-03e1f8efacf2	assessments	114adfa7-602d-430b-9e81-90df69dc3ec5	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:21.979+00
80a95f9d-a64a-472c-b923-19be2e2db750	assessments	6720b0c4-896a-441d-813b-65a9b34d6510	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:21.979+00
6396a747-e6db-4324-89fc-30df77fef342	assessments	42875c3c-a8af-4a7d-ab65-f421da74e43f	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:21.979+00
3bc04f3e-d80a-446e-8b93-0ee3486f6203	assessments	7797d03c-68d6-4ac8-9229-c5c10f73b70d	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:21.979+00
37e2cf6a-e9ab-4af4-9e4b-b143e4cf1d13	assessments	816accb7-9dc4-459c-bae6-107cc3efafc2	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:21.979+00
936589b2-9795-4536-9aee-31979913f24c	assessments	609be6ca-7d40-4618-a152-e080406e8f6b	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:21.979+00
cab494fb-0f47-4db4-be9a-292d6bcedcee	assessments	8f1f1337-a992-4878-a318-c9771d9dab5d	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:21.979+00
e861e145-4390-4ec1-aa7c-25d5f1bfa25d	assessments	7b3cc73c-2c60-40b7-9286-68dacc3b353e	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:21.979+00
8e800942-513c-4c42-949a-4eab19f9846d	assessments	dcb168a7-5b54-4a62-8630-2c18c238f26f	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:21.979+00
b142b8f2-ee19-4841-883f-96a0d1b52f72	assessments	16c31186-66ff-4ae8-951a-2d721a05455a	DELETE	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:21.979+00
ac57ee50-4d0e-4746-a977-353ea22205ec	assessments	7699ade6-fbd2-4208-8794-3df58b3201fa	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:22.12968+00
d0660589-7640-425b-832c-3b5733e2c3ff	assessments	ebec7083-3425-4374-9b8d-c05fa1691274	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:22.12968+00
28f1d796-e6b8-4ffd-9a21-0d4a4c41ca8e	assessments	3d8c0c58-b5ca-4418-8c17-eb371a964e14	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:22.12968+00
f492f7ac-7313-46c8-9a03-b0280f6705c9	assessments	235a88b4-fa3a-4e58-a5b8-983cd893846e	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:22.12968+00
ee1f96cf-4f5f-4f74-9706-253228ee4b4a	assessments	dc0b1fe2-96fc-40b9-a371-6a71df2aff97	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:22.12968+00
ce3dd72b-e2fb-4e07-ae8d-9dc88c515fb3	assessments	b8e255dd-597e-488e-a60d-090ad008de6b	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:22.12968+00
aadb3b37-4448-4d89-b323-fdebedcb2a3e	assessments	9e441b6f-173a-4cc0-89f6-b838f417227d	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:22.12968+00
bf6eca76-566d-4f81-b868-a546860fda48	assessments	406ad36b-d422-4c73-8d76-96ca717d3e1b	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:22.12968+00
cfe5586d-dbf3-40b9-8405-e9755393e13c	assessments	ad78829b-dcb8-49b9-97f2-d6bfe9d37fd1	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:22.12968+00
75677556-64ab-49fb-8e61-30371fbe06c6	assessments	8740e36e-8f8a-4450-bc1a-35dee1690c8c	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:21:22.12968+00
34f206fa-d7fb-4250-962b-a5fac0e8f022	assessments	6c3c6ed9-1935-4a45-a3ba-6859575c8bbb	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:25:44.017821+00
ea14dfeb-fb75-44d2-9257-3b90c0d8b8b4	assessments	f742a945-82cc-4957-b876-50242a2e4b4c	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:25:44.017821+00
b32fce4c-b849-44c2-823d-4078f008622b	assessments	08ed1b93-e715-43b0-b705-3616dd3b5dea	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:25:44.017821+00
61d05f80-adc9-458e-abac-71a731b477b3	assessments	9a6ac10a-843f-4653-bbff-4f9f677c429b	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:25:44.017821+00
7572875f-3b1a-41b8-9015-bf2521d20645	assessments	f59b95fe-967b-4a90-9f0b-bf2ad070bbf1	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:25:44.017821+00
e8e57cce-de53-4804-9a3d-2848087aa0e7	assessments	149370ed-52ae-41b2-be28-3430775fc54a	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:25:44.017821+00
78402a00-d50a-4b72-9fc0-f03f36a0d9c7	assessments	3ff85810-49d6-4254-85f2-8ada4cee343a	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:25:44.017821+00
30bde066-27ac-40db-b103-0025704fa08a	assessments	90174cba-4435-4ba5-91ee-caee2f7535aa	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:25:44.017821+00
ab7d3ec6-3cb8-4a5a-b03b-48f979040ef3	assessments	4c6942eb-aed2-4987-a99d-53dd8f70c7ce	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:25:44.017821+00
80fd20fd-0143-423e-a420-c0c2ccba2309	assessments	8b90f281-371d-49f0-9355-dbd5e2e3967f	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:25:44.017821+00
10075977-64db-4cab-9fc9-8830f01cf32f	problems	ea167b1e-68b0-43ba-bf23-5002b8f8fdd5	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:35:09.22909+00
0e56e342-eaba-4e4e-a2a2-01c2bfda2fb0	assessments	7699ade6-fbd2-4208-8794-3df58b3201fa	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
a1e45b5a-5c10-4929-949c-c88ab66f2e4e	assessments	ebec7083-3425-4374-9b8d-c05fa1691274	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
3963773e-6ce4-46c0-8bc4-ddf81d2f106f	assessments	3d8c0c58-b5ca-4418-8c17-eb371a964e14	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
a5290340-711f-4761-9258-9f0644eb7f12	assessments	235a88b4-fa3a-4e58-a5b8-983cd893846e	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
505715f0-37cc-49d0-bcaa-02d84ee974e7	assessments	dc0b1fe2-96fc-40b9-a371-6a71df2aff97	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
bbad97dc-21b6-4cd1-98c4-623111db465d	assessments	b8e255dd-597e-488e-a60d-090ad008de6b	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
aaedcb77-404d-4c4f-9152-bc989e8e96f7	assessments	9e441b6f-173a-4cc0-89f6-b838f417227d	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
faf658b0-db47-473d-8256-575e3259f6eb	assessments	406ad36b-d422-4c73-8d76-96ca717d3e1b	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
f9baa548-6155-4987-adf8-2847ca90462c	assessments	ad78829b-dcb8-49b9-97f2-d6bfe9d37fd1	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
8864f569-ea49-4bb2-b009-8d4f202387a8	assessments	8740e36e-8f8a-4450-bc1a-35dee1690c8c	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
5dd00ded-066c-4bef-9052-e5d766601a4b	assessments	6c3c6ed9-1935-4a45-a3ba-6859575c8bbb	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
91c34d46-6db0-4306-88d7-2be724902f45	assessments	f742a945-82cc-4957-b876-50242a2e4b4c	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
b1d49d2e-9ce6-4bc3-a49d-fa459a5ee1d7	assessments	08ed1b93-e715-43b0-b705-3616dd3b5dea	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
a2827b5b-5653-4879-9d12-0dcb0bc58ed5	assessments	9a6ac10a-843f-4653-bbff-4f9f677c429b	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
e5f8d60d-0100-499b-b8ea-6bf7658dcb62	assessments	f59b95fe-967b-4a90-9f0b-bf2ad070bbf1	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
40113b4b-4b12-4432-a673-f7102f011cf3	assessments	149370ed-52ae-41b2-be28-3430775fc54a	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
b3cea501-6377-45d8-8112-742466cb2ec9	assessments	3ff85810-49d6-4254-85f2-8ada4cee343a	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
a4fc8d69-d473-46e3-86ed-69035b66faa0	assessments	90174cba-4435-4ba5-91ee-caee2f7535aa	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
0fbef99f-7387-4a2d-8d7b-5065eb0a34cf	assessments	4c6942eb-aed2-4987-a99d-53dd8f70c7ce	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
55770ba7-6d71-45e0-affc-fa3b0e186141	assessments	8b90f281-371d-49f0-9355-dbd5e2e3967f	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:40:23.777562+00
d9509af5-bab8-4593-9604-c9b046306e0a	assessments	7699ade6-fbd2-4208-8794-3df58b3201fa	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
6728c9d3-7509-4f16-8874-bb3e56fee171	assessments	ebec7083-3425-4374-9b8d-c05fa1691274	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
8992190c-7e93-480f-9d9e-d296b31a00be	assessments	3d8c0c58-b5ca-4418-8c17-eb371a964e14	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
16cbf194-c191-4f02-b1ba-962ac3d687a6	assessments	235a88b4-fa3a-4e58-a5b8-983cd893846e	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
8e6194e8-a42e-44f9-8de5-c7da3eb1d93e	assessments	dc0b1fe2-96fc-40b9-a371-6a71df2aff97	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
26218b22-81e4-4224-b94a-e5e252a28b11	assessments	b8e255dd-597e-488e-a60d-090ad008de6b	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
c70ab47e-dc2a-44de-b979-dc8313836bd2	assessments	9e441b6f-173a-4cc0-89f6-b838f417227d	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
2a017be8-67d6-4cf8-86d7-9dc959ed8495	assessments	406ad36b-d422-4c73-8d76-96ca717d3e1b	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
f0e3feea-6e91-44f2-a0f4-85d5d2bc725e	assessments	ad78829b-dcb8-49b9-97f2-d6bfe9d37fd1	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
564038aa-349d-435d-9078-e4c28ba31cd6	assessments	8740e36e-8f8a-4450-bc1a-35dee1690c8c	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
64a1c172-8054-4f8b-ad44-110d4ff2e0e8	assessments	6c3c6ed9-1935-4a45-a3ba-6859575c8bbb	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
933421b4-04a7-4ae4-ab19-c1df6c9db542	assessments	f742a945-82cc-4957-b876-50242a2e4b4c	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
5c17d505-1ea6-4196-b837-5bb399c5cefc	assessments	08ed1b93-e715-43b0-b705-3616dd3b5dea	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
a5998e70-887c-46f0-a74a-58899d9049a5	assessments	9a6ac10a-843f-4653-bbff-4f9f677c429b	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
e6257477-1f13-4c1f-82c6-c90073ed2e07	assessments	f59b95fe-967b-4a90-9f0b-bf2ad070bbf1	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
23f77928-f329-4cbe-a27c-4b3eb6086ea8	assessments	149370ed-52ae-41b2-be28-3430775fc54a	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
2bfd2f5e-6770-4317-b360-db1dd9f02d7a	assessments	3ff85810-49d6-4254-85f2-8ada4cee343a	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
a784eafd-f0a6-448f-b244-a69e5ddd1656	assessments	90174cba-4435-4ba5-91ee-caee2f7535aa	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
aa4d5ca5-501c-48a5-a00d-abb12a462713	assessments	4c6942eb-aed2-4987-a99d-53dd8f70c7ce	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
4a4dcca5-8dd2-4a8a-9f43-ec954e9b385e	assessments	8b90f281-371d-49f0-9355-dbd5e2e3967f	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
90d893c9-2988-483c-902b-ab7551c87d70	assessments	ad1e5178-85ff-4327-b407-d7c8380565d2	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
919241d8-56f9-4633-b751-62577eea4bdb	assessments	57cd13c5-ddb1-4e2c-b30a-a101795db408	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
b2cb716e-e4e8-4391-a4c3-597f622dc11f	assessments	e6b22619-5f54-4591-8239-12eaefcdb6dd	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
1bb48a14-8fde-4caf-ae5c-324339c2af4c	assessments	3a749e0b-77b1-4fab-89a9-f1417e3856b4	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
763306e0-7033-40cd-befb-3a79525efc5b	assessments	3a6c37f5-5753-4b15-a242-d6a687b307be	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
41fdeebe-01ac-4d9d-ad56-56e9580bdf77	assessments	e6a000fc-c376-4318-a562-40490b468451	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
9491bd50-77dd-4e8c-8b4c-2bee9c486e2b	assessments	9c306f51-7f90-41d4-a5d3-01ac6c0f565b	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
482c1280-638a-4940-a737-d7331486c07d	assessments	94ad1746-0f52-4d49-8467-85b7cb186071	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
c8c445a2-5c90-4d5c-a348-1687102114af	assessments	54f3f94e-c5ae-4c70-9a79-7c2b83f1d62c	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
ad41caf5-4407-4c95-8442-97983a26193c	assessments	74e62e20-645e-454f-ac16-2e6b9edeface	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-13 12:40:24.023868+00
085e40a8-e548-4756-b3a5-15dbde7c4d11	assessments	7699ade6-fbd2-4208-8794-3df58b3201fa	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
73a435c7-2453-474c-861b-ada5dfc16586	assessments	ebec7083-3425-4374-9b8d-c05fa1691274	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
b6a42fce-4f5d-479b-8567-646b046cdb15	assessments	3d8c0c58-b5ca-4418-8c17-eb371a964e14	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
94afa2c1-222a-4a9d-86ad-fd2bf4268256	assessments	235a88b4-fa3a-4e58-a5b8-983cd893846e	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
93be84cd-8004-47c9-bf68-1a17d17de2e9	assessments	dc0b1fe2-96fc-40b9-a371-6a71df2aff97	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
d506670b-8ece-4752-878c-5e7f566c2dd3	assessments	b8e255dd-597e-488e-a60d-090ad008de6b	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
3f7f8dfc-57db-4f4d-a0be-29867d414d30	assessments	9e441b6f-173a-4cc0-89f6-b838f417227d	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
faf8081e-f2dd-47a5-846f-fa7f1eab7e0a	assessments	406ad36b-d422-4c73-8d76-96ca717d3e1b	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
b3e62eeb-e85f-4f07-a101-3a5efbc07db7	assessments	08ed1b93-e715-43b0-b705-3616dd3b5dea	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
3b436c5c-d833-47b0-8b0c-e772e8741602	assessments	9a6ac10a-843f-4653-bbff-4f9f677c429b	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
41756f39-4215-489d-87b0-b14ca2f093a3	assessments	f59b95fe-967b-4a90-9f0b-bf2ad070bbf1	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
94b657ee-d4c7-4cd1-b13b-ae0c38d4eef2	assessments	ad78829b-dcb8-49b9-97f2-d6bfe9d37fd1	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
44c1e5b9-ba56-4faa-beb6-f4488115614f	assessments	8740e36e-8f8a-4450-bc1a-35dee1690c8c	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
bce99aa8-94c1-4162-a867-6d722980fa2c	assessments	6c3c6ed9-1935-4a45-a3ba-6859575c8bbb	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
a3369574-8645-4413-aa10-9404ae6bb7e4	assessments	f742a945-82cc-4957-b876-50242a2e4b4c	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
3333e215-9d79-4f8a-af89-e4983c2326d5	assessments	149370ed-52ae-41b2-be28-3430775fc54a	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
7c9b1a14-7c5e-4706-9b10-91527d85149f	assessments	3ff85810-49d6-4254-85f2-8ada4cee343a	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
91874506-c72c-4e34-bf80-85f66b37d8a8	assessments	90174cba-4435-4ba5-91ee-caee2f7535aa	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
3bde8659-2a63-45e9-b573-67814a7584ea	assessments	4c6942eb-aed2-4987-a99d-53dd8f70c7ce	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
83fda361-72e5-4d9f-9a4b-3eb6d243e1f1	assessments	8b90f281-371d-49f0-9355-dbd5e2e3967f	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
9ecf996e-74d7-419c-961c-33eb367685cf	assessments	ad1e5178-85ff-4327-b407-d7c8380565d2	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
26448d6e-33b3-4bcb-acd6-681fafdc23bd	assessments	57cd13c5-ddb1-4e2c-b30a-a101795db408	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
ed7761a7-5b41-4781-912f-5cc9c9af9c72	assessments	e6b22619-5f54-4591-8239-12eaefcdb6dd	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
6d8b95bf-3ddc-4d67-a894-6bd91d20644f	assessments	3a749e0b-77b1-4fab-89a9-f1417e3856b4	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
6f1621c6-8b63-45cc-b58d-7df2358e89aa	assessments	3a6c37f5-5753-4b15-a242-d6a687b307be	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
3366f660-2b16-4aea-a546-166e1cadf130	assessments	e6a000fc-c376-4318-a562-40490b468451	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
874b0851-a070-4043-8ef0-1e3e15390248	assessments	9c306f51-7f90-41d4-a5d3-01ac6c0f565b	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
d7cd5b3e-8ee5-4ea3-ba47-f95fb517eace	assessments	94ad1746-0f52-4d49-8467-85b7cb186071	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
8159d5df-a1cf-49be-a6de-714327795b1d	assessments	54f3f94e-c5ae-4c70-9a79-7c2b83f1d62c	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
7fdf5ae8-7748-40f8-80ab-6247092882cf	assessments	74e62e20-645e-454f-ac16-2e6b9edeface	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:41:44.20939+00
293bc750-258c-4676-af91-a8bab854e27b	assessments	7699ade6-fbd2-4208-8794-3df58b3201fa	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
41600bd2-04ea-494a-acad-2c5563779abf	assessments	ebec7083-3425-4374-9b8d-c05fa1691274	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
c9853abf-1028-4e35-b8e0-7f59a347075b	assessments	3d8c0c58-b5ca-4418-8c17-eb371a964e14	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
bb353458-3513-4f55-9350-c70983dc9017	assessments	235a88b4-fa3a-4e58-a5b8-983cd893846e	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
53415752-6f6e-4cd7-94ea-5d926100339c	assessments	dc0b1fe2-96fc-40b9-a371-6a71df2aff97	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
63b66d7b-7239-44b1-a88a-8f68112a7562	assessments	b8e255dd-597e-488e-a60d-090ad008de6b	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
c7f79e7c-2cff-4b8e-92ef-7355ab6f9f04	assessments	9e441b6f-173a-4cc0-89f6-b838f417227d	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
8cf60a5d-94af-44a4-ab0d-ee012d95eea2	assessments	406ad36b-d422-4c73-8d76-96ca717d3e1b	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
6ca0456c-134c-4ea3-a453-260c22be54dd	assessments	ad78829b-dcb8-49b9-97f2-d6bfe9d37fd1	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
c5639861-afc8-470b-a7cc-d7aac83958b0	assessments	8740e36e-8f8a-4450-bc1a-35dee1690c8c	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
644444bc-5e77-45b0-b105-f64b535f955c	assessments	6c3c6ed9-1935-4a45-a3ba-6859575c8bbb	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
280587e6-7f15-407c-8189-d178654ee436	assessments	f742a945-82cc-4957-b876-50242a2e4b4c	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
c22ad733-00d1-4e76-83b6-5a161135c7f0	assessments	08ed1b93-e715-43b0-b705-3616dd3b5dea	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
1c433115-2208-4d29-b789-4f3fb8e6e64d	assessments	9a6ac10a-843f-4653-bbff-4f9f677c429b	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
db0c5ee5-08d4-46e8-9936-19011efe7d55	assessments	f59b95fe-967b-4a90-9f0b-bf2ad070bbf1	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
ede5686c-6e34-462d-8660-65eacbfbba9d	assessments	149370ed-52ae-41b2-be28-3430775fc54a	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
344dea44-1f86-474f-a699-8731a9c926f4	assessments	3ff85810-49d6-4254-85f2-8ada4cee343a	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
ba2bc4b3-a703-43d2-aae0-31c88a206197	assessments	90174cba-4435-4ba5-91ee-caee2f7535aa	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
6a10adf8-eff2-422a-814c-b4ae53e98f0f	assessments	4c6942eb-aed2-4987-a99d-53dd8f70c7ce	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
7a295e93-414c-45fb-afdb-7386427ffd14	assessments	8b90f281-371d-49f0-9355-dbd5e2e3967f	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:41:44.579657+00
ba97a325-7a00-456b-9f36-e962cf9079e9	assessments	94ad1746-0f52-4d49-8467-85b7cb186071	UPDATE	order_number	\N	1	raheli@ringan.com	2026-01-13 12:52:52.094239+00
4527dc2c-483c-4b2e-bdf5-d8660bcbd8ef	assessments	08ed1b93-e715-43b0-b705-3616dd3b5dea	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
1b75c96f-a9c9-4724-a078-e2f574930083	assessments	9a6ac10a-843f-4653-bbff-4f9f677c429b	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
bf949a4a-5c36-45e1-9456-98eb0490dce9	assessments	f59b95fe-967b-4a90-9f0b-bf2ad070bbf1	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
5e9dcb15-81cc-4f79-9d91-9754e46403ba	assessments	7699ade6-fbd2-4208-8794-3df58b3201fa	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
d83c887b-76db-4147-9b86-faadd79a5e5b	assessments	ebec7083-3425-4374-9b8d-c05fa1691274	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
92b1e471-7751-4b45-8293-b64e7801457c	assessments	3d8c0c58-b5ca-4418-8c17-eb371a964e14	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
300de046-5775-4a39-9ed4-c607e476289c	assessments	235a88b4-fa3a-4e58-a5b8-983cd893846e	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
c50780d8-d6b6-4575-997a-919b7255bec9	assessments	dc0b1fe2-96fc-40b9-a371-6a71df2aff97	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
4bbca3f1-8bf9-4f09-b0e4-9fc089580b66	assessments	b8e255dd-597e-488e-a60d-090ad008de6b	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
31e87aaf-dc1f-4e28-be4e-98c6242c43b0	assessments	ad78829b-dcb8-49b9-97f2-d6bfe9d37fd1	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
a8128207-4ec4-457b-afa3-daaefaea43f9	assessments	8740e36e-8f8a-4450-bc1a-35dee1690c8c	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
6b3db91a-3ce0-43d3-b3a5-f81e8d3ff00e	assessments	6c3c6ed9-1935-4a45-a3ba-6859575c8bbb	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
d4ccfb1b-91ff-4574-97cf-77071dd6b221	assessments	f742a945-82cc-4957-b876-50242a2e4b4c	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
fd6e1058-0516-40e0-95d8-e2912040684d	assessments	149370ed-52ae-41b2-be28-3430775fc54a	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
69f11ae3-91e6-4153-9508-7c5defa697d6	assessments	3ff85810-49d6-4254-85f2-8ada4cee343a	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
122f1f4b-a277-4a2e-9af8-dee5092a2a4d	assessments	90174cba-4435-4ba5-91ee-caee2f7535aa	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
41ca8211-70e5-409d-80a7-7995c7522856	assessments	4c6942eb-aed2-4987-a99d-53dd8f70c7ce	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
25f7ec76-1744-469a-9e08-6ca93e0ed8ef	assessments	8b90f281-371d-49f0-9355-dbd5e2e3967f	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
a5398bcf-5a53-44b3-8e81-149411e1bee6	assessments	9e441b6f-173a-4cc0-89f6-b838f417227d	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
6e4806ae-4a2b-48d3-a1b2-7fee160cb401	assessments	406ad36b-d422-4c73-8d76-96ca717d3e1b	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-13 12:55:52.212423+00
6b579a5c-a66b-49b7-9a91-f10768384917	assessments	7699ade6-fbd2-4208-8794-3df58b3201fa	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
f3b55f1a-04c5-4a12-ac3c-3f0b20190d12	assessments	7699ade6-fbd2-4208-8794-3df58b3201fa	UPDATE	order_number	\N	1	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
357588e6-b736-49c2-b71f-ad5098d9530d	assessments	ebec7083-3425-4374-9b8d-c05fa1691274	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
4eb0cd71-061e-4258-9a8a-497bfdc6ebca	assessments	ebec7083-3425-4374-9b8d-c05fa1691274	UPDATE	order_number	\N	2	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
01531c70-e84f-4101-a319-1ef3ee23fe63	assessments	3d8c0c58-b5ca-4418-8c17-eb371a964e14	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
515ff190-eb01-4df4-9596-d6a7b54ce91c	assessments	3d8c0c58-b5ca-4418-8c17-eb371a964e14	UPDATE	order_number	\N	3	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
d033827e-52fc-4b86-af50-12902c68d123	assessments	235a88b4-fa3a-4e58-a5b8-983cd893846e	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
e873f2e8-7aa0-4b9f-99fd-bb498f7fe5a8	assessments	235a88b4-fa3a-4e58-a5b8-983cd893846e	UPDATE	order_number	\N	4	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
191b4bba-cb97-464b-b71e-ad2582a796b2	problems	4b5a9715-1c74-4eb3-bd44-794ce40d4b54	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
2ab05518-3786-4ef4-a6ee-796da1909cbf	assessments	dc0b1fe2-96fc-40b9-a371-6a71df2aff97	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
ae708453-c2ba-478f-aef6-420008c19045	assessments	dc0b1fe2-96fc-40b9-a371-6a71df2aff97	UPDATE	order_number	\N	5	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
c963467a-c7bc-44ec-8487-dca025954c65	assessments	b8e255dd-597e-488e-a60d-090ad008de6b	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
69a4fd3e-cdc2-437c-b8c5-42b532907ef1	assessments	b8e255dd-597e-488e-a60d-090ad008de6b	UPDATE	order_number	\N	6	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
f2b8ba6c-cd1b-4fbf-b7be-78800ee28a57	assessments	9e441b6f-173a-4cc0-89f6-b838f417227d	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
a0dbea77-b2e7-454c-8053-13cd55449f3c	assessments	9e441b6f-173a-4cc0-89f6-b838f417227d	UPDATE	order_number	\N	7	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
40bbdb48-4377-4358-ac93-bea47484630f	assessments	406ad36b-d422-4c73-8d76-96ca717d3e1b	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
9cc8ea88-faf7-434f-9e63-90b600b8019f	assessments	406ad36b-d422-4c73-8d76-96ca717d3e1b	UPDATE	order_number	\N	8	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
097d19dd-adf8-4d94-b29e-cd7fc30f329c	assessments	ad78829b-dcb8-49b9-97f2-d6bfe9d37fd1	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
05884d9b-3621-4e8e-b66c-c468db09210c	assessments	ad78829b-dcb8-49b9-97f2-d6bfe9d37fd1	UPDATE	order_number	\N	9	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
d3f3347f-79d5-4c50-a063-40252e23de45	assessments	8740e36e-8f8a-4450-bc1a-35dee1690c8c	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
8b3c3790-c1ce-46ff-9626-61b5824d74e9	assessments	8740e36e-8f8a-4450-bc1a-35dee1690c8c	UPDATE	order_number	\N	10	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
3dd280f0-c985-40ad-b280-f15ffd1ac738	assessments	6c3c6ed9-1935-4a45-a3ba-6859575c8bbb	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
945f879c-deeb-4d61-a98c-6b9e5fd149d7	assessments	6c3c6ed9-1935-4a45-a3ba-6859575c8bbb	UPDATE	order_number	\N	1	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
dcc18ea4-7e5d-4e75-b5c9-57f677f3fe1a	assessments	f742a945-82cc-4957-b876-50242a2e4b4c	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
c7a16556-adba-4930-8713-286d7d3d1643	assessments	f742a945-82cc-4957-b876-50242a2e4b4c	UPDATE	order_number	\N	2	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
821a2519-9857-45f9-aa60-2e98e67d6446	assessments	08ed1b93-e715-43b0-b705-3616dd3b5dea	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
c4a0ba49-e71c-4b82-94a2-3f79afda01a2	assessments	08ed1b93-e715-43b0-b705-3616dd3b5dea	UPDATE	order_number	\N	3	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
84aba91b-6ef9-45f3-8ae1-280cb9562805	assessments	9a6ac10a-843f-4653-bbff-4f9f677c429b	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
30f96673-0cfd-4ee7-aac7-d6c1e947f605	assessments	9a6ac10a-843f-4653-bbff-4f9f677c429b	UPDATE	order_number	\N	4	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
f6010fc3-b0f3-49ad-b8b8-b91b360f3838	assessments	f59b95fe-967b-4a90-9f0b-bf2ad070bbf1	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
2494cfc6-d168-4517-a19d-e0ed91287d8f	assessments	f59b95fe-967b-4a90-9f0b-bf2ad070bbf1	UPDATE	order_number	\N	5	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
6408be42-d837-443f-90a5-c694bb108643	assessments	149370ed-52ae-41b2-be28-3430775fc54a	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
99172d33-3c81-42d2-8f5a-bb0c39f44ab4	assessments	149370ed-52ae-41b2-be28-3430775fc54a	UPDATE	order_number	\N	6	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
980f8796-3ff4-44c8-b1f5-fe611a38f86c	assessments	3ff85810-49d6-4254-85f2-8ada4cee343a	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
c1a48667-6fc2-4d40-b444-efbff01bb86e	assessments	3ff85810-49d6-4254-85f2-8ada4cee343a	UPDATE	order_number	\N	7	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
ae3f706d-67df-4739-9f3e-c1760263d64c	assessments	90174cba-4435-4ba5-91ee-caee2f7535aa	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
235c87ae-90bf-4d88-914c-2363d18e014e	assessments	90174cba-4435-4ba5-91ee-caee2f7535aa	UPDATE	order_number	\N	8	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
59147108-fbf8-49f5-b4c8-4990c265d78f	assessments	4c6942eb-aed2-4987-a99d-53dd8f70c7ce	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
02e7bd37-da7b-4fbb-a0c3-8f66182fe483	assessments	4c6942eb-aed2-4987-a99d-53dd8f70c7ce	UPDATE	order_number	\N	9	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
863d9b98-2081-4dba-809e-21caad5f3b3f	assessments	8b90f281-371d-49f0-9355-dbd5e2e3967f	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
8341b6c5-278b-4584-9fd2-f195e060d5c9	assessments	8b90f281-371d-49f0-9355-dbd5e2e3967f	UPDATE	order_number	\N	10	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
07123e9d-9d4b-4c94-89f6-5a5ca2892efe	assessments	ad1e5178-85ff-4327-b407-d7c8380565d2	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
9bd34c7a-b62d-4f0a-87bb-d55bdab0d342	assessments	ad1e5178-85ff-4327-b407-d7c8380565d2	UPDATE	order_number	\N	1	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
7bb43f75-e5fa-4190-8a33-c57d9efa73b1	assessments	57cd13c5-ddb1-4e2c-b30a-a101795db408	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
9d066816-8404-4119-ad52-cb6c84bfebd4	assessments	57cd13c5-ddb1-4e2c-b30a-a101795db408	UPDATE	order_number	\N	2	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
bf91b1c1-a6bb-45dd-bc55-d09c790ecc2d	assessments	e6b22619-5f54-4591-8239-12eaefcdb6dd	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
6aaa77f1-10db-446f-af3a-ea93483607ac	assessments	e6b22619-5f54-4591-8239-12eaefcdb6dd	UPDATE	order_number	\N	3	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
02884293-a9bc-4f80-bb2c-8ab01a1bd46d	assessments	3a749e0b-77b1-4fab-89a9-f1417e3856b4	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
dca2998c-6de1-422b-82ba-924672be0416	assessments	3a749e0b-77b1-4fab-89a9-f1417e3856b4	UPDATE	order_number	\N	4	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
30403da8-c294-4ba6-8c0f-d68164771c8c	assessments	3a6c37f5-5753-4b15-a242-d6a687b307be	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
b3c9214b-3692-431d-a506-6c50c1cf3081	assessments	3a6c37f5-5753-4b15-a242-d6a687b307be	UPDATE	order_number	\N	5	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
cb41a9b5-226d-4f00-a798-43839bf629da	assessments	e6a000fc-c376-4318-a562-40490b468451	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
e6feb68e-f4fc-426d-b5e5-733b0cfe4441	assessments	e6a000fc-c376-4318-a562-40490b468451	UPDATE	order_number	\N	6	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
6a8bcc7d-af1c-47eb-a696-bf72791496ee	assessments	9c306f51-7f90-41d4-a5d3-01ac6c0f565b	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
d83278bb-c1da-4bc2-a381-ca3783ca632e	assessments	9c306f51-7f90-41d4-a5d3-01ac6c0f565b	UPDATE	order_number	\N	7	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
9585bf97-ba86-4a6e-98e8-0d0c09a3ea70	assessments	94ad1746-0f52-4d49-8467-85b7cb186071	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
40920ce5-9302-4a9c-9a61-0dac78ab464e	assessments	94ad1746-0f52-4d49-8467-85b7cb186071	UPDATE	order_number	1	8	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
d8f28a3a-0e40-4a2c-a19c-2ec11578fb50	assessments	54f3f94e-c5ae-4c70-9a79-7c2b83f1d62c	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
4b20dec2-ce0a-406f-b986-8022782f17b3	assessments	54f3f94e-c5ae-4c70-9a79-7c2b83f1d62c	UPDATE	order_number	\N	9	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
92f852e1-e849-4b11-b725-945460a69184	assessments	74e62e20-645e-454f-ac16-2e6b9edeface	UPDATE	is_active	false	true	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
a414b93c-4c12-4ec6-a757-7f961cfdbedc	assessments	74e62e20-645e-454f-ac16-2e6b9edeface	UPDATE	order_number	\N	10	ayelet@ringan.com	2026-01-13 12:55:52.900368+00
56456abd-c83e-4f08-88fe-4f0c724a6b05	assessments	7699ade6-fbd2-4208-8794-3df58b3201fa	UPDATE	question_id	Q1	Q00000001	\N	2026-01-13 13:04:27.820495+00
d815389e-64a5-4051-9668-fafc55f55de5	assessments	ebec7083-3425-4374-9b8d-c05fa1691274	UPDATE	question_id	Q2	Q00000002	\N	2026-01-13 13:04:27.820495+00
6658c056-5ce6-4094-9e3e-e6fcb805119c	assessments	3d8c0c58-b5ca-4418-8c17-eb371a964e14	UPDATE	question_id	Q3	Q00000003	\N	2026-01-13 13:04:27.820495+00
a897b8b3-a422-439e-b9ff-e87a00f5920d	assessments	235a88b4-fa3a-4e58-a5b8-983cd893846e	UPDATE	question_id	Q4	Q00000004	\N	2026-01-13 13:04:27.820495+00
9b84c4e1-db27-4c2b-bc59-1f84863b1340	assessments	dc0b1fe2-96fc-40b9-a371-6a71df2aff97	UPDATE	question_id	Q5	Q00000005	\N	2026-01-13 13:04:27.820495+00
f19814f7-fe86-401d-bb4d-5f8eb6b1d353	assessments	b8e255dd-597e-488e-a60d-090ad008de6b	UPDATE	question_id	Q6	Q00000006	\N	2026-01-13 13:04:27.820495+00
5fd5c5c2-14bd-4d85-937f-5c9bb8162e91	assessments	08ed1b93-e715-43b0-b705-3616dd3b5dea	UPDATE	question_id	Q13	Q00000013	\N	2026-01-13 13:04:27.820495+00
98557060-1ffe-4dc7-ab78-dcc6a4e64990	assessments	9a6ac10a-843f-4653-bbff-4f9f677c429b	UPDATE	question_id	Q14	Q00000014	\N	2026-01-13 13:04:27.820495+00
be298449-1a04-4081-986c-dc8cf7f498e5	assessments	f59b95fe-967b-4a90-9f0b-bf2ad070bbf1	UPDATE	question_id	Q15	Q00000015	\N	2026-01-13 13:04:27.820495+00
5d97d9b6-7b48-48cd-a6ba-b3a8dcbc93d1	assessments	ad78829b-dcb8-49b9-97f2-d6bfe9d37fd1	UPDATE	question_id	Q9	Q00000009	\N	2026-01-13 13:04:27.820495+00
d5cc6539-79d3-46b1-8788-c522338961e5	assessments	8740e36e-8f8a-4450-bc1a-35dee1690c8c	UPDATE	question_id	Q10	Q00000010	\N	2026-01-13 13:04:27.820495+00
1cca07c9-dacf-4466-a6b8-8991f7239174	assessments	6c3c6ed9-1935-4a45-a3ba-6859575c8bbb	UPDATE	question_id	Q11	Q00000011	\N	2026-01-13 13:04:27.820495+00
26e7120a-aa60-4c0e-bba6-941d3f7323c5	assessments	f742a945-82cc-4957-b876-50242a2e4b4c	UPDATE	question_id	Q12	Q00000012	\N	2026-01-13 13:04:27.820495+00
b37c9f05-690e-4e22-94a3-6e4d344364e7	assessments	149370ed-52ae-41b2-be28-3430775fc54a	UPDATE	question_id	Q16	Q00000016	\N	2026-01-13 13:04:27.820495+00
7992a8c8-b406-41b1-bf8a-7b160bd1a765	assessments	3ff85810-49d6-4254-85f2-8ada4cee343a	UPDATE	question_id	Q17	Q00000017	\N	2026-01-13 13:04:27.820495+00
0a67a922-6fe0-4660-b022-b8f506584307	assessments	90174cba-4435-4ba5-91ee-caee2f7535aa	UPDATE	question_id	Q18	Q00000018	\N	2026-01-13 13:04:27.820495+00
ca9c6a69-333f-44ec-8082-ecab2c33e40d	assessments	4c6942eb-aed2-4987-a99d-53dd8f70c7ce	UPDATE	question_id	Q19	Q00000019	\N	2026-01-13 13:04:27.820495+00
b048bb5d-1cfb-4259-b763-bf3cb413ab32	assessments	8b90f281-371d-49f0-9355-dbd5e2e3967f	UPDATE	question_id	Q20	Q00000020	\N	2026-01-13 13:04:27.820495+00
749d4c0c-44a1-4b81-b4d4-cae58f2fb0fc	assessments	ad1e5178-85ff-4327-b407-d7c8380565d2	UPDATE	question_id	Q21	Q00000021	\N	2026-01-13 13:04:27.820495+00
ca3e296e-efcc-48c5-9b34-ca17aac6c55f	assessments	57cd13c5-ddb1-4e2c-b30a-a101795db408	UPDATE	question_id	Q22	Q00000022	\N	2026-01-13 13:04:27.820495+00
48b811bf-f663-4e5a-af37-2a914ed2cbe9	assessments	e6b22619-5f54-4591-8239-12eaefcdb6dd	UPDATE	question_id	Q23	Q00000023	\N	2026-01-13 13:04:27.820495+00
e064dd1a-55c9-4e1a-8ab2-1e0104a98c08	assessments	3a749e0b-77b1-4fab-89a9-f1417e3856b4	UPDATE	question_id	Q24	Q00000024	\N	2026-01-13 13:04:27.820495+00
0b73b86f-5e95-4a63-9710-8265024901ca	assessments	3a6c37f5-5753-4b15-a242-d6a687b307be	UPDATE	question_id	Q25	Q00000025	\N	2026-01-13 13:04:27.820495+00
1ccea483-cf14-445f-8778-92e336ef73a4	assessments	e6a000fc-c376-4318-a562-40490b468451	UPDATE	question_id	Q26	Q00000026	\N	2026-01-13 13:04:27.820495+00
8ba41529-8531-49d2-9899-6c39fa59779a	assessments	9c306f51-7f90-41d4-a5d3-01ac6c0f565b	UPDATE	question_id	Q27	Q00000027	\N	2026-01-13 13:04:27.820495+00
028fc38d-02af-4d4c-9056-9ccdb25739b6	assessments	94ad1746-0f52-4d49-8467-85b7cb186071	UPDATE	question_id	Q28	Q00000028	\N	2026-01-13 13:04:27.820495+00
302a52e2-85d6-4e55-9176-7b84073e23f9	assessments	9e441b6f-173a-4cc0-89f6-b838f417227d	UPDATE	question_id	Q7	Q00000007	\N	2026-01-13 13:04:27.820495+00
73a58dfe-3b2f-4ec3-9773-7265fd00c0f2	assessments	406ad36b-d422-4c73-8d76-96ca717d3e1b	UPDATE	question_id	Q8	Q00000008	\N	2026-01-13 13:04:27.820495+00
75a18921-7300-4cac-8187-52a3469e1f12	assessments	54f3f94e-c5ae-4c70-9a79-7c2b83f1d62c	UPDATE	question_id	Q29	Q00000029	\N	2026-01-13 13:04:27.820495+00
ddeb4053-c569-41e8-907e-06731678e1ca	assessments	74e62e20-645e-454f-ac16-2e6b9edeface	UPDATE	question_id	Q30	Q00000030	\N	2026-01-13 13:04:27.820495+00
e93e6ea5-6652-421b-9bf3-62fd2cb16934	problem_types	3c6cbe92-4aac-41c5-bd45-7acca83e6af2	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-13 13:20:24.105066+00
034885d3-2281-4674-b96b-257aa31d2863	problem_types	feb75d08-d902-4221-a769-b41942bdfbdb	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-17 14:47:08.904074+00
b96d6fbc-732a-4d1e-a20a-209a2a982e31	problems	6ac93594-ded9-45b5-b15d-d43773122df4	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-17 14:49:40.103115+00
5fbb875b-162e-4bb9-9939-525f80fff2e3	problems	489fe2ea-0ddd-4b29-ba9a-639eb68d5d67	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-17 14:52:42.506244+00
8b26b8fb-4157-4bf2-a9c9-32923446d86b	problems	a130938b-2677-4c27-a427-e20c50f4063e	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-17 14:54:03.461611+00
8e2f7555-9817-4f8a-b5e7-f79a1ed5e946	problems	84fbe172-1ce4-4c79-ba86-7b17313b60ab	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-17 14:55:36.555302+00
22cfc6e3-72c1-44be-9958-43d5240b992a	problems	c6357218-dc59-4a69-8c04-57d8a0f2c9cb	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-17 14:56:30.517851+00
86905fee-a141-42e7-b5ba-402015f2c240	problems	c5d6e991-1239-4462-87d2-de4b52240281	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-17 14:57:31.266062+00
3c812fe4-99da-4095-a309-44b2fd246958	problems	9e7c05dc-32a3-44c8-b0e6-32492b24b39f	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-17 14:58:44.659017+00
f8d2d609-3932-49b1-bcf2-c421454496a5	problems	82023881-048e-49f3-8c52-eb407c6aaeb8	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-17 15:00:27.656697+00
34fd6d4e-8dbe-4c7d-97e1-626f06a26773	problem_types	3176dec0-06f0-423c-9229-3613e1d0a052	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-17 15:04:07.257649+00
39427bdc-a99d-4d1c-9c8f-253d16e62709	problems	8fe4a78e-ac4c-4e2f-9ab2-375c4bd8a85b	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-17 15:07:10.135083+00
dc4fc035-6a5b-465c-8911-77f4a0dba61d	problems	dc596f03-8bb0-448a-a317-30e58268e793	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-17 15:09:01.581963+00
9431a1f1-cf58-468a-a780-f03c1b309f32	problems	cca7c488-ce2b-4518-b929-0cac0180bf7c	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-17 15:10:51.497646+00
9442d639-8e90-412c-ae84-0a84b93dd6c6	problems	fc8f32bc-0bfe-486b-a0bc-9682712e8eaa	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-17 15:12:44.316272+00
dbc58377-fb97-4516-80e6-4de5bfc70b43	problems	ce18d0a7-03d1-4ae1-81f7-abe1779ec745	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-17 15:13:30.805899+00
98707893-f566-4f3d-bbfe-79e09369e5b1	problems	7505bbe6-d71d-4940-9f0a-f4b5f5b769a3	INSERT	\N	\N	\N	ayelet@ringan.com	2026-01-17 15:14:16.143414+00
5f5f987f-bfd5-48c5-b8d4-c0a53a887d6a	problem_types	855df379-7e7f-4030-ad99-10354e775ee8	UPDATE	description	Grief, loss, and bereavement-related issues	Grief, loss, and bereavement-related issuess	ayelet@ringan.com	2026-01-24 06:20:05.824309+00
4d344933-47ef-4647-9c1e-02efbaffa747	problem_types	855df379-7e7f-4030-ad99-10354e775ee8	UPDATE	type_name	Grief and Loss	Grief and Loss test	ayelet@ringan.com	2026-01-24 06:20:17.440934+00
a1770726-e9a1-4d6e-86b3-6ea5b86ec96a	problem_types	855df379-7e7f-4030-ad99-10354e775ee8	UPDATE	type_name	Grief and Loss test	Grief and Loss	ayelet@ringan.com	2026-01-24 06:20:39.570293+00
28ac0d3d-9a73-404d-84cb-76674d2e61c7	problem_types	855df379-7e7f-4030-ad99-10354e775ee8	UPDATE	description	Grief, loss, and bereavement-related issuess	Grief, loss, and bereavement-related issue	ayelet@ringan.com	2026-01-24 06:20:39.570293+00
c72517e9-b645-48fa-ab83-1bc2b5fc6037	problem_types	855df379-7e7f-4030-ad99-10354e775ee8	UPDATE	description	Grief, loss, and bereavement-related issue	Grief, loss, and bereavement-related issues	raheli@ringan.com	2026-01-27 10:04:25.351102+00
a75e4438-b8ad-4589-a4aa-84c21b6c32bb	problem_types	855df379-7e7f-4030-ad99-10354e775ee8	UPDATE	description	Grief, loss, and bereavement-related issues	Grief, loss, and bereavement-related issue	raheli@ringan.com	2026-01-27 10:04:31.530144+00
d0b02940-c630-4f63-bf49-02721535618d	problem_types	855df379-7e7f-4030-ad99-10354e775ee8	UPDATE	description	Grief, loss, and bereavement-related issue	Grief, loss, and bereavement-related issues	raheli@ringan.com	2026-01-27 10:28:47.068175+00
047c9d02-1d64-4ac0-b98e-7b39d9080501	problem_types	ef240793-ccef-4681-8cd3-d9616ba20561	UPDATE	description	Issues related to academic in general	sIssues related to academic in general	raheli@ringan.com	2026-01-27 10:38:10.006181+00
c9c8c175-cb9a-41d0-b376-5daee9ea7bcc	problem_types	ef240793-ccef-4681-8cd3-d9616ba20561	UPDATE	description	sIssues related to academic in general	sIssues related to academic in generals	raheli@ringan.com	2026-01-27 10:38:28.06608+00
ab05dd11-18b8-407a-9af9-2ce2dab91834	problem_types	ef240793-ccef-4681-8cd3-d9616ba20561	UPDATE	description	sIssues related to academic in generals	sIssues related to academic in generalss	raheli@ringan.com	2026-01-27 10:39:58.274118+00
4393dc01-1193-4b3c-affe-d7eeac5f985c	problem_types	ef240793-ccef-4681-8cd3-d9616ba20561	UPDATE	description	sIssues related to academic in generalss	sIssues related to academic in generalsss	raheli@ringan.com	2026-01-27 10:40:16.88011+00
6f78a886-f268-4546-bd19-b1fc10702a96	problem_types	ef240793-ccef-4681-8cd3-d9616ba20561	UPDATE	description	sIssues related to academic in generalsss	sIssues related to academic in generalssss	raheli@ringan.com	2026-01-27 10:45:09.952469+00
4dc0a213-f65b-4d89-9713-cb51e45af408	problem_types	ef240793-ccef-4681-8cd3-d9616ba20561	UPDATE	description	sIssues related to academic in generalssss	sIssues related to academic in generalsssss	raheli@ringan.com	2026-01-27 10:45:15.299182+00
0f1702d6-b61f-4180-892c-f5825d6ea713	problem_types	ef240793-ccef-4681-8cd3-d9616ba20561	UPDATE	description	sIssues related to academic in generalsssss	sIssues related to academic in generalsssssa	raheli@ringan.com	2026-01-27 10:49:27.840046+00
b6a5b280-3542-464f-a6ba-7c5111e1db22	problem_types	ef240793-ccef-4681-8cd3-d9616ba20561	UPDATE	description	sIssues related to academic in generalsssssa	sIssues related to academic in generalsssssas	raheli@ringan.com	2026-01-27 10:49:33.73948+00
eb8674cb-0105-44b5-b5bd-065b9888a842	problem_types	ef240793-ccef-4681-8cd3-d9616ba20561	UPDATE	type_name	Academic Issues	Academic Issues Demo	raheli@ringan.com	2026-01-27 11:03:55.267472+00
737781a7-2212-4c2f-b9bb-e56935d64318	problem_types	855df379-7e7f-4030-ad99-10354e775ee8	UPDATE	description	Grief, loss, and bereavement-related issues	Grief, loss, and bereavement-related issue	ayelet@ringan.com	2026-01-27 11:10:40.355618+00
03125b75-3a41-463b-a782-668fb1d9d62d	problem_types	e43e2ef1-0db2-4a1a-8ea8-56191631d0b1	UPDATE	is_active	true	false	ayelet@ringan.com	2026-01-27 11:10:49.038138+00
cfbd66d7-4cb7-4eec-acd3-a2419f30f8e3	problems	9ff1a7cf-b832-4fca-a220-a51d1c475950	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:00:06.63218+00
87300191-f742-476d-89db-3066e45e564b	problems	f94dc5c9-0ceb-4b3b-8945-c1a7cc523f3b	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:00:27.527349+00
b15c3629-29d4-457f-b47f-1883ac69edfb	problems	834b2d18-1710-472b-a604-3402a4bb8e4c	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:00:36.308436+00
984b25dc-44ee-4b1a-8e26-f1ff71215af5	problems	c4538162-b84d-49bc-bbce-dec728d56500	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:00:36.308436+00
b1c31e85-ad7c-4542-9529-b793c3c81227	problems	aa16f507-5641-4452-9dc3-3eba7f9d5cc0	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:00:36.308436+00
92219ddf-d913-45f1-aeb4-3d2734e42619	problems	2ba99c36-5f2c-4ad9-a90d-01cbf4c76422	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:00:36.308436+00
d7657e30-92e3-43e0-8816-01b95f2fcd16	problems	1c696e32-4024-4d94-836a-825f70be23ff	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:00:36.308436+00
92db746f-f8b1-4a34-8f24-e09bdeb9e353	problems	03d4ee2f-7aed-4e8e-b112-a6f61225f9ba	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:00:36.308436+00
8ad41dc5-bb0a-4cee-9f04-493d70755f15	problems	cbaa020b-f43a-410a-b6bc-3d3b62b33a9b	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:00:36.308436+00
439db005-6d5c-4f4e-b0b2-bc3217b8dc15	problems	eb633030-091e-4ae6-b62f-4f4ca71491dc	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:00:36.308436+00
d0c0d677-df8e-4108-aad6-bcd9a466445c	problems	fa741f9f-4a98-4a48-a547-1fe31133d145	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:00:36.308436+00
af6e40cd-f68d-48f7-9c93-d2f32f094d55	problems	9ff1a7cf-b832-4fca-a220-a51d1c475950	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:00:36.308436+00
752c64bd-d499-4303-8429-f94f53192247	problems	1f0e11bc-30ae-49e7-a876-efb5e05c68af	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:16:51.771895+00
58f6fcf1-3951-4ae3-b414-6ab25b49bd3f	problems	66653a69-32bb-41fb-b962-0df834a1d09b	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:17:02.022802+00
14bbc50e-e5a9-4e3b-8529-090e3bf5e33f	problems	9f50b4b4-f648-4aae-93b0-844345875055	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
73bd50de-9e3e-468a-bb85-8a9da1324216	problems	ef89aeda-c953-4850-a918-378a2aec7cf9	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
6ebada7c-0dfc-4f57-80ab-a9c0461d6b47	problems	6ac93594-ded9-45b5-b15d-d43773122df4	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
bdbdf55c-fc64-4ff6-badb-8d5f178eecc6	problems	a130938b-2677-4c27-a427-e20c50f4063e	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
2c449183-c6ea-406f-b540-eb15c100ae85	problems	c6357218-dc59-4a69-8c04-57d8a0f2c9cb	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
f223e365-c7e2-4623-8cf6-2445b3987604	problems	9e7c05dc-32a3-44c8-b0e6-32492b24b39f	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
d01de979-c194-4ed3-8272-8040dea4b5fe	problems	8fe4a78e-ac4c-4e2f-9ab2-375c4bd8a85b	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
22d8bcbc-f857-4014-9882-3fe8cd865f0c	problems	cca7c488-ce2b-4518-b929-0cac0180bf7c	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
68b3c708-e9b7-4ba2-b55a-1d2207ab7cf1	problems	ce18d0a7-03d1-4ae1-81f7-abe1779ec745	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
c47e9200-9760-4348-8113-9031b26474d2	problems	7505bbe6-d71d-4940-9f0a-f4b5f5b769a3	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
bad5e3f3-8049-4555-a42d-85e4929eadf4	problems	cf5aac3b-1a61-4795-a2ac-3f8d565c902e	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
4e38f1ab-aec5-45cb-886f-545229ecde19	problems	09e8cdf2-e631-4a4a-813e-36101bf1ff1b	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
96292cb9-be97-4a16-aaf0-8694c52c0885	problems	f95c42da-e0fa-4241-97e8-348e135d34ff	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
b7c5541f-7939-41a2-a3c1-2eee8c67678a	problems	065e144e-4ba1-4bdc-987c-5db6e7139e4a	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
e145d174-e5d6-45da-a2cb-0d6e99991eb6	problems	9f234586-b901-4d90-aef4-772d5df6c67c	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
7f3ad495-57b7-4215-baca-7faab3bece93	problems	f32a418c-9f31-4ec0-aa0e-fd638c47ed7f	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
53ff801e-730e-4074-a49d-6f8f33780716	problems	a1c6af17-02a7-4bc0-a549-032b55473be8	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
b07b1ba9-d808-419b-8f0b-df0f52120bf7	problems	0f5734cd-e6c3-4a8f-a33e-6bdea10e633a	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
3a9a65f9-c206-495b-b5a0-ac004d87509d	problems	f4a73a27-7b99-49cd-9b60-09268a1fddaa	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
60a9c904-a6c8-4140-9807-6f140184c493	problems	4724acc9-b697-460d-a305-89f148e94524	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
9731f292-3484-45dc-9c7d-cd69abcf4fe4	problems	3cec4c32-6c4e-4a36-828d-339b5e0caf08	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
bcfdf217-768c-4e2c-b8c1-82443e790c48	problems	997d0657-1688-4e0c-b12c-6b0291973f91	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
4d5a2747-ead3-49ca-8bb0-a5a33cf34ef2	problems	6d7dc217-db15-464f-94a2-2bcfae788f47	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
169ec3af-8ba9-4b36-88cc-3ba5de3b278d	problems	9a2ca856-13c7-441e-8cc3-659f8a184d45	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
45ba32cd-2cf0-40fa-9fcd-f47d337117c4	problems	e1d70aa7-6952-42a3-9404-a1e051fc2fc4	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
29334412-5753-4cbd-8c1f-e24331f280a2	problems	9e5eb702-86e1-4acc-806a-668f8f0ffb07	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
6b17bb8a-ca1a-4340-9b32-2aa38953c6ee	problems	0f3baf2e-e351-4022-9403-8d60abb2b373	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
c2395b0e-383a-4a0d-865d-7b7a8504ec81	problems	d738a820-9be0-45ab-880c-53106b5b906d	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
4a3ef8d8-74db-4414-af51-ea2136bccc27	problems	c7f61f6c-7f11-406a-a91d-25b6c78a72d8	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
24e4ab24-bc18-4476-aa8c-fccce5dbace9	problems	22476d41-5953-4dd2-a8bb-b9ed61042120	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
1723e8df-e6fc-49af-bcb5-bedb84214cb1	problems	ea167b1e-68b0-43ba-bf23-5002b8f8fdd5	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
f72123b5-308b-4d8a-bcdf-c08200ef51eb	problems	489fe2ea-0ddd-4b29-ba9a-639eb68d5d67	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
5b30b769-3c90-44f0-83b7-814a9e58b79d	problems	84fbe172-1ce4-4c79-ba86-7b17313b60ab	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
d756495a-0aa5-44da-8083-c8eca0acc102	problems	c5d6e991-1239-4462-87d2-de4b52240281	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
cff5ddcf-17ee-4130-976c-ce8e9c2b4e5f	problems	82023881-048e-49f3-8c52-eb407c6aaeb8	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
e0f7f2eb-3188-486b-9c5b-41cfb853d40c	problems	dc596f03-8bb0-448a-a317-30e58268e793	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
119bd262-486b-4125-bbd5-37838c0913c3	problems	fc8f32bc-0bfe-486b-a0bc-9682712e8eaa	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
82d908b4-3a93-413d-9106-e3965171749e	problems	1f0e11bc-30ae-49e7-a876-efb5e05c68af	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
49ba13d5-3f7d-4cb5-9f5c-df01f09911ce	problems	66653a69-32bb-41fb-b962-0df834a1d09b	UPDATE	is_active	true	false	raheli@ringan.com	2026-01-27 12:21:28.590199+00
a6795280-b16b-486b-ad8d-b47ca337679c	problems	94d49b73-c2dc-4686-8766-8acc9dcc3228	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:35:04.465283+00
230abc87-dd59-4f6d-8d46-129cfa475435	problems	af0b225b-e15e-480a-96cb-d832688ecdbf	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:35:04.465283+00
815e8bb5-19bd-4eb6-bbf9-ce24b3f058b7	problems	0060aa33-c13d-4266-87e5-00a85b948095	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:35:04.465283+00
eb799e80-3806-4a3f-801f-abc5dc29e6c2	problems	a7988624-072e-4a70-9947-d5a641b8f1a1	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:35:04.465283+00
7cd2441e-7268-440e-a0b0-3725f518789d	problems	2b303109-7a4f-4dec-99eb-c2a95252d01a	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:35:04.465283+00
3f93ad36-21f7-4804-859a-f3c662c62efc	problems	75373faa-81d1-49ef-bf84-97f39bb2b338	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:36:00.736774+00
ed11b42b-fc8b-41c2-85df-1ef7448a7e8f	problems	9ff1a7cf-b832-4fca-a220-a51d1c475950	UPDATE	category	Anxiety	ANX_756	raheli@ringan.com	2026-01-27 12:36:00.736774+00
b9f729f3-e20a-42fd-89b7-f762dcb95012	problems	9ff1a7cf-b832-4fca-a220-a51d1c475950	UPDATE	is_active	false	true	raheli@ringan.com	2026-01-27 12:36:00.736774+00
0e8f4b63-709d-4c06-b5a3-ff4480b0d172	problems	66653a69-32bb-41fb-b962-0df834a1d09b	UPDATE	category	Anxiety	ANX_756	raheli@ringan.com	2026-01-27 12:36:00.736774+00
395d47f2-4477-491c-a9ec-431236ea1857	problems	66653a69-32bb-41fb-b962-0df834a1d09b	UPDATE	is_active	false	true	raheli@ringan.com	2026-01-27 12:36:00.736774+00
f340ca03-889e-4ea4-9992-8903ba60325e	problems	f6bb53f0-f6a1-4ae1-9203-9d4a4199a546	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:37:54.801709+00
c8ccdb51-b20e-465b-9b4c-8fc4f32f33bc	problems	27b76c0f-26e7-415f-8aee-abd6a07681c1	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:37:54.801709+00
a93bf56b-b4e9-4318-8f15-b78e3c0ef030	problems	785f9b1d-897a-4a68-a6ae-df834526a67d	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:37:54.801709+00
f4be6c06-d07d-442c-be2a-8662d9a10eab	problems	6041c0f1-a4d0-4623-b2e6-7903da7ca97f	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:37:54.801709+00
643b225e-a541-4dd1-9bbe-f935af5dc127	problems	b5029a36-2d0c-4482-a9ce-e9d8fbab78b3	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:37:54.801709+00
36c81957-ef00-4532-bd27-d668596f28f3	problems	491c5b77-34f2-4444-b194-0a2890f0c957	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:37:54.801709+00
c6fd7c30-9226-4332-914b-02abf380e34b	problems	d347af4b-c5d3-4aa8-9231-8268ffd2734e	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:39:37.557622+00
9b31bc9b-e53d-46c5-bc5a-4e24edc64649	problems	61cc9df2-8cd1-438b-ac56-1b23dbafda32	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:39:37.557622+00
a3c24bc7-34ec-473f-bab4-73ebcf9ce76e	problems	940d0272-2885-42cd-b85a-5f5ceb9236af	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:39:37.557622+00
86440a57-7dc7-4103-ab98-f2e496e975f9	problems	151b356a-8937-4cd4-bdd5-99aa3fe9587f	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:39:37.557622+00
c14029d9-e2ce-4668-959a-8ca57b921147	problems	d2fd1c33-f893-498c-a501-e17acb12172f	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:39:37.557622+00
86d8c9a3-f0e0-4391-918a-c9b9c84bbe46	problems	7efdf8c3-25ae-4c3c-99c4-cf107cda5780	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:39:37.557622+00
c27d32e4-64fe-450e-9da0-1b8e1b137036	problems	54f6b68b-a08c-4f90-8f85-9a954e1095b1	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:39:37.557622+00
0d9c992f-3742-4d5a-ac6d-d151e790798b	problems	2729ae3d-4cdf-473f-be05-b4b7a7920f78	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:50:31.059195+00
dce08430-1e5c-49a2-afd2-57ff6e3526d1	problems	3ab0ab49-12de-45f6-9e2b-319d8d98fde3	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:50:31.059195+00
3dc94cf1-91a5-4f4a-b525-8f6df676d4e0	problems	f60c310d-ffb0-49e3-8cf0-dda445ce0d49	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:50:31.059195+00
d3a91ada-c596-404b-827a-1630c0927874	problems	03961122-d9e2-4633-940f-b8ffe8b4aefc	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:50:31.059195+00
b8c5dbd3-0a05-4bbb-b27f-ec487dc35710	problems	6988e5b1-1f1b-44a5-b6e5-0595ab3c010b	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:50:31.059195+00
7d438254-0f14-4ead-afa7-9c860f7512b7	problems	f3444744-4532-45e3-a300-491de7a426ae	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:50:31.059195+00
38203eca-2fa8-43a7-9c8d-ef863d85bb3b	problems	3ebc7c76-0607-4158-8a5e-5b9f4b52103d	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:50:31.059195+00
6deeb039-3bc3-483e-8b6a-4849a7294573	problems	ef89aeda-c953-4850-a918-378a2aec7cf9	UPDATE	is_active	false	true	\N	2026-01-27 12:51:53.020913+00
acc11224-5365-4fdb-b2ee-febdd27cbdcc	problems	ea167b1e-68b0-43ba-bf23-5002b8f8fdd5	UPDATE	is_active	false	true	\N	2026-01-27 12:52:27.170052+00
464951e1-2beb-42a5-93f3-7d17f1962281	problems	357a286e-f18d-404b-bc81-5eabcecce439	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:55:55.399339+00
6c5fb6f7-8955-4297-98d4-ec346117462b	problems	8b490642-f6d8-48cc-87ff-06569b793e9f	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:55:55.399339+00
569078f9-6bb9-4cee-b59a-2aefc30a3270	problems	15ffd2e2-59b8-442a-9936-8616e49de25b	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:55:55.399339+00
3dcfdf35-e9a0-4aaf-bf4d-39773c0f8362	problems	9866d976-43aa-46e9-acb2-8d9ba6875699	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:55:55.399339+00
3ca9fa5e-ca77-417f-88f1-061d9a00e646	problems	68e13f9e-4ba1-4790-9627-b4dfa4d247c4	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:55:55.399339+00
916992a7-f1f0-4e8e-bfaa-ae476631c5a1	problems	b2a325c6-4e44-4a03-ba7f-fbbf5270f3c3	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 12:55:55.399339+00
7adde94c-d4ce-4679-946f-4c8392d1a70b	problems	1f0f6518-d5e7-469d-8b42-385e2ad95f28	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
f03b60d3-4849-40c2-beb3-b55454341254	problems	ce18caf4-9457-4769-96fa-70d06ed9ae1e	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
164cd7ad-801f-4418-b91b-58f05dfd5b34	problems	0f0fa469-bdd1-44b4-b64f-537b71afe1ae	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
0df80241-a64c-4bd6-b176-a7263e524cdb	problems	2faa91bc-c80f-46af-b106-7dd7501616d6	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
69da0dab-a0a3-4f08-85bc-444ccec97d4d	problems	9c22d2a7-363e-4d85-a302-c4d3d84c07a5	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
9de4cf5b-f6ea-40b3-8d69-376516a666d9	problems	e2d60fdd-6142-481d-b70c-e822acdc9cd6	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
1f669836-2c65-44bd-a9dd-24b7841920ab	problems	3d95d669-5a6e-4577-a92d-a7a7293d7924	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
9d365aa1-4aa2-4d83-be6b-c042316a80d1	problems	30ad6926-74aa-4180-a3bf-23a0ee053533	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
07bc4b75-4b40-4eda-a0f2-91ad5e18d5e7	problems	07a5e452-0d9f-46ce-a56a-8cf6c747a6a6	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
78161761-924a-43e3-8308-d71f688ead31	problems	f571be53-cba4-40be-847a-64fe1ff88add	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
f43047c2-d688-4093-b3ac-d399cbdf0bad	problems	7c2c74a7-b3ee-477f-86bb-14bcb684149d	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
7458a6de-975e-41b1-939e-bd2d5ed1bfa5	problems	9a0edf48-a955-4741-92a5-f09cb8a2ce34	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
a3f33d93-8864-470b-8a09-541a8f8924d5	problems	9d920675-3a2d-4e0b-963a-fd292f455e82	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
88d15271-10b6-4da6-b459-8dbffedad3ed	problems	030eda31-ca0d-4903-a9ad-24c940d6e039	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
bb7704f1-6d60-4d34-a425-410d4ffa17f4	problems	e4a4414b-e9e4-47ed-b82e-dcc6013fe44b	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
603ea6ab-0fa2-4b46-b095-07e03ae52453	problems	a5f19e6f-cf9c-46c6-bb48-2623360a35bb	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
365d506d-186b-4166-ac70-265b20b40d36	problems	67760b04-b3f7-41a3-bfc8-a93e89bfe55b	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
19fad2c9-6059-437b-948d-6dc685f4739b	problems	d54d88bc-5089-4a32-b164-d0a5402cd25e	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
fead4abd-e475-4b1c-80e1-d4449f403e56	problems	98df570e-b472-4aaa-834d-a195d3df8098	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
808acff5-8918-4e20-b405-9fc1232ef4e2	problems	1c8543e1-024d-4ddf-8a5e-86d187edc90c	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
19b6ac8d-e313-4211-8de6-3ccece8bbf44	problems	8e2e8017-9e4a-4b7e-a12d-6d677965d4f8	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
1e1a2681-6a2c-40ce-bcfb-cda5760e67ac	problems	a6589317-ef76-4f65-896e-a176652fdd76	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
40753d9b-dd0e-447f-b87c-16903eaaa2bf	problems	91dffe8d-8f3f-41b4-94a8-029702abaabf	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
a6ddeb98-917a-4f5f-8b34-7a5f807fed26	problems	a0c27638-32b2-41a0-b252-1f89c52b9da5	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
7acdeed5-4ae0-4598-b799-8a281e014fb2	problems	59a8194f-6c39-46cd-8eb6-37cfd22bc031	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
c1859179-81d6-47a7-aa2d-34bba351cb21	problems	db656475-ffab-428f-8ac8-e9347df746d7	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
b8d74c89-2021-433d-8a52-216c7f69e85e	problems	3ce2a7e3-b183-4bef-bcb2-f1bf250228cf	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
610948ee-e384-4c5b-b458-6ba50546e73d	problems	d696d2ff-9545-436b-8485-82ef86785000	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
8646abf8-21a5-4b73-ac31-6dfe5a631bef	problems	3e8ba53c-a613-4ce9-a098-59f46c8d4513	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
5e3e5997-242f-4a2c-8351-580f1449eeb8	problems	2699073e-f9c7-4db9-ab8e-9ac2014ee009	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
05668f32-9624-4e44-9f80-94fb4577ee5a	problems	b725836d-f3dc-45c1-bd9e-77b2d2ff8975	INSERT	\N	\N	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
6df338ef-d402-476a-b821-d54ea2aaa466	problems	fc8f32bc-0bfe-486b-a0bc-9682712e8eaa	UPDATE	problem_name	Avoidant/Restrictive Food Intake Disorder 	Avoidant/restrictive food intake disorder	raheli@ringan.com	2026-01-27 13:02:54.910968+00
dc10672f-f247-4fe9-9ecb-9cc39b2a6c5d	problems	fc8f32bc-0bfe-486b-a0bc-9682712e8eaa	UPDATE	category	Eating disorder	ED_001	raheli@ringan.com	2026-01-27 13:02:54.910968+00
9fdd7e62-6553-4c3a-b1dd-869c0d9e3e68	problems	fc8f32bc-0bfe-486b-a0bc-9682712e8eaa	UPDATE	description	Eating or feeding disturbance leading to:\nSignificant weight loss or failure to gain\nNutritional deficiency\nDependence on supplements or tube feeding\nInterference with psychosocial functioning\nNo body-image disturbance\nCommon in children/adolescents but also diagnosed in adults\n	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
6bb0e79d-5845-4d50-b892-ffedc922f78a	problems	fc8f32bc-0bfe-486b-a0bc-9682712e8eaa	UPDATE	is_active	false	true	raheli@ringan.com	2026-01-27 13:02:54.910968+00
0d475e56-9727-4b57-a35c-6c634337e680	problems	ce18d0a7-03d1-4ae1-81f7-abe1779ec745	UPDATE	problem_name	Pica	PICA	raheli@ringan.com	2026-01-27 13:02:54.910968+00
97c578b7-20ad-457c-9562-98ebf2b0d380	problems	ce18d0a7-03d1-4ae1-81f7-abe1779ec745	UPDATE	category	Eating disorder	ED_001	raheli@ringan.com	2026-01-27 13:02:54.910968+00
0f5bd6f5-2a06-428a-b1c1-fbb38dd8e3ef	problems	ce18d0a7-03d1-4ae1-81f7-abe1779ec745	UPDATE	description	Pica\nPersistent eating of non-nutritive substances\nDevelopmentally inappropriate and not culturally sanctioned\n	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
131305bb-4cda-480f-8a50-7941e6566533	problems	ce18d0a7-03d1-4ae1-81f7-abe1779ec745	UPDATE	is_active	false	true	raheli@ringan.com	2026-01-27 13:02:54.910968+00
3247cbca-8190-475f-b1b8-e43dacc5fb38	problems	7505bbe6-d71d-4940-9f0a-f4b5f5b769a3	UPDATE	problem_name	Rumination Disorder	Rumination Disorder 	raheli@ringan.com	2026-01-27 13:02:54.910968+00
56de723a-f23f-46f4-9903-5a994ae91766	problems	7505bbe6-d71d-4940-9f0a-f4b5f5b769a3	UPDATE	category	Eating disorder	ED_001	raheli@ringan.com	2026-01-27 13:02:54.910968+00
a271b499-71c8-4e0b-91fe-148ffe3cf82c	problems	7505bbe6-d71d-4940-9f0a-f4b5f5b769a3	UPDATE	description	Rumination Disorder\nRepeated regurgitation of food\nMay be re-chewed, re-swallowed, or spit out\n	\N	raheli@ringan.com	2026-01-27 13:02:54.910968+00
cb81cf9c-de59-4d88-a737-8716f3c3d897	problems	7505bbe6-d71d-4940-9f0a-f4b5f5b769a3	UPDATE	is_active	false	true	raheli@ringan.com	2026-01-27 13:02:54.910968+00
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."projects" ("id", "name", "client", "status", "budget", "hourly_rate", "total_hours", "remaining_budget", "project_value", "created_at", "updated_at", "archived_at") FROM stdin;
27320a14-3e42-49b8-aab2-4cbd446aa4ab	IAMTalent	Pertamina	active	500000000	150000	0	350000000	1000000000	2024-01-15 00:00:00+00	2025-09-14 06:57:41.110401+00	\N
550e8400-e29b-41d4-a716-446655440001	E-Commerce Platform	Tokopedia	active	750000000	175000	0	500000000	1500000000	2024-02-01 00:00:00+00	2025-09-14 06:57:41.110401+00	\N
550e8400-e29b-41d4-a716-446655440002	Mobile Banking App	BCA	on_hold	1000000000	200000	0	800000000	2000000000	2024-01-01 00:00:00+00	2025-09-14 06:57:41.110401+00	\N
550e8400-e29b-41d4-a716-446655440003	Business Intelligence Dashboard	RetailMax Corp	active	80000	75	200	80000	80000	2025-09-14 15:17:02.26644+00	2025-09-14 15:17:02.26644+00	\N
550e8400-e29b-41d4-a716-446655440004	Legacy System Migration	OldTech Solutions	active	300000	85	1000	300000	300000	2025-09-14 15:17:02.403419+00	2025-09-14 15:17:02.403419+00	\N
550e8400-e29b-41d4-a716-446655440005	Website Maintenance	SmallBiz LLC	active	25000	50	100	25000	25000	2025-09-14 15:17:02.466903+00	2025-09-14 15:17:02.466903+00	\N
8ad335cc-b760-47d9-8a8c-310a38add7bd	Test Project for Financial Health	Test Client	active	1000000	0	0	1000000	1000000	2025-09-14 17:12:05.892574+00	2025-09-14 17:12:05.892574+00	\N
16936467-acfd-4464-a3b0-8856e54052ca	test project	Pertamina	active	100000000000	0	0	100000000000	100000000000	2025-09-14 17:44:31.98049+00	2025-09-14 17:44:31.98049+00	\N
\.


--
-- Data for Name: budget_alerts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."budget_alerts" ("id", "project_id", "type", "severity", "message", "created_at") FROM stdin;
\.


--
-- Data for Name: calendar_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."calendar_events" ("id", "user_id", "date", "type", "title", "description", "hours", "cost", "status", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: project_releases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."project_releases" ("id", "project_id", "name", "value", "due_date", "status", "created_at", "updated_at") FROM stdin;
550e8400-e29b-41d4-a716-446655440010	27320a14-3e42-49b8-aab2-4cbd446aa4ab	Release 1.0 - Core Platform	300000000	2024-03-15	completed	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00
550e8400-e29b-41d4-a716-446655440011	27320a14-3e42-49b8-aab2-4cbd446aa4ab	Release 2.0 - Mobile App	400000000	2024-06-30	in_progress	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00
550e8400-e29b-41d4-a716-446655440012	550e8400-e29b-41d4-a716-446655440001	E-Commerce MVP	500000000	2024-04-30	in_progress	2024-02-01 00:00:00+00	2024-02-01 00:00:00+00
\.


--
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."invoices" ("id", "project_id", "release_id", "invoice_number", "amount", "currency", "issue_date", "due_date", "status", "payment_date", "payment_method", "notes", "client", "created_at", "updated_at") FROM stdin;
550e8400-e29b-41d4-a716-446655440080	27320a14-3e42-49b8-aab2-4cbd446aa4ab	550e8400-e29b-41d4-a716-446655440010	INV-2024-001	300000000	IDR	2024-03-15	2024-04-15	paid	2024-04-10	bank_transfer	Payment for Release 1.0	Pertamina	2024-03-15 00:00:00+00	2024-04-10 00:00:00+00
550e8400-e29b-41d4-a716-446655440081	27320a14-3e42-49b8-aab2-4cbd446aa4ab	550e8400-e29b-41d4-a716-446655440011	INV-2024-002	200000000	IDR	2024-06-01	2024-07-01	sent	\N	\N	\N	Pertamina	2024-06-01 00:00:00+00	2024-06-01 00:00:00+00
\.


--
-- Data for Name: cashflow_entries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."cashflow_entries" ("id", "project_id", "invoice_id", "type", "amount", "currency", "date", "description", "status", "created_at", "updated_at") FROM stdin;
550e8400-e29b-41d4-a716-446655440090	27320a14-3e42-49b8-aab2-4cbd446aa4ab	550e8400-e29b-41d4-a716-446655440080	payment_received	300000000	IDR	2024-04-10	Payment received for Release 1.0	completed	2024-04-10 00:00:00+00	2024-04-10 00:00:00+00
550e8400-e29b-41d4-a716-446655440091	27320a14-3e42-49b8-aab2-4cbd446aa4ab	550e8400-e29b-41d4-a716-446655440081	invoice_issued	200000000	IDR	2024-06-01	Invoice issued for Release 2.0	completed	2024-06-01 00:00:00+00	2024-06-01 00:00:00+00
\.


--
-- Data for Name: client_satisfaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."client_satisfaction" ("id", "project_id", "rating", "feedback", "survey_date", "created_at") FROM stdin;
\.


--
-- Data for Name: cost_efficiency_tracking; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."cost_efficiency_tracking" ("id", "category", "amount", "percentage", "trend", "efficiency", "period_start", "period_end", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."feedback" ("id", "feedback_type", "message", "page_route", "browser_info", "created_at") FROM stdin;
ba0c270d-3729-4aa3-8886-bb13313baacf	issue	hello	/assessments	{"language": "en-US", "viewport": "1440x906", "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0"}	2026-01-04 10:26:57.282+00
20eea463-8dc3-43d9-9505-64b1744ffb30	idea	asdfasdf	/problems	{"language": "en-US", "viewport": "1671x525", "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36 Edg/143.0.0.0"}	2026-01-04 11:29:08.77+00
\.


--
-- Data for Name: feedback_prompts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."feedback_prompts" ("id", "prompt_id", "prompt_text", "is_active", "created_at", "updated_at") FROM stdin;
a3d16b4a-92ac-4493-84d2-d4b1db24a5cd	F002	Are you still experiencing stress regularly?	\N	\N	\N
28a9f7b8-b132-44d8-b504-cbff0694920a	F001	Did your stress level drop after you tried this technique?	\N	\N	\N
ddd25b30-b791-43ad-adf8-82444a16b7d6	\N	Were you able to apply any technique from the app in real-life scenarios? Yes, No	\N	\N	\N
77abbc7d-a63a-4a46-baa9-ee603fc12b18	P_STR_001	Did the tip help reduce your anxiety?	t	2025-09-04 12:31:58.974+00	2025-09-04 12:31:58.974+00
6ffaf8fb-7747-4507-9f19-5a2296bc19fe	P_STR_002	Are you still experiencing stress regularly?	t	2025-09-04 12:31:58.974+00	2025-09-04 12:31:58.974+00
64c8e222-c2b0-42e5-98d1-8bb5f606fba2	P_GEN_001	Did the tip help reduce your anxiety?	t	2025-09-04 12:31:58.975+00	2025-09-04 12:31:58.975+00
aa949632-b33b-45d6-ab2f-c8770513152f	P_GEN_002	Are you still experiencing stress regularly?	t	2025-09-04 12:31:58.976+00	2025-09-04 12:31:58.976+00
\.


--
-- Data for Name: financial_summaries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."financial_summaries" ("id", "period_start", "period_end", "total_project_value", "total_project_cost", "total_margin", "margin_percentage", "total_talent_cost", "total_operational_cost", "cash_flow_incoming", "cash_flow_outgoing", "cash_flow_net", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: forecasting_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."forecasting_data" ("id", "forecast_type", "current_month", "next_month", "month_after_next", "growth_rate", "risk_level", "confidence_score", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: next_actions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."next_actions" ("id", "action_id", "action_text", "is_active", "created_at", "updated_at") FROM stdin;
4f29adca-c965-4ae0-aecf-dd00e074f6d4	A01	\N	\N	\N	\N
37f5612c-8dbf-41ae-8c2a-51df809cfda8	A02	\N	\N	\N	\N
95ef79f3-4bf6-4299-b445-348e94de2294	A03	\N	\N	\N	\N
21563e11-7e90-4acc-8a7a-cd10bd4cb90e	A04	\N	\N	\N	\N
147c15be-7d91-460f-852e-15750a8f8d32	A05	\N	\N	\N	\N
bb11db6c-ebc6-482b-8ee4-8db2e0e6f180	A06	\N	\N	\N	\N
cb6a1ee1-ec92-4a06-8c80-52c663ad4e87	A07	\N	\N	\N	\N
4c257e04-ce27-4931-b14c-f673408773e6	A08	\N	\N	\N	\N
3e8a28a3-a1d4-4551-abe0-8c04c2ad18d9	A_001	\N	t	2025-09-04 12:31:58.977+00	2025-09-04 12:31:58.977+00
60d519cc-ff9d-476e-a537-81b07cc24e4e	A_002	\N	t	2025-09-04 12:31:58.977+00	2025-09-04 12:31:58.977+00
91f3cb58-b95b-4b5a-8910-b14a1b86883b	A_003	\N	t	2025-09-04 12:31:58.979+00	2025-09-04 12:31:58.979+00
bfa0a852-2663-40ca-9400-72750eedc43d	A_004	\N	t	2025-09-04 12:31:58.979+00	2025-09-04 12:31:58.979+00
93c841ea-8552-4eba-ad1b-4e68a23c29e6	A_005	\N	t	2025-09-04 12:31:58.979+00	2025-09-04 12:31:58.979+00
95e8dbb4-2ea2-45d8-b0b7-eeb3db856080	A_006	\N	t	2025-09-04 12:31:58.98+00	2025-09-04 12:31:58.98+00
ad79c256-d4f5-4435-8677-d6348ec75131	A_007	\N	t	2025-09-04 12:31:58.981+00	2025-09-04 12:31:58.981+00
704ce5a4-eb2d-468d-b015-a7594cf74f2e	A_008	\N	t	2025-09-04 12:31:58.981+00	2025-09-04 12:31:58.981+00
59a707f7-6678-4beb-a50e-43855c67d6e5	A_101	\N	t	2025-09-04 12:31:58.981+00	2025-09-04 12:31:58.981+00
b38c7903-385b-43e8-82dc-e03cae26551a	A_102	\N	t	2025-09-04 12:31:58.981+00	2025-09-04 12:31:58.981+00
e3fbe8c7-edab-4ed3-84bd-74064c7aa150	A_103	\N	t	2025-09-04 12:31:58.983+00	2025-09-04 12:31:58.983+00
87333e1b-5cbb-4157-a6d5-57a94d4bdc75	A_104	\N	t	2025-09-04 12:31:58.983+00	2025-09-04 12:31:58.983+00
901d5252-73bb-4f79-8353-657422e4bcb8	A_105	\N	t	2025-09-04 12:31:58.983+00	2025-09-04 12:31:58.983+00
a87180e3-ee8a-4f0f-8d96-d12b2cd1af41	A_106	\N	t	2025-09-04 12:31:58.984+00	2025-09-04 12:31:58.984+00
52a186d1-d667-4ce9-a777-52e77245a99d	A_107	\N	t	2025-09-04 12:31:58.985+00	2025-09-04 12:31:58.985+00
3fea5329-4f6c-4817-8164-4d24d7661ce1	A_108	\N	t	2025-09-04 12:31:58.985+00	2025-09-04 12:31:58.985+00
4f4645e8-e6cc-4ae4-9bc6-7b8f4a18c4d4	A_201	\N	t	2025-09-04 12:31:58.986+00	2025-09-04 12:31:58.986+00
933de807-ec0e-40c8-9d5e-79a8b6315787	A_202	\N	t	2025-09-04 12:31:58.986+00	2025-09-04 12:31:58.986+00
b0d7f858-6717-4cb6-a167-c6caef1a3ce9	A_203	\N	t	2025-09-04 12:31:58.987+00	2025-09-04 12:31:58.987+00
0d006f20-134b-4e69-8e1d-7ec904ea6d89	A_204	\N	t	2025-09-04 12:31:58.987+00	2025-09-04 12:31:58.987+00
26e87ac4-833b-436c-994e-e6483a9cf373	A_205	\N	t	2025-09-04 12:31:58.987+00	2025-09-04 12:31:58.987+00
2bed5c96-bb19-48cd-82c5-89607eebfa4a	A_206	\N	t	2025-09-04 12:31:58.987+00	2025-09-04 12:31:58.987+00
83510c66-83bd-4673-947d-ad4fdf33926a	A_207	\N	t	2025-09-04 12:31:58.989+00	2025-09-04 12:31:58.989+00
bc4232c2-ebf7-49ba-8f81-b36c873db399	A_208	\N	t	2025-09-04 12:31:58.989+00	2025-09-04 12:31:58.989+00
fabc03b7-db1e-43b6-9ed1-61375478e531	A_301	\N	t	2025-09-04 12:31:58.989+00	2025-09-04 12:31:58.989+00
1a2bf00a-bbcc-4cb0-a8e9-cb837553f2e0	A_302	\N	t	2025-09-04 12:31:58.99+00	2025-09-04 12:31:58.99+00
7372c27c-fae5-4f28-8049-d54d28054c09	A_303	\N	t	2025-09-04 12:31:58.99+00	2025-09-04 12:31:58.99+00
aea6aed4-d5ff-4d05-9dec-d989e435f673	A_304	\N	t	2025-09-04 12:31:58.99+00	2025-09-04 12:31:58.99+00
e910ec39-60e9-447f-98e6-ba106d65e27a	A_305	\N	t	2025-09-04 12:31:58.992+00	2025-09-04 12:31:58.992+00
4b77c395-d08c-4fbf-89ea-726c299bdab5	A_306	\N	t	2025-09-04 12:31:58.992+00	2025-09-04 12:31:58.992+00
78bcfee0-829d-414f-86b7-ef25a5301e07	A_307	\N	t	2025-09-04 12:31:58.992+00	2025-09-04 12:31:58.992+00
82453a8b-27dc-4d33-8d92-348c69e597e8	A_308	\N	t	2025-09-04 12:31:58.994+00	2025-09-04 12:31:58.994+00
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."payments" ("id", "talent_id", "project_id", "amount", "hours", "hourly_rate", "pay_period_start", "pay_period_end", "status", "payment_method", "processed_date", "due_date", "invoice_number", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: problem_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."problem_types" ("id", "type_name", "category_id", "description", "is_active", "created_at", "updated_at") FROM stdin;
273adb8e-24a8-4327-aab4-07e3215e5479	Stress	STR_782	Stress-related conditions and work-life balance issues	t	2025-10-17 07:15:02.287+00	2025-10-17 07:15:02.287+00
35bb4693-1f0b-4b9e-ae98-1832447b1f36	Trauma	TRA_961	Trauma and PTSD-related conditions	t	2025-10-17 07:15:02.287+00	2025-10-17 07:15:02.287+00
64df5ded-f4ef-4257-a06c-8392902a3fd9	Relationship Issues	REL_151	Relationship and interpersonal problems	t	2025-10-17 07:15:02.287+00	2025-10-17 07:15:02.287+00
edfafebb-32fe-4563-a97d-4738a2fc3d55	Sleep Problems	SLE_894	Sleep disorders and insomnia-related issues	t	2025-10-17 07:15:02.287+00	2025-10-17 07:15:02.287+00
d4156ab7-5cbf-42d8-9578-3d1705676613	Self-Esteem	SEL_730	Self-esteem and confidence-related issues	t	2025-10-17 07:15:02.287+00	2025-10-17 07:15:02.287+00
ef240793-ccef-4681-8cd3-d9616ba20561	Academic Issues Demo	AI_001	sIssues related to academic in generalsssssas	t	2026-01-06 12:19:34.866+00	2026-01-27 11:03:55.138+00
855df379-7e7f-4030-ad99-10354e775ee8	Grief and Loss	GRI_239	Grief, loss, and bereavement-related issue	t	2025-10-17 07:15:02.287+00	2026-01-27 11:10:40.69+00
e43e2ef1-0db2-4a1a-8ea8-56191631d0b1	Test Problem	TP_001	testing the problems	f	2025-12-28 09:16:59.647+00	2026-01-27 11:10:49.434+00
c79addc1-47fd-4029-85a2-5465ec739a67	Depression	DEP_754	Depressive disorders and mood-related conditionssss	t	2025-10-17 07:15:02.287+00	2026-01-04 10:39:08.956+00
5741d506-af09-4790-91b3-7949655a4efe	Anxiety	ANX_756	General anxiety disorders and anxiety-related conditionss	t	2025-10-17 07:15:02.287+00	2026-01-04 10:44:24.323+00
ff583ec7-5dd8-4a4b-b347-629a29edf8d0	Motivation	MOT_001	change this later	t	2026-01-06 12:42:02.266+00	2026-01-06 12:42:02.266+00
3c6cbe92-4aac-41c5-bd45-7acca83e6af2	Test Anxiety	TES_774	Test anxiety disorder for testing	f	2025-10-17 07:30:59.732747+00	2026-01-13 13:20:23.82+00
feb75d08-d902-4221-a769-b41942bdfbdb	Addictions	ADD_001	Addiction is when something that once helped, soothed, or excited a person starts to take control over them.\nInstead of being a choice, it becomes a strong urge or habit that’s hard to stop, even when the person knows it’s causing harm.\n\nAddiction is not about weakness or lack of willpower. It’s about how the brain learns, adapts, and sometimes gets stuck in a pattern.	t	2026-01-17 14:47:08.66+00	2026-01-17 14:47:08.66+00
3176dec0-06f0-423c-9229-3613e1d0a052	Eating disorder	ED_001	Eating disorders are mental health conditions marked by ongoing problems with eating behaviors, thoughts, and emotions that seriously affect physical health, emotional wellbeing, and daily functioning.	t	2026-01-17 15:04:07.094+00	2026-01-17 15:04:07.094+00
\.


--
-- Data for Name: problems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."problems" ("id", "problem_name", "category", "category_id", "sub_category_id", "description", "severity_level", "is_active", "created_at", "updated_at") FROM stdin;
9f50b4b4-f648-4aae-93b0-844345875055	work stress	Depression	DEP_754	WS_001	zxvc	1	f	2025-12-29 11:18:01.935+00	2026-01-27 12:32:09.948+00
6ac93594-ded9-45b5-b15d-d43773122df4	Cigarettes	Addictions	ADD_001	CIG_001	Nicotine dependence with tolerance, withdrawal, and compulsive daily smoking	\N	f	2026-01-17 14:49:39.994+00	2026-01-27 12:32:09.948+00
a130938b-2677-4c27-a427-e20c50f4063e	Gaming	Addictions	ADD_001	GAM_001	Excessive play, loss of control, neglect of daily functioning	\N	f	2026-01-17 14:54:03.369+00	2026-01-27 12:32:09.948+00
c6357218-dc59-4a69-8c04-57d8a0f2c9cb	Alcohol	Addictions	ADD_001	ALC_001	Problematic drinking with impaired control, risky use, and dependence	\N	f	2026-01-17 14:56:30.416+00	2026-01-27 12:32:09.948+00
9e7c05dc-32a3-44c8-b0e6-32492b24b39f	Gambling / Online Gambling	Addictions	ADD_001	GOG_001	Persistent, uncontrolled betting despite losses and life consequences	\N	f	2026-01-17 14:58:44.531+00	2026-01-27 12:32:09.948+00
8fe4a78e-ac4c-4e2f-9ab2-375c4bd8a85b	Anorexia Nervosa 	Eating disorder	ED_001	AN_001	Anorexia Nervosa – severe restriction of food intake with intense fear of weight gain. \nRestriction of energy intake leading to significantly low body weight\nIntense fear of gaining weight or persistent behavior interfering with weight gain\nDisturbance in body image or lack of recognition of seriousness\nSubtypes:\nRestricting type\nBinge-eating/purging type\n	\N	f	2026-01-17 15:07:09.982+00	2026-01-27 12:32:09.948+00
cca7c488-ce2b-4518-b929-0cac0180bf7c	Binge-Eating Disorder 	Eating disorder	ED_001	BD_001	Binge-Eating Disorder (BED)\nRecurrent binge-eating episodes without compensatory behaviors\nAssociated with ≥3 of the following:\nEating rapidly\nEating until uncomfortably full\nEating large amounts when not hungry\nEating alone due to embarrassment\nFeeling disgusted, depressed, or guilty afterward\nOccurs at least once a week for 3 months\nMarked distress regarding binge eating\n	\N	f	2026-01-17 15:10:51.182+00	2026-01-27 12:32:09.948+00
834b2d18-1710-472b-a604-3402a4bb8e4c	P001-1 Social Anxiety	Anxiety	ANX_01	ANX_01_01	Marked fear or anxiety about social situations where the individual might be scrutinized	3	f	2025-09-04 11:49:52.749992+00	2026-01-27 12:32:09.948+00
cf5aac3b-1a61-4795-a2ac-3f8d565c902e	Workplace Stress	Stress	\N	SUB_11	Stress experienced in professional settings.	3	f	\N	2026-01-27 12:32:09.948+00
09e8cdf2-e631-4a4a-813e-36101bf1ff1b	Stress	Stress	\N	SUB_13	Stress can be defined as a state of worry or mental tension caused by a difficult situation.	3	f	\N	2026-01-27 12:32:09.948+00
f95c42da-e0fa-4241-97e8-348e135d34ff	Stress - Panic Attack	Stress	\N	SUB_14	Stress-related condition: Stress - Panic Attack	3	f	\N	2026-01-27 12:32:09.948+00
065e144e-4ba1-4bdc-987c-5db6e7139e4a	Depression	Depression	\N	SUB_16	Depression-related condition: Depression	3	f	\N	2026-01-27 12:32:09.948+00
9f234586-b901-4d90-aef4-772d5df6c67c	Trauma	Trauma	\N	SUB_17	Trauma-related condition: Trauma	3	f	\N	2026-01-27 12:32:09.948+00
f32a418c-9f31-4ec0-aa0e-fd638c47ed7f	P004-1 Stress from Relationships	Stress	STR_04	STR_04_01	Emotional or psychological stress related to romantic, social, or interpersonal relationships.	3	f	2025-09-04 11:49:46.892092+00	2026-01-27 12:32:09.948+00
ef89aeda-c953-4850-a918-378a2aec7cf9	Academic Motivation and Task Engagement	Motivation	MOT_001	AMAT_001	change this later	1	t	2026-01-06 12:43:14.343+00	2026-01-27 12:32:09.948+00
2729ae3d-4cdf-473f-be05-b4b7a7920f78	Global self worth	SEL_730	SEL_730	GSW_001	\N	\N	t	2026-01-27 12:50:31.059195+00	2026-01-27 13:02:50.407+00
3ab0ab49-12de-45f6-9e2b-319d8d98fde3	Social/Peer self esteem	SEL_730	SEL_730	SSE_001	\N	\N	t	2026-01-27 12:50:31.059195+00	2026-01-27 13:02:50.407+00
f60c310d-ffb0-49e3-8cf0-dda445ce0d49	Academic/performance self confidence	SEL_730	SEL_730	ASC_001	\N	\N	t	2026-01-27 12:50:31.059195+00	2026-01-27 13:02:50.407+00
03961122-d9e2-4633-940f-b8ffe8b4aefc	Body image/physical self esteem	SEL_730	SEL_730	BISE_001	\N	\N	t	2026-01-27 12:50:31.059195+00	2026-01-27 13:02:50.407+00
6988e5b1-1f1b-44a5-b6e5-0595ab3c010b	Self compassion/inner critic	SEL_730	SEL_730	SCC_001	\N	\N	t	2026-01-27 12:50:31.059195+00	2026-01-27 13:02:50.407+00
f3444744-4532-45e3-a300-491de7a426ae	Perfectionism/fear of failure	SEL_730	SEL_730	POF_001	\N	\N	t	2026-01-27 12:50:31.059195+00	2026-01-27 13:02:50.407+00
3ebc7c76-0607-4158-8a5e-5b9f4b52103d	Resilience/self accepatnce 	SEL_730	SEL_730	RA_001	\N	\N	t	2026-01-27 12:50:31.059195+00	2026-01-27 13:02:50.407+00
ce18d0a7-03d1-4ae1-81f7-abe1779ec745	PICA	ED_001	ED_001	PIC_001	\N	\N	t	2026-01-17 15:13:30.669+00	2026-01-27 13:02:50.407+00
7505bbe6-d71d-4940-9f0a-f4b5f5b769a3	Rumination Disorder 	ED_001	ED_001	RD_001	\N	\N	t	2026-01-17 15:14:16.004+00	2026-01-27 13:02:50.407+00
75373faa-81d1-49ef-bf84-97f39bb2b338	P001-5 Generalized anxiety - Mild	ANX_756	ANX_756	PGAM_002	Excessive anxiety and worry about a number of events or activities, occurring more days than not for at least six months	\N	t	2026-01-27 12:36:00.736774+00	2026-01-27 12:36:00.422+00
66653a69-32bb-41fb-b962-0df834a1d09b	P001-2 Exan/ test anxiety	ANX_756	ANX_756	PETA_001	Marked as fear or having anxiety symptoms before tests and exams	\N	t	2026-01-27 12:17:01.915+00	2026-01-27 12:36:00.422+00
f6bb53f0-f6a1-4ae1-9203-9d4a4199a546	P005-1 – Adjustment Disorder	TRA_961	TRA_961	PAD_001	Emotional and physical distress triggered by life changes or transitions.	\N	t	2026-01-27 12:37:54.801709+00	2026-01-27 12:37:53.759+00
27b76c0f-26e7-415f-8aee-abd6a07681c1	P005-2 – Acute Trauma	TRA_961	TRA_961	PAT_001	Response to a single shocking or distressing event such as an accident or assault.	\N	t	2026-01-27 12:37:54.801709+00	2026-01-27 12:37:53.759+00
785f9b1d-897a-4a68-a6ae-df834526a67d	P005-3 – PTSD (Post-Traumatic Stress Disorder)	TRA_961	TRA_961	PPPS_001	Ongoing symptoms after experiencing or witnessing a life-threatening event.	\N	t	2026-01-27 12:37:54.801709+00	2026-01-27 12:37:53.759+00
6041c0f1-a4d0-4623-b2e6-7903da7ca97f	P005-5 – Childhood Trauma	TRA_961	TRA_961	PCT_001	Trauma rooted in early life adversity such as abuse, neglect, or household dysfunction.	\N	t	2026-01-27 12:37:54.801709+00	2026-01-27 12:37:53.759+00
b5029a36-2d0c-4482-a9ce-e9d8fbab78b3	P005-6 – Medical Trauma	TRA_961	TRA_961	PMT_001	Psychological impact of serious illness, injury, or invasive medical treatment.	\N	t	2026-01-27 12:37:54.801709+00	2026-01-27 12:37:53.759+00
491c5b77-34f2-4444-b194-0a2890f0c957	P005-7 – Traumatic Grief / Loss	TRA_961	TRA_961	PTGL_001	Grief complicated by sudden, violent, or unresolved loss of a loved one.	\N	t	2026-01-27 12:37:54.801709+00	2026-01-27 12:37:53.759+00
a1c6af17-02a7-4bc0-a549-032b55473be8	P004-2 Stress from Family Relations	Stress	P004	P004-2	Stress caused by conflicts, expectations, or emotional strain within family systems.	3	f	\N	2026-01-27 12:32:09.948+00
f94dc5c9-0ceb-4b3b-8945-c1a7cc523f3b	Exam/Test Anxiety	Anxiety	P001	P001-2	Marked as fear or having anxiety symptoms before tests and exams	3	f	\N	2026-01-27 12:32:09.948+00
c4538162-b84d-49bc-bbce-dec728d56500	P001-3 Transition/Adjustment Anxiety	Anxiety	P001	P001-3	Marked as anxious symptoms before or during major transitions like a new home, new school, divorce, etc.	3	f	\N	2026-01-27 12:32:09.948+00
aa16f507-5641-4452-9dc3-3eba7f9d5cc0	P001-4 Panic Disorder	Anxiety	P001	P001-4	Recurrent unexpected panic attacks, followed by persistent concern about having more attacks or significant behavioral changes related to the attacks.	3	f	\N	2026-01-27 12:32:09.948+00
357a286e-f18d-404b-bc81-5eabcecce439	Future goals, purpose and direction	MOT_001	MOT_001	FGPA_001	\N	\N	t	2026-01-27 12:55:55.399339+00	2026-01-27 13:02:50.407+00
8b490642-f6d8-48cc-87ff-06569b793e9f	Meaning, Hope and Belief-system motivation	MOT_001	MOT_001	MHAB_001	\N	\N	t	2026-01-27 12:55:55.399339+00	2026-01-27 13:02:50.407+00
15ffd2e2-59b8-442a-9936-8616e49de25b	Trauma Related avoidacne and emotional overwhelm	MOT_001	MOT_001	TRAA_001	\N	\N	t	2026-01-27 12:55:55.399339+00	2026-01-27 13:02:50.407+00
9866d976-43aa-46e9-acb2-8d9ba6875699	Low energy, apathy and dpression related motivation loss	MOT_001	MOT_001	LEAA_001	\N	\N	t	2026-01-27 12:55:55.399339+00	2026-01-27 13:02:50.407+00
68e13f9e-4ba1-4790-9627-b4dfa4d247c4	external pressure, cultural expectiations and controlled motivation	MOT_001	MOT_001	EPCE_001	\N	\N	t	2026-01-27 12:55:55.399339+00	2026-01-27 13:02:50.407+00
b2a325c6-4e44-4a03-ba7f-fbbf5270f3c3	executive function, task initiation and consistency 	MOT_001	MOT_001	EFTI_001	\N	\N	t	2026-01-27 12:55:55.399339+00	2026-01-27 13:02:50.407+00
0f5734cd-e6c3-4a8f-a33e-6bdea10e633a	P004-3 Stress from Bullying	Stress	P004	P004-3	Stress reactions stemming from verbal, emotional, or physical bullying at school or in social settings.	3	f	\N	2026-01-27 12:32:09.948+00
f4a73a27-7b99-49cd-9b60-09268a1fddaa	P004-4 Stress from the Workplace	Stress	P004	P004-4	Workplace-related stress due to pressure, workload, conflict, or role strain.	3	f	\N	2026-01-27 12:32:09.948+00
4724acc9-b697-460d-a305-89f148e94524	P004-5 Emotional Dysregulation	Stress	P004	P004-5	Inability to manage emotional responses effectively, leading to intense and rapidly shifting emotions.	3	f	\N	2026-01-27 12:32:09.948+00
3cec4c32-6c4e-4a36-828d-339b5e0caf08	P004-6 Acute Stress Reaction	Stress	P004	P004-6	Acute physiological and emotional responses to a traumatic or overwhelming event.	4	f	\N	2026-01-27 12:32:09.948+00
fa741f9f-4a98-4a48-a547-1fe31133d145	Anxiety	Anxiety	\N	SUB_19	Anxiety-related condition: Anxiety	3	f	\N	2026-01-27 12:32:09.948+00
82023881-048e-49f3-8c52-eb407c6aaeb8	Compulsive shopping/Online shopping	Addictions	ADD_001	CSS_001	Repetitive, impulsive buying causing financial, social, or emotional distress	\N	f	2026-01-17 15:00:27.543+00	2026-01-27 12:32:09.948+00
997d0657-1688-4e0c-b12c-6b0291973f91	P004-7 Stress from Low Self Esteem	Stress	P004	P004-7	Chronic stress emerging from negative self-image, low confidence, or perceived lack of self-worth.	3	f	\N	2026-01-27 12:32:09.948+00
6d7dc217-db15-464f-94a2-2bcfae788f47	P005-1 - Adjustment Disorder	Trauma	TRA_05	TRA_05_01	Emotional and physical distress triggered by life changes or transitions.	3	f	2025-09-04 11:49:57.755551+00	2026-01-27 12:32:09.948+00
9a2ca856-13c7-441e-8cc3-659f8a184d45	P005-2 - Acute Trauma	Stress	P005	P005-2	Response to a single shocking or distressing event such as an accident or assault.	4	f	\N	2026-01-27 12:32:09.948+00
e1d70aa7-6952-42a3-9404-a1e051fc2fc4	P005-3 - PTSD (Post-Traumatic Stress Disorder)	Stress	P005	P005-3	Ongoing symptoms after experiencing or witnessing a life-threatening event.	3	f	\N	2026-01-27 12:32:09.948+00
9e5eb702-86e1-4acc-806a-668f8f0ffb07	P005-4 - Complex Trauma	Trauma	P005	P005-4	Long-term exposure to multiple, often interpersonal traumatic experiences.	3	f	\N	2026-01-27 12:32:09.948+00
0f3baf2e-e351-4022-9403-8d60abb2b373	P005-5 - Childhood Trauma	Trauma	P005	P005-5	Trauma rooted in early life adversity such as abuse, neglect, or household dysfunction.	3	f	\N	2026-01-27 12:32:09.948+00
d738a820-9be0-45ab-880c-53106b5b906d	P005-6 - Medical Trauma	Trauma	P005	P005-6	Psychological impact of serious illness, injury, or invasive medical treatment.	3	f	\N	2026-01-27 12:32:09.948+00
c7f61f6c-7f11-406a-a91d-25b6c78a72d8	P005-7 - Traumatic Grief/Loss	Trauma	P005	P005-7	Grief complicated by sudden, violent, or unresolved loss of a loved one.	3	f	\N	2026-01-27 12:32:09.948+00
22476d41-5953-4dd2-a8bb-b9ed61042120	Academic Related to School	Academic Issues	AI_001	ARTS_001	example description	3	f	2026-01-06 12:20:57.612+00	2026-01-27 12:32:09.948+00
489fe2ea-0ddd-4b29-ba9a-639eb68d5d67	Social Media / Phone Overuse	Addictions	ADD_001	SMPO_001	Compulsive scrolling causing distress, sleep, or attention impairment	\N	f	2026-01-17 14:52:42.401+00	2026-01-27 12:32:09.948+00
84fbe172-1ce4-4c79-ba86-7b17313b60ab	Drugs	Addictions	ADD_001	DRU_001	Substance abuse - drugs: Substance use disorder with craving, tolerance, withdrawal, harmful consequences	\N	f	2026-01-17 14:55:36.368+00	2026-01-27 12:32:09.948+00
c5d6e991-1239-4462-87d2-de4b52240281	Food	Addictions	ADD_001	FOO_001	Compulsive overeating or bingeing beyond hunger, causing emotional or physical harm	\N	f	2026-01-17 14:57:31.168+00	2026-01-27 12:32:09.948+00
d347af4b-c5d3-4aa8-9231-8268ffd2734e	P004-1 Stress from Relationships	STR_782	STR_782	PSFR_001	Emotional or psychological stress related to romantic, social, or interpersonal relationships.	\N	t	2026-01-27 12:39:37.557622+00	2026-01-27 12:39:36.466+00
61cc9df2-8cd1-438b-ac56-1b23dbafda32	P004-2 Stress from Family Relations	STR_782	STR_782	PSFF_001	Stress caused by conflicts, expectations, or emotional strain within family systems.	\N	t	2026-01-27 12:39:37.557622+00	2026-01-27 12:39:36.466+00
940d0272-2885-42cd-b85a-5f5ceb9236af	P004-3 Stress from Bullying	STR_782	STR_782	PSFB_001	Stress reactions stemming from verbal, emotional, or physical bullying at school or in social settings.	\N	t	2026-01-27 12:39:37.557622+00	2026-01-27 12:39:36.466+00
151b356a-8937-4cd4-bdd5-99aa3fe9587f	P004-4 Stress from the Workplace	STR_782	STR_782	PSFT_001	Workplace-related stress due to pressure, workload, conflict, or role strain.	\N	t	2026-01-27 12:39:37.557622+00	2026-01-27 12:39:36.466+00
d2fd1c33-f893-498c-a501-e17acb12172f	P004-5 Emotional Dysregulation	STR_782	STR_782	PED_001	Inability to manage emotional responses effectively, leading to intense and rapidly shifting emotions.	\N	t	2026-01-27 12:39:37.557622+00	2026-01-27 12:39:36.466+00
7efdf8c3-25ae-4c3c-99c4-cf107cda5780	P004-6 Acute Stress Reaction	STR_782	STR_782	PASR_001	Acute physiological and emotional responses to a traumatic or overwhelming event.	\N	t	2026-01-27 12:39:37.557622+00	2026-01-27 12:39:36.466+00
ea167b1e-68b0-43ba-bf23-5002b8f8fdd5	Social Motivation & Peer Engagement	Motivation	MOT_001	SMPE_001	write this later	\N	t	2026-01-13 12:35:08.987+00	2026-01-27 12:32:09.948+00
1f0f6518-d5e7-469d-8b42-385e2ad95f28	Adjustment Disorder 	DEP_754	DEP_754	AD_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
ce18caf4-9457-4769-96fa-70d06ed9ae1e	Acute Trauma	TRA_961	TRA_961	AT_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
0f0fa469-bdd1-44b4-b64f-537b71afe1ae	PTSD	TRA_961	TRA_961	PTS_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
2faa91bc-c80f-46af-b106-7dd7501616d6	Childhood Trauma	TRA_961	TRA_961	CT_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
9c22d2a7-363e-4d85-a302-c4d3d84c07a5	Medical Trauma	TRA_961	TRA_961	MT_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
e2d60fdd-6142-481d-b70c-e822acdc9cd6	Traumatic grief and loss 	TRA_961	TRA_961	TGAL_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
3d95d669-5a6e-4577-a92d-a7a7293d7924	Separation anxiety 	ANX_756	ANX_756	SA_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
4b5a9715-1c74-4eb3-bd44-794ce40d4b54	Exam/test anxiety	ANX_756	ANX_756	EA_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
30ad6926-74aa-4180-a3bf-23a0ee053533	Transition/adjustment anxiety	ANX_756	ANX_756	TA_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
07a5e452-0d9f-46ce-a56a-8cf6c747a6a6	Panic attacks (disorder)	ANX_756	ANX_756	PAD_002	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
f571be53-cba4-40be-847a-64fe1ff88add	Generalised anxiety (moderate)	ANX_756	ANX_756	GAM_002	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
7c2c74a7-b3ee-477f-86bb-14bcb684149d	Generalised anxiety (severe)	ANX_756	ANX_756	GAS_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
9a0edf48-a955-4741-92a5-f09cb8a2ce34	Stress from relationships	STR_782	STR_782	SFR_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
9d920675-3a2d-4e0b-963a-fd292f455e82	Stress from family relationships	STR_782	STR_782	SFFR_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
030eda31-ca0d-4903-a9ad-24c940d6e039	Stress from bullying	STR_782	STR_782	SFB_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
e4a4414b-e9e4-47ed-b82e-dcc6013fe44b	Stress from the workplace	STR_782	STR_782	SFTW_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
a5f19e6f-cf9c-46c6-bb48-2623360a35bb	Emotional dysregulation	STR_782	STR_782	ED_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
67760b04-b3f7-41a3-bfc8-a93e89bfe55b	Acute stress reaction	STR_782	STR_782	ASR_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
d54d88bc-5089-4a32-b164-d0a5402cd25e	Stress from low self esteem 	STR_782	STR_782	SFLS_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
98df570e-b472-4aaa-834d-a195d3df8098	Major depressive disorder	DEP_754	DEP_754	MDD_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
1c8543e1-024d-4ddf-8a5e-86d187edc90c	Persistant depressive disorder	DEP_754	DEP_754	PDD_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
8e2e8017-9e4a-4b7e-a12d-6d677965d4f8	Cigarette addiction	ADD_001	ADD_001	CA_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
a6589317-ef76-4f65-896e-a176652fdd76	Social media/phone overuse	ADD_001	ADD_001	SMO_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
91dffe8d-8f3f-41b4-94a8-029702abaabf	Gaming addiction	ADD_001	ADD_001	GA_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
a0c27638-32b2-41a0-b252-1f89c52b9da5	Drug addiction	ADD_001	ADD_001	DA_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
59a8194f-6c39-46cd-8eb6-37cfd22bc031	Alcohol Addiction	ADD_001	ADD_001	AA_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
db656475-ffab-428f-8ac8-e9347df746d7	Food Addiction	ADD_001	ADD_001	FA_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
3ce2a7e3-b183-4bef-bcb2-f1bf250228cf	Gamling / online gaming	ADD_001	ADD_001	GOG_002	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
d696d2ff-9545-436b-8485-82ef86785000	Compulsive shopping - on and off line 	ADD_001	ADD_001	CSOA_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
3e8ba53c-a613-4ce9-a098-59f46c8d4513	Annorexia Nervosa	ED_001	ED_001	AN_002	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
2699073e-f9c7-4db9-ab8e-9ac2014ee009	Bullimia	ED_001	ED_001	BUL_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
b725836d-f3dc-45c1-bd9e-77b2d2ff8975	Binge eating disorder	ED_001	ED_001	BED_001	\N	\N	t	2026-01-27 13:02:54.910968+00	2026-01-27 13:02:50.407+00
dc596f03-8bb0-448a-a317-30e58268e793	Bulimia Nervosa 	Eating disorder	ED_001	BN_001	Bulimia Nervosa – cycles of binge eating followed by compensatory behaviors\nRecurrent binge-eating episodes\nRecurrent inappropriate compensatory behaviors (vomiting, laxatives, fasting, excessive exercise)\nBinges and compensatory behaviors occur at least once a week for 3 months\nSelf-evaluation unduly influenced by body shape and weight\n	\N	f	2026-01-17 15:09:01.43+00	2026-01-27 12:32:09.948+00
1f0e11bc-30ae-49e7-a876-efb5e05c68af	P001-1 Social Anxiety	Anxiety	ANX_756	PSA_002	Marked fear or anxiety about social situations where the individual might be scrutinized	\N	f	2026-01-27 12:16:51.663+00	2026-01-27 12:32:09.948+00
2ba99c36-5f2c-4ad9-a90d-01cbf4c76422	P001-5 Generalized Anxiety - Mild	Anxiety	P001	P001-5	Excessive anxiety and worry about a number of events or activities, occurring more days than not for at least six months	2	f	\N	2026-01-27 12:32:09.948+00
1c696e32-4024-4d94-836a-825f70be23ff	P001-6 Generalized Anxiety - Moderate	Anxiety	P001	P001-6	Excessive anxiety and worry about a number of events or activities, occurring more days than not for at least six months	3	f	\N	2026-01-27 12:32:09.948+00
03d4ee2f-7aed-4e8e-b112-a6f61225f9ba	P001-7 Generalized Anxiety - Severe	Anxiety	P001	P001-7	Excessive anxiety and worry about a number of events or activities, occurring more days than not for at least six months	4	f	\N	2026-01-27 12:32:09.948+00
cbaa020b-f43a-410a-b6bc-3d3b62b33a9b	P001-8 Separation Anxiety Disorder Disorder	Anxiety	P001	P001-8	Characterized by excessive anxiety concerning separation from those to whom the individual is attached.	3	f	\N	2026-01-27 12:32:09.948+00
eb633030-091e-4ae6-b62f-4f4ca71491dc	Exam Anxiety	Anxiety	GEN_01	GEN_01_01	Anxiety related to academic examinations.	3	f	2025-09-04 11:50:02.552679+00	2026-01-27 12:32:09.948+00
54f6b68b-a08c-4f90-8f85-9a954e1095b1	P004-7 Stress from Low Self Esteem	STR_782	STR_782	PSFL_001	Chronic stress emerging from negative self-image, low confidence, or perceived lack of self-worth.	\N	t	2026-01-27 12:39:37.557622+00	2026-01-27 12:39:36.466+00
fc8f32bc-0bfe-486b-a0bc-9682712e8eaa	Avoidant/restrictive food intake disorder	ED_001	ED_001	AFID_001	\N	\N	t	2026-01-17 15:12:44.086+00	2026-01-27 13:02:50.407+00
94d49b73-c2dc-4686-8766-8acc9dcc3228	P001-3 Transition/ adjustment anxiety	ANX_756	ANX_756	PTAA_001	Marked as anxious symptoms before or during major transitions like a new home, new school, divorce, etc.	\N	t	2026-01-27 12:35:04.465283+00	2026-01-27 12:36:00.422+00
af0b225b-e15e-480a-96cb-d832688ecdbf	P001-4 Panic attacks (disorder)	ANX_756	ANX_756	PPAD_001	Recurrent unexpected panic attacks, followed by persistent concern about having more attacks or significant behavioral changes related to the attacks.	\N	t	2026-01-27 12:35:04.465283+00	2026-01-27 12:36:00.422+00
0060aa33-c13d-4266-87e5-00a85b948095	P001-6 Generalized anxiety - Moderate	ANX_756	ANX_756	PGAM_001	Excessive anxiety and worry about a number of events or activities, occurring more days than not for at least six months	\N	t	2026-01-27 12:35:04.465283+00	2026-01-27 12:36:00.422+00
a7988624-072e-4a70-9947-d5a641b8f1a1	P001-7 Generalized anxiety - Severe	ANX_756	ANX_756	PGAS_001	Excessive anxiety and worry about a number of events or activities, occurring more days than not for at least six months	\N	t	2026-01-27 12:35:04.465283+00	2026-01-27 12:36:00.422+00
2b303109-7a4f-4dec-99eb-c2a95252d01a	P001-8 Separation Anxiety	ANX_756	ANX_756	PSA_003	Characterized by excessive anxiety concerning separation from those to whom the individual is attached.	\N	t	2026-01-27 12:35:04.465283+00	2026-01-27 12:36:00.422+00
9ff1a7cf-b832-4fca-a220-a51d1c475950	P001-1 Social Anxiety	ANX_756	ANX_756	PSA_001	Marked fear or anxiety about social situations where the individual might be scrutinized	\N	t	2026-01-27 12:00:06.492+00	2026-01-27 12:36:00.422+00
\.


--
-- Data for Name: project_cost_breakdowns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."project_cost_breakdowns" ("id", "project_id", "resources", "accommodation", "tools_licenses", "architecture", "ppn_tax", "pph_tax", "contingency", "total_cost", "margin", "created_at", "updated_at", "miscellaneous", "travel_expenses", "equipment") FROM stdin;
\.


--
-- Data for Name: project_financial_health; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."project_financial_health" ("id", "project_id", "project_name", "client_name", "total_value", "cost_breakdown", "margin", "margin_percentage", "status", "risk_factors", "projected_margin", "delay_impact", "project_status", "start_date", "end_date", "description", "created_at", "updated_at") FROM stdin;
749f1212-cc01-416d-9b77-51423a49b5de	550e8400-e29b-41d4-a716-446655440001	E-commerce Platform Redesign	TechCorp Inc.	15000000	{"tax": 12000, "tools": 3000, "total": 110000, "server": 2000, "contingency": 8000, "resourceCost": 80000, "accommodation": 5000}	4000000	0.27	healthy	{"Market competition","Technology stack complexity"}	0.24	0.05	on-track	2024-01-15	2024-06-15	Complete redesign of existing e-commerce platform with modern UI/UX	2025-09-14 15:25:24.26003+00	2025-09-14 15:25:24.26003+00
6e29ab98-65fa-4f0b-971a-d3e98a2f3677	550e8400-e29b-41d4-a716-446655440002	Mobile Banking App	FinanceFirst Bank	20000000	{"tax": 16000, "tools": 5000, "total": 165000, "server": 4000, "contingency": 12000, "resourceCost": 120000, "accommodation": 8000}	3500000	0.18	at-risk	{"Regulatory compliance","Security requirements","Tight deadline"}	0.16	0.10	delayed	2024-02-01	2024-07-01	Secure mobile banking application with biometric authentication	2025-09-14 15:25:24.26003+00	2025-09-14 15:25:24.26003+00
c565825f-614a-464f-8d28-8ce547dbb7a3	550e8400-e29b-41d4-a716-446655440004	Legacy System Migration	OldTech Solutions	30000000	{"tax": 25000, "tools": 8000, "total": 333000, "server": 5000, "contingency": 20000, "resourceCost": 250000, "accommodation": 15000}	-3300000	-0.11	critical	{"Legacy system complexity","Data migration risks","Budget overrun","Timeline delays"}	-0.12	0.20	delayed	2024-01-01	2024-08-01	Migration of 20-year-old legacy system to modern architecture	2025-09-14 15:25:24.26003+00	2025-09-14 15:25:24.26003+00
1dbb36a0-6e74-4631-9427-a89908dc41b9	550e8400-e29b-41d4-a716-446655440005	Website Maintenance	SmallBiz LLC	2500000	{"tax": 2000, "tools": 500, "total": 20000, "server": 300, "contingency": 1200, "resourceCost": 15000, "accommodation": 1000}	500000	0.20	healthy	{}	0.18	0.01	on-track	2024-04-01	2024-05-01	Monthly website maintenance and updates	2025-09-14 15:25:24.26003+00	2025-09-14 15:25:24.26003+00
80245352-2cbd-4add-977a-4399352a4488	8ad335cc-b760-47d9-8a8c-310a38add7bd	Test Project for Financial Health	Test Client	1000000	{"tax": 100000, "tools": 50000, "total": 1000000, "server": 50000, "contingency": 200000, "resourceCost": 500000, "accommodation": 100000}	0	0.00	healthy	{}	0.00	0.00	on-track	2024-01-01	2024-06-30	Test project for financial health creation	2025-09-14 17:12:06.049014+00	2025-09-14 17:12:06.049014+00
955c59a0-8b83-4724-9843-dda9cd913276	550e8400-e29b-41d4-a716-446655440003	Business Intelligence Dashboardss	RetailMax Corp	8000000	{"tax": 6000, "tools": 2000, "total": 62000, "server": 1500, "contingency": 4500, "resourceCost": 45000, "accommodation": 3000}	7938000	99.23	healthy	{"Data integration complexity"}	84.23	15.00	on-track	2024-03-01	2024-05-15	Real-time analytics dashboard for retail operations	2025-09-14 15:25:24.26003+00	2025-09-14 17:27:43.825984+00
bdd2d1f6-2b1c-431e-a419-41994c2d4688	16936467-acfd-4464-a3b0-8856e54052ca	test project	Pertamina	100000000000	{"tax": 0, "tools": 0, "total": 50000000000, "server": 0, "contingency": 0, "resourceCost": 50000000000, "accommodation": 0}	50000000000	50.00	healthy	{dags}	35.00	15.00	on-track	2025-09-15	2026-03-28	test	2025-09-14 17:44:32.130637+00	2025-09-14 17:44:32.130637+00
\.


--
-- Data for Name: project_health_metrics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."project_health_metrics" ("id", "project_id", "budget_variance", "schedule_variance", "profit_margin_trend", "risk_level", "client_satisfaction", "overall_health", "calculated_at", "created_at", "updated_at") FROM stdin;
550e8400-e29b-41d4-a716-446655440050	27320a14-3e42-49b8-aab2-4cbd446aa4ab	-5.20	2.10	8.50	good	85	78	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00
550e8400-e29b-41d4-a716-446655440051	550e8400-e29b-41d4-a716-446655440001	3.10	-1.50	12.30	excellent	92	88	2024-02-01 00:00:00+00	2024-02-01 00:00:00+00	2024-02-01 00:00:00+00
\.


--
-- Data for Name: project_milestones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."project_milestones" ("id", "project_id", "name", "description", "due_date", "completed_date", "is_critical", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: project_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."project_reports" ("id", "project_id", "report_type", "title", "data", "generated_by", "generated_at", "created_at") FROM stdin;
\.


--
-- Data for Name: project_risks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."project_risks" ("id", "project_id", "title", "description", "severity", "status", "mitigation_plan", "assigned_to", "due_date", "created_at", "updated_at") FROM stdin;
550e8400-e29b-41d4-a716-446655440060	27320a14-3e42-49b8-aab2-4cbd446aa4ab	Mobile App Performance	Mobile app may have performance issues on older devices	medium	open	Implement performance optimization and testing on various devices	550e8400-e29b-41d4-a716-446655440004	2024-04-30	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00
550e8400-e29b-41d4-a716-446655440061	27320a14-3e42-49b8-aab2-4cbd446aa4ab	Third-party API Dependency	Heavy dependency on external payment gateway APIs	high	in_progress	Implement fallback mechanisms and API monitoring	550e8400-e29b-41d4-a716-446655440005	2024-03-31	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00
\.


--
-- Data for Name: project_sprints; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."project_sprints" ("id", "project_id", "release_id", "name", "description", "start_date", "end_date", "budget", "actual_cost", "status", "progress", "created_at", "updated_at") FROM stdin;
550e8400-e29b-41d4-a716-446655440020	27320a14-3e42-49b8-aab2-4cbd446aa4ab	550e8400-e29b-41d4-a716-446655440010	Sprint 1 - Foundation	Core platform setup and basic features	2024-01-15	2024-02-15	50000000	45000000	completed	100	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00
550e8400-e29b-41d4-a716-446655440021	27320a14-3e42-49b8-aab2-4cbd446aa4ab	550e8400-e29b-41d4-a716-446655440010	Sprint 2 - User Management	User authentication and authorization	2024-02-16	2024-03-15	50000000	48000000	completed	100	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00
550e8400-e29b-41d4-a716-446655440022	27320a14-3e42-49b8-aab2-4cbd446aa4ab	550e8400-e29b-41d4-a716-446655440011	Sprint 3 - Mobile App	Mobile application development	2024-03-16	2024-04-15	60000000	35000000	in_progress	60	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00
\.


--
-- Data for Name: work_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."work_orders" ("id", "project_id", "sprint_id", "name", "description", "estimated_hours", "actual_hours", "budget", "actual_cost", "status", "assigned_talents", "due_date", "created_at", "updated_at") FROM stdin;
550e8400-e29b-41d4-a716-446655440030	27320a14-3e42-49b8-aab2-4cbd446aa4ab	550e8400-e29b-41d4-a716-446655440020	WO-001: Platform Architecture	Design and implement core platform architecture	120	110	15000000	14000000	completed	{550e8400-e29b-41d4-a716-446655440004,550e8400-e29b-41d4-a716-446655440005}	2024-02-10	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00
550e8400-e29b-41d4-a716-446655440031	27320a14-3e42-49b8-aab2-4cbd446aa4ab	550e8400-e29b-41d4-a716-446655440020	WO-002: Database Setup	Database design and implementation	80	75	10000000	9500000	completed	{550e8400-e29b-41d4-a716-446655440004}	2024-02-05	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."tasks" ("id", "project_id", "name", "title", "description", "estimated_hours", "actual_hours", "status", "priority", "due_date", "created_at", "updated_at", "work_order_id", "sprint_id", "assigned_talent", "tags", "progress") FROM stdin;
550e8400-e29b-41d4-a716-446655440040	27320a14-3e42-49b8-aab2-4cbd446aa4ab	task-001	Design System Architecture	Create the overall system architecture and technical specifications	40	38	completed	high	2024-02-01	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00	550e8400-e29b-41d4-a716-446655440030	550e8400-e29b-41d4-a716-446655440020	550e8400-e29b-41d4-a716-446655440004	{architecture,design,planning}	100
550e8400-e29b-41d4-a716-446655440041	27320a14-3e42-49b8-aab2-4cbd446aa4ab	task-002	Implement Core Services	Build the core backend services and APIs	60	55	completed	high	2024-02-08	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00	550e8400-e29b-41d4-a716-446655440030	550e8400-e29b-41d4-a716-446655440020	550e8400-e29b-41d4-a716-446655440005	{backend,api,development}	100
550e8400-e29b-41d4-a716-446655440042	27320a14-3e42-49b8-aab2-4cbd446aa4ab	task-003	Database Schema Design	Design and implement the database schema	30	28	completed	medium	2024-02-03	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00	550e8400-e29b-41d4-a716-446655440031	550e8400-e29b-41d4-a716-446655440020	550e8400-e29b-41d4-a716-446655440004	{database,schema,design}	100
550e8400-e29b-41d4-a716-446655440043	27320a14-3e42-49b8-aab2-4cbd446aa4ab	task-004	User Authentication System	Implement user login and registration functionality	50	45	completed	high	2024-03-10	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00	550e8400-e29b-41d4-a716-446655440030	550e8400-e29b-41d4-a716-446655440021	550e8400-e29b-41d4-a716-446655440005	{auth,security,frontend}	100
550e8400-e29b-41d4-a716-446655440044	27320a14-3e42-49b8-aab2-4cbd446aa4ab	task-005	Mobile App UI Development	Develop the mobile application user interface	80	45	in_progress	high	2024-04-10	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00	550e8400-e29b-41d4-a716-446655440030	550e8400-e29b-41d4-a716-446655440022	550e8400-e29b-41d4-a716-446655440004	{mobile,ui,react-native}	60
\.


--
-- Data for Name: resource_allocations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."resource_allocations" ("id", "user_id", "project_id", "task_id", "allocation_percentage", "start_date", "end_date", "hourly_rate", "resource_type", "is_active", "created_at", "updated_at") FROM stdin;
550e8400-e29b-41d4-a716-446655440070	550e8400-e29b-41d4-a716-446655440004	27320a14-3e42-49b8-aab2-4cbd446aa4ab	550e8400-e29b-41d4-a716-446655440040	100	2024-01-15	2024-04-30	150000	internal	t	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00
550e8400-e29b-41d4-a716-446655440071	550e8400-e29b-41d4-a716-446655440005	27320a14-3e42-49b8-aab2-4cbd446aa4ab	550e8400-e29b-41d4-a716-446655440041	80	2024-01-15	2024-04-30	160000	internal	t	2024-01-15 00:00:00+00	2024-01-15 00:00:00+00
\.


--
-- Data for Name: risk_factors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."risk_factors" ("id", "project_id", "factor_name", "description", "risk_level", "impact_score", "probability_score", "mitigation_plan", "status", "created_at", "updated_at") FROM stdin;
8b3e232a-5952-48b8-a524-00674827c9a5	550e8400-e29b-41d4-a716-446655440001	Market Competition	High competition in e-commerce space may affect project timeline	medium	7	6	Conduct competitive analysis and adjust features accordingly	active	2025-09-14 15:25:24.421913+00	2025-09-14 15:25:24.421913+00
55614f3c-b729-499e-96fa-c88f2c68676c	550e8400-e29b-41d4-a716-446655440001	Technology Stack Complexity	New technology stack may require additional learning time	low	5	4	Provide team training and allocate buffer time	active	2025-09-14 15:25:24.421913+00	2025-09-14 15:25:24.421913+00
f8654c6f-1478-422a-8c02-04631734834a	550e8400-e29b-41d4-a716-446655440002	Regulatory Compliance	Banking regulations may require additional security measures	high	9	8	Engage compliance expert and allocate additional budget	active	2025-09-14 15:25:24.421913+00	2025-09-14 15:25:24.421913+00
d210601e-f074-43c5-baa5-23fa416a26bf	550e8400-e29b-41d4-a716-446655440002	Security Requirements	High security standards may impact development speed	high	8	7	Implement security-first development approach	active	2025-09-14 15:25:24.421913+00	2025-09-14 15:25:24.421913+00
7cea73fc-4fd6-44e0-b843-500dea04de3f	550e8400-e29b-41d4-a716-446655440002	Tight Deadline	Aggressive timeline may lead to quality issues	medium	6	6	Prioritize features and consider phased delivery	active	2025-09-14 15:25:24.421913+00	2025-09-14 15:25:24.421913+00
d1b024fd-e2a0-465e-a4c2-8768fe749264	550e8400-e29b-41d4-a716-446655440004	Legacy System Complexity	20-year-old system has undocumented dependencies	critical	10	9	Conduct thorough system analysis and create detailed documentation	active	2025-09-14 15:25:24.421913+00	2025-09-14 15:25:24.421913+00
cfd34377-321a-4273-be4f-8e924af417e3	550e8400-e29b-41d4-a716-446655440004	Data Migration Risks	Risk of data loss during migration process	critical	9	8	Implement comprehensive backup and testing procedures	active	2025-09-14 15:25:24.421913+00	2025-09-14 15:25:24.421913+00
358ff786-bb49-4d7e-b653-80a6729f775b	550e8400-e29b-41d4-a716-446655440004	Budget Overrun	Project already 10% over budget	high	8	7	Review scope and identify cost-saving measures	active	2025-09-14 15:25:24.421913+00	2025-09-14 15:25:24.421913+00
c409d853-5b4d-4221-93cc-e6245432eefd	550e8400-e29b-41d4-a716-446655440004	Timeline Delays	Project is 2 months behind schedule	high	7	8	Reassess timeline and consider additional resources	active	2025-09-14 15:25:24.421913+00	2025-09-14 15:25:24.421913+00
987c52c5-e06c-4a96-8fb8-0bf058841627	550e8400-e29b-41d4-a716-446655440003	Data Integration Complexity	Multiple data sources may be difficult to integrate	medium	6	5	Create data mapping documentation and test integration early	active	2025-09-14 15:25:24.421913+00	2025-09-14 15:25:24.421913+00
\.


--
-- Data for Name: suggestions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."suggestions" ("id", "suggestion_id", "sub_category_id", "cluster", "suggestion_text", "resource_link", "evidence_base", "difficulty_level", "estimated_duration", "tags", "is_active", "created_at", "updated_at") FROM stdin;
e54b7584-4a8e-4d65-9189-523ddc2d15d9	S001	P005-1	c1	Identify one behavior that you’ve stopped doing since the incident—something that used to bring a sense of structure or reward (e.g., going to the gym, journaling, calling a friend). Break it into three small, manageable steps and schedule the first step this week. Example: Behavior: Cooking a basic meal again. Step 1: Write a grocery list. Step 2: Buy ingredients for one simple recipe. Step 3: Cook and eat that meal mindfully. Purpose: This helps combat avoidance, boost energy, and reintroduce positive reinforcement.	\N	\N	\N	\N	\N	\N	\N	\N
00b07f88-1718-47d9-b17c-b445f4e8b0ba	S002	P005-1	c1	Take a recurring stress-related thought (e.g., “I can’t deal with anything anymore”) and write it at the top of a page. Underneath, create two columns: (1) Evidence that supports this thought, and (2) Evidence that challenges it. Then reframe it into a more flexible thought (e.g., “I feel overwhelmed, but I’ve handled things before”). Purpose: Trains cognitive restructuring and challenges catastrophic interpretations common in adjustment disorder.	\N	\N	\N	\N	\N	\N	\N	\N
b2d2be72-a2b7-4afe-8d60-d300ccc76bef	S003	P005-1	c1	Use the “Values Compass”: Identify one core value (e.g., stability, connection, growth). Ask: “Why does this matter to me?”, “How has this value been affected by the event?”, and “What’s one small act this week that moves me toward this value?” Example: If “connection” is the value, the action might be sending a check-in text to a friend. Purpose: This restores motivation and meaning after disruption and helps prioritize behavior aligned with identity.	\N	\N	\N	\N	\N	\N	\N	\N
5023d228-6c35-4ceb-b5b5-8ec41469c1a9	S004	P005-1	c1	Write a values-based reflection letter to yourself about how you responded to the stressful incident and what personal strengths you used during that time. Be honest and specific. You might begin with: “At first, I felt frozen by everything. But despite that, I managed to…” or “One thing I did that surprised me was…” Identify the internal qualities that helped you (e.g., courage, empathy, responsibility, endurance). Don’t focus on “being perfect”—focus on your authentic efforts. Then, reflect on what matters most to you now and write about one small values-aligned action you’ll commit to doing this week. Purpose: This ACT-based exercise supports psychological flexibility, values re-engagement, and cognitive distancing from trauma-anchored identity.	\N	\N	\N	\N	\N	\N	\N	\N
cf45aa0a-a32c-4dbc-a093-97b001ff7af7	S005	P005-1	c1	Use the “Stress Puzzle” method: Write down all aspects of your current adjustment challenge. Break them into two columns: “What I can influence” vs. “What I cannot.” Choose one actionable piece to focus on this week. Purpose: Reduces overwhelm by separating controllable vs. uncontrollable aspects and shifting focus to small wins.	\N	\N	\N	\N	\N	\N	\N	\N
82da4dfa-f61c-4e31-bdd1-37c737727f44	S006	P005-1	c1	Map your “Resilience Resources”: Draw three circles labeled: “People”, “Places”, and “Practices”. Fill each with stable, supportive resources you still have or can reconnect with. Then pick one to actively engage with this week (e.g., call a friend, return to journaling, walk a calming route). Purpose: Reinforces existing support systems and reminds the person that resources still exist, despite the disruption.	\N	\N	\N	\N	\N	\N	\N	\N
98571e33-fc56-4e7b-bc60-5704f57840f9	S007	P005-1	c1	Track your “adjustment curve”: Note one emotional, one behavioral, and one thinking pattern that has shifted since the event. Use this to notice progress and identify areas still needing support. Ask: “What changed?”, “What improved?”, “What still needs attention?” Purpose: This helps break down the complexity of adjustment into observable, trackable parts, supporting cognitive processing and emotional labeling.	\N	\N	\N	\N	\N	\N	\N	\N
9994d0e7-60b6-4093-a9cb-06b99e4df94c	S008	P005-1	c1	Practice the “One-Minute Reframe”: When facing an emotional wave, pause and ask, “What is this really about?” and “What matters most right now?” Then name one small action that honors what matters — not what the emotion demands. Purpose: Encourages values-based redirection and cognitive-emotional flexibility in real time.	\N	\N	\N	\N	\N	\N	\N	\N
dc8ad2f1-b715-4008-8f85-c82296989a7c	S009	P005-1	c1	Schedule a 20-minute “stability window” each day: Do a familiar, structured task that reminds you of competence and predictability (e.g., making a meal, cleaning, walking the same route). Purpose: Restores a sense of routine and control, useful during emotional chaos.	\N	\N	\N	\N	\N	\N	\N	\N
86107cbd-d5ed-4202-b9bd-030c012a66be	S010	P005-1	c1	Identify one area in your life where you're avoiding something (e.g., conversations, paperwork, decisions). Break it into three smaller steps and do the first one today. Track how your avoidance changes over a week. Purpose: Addresses experiential avoidance and promotes action-based recovery.	\N	\N	\N	\N	\N	\N	\N	\N
a5475aaf-eb4b-46f9-87bc-7b2f810b8c1f	S011	P005-1	c1	Use the "Personal Timeline" technique: On a blank page, draw a horizontal timeline from “Before the Incident” to “Now.” Mark moments of strength, coping, support, or progress since the incident. Even small events like “got out of bed,” “texted a friend,” or “cried and let it out” count. Purpose: Reframes the current struggle as a dynamic adjustment process, not a static state of being stuck.	\N	\N	\N	\N	\N	\N	\N	\N
4319587c-739b-4f29-8f9b-22e66bdfaee7	S012	P005-1	c1	Build a "micro-routine": Choose three tiny actions to repeat each morning (e.g., open the window, drink a glass of water, stretch arms). Keep them easy and consistent. These rituals offer predictability and restore small moments of self-control when the larger world feels disrupted.	\N	\N	\N	\N	\N	\N	\N	\N
269fdcb4-a161-41b9-a2bc-0764ff1f4b6b	S013	P005-1	c1	Do a “meaning scan”: Write down what has changed since the incident—not only in terms of difficulty but also in perspective or values. Then answer: “What matters to me now that didn’t before?” Purpose: Strengthens post-crisis growth by helping the person notice what they want to preserve, reclaim, or reinvent.	\N	\N	\N	\N	\N	\N	\N	\N
39818197-1195-4d1e-851f-7ae682bbe3eb	S014	P005-1	c1	Use the “Three Lenses” technique when something triggers distress: (1) What am I feeling? (2) What am I needing right now? (3) What’s a small, values-aligned next step? Purpose: Trains emotion labeling, unmet need identification, and response flexibility. This helps move from reactivity to intentionality.	\N	\N	\N	\N	\N	\N	\N	\N
8511d1e6-04a8-433f-8dc7-4bc5f58e090c	S015	P005-1	c1	Visualize a “stability space”: Close your eyes and imagine a place (real or imagined) where you feel grounded and secure. Describe it in detail (sights, sounds, smells), then name one thing you could bring from that space into your current life (e.g., “peace,” “light,” “warmth”). Purpose: Builds psychological safety and anchors regulation without generic grounding.	\N	\N	\N	\N	\N	\N	\N	\N
00d072ed-dd40-47c4-bcce-9f382d963971	S016	P005-2	c2	Ask 'What Do I Still Have Control Over Today?'\\nIn the chaos of acute stress, people often feel everything is out of control. Reclaiming even a small sense of agency can help stabilize the mind.\\n👉 Write down 3 things you still have influence over: your breath, what you eat, or what music you play.\\n🌱 Focus on decisions that are reachable.\\n🧠 Why it helps: Even limited control activates the prefrontal cortex and reduces helplessness.	\N	\N	\N	\N	\N	\N	\N	\N
67b7a8cf-58d7-485b-a390-e31176316fb1	S017	P005-2	c2	Break the Day Into 2-Hour Chunks\\nThe future can feel overwhelming. Time distortion is common in acute stress.\\n👉 Create a micro-schedule: ‘From 9–11 I’ll do this. From 11–1 I’ll rest.’\\n🌱 Repeat each block like a ritual.\\n🧠 Why it helps: Time framing restores predictability.	\N	\N	\N	\N	\N	\N	\N	\N
2c278bec-a73e-48be-bf28-46b6fa823b89	S018	P005-2	c2	Name the Event Out Loud or in Writing\\nAvoidance can strengthen distress. Naming what happened—without having to explain it—creates mental distance.\\n👉 Try this script: “Something terrible/shocking/stressful happened. I’m not ready to talk about it fully, but I know it occurred.”\\n🌱 This gives the brain a handle to begin processing.\\n🧠 Why it helps: Labeling reduces emotional intensity and activates cognitive circuits.	\N	\N	\N	\N	\N	\N	\N	\N
838e19c7-3726-4cf2-a6e5-a01df32bca98	S019	P005-2	c2	Build a Short 'Stability List'\\nIn the first days after stress, make a visible list of 3 things that bring even a small sense of calm.\\n👉 Examples: hot shower, sitting in sunlight, listening to music.\\n🌱 Put this list on your fridge, desk, or phone.\\n🧠 Why it helps: Reminders increase likelihood of use, and reinforce internal safety cues.	\N	\N	\N	\N	\N	\N	\N	\N
82ab9860-1c17-40ac-86d7-c30cb8d97ce0	S020	P005-2	c2	Ask: 'Who Is One Person That Feels Safe Right Now?'\\nSocial withdrawal is a common response to trauma. But one positive interaction can reset your stress response.\\n👉 Message, call, or just think about this person. If reaching out feels too hard, write a note you don’t send.\\n🌱 You’re reminding your system that safety exists.\\n🧠 Why it helps: Connection restores coregulatory capacity and reduces isolation.	\N	\N	\N	\N	\N	\N	\N	\N
6a3b41c0-d3d2-48d3-b3cf-891866782743	S021	P005-2	c2	Map Out the Timeline of What Happened\\nOne of the first steps in integrating a traumatic experience is organizing the sequence of events. Even if it's fragmented, trying to tell the story in order helps restore narrative coherence.\\n👉 How: Write (or say) what happened before, during, and after the event. It doesn’t need to be perfect. Add how your body felt or what you were thinking at each stage.\\n💡 Why it works: From a cognitive-behavioral view, trauma often creates disjointed memory. Rebuilding the story helps contain it.	\N	\N	\N	\N	\N	\N	\N	\N
b5429753-c0a5-4d47-a339-fce24f9f87e8	S022	P005-2	c2	Identify What Feels Most Unsafe Right Now\\nAfter acute stress, people often experience a vague sense of threat, even if they’re physically safe. Clarifying the specific fear allows the brain to down-regulate its defense system.\\n👉 How: Ask: “What do I fear is going to happen next?” Break the fear into facts vs. projections.\\n💡 Why it works: RAPID’s assessment and prioritization stages emphasize locating the perceived threat to allow proper support and stabilization.	\N	\N	\N	\N	\N	\N	\N	\N
8be512cf-ca89-437c-9a18-d8520386ea3e	S023	P005-2	c2	List the Resources That Are Still Intact\\nIn acute stress, your attention focuses on loss and disruption. Deliberately noticing what remains steady can help reorient your mindset from helplessness to hope.\\n👉 How: Write down: People you can still talk to, places that feel safe, skills you haven’t lost.\\n💡 Why it works: This primes your brain to notice support and reinforces the “C” of Connect and Cope.	\N	\N	\N	\N	\N	\N	\N	\N
ac48b286-2114-4f42-b9ab-6354f8929204	S024	P005-2	c2	Assign Yourself a Leadership Task, No Matter How Small\\nEven when you feel fragile, taking responsibility for something—yourself, a space, or a person—can reduce the feeling of being a victim.\\n👉 How: Examples: Create a 3-day check-in plan with a friend; organize your environment; share a coping tip with someone else.\\n💡 Why it works: Being useful and needed taps into internal motivation and neurobiological repair.	\N	\N	\N	\N	\N	\N	\N	\N
e21d8eb2-95b4-452a-85f6-45f31b611411	S025	P005-2	c2	Visualize What 'Stabilized' Looks Like in 72 Hours\\nInstead of “getting back to normal,” shift to imagining what a more stable version of you could look like within 3 days. This invites hope, not perfection.\\n👉 How: Ask: “If things felt 20% more stable in 3 days, what would be different?” Visualize that version: calmer breathing, more rest, less isolation\\n💡 Why it works: This builds future orientation and increases goal-directed thinking, which counters traumatic time-freeze.	\N	\N	\N	\N	\N	\N	\N	\N
252d0827-6a18-493e-8bba-427dc644cfb8	S026	P005-2	c2	Use Anchoring Language to Stay in the Present Moment\\nAfter acute stress, your brain may shift into “reliving mode” without warning. This can feel like being pulled back into the traumatic event.\\n👉 Try this grounding sentence when the past invades the present: “Right now I am ___. I am in ___. It is __ o’clock. I see ___ and hear ___.”\\nSay it slowly. You can repeat it as often as needed.\\n🌱 Use it during moments of overwhelm, or just to reset mid-day.\\n🧠 Why it helps: Anchoring language engages the prefrontal cortex, reconnecting you to the present and reducing automatic threat responses.	\N	\N	\N	\N	\N	\N	\N	\N
6104341a-a6e7-4b2c-9a88-e572bb4d94ff	S027	P005-2	c2	Give Yourself Permission to Not “Be Productive”\\nIn early stress recovery, many people pressure themselves to “get back to normal.” But the body and brain are busy processing the event, even if you're just sitting still.\\n👉 Remind yourself: “I’m not lazy. I’m healing. Rest is work right now.”\\nWrite this down. Place it somewhere visible.\\n🌱 This reframes rest as resilience, not avoidance.\\n🧠 Why it helps: Reduces shame, supports parasympathetic regulation, and reinforces self-compassion.	\N	\N	\N	\N	\N	\N	\N	\N
214e60c0-29c8-423d-a092-4c572c8d6378	S028	P005-2	c2	Create a 'Calm Kit' With Objects That Engage the Senses\\nPhysical grounding is crucial in the first week after trauma. A portable “kit” gives your nervous system a lifeline.\\n👉 Include: A calming scent (lavender oil, favorite lotion); A smooth object (stone, coin, fabric); Something visual (photo, quote, artwork); Music or sounds that bring peace\\n🌱 Use it during moments of overwhelm, or just to reset mid-day.\\n🧠 Why it helps: Sensory input signals the amygdala that there is no current danger.	\N	\N	\N	\N	\N	\N	\N	\N
d77f85de-0315-4b22-8cb9-aade1d6b0af4	S029	P005-2	c2	Recognize That Reactions Are Normal, Even If They’re Intense\\nYou might cry suddenly, feel irritable, or go numb. These are not signs of “breaking down”—they are evidence that your system is trying to make sense of something overwhelming.\\n👉 Say aloud or write down: “My reactions make sense for what I went through. I don’t have to understand them right now.”\\n🌱 Keep a “reaction log” instead of a journal—just a note of what came up, without needing to explain it.\\n🧠 Why it helps: Normalizing stress reactions interrupts the spiral of fear about symptoms.	\N	\N	\N	\N	\N	\N	\N	\N
45a26351-521c-4dd9-992c-fa6f8f57ec15	S030	P005-2	c2	Engage in One Strength-Based Action Each Day\\nDuring crisis, we often lose sight of our strengths. This practice reconnects you with your unique abilities—even if they feel muted.\\n👉 Examples: If your strength is creativity: sketch what safety looks like; If it’s kindness: write a 2-line message to someone else; If it’s analysis: map what helped you cope today\\n🌱 Focus on actions that reconnect you to your identity.\\n🧠 Why it helps: Identity continuity is a powerful stabilizer in trauma recovery.	\N	\N	\N	\N	\N	\N	\N	\N
b77d2fce-1d92-43cb-bea3-4d65bbfd3a68	S031	P005-2	c2	Ask: “When I breathe in, where do I feel it most?”\\nThis question helps you anchor attention to your body instead of racing thoughts. You’re not asking your brain to “calm down,” but to observe something real.\\n👉 Use this during moments of tightness, panic, or numbness.\\n🌱 Follow the breath with curiosity, not pressure.\\n🧠 Why it helps: Directing attention to physical sensation activates sensory pathways that interrupt hyperarousal.	\N	\N	\N	\N	\N	\N	\N	\N
fadb7ba6-7214-49b9-94d5-75c00aac6df1	S032	P005-2	c2	Set a 3-Minute Timer to Do Nothing\\nAcute stress often brings hyperactivity or avoidance. This technique gives your system space without pressure to fix anything.\\n👉 Sit or lie down. Set a timer for 3 minutes. Don’t try to think or not think. Just be.\\n🌱 No goal, no success/failure. Just a pause.\\n🧠 Why it helps: Short intentional rest interrupts the cycle of emotional overdrive.	\N	\N	\N	\N	\N	\N	\N	\N
02c3fc51-a165-4153-8bce-0541e603ccc6	S033	P005-2	c2	Ask Yourself: “What Do I Know For Sure Right Now?”\\nThis is a powerful tool for getting out of panic loops. It brings your mind back to fact rather than fear.\\n👉 Examples: “I’m in my room. I can hear the AC. It’s Thursday. I ate lunch.”\\n🌱 Say it out loud. Focus only on current, verifiable truths.\\n🧠 Why it helps: It deactivates threat projection and brings your attention back to stability.	\N	\N	\N	\N	\N	\N	\N	\N
51f49c96-758f-4104-b078-bfeff5f57500	S034	P005-2	c2	Write a Message From the Future You\\nVisualizing a future version of yourself that has healed—even a little—helps pull you toward hope.\\n👉 Write a short letter from your “3-months-from-now self.” What advice would they give? What do they know you’ll get through?\\n🌱 Keep it where you can see it.\\n🧠 Why it helps: This activates values, imagination, and forward orientation.	\N	\N	\N	\N	\N	\N	\N	\N
4e1d50bb-0dc0-46c6-a8bf-e7e3106db1f9	S035	P005-2	c2	Use the “3 Circles” Exercise to Sort What You Carry\\nWhen everything feels heavy, draw 3 circles:\\n– Circle 1: Things I can control\\n– Circle 2: Things I can influence\\n– Circle 3: Things I cannot control or influence\\n👉 Move one item per day from circle 2 to circle 1 by taking small action.\\n🌱 This helps with decision-making and reduces overload.\\n🧠 Why it helps: Clarifies boundaries, restores energy, and supports self-efficacy.	\N	\N	\N	\N	\N	\N	\N	\N
896cc884-3ee3-4b9c-8192-cb2b8b0be026	S036	P005-2	c2	Practice the “5-4-3-2-1” Sensory Countdown\\nWhen your thoughts feel chaotic or out of control, shifting attention to the five senses can ground you in the here and now.\\n👉 Name 5 things you can see, 4 things you can touch, 3 things you can hear, 2 things you can smell, and 1 thing you can taste.\\n🌱 No need to rush. Take time with each one.\\n🧠 Why it helps: This interrupts cognitive flooding and stimulates areas of the brain responsible for regulation and orientation.	\N	\N	\N	\N	\N	\N	\N	\N
82258772-4c7f-4b95-95a0-8201a742e6de	S037	P005-2	c2	Create a Mini-Routine for Morning or Evening\\nAfter acute stress, time may feel broken. Small routines can help you rebuild safety.\\n👉 Choose 3 steps: Example morning routine – brush teeth, open window, make tea.\\n👉 Repeat daily, even if you don’t feel like it.\\n🌱 Routines don’t fix everything, but they provide predictability.\\n🧠 Why it helps: Rituals reduce mental chaos and engage procedural memory, which is often preserved even in distress.	\N	\N	\N	\N	\N	\N	\N	\N
df1ae11b-b609-4a37-b4f7-7b0328884943	S038	P005-2	c2	Use “If-Then” Planning to Feel Prepared\\nUncertainty is painful during crisis. If-Then planning restores a sense of readiness.\\n👉 Example: “If I feel panicky at work, then I will take a 2-minute walk outside.”\\n👉 Write 2–3 If-Then plans for moments you fear.\\n🌱 It’s not about control—it’s about confidence in your ability to respond.\\n🧠 Why it helps: Increases perceived self-efficacy and supports adaptive functioning.	\N	\N	\N	\N	\N	\N	\N	\N
6fc215be-3581-4b99-831b-7552829d7fa3	S039	P005-2	c2	Draw Two Columns: “What I Lost” and “What Remains”\\nAfter shock, your mind naturally focuses on what’s gone. It helps to also name what stayed.\\n👉 In one column, list losses: routine, safety, trust, etc. In the second column, list what remains: skills, people, parts of you.\\n🌱 Do not judge the length of either column. Both are valid.\\n🧠 Why it helps: This balances grief with strength and supports psychological integration.	\N	\N	\N	\N	\N	\N	\N	\N
c45d644c-b217-4709-945d-05ed8e7b3be9	S040	P005-2	c2	Assign a Role to Yourself in the Healing Process\\nRoles offer structure. Even in chaos, you can choose who you want to be now.\\n👉 Examples: “I am the witness,” “I am the one who steadies,” “I am the student of this moment.”\\n👉 Write or say: “My role right now is…”\\n🌱 It can be small but intentional.\\n🧠 Why it helps: Naming a role gives coherence, identity, and direction when those things feel shaken.	\N	\N	\N	\N	\N	\N	\N	\N
f616b15c-dcad-48d8-9e49-1bfd97749818	S041	P005-3	c3	After trauma, the brain’s alarm system—especially the amygdala—can remain overactive. This can make it feel like danger is everywhere, even when you’re safe.\\n\\nPsychoeducation: When we’re under threat, the nervous system shifts into fight, flight, or freeze. After trauma, this system may become overly sensitive. Breathing techniques can signal safety to the brain and body.\\n\\nTry This: Sit quietly, place a hand on your belly, and breathe in slowly for 4 seconds, hold for 4 seconds, and exhale for 6 seconds. Repeat 3 times.\\n\\nExample: If you're startled easily or have trouble sleeping, this kind of breath can help shift your body into rest mode.\\n\\nWhy it helps: This activates the parasympathetic nervous system, quiets the amygdala, and grounds you in the present.	\N	\N	\N	\N	\N	\N	\N	\N
8b6df0f9-4de8-4460-b98f-9b698aa3ad21	S042	P005-3	c3	Even if trauma made you feel powerless, your survival is evidence of your strength. Many strengths stay hidden because we don’t name or claim them.\\n\\nPsychoeducation: Strength-based approaches in therapy focus on what helped you endure, not just what went wrong. This fosters empowerment and resilience.\\n\\nExercise: List 3 challenging times in your life. For each, ask: What got me through? Was it persistence, humor, my ability to plan, or the people I leaned on?\\n\\nExample: 'When I lost my job, I still showed up for my kids—that was responsibility and love.'\\n\\nWhy it helps: Naming strengths helps you reconnect with personal power and fosters a narrative of survival and agency.	\N	\N	\N	\N	\N	\N	\N	\N
f61007ac-37cb-4531-816b-05de011687f0	S043	P005-3	c3	Trauma can leave emotions feeling overwhelming or completely shut down. Rebuilding emotional awareness helps with regulation.\\n\\nPsychoeducation: Emotional granularity is the skill of identifying subtle emotional states. This improves self-understanding and reduces impulsivity.\\n\\nTry This: At least once a day, pause and ask: What am I feeling? (Try using a feelings wheel if needed.) Where do I feel it in my body? What is this emotion asking from me?\\n\\nExample: 'I feel a tight chest and jaw—maybe it’s anger. I need to take a break from this conversation.'\\n\\nWhy it helps: Labeling emotions calms the brain, enhances self-awareness, and supports mindful responses.	\N	\N	\N	\N	\N	\N	\N	\N
7c48a716-3edc-4e62-972e-c01cee674faf	S044	P005-3	c3	Trauma recovery can feel like standing at the bottom of a mountain. The first step often feels the hardest—but it sets everything in motion.\\n\\nPsychoeducation: Behavioral activation (a CBT principle) teaches that even small actions can shift mood and restore hope.\\n\\nTry This: Choose one micro-action today—a shower, opening the window, messaging a friend. Let this be enough.\\n\\nExample: 'I didn’t clean the whole house, but I made my bed. That’s a win.'\\n\\nWhy it helps: Tiny steps reinforce agency, reduce avoidance, and reconnect you to life outside of trauma.	\N	\N	\N	\N	\N	\N	\N	\N
9e6e892f-bc5c-413d-87ce-4df55ab5c001	S104	P005-5	c5	Practice Saying: “That Was Then. This Is Now.” When past experiences still affect how you react today, it can help to gently remind yourself that you’re no longer in the same situation. Practice saying, “That was then. This is now,” when you feel triggered. It can help you feel more in control and reduce fear. If you ever feel unsafe or overwhelmed, we encourage you to speak with a trusted adult or a mental health professional.	\N	\N	\N	\N	\N	\N	\N	\N
301d3e22-f10c-4be8-9f32-ebe49fd88c42	S045	P005-3	c3	Trauma affects the body deeply. Sometimes your body remembers things before your mind does.\\n\\nPsychoeducation: Interoception is your awareness of internal body signals (like heartbeat, breathing, tension). This can be disrupted in PTSD. Rebuilding this awareness helps you better understand your emotional and physical needs.\\n\\nTry This: Do a 3-minute body scan from head to toe. Ask: What do I feel in my head? Neck? Chest? Stomach? Legs? Notice without judgment.\\n\\nExample: 'My stomach feels heavy—maybe I’ve been anxious all day and didn’t realize it.'\\n\\nWhy it helps: This builds self-connection, allows early detection of stress signals, and increases your capacity to care for yourself.	\N	\N	\N	\N	\N	\N	\N	\N
b9c3a6ee-554e-4494-86d8-34aab31a69d0	S046	P005-3	c3	Trauma can fracture your sense of time, making the past feel like it’s still happening. Reclaiming your timeline is one way to begin healing.\\n\\nPsychoeducation: Trauma often disrupts the continuity of autobiographical memory. When you re-place the event in time, you signal to the brain: 'This is over. I survived.'\\n\\nTry This: Write a short timeline of your life using 5–10 major events, including joyful and painful ones. Add the traumatic event in its correct place. Mark a line: 'That was then. This is now.'\\n\\nExample: If your trauma happened at age 17, you might add: 'Started college at 19. Got my first job at 21.'\\n\\nWhy it helps: This anchors the event in the past and strengthens your orientation to the present.	\N	\N	\N	\N	\N	\N	\N	\N
d8285032-3131-4110-b662-2bf93283236b	S047	P005-3	c3	After trauma, life can feel empty or meaningless. Finding or creating meaning is often a turning point in recovery.\\n\\nPsychoeducation: Viktor Frankl and others have shown that meaning-making is a central human drive, especially after suffering. It can emerge from values, service, creativity, or connection.\\n\\nTry This: Reflect on the question—What do I want to stand for despite what happened to me? You can write, draw, or speak your answer. Even a small act aligned with this can create momentum.\\n\\nExample: 'Even after the trauma, I still care about helping others—so I started volunteering again.'\\n\\nWhy it helps: It reconnects you with purpose and breaks the freeze of helplessness.	\N	\N	\N	\N	\N	\N	\N	\N
e587a9ea-cd4c-46c0-8c0c-4c57156ad7ff	S048	P005-3	c3	When words feel overwhelming, creating a trauma narrative in steps can help you process safely.\\n\\nPsychoeducation: Writing in phases—starting with neutral facts—can allow the brain to integrate the memory without becoming overwhelmed.\\n\\nTry This: Step 1 – Write just the who, what, when, and where. Step 2 – Add physical reactions. Step 3 – Add emotions. Step 4 – Add what you wish you’d had or needed.\\n\\nExample: 'I was in my room when it happened. My heart was pounding. I felt trapped. I wish someone had knocked on my door.'\\n\\nWhy it helps: Stepwise exposure helps refile the memory as past, not current threat.	\N	\N	\N	\N	\N	\N	\N	\N
988237cc-7ea1-4ae1-9362-2386f06b7c31	S049	P005-3	c3	Trauma can rob you of your identity. Rebuilding it is an act of self-reclamation.\\n\\nPsychoeducation: Identity disruption is common in PTSD. You may no longer recognize yourself—or feel defined by what happened.\\n\\nTry This: List roles or parts of yourself that existed before the trauma (e.g., friend, athlete, artist). Choose one to reconnect with this week. Ask: What did this part love? What made it feel alive?\\n\\nExample: 'Before it happened, I used to sing. I’ll try humming to a song I used to like.'\\n\\nWhy it helps: Reclaiming identity restores continuity and combats the “I am broken” narrative.	\N	\N	\N	\N	\N	\N	\N	\N
8d362ce2-1536-4c1e-89dc-6bfe42dfea29	S050	P005-3	c3	One of the most powerful ways to heal is to contribute, even in small ways, to someone else’s healing.\\n\\nPsychoeducation: Peer support, storytelling, and mutual aid are all trauma-informed tools shown to reduce isolation and increase meaning.\\n\\nTry This: Share something that helped you—like a quote, technique, or song—with someone else who might need it. Even if it’s anonymous.\\n\\nExample: 'I sent my friend a breathing exercise that helped me. It felt good to pass it on.'\\n\\nWhy it helps: Giving reframes you as not just someone who was hurt, but someone who helps. This activates dignity, connection, and agency.	\N	\N	\N	\N	\N	\N	\N	\N
365ac566-e54e-44b5-94de-a6815b6c390b	S051	P005-3	c3	Sometimes your body reacts before your mind catches up. That racing heart, those tight shoulders, the feeling like something terrible is about to happen? It's your nervous system still doing its job—trying to protect you, even when the danger is long gone. Try saying to yourself: “This is my body trying to keep me safe. But right now, I am safe.”\\nOne helpful practice is to name what you’re feeling as it comes up: “This is fear,” or “This is tension in my chest.” That simple naming helps you step out of the storm and recognize that it’s a memory, not the present.\\nWhy it helps: It brings the brain and body back into sync, helping you feel more in control.	\N	\N	\N	\N	\N	\N	\N	\N
9f6d5156-cf1b-42e1-b933-881853b6fb2f	S052	P005-3	c3	After trauma, finding even one thing that makes you feel safe can make a huge difference. It might be a person, a memory, a scent, or an object. That “anchor” can help you stay grounded during waves of distress.\\nTry this: Think of one thing—just one—that brings a tiny sense of calm. A soft blanket, a friend’s voice, a song. When you're overwhelmed, go to that anchor and let yourself settle there for a moment.\\nWhy it helps: Having a go-to comfort cue builds a sense of predictability and safety in your nervous system.	\N	\N	\N	\N	\N	\N	\N	\N
0f9228cd-3ae0-46fa-b321-ac008fbe4444	S053	P005-3	c3	You are stronger than you think—but not in the way people usually say. Strength doesn’t mean “being fine.” It means getting through. It means getting out of bed even when it’s hard. It means feeling afraid and still showing up.\\nTake a moment to list moments of strength you’ve shown—quiet ones. Then pick one and say it aloud: “I was strong when I __.”\\nWhy it helps: Naming your resilience reclaims your story from the trauma.	\N	\N	\N	\N	\N	\N	\N	\N
471e88e5-acec-4b0f-8f6d-c5d024f13794	S054	P005-3	c3	Feeling safe again is a process, and it starts by noticing what already helps. Think of moments or people that have made you feel just a little more okay. Try making three lists: (1) People I feel safe with, (2) Places I breathe easier in, (3) Things I do that help me settle.\\nKeep these visible—a safety map for your day-to-day.\\nWhy it helps: Trauma makes the world feel unsafe. Building a custom safety list gives you something real to hold onto.	\N	\N	\N	\N	\N	\N	\N	\N
583b5ee2-22c7-4a2a-94fe-421f6ddde183	S055	P005-3	c3	When everything feels too much, try starting small. Healing doesn’t have to be loud or fast. Sometimes it’s just sending a message. Making tea. Breathing on purpose.\\nWhat matters is that you’re choosing—taking a step, even a tiny one, toward life.\\nToday, pick one small thing that connects to who you are or what you care about. Then remind yourself: “I’m still moving.”\\nWhy it helps: Small actions lead to big shifts, and every time you act, you prove to yourself: I am not stuck.	\N	\N	\N	\N	\N	\N	\N	\N
dd302aac-eba5-4663-8ab2-3c5b46c072b6	S056	P005-3	c3	Your story didn’t end with what happened. You’re still here—and every day you are shaping the next chapter. When trauma takes over, it can feel like time stopped. But you have the power to start a new timeline. One powerful way to do this is to write out a personal “healing timeline” starting from today. Include small but meaningful milestones you've already reached, like asking for help or talking about what happened. Then add hopes for the future—like reconnecting with someone you care about or feeling calm again. This practice can help you take back agency and see that healing is already underway.	\N	\N	\N	\N	\N	\N	\N	\N
d1dbcee4-9771-4bea-8389-b637e32b1b26	S057	P005-3	c3	Trauma often brings the question, “Why did this happen?” While that question may not have a clear answer, many people find strength by creating meaning in how they respond. This isn’t about justifying the trauma—it’s about reclaiming your power. You can start by completing the sentence: “Even though this happened, I will…” For example, “I will care more deeply,” or “I will protect others.” It’s about defining your direction, on your own terms. Finding meaning like this helps transform pain into purpose.	\N	\N	\N	\N	\N	\N	\N	\N
1449e276-2d32-4e41-a494-0f21639cf235	S058	P005-3	c3	Not every feeling has words. Sometimes the pain is stored deep in the body, and it helps to express it through other channels. Creative activities like drawing, music, photography, or movement can allow your nervous system to release what it’s been holding. You might create a picture of what safety feels like, or a song that mirrors your emotions. These are ways to process trauma without needing to explain everything out loud. Creative expression helps you feel understood—even by yourself.	\N	\N	\N	\N	\N	\N	\N	\N
3f5d9a24-4065-4d6e-ac36-02ea08ecbfb8	S059	P005-3	c3	Trauma can make you feel like you've lost yourself. You might ask, “Who am I now?” But even in pain, parts of you have stayed steady. One helpful exercise is to write a list called, “The parts of me that remain.” These might include things like, “I still notice kindness,” “I still love music,” or “I still keep going.” This list helps you reconnect with your identity and see that your core self is still there, waiting to be rebuilt.	\N	\N	\N	\N	\N	\N	\N	\N
2ea0ef54-be05-469d-9e6f-39b982a6f1a0	S060	P005-3	c3	Trauma often makes people feel disconnected or powerless. One powerful way to reconnect is through helping others—even in small, safe ways. You don’t have to be fully healed to offer support. You might text a friend who’s struggling, help with a task at home, or simply listen to someone. These moments remind you that you have something to offer. Helping others can rebuild your sense of connection, value, and strength.	\N	\N	\N	\N	\N	\N	\N	\N
1b148fb6-9aea-4b3e-9407-171c0c1ef130	S061	P005-3	c3	Practice Feeling in Steps, Not All at Once. If you’ve been avoiding painful memories or feelings, it’s okay to go slow. You don’t need to face everything all at once. Try setting a timer for just 2–3 minutes to sit with one emotion—like sadness or fear—then shift to something grounding, like touching a textured object or focusing on your breath. Why it helps: This “pendulation” technique (moving between distress and safety) comes from somatic therapy and helps train your brain that you can feel emotions without being overwhelmed.	\N	\N	\N	\N	\N	\N	\N	\N
d82c8030-3600-4035-b690-9e4eb4976ffa	S062	P005-3	c3	Use “What Now?” Instead of “Why Me?”. After trauma, it’s natural to ask “Why me?” But that question can trap you in guilt or confusion. Instead, try asking, “What now?” This reorients you toward possibility. What values do you still hold? What steps might move you toward healing, connection, or peace? You don’t need all the answers—just the next right step. Why it helps: Shifting to a forward-looking mindset increases resilience and creates a sense of momentum.	\N	\N	\N	\N	\N	\N	\N	\N
b1c369d4-6dc1-4e58-bfd5-0187713fd2fb	S063	P005-3	c3	Create a Ritual to Mark What You’ve Been Through. You might feel like what happened to you is invisible to others. One way to validate your experience is to create a private or shared ritual that acknowledges what you’ve lived through. Light a candle, write a letter, create a piece of art, or spend time in nature with intention. Let the ritual honor your strength and grief. Why it helps: Rituals give structure to loss and healing, and they help you reconnect with your own meaning-making process.	\N	\N	\N	\N	\N	\N	\N	\N
4d8e2557-7f5c-4412-8cb8-6af7c63140cb	S064	P005-3	c3	Learn to Track Your Window of Tolerance. The “window of tolerance” is your nervous system’s range for handling stress. When you’re outside it, you may feel numb, dissociated, or hyper-alert. Start by noticing your cues—do you clench your jaw when overwhelmed? Do you zone out? Then make a personal plan for returning to the window: breathing, stretching, drinking water, or connecting with someone. Why it helps: This builds body awareness and helps prevent emotional spirals.	\N	\N	\N	\N	\N	\N	\N	\N
49a5f61f-d0b0-452b-9fd6-eff4eba766c2	S065	P005-3	c3	Choose One Guiding Word for Your Healing. When the healing journey feels overwhelming, one simple grounding practice is to choose a “guiding word” that represents your direction. It might be “peace,” “strength,” “belonging,” or “clarity.” Write it down, place it somewhere visible, and return to it when you feel lost. Let it be your lighthouse in dark moments. Why it helps: This activates motivation and connects healing to something deeply personal and chosen.	\N	\N	\N	\N	\N	\N	\N	\N
852b7144-6233-4c60-9048-5d31ce85e59f	S066	P005-3	c3	Anchor Yourself to the Present with a Personal Object. When flashbacks or overwhelming thoughts pull you into the past, a small object can help bring you back. Choose something that feels safe and grounding—like a smooth stone, a photo, or a piece of fabric. Keep it with you and touch it when needed. Tell yourself, “This is now. I’m here. I’m safe.” Why it helps: This taps into sensory grounding and the brain’s ability to associate safety with concrete signals. It helps regulate the nervous system.	\N	\N	\N	\N	\N	\N	\N	\N
012e5a5d-4cd7-4e80-aa13-693fe5554b9a	S067	P005-3	c3	Make a “Triggers & Tools” Chart. When you start to understand your personal trauma triggers, you can begin to respond with choice instead of fear. Create two columns: (1) “Triggers” and (2) “Tools that Help.” For example, if loud noises are a trigger, tools might be noise-canceling headphones or deep breathing. Keep updating your list as you learn what helps. Why it helps: Builds a sense of control and mastery over symptoms while reinforcing personalized coping strategies.	\N	\N	\N	\N	\N	\N	\N	\N
a3d654ca-4fa5-4c8a-a052-a0786773fb3e	S068	P005-3	c3	Reconnect with Safe Touch and Movement. Trauma often disrupts your relationship with your body. Gentle, intentional movement—like stretching, rocking, or swaying—can begin to rebuild trust. You can also try self-soothing touch: placing your hand over your heart, or wrapping yourself in a blanket. These are ways to send signals of safety to your brain. Why it helps: Reconnects the body and mind, helps regulate the vagus nerve, and fosters embodied healing.	\N	\N	\N	\N	\N	\N	\N	\N
aef1279a-65f6-454d-95d3-7de9635692c1	S069	P005-3	c3	Write the Story You Want Your Body to Tell. Sometimes our bodies keep the memory of trauma even when our minds try to move on. Try journaling from the perspective of your body: “Dear mind, here’s what I want you to know…” Then switch perspectives: “Dear body, here’s what I’ve been trying to protect you from.” This helps integrate memory, emotion, and body wisdom. Why it helps: Supports emotional processing, self-compassion, and integration between cognitive and somatic experience.	\N	\N	\N	\N	\N	\N	\N	\N
e7dad7e7-a1dd-426b-b6ef-41c25b36d128	S070	P005-3	c3	Rebuild a Sense of Safety in Spaces You Use Often. Trauma can make once-familiar places feel unsafe. Choose one small space (like your bedroom, car, or desk) and intentionally turn it into a safe zone. Add soft textures, calming scents, comforting images, or affirmations. Let your nervous system learn, “This is my space. I am safe here.” Why it helps: Environmental control supports psychological safety and gives daily opportunities for nervous system repair.	\N	\N	\N	\N	\N	\N	\N	\N
54eaa0ef-d847-46b8-ae54-369479b04844	S071	P005-4	c4	Rebuild Emotional Safety with a Daily Grounding Ritual\\nComplex trauma can leave a person feeling unsafe in their own body or daily life, even when nothing threatening is happening. This is not your fault—it's a natural response to prolonged stress and emotional injury. One way to begin restoring a sense of safety is through consistent, calming routines.\\nTry this: Choose a predictable time each day (for example, just after waking or before bed). During this time, take three to five minutes to pause, breathe slowly, and notice your physical environment. Feel your feet on the ground. Pay attention to a color or object in the room. Say to yourself:\\n“I am here right now. I am safe enough in this moment.”\\nOver time, this simple act helps teach the nervous system that not every moment is dangerous. It's okay if this feels strange or difficult at first—reclaiming safety is a gradual process.\\nIf the sense of unsafety feels too overwhelming, please consider reaching out to a trauma-informed therapist who can help you strengthen this skill with support.	\N	\N	\N	\N	\N	\N	\N	\N
52b14547-8f87-44f1-86ca-6d0957699e7b	S072	P005-4	c4	Write the Letter You Needed and Deserved\\nMany people with complex trauma carry pain from things that were never said to them—words of comfort, protection, or validation that should have been spoken but never were. These silent wounds can shape self-worth and inner dialogue.\\nThis exercise invites you to reclaim some of that space. Find a quiet moment to write a letter from the caregiver, protector, or adult you needed.\\nWhat would they say to the younger you?\\nWhat would they say to the current you, navigating healing?\\nLet the words be kind, firm, or sorrowful—whatever feels honest and healing.\\nThis is a powerful self-compassion practice and a way to care for parts of yourself that were neglected or harmed.\\nIf painful emotions arise, know they are welcome—but you don’t have to hold them alone. A mental health professional can guide you through this process with care and safety.	\N	\N	\N	\N	\N	\N	\N	\N
025156f4-281b-4da9-8e23-865952e6c091	S073	P005-4	c4	Notice When You “Disappear” and Begin to Reclaim Presence\\nDissociation is a common and understandable response to chronic trauma. It may show up as zoning out, emotional numbness, memory gaps, or a floating feeling—especially in stressful situations. Rather than seeing this as something “wrong,” it’s helpful to view dissociation as your brain’s way of protecting you from overwhelm.\\nBegin by gently noticing when you lose presence. Ask yourself:\\n– What situation was I in when I disconnected?\\n– What was I feeling just before?\\n– What helped bring me back?\\nYou might carry a small object—a stone, piece of fabric, or scent—that you can touch when you're feeling out of body. This helps ground your senses.\\nThis isn’t about forcing yourself to stay present in all moments, but about developing gentle awareness and self-compassion when it happens.\\nIf dissociation becomes distressing or interferes with daily life, therapy can offer safe ways to reconnect with your body and experience.	\N	\N	\N	\N	\N	\N	\N	\N
16b2d01b-4fc3-4c3a-a31a-3f0a70d3d36e	S074	P005-4	c4	Track Triggers with Gentle Curiosity, Not Judgment\\nLiving with complex trauma often means that certain sounds, places, phrases, or body cues can trigger emotional flashbacks. These aren’t always obvious, and the reaction may feel out of proportion to what’s happening.\\nOne way to make sense of your inner world is by tracking your triggers over time.\\nUse a private journal to answer these questions when something intense happens:\\n– What just occurred, externally and internally?\\n– What feelings or thoughts showed up?\\n– What memory or meaning might be connected?\\n– What would have helped me feel safer or more supported in that moment?\\nThis kind of reflection turns triggers into teachers. It’s a way to understand what your body and brain are still carrying.\\nBut please remember: you are not alone in this. If these patterns are confusing or painful, a trauma-informed therapist can walk beside you as you build understanding and safety.	\N	\N	\N	\N	\N	\N	\N	\N
107e4bf7-88ee-4514-8b9a-5de045764206	S075	P005-4	c4	Reconnect with Your Identity Through “Anchoring Statements”\\nWhen trauma is layered, ongoing, or tied to our early development, it can blur the sense of self. You may find yourself asking, “Who am I, really?” or shifting your personality to feel safe in different environments. This is a protective survival strategy—but it can also feel disorienting.\\nTry this practice: Write down three truths about yourself that remain consistent, regardless of how others treat you or what role you are in.\\nExamples:\\n– “I have always tried to protect others.”\\n– “I notice beauty, even in small things.”\\n– “I care deeply, even when I hide it.”\\nRepeat these truths aloud to yourself each morning. Place them somewhere visible. These anchoring statements help stabilize your identity and foster self-acceptance.\\nHealing the sense of self is deep work. If you feel lost in this journey, a mental health professional can help you reconnect with your most authentic self at a safe pace.	\N	\N	\N	\N	\N	\N	\N	\N
d518df59-8e7c-4ffc-8dd0-0a5c277cba00	S076	P005-4	c4	Use a Daily "Safety Check-In" to Rebuild Trust in the Present. When someone has lived through complex trauma, the body and mind often stay on high alert—even when danger is no longer present. One way to help rebuild a sense of safety is to create a small daily ritual that gently reminds your system: “Right now, I’m safe enough.” At a regular time each day (morning, before sleep, or after a meal), pause and ask yourself: What tells me I am physically safe right now (a locked door, calm surroundings)? What tells me I am emotionally safe (no one criticizing me, I can speak freely)? What might help me feel safer in this moment, even a little? You can say these answers out loud or write them down. Over time, this helps your nervous system begin to separate past danger from present safety. If this feels hard or confusing, it’s not a failure—it’s a sign you might benefit from trauma-informed support to guide you safely.	\N	\N	\N	\N	\N	\N	\N	\N
0a2aa6fc-3d3a-4543-ad38-cc46322e38ef	S077	P005-4	c4	Create a “Who I Am” Journal to Anchor Your Identity. Complex trauma can blur or even erase a person’s sense of identity, especially when survival meant becoming who others needed. A powerful healing step is to reclaim who you are—on your own terms. Start a small journal and explore: What colors, music, or foods do I actually enjoy? What values matter to me—kindness, honesty, creativity? When have I felt like my most real self? This is not about having all the answers. It’s about slowly, safely reconnecting to the self that trauma tried to suppress. If this process feels too difficult or unclear, working with a therapist can help you make sense of it at your own pace.	\N	\N	\N	\N	\N	\N	\N	\N
0aa775a7-d2fe-4984-921e-755c59fb0332	S078	P005-4	c4	Make a Map of Relationships: Past and Present. When trauma involves relationships, especially over a long period of time, it can leave deep confusion about trust, love, and safety. One way to begin making sense of it is to map it out visually. Draw a circle and place the people from your past and present into it—those who hurt you, helped you, confused you. Use different symbols or colors if you like. Then reflect: What did I learn about connection from these people? Which beliefs or patterns do I want to keep—or let go of? This map becomes a way to reclaim choice and awareness in your current relationships. It may stir strong feelings, and if it does, a professional can help guide you in processing them safely.	\N	\N	\N	\N	\N	\N	\N	\N
0e0a6423-4fb4-4772-ac18-f5cc5144e591	S079	P005-4	c4	Understand Your Nervous System with the “Window of Tolerance.” If your emotions feel unpredictable—rushing in or shutting down—you’re not broken. That’s your nervous system doing its best to protect you. Learning about the “Window of Tolerance” can help. Imagine three zones: High (panic, anger, racing mind), Low (numbness, fatigue, disconnection), and Middle (calm, focused, present). Begin gently checking in with yourself during the day: Where am I right now? What nudges me closer to center? This is not about controlling your emotions—it’s about understanding them. Over time, this awareness can help you feel more stable and safe. A trauma-informed therapist can support you on this journey.	\N	\N	\N	\N	\N	\N	\N	\N
8c9e8e66-37af-4a14-b4e3-36e0c89c7325	S080	P005-4	c4	Plant One Small Act of Power Each Day. One of the most painful parts of complex trauma is the loss of agency—the sense that you had no voice or choice. Healing includes reclaiming that voice, even in small ways. Each day, ask yourself: What is one thing I can do today that shows I matter? It might be saying “no,” choosing your clothes with intention, writing a journal entry, or advocating for yourself or someone else. These acts may seem small, but they are powerful reminders that you still have strength, purpose, and direction. If this feels difficult, you don’t have to do it alone. A therapist can help you rediscover these moments of agency.	\N	\N	\N	\N	\N	\N	\N	\N
80ce64dc-baef-47bb-9ed4-d1ced4f4940d	S081	P005-4	c4	Reflect on Moments That Shaped You. Complex trauma can make it hard to understand how the past has influenced who you are today. Instead of diving into painful memories, try this: Think of three moments from your life—any age—that stand out to you. They don’t have to be traumatic. They might be moments when you made a decision, felt something strongly, or learned something about yourself. Write a few words or draw something for each one. Ask: What did this moment show me about myself? What strengths helped me get through it? This gentle reflection can help you feel more connected to your story in a way that honors your growth. If you want to go deeper, consider doing this with a therapist who can support the process.	\N	\N	\N	\N	\N	\N	\N	\N
bc1b440c-1c79-4300-8c5d-05d170e26c50	S082	P005-4	c4	Build a “What’s Real Now” List to Anchor in the Present. Complex trauma can keep you reliving moments that no longer match your current life. When that happens, grounding in what’s real now can offer a lifeline. Each morning or evening, write down 3–5 facts that affirm your current safety or growth: I have a safe place to sleep. I set a boundary yesterday. I am learning who I am. This isn’t denial of the past—it’s a daily practice of reminding your brain and body that things are shifting. It trains awareness to include not just danger, but progress. If this feels hard to believe at first, that’s okay. Just the act of looking for truth in the present is part of healing.	\N	\N	\N	\N	\N	\N	\N	\N
3d8a23bb-38f0-4aad-9e46-069bbb60f977	S083	P005-4	c4	Design a “Resilience Roots” Poster. You are more than what happened to you. And yet, trauma can shrink our sense of self until all we see are the scars. Reclaim your wholeness by creating a “Resilience Roots” visual. Draw a tree: the roots represent your strengths, skills, and supportive people. The trunk is what keeps you going. The branches are hopes or goals. Even if it’s messy, it’s real. Look at this poster when you feel small or overwhelmed. You are built on more than pain. This practice not only boosts self-worth but also reminds you that growth is possible—even after long darkness.	\N	\N	\N	\N	\N	\N	\N	\N
1f2a6753-f073-49ec-a912-484495bfb500	S084	P005-4	c4	Practice “Self-Talk Rewriting” with Compassion. Many trauma survivors live with internal voices shaped by judgment, fear, or others’ cruelty. These voices are not your truth—but they may feel real. Begin noticing one harsh thought a day (e.g., “I’m broken,” “No one will ever get me”). Then pause, and ask: If someone I loved felt this, what would I tell them? Write down that gentler response. Say it out loud if you can. Over time, this helps create new neural pathways that support self-compassion. And if the old voice feels louder some days, that’s normal. Be patient. You’re not erasing the past—you’re building a new way to relate to yourself.	\N	\N	\N	\N	\N	\N	\N	\N
5d490bf7-8161-44b4-a494-8b7e68591c14	S085	P005-4	c4	Begin a “Resource and Ally Map.” Healing from complex trauma isn’t a solo journey. Even if people have let you down in the past, it’s possible to build a network of support. On a sheet of paper, write down names of people, services, or groups that offer even a small sense of safety or respect. This could include a friend, a trauma-informed therapist, a support group, or even a podcast or book that helps you feel less alone. Notice what’s missing too—and let that guide what you seek. Mapping your resources helps shift focus from isolation to connection. If this feels overwhelming, start with just one name. Healing relationships are built one safe connection at a time.	\N	\N	\N	\N	\N	\N	\N	\N
93337889-331a-457f-acb0-8536ea79b9c2	S086	P005-4	c4	Reclaim Your Nervous System’s Rhythm Through Gentle Movement. When we live through trauma, our body may lose its natural rhythm—stuck in tension or collapse. Begin noticing your energy levels during the day. Choose a gentle movement that meets your state: a slow walk when anxious, a stretch when frozen, dancing if you have extra energy. These are not workouts—they're ways to tell your body: I’m listening. Over time, you’re retraining your system to feel safe moving through states. If movement feels unsafe, talk with a trauma-informed therapist who can guide you carefully.	\N	\N	\N	\N	\N	\N	\N	\N
37deb986-69dc-4309-a649-4d2af0abb3ef	S087	P005-4	c4	Use Sensory Anchors to Create Safety in the Now. Trauma often disconnects us from our body or makes it feel like a threat. You can begin to reclaim it gently, through sensory safety. Choose one sense: sight, touch, smell. Ask yourself—what soothes me here? It might be a warm blanket, soft light, or lavender. Create a sensory corner in your space. Use it daily, especially after distress. This is not just comfort—it's rewiring your nervous system to pair the present with peace. For deeper somatic work, a therapist can support re-embodiment.	\N	\N	\N	\N	\N	\N	\N	\N
71841188-0acf-447a-9686-d10fff21a197	S088	P005-4	c4	Practice “Parts Mapping” to Understand Your Inner Conflicts. If you’ve ever said, “A part of me wants to hide, and another part wants to speak up,” you’re already doing parts work. Trauma often fragments us—each part holding pain, protection, or potential. Try drawing or listing the different “parts” of you that show up in stress. Give each a voice. What are they trying to do for you? This isn’t pathology—it’s self-awareness. Over time, this practice builds inner harmony and reduces shame. If it feels too confusing, parts-based therapy can help make sense of it all.	\N	\N	\N	\N	\N	\N	\N	\N
7e09791b-0849-4793-821f-62cf9864acda	S089	P005-4	c4	Use Imagery to Create a Safe Inner Place. Trauma can leave us feeling like there’s no safe place anywhere. Guided imagery offers a way to build one inside. Close your eyes and imagine a place—real or imaginary—where you feel calm, protected, and fully yourself. It could be a forest, a room, even a planet. Add sensory details. Practice going there mentally when distressed. This safe place can become your mental shelter during storms. If it’s hard to visualize, working with a therapist trained in EMDR or SEE FAR CBT can help create this space together.	\N	\N	\N	\N	\N	\N	\N	\N
ae41ea7a-6f46-43b0-b141-c84dd70d3cf9	S090	P005-4	c4	Begin a “Needs Translation” Practice. Survivors of trauma often carry unmet needs—without words for them. When you feel agitated or shut down, ask gently: What is this part of me needing right now? Is it safety, comfort, clarity, connection? Even if no answer comes, the act of asking builds internal trust. Over time, this helps you make choices that nourish instead of just surviving. For help decoding deep needs, therapy can offer a safe container.	\N	\N	\N	\N	\N	\N	\N	\N
35e616e0-5c25-4073-8acd-232fe5bc21fc	S091	P005-4	c4	Build a “Safe People Map.” When relationships have been unpredictable or hurtful, it can be hard to know who feels safe now. Try mapping your current connections. Start with people who help you feel grounded—even if you don’t talk often. Then add people who offer support, even just in small ways. You’re looking for quality, not quantity. The act of mapping reminds you that safety is possible. If trust is hard, therapy can help explore why, and how to slowly rebuild it.	\N	\N	\N	\N	\N	\N	\N	\N
95f2ac60-ecad-41e3-b635-338178f09510	S092	P005-4	c4	Practice the “Window of Tolerance” Check-In. Trauma can shrink or stretch your ability to handle stress. The “window of tolerance” is the zone where you feel alert but not overwhelmed. Each day, check in: Am I inside my window? Or outside—too anxious or too numb? Learning to notice (without judgment) helps you choose tools to return to balance. Over time, you’ll feel more in control. A trauma-informed therapist can help widen your window safely.	\N	\N	\N	\N	\N	\N	\N	\N
0d620041-ed8f-4baf-8282-47137f496f61	S093	P005-4	c4	Use “Then vs. Now” to Reduce Emotional Flashbacks. Sometimes a present moment triggers old feelings. You may react with intensity that doesn’t match the situation. Pause and gently ask: Am I responding to now—or to something from back then? Grounding in the present moment (naming the date, where you are, who you're with) can shift your nervous system from reactivity to reality. Over time, this practice helps separate past from present. If flashbacks are frequent, therapy can provide safer processing.	\N	\N	\N	\N	\N	\N	\N	\N
2894237f-0051-4a4a-9a56-e2da1069719c	S094	P005-4	c4	Try “Values Journaling” When You Feel Stuck. Trauma can make it hard to know what you want—survival takes up all your energy. Once a week, set aside time to write about what matters to you. Not goals, but values: kindness, truth, creativity, safety, etc. Ask: Where have I lived this value, even a little? What’s one step I can take this week to express it again? This reconnects you to who you are underneath the pain. A therapist can help clarify values and translate them into healing actions.	\N	\N	\N	\N	\N	\N	\N	\N
58fd3162-4b59-461c-bcbc-2df983203851	S095	P005-4	c4	Track Patterns Without Self-Blame. Survivors of trauma often repeat emotional patterns—not because they’re broken, but because the brain adapts to danger. Try tracking a recurring pattern (e.g., pulling away when someone gets close). Look at it with curiosity, not shame. What might this pattern have protected you from in the past? What would healing this pattern make possible? Insight grows slowly. Support from a compassionate professional can help break the cycle.	\N	\N	\N	\N	\N	\N	\N	\N
80af08cd-077a-4ed2-975c-92990f011c82	S096	P005-4	c4	Use Gentle Time Travel to Reduce Self-Blame. Survivors of trauma often carry guilt or shame for things they had no control over. One way to shift this is to imagine your current self going back in time to speak to your younger self during a difficult moment. What would you say? What would you want that younger version of you to know? This can create emotional distance and compassion. If strong emotions come up, pause and return to the present. A therapist can help guide this process gently.	\N	\N	\N	\N	\N	\N	\N	\N
22cdc4f9-9484-4f49-8ee6-18b113fafec6	S097	P005-4	c4	Explore “Protective Parts” With Curiosity. If you’ve ever felt like a part of you is pushing people away or shutting down, that might be a protective part doing its best to keep you safe. Instead of trying to silence it, try thanking it. Ask: What are you trying to protect me from? What do you need? This dialogue helps reduce inner conflict and invites trust. If the part feels overwhelming, parts-based therapy (like IFS) can help create safe inner dialogue.	\N	\N	\N	\N	\N	\N	\N	\N
c13192e5-567c-4a3b-8bc9-2768c0a7dd43	S098	P005-4	c4	Recognize When “Numb” is a Safety Strategy. Sometimes feeling nothing is the brain’s way of protecting us from too much pain. Instead of pushing the numbness away, notice it gently. Ask: What might this numbness be keeping me safe from? What would I need to feel a little more present? Even naming the numbness is a brave step. If it persists or feels too hard to manage, consider speaking to a therapist who understands trauma responses.	\N	\N	\N	\N	\N	\N	\N	\N
b43abf76-3bdd-4e9a-bd1a-e4e368b9139d	S099	P005-4	c4	Use “Small Wins” to Rebuild Trust in Yourself. Trauma can leave you feeling helpless or unsure of your own abilities. To rebuild that sense of agency, start with one small task a day that aligns with your values—like reaching out to someone, organizing something, or taking a walk. After each task, name it: “I did that.” Over time, this builds trust that you can make choices and move forward. If shame or doubt interferes, a therapist can help you reframe those thoughts.	\N	\N	\N	\N	\N	\N	\N	\N
1612c268-d9c5-4440-a031-754682f7dfac	S100	P005-4	c4	Practice Emotional Labeling to Increase Safety. When emotions feel overwhelming or confusing, it can help to slow down and simply name what you're feeling—without needing to fix it. Try saying: “This is sadness.” or “I feel overwhelmed.” Naming emotions activates the thinking part of your brain and helps soothe the alarm system. Over time, this builds emotional regulation. If naming emotions is hard, therapists can help guide you in learning to identify and work with them gently.	\N	\N	\N	\N	\N	\N	\N	\N
e2fb2e25-4a44-46ed-a817-f02dea0d34b1	S101	P005-5	c5	Try Naming One Emotion at a Time. Sometimes when we feel overwhelmed by memories or family stress, everything blends together. Start by asking yourself: “What am I feeling right now?”—even if the answer is just “confused” or “tired.” Naming emotions can help you take the first step in understanding what’s going on inside. If it starts to feel too intense, pause and take a deep breath. You don’t have to solve everything today. If you feel unsafe, please talk to a trusted adult or get support from a mental health professional.	\N	\N	\N	\N	\N	\N	\N	\N
155634c8-7262-4d1b-969b-d8e386f08839	S102	P005-5	c5	Write Down One Memory That Still Bothers You — But Only What Feels Safe to Remember. Choose a memory that’s been lingering, and write just a sentence or two about what happened. You don’t need to go into deep detail. Then write one thing you wish had gone differently, or something you needed at the time. This small act of reflection can help you process your story in a gentle way. If it brings up hard emotions, stop and ground yourself. And if you feel unsafe, please reach out to a trusted adult or professional.	\N	\N	\N	\N	\N	\N	\N	\N
56ef68b0-6c61-4224-92db-8f25c56bf234	S103	P005-5	c5	Create a “Comfort List” of Safe People or Places. Think of three people, places, or objects that help you feel even a little bit calmer or safer. Write them down, draw them, or keep a picture on your phone. In moments of stress, look at this list as a reminder that safety and support are real and reachable. If you don’t feel like you have those supports right now, that’s okay—this is also a sign that it might be time to talk to someone who can help.	\N	\N	\N	\N	\N	\N	\N	\N
aa289b71-7b6f-49b8-b5f2-6fd38f1a3bb5	S105	P005-5	c5	Use the “Five Senses” Technique to Feel Grounded. When emotions run high, try this: Notice 5 things you can see, 4 you can touch, 3 you can hear, 2 you can smell, and 1 you can taste. This simple tool brings you back to the present moment and can calm the body quickly. It’s okay if it doesn’t work right away—practice helps. And if your feelings become too much to handle alone, talk to someone you trust or seek help from a professional.	\N	\N	\N	\N	\N	\N	\N	\N
421c32e1-f928-4336-bab9-a9075034033e	S106	P005-5	c5	Make a Drawing of What Safety Looks Like to You. You don’t need to be good at drawing. Just grab a pen or pencil and sketch what “safe” would look like—maybe it’s a place, a person, a color, or even a shield. This can help you figure out what you need more of in your life. If it makes you emotional, that’s okay. Please remember, if you feel unsafe, talk to a trusted adult or reach out to professional support.	\N	\N	\N	\N	\N	\N	\N	\N
cc5a6d00-3a2d-4405-97cf-2b6ede32f0d1	S107	P005-5	c5	Practice a Breathing Technique You Can Use Anywhere. Try this: Inhale slowly for 4 counts, hold for 4, exhale for 4. Do it 3 times. It helps calm your nervous system. Breathing is something you always carry with you, and it can be a safe anchor during stress. If emotions still feel too big, it’s important to talk to someone you trust or get support from a professional.	\N	\N	\N	\N	\N	\N	\N	\N
413507ab-ca68-473d-80da-723a51a50b68	S108	P005-5	c5	Use Music to Create a Mood Shift. Build two playlists: one that matches your current mood (so you feel seen), and another that slowly moves you toward a calmer or safer place emotionally. Music can express what’s hard to say and help you regulate feelings. If you find yourself stuck in painful feelings, please connect with a safe adult or therapist.	\N	\N	\N	\N	\N	\N	\N	\N
3f87bea3-f7a8-4d06-be55-6c03a62675c7	S109	P005-5	c5	Write a Letter to Your Younger Self. Begin with “You didn’t deserve what happened.” Write to your younger self with kindness, understanding, and encouragement. You don’t need to reread it or share it. The act of writing can help with self-compassion and healing. If this brings up too much pain, pause and ask for support. You don’t have to carry this alone.	\N	\N	\N	\N	\N	\N	\N	\N
324fa8d8-319c-465d-9484-26dab99f1342	S110	P005-5	c5	Identify One Supportive Adult You Can Talk To. Think of a teacher, family member, counselor, or neighbor who feels safe. Practice what you might say to them: “Can I tell you something that’s been bothering me?” You deserve to feel heard. If you don’t feel ready now, that’s okay. Keep this as an option for later. Getting help early makes a difference.	\N	\N	\N	\N	\N	\N	\N	\N
6f8e5938-bced-4e91-97d5-9909328fe7df	S111	P005-5	c5	Start a “Safe Space” Journal. Create a notebook that’s just for you. Use it to write or draw moments when you felt okay, supported, or less alone—even if they were small. This helps your brain notice safety and start building a sense of trust. If writing feels hard, you can just write one word or a doodle. Please remember, if you’re feeling unsafe now, talk to a trusted adult or seek professional help.	\N	\N	\N	\N	\N	\N	\N	\N
a24d77ba-c58a-4a48-9d2d-cafeba32fd12	S112	P005-5	c5	Use a “Stress Thermometer” to Track Your Feelings. Draw a thermometer with 0 at the bottom (calm) and 10 at the top (extremely upset). During the day, check in with yourself and mark where you are. This can help you notice what triggers your emotions and give you more control. If your “temperature” feels too high, it’s a good time to ask for help.	\N	\N	\N	\N	\N	\N	\N	\N
733554a0-baaf-48ec-90c4-885426d07c0d	S113	P005-5	c5	Make a List of Things That Help You Feel Calmer. Think about music, movement, certain people, pets, or nature. Keep this list nearby when you feel overwhelmed. Knowing what helps you is a strength. You’re not weak for needing support. If those calming tools stop working, please reach out to a therapist or safe adult.	\N	\N	\N	\N	\N	\N	\N	\N
e4c47376-58d6-4d16-8139-86cdbc8afa0e	S114	P005-5	c5	Explore Your Strengths with a “Tree of Me.” Draw or imagine a tree. The roots are your values, the trunk is what keeps you going, and the branches are your dreams. You’ve already survived a lot—this helps remind you that you’re more than what happened. If big feelings come up while doing this, pause and talk to someone you trust.	\N	\N	\N	\N	\N	\N	\N	\N
3014039b-126e-43be-9f7f-1606fdb5cb94	S115	P005-5	c5	Record a Voice Note to Your Future Self. Say something kind, encouraging, or hopeful, even if you don’t feel it yet. Play it back when you’re struggling. It can help you remember that healing is possible. You don’t need to do this alone. If your pain feels heavy, please get support from a counselor or trusted adult.	\N	\N	\N	\N	\N	\N	\N	\N
df2c9d58-3a3e-4584-be45-87a83eef76d1	S116	P005-6	c6	Ground Yourself With the 5-4-3-2-1 Method\\nAfter medical trauma, many people experience intense moments where their body feels like it’s reliving the stress all over again. One technique that can help bring you back into the present moment is called the 5-4-3-2-1 method. Here’s how it works:\\n– Look around and name 5 things you can see (e.g., your hands, a window, a lamp).\\n– Notice 4 things you can touch (e.g., your shirt, the chair, the floor).\\n– Focus on 3 things you can hear right now (e.g., distant traffic, birds, your own breath).\\n– Identify 2 things you can smell (or recall smells you like if none are present).\\n– Finally, identify 1 thing you can taste (or imagine a favorite flavor).\\nThis method gently brings your attention to your body and environment, helping you feel safer.\\nWhy it helps: Grounding interrupts dissociation and re-regulates the nervous system.	\N	\N	\N	\N	\N	\N	\N	\N
a3979a7e-3ad8-4db9-a503-153f2c0722e8	S117	P005-6	c6	Use Visualization to Create a Safe Inner Place\\nMedical trauma often leaves people feeling exposed or out of control. One way to calm the nervous system is to use guided imagery. Try imagining a place—real or imagined—where you feel completely safe. It might be a forest, your grandmother’s kitchen, a sunny beach, or even a cozy library. Picture the colors, the textures, the sounds. Let yourself stay there mentally for a few minutes. You can return to this place anytime you feel overwhelmed.\\nWhy it helps: Visualization offers an internal anchor and supports emotion regulation.	\N	\N	\N	\N	\N	\N	\N	\N
64fe3bae-d54c-46f7-b7af-c69b817e3bf0	S118	P005-6	c6	Reclaim Your Sense of Control With Small Choices\\nDuring hospitalization or treatment, many people feel like decisions are made for them. This can cause a lingering sense of helplessness. One way to rebuild your sense of agency is through small daily choices. Start with low-stakes decisions:\\n– Choose what to wear based on comfort and preference.\\n– Pick a meal or snack that makes you feel nourished.\\n– Decide whether you want to be alone or talk to someone.\\nThese may seem small, but they reinforce the message that your voice matters again.\\nWhy it helps: Builds autonomy and counters learned helplessness after trauma.	\N	\N	\N	\N	\N	\N	\N	\N
6ae0a69c-76a7-4cbd-81c9-17b398c408c5	S119	P005-6	c6	Breathe With Intention: The 4-2-6 Technique\\nYour breath is a powerful tool for calming the body. When you’re feeling triggered or anxious after medical trauma, try this simple pattern:\\n– Inhale through your nose for 4 seconds.\\n– Hold the breath for 2 seconds.\\n– Exhale slowly through your mouth for 6 seconds.\\nDo this for a few minutes while sitting comfortably. This signals to your body that it is safe now.\\nWhy it helps: Activates the vagus nerve and reduces the stress response.	\N	\N	\N	\N	\N	\N	\N	\N
09bd0f2e-083a-4b2d-a930-e1554127e7fe	S120	P005-6	c6	Reframe the Narrative: What Comes After Survival?\\nMedical trauma can leave people stuck in a cycle of fear, replaying what went wrong. But healing also includes writing the next chapter. Ask yourself:\\n– What helped me get through that difficult time?\\n– What parts of me showed strength, even if no one saw it?\\n– What do I want to carry forward—and what do I want to let go of?\\nYou could write a journal entry, record a voice note, or share it with someone you trust.\\nWhy it helps: Strengthens identity and supports post-traumatic growth.	\N	\N	\N	\N	\N	\N	\N	\N
7c454c00-42ea-40c9-a147-5399b8217bed	S121	P005-6	c6	Sometimes your body remembers more than your mind. After medical trauma, even small things—like a smell, a tone of voice, or the flicker of fluorescent light—can bring up fear or tension. Begin gently tracking when you feel uncomfortable or anxious. Ask yourself: What just happened? Where do I feel this in my body? What thoughts came up? You can jot these down in a small notebook or an app. Over time, you may begin to recognize patterns and gently prepare for difficult moments. This helps increase body awareness and supports emotional regulation.	\N	\N	\N	\N	\N	\N	\N	\N
d848660c-ee0a-44c8-823f-0558a38d82ad	S122	P005-6	c6	Create a simple grounding kit for moments when you feel overwhelmed. It might include a soft fabric, a calming scent like lavender or eucalyptus, a small snack, a comforting photo, or a handwritten note from someone who cares about you. You can also include a few index cards with grounding exercises like “5 things you can see, 4 you can touch…” Having something ready to help you reconnect in those intense moments gives a sense of control and safety.	\N	\N	\N	\N	\N	\N	\N	\N
937f1321-43dc-4498-a5c3-6c52d0b43ff4	S123	P005-6	c6	If your heart races or you feel panic in a place that’s technically safe, it doesn’t mean something is wrong with you. After trauma, the brain’s alarm system—the amygdala—can become hypersensitive. It reacts fast, even when there’s no current danger. Gently reminding yourself, “My body is remembering, but I am safe right now,” can help you stay present. Learning how this works can reduce fear and shame. Psychoeducation like this helps restore control.	\N	\N	\N	\N	\N	\N	\N	\N
8e53a5e5-786a-447e-a30f-0d9dfdef7c54	S124	P005-6	c6	Establishing even a simple daily routine can help rebuild a sense of safety after medical trauma. Try creating a basic plan that includes a morning ritual like stretching or tea, a consistent sleep and meal schedule, and time for creativity or quiet. Having predictable steps during your day gives your nervous system a way to settle. It doesn’t need to be perfect—just something you can return to.	\N	\N	\N	\N	\N	\N	\N	\N
9ce02105-f6ac-421a-9f08-7ae0f635d5b1	S125	P005-6	c6	When you feel triggered or overwhelmed, pause and ask yourself with kindness: What just happened? What might I have needed in that moment? What would I say to a friend who felt this way? This practice—called compassionate curiosity—builds emotional safety and softens the self-blame many survivors carry. Over time, it helps you respond to yourself with care instead of criticism.	\N	\N	\N	\N	\N	\N	\N	\N
f9250a66-9fec-4a79-8792-557f115f32e4	S126	P005-6	c6	Visualization can help your body feel safe again. Imagine a place where you feel completely calm and protected—this might be a real location, like your grandmother’s kitchen, or a place you create in your mind. Use all your senses: What do you see, hear, feel, or smell there? Practicing this for just a few minutes a day helps create a “safe space” you can return to when stress hits. This technique is especially helpful before medical appointments or procedures.	\N	\N	\N	\N	\N	\N	\N	\N
8c0fca5d-22f1-49fc-a45a-672eafbe7922	S127	P005-6	c6	Medical trauma can leave you feeling like your voice didn’t matter. One healing step is to practice speaking up again—even in small ways. Start with making a short list of things you need or want from others, like “I need clear explanations,” or “Please don’t touch without asking.” Practicing these sentences aloud helps you reclaim control in interactions with medical staff or even daily conversations.	\N	\N	\N	\N	\N	\N	\N	\N
e1ebd121-425b-47b1-9600-7c75fa86f036	S128	P005-6	c6	Your body needs signals of safety. Try “Vagus Nerve resets” like humming softly, splashing cold water on your face, or slowly exhaling with a “voo” sound. These gentle actions help calm your nervous system by engaging the parasympathetic response. They don’t need to take long, and over time, they train your body to come out of a stress state more quickly.	\N	\N	\N	\N	\N	\N	\N	\N
f55a1141-882e-4c66-9dcd-6361ca51fa98	S129	P005-6	c6	After medical trauma, it can be hard to trust your own body. Try a brief daily check-in: Sit quietly and notice how your body feels—without judgment. Ask, “What do I need right now?” Sometimes the answer is rest, movement, or simply to breathe. Building this body-awareness gently over time helps restore the connection between you and your physical self.	\N	\N	\N	\N	\N	\N	\N	\N
c7e45b0f-00ea-4889-8cf9-8ad7b7f8c5d0	S130	P005-6	c6	Reclaiming a sense of meaning after medical trauma can help you move forward. Consider writing about what you’ve learned from this experience—not to minimize the pain, but to explore how it shaped your strengths, values, or sense of empathy. Ask yourself: “What do I want to carry forward?” and “What do I want to let go of?” Writing for even 10 minutes can help organize thoughts and foster resilience.	\N	\N	\N	\N	\N	\N	\N	\N
de6eadec-a410-4d4b-8605-d3bd2b7ebdee	S131	P005-7	c7	Create a Grief Journal with One Memory Per Page. Writing down memories of the person you've lost—one memory per page—can help you hold onto them while slowly processing the pain. You might write about a time they made you laugh, a phrase they always said, or how they made you feel safe. This keeps the relationship alive in your heart while helping you face your loss at your own pace. 🧠 Why it helps: Writing organizes overwhelming emotions and supports emotional expression. If it becomes too intense, take a break or talk to someone you trust.	\N	\N	\N	\N	\N	\N	\N	\N
05b4facd-55d3-4de5-96ce-e4b6e8a6f1da	S132	P005-7	c7	Use the “Still Connected” Practice. Grieving doesn’t mean forgetting. Try writing a short letter to the person who passed away—maybe telling them about your day, something they’d be proud of, or what you miss. Some people write these in a notebook, others speak them aloud or save them as voice notes. 🧠 Why it helps: This creates a continued emotional connection and allows grief to transform instead of disappear. If it brings up pain that feels too strong, it’s okay to ask for help.	\N	\N	\N	\N	\N	\N	\N	\N
e7df8618-14a1-4967-85fa-1eb4d70e4d8c	S133	P005-7	c7	Make a “Then and Now” Strength Map. Divide a page into two columns. On one side, write down people, places, or actions that helped you feel strong *before* the loss. On the other, write what helps you *now*—even small things like music, journaling, or a pet. 🧠 Why it helps: This helps you see what’s still working, and reminds you that even if things changed, you still have tools to support you. If the right column feels empty, that’s a sign it might be time to ask for support.	\N	\N	\N	\N	\N	\N	\N	\N
df44594d-c5f9-44e2-bdcc-c652d55fad1b	S134	P005-7	c7	Create a Safe Grieving Space. Pick a small space and time just for your grief—a cozy corner, a quiet walk, a candle at night. Let yourself feel whatever comes up, without needing to fix it. Maybe listen to music you shared, cry, or just sit with your memories. 🧠 Why it helps: Having a “container” for grief prevents emotions from becoming overwhelming all day long. If the emotions feel like too much, it's a strong sign you should talk with someone.	\N	\N	\N	\N	\N	\N	\N	\N
86f369d5-843c-4ec3-a3ec-fc5f9bb056df	S135	P005-7	c7	Try Visualization: “Carrying Them With You.” Sit somewhere quiet, close your eyes, and imagine the person you lost walking beside you. Imagine their voice cheering you on as you go through something hard. Picture them giving you a smile or strength. 🧠 Why it helps: This allows you to move forward without feeling like you’re leaving them behind. It helps transform pain into comfort and strength. If the feelings become too intense, pause and share what came up with someone safe.	\N	\N	\N	\N	\N	\N	\N	\N
4cbe9772-5beb-4b3b-b508-9763a8d834b7	S136	P005-7	c7	Use a “Grief Timeline” to Notice Shifts in How You’re Coping. Draw a simple line that represents the past month. Mark dates when your grief felt more intense, and moments (even small ones) that felt lighter. Note any events, memories, or actions that made a difference. 🧠 Why it helps: Grief can feel like you’re stuck in one endless emotion. This timeline shows that your emotions shift, even when it’s hard. Seeing that change is possible builds hope and gives a foundation for healing. This technique supports emotional tracking and is used in trauma-focused therapies.	\N	\N	\N	\N	\N	\N	\N	\N
2fff3939-7604-4ee5-bdf9-fa07c66bca68	S137	P005-7	c7	Practice Naming What You’re Feeling in the Moment—Without Trying to Change It. Sit quietly, take a breath, and ask yourself: “What am I feeling right now?” It might be sadness, guilt, relief, numbness, or confusion—all of these are valid. Just notice them without judgment. 🧠 Why it helps: The act of labeling emotions helps calm the fear center of the brain and activates the thinking part of your brain (the prefrontal cortex). This is a core technique in both mindfulness and trauma-informed care. Simply noticing and naming what you feel can reduce emotional overwhelm.	\N	\N	\N	\N	\N	\N	\N	\N
bb7369fd-22f0-4646-a84b-78cef4abf052	S138	P005-7	c7	Remember These 3 Truths When You Feel Lost in Grief: 1) Love doesn’t end when a person is gone. 2) Your story didn’t stop when theirs did. 3) Living is not betrayal—it’s part of honoring them. Write these down and return to them when things feel heavy. 🧠 Why it helps: After a loss, it’s common to feel guilt for moving on, or like life has no meaning. This tool helps restructure distorted beliefs and restore purpose—key steps in healing after grief.	\N	\N	\N	\N	\N	\N	\N	\N
7f5a100a-c3de-49d7-a272-2c43fbf1ac49	S139	P005-7	c7	Try a “Grief and Gratitude” Practice to Hold Both Pain and Growth. Each night, write down one thing you miss and one thing you’re grateful for. For example: “I miss my dad’s stories. I’m grateful he taught me to listen deeply.” These are not contradictions—they can live side by side. 🧠 Why it helps: Holding both grief and gratitude increases emotional flexibility, which is a protective factor against complicated grief. This practice helps your brain experience balance and hope, while still honoring your loss.	\N	\N	\N	\N	\N	\N	\N	\N
588e9961-71ef-46c1-8807-75719e18fc6e	S140	P005-7	c7	Build a “Grief Emergency Kit” You Can Use When a Wave Hits. Choose 3–5 things that calm or ground you—like a playlist of soft music, a comforting object, a letter from someone you trust, or a calming scent. Put them in a small box or digital folder. 🧠 Why it helps: During intense emotional moments, it’s hard to think clearly. Having a ready-made toolkit gives you access to safety and regulation without having to search. This strategy is used in trauma and grief work to reduce distress and increase agency.	\N	\N	\N	\N	\N	\N	\N	\N
074474a1-956d-4844-a3da-9e260b223bfc	S141	P005-7	c7	Use Breath Awareness to Anchor Yourself When Grief Feels Overwhelming\\nGrief can flood the nervous system. When it does, gently bring your attention to your breath. Try breathing in for 4 seconds, hold for 4, and out for 6.\\n🧠 Why it helps: Slow, conscious breathing engages the parasympathetic nervous system, helping calm the body. It’s a core tool in trauma-informed mindfulness.	\N	\N	\N	\N	\N	\N	\N	\N
2bc21bce-3671-42b9-b9a9-23167d367cd7	S142	P005-7	c7	Create a Safe Space Visualization When Emotions Feel Too Intense\\nClose your eyes and imagine a place where you feel safe, calm, and supported. Fill in the details—what it looks like, sounds like, smells like.\\n🧠 Why it helps: This technique is used in EMDR and trauma care to regulate the nervous system and create internal safety.	\N	\N	\N	\N	\N	\N	\N	\N
7df7bdbf-c3e9-4152-957b-21a941e5ba9b	S143	P005-7	c7	Allow Waves of Grief Instead of Suppressing Them\\nTry saying to yourself: “This is a wave. I can feel it and let it pass.”\\n🧠 Why it helps: Emotions from grief often come in waves. Suppressing them can lead to longer-term distress. Acceptance and Commitment Therapy teaches us to make room for hard feelings without being consumed by them.	\N	\N	\N	\N	\N	\N	\N	\N
750536a3-602b-4f86-ad2c-3633a62a3753	S144	P005-7	c7	Write a Letter to the Person You Lost\\nYou can say whatever you need—what you miss, what you didn’t get to say, what you hope they knew.\\n🧠 Why it helps: Expressive writing allows emotional release and meaning-making. It’s often used in grief therapy to foster continuing bonds and emotional resolution.	\N	\N	\N	\N	\N	\N	\N	\N
863eaa45-175e-46dd-ad40-4d9f05e6b287	S145	P005-7	c7	Identify and Use Supportive Resources Around You\\nMake a list: Who or what helps you feel supported, even slightly? Friends? Pets? Music? Nature?\\n🧠 Why it helps: Recognizing and using existing support builds resilience. Grief often narrows focus, so this step widens your view and reduces isolation.	\N	\N	\N	\N	\N	\N	\N	\N
c69eb3b8-7083-465a-bb7c-aa58e98f37c2	S146	P005-7	c7	Understand That Missing Them Is a Sign of Love and Connection\\nMissing someone deeply after losing them is not a flaw—it's a reflection of your love.\\n🧠 Why it helps: Grief experts highlight that yearning is a normal, expected part of the process. Rather than trying to “move on,” we learn to carry love and loss together.\\nIf you feel stuck, know that grieving takes many forms. There is no single timeline.	\N	\N	\N	\N	\N	\N	\N	\N
0ebb8b1a-cf6d-4a94-81d9-63c8d7dc2bd6	S147	P005-7	c7	Make Space for Sadness Without Judgment\\nSadness is not something to avoid—it’s something to make space for. Try setting aside even 5 minutes a day just to notice and name what you’re feeling.\\n🧠 Why it helps: Giving grief a regular place reduces emotional suppression, and helps emotions pass rather than stay stuck. ACT and CBT approaches encourage gentle exposure to difficult feelings.	\N	\N	\N	\N	\N	\N	\N	\N
ef43d1c2-af46-4b09-b6e5-61b35f078438	S148	P005-7	c7	Learn About the Stages of Grief—But Don’t Feel Pressured to Follow Them\\nYou may have heard of the 5 stages: denial, anger, bargaining, depression, and acceptance. These are **not** steps everyone goes through in order. They’re patterns that help describe common reactions.\\n🧠 Why it helps: Knowing that your experience doesn’t have to “look a certain way” can reduce shame and confusion. This helps normalize what you’re going through.	\N	\N	\N	\N	\N	\N	\N	\N
6e6150f2-50a7-45d4-ad58-33a3dfcaaabd	S149	P005-7	c7	Use “Continuing Bonds” to Stay Connected in a Healthy Way\\nStaying connected to someone you lost—by writing letters, keeping a photo, or continuing a tradition—can be healing.\\n🧠 Why it helps: This concept of “continuing bonds” is a healthy alternative to the idea of closure. It allows you to honor the person’s memory while still living your life.	\N	\N	\N	\N	\N	\N	\N	\N
a0981cae-06a7-4a1a-b8e4-c918e7102def	S150	P005-7	c7	Remind Yourself That There’s No Wrong Way to Grieve\\nGrief doesn’t follow a script. Some days you might laugh, others you might cry. That’s all okay. \\nTry to avoid judging yourself for how you’re feeling.\\n🧠 Why it helps: Self-compassion is critical in grief. Research shows that people who are kind to themselves during the grieving process are more likely to recover emotionally.	\N	\N	\N	\N	\N	\N	\N	\N
c2c2e139-b761-4324-a853-8bcd01d24ce4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
fe6445b0-0e3f-4aa4-82b1-ae9e40b3f9fe	S_STR_001	STR_04_01	c1	Do a 'Needs Inventory' check after a relationship conflict. Ask yourself: What was I truly needing—validation, safety, space, understanding? Identifying unmet needs can reduce the emotional intensity and guide clearer communication.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.937+00	2025-09-04 12:31:58.937+00
275121c7-a232-46c0-a954-a2265019f54a	S_STR_002	STR_04_01	c1	Practice the 'Four Horsemen Reversal': Identify if you’ve used one of the four negative conflict styles—criticism, contempt, defensiveness, or stonewalling—in your last argument. For example, if you said, "You always ignore me," try rephrasing as, "I felt lonely last night when I didn’t hear from you." Then, write out or rehearse each reversal: gentle start-up, appreciation, responsibility, and self-soothing. Doing this helps rewire automatic reactions and builds trust over time.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.937+00	2025-09-04 12:31:58.937+00
932ec22b-9c73-4e78-b34e-6a43c97c842d	S_STR_003	STR_04_01	c1	Do the 'Attachment Rewind': After a stressful interaction, journal or voice-record what deeper emotional memory it stirred. For instance, if your partner didn’t respond to a message, you might realize it triggered a childhood fear of being abandoned. Say: "This reminded me of when I was left alone at school as a kid." Separating past hurt from present events helps reduce emotional overload and brings clarity.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.939+00	2025-09-04 12:31:58.939+00
1affd1ba-b8b9-4aaf-a8b6-cdd7c75a03d0	S_STR_004	STR_04_01	c1	Use a 'Repair Attempt' template: Send a short, gentle message like: "I’m sorry about our fight. I didn’t mean to snap. I value you and want to reconnect." You can also write: "Can we take 10 minutes to reset later today?" Practicing small repair steps—even if they don’t solve the issue—reduces chronic stress and shows emotional maturity.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.939+00	2025-09-04 12:31:58.939+00
ea6bd24b-298e-4cfa-a5b9-b018015fcb75	S_STR_005	STR_04_01	c1	Try 'Mentalizing' to reduce reactive stress: When conflict arises, pause and silently ask, "What are they feeling right now?" or "What might they be worried about?" For example, if someone is avoiding eye contact, instead of assuming they’re angry, consider they might feel ashamed or overwhelmed. Curiosity interrupts blame and leads to calmer interactions.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.941+00	2025-09-04 12:31:58.941+00
06317bc9-ba01-4de8-bebe-0e98a687c9f3	S_STR_006	STR_04_01	c1	Regulate before you relate: After a heated moment, take 3 minutes to sit alone, breathe deeply, and scan your body. For instance, inhale for 4 counts, exhale for 6. Stretch your shoulders or shake out your hands. Only then re-engage with the other person. When your nervous system is calm, your words come out softer and more intentional.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.941+00	2025-09-04 12:31:58.941+00
32110e87-0f07-45da-99ea-fcdcf934a969	S_STR_007	STR_04_01	c1	Draw a ‘Conflict Timeline’: On paper, mark when a conflict began, what triggered it (e.g., missed text), what thoughts you had ("They don’t care"), emotions felt (anger, shame), and where escalation occurred. Then, brainstorm 1–2 moments where you could have paused or exited differently. This tool helps build insight and options for next time.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.942+00	2025-09-04 12:31:58.942+00
03b5b2aa-eb80-46f7-b01c-0c3ddc802df6	S_STR_008	STR_04_01	c1	Create a ‘Relationship Stress Plan’ ahead of time: List your personal stress signs (e.g., eye twitching, silence), helpful coping tools (walk, music, venting), and calming phrases (e.g., "I need a moment to breathe"). Share your plan with a partner or friend so they can support—not escalate—when tension rises.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.943+00	2025-09-04 12:31:58.943+00
7a40ec77-e4f0-47cf-a9e2-f3117d62148f	S_STR_009	STR_04_01	c1	Use a 'Stress Dialogue' journaling method: Write as two voices. One part expresses your stress: "I’m so sick of not being heard!" Another part responds gently: "That sounds really hard. What do you need?" This technique creates internal compassion and reduces the urge to explode outwardly.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.943+00	2025-09-04 12:31:58.943+00
9183c3ce-b808-444e-881a-3dc611f712d1	S_STR_010	STR_04_01	c1	Reframe conflict as a growth opportunity: After a disagreement, list 3 ways this might help your bond—e.g., learning better boundaries, becoming more honest, seeing triggers clearly. Even if you don’t feel positive now, imagining growth reduces your brain’s stress chemicals and opens possibility.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.945+00	2025-09-04 12:31:58.945+00
fe8440fa-9422-41c8-8f31-d0f01f18d175	S_STR_011	STR_04_01	c1	Practice co-regulation: Sit silently near a calm, safe person (even without talking). Focus on their breathing, posture, and tone. Match your breath to theirs. Let their regulation soothe your nervous system. This technique is especially powerful after arguments or emotional flooding.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.945+00	2025-09-04 12:31:58.945+00
8e027f08-1cc1-4222-9870-90a7231cedf0	S_STR_012	STR_04_01	c1	Try a 'Body Boundary Reset': After a stressful encounter, stretch arms wide, touch your shoulders, then gently hug yourself. You can whisper, "I’m safe now" or "This is my space." Adding sensory movement calms the vagus nerve and restores self-protection after interpersonal stress.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.946+00	2025-09-04 12:31:58.946+00
167eb42a-22f1-41cc-87c5-c5e7b787a659	S_STR_013	STR_04_01	c1	Use the 'Dropping the Anchor' technique during relational overwhelm. Stand or sit firmly, press your feet into the ground, and name five things you see, four you hear, three you feel physically. This grounds you when emotions spike during arguments, helping you stay present and connected. Practice it during or after a fight to keep the mind from spiraling.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.947+00	2025-09-04 12:31:58.947+00
e012847e-5e1d-49c1-a6ba-241c024b4e0a	S_STR_014	STR_04_01	c1	Try the 'Circle of Control and Influence' when you feel powerless in a relationship conflict. Write down your stressor in the center, then make two circles: one with things you can control (your words, tone, boundaries), and one with what you can’t (their reactions, their emotions). This visual helps reduce rumination and gives clarity on where to act and where to let go.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.947+00	2025-09-04 12:31:58.947+00
feefa005-2765-44de-a835-70b361f27fb6	S_STR_015	STR_04_01	c1	Respond instead of react: When triggered in a relationship, pause and breathe before speaking. Ask yourself: "What do I want from this moment—connection or being right?" Then choose a softer tone or a question instead of a harsh comment. This practice rewires reactivity and builds trust over time.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.949+00	2025-09-04 12:31:58.949+00
7746e8bb-4dcb-48aa-8367-fce27f2763b3	S_STR_016	STR_04_01	c1	Zoom out and take a 'Big Picture View' after conflict. Ask yourself: "Will this still feel huge in a week, month, or year?" Then write down three strengths in the relationship that remain intact. This reframing tool activates the rational brain, reduces emotional flooding, and restores perspective after relational tension.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.949+00	2025-09-04 12:31:58.949+00
292df59c-528a-4aff-bf36-922cdf725ed9	S_ANX_001	ANX_01_01	c1	When you feel like everyone is judging you or thinking something negative about you, try using a method called cognitive restructuring. The idea is to notice your anxious thoughts, write them down, and then challenge them gently with evidence. How to do it: (1) Write down the thought — e.g., “Everyone thinks I’m weird when I speak.” (2) Ask yourself: “What evidence do I have for and against this thought?” and “Is there another way to look at this?” (3) Replace it with something more balanced, like: “Some people may not even notice me, and others might appreciate what I say. I’m allowed to speak up.” This helps your brain start seeing social situations more clearly, instead of through an anxiety filter.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.949+00	2025-09-04 12:31:58.949+00
361686d2-0fcf-468f-b4dc-9cc7d7a00601	S_ANX_002	ANX_01_01	c1	Start practicing exposure to small social fears instead of avoiding them. Avoidance keeps the anxiety alive — but repeated, gentle practice can reduce it. Try this: (1) Make a “fear ladder” — a list of situations from least scary to most scary (e.g., sending a message to a classmate, asking a question in class, joining a group discussion). (2) Start with the least scary one and do it multiple times — not perfectly, just enough to stay in it. (3) After each attempt, reflect: “What happened? Was it as bad as I expected? Did I survive it?” Over time, your brain will learn: “I can handle this.”	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.95+00	2025-09-04 12:31:58.95+00
91e075a8-d8a8-485e-b5a1-bc4d1adec91c	S_ANX_003	ANX_01_01	c1	Before entering a social situation, try “anchoring” yourself with mindfulness techniques. For example, take three deep breaths while feeling your feet on the floor or lightly press your fingertips together and focus on the sensation. This helps you shift your attention from worrying thoughts to the here and now. Imagine saying to yourself: “Right now I’m okay. I can handle this moment.”	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.95+00	2025-09-04 12:31:58.95+00
eb7296ca-bada-4700-b628-f9125f751425	S_ANX_004	ANX_01_01	c1	Ask yourself: “What would I do right now if I were acting based on my values, not fear?” Social anxiety often makes us pull away from what we care about — like friendship, expression, or learning. Values-based action means choosing small behaviors that support what matters to you. Example: If you value connection, you might smile at someone or join a conversation — even if it's awkward. Practicing this shifts your focus from avoiding pain to moving toward purpose.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.952+00	2025-09-04 12:31:58.952+00
7ca4678f-fab9-42aa-8465-86cce6cf412e	S_ANX_005	ANX_01_01	c1	Build your own “social fear ladder.” Start by listing social situations that make you anxious, from the least to most difficult. For example: (1) saying hi to a classmate, (2) making small talk with a neighbor, (3) speaking in front of a group. Pick the easiest one and practice it until it becomes less scary. Then move up the ladder. This gradual exposure helps reduce fear by showing your brain you can survive the discomfort.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.952+00	2025-09-04 12:31:58.952+00
65d9768f-312e-4ebd-aace-39bdc9f7a406	S_ANX_006	ANX_01_01	c1	After every social situation, take a few minutes to write a short reflection: What went well? What surprised you? What didn’t go as badly as you expected? This helps train your brain to notice positive or neutral outcomes, not just the fear. For example, you might write: “I spoke in class. I felt shaky, but I didn’t mess up. Nobody laughed.” Repeating this builds evidence that challenges your automatic fears.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.953+00	2025-09-04 12:31:58.953+00
51e28a1e-1905-497b-b9b3-61f54260807b	S_ANX_007	ANX_01_01	c1	Try using self-compassion when you're feeling socially anxious. Instead of judging yourself for being nervous, speak to yourself like you would a close friend: “It’s okay to feel anxious — I’m doing something brave.” You can place a hand on your heart or take a calming breath. These small acts of kindness reduce inner criticism and calm your nervous system.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.953+00	2025-09-04 12:31:58.953+00
17b40955-d7a7-4272-bf56-f6a53d337939	S_ANX_008	ANX_01_01	c1	Use a technique called “box breathing” before entering stressful social situations. Inhale for 4 seconds, hold for 4, exhale for 4, hold for 4 — repeat 4 times. This lowers physical tension and brings focus. For example, try it right before entering a classroom or social event. Your body will feel more grounded and your brain more alert.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.954+00	2025-09-04 12:31:58.954+00
3d6c1e46-5cc7-424a-a6fa-e1729e415a20	S_ANX_009	ANX_01_01	c1	Before a social event, try guided visualization. Close your eyes and imagine yourself walking into the space, breathing steadily, making eye contact, and feeling calm. Picture how you’d like to act and respond. This primes your brain for success. Athletes use this to boost performance — and it works for social skills too.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.955+00	2025-09-04 12:31:58.955+00
a0bde961-f179-41ec-8c19-19d70fb0634d	S_ANX_010	ANX_01_01	c1	Ask a trusted friend or sibling to join you during a challenging social moment. For example, going to a party, placing an order, or meeting new people. Their presence acts like a safety net while you build confidence. Over time, you may not need them there, but having support early on reduces fear and increases success.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.956+00	2025-09-04 12:31:58.956+00
0762a0f1-c92d-4970-9ed6-904b07642e38	S_ANX_011	ANX_01_01	c1	When you think someone is judging you, write down what actually happened. Did they laugh? Say something unkind? Or is that your anxious brain assuming the worst? This helps you learn to separate assumptions from facts. For example: “I thought they were laughing at me, but actually, they were laughing at something else.”	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.956+00	2025-09-04 12:31:58.956+00
88abad17-1fb0-4d94-932a-38ac6a808274	S_ANX_012	ANX_01_01	c1	Try joining a low-pressure group activity like theater, improv, or debate club. These settings normalize social awkwardness and give you repeated practice expressing yourself. It helps desensitize you to attention and builds the muscle of confidence. You don’t have to be perfect — just present.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.957+00	2025-09-04 12:31:58.957+00
b89a12cc-38ee-4fe8-bf64-8ded663719b9	S_TRA_001	TRA_05_01	c1	Identify one behavior that you’ve stopped doing since the incident—something that used to bring a sense of structure or reward (e.g., going to the gym, journaling, calling a friend). Break it into three small, manageable steps and schedule the first step this week. Example: Behavior: Cooking a basic meal again. Step 1: Write a grocery list. Step 2: Buy ingredients for one simple recipe. Step 3: Cook and eat that meal mindfully. Purpose: This helps combat avoidance, boost energy, and reintroduce positive reinforcement.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.958+00	2025-09-04 12:31:58.958+00
db0fc44e-2981-4401-9608-8b1eff50aa71	S_TRA_002	TRA_05_01	c1	Take a recurring stress-related thought (e.g., “I can’t deal with anything anymore”) and write it at the top of a page. Underneath, create two columns: (1) Evidence that supports this thought, and (2) Evidence that challenges it. Then reframe it into a more flexible thought (e.g., “I feel overwhelmed, but I’ve handled things before”). Purpose: Trains cognitive restructuring and challenges catastrophic interpretations common in adjustment disorder.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.958+00	2025-09-04 12:31:58.958+00
38f8ccb5-9d80-4671-bf49-bc9fc17d4b0e	S_TRA_003	TRA_05_01	c1	Use the “Values Compass”: Identify one core value (e.g., stability, connection, growth). Ask: “Why does this matter to me?”, “How has this value been affected by the event?”, and “What’s one small act this week that moves me toward this value?” Example: If “connection” is the value, the action might be sending a check-in text to a friend. Purpose: This restores motivation and meaning after disruption and helps prioritize behavior aligned with identity.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.96+00	2025-09-04 12:31:58.96+00
0eb491e9-acc6-4bd9-9e28-eb0de534033d	S_TRA_004	TRA_05_01	c1	Write a values-based reflection letter to yourself about how you responded to the stressful incident and what personal strengths you used during that time. Be honest and specific. You might begin with: “At first, I felt frozen by everything. But despite that, I managed to…” or “One thing I did that surprised me was…” Identify the internal qualities that helped you (e.g., courage, empathy, responsibility, endurance). Don’t focus on “being perfect”—focus on your authentic efforts. Then, reflect on what matters most to you now and write about one small values-aligned action you’ll commit to doing this week. Purpose: This ACT-based exercise supports psychological flexibility, values re-engagement, and cognitive distancing from trauma-anchored identity.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.961+00	2025-09-04 12:31:58.961+00
ab37866f-0999-45e8-b006-73660f210f62	S_TRA_005	TRA_05_01	c1	Use the “Stress Puzzle” method: Write down all aspects of your current adjustment challenge. Break them into two columns: “What I can influence” vs. “What I cannot.” Choose one actionable piece to focus on this week. Purpose: Reduces overwhelm by separating controllable vs. uncontrollable aspects and shifting focus to small wins.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.961+00	2025-09-04 12:31:58.961+00
6f11af85-2c85-42b7-8174-6ed812fcc0f2	S_TRA_006	TRA_05_01	c1	Map your “Resilience Resources”: Draw three circles labeled: “People”, “Places”, and “Practices”. Fill each with stable, supportive resources you still have or can reconnect with. Then pick one to actively engage with this week (e.g., call a friend, return to journaling, walk a calming route). Purpose: Reinforces existing support systems and reminds the person that resources still exist, despite the disruption.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.963+00	2025-09-04 12:31:58.963+00
9c5d6f81-9ab0-4a8c-afd5-2581182a76ab	S_TRA_007	TRA_05_01	c1	Track your “adjustment curve”: Note one emotional, one behavioral, and one thinking pattern that has shifted since the event. Use this to notice progress and identify areas still needing support. Ask: “What changed?”, “What improved?”, “What still needs attention?” Purpose: This helps break down the complexity of adjustment into observable, trackable parts, supporting cognitive processing and emotional labeling.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.964+00	2025-09-04 12:31:58.964+00
905777a5-0015-4456-80ff-367754943a23	S_TRA_008	TRA_05_01	c1	Practice the “One-Minute Reframe”: When facing an emotional wave, pause and ask, “What is this really about?” and “What matters most right now?” Then name one small action that honors what matters — not what the emotion demands. Purpose: Encourages values-based redirection and cognitive-emotional flexibility in real time.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.965+00	2025-09-04 12:31:58.965+00
df9d8120-c99d-420a-8f9e-64bdda3be824	S_TRA_009	TRA_05_01	c1	Schedule a 20-minute “stability window” each day: Do a familiar, structured task that reminds you of competence and predictability (e.g., making a meal, cleaning, walking the same route). Purpose: Restores a sense of routine and control, useful during emotional chaos.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.966+00	2025-09-04 12:31:58.966+00
f50c4f66-837f-40aa-b9b5-e79c8a6e4b4a	S_TRA_010	TRA_05_01	c1	Identify one area in your life where you're avoiding something (e.g., conversations, paperwork, decisions). Break it into three smaller steps and do the first one today. Track how your avoidance changes over a week. Purpose: Addresses experiential avoidance and promotes action-based recovery.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.966+00	2025-09-04 12:31:58.966+00
d5de0d48-cef6-46f2-9611-48b04ee7e8b3	S_TRA_011	TRA_05_01	c1	Use the "Personal Timeline" technique: On a blank page, draw a horizontal timeline from “Before the Incident” to “Now.” Mark moments of strength, coping, support, or progress since the incident. Even small events like “got out of bed,” “texted a friend,” or “cried and let it out” count. Purpose: Reframes the current struggle as a dynamic adjustment process, not a static state of being stuck.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.968+00	2025-09-04 12:31:58.968+00
bfddbf44-e0cf-4216-a2b1-d2cbe7831cfe	S_TRA_012	TRA_05_01	c1	Build a "micro-routine": Choose three tiny actions to repeat each morning (e.g., open the window, drink a glass of water, stretch arms). Keep them easy and consistent. These rituals offer predictability and restore small moments of self-control when the larger world feels disrupted.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.968+00	2025-09-04 12:31:58.968+00
69ba2112-5d72-49d6-860e-55dba1777c0b	S_TRA_013	TRA_05_01	c1	Do a “meaning scan”: Write down what has changed since the incident—not only in terms of difficulty but also in perspective or values. Then answer: “What matters to me now that didn’t before?” Purpose: Strengthens post-crisis growth by helping the person notice what they want to preserve, reclaim, or reinvent.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.968+00	2025-09-04 12:31:58.968+00
18e3107b-728c-412d-b98d-85f232206a13	S_TRA_014	TRA_05_01	c1	Use the “Three Lenses” technique when something triggers distress: (1) What am I feeling? (2) What am I needing right now? (3) What’s a small, values-aligned next step? Purpose: Trains emotion labeling, unmet need identification, and response flexibility. This helps move from reactivity to intentionality.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.969+00	2025-09-04 12:31:58.969+00
792d7e0a-9db7-47bb-9ba8-c16767ccb996	S_TRA_015	TRA_05_01	c1	Visualize a “stability space”: Close your eyes and imagine a place (real or imagined) where you feel grounded and secure. Describe it in detail (sights, sounds, smells), then name one thing you could bring from that space into your current life (e.g., “peace,” “light,” “warmth”). Purpose: Builds psychological safety and anchors regulation without generic grounding.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.969+00	2025-09-04 12:31:58.969+00
6674ba8d-47a8-492f-864b-5f7f6d6d56af	S_GEN_001	GEN_01_01		Try deep breathing exercises before exams.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.971+00	2025-09-04 12:31:58.971+00
48acd6b9-ae09-4d00-b65e-e391d7d17bef	S_GEN_002	GEN_01_01		Use time management techniques.	\N	\N	\N	\N	\N	t	2025-09-04 12:31:58.971+00	2025-09-04 12:31:58.971+00
\.


--
-- Data for Name: talent_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."talent_assignments" ("id", "talent_id", "project_id", "hourly_rate", "assignment_type", "percentage", "hours_this_week", "hours_this_month", "total_earnings", "utilization_rate", "capacity_hours", "actual_hours", "timesheet_status", "payment_status", "created_at", "updated_at") FROM stdin;
6dc9f5b1-f209-43f0-aa12-5ade68dd0496	550e8400-e29b-41d4-a716-446655440001	550e8400-e29b-41d4-a716-446655440001	85	single	100.00	40.00	160.00	1360000	100.00	40	40.00	up-to-date	pending	2025-09-14 15:25:24.353525+00	2025-09-14 15:25:24.353525+00
0eb899fc-9d36-4cfb-a63b-aacc6e926275	550e8400-e29b-41d4-a716-446655440001	550e8400-e29b-41d4-a716-446655440002	85	multiple	50.00	20.00	80.00	680000	100.00	40	40.00	up-to-date	pending	2025-09-14 15:25:24.353525+00	2025-09-14 15:25:24.353525+00
b0af2049-4455-438f-ab54-b2cc6a454a46	550e8400-e29b-41d4-a716-446655440002	550e8400-e29b-41d4-a716-446655440001	65	single	100.00	40.00	160.00	1040000	100.00	40	40.00	up-to-date	pending	2025-09-14 15:25:24.353525+00	2025-09-14 15:25:24.353525+00
c8810559-774a-4b8e-92f7-d945addd456f	550e8400-e29b-41d4-a716-446655440002	550e8400-e29b-41d4-a716-446655440003	65	multiple	75.00	30.00	120.00	780000	100.00	40	40.00	up-to-date	pending	2025-09-14 15:25:24.353525+00	2025-09-14 15:25:24.353525+00
a2729396-f7c1-4bc7-95cb-5d3ae38b7fb7	550e8400-e29b-41d4-a716-446655440003	550e8400-e29b-41d4-a716-446655440001	70	single	100.00	40.00	160.00	1120000	100.00	40	40.00	up-to-date	pending	2025-09-14 15:25:24.353525+00	2025-09-14 15:25:24.353525+00
3766ced4-7647-4184-acf4-3da12c237ce7	550e8400-e29b-41d4-a716-446655440003	550e8400-e29b-41d4-a716-446655440002	70	multiple	50.00	20.00	80.00	560000	100.00	40	40.00	up-to-date	pending	2025-09-14 15:25:24.353525+00	2025-09-14 15:25:24.353525+00
ea971cf7-f3de-43ff-8c70-a2af262c3006	550e8400-e29b-41d4-a716-446655440004	550e8400-e29b-41d4-a716-446655440003	60	single	100.00	40.00	160.00	960000	100.00	40	40.00	up-to-date	pending	2025-09-14 15:25:24.353525+00	2025-09-14 15:25:24.353525+00
b9aa1934-34f0-4334-87e4-5a424e842cc6	550e8400-e29b-41d4-a716-446655440005	550e8400-e29b-41d4-a716-446655440004	75	single	100.00	40.00	160.00	1200000	100.00	40	40.00	up-to-date	pending	2025-09-14 15:25:24.353525+00	2025-09-14 15:25:24.353525+00
\.


--
-- Data for Name: talent_utilization_tracking; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."talent_utilization_tracking" ("id", "talent_id", "week_starting", "total_hours", "billable_hours", "utilization_rate", "efficiency_score", "project_count", "total_earnings", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: time_entries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."time_entries" ("id", "user_id", "project_id", "task_id", "date", "hours", "description", "status", "entry_type", "timer_session_id", "hourly_rate", "total_cost", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: timer_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."timer_sessions" ("id", "user_id", "project_id", "task_id", "start_time", "end_time", "duration", "is_active", "is_paused", "paused_at", "total_paused_time", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: timesheet_approvals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."timesheet_approvals" ("id", "talent_id", "week_starting", "total_hours", "total_amount", "status", "submitted_at", "approved_at", "approved_by", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: training_examples; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "public"."training_examples" ("id", "example_id", "problem", "conversation_id", "user_intent", "prompt", "completion", "context", "quality_score", "tags", "is_active", "created_at", "updated_at") FROM stdin;
bed4246d-063b-465c-9930-ab4861788bfe	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
496854a8-098b-4702-b14c-a6d4f889855f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
acd896c6-88d6-4c87-8d5a-a439c8fd219b	\N	\N	\N	\N	I’m having panic attacks when I fly. What can I do?	I’m sorry you’re feeling that way. Try this 4‑7‑8 breathing exercise…	\N	\N	\N	\N	\N	\N
bf1d2a0c-d1b4-444c-bd19-f6b635a42564	\N	\N	\N	\N	How can I distract myself from negative thoughts?	Here are a few strategies: 1) List 5 things you see right now… 2) Do a body‑scan… 3) Call a friend.	\N	\N	\N	\N	\N	\N
b41a1b33-3583-4820-a85d-77f09bf5fe2f	\N	\N	\N	\N	I'm nervous about my upcoming test.	It's natural to feel nervous. Try using calming techniques like deep breathing.	\N	\N	\N	\N	\N	\N
e4c753c6-9700-4512-9c44-701006e2580d	\N	\N	\N	\N	I can't handle work stress anymore.	It might help to break tasks into smaller chunks and take regular breaks.	\N	\N	\N	\N	\N	\N
f0fed61f-ba28-46e6-9895-4a33b5499801	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
0f6a7d6a-f502-442b-a545-fd0ae15c6b13	\N	P004	\N	\N	I'm really stressed about all of the school work that I have	It sounds like school is very stressful right now. Can you be more specific about which part is stressing you out the most at the moment?	\N	\N	\N	\N	\N	\N
8e4100cc-2672-4173-a808-d3b5ea3e6aa2	\N	\N	\N	\N	I have 2 tests next week, 1 assignment and I need to look after my younger brother while my parents work	It sounds like you have a lot on your plate at the moment, with all of the school work and looking after your brother. I would also feel stressed out if I had so many things to do. What's more stressful for you, the tests or the assignment?	\N	\N	\N	\N	\N	\N
af0b119c-370d-4697-b6c5-4beceafd5109	\N	\N	\N	\N	The maths test is the hardest part for me	So it sounds like you can manage the assignment and your brother, but you're most stressed out about the maths test. What usually works for you when you have a maths test to prepare for?	\N	\N	\N	\N	\N	\N
f637700b-0606-4a5a-83d2-d2d8ed0ad670	\N	\N	\N	\N	Nothing! Nothing works for me	Wow, it seems as if this is very stressful for you. I hear you. Some people could ask their friends for help, and others might want to ask the teacher. What do you think would help you?	\N	\N	\N	\N	\N	\N
44068ebd-f532-4c0e-b98c-88605e14a914	\N	\N	\N	\N	I'd prefer to ask my friends for help	Great! That sounds like a good plan	\N	\N	\N	\N	\N	\N
a36d9d3f-ef67-4824-b5d3-1d84fd726511	\N	P004	\N	\N	I'm so stressed because my parents told me to come home straight after school and I went to my friend's house instead. And now i will be 2 hours late. I'm so stressed i can barely breath	It sounds like your stress levels are very high. It's really hard when you feel so stressed that your body reacts as well. Would you like to do a short breathing exercise to help your body calm down, and bring your breath back	\N	\N	\N	\N	\N	\N
0987101f-94fc-4761-876e-4d5322e00ce6	\N	\N	\N	\N	I'm not sure	We can do a breathing exercise right now, or we can talk about why you're feeling so stressed. What would you like to do?	\N	\N	\N	\N	\N	\N
3c240df9-35aa-4453-a1fc-e3e5e24decdc	\N	\N	\N	\N	I'd like to try the breathing exercise	Good for you for taking control. Let's try the 5-2-5 breathing exercise	\N	\N	\N	\N	\N	\N
e9dd9323-5d59-47a6-92b3-fb0a305098b0	\N	P004	\N	\N	I cant' fall asleep at night, because my mind won't stop racing	It's really hard when you feel tired and you can't sleep. Do you want to try the journal method or the visualising method?	\N	\N	\N	\N	\N	\N
8b1fbbd0-cf82-4b1e-b887-deb19367e9b0	\N	\N	\N	\N	I'll try the journal method	That sounds like a good choice. If you keep a journal next to your bed and whenever your mind races, start to write all of your thoughts down. When you have finished writing, reread it and see if you have anything to add. Arrange your thoughts by topics, and ask yourself if there is anything that can wait until the morning, or if it has to be dealt with right now. It's most likely that you will be able to deal with everything in the morning.	\N	\N	\N	\N	\N	\N
103afd42-d2ff-4476-9b85-c6840b4ebe77	\N	\N	\N	\N	I'll try the visualisation method	Good for you for taking control and choosing visualisation. You can do this by thinking about a soothing, pleasant experience you've had in the past, and use your imagination to go back to this time. Allow your thoughts and feelings to sit in this experience, and sit with it until your whole body relaxes.	\N	\N	\N	\N	\N	\N
de23a651-9efc-4c2d-b312-3986ea458f43	\N	P004	\N	\N	I'm stressed out about going to my gym class tomorrow because there's going to be a new piece of equipment that the teacher will make us use.	It can be very stressful to use equipment for the first time in a clasroom situation. A lot of people come across this situation. Some people choose to create a step by step plan of how to approach a new situation, and others choose to research more information about the new equipment. What would you prefer to do?	\N	\N	\N	\N	\N	\N
76fc9d5d-3d8c-4412-a5be-512a064f18d7	\N	\N	\N	\N	I'd like to create a step by step plan	Great! Let's create a step by step plan of how to manage your stress: 1. When your first arrive, talk to the teacher and ask if you are able to watch a friend before using the equipment yourself. 2. Watch the other kids use the equipment before you have a go. 3. Ask yourself how scared you are, from 0-10. 4. Positive self talk about doing something even when you feel scared. 5. Limit the time you spend on the equipment and engage in an activity where you will feel successful. 6. Once you have finished the activity, compare the way you feel  - how scared are you now, and how accomplished do you feel?	\N	\N	\N	\N	\N	\N
47d17c0f-aff7-4eed-94c2-f8a508b65ca6	\N	\N	\N	\N	I'd like to do some research about the equipment	Great! Do you prefer to do a google search, or to talk to someone who has used this piece of equipment previously?	\N	\N	\N	\N	\N	\N
5f6e2bae-2eea-4733-8158-06d966a10748	\N	P004	\N	\N	I feel stressed out because my parents expect me to get excellent grades in all of my subjects at school.	It sounds like you're feeling very stressed out as your parents have very high expectations of you. Which part of them having high expectations of you, is most stressful? Is it the pressure to always acheive high grades, the way it impacts your family reputation, or the way it may impact your future?	\N	\N	\N	\N	\N	\N
cacac590-cd29-4e2a-ac65-afcc1d659bb2	\N	\N	\N	\N	I feel stressed that if i don't acheive good grades then it will impact my future and I want be able to support my family	It can be very stressful to have a lot of pressure to always succeed at school with high grades, and to feel that if you don't acheive then you may not have a successful future ahead of you. I think many people in your situation would feel stressed out as well. What do you want to do about it? Do you want to try and have a conversation with your parents, or do you want to create a plan to help you manage your stress?	\N	\N	\N	\N	\N	\N
feeeb066-c63f-41f8-986d-1e4441183ff3	\N	\N	\N	\N	I'd like to make a plan to help me manage my stress	\N	\N	\N	\N	\N	\N	\N
53c552f9-5c98-422d-a795-32597a2f4d22	\N	P004	\N	\N	I don't understand what is happening in science class and I keep failing the tests. This is really stressing me out.	I'm sorry to hear that you're finding the science subject at school very hard, and that you feel as if you're not succeeding. It's very difficulty to do well on a test when you don't follow what is going on in class. Many people find science very difficult. Some choose to go online and search for explanations via you tube, others ask a friend to help them, and some go to the teacher for help. What would you prefer to do?	\N	\N	\N	\N	\N	\N
88ec20c4-b5ee-43d5-ac7a-088033c4651f	\N	\N	\N	\N	I would feel most comfortable asking a friend for help.	That sounds like a great idea, do you have a particular friend you could ask? It's much easier when you have a plan in place, so you can have a think about exactly what you're going to ask your friend. For example, do you have specific question you want to ask your friend, or specific topics you don't understand.	\N	\N	\N	\N	\N	\N
95bb8693-7f48-48ff-b2a0-82628845ff40	\N	\N	\N	\N	Yes, I"m going to go and ask my friend Ika, because she is very patient and will be able to explain things easily to me.	\N	\N	\N	\N	\N	\N	\N
dabf53b7-34b8-4457-a395-5873cd63142d	\N	P004	\N	\N	I went onto instagram, and I saw photos of my x-girlfriend hanging out with her friends and having a lot of fun. It feels like she's already forgotten about me, and I"m so angry that I don't know what to do.	It sounds like you're really struggling with your break-up with your girlfriend. Breakups can be very overwhleming, upsetting and emotionally draining. Sometimes when people feel angry, they're actually feeling a lot of sadness. What usually works for you when you're sad?	\N	\N	\N	\N	\N	\N
9dd28e58-901a-4786-94ec-d7c91ffb88d1	\N	\N	\N	\N	When I'm sad it helps me to distract myself and not think about what's going on.	It sounds like you know what works for you. There's a few ways you can manage this, you can unfollow your x-girlfriend on instagram so you don't have to see what she's doing all of the time. The other option is to distract yourself with other thing aside from social media, such as going out with friends, doing sport or anything you like. This usually helps people. What would you like to do?	\N	\N	\N	\N	\N	\N
e176fc09-38fc-4c87-873e-8fb4e16f1663	\N	\N	\N	\N	I'm going to hang out with my friends, and try to take a break from social media.	Good for you for taking action. Breakups can be very difficult for everyone. Give yourself at least 3-4 weeks of creating new habits before you expect to see a big change in the way you feel. It can take time.	\N	\N	\N	\N	\N	\N
7e3da2c5-59cf-4129-a745-a9ab319a8f90	\N	P004	\N	\N	I'm scared to go to school today because I get bullied by 3 boys in my class.	Experiencing bullying is a really tough thing. Can you tell me more about what's going on?	\N	\N	\N	\N	\N	\N
0d41783b-6596-4975-a076-004e3ae3246d	\N	\N	\N	\N	The boys call me names, they tell me I'm stupid and they always laugh about what I wear.	It must be very difficult to motivate yourself to go to school when you know that people are making fun of you all of the time. It sounds especially hard when they are laughing at you about things that you can't change. Dealing with bullies is not easy. Some kids who are being bullied choose to ask for help from an adult at school, and some kids prefer to talk to the bullies themselves. We know that bullies don't usually just go away, so you can choose to get help from an adult, or try to deal with it yourself. What do you prefer to do?	\N	\N	\N	\N	\N	\N
977fc801-514f-4533-acae-199cc334b326	\N	\N	\N	\N	I don't want to ask an adult for help. What can I do myself?	Some kids feel OK to approach the bully themselves. Others don't want to, but decide that whatever the bullies say, won't impact them, by saying this to themselves "your words are empty and they can't hurt me". What would you like to do?	\N	\N	\N	\N	\N	\N
1e2f2384-e944-4420-98ac-da176b13cca6	\N	\N	\N	\N	I think I"m going to say this to myself, I don't think I have the courage to approach the bully	Great, taking control over how much it impacts you it a very big towards ending bullying. Usually, when a bully notices that his words have no impact, he stops. Good for you for taking charge of your own reaction.	\N	\N	\N	\N	\N	\N
c78869d6-bbd0-44e5-8145-f73348276672	\N	P004	\N	\N	I'm scared to go to school today because I get bullied by 3 boys in my class.	Experiencing bullying is a really tough thing. Can you tell me more about what's going on?	\N	\N	\N	\N	\N	\N
a8b230d4-750f-4efa-bccc-4f365740de86	\N	\N	\N	\N	I prefer to speak to an adult, but who should I speak to and what do I say to them?	Usually, people approach an adult that they know well and they trust. Do you have someone like this at your school or in your family?	\N	\N	\N	\N	\N	\N
1093287b-6e43-4866-badb-5931dc3fc114	\N	\N	\N	\N	I like the school counsellor, but what should I say to her?	What do you think it's important for her to know? If you were the school counsellor, what do you think you would need to know so you could help the student? It's normal to feel nervous when talking to an adult about bullying. But most adults takes bullying seriously and want to help.	\N	\N	\N	\N	\N	\N
3af4a620-81c2-4773-aacb-62065fffd049	\N	\N	\N	\N	I want to tell her that the boys usually make fun of me during gym class.	Good for you, for being able to share that with someone that can help. Once you've had that conversation, what would you like to see happen? Do you want the counsellor to have a conversation with you and the boys together or for her to speak to the boys on their own? It will be easier if we have a solid plan of what you think will be helpful.	\N	\N	\N	\N	\N	\N
e900d8fc-a899-4f33-8637-b8a987dd555b	\N	\N	\N	\N	I'm not sure, I don't know what would be best to do here.	It's normal not to always have an answer. It sounds to me that you need to follow your plan by talking to the counsellor, and then you can make a plan together. Would that work for you?	\N	\N	\N	\N	\N	\N
23230a4c-5f55-424a-ac55-95d84f9adb3b	\N	\N	\N	\N	Yes, I think that would be helpful. I'm going to talk to the counsellor and then come up with a plan together with her.	Great idea!	\N	\N	\N	\N	\N	\N
74874260-52d4-40c5-bd97-52a020ed2d86	\N	P004	\N	\N	I can't do this	"I can see this is really tough for you right now. It’s totally normal to feel overwhelmed in front of a group. You’re not alone." You know, you did start speaking, which already shows a lot of courage. It seems like your brain just hit pause for a second—it happens to a lot of people, even adults.	\N	\N	\N	\N	\N	\N
a585b51e-5411-4921-810a-27ac635086f9	\N	\N	\N	\N	It’s really hard for me	It looks uncomfortable and not pleasant to feel this way. Let’s think about what could help right now. Would it feel better to sit down and read your notes? Or maybe take a quick break and come back to it? Totally your call	\N	\N	\N	\N	\N	\N
01608941-febd-4690-80ae-d996fc126d2d	\N	\N	\N	\N	Maybe I can sit and just read it from the paper	That’s a great idea. Freezing like this happens when your body goes into stress mode—it’s just your brain trying to protect you. Next time, we can practice breathing or using note cards. There are lots of strategies that help."	\N	\N	\N	\N	\N	\N
4b1dbc68-5bd5-4fd9-ae42-41b7d25cb330	\N	\N	\N	\N	Okay. I’ll try sitting down. Thanks	\N	\N	\N	\N	\N	\N	\N
e0478174-975b-4ad1-8365-e2f2f03dd652	\N	P004	\N	\N	I'm not going. I don't care waht you say. I'm not going to a dinner with uncle Budi. He always speaks down towards me	You sound really upset. I can tell that being around him feels aweful for you	\N	\N	\N	\N	\N	\N
f1d4d061-394e-401f-9952-e32a042f8621	\N	\N	\N	\N	Yes it does. He talks to me as if i am still 10 years old and I'm sick of pretending it's OK	I understand that, it's really frustrating when someone treats you as if you are younger than you really are. And having to keep a smile on your face just adds to that pressure.	\N	\N	\N	\N	\N	\N
d5b5621a-e70a-4e0c-9f4b-7020bbe04110	\N	\N	\N	\N	Exactly. no one eer says anything to him and I just have to sit there and listen.	What do you think would help you feel less stuck this time? Do you want to sit at the other end of the table? Or give me a signal if it gets too much and you need to take a break?	\N	\N	\N	\N	\N	\N
38785822-932a-4d72-b20d-e530b904b9fc	\N	\N	\N	\N	I guess sitting further away from him would help me. And may be i could just leave the room if i need to?	Yes, we can do that. It's also important for you to know that some people choose to speak up directly, and others set boundaries in quieter ways. If you ever want helpwith waht to say to him, we can come up with something together.	\N	\N	\N	\N	\N	\N
f2a5f0e1-37e7-42d8-ab43-088cafb5c64d	\N	\N	\N	\N	Ok, I don't think i will talk, but if I can sit far away from him, I will go to the dinner	\N	\N	\N	\N	\N	\N	\N
a400475c-b888-4edb-8536-463d3a0f4174	\N	P004	\N	\N	I don't want to go back to school. I know they're talking about me	Do you think people are saying things behind your back?	\N	\N	\N	\N	\N	\N
e1fa3d62-5f53-4e14-875c-35cc379b5cc1	\N	\N	\N	\N	Yes, after that silly fight we had last week, they posted this story on instagram. They didn't put a name, but it was obviously about me	Ugh that must feel awful. It must feel like you're being watched and judged non-stop	\N	\N	\N	\N	\N	\N
fdb63646-4459-41ac-a9a9-7b7fe700083e	\N	\N	\N	\N	Exactly. I keep thinking about it. I can't sleep. I feel terrible.	Do you want to show me the story? Maybe we canfigure out how much it was directed at you. Sometimes our brains fill in the worst case version	\N	\N	\N	\N	\N	\N
bd1f6be3-b33f-4c47-912e-5fac8de87cf7	\N	\N	\N	\N	Sure, here it is. It was posted just after our fight, so it must be aimed at me	I see why it feels that way. And even if it's not named, it hit hard. The makes sense. When people post things like this, it's designed to sting and hurt.	\N	\N	\N	\N	\N	\N
3d12373a-17a0-4f94-a09e-9a5b1589455a	\N	\N	\N	\N	Yeah, I just keep replaying it in my head	What do you want to do? Do you want to take a break from your phone for a bit? I can hang out with you or we can do something else offline	\N	\N	\N	\N	\N	\N
f59ed543-e574-4354-943c-e955326c88da	\N	\N	\N	\N	Yeah, i need a break. I don't even want to look at it anymore	You're not the only one this kind of thing happens to. Lots of people feel better when they unplug and talk it out. If you want, i can help you think about it or how you want to respond later on.	\N	\N	\N	\N	\N	\N
63ece448-6489-4e46-80bf-3d808d51e2b1	\N	\N	\N	\N	Ok, that helps a lot. Thanks for not acting as if nothing happened.	Of course, it's something big. And i've got your back.	\N	\N	\N	\N	\N	\N
22387f30-f3ca-4dfd-b2fa-0fb2447014bf	\N	P004	\N	\N	I'm not going back. What if something happens again?	I hear you, it must feel really scary to even think about sitting in class like everything is normal	\N	\N	\N	\N	\N	\N
86244990-e9b3-4b38-a4ca-bb9b8f79e48e	\N	\N	\N	\N	Yeah, my body feels tight just thinking about walking in there	It makes sense, you went through something very intense. No one expects you to just bounce back	\N	\N	\N	\N	\N	\N
8bf89839-4909-481e-93f4-c5dd16907477	\N	\N	\N	\N	So then why do i have to go back at all?	Let's look at options. What if we try half days for now? Maybe just mornings with breaks in between?	\N	\N	\N	\N	\N	\N
1c750be4-e10b-44d6-b7c6-0fd51249383e	\N	\N	\N	\N	I guess...that sounds a little bit better than a full day	And some students find it helps to have a safe space they can step into if they need it, would that help as well?	\N	\N	\N	\N	\N	\N
eaf573c0-0ae2-4a73-98fc-7329e554d9b2	\N	\N	\N	\N	Yes, just knowing that I can leave if I need to	OK, that is something we can arrange. When the brain goes through something traumatic, it stays on alert for a while. So we rebuild trust in small steps. You're not alone in this, and you don't have to do it all at once.	\N	\N	\N	\N	\N	\N
db363ef0-c5c4-40bb-a12b-3680100ec3c2	\N	P004	\N	\N	Everyone got invited except for me. I dont' even know what i did.	That kind of thing really hurts. I would feel the same	\N	\N	\N	\N	\N	\N
0f8f07fd-4034-472e-8f84-5aacae3105a5	\N	\N	\N	\N	I'm trying not to care, but i keep checking their stories like a looser	Yeah, it's hard to stop looking when you feel left out. It's like your brain wants to punish you even more.	\N	\N	\N	\N	\N	\N
ca9c35a3-1fbe-498b-b0c7-b9e78526b6b8	\N	\N	\N	\N	I just want to disappear	You don't have to dissapear. You matter, with our wihtout that invite. Do you want ot hang out with me on the night of the party instead?	\N	\N	\N	\N	\N	\N
ec64f3d8-cbd2-43c8-9b5b-7aad32ae6686	\N	\N	\N	\N	I guess, but i still feel like I'm not part of the group anymore	Some people do these kind of things because they don't know how to talk things out. Others just go along with it. Do you want to think about whether this is something you want to confront, or prefer to let go of?	\N	\N	\N	\N	\N	\N
bcc69f16-9769-44f9-b1d8-525719836ab6	\N	\N	\N	\N	Maybe, but right now I just dont' want to be alone	Ok, I won't leave you alone. We'll figure this out together. And remember, the pain you're feeling now doesn't define your future connections.	\N	\N	\N	\N	\N	\N
fdba810b-a6a2-4ce4-9b81-3508f899e32d	\N	P004	\N	\N	I keep failing. It doesn't matter how hard I try, I'm just terrible at maths.	That sounds really discouraging. You've been trying so hard and you still feel stuck.	\N	\N	\N	\N	\N	\N
460909cf-9630-4862-be04-5077e7c33c86	\N	\N	\N	\N	I study for hours, but the minute I see the test, my brain goes blank.	That kind of stress can shut your whole brain down. It's not about your ability, it's your brain going into panic mode.	\N	\N	\N	\N	\N	\N
39482dd4-9e5f-447a-8007-6ed3ffa7f72b	\N	\N	\N	\N	Then what is the point of even tryingg?	Some students in your situation work with a tutor to help them, or request extra time on their tests. Others change the way in which they study. Let's explore some of those options	\N	\N	\N	\N	\N	\N
495581a0-daf5-4808-b392-7f67c8503152	\N	\N	\N	\N	Do you think i'm stupid?	I know you're not stupid. You're overshelmed, and there's a difference. When our bodies are stressed, they aren't able to recall information and have a hard time focussing. We can make a plan that works with how your brain handles stress.	\N	\N	\N	\N	\N	\N
f2e39501-1037-41ac-9233-6014b42160cd	\N	\N	\N	\N	OK, I'll try again if we can change the approach	I'm with you. Let's try smoething that actually supports you this time. And remember, needing help doesn't mean you're failing, it means you're human	\N	\N	\N	\N	\N	\N
185c2dfc-638c-4498-b3d6-ee26f5834b24	\N	P004	\N	\N	It's like I'm always the extra person. I don't fit in with anyone	That sounds lonely. Like you're always on the outside looking in	\N	\N	\N	\N	\N	\N
bfaf48a3-dcc6-46c3-9d42-99b6bd991beb	\N	\N	\N	\N	Yeah, even when I'm with people, I still feel alone	I've felt that before. It's exahsuting pretending you're OK all of the time	\N	\N	\N	\N	\N	\N
18f8f00f-42ef-41c7-9f57-c8feb3e7f8a5	\N	\N	\N	\N	I don't think I"ll ever have a real group of friends	Some people find their group of friends later than others. What if we start with one connection at a time? IS there anyone who feels even a little bit safe to talk to?	\N	\N	\N	\N	\N	\N
6a1fa228-9b55-482c-9bcd-210579568e73	\N	\N	\N	\N	Maybe Maya, she's quiet like me	That's a good start. Some people focus on depth of friendships, instead of crowds. You might be one of those peopel, and that's OK	\N	\N	\N	\N	\N	\N
f66e18f2-3db9-490e-9945-9747e80c6fdd	\N	\N	\N	\N	I just don't want to feel invisible anymore	Do you want to find one moment this week where you felt seen? Whether it was a message from Maya or a moemnet when you felt heard? Those small things all add up	\N	\N	\N	\N	\N	\N
023fe31f-bd36-4899-8a69-76b332ae4e63	\N	\N	\N	\N	Sure, I'll look through my phone and have a look.	\N	\N	\N	\N	\N	\N	\N
e48bcf8e-8579-4f07-8cfb-77868455c6b7	\N	P004	\N	\N	I messed everything up! The whole group is angry at me and we're going to fail	I hear how heavy that feels. You're carrying a lot of guilt right now.	\N	\N	\N	\N	\N	\N
5477c803-0be1-481a-adef-e3cd72ccd779	\N	\N	\N	\N	Because it's true! I missed the deadline. now the whole project is messed up	Missing a deadline is serious, but it doesn't mane thte whole project is ruined. Or that you are.	\N	\N	\N	\N	\N	\N
c8094881-adf4-47e5-8985-72f824c2de3c	\N	\N	\N	\N	I just want to fix it, but I don't even know how	What do you think the first step could be? An apology or taking the lead on fixing things up?	\N	\N	\N	\N	\N	\N
63f12da8-83c8-4690-8d58-59edea13fc4b	\N	\N	\N	\N	Maybe both, i'll message the group first	That sounds like a strong move. Some students recover really well after a mistake, beause they take responsibility and repair	\N	\N	\N	\N	\N	\N
4be2efef-216f-4355-9f8b-60752a7f3a7d	\N	\N	\N	\N	But what if they are still angry at me for a long time?	They may be angry for a while, and that's OK too. It doesn't define you. Repairing doesn't mean erasing the mistake. It means learning how to show up even after it.	\N	\N	\N	\N	\N	\N
b200d13a-67a7-4641-b77c-6410792fe0f1	\N	P004	\N	\N	I hate my face, I hate how I look in every single picture	It sounds like you're really frustrated with what you see in the mirror	\N	\N	\N	\N	\N	\N
b736072a-be21-4e69-a89a-fcad3735c03f	\N	\N	\N	\N	Yes, I feel aweful. Like I'm the ugly one in every room	That kind of self talk can be brutal. I wish you could see what I see when I look at you	\N	\N	\N	\N	\N	\N
fabb6c50-bf1a-4ea7-bc4a-6ae0b4bf952c	\N	\N	\N	\N	You're my parent, you have to say that	True, but I also know that so many teenagers feel this way, especially when social media is full of edited, filtered versions of poeple. It tricks our brain into thinking we're not good enough.	\N	\N	\N	\N	\N	\N
152305b2-780c-46ba-8a2b-67afd2f98f03	\N	\N	\N	\N	I just feel like I"ll never be OK wiht how I look	You're not alone. Some poeple try limiting their time online, or practicing self compassion in front of the mirror. Do you want to experiment with one of those and see how it feels?	\N	\N	\N	\N	\N	\N
67e4f937-97fe-4acf-bcd2-81ac83f89bc7	\N	\N	\N	\N	Maybe, I don't want to feel this way forever	You won't. We'll try together, at your pace.	\N	\N	\N	\N	\N	\N
0c1702c8-bc7c-4066-8fc4-99bac5fa2fd5	\N	P004	\N	\N	There's something that has gone really wrong, but I can't tell anyone. I'll just get judged	It sounds like you're carrying something really heavy, and alone	\N	\N	\N	\N	\N	\N
44475999-73bd-43b6-8392-b0cb73e7e75c	\N	\N	\N	\N	I am, but if i talk about it, people will think I'm weak or stupid	I understand your fear. Sometimes saying it outloud is the thing that helps us breath again	\N	\N	\N	\N	\N	\N
3c1a6cf3-a232-4394-b6f8-b5cc0d1c9a2b	\N	\N	\N	\N	I don't know, maybe. I just hate this feeling	What if we try this. Do you want to just tell me the part you're ready to say, or we can try that tomorrow. Whatever you prefer.	\N	\N	\N	\N	\N	\N
9fb6751c-a244-4649-83a0-c32fac40c6eb	\N	\N	\N	\N	OK, I'll tell you now. I failed two tests and I lied about it	Thank you for trusting me. That doesn't make you weak, it makes you human. Now we can figure out what to do next, together	\N	\N	\N	\N	\N	\N
1f653d5a-e511-4870-af2a-d1bd1397d0ed	\N	P004	\N	\N	What's the point? I try and try and nothing ever works out for me	Sounds like you're running on empty, as if the effort never matches the reuslts	\N	\N	\N	\N	\N	\N
520145b0-9161-4aa7-86a2-c4df298ba5d9	\N	\N	\N	\N	Exactly, everyone else succeeds. I always end up getting stuck	That's a hard spot to be in. Sometimes when we're overwhelmed, we don't need to push harder, we need a new approach	\N	\N	\N	\N	\N	\N
497a274c-1dfa-4ea5-af5c-604b106a6cc0	\N	\N	\N	\N	I don't even know what that means	It could mean smaller tasks, more breaks, or even different ways of learning. What if we focus on just one assignment right now?	\N	\N	\N	\N	\N	\N
a5da2693-a468-476f-ab5a-139219903bcd	\N	\N	\N	\N	I guess I could do one	One is a win One step builds the next	\N	\N	\N	\N	\N	\N
7cef7c83-c1a1-428e-a24d-934d8e2c50c8	\N	P004	\N	\N	They called me that word again. Right in the middle of the school hallway. No one even said anything or stood up for me	I'm so sorry that happened. That's not OK. And it must have felt awful to stand there and feel invisible	\N	\N	\N	\N	\N	\N
59b2a7dc-7441-4b6e-bf83-2816294f4615	\N	\N	\N	\N	Yes, like I don't even matter	You do matter. What they said wasn't just wrong, it was harmful. And it shouldn't go unnoticed	\N	\N	\N	\N	\N	\N
6afc7684-ccb2-4a78-b1b5-84d54e329b8d	\N	\N	\N	\N	I don't want to make it worse by reporting it	I understand that. Some people write it down first. Others talk it through with someone they trust. What would feel safest for you?	\N	\N	\N	\N	\N	\N
d7e1ba18-edf7-462b-9b9d-06bc08acbf95	\N	\N	\N	\N	Maybe I could write it down	That's a brave step. And we'll support you through it, however you choose to speak up.	\N	\N	\N	\N	\N	\N
ad629c91-6983-44c9-b474-47b8fed8475a	\N	P004	\N	\N	I sit down to study and nothing sticks. My brain feels like mush	Sounds like you're drained. Like your brain is trying to protect you by shutting down	\N	\N	\N	\N	\N	\N
8bf4fa41-6f74-48bf-9fde-acb4607002f5	\N	\N	\N	\N	Yes, and the more I fall behind, the more I panic. It's like I'm failing for the first time in my life	That must feel scary. You're used to doing well, and now it feels like it's all slipping away	\N	\N	\N	\N	\N	\N
aa9fdc5f-66cc-4b49-aa0d-95ac07ddbada	\N	\N	\N	\N	Exactly, I do't even recognise myself right now	When we're stuck in stress for too long, our brains go into freeze mode. Let's try one step togehter. What feels most urgent right now? Give me 2 things	\N	\N	\N	\N	\N	\N
7033a91a-bf69-4b97-9163-a7f860599319	\N	\N	\N	\N	Biology. I need to finish the lab report	Perfect. One page at a time. Your're not broken, you're burnt out. And we'll rebuild from there.	\N	\N	\N	\N	\N	\N
3eed8ae9-ca32-4500-8637-cf9475017d69	\N	P004	\N	\N	I think I know who I am, but I can't come out to them. They won't understand	That's a really big weight to carry. I can see you're scared. You deserve to feel safe	\N	\N	\N	\N	\N	\N
3b0b97b3-46ed-4b0a-9bf9-28b2e339afdd	\N	\N	\N	\N	I've gone over every word in my head, and it always ends with them not talking to me	That fear make sense. A lot of people go through this quietly at first, you're not alone. Some come out in stages, when it feels safer	\N	\N	\N	\N	\N	\N
8b34b541-ce69-490e-b362-ceabfecf0173	\N	\N	\N	\N	But if I'm hiding this, am I really being myself?	You're protecting yourself, and that's OK. Being careful doesn't mean you're not real. It means you're surviving.	\N	\N	\N	\N	\N	\N
0ac08162-94a7-48d3-87f1-9bce6ec67984	\N	\N	\N	\N	I just wish it didn't have to be this hard	I can hear how hard it is for you. I"m here with you. What do you want to do about this? What would be helpful?	\N	\N	\N	\N	\N	\N
05e68fcd-32f6-4ade-9723-4eb71b6ba6f2	\N	\N	\N	\N	To take the pressure off myself right now	Ok, that's great. Do you want to disucss this again with me in 1 week, or in 2 weeks? We can talk about it again then and make some decisions	\N	\N	\N	\N	\N	\N
235f151d-5848-460c-bce9-9a11140e97cb	\N	\N	\N	\N	Let's talk about it again in 2 weeks, I need some time	That sounds like a good plan	\N	\N	\N	\N	\N	\N
f7f3b306-f4af-4886-b74c-e18d6d1ae2e0	\N	P004	\N	\N	I don't know what's wrong with me. I just snap and start swinging on my chair	Nothing is wrong with you. It sounds like your body is in fight mode, and it starts very quickly	\N	\N	\N	\N	\N	\N
72e8cdf6-978c-4cb2-91b1-1915cae0da53	\N	\N	\N	\N	Yes, but now I'm suspended again Everyone thinks I"m just a problem child	You're more than your outbursts. That kind of anger usually has a reason. Let's try to figure out what is underlying it	\N	\N	\N	\N	\N	\N
ac7d7ff5-10de-434d-9913-c6e69de41e7e	\N	\N	\N	\N	I guess so...it's usually when people disrespect me, or even look at me the wrong way	That kind of hyper alert feeling makes sense if you've had to stay on guard for long periods of time. What would hlep your body feel safter in those moments? Do you want to think of a few things?	\N	\N	\N	\N	\N	\N
97f0b6d4-76fa-4c53-8a67-e72e5a78a4a0	\N	\N	\N	\N	Maybe music, or walking away?	That's a great start. We can build tools together, you're not alone in this	\N	\N	\N	\N	\N	\N
746c1130-931e-4dcb-949c-c4e908d4c7d3	\N	P004	\N	\N	They've just told me they're getting divorced. I didn't even know they were thinking about this	That's huge news to hear. No wonder your mind feels scrambled	\N	\N	\N	\N	\N	\N
f0599a28-a76f-4779-b997-f7e4607420da	\N	\N	\N	\N	i don't even know how to feel. Sad, angry, empty, all of it at once	All of that makes perfect sense. When the family unit shifts, it shakes everything	\N	\N	\N	\N	\N	\N
3e988484-5933-496e-a411-003eaccad91f	\N	\N	\N	\N	I just want everything to go back to normal	That's a very natural response. Some teens find it helpful to create new routines, tiny pieces of normal that they can control. Do you want to try that?	\N	\N	\N	\N	\N	\N
368748ab-18b7-4aad-9dcc-d0a0fff317bb	\N	\N	\N	\N	I guess writing it down in a diary could help, or not pretending that I'm fine	Both of your ideas sound like good options. And I"m here if you want to talk about it more	\N	\N	\N	\N	\N	\N
ff2f066c-64b5-4d97-8120-2ef99b5dab9e	\N	P004	\N	\N	Everytime I close my eyes, I see it agin. I can't sleep	I believe you. That kind of fear doesn't just switch off. It stays in the body	\N	\N	\N	\N	\N	\N
daaebb58-f273-4ef5-a6a1-b56b29fe6265	\N	\N	\N	\N	My heart races, I get sweaty and then I just lie there	That's your system stuck in alamr mode. What if we try calming it - take some slow breaths, some grounding techniques, or even something like a bedroom routine?	\N	\N	\N	\N	\N	\N
2be9b67e-7815-42f0-8c11-7c202300f82a	\N	\N	\N	\N	I don't think anything works	Some children try journaling, by writing out their scary thoughts and then writing a plan for the morning. Do you want to try that tonight?	\N	\N	\N	\N	\N	\N
1eae3f11-2f12-4772-adf7-83d6c7e7047a	\N	\N	\N	\N	OK, I"ll try that	We'll find something that works fo ryou, you're not alone in this	\N	\N	\N	\N	\N	\N
963ba660-3634-4b52-84f9-88dac17bbbd4	\N	P004	\N	\N	I wish I could be like everyone else, people think I'm weird.	You're feeling really left out, right?	\N	\N	\N	\N	\N	\N
c3399595-074e-48ca-b03d-0450d031fe18	\N	\N	\N	\N	Yes, I say something and people just stare at me or laugh	That must really hurt. Feeling different is tough, especially when other people don't understand you	\N	\N	\N	\N	\N	\N
6615ad7c-a6cf-4a76-88bc-f3d4dd0edb76	\N	\N	\N	\N	I try to fit in, but it never works	Some of the best people I know didn't feel as if they fit in when they were younger. Do you want to talk about what happened today?	\N	\N	\N	\N	\N	\N
26358ca5-c665-4a79-8224-d15969567813	\N	\N	\N	\N	I made a joke in class and everyone just stared at me	That sounds rough. What would help you next time? Do you want to practice your jokes on me first?	\N	\N	\N	\N	\N	\N
4bc6e912-ab75-44d9-8584-8e477dc53bbb	\N	\N	\N	\N	Maybe, that might help	Great, let's do it.	\N	\N	\N	\N	\N	\N
0ffcdf55-b2d7-4196-97d2-147fc7db6486	\N	P004	\N	\N	They're all doing it now, vaping behind school I told them that I wasn't going to do it, and they said I was a whimp	You were in a tough situation. Saying no takes real courage	\N	\N	\N	\N	\N	\N
0174868c-347d-4015-92f1-bbdeab3cdedc	\N	\N	\N	\N	Yeah, but now they treat me like I'm a baby	That pressure is real. But you stayed true to your values. And that shows strength	\N	\N	\N	\N	\N	\N
ea36a924-fefc-41a3-86b1-491eff0e8052	\N	\N	\N	\N	I just don't want to loose my friends	What would be most helpful right now? Would it help to talk to one of your friends one on one? Maybe one who seems most understanding? Who would be best to chat to?	\N	\N	\N	\N	\N	\N
74f68b28-d898-4d8d-8206-3fdc898607d8	\N	\N	\N	\N	I could try that but I don't want to make a big deal of it	Even one calm conversation can be very helpful and change the outcome. Do you want to think about which friend might be the best option to have a conversation with?	\N	\N	\N	\N	\N	\N
76c5c849-3191-4d77-97c6-e1b76fa37298	\N	\N	\N	\N	Yes, I think I will talk to Mohammed	That sounds like a great plan for now	\N	\N	\N	\N	\N	\N
4a69981c-fe12-430d-9886-574467f09f83	\N	P004	\N	\N	I get chosen last in every gym class	That must feel very embarrassing	\N	\N	\N	\N	\N	\N
2d10bfc6-cf32-4a33-bcd9-44ee38c8cd90	\N	\N	\N	\N	Yes, it feels like no one wants me on their team	That would be upsetting to most people. Do you think it's about your speed in group sports, or something else?	\N	\N	\N	\N	\N	\N
5c562cd7-e552-4abc-a84f-9389229ddb5a	\N	\N	\N	\N	I'm not fast, so they just skip me	That doesn't define your self worth. What do you want to do about it? Do you want to practice together with me, or ask a friend to practice with you?	\N	\N	\N	\N	\N	\N
c48baae0-cdfd-43e6-9ccc-2dfc7ee28fe8	\N	\N	\N	\N	Yes, I'd love to make a time where we can practice together	Great! You're worth more than just how fast you can run	\N	\N	\N	\N	\N	\N
6a7c6b49-2c84-47aa-b552-e005384ff118	\N	P004	\N	\N	I did so badly on the science test. My mum is going to kill me!	You sound really stressed. Do you want to talk about what happened?	\N	\N	\N	\N	\N	\N
4e12c092-de01-4b5c-82a0-b05cf3bc9c5e	\N	\N	\N	\N	I thought I had studied, but during the test I blanked out	Stress can really mess with your memory. It doesn't mean you didn't try hard	\N	\N	\N	\N	\N	\N
1f8ee074-b819-4174-8f48-c86346841d35	\N	\N	\N	\N	So what do I do now?	Do you want to go over the areas you missed out, or do you want me to help you write a message to your teacher to see if you can redo the test? We can do this together	\N	\N	\N	\N	\N	\N
d609db23-03ab-4bb3-9c86-6c335fc5ca66	\N	\N	\N	\N	OK, I just don't want to feel like a failure	You are not a failure, this is part of the learning process	\N	\N	\N	\N	\N	\N
9fe130bc-7d96-4c95-be4b-a544515b940f	\N	P004	\N	\N	Why did you and dad split up? Was it because of me?	No dear, it wasn't your fault	\N	\N	\N	\N	\N	\N
074d139e-36e8-4e65-8fc2-68b278aed4a1	\N	\N	\N	\N	But everything has changed. I don't know where I belong anymore	I know, it's confusing and painful. You've been caught in the middle and that is very hard	\N	\N	\N	\N	\N	\N
79c8a1ff-d219-43cf-b684-7bd6db6a9f9f	\N	\N	\N	\N	Sometimes I feel like I'm the one being pulled back and forth	You are, and it's not fair. Lets make a plan so you feel a little bit more in control of this difficult situation. Do you want to decide where you'd like to sleep on the weekends, or on the weekdays?	\N	\N	\N	\N	\N	\N
a41a77fa-7388-41f0-b4c0-085de1c85be8	\N	\N	\N	\N	Yes, the weekends are important for me to be near my friends. So I'd like to stay with dad on the weekends	Great, lets make a plan together, as you're an important part of this family and you matter a lot	\N	\N	\N	\N	\N	\N
3c024ccc-02a1-446f-90bb-d994e11e9075	\N	P004	\N	\N	Everyone else seems ot have a plan, and I"m just stuck	That's a heavy feeling. Do you mean you feel behind?	\N	\N	\N	\N	\N	\N
17b78c38-a012-4d5b-808b-e8e43a0ea74a	\N	\N	\N	\N	Yes, I feel like I"m wasting time	You're not alone. Many people feel like this when they are in their 20's. How do you think you could manage this? Do you want to discuss one thing you feel curious about?	\N	\N	\N	\N	\N	\N
8c3f6c09-a739-4d84-9a68-596822b9f738	\N	\N	\N	\N	I really enjoyed voluteering at the shelter last year	That's a good place ot start. Let's see what could happen from there...	\N	\N	\N	\N	\N	\N
2eff15bf-4a40-4370-9bc5-d47951c75410	\N	P004	\N	\N	I feel like I"m a fraud. I always feel like I"m pretending to know what I am doing, and I don't really know!	It sounds like imposter syndrome has crept in...	\N	\N	\N	\N	\N	\N
1eac07d7-b093-4183-a078-b8c8ba817253	\N	\N	\N	\N	Yes, I always feel as if I'm one mistake away from being exposed	That's more common than you think, especially when it comes to new jobs. What's one area you feel confident in?	\N	\N	\N	\N	\N	\N
782a82ce-0b56-478d-b306-1a20fe1079a4	\N	\N	\N	\N	I love working with clients, but I find I don't know how to manage the admin part	It sounds like your confidence is with your clients. That's great. What can you do to help support yourself with the admin? Some people might choose to outsource it, and others may choose to take a short course. What do you think would work for you?	\N	\N	\N	\N	\N	\N
4adc6db2-9959-4187-ac51-f03cdebb7590	\N	\N	\N	\N	I think I'll outsource it, that would make life so much easier and I won't need to pretend I know what I'm doing when it comes to the accounts	\N	\N	\N	\N	\N	\N	\N
888282f2-2d11-47f3-a9f0-f8e16c386132	\N	P004	\N	\N	I don't even know if this is normal anymore. We fight all of the time, and I feel completely drained	That sounds exhausting. It sounds like you don't get much peace and quiet anymore	\N	\N	\N	\N	\N	\N
f17d1d5b-56aa-487e-a2de-a0dab2a802be	\N	\N	\N	\N	Yes, but I don't want to live alone either	That fear is real. But staying in pain also has a cost. Do you want to have a look at how you feel before, during and after your time together?	\N	\N	\N	\N	\N	\N
c3823322-0dbd-44c9-bb12-30c63a75fdf3	\N	\N	\N	\N	I could do that. Maybe it will make things clearer	Yes, we can make a time to disucss this	\N	\N	\N	\N	\N	\N
8f7ba8d8-0bb0-41cd-95a6-4a5a722dd262	\N	P004	\N	\N	I'm so tired, but I feel so guilty taking a rest	It sounds like you are running on fumes	\N	\N	\N	\N	\N	\N
1e22ca34-1633-4ec9-8e3c-36f0fd7096d2	\N	\N	\N	\N	I am, and everyone else seems to be able to manage so much better than me	You don't have to earn a rest by breaking down. You can pause before that point. What would one real pause look like to you?	\N	\N	\N	\N	\N	\N
58d6d1c3-e42e-40f1-8dfd-badef79580a7	\N	\N	\N	\N	Maybe turning off my phone for a weekend.	That sounds like a great start	\N	\N	\N	\N	\N	\N
5ab55754-c81d-4991-97ca-63a373ccce2b	\N	POO4	\N	\N	I got a C on that test. I knew I shouldn’t have even tried.	I can tell you’re really upset. Like your effort didn’t match the result.	\N	\N	\N	\N	\N	\N
bf62460b-589b-483d-9ec5-b450bf23b43e	\N	\N	\N	\N	It’s so embarrassing. Everyone else did better.	That’s a heavy feeling—like your grade defines your worth. But it doesn’t.	\N	\N	\N	\N	\N	\N
147e721f-7609-478d-9aff-b2f7095d9f2e	\N	\N	\N	\N	I just feel like a failure.	You’re not. And this one test doesn’t cancel everything you’ve been working on. Do you want to look at what tripped you up and what might help for next time?	\N	\N	\N	\N	\N	\N
8c31e75c-f60a-42fd-8877-e661e08529d9	\N	\N	\N	\N	Yeah… maybe I studied the wrong way.	That’s something we can adjust. Some students learn best by teaching others, or using visuals. Let’s explore what works for you.	\N	\N	\N	\N	\N	\N
f2059ab2-b719-4031-91f9-62b96f093316	\N	\N	\N	\N	Okay. That might help.	You’re learning—not failing. Let’s try again with tools that fit your brain.	\N	\N	\N	\N	\N	\N
87914c81-f172-4937-b15c-d3341b74eeb5	\N	P004	\N	\N	They ditched me again. They said they ‘forgot’—but that’s twice now.	That must sting. Like you’re the extra they can leave out.	\N	\N	\N	\N	\N	\N
0d818e81-6091-4db5-bbc4-24cb573ac1d6	\N	\N	\N	\N	Yeah. It’s like I’m not important unless they need something.	You deserve more than that. Want to talk about whether this is something to bring up—or something to step back from?	\N	\N	\N	\N	\N	\N
03112ddf-f1d7-4ace-9423-3ca7311de0ba	\N	\N	\N	\N	I don’t even know. I just feel stupid for caring.	Caring isn’t stupid—it means you value connection. But that connection should go both ways.	\N	\N	\N	\N	\N	\N
a5f79f98-529b-4515-9b82-1893511bf566	\N	\N	\N	\N	What if I confront them and they just laugh it off?	Then at least you’ll know you were honest. Do you want help planning how to say it in a way that protects your peace?	\N	\N	\N	\N	\N	\N
1b407851-bf2c-44eb-bca3-166fa53ef35d	\N	\N	\N	\N	Yeah. That would help.	We’ll figure it out together. You’re allowed to expect respect.	\N	\N	\N	\N	\N	\N
17caaf54-7cc1-47c8-b8ee-52c399addf8b	\N	P004	\N	\N	Every time I get an interview, I freeze. I look fine, but inside I’m panicking.	Sounds like your body is going into stress mode, even before the questions start.	\N	\N	\N	\N	\N	\N
9d5eedbe-8ad0-4317-aea1-904c9adbebbb	\N	\N	\N	\N	Yeah. I can’t think straight. Then I hate myself after.	That’s a rough loop. What helps some people is rehearsing the pressure moments—like mini exposure therapy. Do you want to try?	\N	\N	\N	\N	\N	\N
6a6e0251-73bd-4150-8ec1-ef1baa956056	\N	\N	\N	\N	Maybe. But I feel so fake doing that.	You’re not being fake. You’re training your brain to recognize that you’re safe. Kind of like rewiring an alarm system.	\N	\N	\N	\N	\N	\N
8d89b37d-bcb2-491a-900a-49d8feb87efa	\N	\N	\N	\N	Okay… maybe we can try one question now?	Great. Let’s start with one—and breathe through it together.	\N	\N	\N	\N	\N	\N
3eb311de-7e27-432c-996e-d2e21e22ba05	\N	P004	\N	\N	I said yes to everything, and now I want to scream. I can’t keep up.	Sounds like you’re stretched thin and running on empty.	\N	\N	\N	\N	\N	\N
2c4ff8fd-cf5d-483e-93e1-a4cfdfd2506f	\N	\N	\N	\N	It’s my fault. I should be able to handle this.	That voice in your head is being really unforgiving. Can I offer a reframe?	\N	\N	\N	\N	\N	\N
fd0185f7-f2d8-424d-931a-36aec7e37dec	\N	\N	\N	\N	Sure.	What if saying no isn’t a failure—but a sign of strength and self-awareness?	\N	\N	\N	\N	\N	\N
765ddd2e-de88-40b1-b483-21b00b420272	\N	\N	\N	\N	I’ve never thought of it like that.	Many students learn the hard way that boundaries build resilience. Do you want to make a list of what could be paused this week?	\N	\N	\N	\N	\N	\N
0f4d0e1a-515c-4188-b46e-d8cd8ede66a0	\N	\N	\N	\N	Yes. Please.	Let’s protect your energy—on purpose.	\N	\N	\N	\N	\N	\N
f5be7b14-dd55-4468-830d-304dc9d02b73	\N	P004	\N	\N	Everyone else finished the assignment already. I haven’t even started.	You’re feeling behind—and maybe a little stuck?	\N	\N	\N	\N	\N	\N
a44d577b-c851-4f9a-90b4-15ed11269cf3	\N	\N	\N	\N	Yeah. And the more I think about it, the worse it gets.	I get it. When stress builds, our brains often shut down instead of speed up.	\N	\N	\N	\N	\N	\N
5b1e6d9b-6cd0-47da-8051-384feddb830b	\N	\N	\N	\N	I’m just not as smart as they are.	It’s not about smart—it’s about overwhelmed. Want to break it down together into one small next step?	\N	\N	\N	\N	\N	\N
44c6d125-d1b2-40b0-bc94-322626b34d70	\N	\N	\N	\N	I guess I could just open the doc and write the title.	That’s a great first step. One small move beats a perfect plan you can’t start.	\N	\N	\N	\N	\N	\N
0677f7d4-1216-4f26-8042-0547a8a6849a	\N	\N	\N	\N	Okay. One step. I can try that.	And I’ll be here if you get stuck. You don’t have to do it alone.	\N	\N	\N	\N	\N	\N
046983a0-2092-4c11-8ac2-6731893e34f0	\N	P004	\N	\N	Everyone’s posting like they’re perfect. I feel like a loser in comparison.	Social media has a way of showing everyone’s highlights, not their real life.	\N	\N	\N	\N	\N	\N
080ebf86-6267-4adc-b30d-955ba157e154	\N	\N	\N	\N	But even their bad days look better than mine.	It’s easy to forget how filtered things are. Would you want to take a short break from it together?	\N	\N	\N	\N	\N	\N
dbfc40ed-1de2-4698-b919-d0e306599d10	\N	\N	\N	\N	I don’t know. I feel like I’d miss out.	FOMO is real. But sometimes JOMO—the joy of missing out—can give your brain a break. Want to try one hour and check in?	\N	\N	\N	\N	\N	\N
c707eb6b-ca7d-4862-a8db-f5d1aed73a8d	\N	\N	\N	\N	Yeah... maybe.	I’ll be your check-in buddy. One hour off isn’t forever—but it could help.	\N	\N	\N	\N	\N	\N
159035e9-399d-4d5d-871a-4eee734faea4	\N	P004	\N	\N	No one even notices when I’m home. I could disappear and it wouldn’t matter.	That sounds incredibly lonely. Like you're shouting inside and no one hears.	\N	\N	\N	\N	\N	\N
c72c352c-a71c-4747-96e7-88de59bbf6b8	\N	\N	\N	\N	Exactly. I just stay in my room because what’s the point?	That space might feel safe—but it also sounds like you’re craving connection. Want to talk about one way to feel seen?	\N	\N	\N	\N	\N	\N
bc3e06b0-b9b5-479c-9529-a06692cc4343	\N	\N	\N	\N	Like what?	Maybe something small, like choosing the dinner or suggesting a movie? You matter, even if they don’t always show it well.	\N	\N	\N	\N	\N	\N
a67ad496-b9d3-49be-8685-f0949588ab76	\N	\N	\N	\N	Okay. I might try that.	And I’ll be here to help if it feels too hard. You’re not invisible to me.	\N	\N	\N	\N	\N	\N
ad7166f1-3b98-4a0f-a899-ec04d5559f5b	\N	P004	\N	\N	What if I pick the wrong major and ruin everything?	That’s a big fear—like one choice will decide your whole life?	\N	\N	\N	\N	\N	\N
98d0e115-76a6-48e4-81cb-eba903ea5436	\N	\N	\N	\N	Yes! And I don’t even know what I’m good at.	It’s totally okay to not have it all figured out. Want to explore what lights you up instead of what locks you in?	\N	\N	\N	\N	\N	\N
31ab55fd-39cf-4a54-87dd-e0f08486fcc5	\N	\N	\N	\N	Maybe. But I still feel lost.	Lots of people feel that way. Think of this as version 1.0—you can update as you learn.	\N	\N	\N	\N	\N	\N
a4e27eee-cf35-40cb-9469-bce9c9c0e379	\N	\N	\N	\N	Okay. That feels a little better.	One step at a time. Your path can bend—and still move forward.	\N	\N	\N	\N	\N	\N
f8c91380-38d7-4c4c-b100-c0fd6bc86183	\N	P004	\N	\N	I’m freaking out. The math test is tomorrow and I just know I’m going to fail.	Sounds like your mind is really full right now. Do you want to take a breath with me first?	\N	\N	\N	\N	\N	\N
c2cf48eb-8a75-4a4c-a858-4a457005d7bf	\N	\N	\N	\N	Okay…	You’re not alone. A lot of people feel pressure before big tests. What part feels the scariest?	\N	\N	\N	\N	\N	\N
c3878dc1-2da5-44b7-bbc9-2349c16799e9	\N	\N	\N	\N	That I’ll blank out and not remember anything.	That makes sense—our brains sometimes freeze under pressure. Can we practice a calming technique that helps bring you back when that happens?	\N	\N	\N	\N	\N	\N
552b2c78-2f4d-40da-b8ac-a45ac169efb5	\N	\N	\N	\N	Like what?	One way is to pause and name 3 things you can see, 2 things you can touch, and 1 thing you can hear. It brings you into the present. Do you want to try it now?	\N	\N	\N	\N	\N	\N
8852cc1f-ea81-4e62-b06c-5f645caa8028	\N	\N	\N	\N	Okay… I see your desk, the board, and the window… I feel the chair and my pencil…	Perfect. That’s how we tell the brain we’re safe. Your knowledge is still there—it just needs a calmer space to show up.	\N	\N	\N	\N	\N	\N
9246fb94-98c7-4fec-8e8a-9e997cebb412	\N	P004	\N	\N	I sit alone at lunch almost every day. No one even looks at me.	That sounds really lonely. I’m glad you told me—it takes courage.	\N	\N	\N	\N	\N	\N
3fa87aac-fce2-40fb-bdae-46b0b786e157	\N	\N	\N	\N	It just feels like I don’t matter.	I hear you. That feeling can be really heavy. Can we take a minute together to just breathe and be in this moment?	\N	\N	\N	\N	\N	\N
88f4577e-d587-4909-b2f8-dec0efd1af5c	\N	\N	\N	\N	Yeah… okay.	Thank you. Let’s look at something together—sometimes when people seem distant, they’re caught up in their own worries. Do you want to talk about someone you wish would notice you more?	\N	\N	\N	\N	\N	\N
497a1fa5-41da-4b22-a88a-81c2b843e2f8	\N	\N	\N	\N	Like what?	Maybe that you care about belonging. We can work on ways to express that *without* shutting down or lashing out.	\N	\N	\N	\N	\N	\N
ef98d507-563d-4822-aa6f-0bc9191fbe07	\N	\N	\N	\N	There’s a kid in my science class I think is kind. But I never know what to say.	That’s a great start. We can practice together. You matter. And we can build ways to help others see that too.	\N	\N	\N	\N	\N	\N
ca4a894d-9839-49ef-aa47-5507823f9553	\N	P004	\N	\N	I can’t stop thinking about how awkward I sounded at that party. I keep replaying it.	That sounds exhausting—like your brain won’t give you a break.	\N	\N	\N	\N	\N	\N
6b2de830-f0f5-4030-9fb9-164e9fb1a621	\N	\N	\N	\N	Yeah. I wish I could just forget it.	I get that. Do you want to pause and breathe for a sec, just to give your body a reset?	\N	\N	\N	\N	\N	\N
796229ed-d1a7-4331-95b5-a8ddc169079f	\N	\N	\N	\N	Okay…	What if we looked at it a little differently? You’re focusing on one moment—but what else happened that night?	\N	\N	\N	\N	\N	\N
42769722-ef84-4f57-a197-005c65722872	\N	\N	\N	\N	I did make a few people laugh later on…	Exactly. Our minds latch onto what felt wrong, but that’s only part of the story. You’re more than one awkward sentence.	\N	\N	\N	\N	\N	\N
f6048e52-5382-47a7-9c12-b898766e0fe4	\N	P004	\N	\N	I’m never going to be as good as everyone else. I don’t even know why I try.	That’s a hard thought to carry. Can we just sit with it together for a second?	\N	\N	\N	\N	\N	\N
be43b7a9-efb1-4239-a6b6-9f4fa4e7fb77	\N	\N	\N	\N	Sure.	Thanks. That voice in your head is trying to protect you from disappointment—but it’s not telling the full truth.	\N	\N	\N	\N	\N	\N
835b0b89-09ea-4c3c-9868-3c1ad08c6af3	\N	\N	\N	\N	What do you mean?	Trying is an act of courage. It means you’re choosing to grow. Do you want to talk about one area where you’ve improved—even just a little, or do you want to talk about something else?	\N	\N	\N	\N	\N	\N
bae80c33-0b50-43b2-8bad-738cc8cbd1c5	\N	\N	\N	\N	Let's talk about where I've made progress. I guess I’ve gotten better at talking in class…	That matters. Growth often hides in small steps. You’re not falling behind—you’re building forward.	\N	\N	\N	\N	\N	\N
0ff73162-8733-40db-a57c-fadeb68cb779	\N	P004	\N	\N	I looked in the mirror this morning and I felt disgusting. I didn’t even want to come to school.	That’s such a painful experience. I’m so sorry you felt that way.	\N	\N	\N	\N	\N	\N
efa4fa66-b799-41e8-a677-fd2d966b6517	\N	\N	\N	\N	It just doesn’t stop. I hate how I look.	Let’s breathe together for a moment. These feelings can overwhelm us fast.	\N	\N	\N	\N	\N	\N
42c0edd0-397c-4676-a1dc-669a9305c0cd	\N	\N	\N	\N	*(breathes)*	Thank you. That moment of self-hate is your mind reacting to pressure and comparison. It doesn’t define your worth.	\N	\N	\N	\N	\N	\N
ef12e474-6c7c-4f73-81fd-52479bf12488	\N	\N	\N	\N	But I still feel like everyone sees what’s wrong with me.	Our brains are wired to look for danger—and sometimes, that danger is imagined. Do you want to talk about what your body does for you, instead of how it looks?	\N	\N	\N	\N	\N	\N
cf33ee79-c869-4076-94fe-7d7b83318a43	\N	\N	\N	\N	I guess it lets me run. And I like dancing sometimes.	That’s beautiful. Let’s make space for gratitude alongside the hard thoughts. You are more than your reflection.	\N	\N	\N	\N	\N	\N
7308f9d2-9f73-4429-a05e-7c9ed698c608	\N	P004	\N	\N	I’m freaking out. The math test is tomorrow and I just know I’m going to fail.	Sounds like your mind is really full right now. Want to take a breath with me first?	\N	\N	\N	\N	\N	\N
f2227fd0-1454-427b-b563-c70e6339aa3f	\N	\N	\N	\N	That I’ll blank out and not remember anything.	That makes sense—our brains sometimes freeze under pressure. Do you want to practice a calming technique that helps bring you back when that happens?	\N	\N	\N	\N	\N	\N
f7317c67-71db-4649-9961-f4d31571d06f	\N	\N	\N	\N	Like what?	One way is to pause and name 3 things you can see, 2 things you can touch, and 1 thing you can hear. It brings you into the present. Want to try it now?	\N	\N	\N	\N	\N	\N
6837e9cc-b3b0-49d0-8c60-1bb028de0fdb	\N	P004	\N	\N	I sit alone at lunch almost every day. No one even looks at me.	That sounds really lonely. I’m glad you told me—it takes courage.	\N	\N	\N	\N	\N	\N
dcae1141-05b7-4eb7-9317-29af94325fef	\N	P004	\N	\N	I can’t stop thinking about how awkward I sounded at that party. I keep replaying it.	That sounds exhausting—like your brain won’t give you a break.	\N	\N	\N	\N	\N	\N
19ed451b-176c-4db7-a4d0-3a60db445d83	\N	\N	\N	\N	Yeah. I wish I could just forget it.	I get that. do you want to pause and breathe for a sec, just to give your body a reset? Or do you want to continue talking about this?	\N	\N	\N	\N	\N	\N
30554739-cd4d-4190-ae9d-1a95f4fdcdc8	\N	\N	\N	\N	Okay…let's pause for a minute	What if we looked at it a little differently? You’re focusing on one moment—but what else happened that night?	\N	\N	\N	\N	\N	\N
bfe4d86f-8885-44ac-ad67-ee6f227f222e	\N	P004	\N	\N	I can’t sleep. Every time I close my eyes, I think about the news.	It sounds like your brain is staying on high alert. That’s a normal reaction to scary things.	\N	\N	\N	\N	\N	\N
33f93de5-d009-43f0-aaee-4169de40a436	\N	\N	\N	\N	I keep hearing the sirens in my head.	It’s like your nervous system doesn’t know the threat is over. Do you to try something to help calm your body?	\N	\N	\N	\N	\N	\N
1fb27e05-ee25-4cae-963e-61bd132a1325	\N	\N	\N	\N	Like what?	Let’s try pushing your feet into the ground and noticing the support. You’re safe right now. Want to try?	\N	\N	\N	\N	\N	\N
2c159a2d-b676-423f-a180-980b7a91702f	\N	\N	\N	\N	Okay.	You’re doing great. We can also make a routine for bedtime—something that signals safety, like a warm drink or soft music.	\N	\N	\N	\N	\N	\N
12e48f60-5748-4534-a99c-60a03dc2a643	\N	P004	\N	\N	My mom’s always yelling at me. I try to stay calm but it never works.	That sounds incredibly frustrating. Like no matter what you do, it blows up?	\N	\N	\N	\N	\N	\N
35365b2a-2703-4618-a8b8-ef718543a5dd	\N	\N	\N	\N	Exactly.	I hear how much you’re trying. Want to map out some things you can control in those moments?	\N	\N	\N	\N	\N	\N
1f5276b1-9a69-4855-960e-9c7975e01241	\N	\N	\N	\N	Like walking away?	Yes. That’s a powerful strategy. Also, learning to name how you feel without it escalating. Do you want to practice that together?	\N	\N	\N	\N	\N	\N
5bbf5541-3792-42d8-9aa3-be254dd8f5a0	\N	\N	\N	\N	I guess.	I’ve got you. Let’s start with, “I’m not feeling heard right now.” Small shifts can open big doors.	\N	\N	\N	\N	\N	\N
9e57a509-f2be-4c34-8dca-97d630f1caba	\N	P004	\N	\N	If I mess up at the game tomorrow, the coach will bench me.	I can feel how heavy that pressure is. Let’s take a breath and slow down for a sec.	\N	\N	\N	\N	\N	\N
b2279a14-753c-49ab-b460-048efa10007f	\N	\N	\N	\N	Okay.	Thanks. Performance pressure is real—but it doesn’t have to own you. Do you want to explore what part you can control?	\N	\N	\N	\N	\N	\N
99b32c9e-0353-4b04-8ebc-09f0e5a29b22	\N	\N	\N	\N	Like my effort?	Exactly. You can’t control outcome or coach’s mood—but you can show up, breathe, and focus on your game.	\N	\N	\N	\N	\N	\N
0682ca58-5c7d-432a-82aa-66052095e4b1	\N	\N	\N	\N	That helps.	You’ve trained for this. Let the moment be about *presence*, not perfection.	\N	\N	\N	\N	\N	\N
da5b7dd1-6519-4870-99c1-a0189019e552	\N	P004	\N	\N	Someone’s been posting stuff about me online. It’s getting worse.	I’m so sorry that’s happening. You don’t deserve that.	\N	\N	\N	\N	\N	\N
75011f17-4779-4bec-ab55-bcb3b6f5e425	\N	\N	\N	\N	It makes me not want to go to school.	I can see how that would make you want to shut down. Can we look at options together?	\N	\N	\N	\N	\N	\N
38c7d793-e073-4b05-a51c-325c92f55137	\N	\N	\N	\N	Like reporting it?	Yes. And also building your team—trusted adults, peers, and safe spaces. You don’t have to handle this alone.	\N	\N	\N	\N	\N	\N
fa76affd-5d17-47be-97f0-c8a90ab490a7	\N	\N	\N	\N	Okay. Will you help me?	Absolutely. We’ll face this together. And we’ll remind your brain: this is not your fault.	\N	\N	\N	\N	\N	\N
9785363c-1b4c-4c0a-a9c5-a257303a103f	\N	P004	\N	\N	They had a whole group hangout and didn’t even invite me.	That hurts. You were hoping to be included, and it stings to be left out.	\N	\N	\N	\N	\N	\N
f9508c3c-bdbd-4cb5-b803-6eabe1c7d64b	\N	\N	\N	\N	I don’t even want to talk to them now.	That’s valid. It’s okay to feel hurt. Do you want to explore what that feeling is trying to tell you?	\N	\N	\N	\N	\N	\N
726c90b8-c116-417a-9a2f-e635ebf0fef8	\N	\N	\N	\N	Sure, I'll look through my phone and have a look.	\N	\N	\N	\N	\N	\N	\N
84f6add3-ebc4-4823-89ae-e4f355bc6467	\N	\N	\N	\N	Yeah… maybe.	You matter, even when others don’t show it. Let’s figure out a step that helps you feel grounded again.	\N	\N	\N	\N	\N	\N
bfcb035b-8a94-45bd-876f-a02b7b5c962e	\N	P004	\N	\N	I don’t know who I am anymore. I feel lost.	That’s a powerful feeling—and a common one at your age. Do you want to sit with it for a moment together?	\N	\N	\N	\N	\N	\N
08907c49-af5a-4217-b682-4171a754e35d	\N	\N	\N	\N	It’s scary.	I hear that. Let’s ground ourselves in this moment first. Can you name one thing you know you care about? Or do you want to spend more time doing grounding exercises?	\N	\N	\N	\N	\N	\N
7279c7b7-f67f-4387-9339-26973e5aa4b9	\N	\N	\N	\N	let's talk about it. I care about art.	That’s something real. Your identity isn’t a fixed label—it’s something you’re shaping over time.	\N	\N	\N	\N	\N	\N
aa4ccddc-ea86-4a52-a987-2b4b9dd7ad8d	\N	\N	\N	\N	But what if I never figure it out?	It’s okay not to have all the answers. Let’s make space for exploration, not judgment.	\N	\N	\N	\N	\N	\N
859f55a6-d2c2-4372-8136-e37c8075cbbf	\N	P004	\N	\N	I saw someone get hurt near the store. I can’t stop thinking about it.	That must’ve been shocking and scary. I’m really glad you’re talking about it.	\N	\N	\N	\N	\N	\N
4bf97343-a4ea-432d-a395-735860db8d2d	\N	\N	\N	\N	I keep replaying it in my head.	That’s a trauma response. Your brain is trying to make sense of something big. Do you want to try grounding yourself in the here-and-now?	\N	\N	\N	\N	\N	\N
4483d57b-2cc1-4a4b-ad89-8efda4714bb9	\N	\N	\N	\N	How?	Can you press your hands into your thighs and name what’s around you right now?	\N	\N	\N	\N	\N	\N
377420a8-336f-48e3-9149-92b9b448e373	\N	\N	\N	\N	Okay… I see your pen, the window, the floor.	That’s it. You’re here. Safe. The memory is real, but it’s not happening now.	\N	\N	\N	\N	\N	\N
e475d68c-09e4-4800-97db-7d44f3e0a5f0	\N	P004	\N	\N	What if I don’t get into college? What if I never figure out my life?	Those are really overwhelming thoughts. Do you want to pause for a breath before we dive in?	\N	\N	\N	\N	\N	\N
4b09c20c-3a65-44b6-88d8-f4a3afc67424	\N	\N	\N	\N	Okay, that sounds good	Thanks. Let’s separate what you know from what your anxiety is guessing. What’s one step you’ve taken toward your goals?	\N	\N	\N	\N	\N	\N
683ca2ab-a643-42ec-80d4-9bd47bbe52fd	\N	\N	\N	\N	I applied to three schools already.	That’s a big step. Uncertainty is hard, but it doesn’t mean failure—it means you’re moving forward.	\N	\N	\N	\N	\N	\N
e7e741df-1af4-402f-ac0a-32ef40592876	\N	P004	\N	\N	I can’t stop crying since my dog died. It’s like my chest hurts.	Losing a pet is real grief. I’m so sorry you’re going through this.	\N	\N	\N	\N	\N	\N
a8e26809-df30-4b57-ab10-1d80335aaf4b	\N	\N	\N	\N	I keep expecting to hear his paws at the door.	Those moments of expectation—those are part of how we hold on. It means he mattered deeply.	\N	\N	\N	\N	\N	\N
7ecd1ae1-2582-4e6e-8e66-099de8e026c8	\N	\N	\N	\N	It feels silly to be this sad.	It’s not silly at all. Grief honors love. Do you want to share a memory of him with me?	\N	\N	\N	\N	\N	\N
ebf51039-d72a-4590-bac0-ae8c983bb033	\N	\N	\N	\N	He used to curl up next to me when I was sick.	That’s such a beautiful connection. Your pain is the shape of that love.	\N	\N	\N	\N	\N	\N
8a484e96-01ae-4b61-b02d-41134bb478ab	\N	P004	\N	\N	I’m just done. I don’t care about classes anymore. I’m too tired.	That sounds like burnout—not laziness. You’ve been pushing hard, haven’t you?	\N	\N	\N	\N	\N	\N
638536da-c9eb-46d8-84ed-f973abc50d1a	\N	\N	\N	\N	Yeah. I haven’t had a real break in months.	Your brain and body are telling you something important: it’s time to slow down. Do you want to talk through what rest could look like?	\N	\N	\N	\N	\N	\N
bddbe237-9590-453e-9eec-15781f239dd9	\N	\N	\N	\N	Like skipping assignments?	Maybe pausing non-urgent tasks, or asking for extensions. Rest isn’t quitting—it’s refueling.	\N	\N	\N	\N	\N	\N
8a38d9dd-2ef3-476d-8303-046c24c78697	\N	\N	\N	\N	That helps. I feel less guilty now.	You deserve space to breathe. Burnout is a signal—not a personal failure.	\N	\N	\N	\N	\N	\N
8a813ee6-72ce-4eab-92a1-f51d56480775	\N	P004	\N	\N	My best friend and I haven’t talked in a week. I think she’s mad at me.	That silence must feel heavy. Want to talk through what happened?	\N	\N	\N	\N	\N	\N
acf0a354-355a-465b-b3a1-dfb377b5e93b	\N	\N	\N	\N	I don’t even know. One day we were fine, then nothing.	Uncertainty can be so painful. Let’s slow down and explore what you’re feeling underneath.	\N	\N	\N	\N	\N	\N
8be748b1-1453-4f14-815c-fdc021a444c5	\N	\N	\N	\N	Mostly hurt. And kind of ashamed.	Those feelings make sense. Do you want to write her a message together—one that shares honestly but gently? Or do you prefer to talk to her face to face?	\N	\N	\N	\N	\N	\N
c613ef3b-8057-44e9-a495-92a3695e37b3	\N	\N	\N	\N	Yeah… I think it might help to write her a message	Let’s try it. You’re not alone in this.	\N	\N	\N	\N	\N	\N
6505e4e1-c9f1-4df6-939a-d7b29901bf88	\N	P004	\N	\N	I got triggered during class and couldn’t focus. It felt like I was floating.	That sounds like dissociation—like your body was present but your mind was protecting you.	\N	\N	\N	\N	\N	\N
2e62d38a-6b10-49c6-a132-a6417f04b5dd	\N	\N	\N	\N	Yeah, exactly.	It’s more common than you think. Do you want to try a few grounding tricks together?	\N	\N	\N	\N	\N	\N
569bcf1d-8d46-470a-83b8-cda4d00c1e1a	\N	\N	\N	\N	Okay.	Let’s push your feet into the floor. What do you feel?	\N	\N	\N	\N	\N	\N
78367a56-d408-46a0-bbc1-5b88a5df5309	\N	\N	\N	\N	The carpet. My socks.	My voice is here with you. This moment is safe. We can talk through what happened when you’re ready.	\N	\N	\N	\N	\N	\N
7741bb6b-268a-4d5b-ab72-d86bc8c8525a	\N	P004	\N	\N	I hate how I freeze when someone yells. Even if they’re not yelling at me.	That’s a trauma response—your body is remembering something old and reacting to it now.	\N	\N	\N	\N	\N	\N
5d568279-c03f-4bdd-a02d-5973d9eb8904	\N	\N	\N	\N	It’s embarrassing.	There’s nothing wrong with you. This is your nervous system trying to protect you. Do you want to learn ways to feel more in control when that happens, or do you prefer to continue talking about it?	\N	\N	\N	\N	\N	\N
4e2d4e3f-f727-4b2b-9fc9-87c9c6608b9c	\N	\N	\N	\N	Let's learn some techniques	I’ve got a few tricks—like squeezing something in your hand or tapping your fingers. We can practice this together.	\N	\N	\N	\N	\N	\N
b7a15f5e-ea05-4f84-94d8-03fd43c04b32	\N	P004	\N	\N	I feel like I don’t fit anywhere—not at school, not even at home.	That sounds like you’re holding a lot of loneliness. I’m really glad you said something.	\N	\N	\N	\N	\N	\N
7533a568-e9a2-42b0-b55d-0284bfd00017	\N	\N	\N	\N	I just pretend to be someone else so I don’t get judged.	That kind of masking is exhausting. Let’s take a breath and just let you be fully yourself for a second.	\N	\N	\N	\N	\N	\N
5c6c56d6-d7ba-49ba-90b0-5a5247314280	\N	\N	\N	\N	Okay.	Thank you. You matter just as you are. Do you want to think together about where your people might be?	\N	\N	\N	\N	\N	\N
ad5ebfe8-7d75-4965-b0a2-a9e7720e0bd5	\N	\N	\N	\N	Yeah.	I’m with you in this. We’ll find places you belong.	\N	\N	\N	\N	\N	\N
381623e3-2427-4897-89e4-1f6ef6ff469b	\N	P004	\N	\N	Every time someone raises their voice, I flinch. I hate that I do that.	Your body is remembering past danger. That flinch is a survival response—not weakness.	\N	\N	\N	\N	\N	\N
1915a63b-08e7-4872-b754-3daca00b41fa	\N	\N	\N	\N	I feel broken.	You’re not broken. You adapted to protect yourself. And now we can build new safety signals.	\N	\N	\N	\N	\N	\N
a253abb2-ddbb-42aa-9270-a1e97d4f466f	\N	\N	\N	\N	How?	One way is to practice naming that the present moment is different. Do you want to try together?	\N	\N	\N	\N	\N	\N
7663666c-0520-48f5-862d-69c24edf2d63	\N	\N	\N	\N	Yeah.	Okay—“Right now I’m safe. Right now I’m okay.” Say it with me.	\N	\N	\N	\N	\N	\N
146c3d00-5dd1-4c6b-8eb9-10ff4eafff0b	\N	P004	\N	\N	I get so anxious I feel like I’m going to throw up before I speak in class.	That kind of anxiety shows up in the body—it’s real. Let’s take one breath together to calm your system.	\N	\N	\N	\N	\N	\N
44a00feb-045a-4608-96c6-b9f19b586c5e	\N	\N	\N	\N	Okay…	Good. That was a strong first step. Your body’s reacting like you’re in danger—but we know you’re safe right now.	\N	\N	\N	\N	\N	\N
ad1e933c-6c1d-4acd-807a-ca22f4285316	\N	\N	\N	\N	It doesn’t feel like it. Everyone’s staring and I freeze.	Freezing is your brain’s way of trying to protect you. Can we plan together how you might ease into speaking?	\N	\N	\N	\N	\N	\N
6f1fc444-8ba5-4926-8404-5146934c9e5f	\N	\N	\N	\N	I guess. Maybe I could write notes or ask to go later in class.	Those are great control options. You’re not avoiding—you’re preparing.	\N	\N	\N	\N	\N	\N
f5a3b7cd-dd5b-42c2-8d31-b4507c6c9631	\N	\N	\N	\N	It would help if I had a backup plan, just in case.	Absolutely. Let’s create a script or grounding tool you can keep in your pocket. Confidence comes from practicing safety.	\N	\N	\N	\N	\N	\N
02a1a948-533f-43c5-a00b-864cacfa1817	\N	P004	\N	\N	I haven’t told anyone, but I think I might be depressed. I’m just… empty.	Thank you for saying that. I hear the weight you’re carrying.	\N	\N	\N	\N	\N	\N
6ca0130a-c8a9-4033-bd52-432eda796fc9	\N	\N	\N	\N	It’s like nothing matters. And I’m tired all the time.	Those are serious signs—and you’re not alone. Depression can feel like a fog that blocks your view of what’s good.	\N	\N	\N	\N	\N	\N
0cd485a2-876f-4c80-a9ba-07cc5b606490	\N	\N	\N	\N	What if people think I’m weak?	It actually takes strength to speak up. You’ve already done something strong. Do you want to talk about next steps, gently?	\N	\N	\N	\N	\N	\N
c168d0bc-adc2-406d-93fd-6c43946b949b	\N	\N	\N	\N	Like what?	We could start by talking to a counselor. Or even journaling your thoughts each night. Small actions can reconnect you to hope. What would you prefer?	\N	\N	\N	\N	\N	\N
5ad7509e-4d70-465d-8e0d-1e60c4811a89	\N	\N	\N	\N	I’d try journaling. I’m not sure I’m ready to talk.	That’s totally okay. This isn’t a race. Let’s choose what feels safe—and keep checking in.	\N	\N	\N	\N	\N	\N
3043c296-176d-4033-b268-2aa027014298	\N	P004	\N	\N	My older sibling is always making fun of me. I laugh it off, but it hurts.	Mocking from someone close really stings. I’m glad you shared it.	\N	\N	\N	\N	\N	\N
b7b59eb2-a848-4257-9723-c9b6466d25e7	\N	\N	\N	\N	It makes me feel small. But when I say something, they say I’m “too sensitive.”	That’s gaslighting—and it erodes your confidence. Let’s build a sentence you can use to hold your space.	\N	\N	\N	\N	\N	\N
858c3453-1774-4834-bff2-3e8a2abec2dd	\N	\N	\N	\N	Like what?	How about, “I’m not okay with being talked to that way—it crosses a line for me.” Firm but calm.	\N	\N	\N	\N	\N	\N
ce12169a-f50c-488e-a785-4f456ae69de8	\N	\N	\N	\N	What if they ignore me or laugh more?	Then you follow up with action: walking away, setting distance, or telling an adult. You can’t control them—but you can protect your peace. Which options sound good to you?	\N	\N	\N	\N	\N	\N
839700ab-8410-4c1a-bb91-dc4998d9f0c1	\N	\N	\N	\N	I like the sentence. I want to try it.	Let’s practice it together now, so it feels stronger when you need it.	\N	\N	\N	\N	\N	\N
e30be585-f9fc-476f-a176-c4916d4b1922	\N	P004	\N	\N	I can’t focus on anything anymore. My brain feels foggy all the time.	It sounds like your mind is overloaded—not broken.	\N	\N	\N	\N	\N	\N
4e3c6aa2-d14a-4895-b0da-a2b080d26c95	\N	\N	\N	\N	I just keep forgetting stuff. Even simple things.	Stress can shrink focus. Want to map out what’s taking up most of your mental energy?	\N	\N	\N	\N	\N	\N
3c8cd72f-15a9-40de-b5f6-d4dfcabf7db5	\N	\N	\N	\N	School, my parents arguing, and not sleeping.	That’s a lot for one person. We can’t fix everything at once—but we can add a few things that bring clarity back.	\N	\N	\N	\N	\N	\N
2a9c66b7-e6b5-4a7c-8eb0-c92ded481f34	\N	\N	\N	\N	Like what?	Tiny wins: a daily walk, a phone-free hour, a planner, breathing breaks. Which one feels doable?	\N	\N	\N	\N	\N	\N
c6f71f59-9e34-4af2-9238-5b3964cdbfe9	\N	\N	\N	\N	Maybe the walk. I miss fresh air.	Perfect. Let’s build from there. Clarity starts with care.	\N	\N	\N	\N	\N	\N
39c07420-a5c3-4a0e-9042-ad953f8a6c51	\N	P004	\N	\N	I keep having nightmares. I wake up sweating and scared.	It sounds like your brain’s trying to process something—even while you sleep.	\N	\N	\N	\N	\N	\N
9f0796eb-ecdf-46f1-819f-130a71814fa3	\N	\N	\N	\N	Yeah. I don’t even want to go to bed anymore.	That’s real. Avoiding sleep is your way of trying to stay safe. What helps calm you down after a nightmare?	\N	\N	\N	\N	\N	\N
7b8b6e5c-5370-4a97-b08c-0238ef6f4c75	\N	\N	\N	\N	Turning on a light. And holding my blanket tight.	That’s great. Your body is already doing self-soothing. Do you want to build a bedtime ritual around safety?	\N	\N	\N	\N	\N	\N
b5fa3310-2ac9-49cd-89f9-e27b6a50e3a2	\N	\N	\N	\N	Like what?	Maybe calming music, a sleep story, drawing a symbol of safety near your bed. We can make it yours. You can choose	\N	\N	\N	\N	\N	\N
7b6fa045-1552-4f7f-be1d-70f482d1e2a1	\N	\N	\N	\N	Okay. That actually makes me feel a little better.	That’s the goal—more safety, less fear. You deserve restful nights.	\N	\N	\N	\N	\N	\N
9b3840cd-ee8f-4eb2-83dc-78f6d0818f15	\N	P004	\N	\N	Everyone’s talking about university, and I still have no clue what I want to do.	It’s totally okay not to know right now. That uncertainty doesn’t mean failure.	\N	\N	\N	\N	\N	\N
419300a7-ed72-4a34-88ab-c700c9538c42	\N	\N	\N	\N	But it feels like I’m falling behind.	You’re on your own path. Can we explore what you’re curious about instead of what box you’re “supposed” to fit into?	\N	\N	\N	\N	\N	\N
2f31ea06-8122-4ebe-a000-6613a13cc5dd	\N	\N	\N	\N	I like animals. And I’m good at helping people.	That’s a great start. You don’t need a final answer—just a direction to move toward.	\N	\N	\N	\N	\N	\N
8c7c6110-6bae-4a49-a642-c7be10e9517f	\N	\N	\N	\N	What if I make the wrong choice?	Most people change careers several times. Let’s look at options you can try or explore without committing forever.	\N	\N	\N	\N	\N	\N
b588ef16-75b5-454a-a6cc-6ba15698b8f9	\N	\N	\N	\N	Okay. Maybe I could volunteer or shadow someone.	Exactly. You’re not stuck—you’re experimenting. That’s how real decisions grow.	\N	\N	\N	\N	\N	\N
e6b66c53-4ae0-4096-9cfe-3a240ccd2188	\N	P004	\N	\N	I hate being in big groups. My chest tightens and I feel like I can’t breathe.	Social anxiety can feel like physical danger. Let’s pause for a moment—can we do a grounding breath?	\N	\N	\N	\N	\N	\N
967ed2b9-e001-4b87-9d85-cc8680072e4d	\N	\N	\N	\N	Sure.	You’re doing great. Now, what’s the part that feels hardest—being seen? Judged?	\N	\N	\N	\N	\N	\N
75a4aef5-1322-4f64-8a65-bcc86cc9efa1	\N	\N	\N	\N	All of it. I just want to disappear.	That’s your nervous system going into protect mode. But you’re not broken. Do you want to explore tiny steps that build safety, or do you prefer to continue talking about it?	\N	\N	\N	\N	\N	\N
38e2a9b8-e230-400b-b220-db2e9b130b40	\N	\N	\N	\N	Like what?	Entering early so it’s not a crowd, choosing one familiar face, holding something calming in your hand. Which one feels okay to try?	\N	\N	\N	\N	\N	\N
d11cc417-2a4e-4f43-8276-9ced9e95ebd6	\N	\N	\N	\N	Maybe the familiar face. I could stand near them.	Perfect. You’re not escaping—you’re building a bridge.	\N	\N	\N	\N	\N	\N
f9b027b3-c9c7-43e7-8297-f976e05000a0	\N	P004	\N	\N	I keep comparing myself to people on Instagram. I always feel worse after.	Social media can distort reality. What you’re seeing is curated, not truth.	\N	\N	\N	\N	\N	\N
99bba7cb-d6e2-44a0-9b5e-b5fab157c84e	\N	\N	\N	\N	But it still gets in my head. Everyone looks so perfect.	Your brain is reacting to illusion as if it’s real. Let’s name what’s real about you instead.	\N	\N	\N	\N	\N	\N
9ed3e3e4-e17f-4b89-9d31-b9a02116874c	\N	\N	\N	\N	Like what?	You show up. You care. You’re honest with your feelings. That matters more than filtered pictures.	\N	\N	\N	\N	\N	\N
6543b09e-85ed-42da-84d5-a2d0902f244e	\N	\N	\N	\N	I still want to scroll. I don’t know how to stop.	Do you want to build a “scroll with intention” plan. Time limits, accounts that inspire instead of shame, a check-in before and after.	\N	\N	\N	\N	\N	\N
8be48023-4597-41a7-a1d1-38d072150f4f	\N	\N	\N	\N	That sounds doable. Maybe 15 minutes, and only pages that make me feel good.	That’s control. That’s choice. You’re the one driving the experience.	\N	\N	\N	\N	\N	\N
75ee44eb-c36d-4605-8478-e9d7a439208b	\N	P004	\N	\N	My teacher embarrassed me in front of the class today. I just shut down.	That must’ve been painful. Being called out publicly can feel like an attack.	\N	\N	\N	\N	\N	\N
48b19588-01f7-4b10-bba5-3e1427c3710f	\N	\N	\N	\N	Everyone laughed. I wanted to disappear.	Shame does that—it tells us we’re small. But you are not the moment that happened. Do you want to talk through a response plan?	\N	\N	\N	\N	\N	\N
98d42e07-c1fc-4b8b-a163-0e1cc988d35e	\N	\N	\N	\N	Like saying something to the teacher?	Yes—either privately or with support. Even just writing it down can help you reclaim your voice.	\N	\N	\N	\N	\N	\N
3d4264d1-a1a9-4c3b-ae14-b6ec90bbf1bb	\N	\N	\N	\N	What if they don’t listen?	Then you did your part. You spoke up for yourself. That builds self-trust, even if the outcome isn’t perfect.	\N	\N	\N	\N	\N	\N
dfaa31be-5225-451b-a5ab-1669ee4d3d74	\N	P004	\N	\N	I don’t get invited to hangouts anymore. I think I’m being slowly pushed out.	That sounds really painful—like invisible rejection.	\N	\N	\N	\N	\N	\N
462648ca-36e7-4097-9a1d-fd5f46323480	\N	\N	\N	\N	Yeah. It hurts worse than a fight because it’s just… silence.	Silent exclusion can feel like erasure. Do you want to look at what you *can* do right now?	\N	\N	\N	\N	\N	\N
ba6d84bd-b3e8-4652-ba69-4f1495a3f1d9	\N	\N	\N	\N	Like text them? Or just move on?	Both are valid. You could name your feeling gently or shift your energy to people who see you.	\N	\N	\N	\N	\N	\N
b47ce546-528a-4479-a30c-a27b42d85061	\N	\N	\N	\N	I don’t want to seem desperate.	You won’t. “I’ve noticed some distance and miss being part of things” is brave, not needy.	\N	\N	\N	\N	\N	\N
21659fba-3333-4ef4-8c38-95555fcad48a	\N	\N	\N	\N	Okay. I’ll try sending something short.	That’s strong. You deserve friendships that make room for you.	\N	\N	\N	\N	\N	\N
e030e958-04c8-48fa-8504-0a6154c3d04d	\N	P004	\N	\N	I have so much to do, but I keep putting it off. Then I feel worse.	That sounds like the procrastination spiral—avoidance now, guilt later.	\N	\N	\N	\N	\N	\N
a5b09525-04ca-42cb-ae28-f7655147057f	\N	\N	\N	\N	Exactly. I know I’m doing it but I can’t stop.	Let’s look at what’s beneath it. Is it fear of not doing it well? Feeling overwhelmed?	\N	\N	\N	\N	\N	\N
8a9ed9a0-a8a6-4f81-9d96-648e62640486	\N	\N	\N	\N	All of the above.	I get it. Want to break it down into smaller pieces and pick the *easiest win* to start with?	\N	\N	\N	\N	\N	\N
201a1158-c86f-4f1d-89e4-be79f458b614	\N	\N	\N	\N	Maybe just opening the document.	Perfect. That one action tells your brain, “I’m showing up.” Then we build from there.	\N	\N	\N	\N	\N	\N
2053bfbb-895d-4eab-9331-9a176f9c10fb	\N	\N	\N	\N	So I don’t have to finish everything right now?	Exactly. Progress is movement, not perfection.	\N	\N	\N	\N	\N	\N
bbecd856-7714-48cd-8149-3ad25873b55d	\N	P004	\N	\N	I start things and never finish them. I lose motivation so fast.	That can feel really frustrating—like you’re letting yourself down.	\N	\N	\N	\N	\N	\N
850a75e0-48cd-43e3-b2ac-723d4cdfddae	\N	\N	\N	\N	Yeah, I feel lazy.	Let’s reframe that. You’re probably not lazy—you might just lose momentum without structure. Can we explore a system that works for your brain?	\N	\N	\N	\N	\N	\N
7b0016df-346a-4a24-9dd4-d6d6aec99791	\N	\N	\N	\N	Like what?	Short bursts with rewards. 20 minutes of focus, then a 5-minute break with music or movement. Want to try it or do you want me to give you another suggestion?	\N	\N	\N	\N	\N	\N
43bb52ee-61ff-4165-b0dc-aaf3d2468c2f	\N	\N	\N	\N	That sounds better than sitting for hours.	Exactly. Your brain might need rhythm—not punishment.	\N	\N	\N	\N	\N	\N
d8db8ac7-94cc-4bdf-b22f-220665c39f1e	\N	P004	\N	\N	I don’t even try anymore because I assume I’ll fail.	That fear is loud. It’s trying to protect you—but at a cost.	\N	\N	\N	\N	\N	\N
7aad7e8e-465f-4847-9c91-843f0956c819	\N	\N	\N	\N	What if I’m just not good enough?	Let’s pause and notice: Is that thought a fact or a fear?	\N	\N	\N	\N	\N	\N
9c151416-9a36-4880-a79a-cdf5f3ec7fa8	\N	\N	\N	\N	A fear.	Exactly. Do you want to name one thing you’ve done well recently—even something small, or we can talk more about your fear. What do you want to do?	\N	\N	\N	\N	\N	\N
bcb4a06b-8390-4fe8-bf6e-aea3731c3451	\N	\N	\N	\N	I'll share what I've done before, I helped my little sister with her homework.	That’s connection, contribution, and patience. It matters. You don’t only have to “win” to grow.	\N	\N	\N	\N	\N	\N
4eb911a1-62e9-4f9c-86c1-b3b2fe36072d	\N	P004	\N	\N	I used to love drawing but now I never do it. I don’t see the point.	Sounds like disconnection from something that used to bring you joy.	\N	\N	\N	\N	\N	\N
0abb3bf3-ce15-4699-b854-8d54f6b33462	\N	\N	\N	\N	Yeah, it just feels pointless now.	That can be a sign of burnout or emotional fatigue. Do you want to try drawing without pressure—just scribbles, color, no goal?	\N	\N	\N	\N	\N	\N
0a6d233e-0b78-4941-aed8-7c5b74fce5f8	\N	\N	\N	\N	I guess. I miss the feeling of getting lost in it.	That feeling is still there. Let’s make space for it again—do you want to try for 10 minutes a day, or 15 minutes a day with no expectations?	\N	\N	\N	\N	\N	\N
8da075ab-a9f4-4a3b-af8b-d11b96ed647c	\N	\N	\N	\N	Maybe I’ll try tonight.	That’s a spark. Joy often comes back through small doors.	\N	\N	\N	\N	\N	\N
5af521b9-1117-44de-a030-2ab6edb6d117	\N	P004	\N	\N	I look around and everyone else seems so motivated. I just feel stuck.	It can feel isolating to think everyone has it figured out. But what you see is the highlight reel.	\N	\N	\N	\N	\N	\N
16359b4d-6340-4e05-8516-e7b2c4c77647	\N	\N	\N	\N	So I’m not the only one?	Not at all. Most people struggle quietly. Do you want to talk about what *you* want—not what looks good on paper.	\N	\N	\N	\N	\N	\N
5b89d0b8-fc20-4b3f-ae4e-f238ae84c6f9	\N	\N	\N	\N	I want to feel excited again. Like I’m moving forward.	That’s a powerful goal. Let’s build one habit that creates motion, even if it’s small.	\N	\N	\N	\N	\N	\N
fb0759e3-5700-4bff-8678-5178f49f6028	\N	\N	\N	\N	Maybe morning walks with music.	Beautiful. That’s momentum. Action creates clarity—you’re not stuck, you’re restarting.	\N	\N	\N	\N	\N	\N
bbec980e-fe3a-4547-8bd6-b6aa0d05da16	\N	P004	\N	\N	I used to be excited about school, but now I just don’t care anymore.	It sounds like something shifted for you. Do you want to talk about what changed?	\N	\N	\N	\N	\N	\N
444bed2c-5d43-40f8-bec9-672b4e249073	\N	\N	\N	\N	I’m not sure. It’s like everything feels pointless lately.	That sounds like emotional fatigue. Sometimes our minds disconnect to protect us from burnout.	\N	\N	\N	\N	\N	\N
744a798b-3333-47fe-a500-a38e14b600c6	\N	\N	\N	\N	But isn’t that just being lazy?	Not at all. Disconnection is often a sign your system needs rest or meaning—not that you’re weak.	\N	\N	\N	\N	\N	\N
6bfdf451-45c3-40a4-8102-f126d14ca261	\N	\N	\N	\N	So what do I do if nothing feels meaningful?	We start small. Do you want to think of one thing—however tiny—that brings even a little spark?	\N	\N	\N	\N	\N	\N
50e7ff3f-99e9-4ed4-8443-2608a221066b	\N	\N	\N	\N	I guess music still helps sometimes.	That’s a clue. Can we pair that with a daily habit? Like listening while organizing your notes or going for a walk?	\N	\N	\N	\N	\N	\N
87e1004a-8cc3-4b1e-91c9-4933720737f8	\N	\N	\N	\N	Maybe. That feels lighter than forcing myself to “care.”	Exactly. We’re building from ease, not shame. You don’t have to fake motivation—you can rebuild it gently.	\N	\N	\N	\N	\N	\N
83605082-eaa3-4ceb-bd54-1947835ff8e9	\N	P004	\N	\N	I feel like I have no discipline. I make plans and then ignore them.	That’s a really common experience, especially when the plans are too rigid or heavy.	\N	\N	\N	\N	\N	\N
c77ec018-fa54-4902-888d-28c518c10109	\N	\N	\N	\N	But other people seem to just push through.	I hear that comparison creeping in. Want to pause and look at your *own* rhythm instead?	\N	\N	\N	\N	\N	\N
cce694e5-d1c4-4f3a-adc1-e891caf8f805	\N	\N	\N	\N	What do you mean?	Some people operate on structure. Others need flexibility and reward systems. Let’s build one that fits your brain.	\N	\N	\N	\N	\N	\N
efed914b-799b-452e-b34c-8680e3b19bcd	\N	\N	\N	\N	Like what?	We could try a checklist with flexible blocks: “focus, pause, reward.” Or use visual cues—color-coded tasks, sticky notes. What do you think would work for you?	\N	\N	\N	\N	\N	\N
79f8a7bc-52d0-417c-a253-e40dd17299be	\N	\N	\N	\N	I like visuals. I need to *see* what I’m doing.	Great insight. That’s not lack of discipline—it’s a different kind of organization. One that actually works for you.	\N	\N	\N	\N	\N	\N
f054f40f-7109-4392-8370-37acc028ab96	\N	P004	\N	\N	I can’t get started on anything because I’m scared I’ll screw it up.	That fear of failure can be paralyzing. Can I ask—what’s the worst thing that could happen if you did mess up?	\N	\N	\N	\N	\N	\N
4cf189ce-da30-4094-9cf8-00463179f1d1	\N	\N	\N	\N	I’ll disappoint everyone. They’ll know I’m not good enough.	That sounds like a deep belief you’ve been carrying. But what if we rewrote that story?	\N	\N	\N	\N	\N	\N
0495823f-2083-4629-a218-60b1dd3ccdaf	\N	\N	\N	\N	How?	It could start with: “Trying and learning isn’t failure—it’s growth.” Want to say it out loud?	\N	\N	\N	\N	\N	\N
061ca74a-be05-4761-9124-da52af890ef9	\N	\N	\N	\N	Trying and learning isn’t failure—it’s growth.	Hear that shift? That’s reframing. Now, can we pick one task and start with just 5 or 10 minutes, you can choose.	\N	\N	\N	\N	\N	\N
51f980f0-e8fe-4551-b220-1686b8db26ca	\N	\N	\N	\N	I guess I could try working on the intro to my essay for 5 minutes.	Perfect. Five minutes. You’re not committing to perfect—just showing up.	\N	\N	\N	\N	\N	\N
73126cd1-3639-4694-a1fa-c06abe1b627c	\N	P004	\N	\N	I want to do something meaningful in life, but I don’t know what I’m good at.	It’s so human to want purpose. Can I ask—what moments make you feel most alive?	\N	\N	\N	\N	\N	\N
ea7a572b-84f3-4e6a-8154-5998987bcaf3	\N	\N	\N	\N	Maybe when I help someone. Or when I’m being creative.	That’s powerful. Helping and creating—those are values. They point toward your direction.	\N	\N	\N	\N	\N	\N
7ad31a94-9974-4952-8be7-b33a81619fd5	\N	\N	\N	\N	But I’m not great at anything specific.	You don’t have to be the best. You only need to be engaged. Do you want to make a list of things you’ve enjoyed or been proud of or do you want to talk about this some more?	\N	\N	\N	\N	\N	\N
795fd368-517c-4c09-81a2-6c5ab407ddfa	\N	\N	\N	\N	Okay… tutoring my cousin, making posters for events, organizing stuff.	Those are all skills. Maybe we can brainstorm paths where they fit—nonprofits, design, teaching.	\N	\N	\N	\N	\N	\N
1dfddc24-9b62-40ad-a434-097d2de71e7a	\N	\N	\N	\N	I’ve never thought of it that way.	It’s a beginning. You’re not lost—you’re in the middle of figuring things out.	\N	\N	\N	\N	\N	\N
882b5840-b914-4d6b-91bb-205dfdb3a7b3	\N	P004	\N	\N	Every time I get close to finishing something, I sabotage it.	I hear frustration in that. Can we pause and look at what’s underneath?	\N	\N	\N	\N	\N	\N
37651735-8ea0-4edc-a81c-1ec34be0b407	\N	\N	\N	\N	Maybe I’m scared of what happens if I actually succeed.	That’s deep honesty. Sometimes we fear success because it means change or pressure.	\N	\N	\N	\N	\N	\N
175dbf2d-53ed-4a89-8308-4fcaa18aa3e1	\N	\N	\N	\N	Yeah. If I succeed, people expect more—and I might not be able to keep it up.	So it’s safer to stay stuck than risk the pressure of rising?	\N	\N	\N	\N	\N	\N
a3a41ec9-767a-4db9-a631-430485120bfd	\N	\N	\N	\N	Exactly.	It makes sense. But you also deserve to see what you’re capable of. Do you want some help to create a success plan *with* boundaries? We can work on this now, or later, you choose.	\N	\N	\N	\N	\N	\N
1d427ca6-4cae-4d2b-8b14-8807ce702b0f	\N	\N	\N	\N	Boundaries? What does that mean? Lets work on this now	Yes. Like celebrating small wins, saying no to added pressure, and choosing your pace. You don’t have to sprint just because you can run.	\N	\N	\N	\N	\N	\N
e57e23ed-96e9-4c33-b600-f7e525ba2dee	\N	\N	\N	\N	That helps. I want to finish this time—without burning out.	That’s a strong goal. Let’s build a way for you to cross that finish line with peace, not panic.	\N	\N	\N	\N	\N	\N
bb828ae6-b4ee-434f-9ef7-cc98e661d2ab	\N	P004	\N	\N	I don’t think anyone actually sees me. I’m just... there.	That sounds really lonely. Like you’re in the room, but invisible.	\N	\N	\N	\N	\N	\N
faf3a809-a041-4af6-bcee-7366ae28d748	\N	\N	\N	\N	Yeah. I could disappear for a day and no one would notice.	I’m noticing you now. And I’m really glad you said something. That takes courage.	\N	\N	\N	\N	\N	\N
6dc30fce-3e38-4b98-a85f-7a7915ebef06	\N	\N	\N	\N	I’m just tired of pretending I’m fine.	You shouldn’t have to pretend. What would it be like to show even a small part of how you’re really feeling?	\N	\N	\N	\N	\N	\N
d01b58c9-c15c-48e7-b9c9-2ed21ddf4e57	\N	\N	\N	\N	Scary. But maybe kind of freeing too.	We can take it one step at a time. You don’t have to carry this alone.	\N	\N	\N	\N	\N	\N
bf22caed-deb5-4152-bd06-980857b45ecd	\N	P004	\N	\N	I keep messing up with my parents. Every talk turns into a fight.	It sounds like the tension builds up fast. Do you want things to feel different between you?	\N	\N	\N	\N	\N	\N
c172e811-f3b2-4210-84f0-181c8c465d79	\N	\N	\N	\N	Yeah. But I don’t even know where to start.	What’s the part that hurts the most in those moments?	\N	\N	\N	\N	\N	\N
e171a9cc-9d26-4f72-bfd7-9330b6dbdea4	\N	\N	\N	\N	When they act like I’m just being dramatic or lazy.	It feels like they’re not hearing what’s underneath. Do you think they’d be open to hearing what’s behind your tone—if we wrote it out together?	\N	\N	\N	\N	\N	\N
3a77b44a-a9ef-468f-ad16-a5f2e49261db	\N	\N	\N	\N	Maybe. That might make it easier.	Would you like me to help you shape the words? You deserve to be heard, not just reacted to.	\N	\N	\N	\N	\N	\N
d243f565-d9e7-48a1-840e-3e86064ec157	\N	\N	\N	\N	Yes, that would be a great help thank you.	\N	\N	\N	\N	\N	\N	\N
f29c78aa-fb68-41e6-b909-ef1a7675bac3	\N	P004	\N	\N	Everyone expects me to be “the strong one,” but I’m so tired.	That sounds like a heavy mask to wear all the time.	\N	\N	\N	\N	\N	\N
41e8ea8b-6acd-4bec-9d86-f281eecbc39f	\N	\N	\N	\N	Yeah. If I fall apart, it feels like everything else will too.	So you hold it all in to keep everything standing. That must be exhausting.	\N	\N	\N	\N	\N	\N
9bdc17c9-df2f-458f-a45b-0422ee556347	\N	\N	\N	\N	It is. But if I stop, I’m afraid I’ll break.	What if breaking isn’t the end—but just a signal to breathe, to ask for help?	\N	\N	\N	\N	\N	\N
d9c55a25-de77-4682-ac0d-00f1ffacac5d	\N	\N	\N	\N	I’ve never thought about that.	Being strong doesn’t mean carrying it alone. It means knowing when to rest and let someone else hold the weight for a bit.What do you want to do about it?	\N	\N	\N	\N	\N	\N
99083939-a00b-4bba-8474-9da8872032ff	\N	\N	\N	\N	I think i'll ask for some help	Great idea	\N	\N	\N	\N	\N	\N
0228eb09-3f84-420e-a50a-eba4ae1ebb96	\N	P004	\N	\N	I feel like I’m stuck between who I was and who I’m supposed to become.	That in-between space can be really disorienting.	\N	\N	\N	\N	\N	\N
185292ba-3ba3-4b54-9e49-c9a2b9fd9886	\N	\N	\N	\N	It’s like I don’t fit anywhere. Not anymore.	Maybe you’re in the middle of growing—and the old skin doesn’t quite fit, but the new one’s not ready yet.	\N	\N	\N	\N	\N	\N
1bb63298-6331-4bb3-bf3c-8b1987ce939f	\N	\N	\N	\N	Yeah… that’s kind of what it feels like.	That place is real. It’s not failure—it’s transition. Can we name something small that still feels solid in the midst of change?	\N	\N	\N	\N	\N	\N
4fb2f665-27e2-4ce5-a181-b11956763859	\N	\N	\N	\N	My love for animals hasn’t changed.	That’s something steady. Let’s hold onto that while you grow into the next version of yourself.	\N	\N	\N	\N	\N	\N
b5364d97-ee3a-4f9d-be89-d03836a89dd1	\N	P004	\N	\N	I just don’t care about anything anymore. It all feels numb.	Numb can be a form of pain that’s gone underground. Like your feelings got tired of shouting.	\N	\N	\N	\N	\N	\N
0e6ecdbd-05b8-47c0-a4aa-1679f14bce59	\N	\N	\N	\N	That’s exactly it. I’m just... over it.	Do you want to try and fix this problem, or do you prefer to sit here with the truth of what you’re feeling?	\N	\N	\N	\N	\N	\N
dfe7341b-6764-471f-ba25-7e0fb8117e07	\N	\N	\N	\N	Okay, I"ll sit here with the feeling.	I’m with you in this space. You don’t need to force care to deserve care.	\N	\N	\N	\N	\N	\N
bf0f8d56-54a3-45da-b7b6-d3b8baa76324	\N	\N	\N	\N	Thanks.	I’m glad you let me in. That’s a powerful place to start.	\N	\N	\N	\N	\N	\N
0d6e5cd6-c994-4c9a-8291-100226234f26	\N	P004	\N	\N	Lately, every time my mom asks me something, I freeze. Like I’m going to get it wrong.	That sounds like there’s a lot of pressure in those moments—even if she doesn’t mean it that way.	\N	\N	\N	\N	\N	\N
e2d6f3aa-6146-4388-8cdf-45c77dc64ec2	\N	\N	\N	\N	Yeah. It’s like my brain goes blank. I get so tense.	Do you think it’s about the question, or what might happen if you answer “wrong”?	\N	\N	\N	\N	\N	\N
ebbe4e95-03f0-498e-934b-2c4ea248fbb8	\N	\N	\N	\N	It’s the reaction. She sighs or gets impatient, and then I feel like a disappointment.	That feeling runs deep. You’re not just reacting to her now—you’re reacting to years of feeling judged.	\N	\N	\N	\N	\N	\N
582fa0c4-0056-45cc-9d0e-457748bfce21	\N	\N	\N	\N	Exactly.	It makes sense then that your body tenses up to protect you. Do you want to explore what a calmer moment with her might look like?	\N	\N	\N	\N	\N	\N
452640c3-7258-4671-9156-a043604d455c	\N	\N	\N	\N	I guess I could tell her I need a second to think.	That’s a great step. Naming what you need helps reset the dynamic. You’re allowed to pause.	\N	\N	\N	\N	\N	\N
7ed3244b-a09b-4435-9c93-aa30c3b34595	\N	P004	\N	\N	My dad never talks about emotions. I’ve tried, but he just shuts down.	That must feel so isolating. Like there’s a wall between what you feel and what he’ll let in.	\N	\N	\N	\N	\N	\N
f3dd0957-4ade-4ba3-9e70-2c688b452221	\N	\N	\N	\N	Yeah. I want connection, but I don’t want to push him.	Wanting connection isn’t pushing—it’s reaching. And it matters. What have you tried so far?	\N	\N	\N	\N	\N	\N
daa08c77-a512-4e4f-be2f-5f20687d6190	\N	\N	\N	\N	I once wrote him a letter, but he didn’t bring it up.	That silence can feel like rejection, even if it’s his discomfort speaking. Do you want to try it again, with no expectations?	\N	\N	\N	\N	\N	\N
191e662a-5545-4e9d-8d05-ce646bdac225	\N	\N	\N	\N	Hard. But maybe worth it.	I can help you shape the words if you want. Even saying, “This is hard for me, but I care,” is a start.	\N	\N	\N	\N	\N	\N
7d314555-c6d8-4a7f-8c21-b7b0148cc8ac	\N	P004	\N	\N	I always feel like I owe my parents something. Like I can’t make my own choices.	That sounds like a quiet pressure that's always there—shaping your decisions.	\N	\N	\N	\N	\N	\N
86fc4981-ff64-4eb6-90e2-ade7d17ac448	\N	\N	\N	\N	Yeah. Even when I disagree, I feel guilty just thinking it.	Guilt can be a strong force when love and duty get tangled. Can we pause and name what *you* want?	\N	\N	\N	\N	\N	\N
67d0541b-18fd-40da-a4de-2fcab7e9d883	\N	\N	\N	\N	I want to study art. They want me to do business.	That’s a real conflict. But your desires are valid. What would it feel like to say, “This matters to me, even if it’s not what you pictured”?	\N	\N	\N	\N	\N	\N
d616ed79-44bd-41c2-97ad-658336fb371d	\N	\N	\N	\N	Terrifying. But maybe also freeing.	That’s the space where your voice grows. If you want, we can practice how that conversation might sound. You can choose what you prefer.	\N	\N	\N	\N	\N	\N
efb8e39f-6bb6-4730-971e-6e0f0b7ba60d	\N	P004	\N	\N	I think my parents love me, but I never feel like I’m enough for them.	That’s a painful place to live—always striving, never arriving.	\N	\N	\N	\N	\N	\N
fa2e05f6-5568-4c77-8313-5904f409d7c4	\N	\N	\N	\N	Yeah. If I get an A, they ask why it wasn’t an A+.	It’s like the goalpost keeps moving. That constant pressure can chip away at your self-worth.	\N	\N	\N	\N	\N	\N
d9cdedf8-ca7e-41e4-a1f9-d0900ab971bd	\N	\N	\N	\N	It does. I pretend it doesn’t bother me, but it does.	What would it be like to let them know how it feels when their standards silence your joy?	\N	\N	\N	\N	\N	\N
674adb7d-27ca-40aa-879f-0bd8debce6bd	\N	\N	\N	\N	Scary. I don’t think they mean to hurt me.	You can love someone and still ask for change. Want to write a few lines together that name your truth gently?	\N	\N	\N	\N	\N	\N
762db5a4-7553-4d60-be6f-12bd19c50e5a	\N	\N	\N	\N	Yeah. I’d like that.	Okay. You deserve to feel proud—not just pushed.	\N	\N	\N	\N	\N	\N
e84173a0-d0a8-4b42-b8a2-198411ba930a	\N	P004	\N	\N	Whenever I argue with my parents, I feel sick after. Like I did something wrong even if I didn’t.	That sounds like your nervous system stays stuck in the fight long after it’s over.	\N	\N	\N	\N	\N	\N
a5c2a044-3be9-4e57-969f-1dab9a22216e	\N	\N	\N	\N	I replay the whole thing in my head, over and over.	That kind of rumination is exhausting. Can we try to unpack what part of the argument hits you the hardest?	\N	\N	\N	\N	\N	\N
008f04a4-d51a-466a-a0ca-dea80035df4e	\N	\N	\N	\N	When they say I’m ungrateful. Even if I was just setting a boundary.	That word lands heavy. Maybe it touches an old belief that your needs are “too much.”	\N	\N	\N	\N	\N	\N
b04f7464-4e0b-4198-aa1a-603bae150441	\N	\N	\N	\N	Yeah. That’s exactly it.	I wonder how it would feel to remind yourself: “Setting boundaries is a form of respect—not rejection.”	\N	\N	\N	\N	\N	\N
24a59bda-2dce-4e60-9aba-74342f0ef9c2	\N	\N	\N	\N	I think I need to hear that more often.	Let’s turn it into a phrase you repeat when the guilt starts creeping in. You deserve to feel safe in your own voice.	\N	\N	\N	\N	\N	\N
cad49f50-fd48-4168-9c7b-2deb67b173b8	\N	P004	\N	\N	I always feel like I’m walking on eggshells around my mom. One wrong word and she blows up.	That sounds like you’re constantly on alert—like you have to shrink yourself just to stay safe.	\N	\N	\N	\N	\N	\N
184a62df-b226-4d6b-b465-1678ecdbd8c8	\N	\N	\N	\N	Exactly. I don’t even speak up anymore.	It makes sense. Your silence isn’t weakness—it’s a survival strategy.	\N	\N	\N	\N	\N	\N
a393221e-1e5c-4cd8-8576-915daf0228db	\N	\N	\N	\N	But it’s making me feel small and resentful.	That resentment is a signal that your boundaries are being crossed, even quietly. Want to talk through what safety might look like with her?	\N	\N	\N	\N	\N	\N
9f3fff7f-3bf8-43f7-aa52-f5edf934fcd8	\N	\N	\N	\N	I don’t even know. Maybe just asking her to not raise her voice.	That’s a strong start. You could say, “I want to talk, but I shut down when it gets loud.”	\N	\N	\N	\N	\N	\N
ab482052-bde4-408f-a9b5-664c260cd3c8	\N	\N	\N	\N	What if she gets mad at that too?	Then you gave her the chance. You didn’t stay silent. That’s growth, even if she’s not ready to meet you there.	\N	\N	\N	\N	\N	\N
c98c6b8f-2b92-4e05-b158-e4527e44cd5e	\N	P004	\N	\N	My parents always compare me to my older brother. I hate it.	It sounds like they don’t realize how much that stings.	\N	\N	\N	\N	\N	\N
95189d1a-ee94-4e64-9786-841fa6ec4e88	\N	\N	\N	\N	They always say, “Why can’t you be more like him?”	That kind of comment cuts deep. It makes you feel like who you are isn’t good enough.	\N	\N	\N	\N	\N	\N
15706c12-db9a-413b-bd1e-7732c85aa1a7	\N	\N	\N	\N	Exactly. And the worst part is—I’ve started believing it.	Let’s pause right there. You are not your brother, and you’re not meant to be.	\N	\N	\N	\N	\N	\N
f0b32c1c-4204-4ed4-bfda-22a9149357da	\N	\N	\N	\N	But I still feel like a disappointment.	You are allowed to be your own person. Maybe next time, you could say, “I’d like to be valued for who I am, not compared to someone else.”	\N	\N	\N	\N	\N	\N
de05f294-3fe8-467e-9ae6-883d75c7a566	\N	\N	\N	\N	I don’t know if I can say that out loud.	If you want, we can write it out together, or we can work on sending it in a message if you prefer.	\N	\N	\N	\N	\N	\N
ac849920-768a-4946-b009-dd198049ae6b	\N	P004	\N	\N	My dad says he wants me to be honest, but when I am, he shuts me down.	That’s confusing—he asks for truth, but doesn’t create space for it.	\N	\N	\N	\N	\N	\N
7a1bc290-8303-46ea-96f2-4a53014dec95	\N	\N	\N	\N	Yeah. Last time I said how I felt, he called me disrespectful.	That must have felt like a slap to your vulnerability.	\N	\N	\N	\N	\N	\N
b49e4404-4ce4-4e80-b142-664431cd7f90	\N	\N	\N	\N	I just stopped trying after that.	It makes sense. Why open up if it’s going to hurt more?	\N	\N	\N	\N	\N	\N
ee7fafb8-257c-4359-93c5-00a3bfb41f7b	\N	\N	\N	\N	So what do I do?	I wonder if naming the pattern might help. Like, “I want to share, but I need to feel safe when I do.”	\N	\N	\N	\N	\N	\N
65d3291f-41ea-46fa-8e80-2e774e85e3f2	\N	\N	\N	\N	Even saying that feels risky.	And brave. Do you want to rehearse it together or do you prefer to just say it yourself? You deserve to speak your truth without fear.	\N	\N	\N	\N	\N	\N
51f1fbfe-6114-44e8-8ae4-91da065a4a52	\N	P004	\N	\N	I try so hard to make my parents proud, but I don’t think they ever really see me.	That’s a painful kind of invisibility—being noticed for what you do, but not for who you are.	\N	\N	\N	\N	\N	\N
a78cbf3b-18f8-4548-af88-737e0025e2ca	\N	\N	\N	\N	Yeah. I get good grades, stay out of trouble, help at home… nothing seems to matter.	You’ve been showing up in all the ways they say they want—but your emotional needs are going unmet.	\N	\N	\N	\N	\N	\N
efb80e84-ae22-4c89-bc68-2e58bee04f88	\N	\N	\N	\N	Right. I don’t want more chores—I want them to *know* me.	That’s so important. Can we think of a gentle way to invite them into your world?	\N	\N	\N	\N	\N	\N
a9d333af-5d97-49a0-a6dc-92e8581b53bf	\N	\N	\N	\N	Maybe writing a note? I don’t do well talking in person.	That’s totally fine. You could share something you’ve never said before, like what lights you up or what hurts you.	\N	\N	\N	\N	\N	\N
ad86baca-8eb1-4e88-a1fe-0de35eccacdf	\N	\N	\N	\N	I like that. It might finally open a door.	Exactly. You’re not asking for praise—you’re asking to be *seen*.	\N	\N	\N	\N	\N	\N
926a39c2-5f69-4059-8a10-6c86fd93f95f	\N	P004	\N	\N	Every time I say no to my mom, she acts like I betrayed her.	It sounds like saying no isn’t safe—it becomes personal, like an attack.	\N	\N	\N	\N	\N	\N
ec99a90f-da46-4436-b8dd-02ff031c620a	\N	\N	\N	\N	Yeah, then I feel guilty for even trying to set a boundary.	That’s emotional pressure disguised as closeness. It’s not your job to meet all her needs.	\N	\N	\N	\N	\N	\N
2149961f-a070-4037-af2d-2c55b90f09fc	\N	\N	\N	\N	But I don’t want to hurt her feelings.	I hear that. Can we reframe “no” as “I care, and I also need space”?	\N	\N	\N	\N	\N	\N
84c54dc9-b067-4610-90f5-b397e939d189	\N	\N	\N	\N	How would I even say that?	You can try: “I love you, and I also need to say no right now so I don’t burn out.” or we can think of another line together. What do you prefer?	\N	\N	\N	\N	\N	\N
807d4b36-2027-4a98-b2e2-35fadab38654	\N	\N	\N	\N	That sounds more kind than how I usually say it.	Kindness and firmness can live together. And you’re allowed to protect your energy.	\N	\N	\N	\N	\N	\N
f2df4566-da80-467a-9901-000828764076	\N	P004	\N	\N	I like this guy but I have no idea if he actually likes me back. It’s driving me crazy.	That sounds like a storm of wondering—and no clear signals.	\N	\N	\N	\N	\N	\N
13c2304c-1af9-4050-b72d-3265dd82b249	\N	\N	\N	\N	Yeah. One day he talks to me for hours, the next day it’s like I don’t exist.	That emotional whiplash is confusing. It’s okay to want clarity—you’re not “needy” for wondering where you stand.	\N	\N	\N	\N	\N	\N
f2155695-c9a6-4fd8-934a-d2100c4f2da1	\N	\N	\N	\N	Should I ask him? What if I scare him off?	It’s scary to be direct, but it’s also exhausting to keep guessing. How would it feel to say, “I’ve noticed I’m unsure where I stand with you”?	\N	\N	\N	\N	\N	\N
c53df290-8a60-4649-9d26-3f23da84db48	\N	\N	\N	\N	That feels honest, but terrifying.	Honest *is* brave. And you deserve a relationship that brings peace, not confusion.	\N	\N	\N	\N	\N	\N
df5e2024-861f-435a-84c1-e8cdaa0c9c9c	\N	\N	\N	\N	I just want to know the truth, even if it hurts.	And that shows maturity. Let’s figure out how to ask in a way that feels most true to you.	\N	\N	\N	\N	\N	\N
6e232cb3-be96-4640-91dc-f78949393987	\N	P004	\N	\N	My girlfriend broke up with me last week and I still can’t breathe.	It sounds like your whole body is grieving, not just your heart.	\N	\N	\N	\N	\N	\N
5ead1c3e-f1d5-4376-85b8-5badedb0a8de	\N	\N	\N	\N	I keep going over what I did wrong.	Breakups trigger a deep need to make sense of things. But not every ending is about failure.	\N	\N	\N	\N	\N	\N
2cf5cb2e-974b-482f-a8a0-7e4ce398832f	\N	\N	\N	\N	It still feels like I wasn’t enough.	That belief can linger, but it isn’t truth. Want to talk about what you *gave* in that relationship?	\N	\N	\N	\N	\N	\N
71577d85-3ed4-4b57-a815-341b4a7683d9	\N	\N	\N	\N	I tried hard to listen. I always showed up.	That matters. You were present and real. Maybe this pain isn’t about your worth—but about loss.	\N	\N	\N	\N	\N	\N
6ea02077-2b92-4b48-b0f8-a4b680ccc175	\N	\N	\N	\N	So what do I do with it?	We sit with it, gently. And when you’re ready, we talk about how to carry the pain without letting it define you.	\N	\N	\N	\N	\N	\N
1fe53656-025c-4957-9b39-e6167bbb3ef1	\N	P004	\N	\N	My boyfriend keeps making jokes that hurt me, but when I tell him, he says I’m too sensitive.	That sounds like he’s avoiding accountability—and turning it on you.	\N	\N	\N	\N	\N	\N
b62feb33-e82d-49d3-a8c5-2eb8f9df9e7b	\N	\N	\N	\N	I don’t want to seem dramatic, but I cry after.	Your tears are valid. Jokes that hurt repeatedly aren’t harmless—they’re communication.	\N	\N	\N	\N	\N	\N
2d9ffcbe-7127-4832-8e54-d4165c321a4e	\N	\N	\N	\N	What if he doesn’t mean to?	Even if the intent isn’t to harm, the impact still matters. How would it feel to say, “That joke doesn’t sit right with me—it hurts”?	\N	\N	\N	\N	\N	\N
83caa836-d153-412e-ae3a-4f44f9a70d93	\N	\N	\N	\N	I’m scared he’ll get defensive.	You can’t control his reaction, but you can control your truth. Let’s practice the sentence together.	\N	\N	\N	\N	\N	\N
b26efe06-ce05-494b-83ac-51339dc5e1dc	\N	\N	\N	\N	Okay. I want to feel strong when I say it.	And you will. Standing up for yourself is strength—even when your voice shakes.	\N	\N	\N	\N	\N	\N
dcb9ec58-f50a-4c2d-9bf3-ecde9ee2e90e	\N	P004	\N	\N	I’ve never had a relationship and I feel like I’m falling behind everyone else.	That’s a hard feeling—like the world’s racing ahead and you’re stuck on pause.	\N	\N	\N	\N	\N	\N
5b09fc38-a8f5-48f5-9467-6f7e06a71f8c	\N	\N	\N	\N	Yeah. Everyone around me is dating and I’m just… waiting.	Waiting doesn’t mean lacking. Want to explore what you actually want—not just what’s expected?	\N	\N	\N	\N	\N	\N
6f8e4a2f-9f97-4ee3-8931-ada005738903	\N	\N	\N	\N	I don’t know. Maybe I just want someone to get me.	That’s a powerful start. Relationships aren’t milestones—they’re connections. would you like to explore how you can be more active or would you like to explore your current situation and see if you are seeing the full picture of what is happening around you. Somethimes we have blind spots and we miss things, especially when it comes to social interactions.	\N	\N	\N	\N	\N	\N
19aa5680-2968-4f02-a00a-af9d2e47f12a	\N	\N	\N	\N	OK, this is interesting, maybe I have blind spots? I'dlike to explore that.	Great, let's start	\N	\N	\N	\N	\N	\N
f2c8d3d0-f211-4dd8-bea9-b0738681cfa4	\N	P004	\N	\N	I feel like I’m always the one chasing in relationships. No one ever chooses me first.	It sounds like that ache goes deep, like being second place to everyone.	\N	\N	\N	\N	\N	\N
e133cce5-76dd-4bd4-95e8-847381d33490	\N	\N	\N	\N	Exactly. I text first, I plan things. If I stop, it’s silence.	It sounds like you’ve learned to hustle for love—and it’s exhausting.	\N	\N	\N	\N	\N	\N
d563b638-9f50-4601-9dd3-1addea8e8201	\N	\N	\N	\N	Yeah. And then I start wondering if I’m just not worth the effort.	Let’s pause. It is easy to confuse lack of communication with self worth. would you like to try something new?	\N	\N	\N	\N	\N	\N
10878a06-a066-4598-8511-6410d764f34e	\N	\N	\N	\N	sure, but what?	You can make a list of communication expectations that you have and then go over it and see if it makes sense to have these expectations? You can dive deep into trying to understand why you would think less of yourself as a sesponce to someone elses communication style.	\N	\N	\N	\N	\N	\N
0b3a613e-b714-4124-9bd0-b9b510764837	\N	\N	\N	\N	I think I have to separate my self worth from the way people communicate with me. yes.	OK, great. Would you like to start by writing your healthy communication expectations.	\N	\N	\N	\N	\N	\N
2b4a4d0d-9abc-4671-b900-bdd6dbd23900	\N	\N	\N	\N	Ye, thanks, I'll start there	\N	\N	\N	\N	\N	\N	\N
bb3bb086-877a-4930-a358-5806ce84ee4a	\N	P004	\N	\N	I feel like I’m always the one sharing in my relationship. He just listens but never opens up.	That can feel one-sided—like you’re giving emotional energy without getting any back.	\N	\N	\N	\N	\N	\N
ee9a8815-db88-4b88-95a8-df73004ed6e1	\N	\N	\N	\N	Yeah. I want to know what he’s feeling, but he just shrugs things off.	It sounds like you’re craving connection, not just conversation.	\N	\N	\N	\N	\N	\N
550cd6e8-16b9-40dc-88f4-e238087ec8c7	\N	\N	\N	\N	Exactly. It’s like I’m in it alone.	Have you ever told him how that feels—not as a complaint, but as a need?	\N	\N	\N	\N	\N	\N
637b0df7-bf25-4698-954b-a9900a7934a5	\N	\N	\N	\N	No… I guess I don’t want to seem clingy.	Needing emotional closeness isn’t clingy. It’s human.  you can try  saying, “I feel closest to you when you share too”? Or, "this is how I feel connected and it will be great to try it my way sometimes"	\N	\N	\N	\N	\N	\N
21b03424-7c25-4541-a2fa-3c791612052c	\N	\N	\N	\N	That actually sounds okay. I want to try.	Good. You deserve to feel seen and heard, not just like a listener.	\N	\N	\N	\N	\N	\N
47396816-33ed-4163-9eee-3e10b90eebee	\N	P004	\N	\N	I let my guard down with someone and now I regret it. He’s acting distant.	That can be such a vulnerable spot—giving trust and not knowing if it’ll be held.	\N	\N	\N	\N	\N	\N
fcff502f-cd92-4b6a-bb18-5f952badb249	\N	\N	\N	\N	Yeah. I feel stupid for opening up.	Let’s pause there. You’re not stupid—you were brave. His behavior doesn’t erase that.	\N	\N	\N	\N	\N	\N
fb3ff0b2-ad10-41d0-bb4c-4ec0fa191f49	\N	\N	\N	\N	But now I just want to shut down again.	I get that urge. But healing doesn’t come from walls—it comes from clarity. Do you want to think through what you *want* to say to him, or do you need another minute to "be" in it?	\N	\N	\N	\N	\N	\N
ecdcfc3a-3738-4622-991a-7fa406e44eff	\N	\N	\N	\N	I think I want to  ask what changed.	Then let’s do it. Your voice still matters, even if someone else pulled away.	\N	\N	\N	\N	\N	\N
2614dc7e-0f06-4f5b-b857-cda9cd7f0029	\N	P004	\N	\N	My girlfriend keeps checking my phone and getting upset about little things.	That sounds like a trust issue that’s getting really invasive.	\N	\N	\N	\N	\N	\N
d6245b41-8cca-4f4f-85db-67b470760bb8	\N	\N	\N	\N	Yeah. I haven’t done anything wrong, but I feel guilty anyway.	That guilt might not be yours to carry. Want to explore where your line is—what feels respectful versus what feels controlling?	\N	\N	\N	\N	\N	\N
b3d6785a-85d5-404d-a546-a8df6218474a	\N	\N	\N	\N	I don’t want to lose her, but I don’t like feeling watched.	You’re allowed to want love and privacy. Maybe we can figure out how to say, “I want us to trust each other without needing proof.”	\N	\N	\N	\N	\N	\N
eafd0981-2178-450e-9868-d9b1bf059a19	\N	\N	\N	\N	That sounds right. I need space without guilt.	Exactly. Boundaries protect connection—they don’t threaten it. Do you think you can work out how to say it on your own, or do you want to figure out the wording together?	\N	\N	\N	\N	\N	\N
b039f7f1-9d82-4f46-9775-5d0596d3caac	\N	\N	\N	\N	I think I can manage this on my own.	Great!	\N	\N	\N	\N	\N	\N
0db5cb85-cdb7-4d93-9f72-4754284880eb	\N	P004	\N	\N	I’m starting to feel like I lose myself in every relationship. I become who they want.	That sounds like you’ve learned to adapt to stay connected—but at the cost of your identity.	\N	\N	\N	\N	\N	\N
07522771-babd-4c8e-98e0-1903d7e4b96f	\N	\N	\N	\N	Yes. I don’t even know what *I* like anymore.	Let’s sit with that. When you’re with someone, what parts of you shrink?	\N	\N	\N	\N	\N	\N
93fcfccc-7562-4259-b1b0-2ada074fb265	\N	\N	\N	\N	My opinions, my hobbies, even how I dress.	That’s a big signal. Real love won’t ask you to disappear.	\N	\N	\N	\N	\N	\N
3320b7d0-c05a-4d77-b049-7180cb0c4ecf	\N	\N	\N	\N	So how do I stay *me* next time?	We can build anchors—your values, your joy, your voice. Even one boundary like, “I still need solo time on weekends” can help.	\N	\N	\N	\N	\N	\N
c6376325-ab3e-4e3f-a62c-d4a529f896ac	\N	\N	\N	\N	I want that. I want to keep my center.	And you can. Relationships should expand you, not erase you.	\N	\N	\N	\N	\N	\N
c0db3246-1931-4e85-bc24-b3a9a601b8d5	\N	P004	\N	\N	He says he loves me, but then he jokes about things I’ve told him in private.	That feels like a betrayal—laughing with your secrets instead of holding them.	\N	\N	\N	\N	\N	\N
49706823-6a1b-42e3-961c-dd1e66ffc6dc	\N	\N	\N	\N	Yeah. I brush it off but I feel hurt every time.	It makes sense. Trust isn’t just about not lying—it’s about how someone protects what you share.	\N	\N	\N	\N	\N	\N
e6e9a480-7944-4254-9b59-03d905a53b3b	\N	\N	\N	\N	So is that a red flag?	Only you can decide—but your hurt is real. Want to talk about what you need for this to feel safe again?	\N	\N	\N	\N	\N	\N
755dc3e1-ebd1-4364-936e-371ac06d50e6	\N	\N	\N	\N	I think I need him to understand that some things aren’t jokes.	Exactly. Maybe saying, “When you joke about that, it makes me feel unsafe sharing with you” could open the door.	\N	\N	\N	\N	\N	\N
821056dd-f00a-4510-945f-3e6cc8b567ac	\N	\N	\N	\N	Okay. I need to say something.	And you deserve to. Trust should feel like safety, not silence.	\N	\N	\N	\N	\N	\N
d091b572-d88b-4654-ad3d-b0358bc42934	\N	P004	\N	\N	I told him I liked him and he said he “wasn’t sure.” I feel so embarrassed.	Thanks for trusting me with that. What was it like for you to say it out loud to him?	\N	\N	\N	\N	\N	\N
2e842447-a5d1-4861-8496-0fb4374546db	\N	\N	\N	\N	I was shaking. I’ve never said that to anyone before.	That sounds like it took a lot of courage. What did you expect might happen when you told him?	\N	\N	\N	\N	\N	\N
eac83f17-54f6-4b43-a56c-da6960e328af	\N	\N	\N	\N	I hoped he’d say it back—or at least something more than “I’m not sure.”	Yeah, that must have left you wondering what he really meant. What do you think “not sure” means coming from him?	\N	\N	\N	\N	\N	\N
490a6bb3-3258-4fab-8304-5ac713e96d0e	\N	\N	\N	\N	I honestly don’t know. I’ve been trying to guess ever since.	That sounds exhausting—to hold all that uncertainty by yourself. Would it help to explore what you need right now, regardless of what he’s feeling?	\N	\N	\N	\N	\N	\N
44db8546-2d8f-45b4-b736-990ad14e64ca	\N	\N	\N	\N	Yeah… I just don’t know what to do next.	You’ve got a few options. Would you like to:	\N	\N	\N	\N	\N	\N
9d4bf8ec-2958-405e-9a55-2ab4aa97c98f	\N	\N	\N	\N	\N	– Give yourself space from him for a few days to clear your thoughts?	\N	\N	\N	\N	\N	\N
b5dfafdf-1b12-4577-9996-cf93149df614	\N	\N	\N	\N	\N	– Talk to him again and ask for more clarity about where he stands?	\N	\N	\N	\N	\N	\N
03e8cfee-f233-4280-83ec-440a830d9d82	\N	\N	\N	\N	\N	– Focus on writing down what you want from a relationship, with or without him in it?	\N	\N	\N	\N	\N	\N
83eb29d5-e84e-44dc-8d83-9b15a8f285ec	\N	\N	\N	\N	\N	Which of these feels right for where you are, or is there something else you’re thinking?	\N	\N	\N	\N	\N	\N
6c661bdc-47ab-4b59-9885-dad8c91caf16	\N	\N	\N	\N	I think I want space. I need to reset.	That sounds like a wise move. Giving yourself space lets you listen to your own voice.	\N	\N	\N	\N	\N	\N
661a24a8-45b8-455b-8f8e-a82ed56f7155	\N	\N	\N	\N	\N	And just so you know—putting yourself out there doesn’t mean you failed. Vulnerability is a form of strength, even if it feels raw. The “not sure” response says more about where he is than who you are.	\N	\N	\N	\N	\N	\N
57a5679b-1a57-4c44-897c-4d146b338d42	\N	P004	\N	\N	Lately my mom keeps checking my phone. I feel like I can’t breathe.	That sounds really invasive. What’s it like for you when that happens?	\N	\N	\N	\N	\N	\N
b86c6eb2-161d-44ce-bb4c-5cdb12a805b1	\N	\N	\N	\N	I just freeze. I don’t even want to be home.	What do you think she’s hoping to find—or afraid she’ll miss?	\N	\N	\N	\N	\N	\N
76f71d71-3aad-4205-9013-712f4caee5d4	\N	\N	\N	\N	I think she’s just paranoid. I’ve never given her a reason to not trust me.	Would it help to explore how you might tell her how this makes you feel, or what kind of boundaries feel fair?	\N	\N	\N	\N	\N	\N
f40c0fd1-6d61-4c77-968a-d0d2c3201763	\N	\N	\N	\N	Maybe. But she gets super defensive.	Let’s think of what you can do next. Would you like to:	\N	\N	\N	\N	\N	\N
e445d81c-06ea-4bf2-811c-5666d7fa8c72	\N	\N	\N	\N	\N	Write down how this is impacting your trust and share it with her calmly?	\N	\N	\N	\N	\N	\N
eb920c3d-6876-4606-9812-5a67f18938e3	\N	\N	\N	\N	\N	Or ask for a time to talk when things are not heated?	\N	\N	\N	\N	\N	\N
5e16836a-2541-4bed-88e3-f9aeff2b7d4d	\N	\N	\N	\N	\N	Or talk to another adult first to help mediate?	\N	\N	\N	\N	\N	\N
8b0bdec0-c436-42bf-9d47-4f11cdc8d8dc	\N	\N	\N	\N	I think writing it out first will help.	Good choice. It gives you a way to clarify your voice before reacting.	\N	\N	\N	\N	\N	\N
127cf7d1-a772-4e4e-ab3c-dad8c52c7d88	\N	\N	\N	\N	\N	Sometimes, when parents fear losing control, they try to micromanage. But trust grows from mutual respect, not surveillance.	\N	\N	\N	\N	\N	\N
689be467-ac72-4bdc-84aa-dc7355d3ad69	\N	P004	\N	\N	My dad keeps comparing me to my older brother. I can’t take it anymore.	That sounds heavy. What’s the impact on you when those comparisons happen?	\N	\N	\N	\N	\N	\N
ee747eb1-8f45-4835-b9a9-16b9f84c378c	\N	\N	\N	\N	I feel like I’ll never be enough.	What do you think your dad sees in your brother that he doesn’t acknowledge in you?	\N	\N	\N	\N	\N	\N
49e58b00-6c9c-423d-ac5e-74646d568c22	\N	\N	\N	\N	Like he’s the “successful one,” and I’m just the “lazy one.”	That must hurt. Would it help to find a way to express your own strengths—or to tell your dad how these comparisons affect your motivation?	\N	\N	\N	\N	\N	\N
8d1ea309-276c-472b-abfa-ecbc70511c9a	\N	\N	\N	\N	Maybe both. I want him to see *me*.	Would you like to:	\N	\N	\N	\N	\N	\N
706c7042-eacd-4b21-8f35-88bcffb3b662	\N	\N	\N	\N	\N	– Write or speak directly to your dad about how this makes you feel?	\N	\N	\N	\N	\N	\N
75dd0262-067e-4662-8192-d16581eb569c	\N	\N	\N	\N	\N	– Ask for help from someone else in the family to communicate this?	\N	\N	\N	\N	\N	\N
b116eaa6-cbb2-47cf-a161-5379523e2986	\N	\N	\N	\N	\N	– Focus for now on what makes you proud of yourself—and share that?	\N	\N	\N	\N	\N	\N
1caa029c-627e-46b0-af77-b5133ad208b7	\N	\N	\N	\N	I think I want to tell him straight up.	That kind of directness takes guts—and clarity.	\N	\N	\N	\N	\N	\N
0b825a9a-81aa-475b-8e29-d5a64e7068d5	\N	\N	\N	\N	\N	Parents often compare as a way of motivating, but it can backfire. Emotional identity needs to be nurtured separately, not competitively.	\N	\N	\N	\N	\N	\N
f79b896d-1424-46b1-9a6f-1fbea1061309	\N	P004	\N	\N	My parents are getting divorced and they keep putting me in the middle.	It sounds like you’re stuck between two people you care about, being pulled in both directions.	\N	\N	\N	\N	\N	\N
bdce6e49-e8b2-49e7-81a0-049fee337b09	\N	\N	\N	\N	Exactly. They both want me to “take their side.”	What’s it like for you to hear their arguments or complaints about each other?	\N	\N	\N	\N	\N	\N
a05435c5-ff9a-4446-a5b7-2368f1323625	\N	\N	\N	\N	It just makes me want to disappear.	That’s a lot to carry. Want to talk through ways to protect your space while still caring for both of them?	\N	\N	\N	\N	\N	\N
9e10d711-9ff1-4c92-91ba-fc6245b83aca	\N	\N	\N	\N	Yeah. I don’t want to hurt either of them.	Here are a few options:	\N	\N	\N	\N	\N	\N
3d8768c6-ca13-41c8-a4d7-14a5565dc7d9	\N	\N	\N	\N	– Set a clear boundary like, “I can’t be the one to solve this—it’s between you two.”	You can set a clear boundary like, “I can’t be the one to solve this—it’s between you two.”	\N	\N	\N	\N	\N	\N
d1308e91-b788-4f27-ad69-2aca5a4cd225	\N	\N	\N	\N	– Ask a trusted adult or counselor to help you say that if it feels too hard alone.	Or you can ask a trusted adult or counselor to help you say that if it feels too hard alone.	\N	\N	\N	\N	\N	\N
bfa49763-6142-4e38-8d97-d20911225205	\N	\N	\N	\N	– Limit conversations when they become about the other parent.	Or you can limit conversations when they become about the other parent.	\N	\N	\N	\N	\N	\N
ab4ef170-a203-4114-827d-3248239e868a	\N	\N	\N	\N	I think I need help saying it.	That’s wise. Support makes boundary-setting stronger.	\N	\N	\N	\N	\N	\N
9e5d6362-1d44-4b65-97ee-1fbc57d37ece	\N	\N	\N	\N	\N	Kids should never be used as emotional referees. Divorce is hard enough—your job is to feel safe, not split.	\N	\N	\N	\N	\N	\N
a6a7318f-9983-4066-af62-5d62c6836b47	\N	P004	\N	\N	I told my mom I want to take a gap year before college and she flipped out.	That sounds intense. What was her reaction like?	\N	\N	\N	\N	\N	\N
9e37a70d-3339-4127-985f-b061671b18c7	\N	\N	\N	\N	She said I was wasting my future.	What do "you" want out of the gap year? What’s driving your decision?	\N	\N	\N	\N	\N	\N
3615d15b-0d38-4ce6-a140-b51604ddca5b	\N	\N	\N	\N	I want to breathe. I’ve been in school nonstop since I was five.	I hear that. Would it help to explore how you can express that desire in a way she might understand?	\N	\N	\N	\N	\N	\N
6aa5e543-1e9a-47f4-b13e-e2f684001d3a	\N	\N	\N	\N	Maybe. But she only sees academics as success.	Would you like to:	\N	\N	\N	\N	\N	\N
299b6660-d5b2-4ca7-ab62-b4633fb79f3b	\N	\N	\N	\N	– Make a plan to show her how your year will include growth, not just rest?	Make a plan to show her how your year will include growth, not just rest?	\N	\N	\N	\N	\N	\N
96136a61-8133-49ed-8651-6702686a1d51	\N	\N	\N	\N	– Ask to talk with someone she trusts (like a teacher or mentor) who supports your idea?	Or ask to talk with someone she trusts (like a teacher or mentor) who supports your idea?	\N	\N	\N	\N	\N	\N
76cd7b07-5309-4d8b-b803-ac9cac514351	\N	\N	\N	\N	– Delay the conversation for a bit and build your confidence first?	Or would you prefer to delay the conversation for a bit and build your confidence first?	\N	\N	\N	\N	\N	\N
b3ad0544-2b01-4a83-87e6-7eae19b60f47	\N	\N	\N	\N	I want to make a plan to show her.	That’s a smart step. Sometimes people fear what they don’t understand until they see structure.	\N	\N	\N	\N	\N	\N
a7b50daa-6571-4d11-9df4-4af0b3512a2f	\N	\N	\N	\N	\N	A gap year, when used intentionally, can increase maturity, resilience, and even motivation for future studies.	\N	\N	\N	\N	\N	\N
992e92a4-e6c0-4c25-bd0c-038fae53612d	\N	P004	\N	\N	My parents always say “you’re so emotional” like it’s a bad thing.	It sounds like that label has become a way to shut you down. How does it feel when they say that?	\N	\N	\N	\N	\N	\N
ada248e4-2825-4522-a0bd-963a37af6be4	\N	\N	\N	\N	I feel like there’s something wrong with me.	What do you think they mean when they say “emotional”? What’s behind that word for them?	\N	\N	\N	\N	\N	\N
faee67e7-0b50-4040-9f4d-e30da0956833	\N	\N	\N	\N	I guess they don’t like it when I cry or get upset.	Would it help to talk about the role emotions actually play in communication—or to show them how labeling shuts you down?	\N	\N	\N	\N	\N	\N
534c4b67-8c88-4eed-9225-b4dd46dc483b	\N	\N	\N	\N	Maybe both. I want to stop being afraid to feel.	Would you like to:	\N	\N	\N	\N	\N	\N
701bca99-9962-495d-908d-adbd93ed5c3c	\N	\N	\N	\N	– Start journaling or talking about your emotions more openly, even if they don't always respond well?	Start journaling or talking about your emotions more openly, even if they don't always respond well?	\N	\N	\N	\N	\N	\N
cac58ba4-8180-4293-a838-f71ec37c3415	\N	\N	\N	\N	– Ask them, “What do you mean when you say that?” next time it happens, to open the door?	Ask them, “What do you mean when you say that?” next time it happens, to open the door?	\N	\N	\N	\N	\N	\N
ad2b9453-8c69-448d-86a8-4e11963c2b0f	\N	\N	\N	\N	– Share something about emotional health and how it's part of being strong—not weak?	Share something about emotional health and how it's part of being strong—not weak?	\N	\N	\N	\N	\N	\N
d51c0b74-419e-4c00-af96-d455a397f3d7	\N	\N	\N	\N	I want to ask them next time—what do they actually mean?	That’s powerful. Curiosity instead of defensiveness creates room for change.	\N	\N	\N	\N	\N	\N
e4e7b829-7b3d-4330-98c3-7a2f3769c86d	\N	\N	\N	\N	\N	Being emotionally aware is not a flaw—it’s a superpower, especially when you learn how to name and use those feelings with clarity.	\N	\N	\N	\N	\N	\N
c3241c9d-7124-43e5-8e84-c3bc3e30800d	\N	P004	\N	\N	His mom invited me to a family dinner. I said yes, but now I’m freaking out.	That sounds like a big step. What’s making you feel nervous about it?	\N	\N	\N	\N	\N	\N
4c172efd-e00c-4531-9ce1-15f14e0d735a	\N	\N	\N	\N	What if they don’t like me? What if I say something wrong?	What are you imagining could happen that would feel the most uncomfortable?	\N	\N	\N	\N	\N	\N
14878326-34fb-4d52-9fce-328f268a7384	\N	\N	\N	\N	That I’ll embarrass myself or he’ll see I’m not good enough.	Would it help to explore what parts of this dinner you can prepare for, and what you might let go of?	\N	\N	\N	\N	\N	\N
cf29ef92-f961-4a60-b2fd-8f29d03aa563	\N	\N	\N	\N	Maybe. I want to feel more in control of the situation.	Here are a few options:	\N	\N	\N	\N	\N	\N
da15966f-7198-471a-9b43-fabaaeb3e47a	\N	\N	\N	\N	\N	– Talk with him about what to expect and what his parents are like.	\N	\N	\N	\N	\N	\N
6b819911-1bf9-47d2-a726-21198764d0a3	\N	\N	\N	\N	\N	– Set a goal for yourself, like, “I’ll be kind and honest—that’s enough.”	\N	\N	\N	\N	\N	\N
88ca4dc6-3e59-4796-8860-fce921e50d83	\N	\N	\N	\N	\N	– Do a mock conversation with a friend to shake off nerves.	\N	\N	\N	\N	\N	\N
36682776-3adc-43b0-8974-6e767e8db5c5	\N	\N	\N	\N	\N	Which of those would help you feel a little steadier?	\N	\N	\N	\N	\N	\N
f386cec2-8445-4578-a958-ee8516b7f47a	\N	\N	\N	\N	I want to ask him more about his family and what to expect.	Great choice. Feeling prepared gives your nervous system a sense of safety.	\N	\N	\N	\N	\N	\N
77f53b42-551d-4235-86e6-171be19b887f	\N	\N	\N	\N	\N	Meeting the family often brings up fears of judgment, but it’s also a chance to be yourself—at your pace.	\N	\N	\N	\N	\N	\N
3ad7fd2b-e056-462c-beb1-230ebf4fcffe	\N	P004	\N	\N	I think he’s going to propose, and I’m panicking.	It sounds like a lot is coming up for you. What makes you think that?	\N	\N	\N	\N	\N	\N
bca28b09-f3d7-40f4-9a4e-167928a69f90	\N	\N	\N	\N	He keeps hinting at “the next step,” and I just freeze.	I hear that. What does “marriage” bring up for you emotionally right now?	\N	\N	\N	\N	\N	\N
85813cb6-64aa-4948-a05c-537b83ebaac9	\N	\N	\N	\N	Pressure. Like this is all happening too fast.	Would it help to explore how to talk with him about your pace and comfort without hurting the relationship?	\N	\N	\N	\N	\N	\N
d93a9a4c-0744-4ad1-9236-7489ae39bd88	\N	\N	\N	\N	Yeah. But I don’t know how to say it.	Let’s brainstorm some ways. Would you like to:	\N	\N	\N	\N	\N	\N
a6714c52-fd82-4f1a-9b7c-81c3138873ac	\N	\N	\N	\N	– Start with a statement like, “I care about you deeply, and I need to move more slowly”?	Start with a statement like, “I care about you deeply, and I need to move more slowly”?	\N	\N	\N	\N	\N	\N
ca62e3b9-c59f-41f0-a308-7c008c116f21	\N	\N	\N	\N	– Ask for a pause to reflect together about the future?	Or would you prefer to ask for a pause to reflect together about the future?	\N	\N	\N	\N	\N	\N
9aa2b291-1a0b-42a8-8b43-67b0b734aa86	\N	\N	\N	\N	– Talk to someone else first to sort your feelings?	Or talk to someone else first to sort your feelings?	\N	\N	\N	\N	\N	\N
e263ffec-1ce1-4283-a430-4356ee6e553b	\N	\N	\N	\N	I want to try the first one. Say it gently.	Perfect. Expressing clarity with warmth helps build trust, not break it.	\N	\N	\N	\N	\N	\N
dfc0efcf-c7a0-4f8f-aaf9-eed91323250d	\N	\N	\N	\N	\N	Big milestones like marriage can stir up anxiety—even in good relationships. Going slow doesn’t mean “no.” It means respecting your timing.	\N	\N	\N	\N	\N	\N
5249d799-a4d2-420f-9b62-09aadbdb573c	\N	P004	\N	\N	She said “I love you,” and I panicked. I didn’t say it back.	That sounds like it caught you off guard. What was your first reaction inside?	\N	\N	\N	\N	\N	\N
35029551-094a-4305-b3df-0052281c82c7	\N	\N	\N	\N	I froze. Not because I don’t care, but because it felt too soon.	What does “I love you” mean to you at this point in a relationship?	\N	\N	\N	\N	\N	\N
c969291b-f734-45bd-8ca1-bc60d7211a96	\N	\N	\N	\N	Commitment. Depth. And I’m not quite there yet.	Would it help to explore ways to stay honest without pushing her away?	\N	\N	\N	\N	\N	\N
7d50f548-7ad4-4d7a-a62a-02af68fbe277	\N	\N	\N	\N	Yes, because I do care a lot.	Here are some ways to make you feel more in control:	\N	\N	\N	\N	\N	\N
c9163a42-6a24-480e-afe7-97bdfb54ab16	\N	\N	\N	\N	– Acknowledge her feelings with gratitude and share where you’re at: “I really care about you and I’m still growing into those words.”	You could acknowledge her feelings with gratitude and share where you’re at by saying something like: “I really care about you and I’m still growing into those words.”	\N	\N	\N	\N	\N	\N
9c76adbf-b030-4d6c-bb8f-01cccc92463f	\N	\N	\N	\N	– Suggest revisiting the conversation when it feels right.	You can suggest revisiting the conversation when it feels right.	\N	\N	\N	\N	\N	\N
1a584468-5b1a-4645-864e-d16efeba9c90	\N	\N	\N	\N	– Talk about what love means to each of you.	Or you can talk about what love means to each of you.	\N	\N	\N	\N	\N	\N
931118c3-f89d-4308-bc29-a3614cbc635c	\N	\N	\N	\N	What would feel most authentic to you?	What would feel most authentic to you?	\N	\N	\N	\N	\N	\N
3a76e725-5574-48e2-8123-982e19e0aacd	\N	\N	\N	\N	I want to be honest but kind. Maybe say I’m still catching up emotionally.	That’s thoughtful. Emotional timing doesn’t always sync up—and that’s okay.	\N	\N	\N	\N	\N	\N
ea7e0865-8792-4007-8aab-3160e0edc188	\N	\N	\N	\N	\N	Love isn’t a race. It’s a dialogue. The healthiest relationships allow room to grow into the words.	\N	\N	\N	\N	\N	\N
a95fa5fc-041e-4694-8305-b024fbb512ac	\N	P004	\N	\N	He wants to move in together, but I’m not sure I’m ready.	That’s a big transition. What makes you unsure right now?	\N	\N	\N	\N	\N	\N
0ef353d2-0ecd-424e-8607-4a17396dd85d	\N	\N	\N	\N	I like having my own space. And I’m afraid of what might change.	What part of your independence feels most important to protect?	\N	\N	\N	\N	\N	\N
62ce38df-27c8-47f0-bb1a-09e9cfd0645c	\N	\N	\N	\N	Having a place to recharge. I need that time alone.	Would it help to explore whether there’s a way to keep that, even if the relationship deepens?	\N	\N	\N	\N	\N	\N
adb8420a-f067-4cba-833d-43187358e130	\N	\N	\N	\N	Maybe. I just don’t want to lose myself.	Here are some options of what you can do	\N	\N	\N	\N	\N	\N
c410ed71-12b1-428e-a54c-6dcafa699ef0	\N	\N	\N	\N	– Talk to him about a trial weekend or shared routine before a full move.	You can talk to him about a trial weekend or shared routine before a full move.	\N	\N	\N	\N	\N	\N
d445f54b-0d64-4f44-9b82-23ba75ca4837	\N	\N	\N	\N	– Explore a shared living arrangement where you each still have alone time.	You can explore a shared living arrangement where you each still have alone time.	\N	\N	\N	\N	\N	\N
27c84e5f-d368-49db-b0a0-707b323004dc	\N	\N	\N	\N	– Consider keeping separate places longer and checking in about it later.	You can consider keeping separate places longer and checking in about it later.	\N	\N	\N	\N	\N	\N
cb26cd37-d3db-4290-bb2c-64a837e56129	\N	\N	\N	\N	Which of these might feel like a starting point?	Which of these might feel like a good starting point for you?	\N	\N	\N	\N	\N	\N
9da66d9f-e000-4bda-a559-f2e1166405f8	\N	\N	\N	\N	Maybe the trial idea. I want to see how it feels.	That’s a wise step. Trying something small before a big leap lets you stay connected *and* grounded.	\N	\N	\N	\N	\N	\N
3dd5bb43-83a4-4689-9269-3003386f0c2b	\N	\N	\N	\N	\N	Moving in is not just about logistics—it’s about emotional rhythm. Make sure both of yours are heard.	\N	\N	\N	\N	\N	\N
7cc69b24-4e9d-44d7-80c6-86775c01752d	\N	P004	\N	\N	I don’t know if I want to stay in this relationship, but I feel bad leaving.	That sounds painful. What’s keeping you from making a decision?	\N	\N	\N	\N	\N	\N
872cce40-410e-4258-967e-0e065b28dfb9	\N	\N	\N	\N	I care about them. But I also feel stuck.	What do you feel when you imagine staying—and when you imagine leaving?	\N	\N	\N	\N	\N	\N
d1142171-d20e-43e0-b9fa-502b50de8836	\N	\N	\N	\N	Staying feels heavy. Leaving feels guilty.	Would it help to sort through whether you’re staying for love, or out of fear of hurting someone?	\N	\N	\N	\N	\N	\N
7604c94b-47d9-40a4-a0db-806e3cd6403a	\N	\N	\N	\N	Yeah. I’ve been avoiding that.	Here are a few next steps you could try:	\N	\N	\N	\N	\N	\N
f7d6d96b-189f-4f05-8c28-0fbf41974278	\N	\N	\N	\N	\N	– Journal about what you want and need, apart from anyone else., then see if you can assess which is stronger. writing something can often offer clarity.	\N	\N	\N	\N	\N	\N
f1319d2d-5224-47fc-8ed5-9f30b46f9b14	\N	\N	\N	\N	\N	Or, you can sit and talk with a friend that you trust, do the same thing and then ask them to repeat it for you - hearing someone else saying it can help you see the situation more clearly.	\N	\N	\N	\N	\N	\N
b78d4b60-d193-4d36-bc8b-c0117683ec4f	\N	\N	\N	\N	\N	what would you prefer?	\N	\N	\N	\N	\N	\N
31ceb1b8-2207-4385-9904-222091d3c3cb	\N	\N	\N	\N	Maybe journaling. I don’t know what I feel yet.	That’s a solid start. Giving yourself space to listen inward is the first sign of self-respect.	\N	\N	\N	\N	\N	\N
c5ceb48a-2af9-4994-a726-8a6fdafc7e0a	\N	\N	\N	\N	\N	remember, Relationships end sometimes—not out of failure, but because people grow. The goal is clarity, not guilt.	\N	\N	\N	\N	\N	\N
2541b6e7-a147-4b11-ad8a-b9cae3173a18	\N	P004	\N	\N	I get anxious when he doesn’t text me back right away. My mind goes wild.	That sounds really overwhelming. What do you notice happens in your body or thoughts when that happens?	\N	\N	\N	\N	\N	\N
e03419fd-2d33-4be1-bb83-ffd0340040a8	\N	\N	\N	\N	My chest tightens and I start imagining he’s mad or losing interest.	What do you think those thoughts are trying to protect you from?	\N	\N	\N	\N	\N	\N
f719787b-75da-4c81-ba76-ea3f8390b5ae	\N	\N	\N	\N	Probably rejection. I’ve been ghosted before.	Would it help to explore ways to manage the anxiety in the moment, and talk to him about how communication affects you?	\N	\N	\N	\N	\N	\N
f154c238-ec73-49b2-abdd-48f7bf348f2a	\N	\N	\N	\N	Yeah. But I don’t want to sound clingy.	Here are a few options:	\N	\N	\N	\N	\N	\N
1dae544e-14f3-4908-8360-caca4672cb9d	\N	\N	\N	\N	\N	– Practice grounding techniques when the urge to overthink hits.	\N	\N	\N	\N	\N	\N
7a777c6b-dd0c-4fb7-b137-0cb328959cea	\N	\N	\N	\N	I want to ask him about texting expectations.	That’s a great way to build clarity.	\N	\N	\N	\N	\N	\N
2a388b8f-f265-420f-bf91-cfaa587f0fce	\N	\N	\N	\N	\N	Our brains react to uncertainty like danger, especially if we've been hurt before. Healthy communication can soothe those old alarms.	\N	\N	\N	\N	\N	\N
7f10d542-c038-4e10-b91e-a1e68e153f52	\N	P004	\N	\N	She shares everything with her ex and says they’re “just friends.” It bothers me.	That sounds like a tough spot. What feels hardest about it for you?	\N	\N	\N	\N	\N	\N
5e42734f-d474-4efe-8412-64d7e2d81d9a	\N	\N	\N	\N	It’s like she tells him things before me. I feel pushed aside.	What do you think that dynamic says about what you need in a relationship?	\N	\N	\N	\N	\N	\N
0174e4e2-ffc8-4ba2-8a10-a8d3b7d55e86	\N	\N	\N	\N	I need to feel like I’m the one she leans on.	Would you like to explore ways to talk to her about your needs without making demands?	\N	\N	\N	\N	\N	\N
3af6fb85-de23-4c49-8e92-17c6e80725c9	\N	\N	\N	\N	Yeah, I want to say something without sounding jealous.	Here are some ideas:	\N	\N	\N	\N	\N	\N
e25de562-ed03-434b-8291-6b6c14d82f74	\N	\N	\N	\N	\N	– Ask her gently, “Can we talk about how much you share with your ex?”	\N	\N	\N	\N	\N	\N
1e66be03-ed4f-4c09-8201-719cdf9b7fed	\N	\N	\N	\N	I’ll try asking to talk. I want to be honest.	Honesty with care builds real intimacy.	\N	\N	\N	\N	\N	\N
f7e239bb-5476-447a-9d2c-04b9786956e0	\N	\N	\N	\N	\N	remember, Past relationships can linger in subtle ways, but current ones deserve clear space and priority.	\N	\N	\N	\N	\N	\N
e37891a5-976d-4f68-882f-6ae5ade928a9	\N	P004	\N	\N	He jokes in public about things I told him in private. It makes me shut down.	That must feel like your trust is being exposed. What’s it like for you when that happens?	\N	\N	\N	\N	\N	\N
2a2ff4f6-095e-431a-8fb4-747a2d58f12d	\N	\N	\N	\N	I feel stupid and betrayed. Like I can't relax around him anymore.	Do you think he understands the impact of those comments?	\N	\N	\N	\N	\N	\N
1a0ded46-7e5b-4056-81a2-44a7c959e915	\N	\N	\N	\N	No. He says I’m “too sensitive.”	Would you like help thinking through how to set a boundary that protects your voice?	\N	\N	\N	\N	\N	\N
ace36814-e17d-41b1-82d3-5562b2fa254f	\N	\N	\N	\N	Yes, please. I don’t want to keep quiet about this.	Here are some ways to take control:	\N	\N	\N	\N	\N	\N
12939c28-e482-42e7-ae21-9f2e27cb4b14	\N	\N	\N	\N	\N	– Say something like, “When you share private things as jokes, I feel unsafe.”	\N	\N	\N	\N	\N	\N
a03a89ee-62c7-4b22-afbc-b60fc8e0c5a3	\N	\N	\N	\N	\N	Which approach feels most true to you?	\N	\N	\N	\N	\N	\N
44a450ac-e6ed-462b-8872-4594952d07cb	\N	\N	\N	\N	Maybe the first. I want to say how it made me feel.	That’s a strong start.	\N	\N	\N	\N	\N	\N
df5187a0-f91c-4449-8a65-a74b921f7608	\N	\N	\N	\N	\N	Emotional safety is just as important as physical safety. Jokes that cross trust lines aren't harmless—they chip away at closeness.	\N	\N	\N	\N	\N	\N
1727afca-9f01-48dd-98db-5ee6ab65bb40	\N	P004	\N	\N	She said she needed space, but I don’t know what that means. Is it over?	It’s hard sitting in the unknown. What do you think she meant by “space”?	\N	\N	\N	\N	\N	\N
eb592c1c-3bfc-45de-a289-27ac175799a5	\N	\N	\N	\N	I honestly don’t know. She didn’t explain.	What’s your gut telling you right now about what you need?	\N	\N	\N	\N	\N	\N
84773deb-c015-45a0-8c2d-c5916b28a55e	\N	\N	\N	\N	I want to respect her, but I’m spiraling.	Here are some options of what you could do:	\N	\N	\N	\N	\N	\N
3866c15f-f7f6-4bc2-812b-d4d8022eab5b	\N	\N	\N	\N	– Ask her to clarify what “space” means to her?	Ask her to clarify what “space” means to her?	\N	\N	\N	\N	\N	\N
509e626a-e0c5-4807-840e-12b0e18ac126	\N	\N	\N	\N	– Focus on your own needs right now and create a self-care plan?	Focus on your own needs right now and create a self-care plan?	\N	\N	\N	\N	\N	\N
cb6a2c69-b627-49e1-95be-d5f6221e64a5	\N	\N	\N	\N	– Talk to someone neutral to help ground yourself?	Talk to someone neutral to help ground yourself?	\N	\N	\N	\N	\N	\N
aaaba4de-44ce-404b-a86e-8b20cf07f3a5	\N	\N	\N	\N	I think I need to ask her directly.	That shows strength. Asking for clarity helps you stop guessing and start breathing.	\N	\N	\N	\N	\N	\N
da15902c-24b4-4296-8042-f8156856c72e	\N	\N	\N	\N	\N	“Space” can mean many things. What matters is how each person defines it—and whether both feel respected.	\N	\N	\N	\N	\N	\N
5e085c39-d46d-4e9f-affc-642c5eb00e93	\N	P004	\N	\N	I feel like I’m always the one initiating everything in this relationship.	That sounds exhausting. What does it feel like to carry most of the effort?	\N	\N	\N	\N	\N	\N
4c22cdf8-36e3-406f-a33e-0f07a7a86121	\N	\N	\N	\N	Like I care more than they do. It’s starting to wear me down.	What do you think is behind their lack of effort—or how do you interpret it?	\N	\N	\N	\N	\N	\N
41a7b225-062f-480f-a27d-b82c80aa628a	\N	\N	\N	\N	I’m not sure. I just know I feel alone in this.	Would you like to explore how to share your need for balance—or decide if this is the right dynamic for you?	\N	\N	\N	\N	\N	\N
6dbde10b-36d6-4cd5-b53b-6975d5b1a0e0	\N	\N	\N	\N	Yes, I need to speak up.	Here are some choices:	\N	\N	\N	\N	\N	\N
782764b8-ca9b-40c8-bae0-30554a0c1c56	\N	\N	\N	\N	\N	You could say something like: “I’ve noticed I’m doing a lot of the work—can we talk about that?”	\N	\N	\N	\N	\N	\N
fb945f83-9434-442d-bf06-f2a968ff60bb	\N	\N	\N	\N	\N	Or you could pause your initiating and see what happens.	\N	\N	\N	\N	\N	\N
364a9ed3-c2b0-4973-89c4-1d76c272e5dd	\N	\N	\N	\N	\N	Or you could reflect on whether this pattern has shown up in other relationships, too.	\N	\N	\N	\N	\N	\N
927798ea-34ff-47bd-93a2-5d41b6d06f05	\N	\N	\N	\N	\N	Which step feels right for now?	\N	\N	\N	\N	\N	\N
77a28fd2-4e30-4b18-a450-9d7442e69807	\N	\N	\N	\N	Maybe I’ll speak up and take a little step back too.	That’s a good balance.	\N	\N	\N	\N	\N	\N
6b04c34a-a8fb-4fb3-a7ec-54453cd58e05	\N	\N	\N	\N	\N	Mutual effort is part of healthy connection. If love only flows one way, it starts to feel like work instead of warmth.	\N	\N	\N	\N	\N	\N
1d881a8f-31a6-4acb-8f85-42f3f99a2378	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1dfc7a6b-5ec0-4567-a431-40a16c643a4e	\N	\N	\N	\N	I'll try the journal method	That sounds like a good choice. If you keep a journal next to your bed and whenever your mind races, start to write all of your thoughts down. When you have finished writing, reread it and see if you have anything to add. Arrange your thoughts by topics, and ask yourself if there is anything that can wait until the morning, or if it has to be dealt with right now. It's most likely that you will be able to deal with everything in the morning.	\N	\N	\N	\N	\N	\N
e0fc06c7-c6aa-4dac-8e3a-ef34ccb1c588	\N	\N	\N	\N	I'll try the visualisation method	Good for you for taking control and choosing visualisation. You can do this by thinking about a soothing, pleasant experience you've had in the past, and use your imagination to go back to this time. Allow your thoughts and feelings to sit in this experience, and sit with it until your whole body relaxes.	\N	\N	\N	\N	\N	\N
0880457d-7a63-4c96-adaa-00785c1da22c	\N	\N	\N	\N	I'd like to create a step by step plan	Great! Let's create a step by step plan of how to manage your stress: 1. When your first arrive, talk to the teacher and ask if you are able to watch a friend before using the equipment yourself. 2. Watch the other kids use the equipment before you have a go. 3. Ask yourself how scared you are, from 0-10. 4. Positive self talk about doing something even when you feel scared. 5. Limit the time you spend on the equipment and engage in an activity where you will feel successful. 6. Once you have finished the activity, compare the way you feel  - how scared are you now, and how accomplished do you feel?	\N	\N	\N	\N	\N	\N
35114776-41a8-4fe1-bccf-ff6a2781b834	\N	\N	\N	\N	I'd like to do some research about the equipment	Great! Do you prefer to do a google search, or to talk to someone who has used this piece of equipment previously?	\N	\N	\N	\N	\N	\N
fd27634b-c697-42da-9a0f-0209c4d75eae	\N	P004	\N	\N	I feel stressed out because my parents expect me to get excellent grades in all of my subjects at school.	It sounds like you're feeling very stressed out as your parents have very high expectations of you. Which part of them having high expectations of you, is most stressful? Is it the pressure to always acheive high grades, the way it impacts your family reputation, or the way it may impact your future?	\N	\N	\N	\N	\N	\N
3ecbbd85-675f-4701-a96f-e436f0b7b095	\N	\N	\N	\N	I feel stressed that if i don't acheive good grades then it will impact my future and I want be able to support my family	It can be very stressful to have a lot of pressure to always succeed at school with high grades, and to feel that if you don't acheive then you may not have a successful future ahead of you. I think many people in your situation would feel stressed out as well. What do you want to do about it? Do you want to try and have a conversation with your parents, or do you want to create a plan to help you manage your stress?	\N	\N	\N	\N	\N	\N
67f06391-d341-429e-ad9d-fdc3d56740dc	\N	\N	\N	\N	I'd like to make a plan to help me manage my stress	\N	\N	\N	\N	\N	\N	\N
30df00c6-3490-4403-bbe7-be383e03f790	\N	P004	\N	\N	I don't understand what is happening in science class and I keep failing the tests. This is really stressing me out.	I'm sorry to hear that you're finding the science subject at school very hard, and that you feel as if you're not succeeding. It's very difficulty to do well on a test when you don't follow what is going on in class. Many people find science very difficult. Some choose to go online and search for explanations via you tube, others ask a friend to help them, and some go to the teacher for help. What would you prefer to do?	\N	\N	\N	\N	\N	\N
ba6f3b46-f80c-48c0-bd60-87692ad49576	\N	\N	\N	\N	I would feel most comfortable asking a friend for help.	That sounds like a great idea, do you have a particular friend you could ask? It's much easier when you have a plan in place, so you can have a think about exactly what you're going to ask your friend. For example, do you have specific question you want to ask your friend, or specific topics you don't understand.	\N	\N	\N	\N	\N	\N
2b68442a-8fff-4907-81cd-8ca67a8d2cdb	\N	\N	\N	\N	Yes, I"m going to go and ask my friend Ika, because she is very patient and will be able to explain things easily to me.	\N	\N	\N	\N	\N	\N	\N
39ddc89e-df8d-4443-a243-475b36149feb	\N	P004	\N	\N	I went onto instagram, and I saw photos of my x-girlfriend hanging out with her friends and having a lot of fun. It feels like she's already forgotten about me, and I"m so angry that I don't know what to do.	It sounds like you're really struggling with your break-up with your girlfriend. Breakups can be very overwhleming, upsetting and emotionally draining. Sometimes when people feel angry, they're actually feeling a lot of sadness. What usually works for you when you're sad?	\N	\N	\N	\N	\N	\N
06db97a3-1475-4a2a-a6ea-b9a2c0859de1	\N	\N	\N	\N	When I'm sad it helps me to distract myself and not think about what's going on.	It sounds like you know what works for you. There's a few ways you can manage this, you can unfollow your x-girlfriend on instagram so you don't have to see what she's doing all of the time. The other option is to distract yourself with other thing aside from social media, such as going out with friends, doing sport or anything you like. This usually helps people. What would you like to do?	\N	\N	\N	\N	\N	\N
082218fb-718a-4b7f-b3fa-18678e4db3d5	\N	\N	\N	\N	I'm going to hang out with my friends, and try to take a break from social media.	Good for you for taking action. Breakups can be very difficult for everyone. Give yourself at least 3-4 weeks of creating new habits before you expect to see a big change in the way you feel. It can take time.	\N	\N	\N	\N	\N	\N
6e63c05a-461c-47a9-8723-a100ba570c6e	\N	P004	\N	\N	I'm scared to go to school today because I get bullied by 3 boys in my class.	Experiencing bullying is a really tough thing. Can you tell me more about what's going on?	\N	\N	\N	\N	\N	\N
6dfae924-d75f-4fd8-80e1-829be28706ba	\N	\N	\N	\N	The boys call me names, they tell me I'm stupid and they always laugh about what I wear.	It must be very difficult to motivate yourself to go to school when you know that people are making fun of you all of the time. It sounds especially hard when they are laughing at you about things that you can't change. Dealing with bullies is not easy. Some kids who are being bullied choose to ask for help from an adult at school, and some kids prefer to talk to the bullies themselves. We know that bullies don't usually just go away, so you can choose to get help from an adult, or try to deal with it yourself. What do you prefer to do?	\N	\N	\N	\N	\N	\N
cb49902e-e07b-49f5-8436-a06ac6ff647b	\N	\N	\N	\N	I don't want to ask an adult for help. What can I do myself?	Some kids feel OK to approach the bully themselves. Others don't want to, but decide that whatever the bullies say, won't impact them, by saying this to themselves "your words are empty and they can't hurt me". What would you like to do?	\N	\N	\N	\N	\N	\N
65ac3440-cd89-40b6-9548-082011f756b8	\N	\N	\N	\N	I think I"m going to say this to myself, I don't think I have the courage to approach the bully	Great, taking control over how much it impacts you it a very big towards ending bullying. Usually, when a bully notices that his words have no impact, he stops. Good for you for taking charge of your own reaction.	\N	\N	\N	\N	\N	\N
332d1775-66ae-4f56-9e44-8142746eabfc	\N	P004	\N	\N	I'm scared to go to school today because I get bullied by 3 boys in my class.	Experiencing bullying is a really tough thing. Can you tell me more about what's going on?	\N	\N	\N	\N	\N	\N
3cac7d74-4985-46a4-9fc0-49ad880613f2	\N	\N	\N	\N	I prefer to speak to an adult, but who should I speak to and what do I say to them?	Usually, people approach an adult that they know well and they trust. Do you have someone like this at your school or in your family?	\N	\N	\N	\N	\N	\N
3f3de64f-238e-43f1-94cb-8a9b38c4a806	\N	\N	\N	\N	I like the school counsellor, but what should I say to her?	What do you think it's important for her to know? If you were the school counsellor, what do you think you would need to know so you could help the student? It's normal to feel nervous when talking to an adult about bullying. But most adults takes bullying seriously and want to help.	\N	\N	\N	\N	\N	\N
29d707c1-5806-4d2e-b13d-eb273feb7d77	\N	\N	\N	\N	I want to tell her that the boys usually make fun of me during gym class.	Good for you, for being able to share that with someone that can help. Once you've had that conversation, what would you like to see happen? Do you want the counsellor to have a conversation with you and the boys together or for her to speak to the boys on their own? It will be easier if we have a solid plan of what you think will be helpful.	\N	\N	\N	\N	\N	\N
b6aefaca-1d69-4269-8f74-179525c3100d	\N	\N	\N	\N	I'm not sure, I don't know what would be best to do here.	It's normal not to always have an answer. It sounds to me that you need to follow your plan by talking to the counsellor, and then you can make a plan together. Would that work for you?	\N	\N	\N	\N	\N	\N
46e9a8f8-0672-457b-a33f-6d233e1c89cf	\N	\N	\N	\N	Yes, I think that would be helpful. I'm going to talk to the counsellor and then come up with a plan together with her.	Great idea!	\N	\N	\N	\N	\N	\N
b5adddfe-65e9-428b-a756-840991d1067a	\N	P004	\N	\N	I can't do this	"I can see this is really tough for you right now. It’s totally normal to feel overwhelmed in front of a group. You’re not alone." You know, you did start speaking, which already shows a lot of courage. It seems like your brain just hit pause for a second—it happens to a lot of people, even adults.	\N	\N	\N	\N	\N	\N
39c792fa-64a8-42b5-a5c1-a88937afc40b	\N	\N	\N	\N	It’s really hard for me	It looks uncomfortable and not pleasant to feel this way. Let’s think about what could help right now. Would it feel better to sit down and read your notes? Or maybe take a quick break and come back to it? Totally your call	\N	\N	\N	\N	\N	\N
bb1d89c3-18e4-4a3f-b0da-4929afd3506c	\N	\N	\N	\N	Maybe I can sit and just read it from the paper	That’s a great idea. Freezing like this happens when your body goes into stress mode—it’s just your brain trying to protect you. Next time, we can practice breathing or using note cards. There are lots of strategies that help."	\N	\N	\N	\N	\N	\N
ef4fbb1c-0a23-4ad5-a7bf-a735859d1109	\N	\N	\N	\N	Okay. I’ll try sitting down. Thanks	\N	\N	\N	\N	\N	\N	\N
94390c8e-3fe5-41e4-b279-7f5cdb0d00c2	\N	P004	\N	\N	I'm not going. I don't care waht you say. I'm not going to a dinner with uncle Budi. He always speaks down towards me	You sound really upset. I can tell that being around him feels aweful for you	\N	\N	\N	\N	\N	\N
f8be4d29-3040-4eac-bb8f-ba0ce0a2a8fd	\N	\N	\N	\N	Yes it does. He talks to me as if i am still 10 years old and I'm sick of pretending it's OK	I understand that, it's really frustrating when someone treats you as if you are younger than you really are. And having to keep a smile on your face just adds to that pressure.	\N	\N	\N	\N	\N	\N
85f10dca-93c9-41e0-8c4b-63e37801df3b	\N	\N	\N	\N	Exactly. no one eer says anything to him and I just have to sit there and listen.	What do you think would help you feel less stuck this time? Do you want to sit at the other end of the table? Or give me a signal if it gets too much and you need to take a break?	\N	\N	\N	\N	\N	\N
ac953f59-772f-4211-afe0-f292b1487856	\N	\N	\N	\N	I guess sitting further away from him would help me. And may be i could just leave the room if i need to?	Yes, we can do that. It's also important for you to know that some people choose to speak up directly, and others set boundaries in quieter ways. If you ever want helpwith waht to say to him, we can come up with something together.	\N	\N	\N	\N	\N	\N
ef4915e5-8dc9-4f69-8781-a12c88803c14	\N	\N	\N	\N	Ok, I don't think i will talk, but if I can sit far away from him, I will go to the dinner	\N	\N	\N	\N	\N	\N	\N
f1e1c93d-de2c-4879-8115-998f192b6e70	\N	P004	\N	\N	I don't want to go back to school. I know they're talking about me	Do you think people are saying things behind your back?	\N	\N	\N	\N	\N	\N
17ec619a-8603-4167-84df-67f67c278574	\N	\N	\N	\N	Yes, after that silly fight we had last week, they posted this story on instagram. They didn't put a name, but it was obviously about me	Ugh that must feel awful. It must feel like you're being watched and judged non-stop	\N	\N	\N	\N	\N	\N
7c3a648e-b2b4-4528-8644-c7483fe8c81f	\N	\N	\N	\N	Exactly. I keep thinking about it. I can't sleep. I feel terrible.	Do you want to show me the story? Maybe we canfigure out how much it was directed at you. Sometimes our brains fill in the worst case version	\N	\N	\N	\N	\N	\N
5d24ebfe-1d2e-4826-9ee9-62ac918ae16b	\N	\N	\N	\N	Sure, here it is. It was posted just after our fight, so it must be aimed at me	I see why it feels that way. And even if it's not named, it hit hard. The makes sense. When people post things like this, it's designed to sting and hurt.	\N	\N	\N	\N	\N	\N
c30c6077-243c-46b4-a16d-5e94a14f8b44	\N	\N	\N	\N	Yeah, I just keep replaying it in my head	What do you want to do? Do you want to take a break from your phone for a bit? I can hang out with you or we can do something else offline	\N	\N	\N	\N	\N	\N
61bd1df3-bc1f-4a4a-b11d-6856168aeea6	\N	\N	\N	\N	Yeah, i need a break. I don't even want to look at it anymore	You're not the only one this kind of thing happens to. Lots of people feel better when they unplug and talk it out. If you want, i can help you think about it or how you want to respond later on.	\N	\N	\N	\N	\N	\N
f19951bf-c7db-436a-a2c3-536c1f422c7e	\N	\N	\N	\N	Ok, that helps a lot. Thanks for not acting as if nothing happened.	Of course, it's something big. And i've got your back.	\N	\N	\N	\N	\N	\N
c64ec3f7-8390-4640-a217-52a5dc6ab586	\N	P004	\N	\N	I'm not going back. What if something happens again?	I hear you, it must feel really scary to even think about sitting in class like everything is normal	\N	\N	\N	\N	\N	\N
ea04b45c-edb6-4193-86b0-2ee20d1fabfd	\N	\N	\N	\N	Yeah, my body feels tight just thinking about walking in there	It makes sense, you went through something very intense. No one expects you to just bounce back	\N	\N	\N	\N	\N	\N
1d83e199-1ff9-480e-9aa6-87d3d98e3346	\N	\N	\N	\N	So then why do i have to go back at all?	Let's look at options. What if we try half days for now? Maybe just mornings with breaks in between?	\N	\N	\N	\N	\N	\N
a3b48ea3-7d18-40b0-90f5-ea5748d5453c	\N	\N	\N	\N	I guess...that sounds a little bit better than a full day	And some students find it helps to have a safe space they can step into if they need it, would that help as well?	\N	\N	\N	\N	\N	\N
2418ee52-2d6a-433d-bd9d-dd9f81b3ba27	\N	\N	\N	\N	Yes, just knowing that I can leave if I need to	OK, that is something we can arrange. When the brain goes through something traumatic, it stays on alert for a while. So we rebuild trust in small steps. You're not alone in this, and you don't have to do it all at once.	\N	\N	\N	\N	\N	\N
dc8b4203-6355-4751-bde4-40a56f9f08bc	\N	P004	\N	\N	Everyone got invited except for me. I dont' even know what i did.	That kind of thing really hurts. I would feel the same	\N	\N	\N	\N	\N	\N
6b6ded03-30df-4167-9e91-7e8df8e9a014	\N	\N	\N	\N	I'm trying not to care, but i keep checking their stories like a looser	Yeah, it's hard to stop looking when you feel left out. It's like your brain wants to punish you even more.	\N	\N	\N	\N	\N	\N
94f89f16-cf48-4bd3-9ddf-4af863c28a2c	\N	\N	\N	\N	I just want to disappear	You don't have to dissapear. You matter, with our wihtout that invite. Do you want ot hang out with me on the night of the party instead?	\N	\N	\N	\N	\N	\N
306bdec8-461d-4543-9661-347922d0ff99	\N	\N	\N	\N	I guess, but i still feel like I'm not part of the group anymore	Some people do these kind of things because they don't know how to talk things out. Others just go along with it. Do you want to think about whether this is something you want to confront, or prefer to let go of?	\N	\N	\N	\N	\N	\N
2f638a51-200f-41e2-afe0-b2436fadcb1d	\N	\N	\N	\N	Maybe, but right now I just dont' want to be alone	Ok, I won't leave you alone. We'll figure this out together. And remember, the pain you're feeling now doesn't define your future connections.	\N	\N	\N	\N	\N	\N
029974e1-d0bf-4159-9e91-1b9eb8a1e6cb	\N	P004	\N	\N	I keep failing. It doesn't matter how hard I try, I'm just terrible at maths.	That sounds really discouraging. You've been trying so hard and you still feel stuck.	\N	\N	\N	\N	\N	\N
c269460c-d29b-436e-8ec7-7bbb56f1fe85	\N	\N	\N	\N	I study for hours, but the minute I see the test, my brain goes blank.	That kind of stress can shut your whole brain down. It's not about your ability, it's your brain going into panic mode.	\N	\N	\N	\N	\N	\N
a61228ac-414c-4959-b937-7bd6ff6e4ddb	\N	\N	\N	\N	Then what is the point of even tryingg?	Some students in your situation work with a tutor to help them, or request extra time on their tests. Others change the way in which they study. Let's explore some of those options	\N	\N	\N	\N	\N	\N
af0dee8f-8360-4397-91a0-232ec0d0815d	\N	\N	\N	\N	Do you think i'm stupid?	I know you're not stupid. You're overshelmed, and there's a difference. When our bodies are stressed, they aren't able to recall information and have a hard time focussing. We can make a plan that works with how your brain handles stress.	\N	\N	\N	\N	\N	\N
e4a29ddc-6061-4a8f-aa34-278050fc196e	\N	\N	\N	\N	OK, I'll try again if we can change the approach	I'm with you. Let's try smoething that actually supports you this time. And remember, needing help doesn't mean you're failing, it means you're human	\N	\N	\N	\N	\N	\N
97af9b95-5ba3-4b5a-a35f-5f92e671eeb0	\N	P004	\N	\N	It's like I'm always the extra person. I don't fit in with anyone	That sounds lonely. Like you're always on the outside looking in	\N	\N	\N	\N	\N	\N
59107f50-dd83-4466-9cf2-d9fb0882cc38	\N	\N	\N	\N	Yeah, even when I'm with people, I still feel alone	I've felt that before. It's exahsuting pretending you're OK all of the time	\N	\N	\N	\N	\N	\N
d4e3b000-50be-4a4e-a8bd-7095712b41e7	\N	\N	\N	\N	I don't think I"ll ever have a real group of friends	Some people find their group of friends later than others. What if we start with one connection at a time? IS there anyone who feels even a little bit safe to talk to?	\N	\N	\N	\N	\N	\N
9f3ba621-d284-4701-b780-e3dc45a2e4af	\N	\N	\N	\N	Maybe Maya, she's quiet like me	That's a good start. Some people focus on depth of friendships, instead of crowds. You might be one of those peopel, and that's OK	\N	\N	\N	\N	\N	\N
1413ab35-72cc-428b-84f6-413aefa42cd6	\N	\N	\N	\N	I just don't want to feel invisible anymore	Do you want to find one moment this week where you felt seen? Whether it was a message from Maya or a moemnet when you felt heard? Those small things all add up	\N	\N	\N	\N	\N	\N
fab6f143-6fbe-413e-a2ea-694a1e2ee4a1	\N	P004	\N	\N	I messed everything up! The whole group is angry at me and we're going to fail	I hear how heavy that feels. You're carrying a lot of guilt right now.	\N	\N	\N	\N	\N	\N
5ca9ac6e-994e-4bb8-9ce9-f52d44bc04aa	\N	\N	\N	\N	Because it's true! I missed the deadline. now the whole project is messed up	Missing a deadline is serious, but it doesn't mane thte whole project is ruined. Or that you are.	\N	\N	\N	\N	\N	\N
0e8e1065-5139-4152-9884-cf269391be4b	\N	\N	\N	\N	I just want to fix it, but I don't even know how	What do you think the first step could be? An apology or taking the lead on fixing things up?	\N	\N	\N	\N	\N	\N
7a389762-05ee-41b3-81a4-1c87645012f8	\N	\N	\N	\N	Maybe both, i'll message the group first	That sounds like a strong move. Some students recover really well after a mistake, beause they take responsibility and repair	\N	\N	\N	\N	\N	\N
4f7166d5-2b6f-4f15-8f8b-0f773fc61983	\N	\N	\N	\N	But what if they are still angry at me for a long time?	They may be angry for a while, and that's OK too. It doesn't define you. Repairing doesn't mean erasing the mistake. It means learning how to show up even after it.	\N	\N	\N	\N	\N	\N
83ee25a4-c42d-49f3-b112-651653854747	\N	P004	\N	\N	I hate my face, I hate how I look in every single picture	It sounds like you're really frustrated with what you see in the mirror	\N	\N	\N	\N	\N	\N
8eab4b4d-f47e-4afa-ae51-e2a30e2c72d6	\N	\N	\N	\N	Yes, I feel aweful. Like I'm the ugly one in every room	That kind of self talk can be brutal. I wish you could see what I see when I look at you	\N	\N	\N	\N	\N	\N
f0f2747d-4be6-4d8b-add0-3dbe904d9db3	\N	\N	\N	\N	You're my parent, you have to say that	True, but I also know that so many teenagers feel this way, especially when social media is full of edited, filtered versions of poeple. It tricks our brain into thinking we're not good enough.	\N	\N	\N	\N	\N	\N
e2969e8a-a1dd-416b-ae56-7887da96d987	\N	\N	\N	\N	I just feel like I"ll never be OK wiht how I look	You're not alone. Some poeple try limiting their time online, or practicing self compassion in front of the mirror. Do you want to experiment with one of those and see how it feels?	\N	\N	\N	\N	\N	\N
bc5c224f-25be-43a2-9d99-8dd0de27a604	\N	\N	\N	\N	Maybe, I don't want to feel this way forever	You won't. We'll try together, at your pace.	\N	\N	\N	\N	\N	\N
cf0bada3-555b-40f6-af1e-730faab05d54	\N	P004	\N	\N	There's something that has gone really wrong, but I can't tell anyone. I'll just get judged	It sounds like you're carrying something really heavy, and alone	\N	\N	\N	\N	\N	\N
9017ceed-36b0-4b36-bdbf-147950123254	\N	\N	\N	\N	I am, but if i talk about it, people will think I'm weak or stupid	I understand your fear. Sometimes saying it outloud is the thing that helps us breath again	\N	\N	\N	\N	\N	\N
130d9b71-c6f3-4f8f-91b0-dca13ddba597	\N	\N	\N	\N	I don't know, maybe. I just hate this feeling	What if we try this. Do you want to just tell me the part you're ready to say, or we can try that tomorrow. Whatever you prefer.	\N	\N	\N	\N	\N	\N
b07c35a9-8617-4201-942f-03b100675a21	\N	\N	\N	\N	OK, I'll tell you now. I failed two tests and I lied about it	Thank you for trusting me. That doesn't make you weak, it makes you human. Now we can figure out what to do next, together	\N	\N	\N	\N	\N	\N
bb69189d-229e-431a-bd47-12d18d0f6ed1	\N	P004	\N	\N	What's the point? I try and try and nothing ever works out for me	Sounds like you're running on empty, as if the effort never matches the reuslts	\N	\N	\N	\N	\N	\N
94779fd2-4860-43e8-88bf-f30d08ef9e0b	\N	\N	\N	\N	Exactly, everyone else succeeds. I always end up getting stuck	That's a hard spot to be in. Sometimes when we're overwhelmed, we don't need to push harder, we need a new approach	\N	\N	\N	\N	\N	\N
4e34a49e-20a0-4be8-a0c1-68cf1b00f385	\N	\N	\N	\N	I don't even know what that means	It could mean smaller tasks, more breaks, or even different ways of learning. What if we focus on just one assignment right now?	\N	\N	\N	\N	\N	\N
92b3cb5a-1c9e-46e1-8503-dd232d1d9f0b	\N	\N	\N	\N	I guess I could do one	One is a win One step builds the next	\N	\N	\N	\N	\N	\N
7d0c7e91-a41d-4488-87d2-f733a924d457	\N	P004	\N	\N	They called me that word again. Right in the middle of the school hallway. No one even said anything or stood up for me	I'm so sorry that happened. That's not OK. And it must have felt awful to stand there and feel invisible	\N	\N	\N	\N	\N	\N
64f09ae0-7dbf-477c-a3b5-cb589bd02999	\N	\N	\N	\N	Yes, like I don't even matter	You do matter. What they said wasn't just wrong, it was harmful. And it shouldn't go unnoticed	\N	\N	\N	\N	\N	\N
60a41cfa-5482-4bcf-a938-32af8a13d3b8	\N	\N	\N	\N	I don't want to make it worse by reporting it	I understand that. Some people write it down first. Others talk it through with someone they trust. What would feel safest for you?	\N	\N	\N	\N	\N	\N
41edd965-b023-4f44-bfb3-3537a10d6787	\N	\N	\N	\N	Maybe I could write it down	That's a brave step. And we'll support you through it, however you choose to speak up.	\N	\N	\N	\N	\N	\N
15202f86-4f93-4bce-b5d0-5177de7c3889	\N	P004	\N	\N	I sit down to study and nothing sticks. My brain feels like mush	Sounds like you're drained. Like your brain is trying to protect you by shutting down	\N	\N	\N	\N	\N	\N
12dc9988-0ff0-41db-b127-a2b5df661fe4	\N	\N	\N	\N	Yes, and the more I fall behind, the more I panic. It's like I'm failing for the first time in my life	That must feel scary. You're used to doing well, and now it feels like it's all slipping away	\N	\N	\N	\N	\N	\N
24312d6c-1cfd-4e5b-b937-cbf5152799c5	\N	\N	\N	\N	Exactly, I do't even recognise myself right now	When we're stuck in stress for too long, our brains go into freeze mode. Let's try one step togehter. What feels most urgent right now? Give me 2 things	\N	\N	\N	\N	\N	\N
541cf443-b0bb-4dde-8f85-d8d21dc78e37	\N	\N	\N	\N	Biology. I need to finish the lab report	Perfect. One page at a time. Your're not broken, you're burnt out. And we'll rebuild from there.	\N	\N	\N	\N	\N	\N
98f04d1e-8221-4c7b-900c-8f51fef12ab4	\N	P004	\N	\N	I think I know who I am, but I can't come out to them. They won't understand	That's a really big weight to carry. I can see you're scared. You deserve to feel safe	\N	\N	\N	\N	\N	\N
4717061a-d69e-4abe-9cfd-10619df0923c	\N	\N	\N	\N	I've gone over every word in my head, and it always ends with them not talking to me	That fear make sense. A lot of people go through this quietly at first, you're not alone. Some come out in stages, when it feels safer	\N	\N	\N	\N	\N	\N
dabbe48f-0026-4de5-87e6-6bfca2f57070	\N	\N	\N	\N	But if I'm hiding this, am I really being myself?	You're protecting yourself, and that's OK. Being careful doesn't mean you're not real. It means you're surviving.	\N	\N	\N	\N	\N	\N
8fd799ae-004c-4ac7-8155-00e85bf9ef17	\N	\N	\N	\N	I just wish it didn't have to be this hard	I can hear how hard it is for you. I"m here with you. What do you want to do about this? What would be helpful?	\N	\N	\N	\N	\N	\N
2f004ade-d353-4596-8117-3406766215c4	\N	\N	\N	\N	To take the pressure off myself right now	Ok, that's great. Do you want to disucss this again with me in 1 week, or in 2 weeks? We can talk about it again then and make some decisions	\N	\N	\N	\N	\N	\N
48ffcbc9-8eef-487f-9893-b8e70d88bf93	\N	\N	\N	\N	Let's talk about it again in 2 weeks, I need some time	That sounds like a good plan	\N	\N	\N	\N	\N	\N
9c53ab6c-3395-4819-b542-1a0d529e6013	\N	P004	\N	\N	I don't know what's wrong with me. I just snap and start swinging on my chair	Nothing is wrong with you. It sounds like your body is in fight mode, and it starts very quickly	\N	\N	\N	\N	\N	\N
e9159135-5457-4d97-a2dd-b2328e8c7caf	\N	\N	\N	\N	Yes, but now I'm suspended again Everyone thinks I"m just a problem child	You're more than your outbursts. That kind of anger usually has a reason. Let's try to figure out what is underlying it	\N	\N	\N	\N	\N	\N
bf2c72df-2e30-4037-b46a-9e8d160b47a2	\N	\N	\N	\N	I guess so...it's usually when people disrespect me, or even look at me the wrong way	That kind of hyper alert feeling makes sense if you've had to stay on guard for long periods of time. What would hlep your body feel safter in those moments? Do you want to think of a few things?	\N	\N	\N	\N	\N	\N
a74aa8cf-0d49-4a86-8cda-22fb50204554	\N	\N	\N	\N	Maybe music, or walking away?	That's a great start. We can build tools together, you're not alone in this	\N	\N	\N	\N	\N	\N
cb8f5e07-48aa-4b87-88b2-62c6ae4bb098	\N	P004	\N	\N	They've just told me they're getting divorced. I didn't even know they were thinking about this	That's huge news to hear. No wonder your mind feels scrambled	\N	\N	\N	\N	\N	\N
0632a729-7d89-44d2-92f7-d5e9b87f85b0	\N	\N	\N	\N	i don't even know how to feel. Sad, angry, empty, all of it at once	All of that makes perfect sense. When the family unit shifts, it shakes everything	\N	\N	\N	\N	\N	\N
a06312a9-50ab-4a55-8146-0b368c2973aa	\N	\N	\N	\N	I just want everything to go back to normal	That's a very natural response. Some teens find it helpful to create new routines, tiny pieces of normal that they can control. Do you want to try that?	\N	\N	\N	\N	\N	\N
8cf0a804-b04f-4f2a-9cf8-7ba6a36361d8	\N	\N	\N	\N	I guess writing it down in a diary could help, or not pretending that I'm fine	Both of your ideas sound like good options. And I"m here if you want to talk about it more	\N	\N	\N	\N	\N	\N
e0ca54d0-7624-448b-a803-cdd4db59822b	\N	P004	\N	\N	Everytime I close my eyes, I see it agin. I can't sleep	I believe you. That kind of fear doesn't just switch off. It stays in the body	\N	\N	\N	\N	\N	\N
8296e0f1-4fff-4b55-a8ae-b6d1bebfbc81	\N	\N	\N	\N	My heart races, I get sweaty and then I just lie there	That's your system stuck in alamr mode. What if we try calming it - take some slow breaths, some grounding techniques, or even something like a bedroom routine?	\N	\N	\N	\N	\N	\N
0d80a155-dcb2-40ad-95d8-8ba97a4743f5	\N	\N	\N	\N	I don't think anything works	Some children try journaling, by writing out their scary thoughts and then writing a plan for the morning. Do you want to try that tonight?	\N	\N	\N	\N	\N	\N
33ac1cc8-2810-47ca-ae5b-c305ac8bc9d9	\N	\N	\N	\N	OK, I"ll try that	We'll find something that works fo ryou, you're not alone in this	\N	\N	\N	\N	\N	\N
a894f633-e8b8-4a46-b67f-3e7fbfe300f3	\N	P004	\N	\N	I wish I could be like everyone else, people think I'm weird.	You're feeling really left out, right?	\N	\N	\N	\N	\N	\N
dd364860-529e-4767-9a0c-1c4648fd8e11	\N	\N	\N	\N	Yes, I say something and people just stare at me or laugh	That must really hurt. Feeling different is tough, especially when other people don't understand you	\N	\N	\N	\N	\N	\N
25b5c674-329f-43da-8154-d76d6b5aa929	\N	\N	\N	\N	I try to fit in, but it never works	Some of the best people I know didn't feel as if they fit in when they were younger. Do you want to talk about what happened today?	\N	\N	\N	\N	\N	\N
c276a21d-01e2-46ed-bbe3-81c397d8aaf0	\N	\N	\N	\N	I made a joke in class and everyone just stared at me	That sounds rough. What would help you next time? Do you want to practice your jokes on me first?	\N	\N	\N	\N	\N	\N
e50eb75e-25a4-49c0-af1c-61e28afc58b0	\N	\N	\N	\N	Maybe, that might help	Great, let's do it.	\N	\N	\N	\N	\N	\N
8fdebe23-79d8-4d69-a795-ca3cb0e42733	\N	P004	\N	\N	They're all doing it now, vaping behind school I told them that I wasn't going to do it, and they said I was a whimp	You were in a tough situation. Saying no takes real courage	\N	\N	\N	\N	\N	\N
dd0c499f-9af7-48f9-be3d-8ac8ff626207	\N	\N	\N	\N	Yeah, but now they treat me like I'm a baby	That pressure is real. But you stayed true to your values. And that shows strength	\N	\N	\N	\N	\N	\N
78bc3802-c090-476a-9998-9b0c585d443e	\N	\N	\N	\N	I just don't want to loose my friends	What would be most helpful right now? Would it help to talk to one of your friends one on one? Maybe one who seems most understanding? Who would be best to chat to?	\N	\N	\N	\N	\N	\N
7745c55e-0db3-4767-b9a5-69cf13f8aa85	\N	\N	\N	\N	I could try that but I don't want to make a big deal of it	Even one calm conversation can be very helpful and change the outcome. Do you want to think about which friend might be the best option to have a conversation with?	\N	\N	\N	\N	\N	\N
c5f51576-1377-4b1b-9304-2fcd2dba9ebb	\N	\N	\N	\N	Yes, I think I will talk to Mohammed	That sounds like a great plan for now	\N	\N	\N	\N	\N	\N
666c32fd-e0a7-4764-b593-f81f0bd4d268	\N	P004	\N	\N	I get chosen last in every gym class	That must feel very embarrassing	\N	\N	\N	\N	\N	\N
d6ca87d0-af4e-45e9-9855-d400cf476876	\N	\N	\N	\N	Yes, it feels like no one wants me on their team	That would be upsetting to most people. Do you think it's about your speed in group sports, or something else?	\N	\N	\N	\N	\N	\N
9b123032-373d-40be-bf94-61be1e3f8d9a	\N	\N	\N	\N	I'm not fast, so they just skip me	That doesn't define your self worth. What do you want to do about it? Do you want to practice together with me, or ask a friend to practice with you?	\N	\N	\N	\N	\N	\N
2c613764-cbea-41d5-982f-aedad09bdd69	\N	\N	\N	\N	Yes, I'd love to make a time where we can practice together	Great! You're worth more than just how fast you can run	\N	\N	\N	\N	\N	\N
af8f0807-247d-4f19-b009-8e1402aa3275	\N	P004	\N	\N	I did so badly on the science test. My mum is going to kill me!	You sound really stressed. Do you want to talk about what happened?	\N	\N	\N	\N	\N	\N
d9fa72bf-888b-4c9e-acb9-1fed83615666	\N	\N	\N	\N	I thought I had studied, but during the test I blanked out	Stress can really mess with your memory. It doesn't mean you didn't try hard	\N	\N	\N	\N	\N	\N
8ffd1d02-f861-4eac-af58-f26ee9971fa2	\N	\N	\N	\N	So what do I do now?	Do you want to go over the areas you missed out, or do you want me to help you write a message to your teacher to see if you can redo the test? We can do this together	\N	\N	\N	\N	\N	\N
d0b86359-7e99-412b-8088-e1dbabf28382	\N	\N	\N	\N	OK, I just don't want to feel like a failure	You are not a failure, this is part of the learning process	\N	\N	\N	\N	\N	\N
37a87819-dac6-4d55-a8d2-214e91113fb0	\N	P004	\N	\N	Why did you and dad split up? Was it because of me?	No dear, it wasn't your fault	\N	\N	\N	\N	\N	\N
12bc33c6-8052-4fb1-97b2-a0423392b1b3	\N	\N	\N	\N	But everything has changed. I don't know where I belong anymore	I know, it's confusing and painful. You've been caught in the middle and that is very hard	\N	\N	\N	\N	\N	\N
9cbf015f-ae3a-47f3-8699-e585aebf2237	\N	\N	\N	\N	Sometimes I feel like I'm the one being pulled back and forth	You are, and it's not fair. Lets make a plan so you feel a little bit more in control of this difficult situation. Do you want to decide where you'd like to sleep on the weekends, or on the weekdays?	\N	\N	\N	\N	\N	\N
b0c4081d-8aac-407c-b613-a24742654f18	\N	\N	\N	\N	Yes, the weekends are important for me to be near my friends. So I'd like to stay with dad on the weekends	Great, lets make a plan together, as you're an important part of this family and you matter a lot	\N	\N	\N	\N	\N	\N
cf0e60e5-32c8-4336-a097-e95e70cbf930	\N	P004	\N	\N	Everyone else seems ot have a plan, and I"m just stuck	That's a heavy feeling. Do you mean you feel behind?	\N	\N	\N	\N	\N	\N
8b4fcda2-75bf-4f7d-acfd-3398eb8d56e3	\N	\N	\N	\N	Yes, I feel like I"m wasting time	You're not alone. Many people feel like this when they are in their 20's. How do you think you could manage this? Do you want to discuss one thing you feel curious about?	\N	\N	\N	\N	\N	\N
11414e0a-c194-4172-8855-45fe242a73b5	\N	\N	\N	\N	I really enjoyed voluteering at the shelter last year	That's a good place ot start. Let's see what could happen from there...	\N	\N	\N	\N	\N	\N
6e150ae2-fd13-4cff-b514-048595736eb7	\N	P004	\N	\N	I feel like I"m a fraud. I always feel like I"m pretending to know what I am doing, and I don't really know!	It sounds like imposter syndrome has crept in...	\N	\N	\N	\N	\N	\N
783f590b-21ee-4ea8-a399-46366b0b8c11	\N	\N	\N	\N	Yes, I always feel as if I'm one mistake away from being exposed	That's more common than you think, especially when it comes to new jobs. What's one area you feel confident in?	\N	\N	\N	\N	\N	\N
ebfb18db-bd9e-44e3-a751-9cd261e169fc	\N	\N	\N	\N	I love working with clients, but I find I don't know how to manage the admin part	It sounds like your confidence is with your clients. That's great. What can you do to help support yourself with the admin? Some people might choose to outsource it, and others may choose to take a short course. What do you think would work for you?	\N	\N	\N	\N	\N	\N
8379e94f-9e79-49ee-98a4-a6e6edbe6dd2	\N	\N	\N	\N	I think I'll outsource it, that would make life so much easier and I won't need to pretend I know what I'm doing when it comes to the accounts	\N	\N	\N	\N	\N	\N	\N
9e75efb0-34fc-42fd-829a-c495db6e219c	\N	P004	\N	\N	I don't even know if this is normal anymore. We fight all of the time, and I feel completely drained	That sounds exhausting. It sounds like you don't get much peace and quiet anymore	\N	\N	\N	\N	\N	\N
d8a9e8c1-c077-440c-ac60-54cf7a09ec28	\N	\N	\N	\N	Yes, but I don't want to live alone either	That fear is real. But staying in pain also has a cost. Do you want to have a look at how you feel before, during and after your time together?	\N	\N	\N	\N	\N	\N
23045032-56e2-4206-b46b-98c19f011501	\N	\N	\N	\N	I could do that. Maybe it will make things clearer	Yes, we can make a time to disucss this	\N	\N	\N	\N	\N	\N
7234dfa1-8022-479a-a76a-19ef338d4382	\N	P004	\N	\N	I'm so tired, but I feel so guilty taking a rest	It sounds like you are running on fumes	\N	\N	\N	\N	\N	\N
2fbc9024-6bfe-44e4-a091-89ee8f6f00f6	\N	\N	\N	\N	I am, and everyone else seems to be able to manage so much better than me	You don't have to earn a rest by breaking down. You can pause before that point. What would one real pause look like to you?	\N	\N	\N	\N	\N	\N
58d0aab2-6d14-40c3-b041-d85a680c365f	\N	\N	\N	\N	Maybe turning off my phone for a weekend.	That sounds like a great start	\N	\N	\N	\N	\N	\N
5bf4b52e-04c1-4638-a120-febf45886773	\N	POO4	\N	\N	I got a C on that test. I knew I shouldn’t have even tried.	I can tell you’re really upset. Like your effort didn’t match the result.	\N	\N	\N	\N	\N	\N
d967cad2-3e83-4142-9c4d-259ca5e96484	\N	\N	\N	\N	It’s so embarrassing. Everyone else did better.	That’s a heavy feeling—like your grade defines your worth. But it doesn’t.	\N	\N	\N	\N	\N	\N
3067746b-c763-4f82-b1f2-ba300f7ad7da	\N	\N	\N	\N	I just feel like a failure.	You’re not. And this one test doesn’t cancel everything you’ve been working on. Do you want to look at what tripped you up and what might help for next time?	\N	\N	\N	\N	\N	\N
274d2d48-a088-4a68-bad6-9ca13b819535	\N	\N	\N	\N	Yeah… maybe I studied the wrong way.	That’s something we can adjust. Some students learn best by teaching others, or using visuals. Let’s explore what works for you.	\N	\N	\N	\N	\N	\N
7acf20f0-6be7-447b-b374-ba8e375faf37	\N	\N	\N	\N	Okay. That might help.	You’re learning—not failing. Let’s try again with tools that fit your brain.	\N	\N	\N	\N	\N	\N
c751b666-bc55-4881-a87b-54a890029df0	\N	P004	\N	\N	They ditched me again. They said they ‘forgot’—but that’s twice now.	That must sting. Like you’re the extra they can leave out.	\N	\N	\N	\N	\N	\N
4cee1498-c8f9-4af7-8130-c4e8628b0b2a	\N	\N	\N	\N	Yeah. It’s like I’m not important unless they need something.	You deserve more than that. Want to talk about whether this is something to bring up—or something to step back from?	\N	\N	\N	\N	\N	\N
58f972a7-1a5b-474b-a1c0-0c18ca88a805	\N	\N	\N	\N	I don’t even know. I just feel stupid for caring.	Caring isn’t stupid—it means you value connection. But that connection should go both ways.	\N	\N	\N	\N	\N	\N
1f07ad6c-e9e3-4034-b403-220bfe6ab442	\N	\N	\N	\N	What if I confront them and they just laugh it off?	Then at least you’ll know you were honest. Do you want help planning how to say it in a way that protects your peace?	\N	\N	\N	\N	\N	\N
3324de50-dcc4-414b-a80d-e0aff6f2843e	\N	\N	\N	\N	Yeah. That would help.	We’ll figure it out together. You’re allowed to expect respect.	\N	\N	\N	\N	\N	\N
d0454011-4d1e-4f73-b8de-c1970b5f1df2	\N	P004	\N	\N	Every time I get an interview, I freeze. I look fine, but inside I’m panicking.	Sounds like your body is going into stress mode, even before the questions start.	\N	\N	\N	\N	\N	\N
2c71f156-7f5b-4b31-aaf3-31ef7a4dcb52	\N	\N	\N	\N	Yeah. I can’t think straight. Then I hate myself after.	That’s a rough loop. What helps some people is rehearsing the pressure moments—like mini exposure therapy. Do you want to try?	\N	\N	\N	\N	\N	\N
2d809b0a-c833-4a1d-8548-aa3057e24878	\N	\N	\N	\N	Maybe. But I feel so fake doing that.	You’re not being fake. You’re training your brain to recognize that you’re safe. Kind of like rewiring an alarm system.	\N	\N	\N	\N	\N	\N
07330e05-031b-473a-9dfc-d581335f9274	\N	\N	\N	\N	Okay… maybe we can try one question now?	Great. Let’s start with one—and breathe through it together.	\N	\N	\N	\N	\N	\N
5ecf8b90-145a-4aec-99a1-c24b838686ea	\N	P004	\N	\N	I said yes to everything, and now I want to scream. I can’t keep up.	Sounds like you’re stretched thin and running on empty.	\N	\N	\N	\N	\N	\N
d2629bb8-c133-4ec9-8569-5234b2952a7e	\N	\N	\N	\N	It’s my fault. I should be able to handle this.	That voice in your head is being really unforgiving. Can I offer a reframe?	\N	\N	\N	\N	\N	\N
a6129852-a0b9-488f-a357-17e1956605ad	\N	\N	\N	\N	Sure.	What if saying no isn’t a failure—but a sign of strength and self-awareness?	\N	\N	\N	\N	\N	\N
543ea6a0-8dc9-47cc-a221-52f8b69a7a07	\N	\N	\N	\N	I’ve never thought of it like that.	Many students learn the hard way that boundaries build resilience. Do you want to make a list of what could be paused this week?	\N	\N	\N	\N	\N	\N
ad4e5fa4-64be-47cf-b3e4-e65b96b41984	\N	\N	\N	\N	Yes. Please.	Let’s protect your energy—on purpose.	\N	\N	\N	\N	\N	\N
aa335d81-a3ff-481f-a9f0-33dc6fa5ba33	\N	P004	\N	\N	Everyone else finished the assignment already. I haven’t even started.	You’re feeling behind—and maybe a little stuck?	\N	\N	\N	\N	\N	\N
dd7bc201-db5a-4378-9be7-d19ce34bdd23	\N	\N	\N	\N	Yeah. And the more I think about it, the worse it gets.	I get it. When stress builds, our brains often shut down instead of speed up.	\N	\N	\N	\N	\N	\N
d1bad7a9-01df-4634-9bfd-905cbc76fee4	\N	\N	\N	\N	I’m just not as smart as they are.	It’s not about smart—it’s about overwhelmed. Want to break it down together into one small next step?	\N	\N	\N	\N	\N	\N
ac5b9c03-501c-4f79-8d41-2ab1e3c1a770	\N	\N	\N	\N	I guess I could just open the doc and write the title.	That’s a great first step. One small move beats a perfect plan you can’t start.	\N	\N	\N	\N	\N	\N
c1688a1c-b6ec-45e1-9389-cbfb5180967f	\N	\N	\N	\N	Okay. One step. I can try that.	And I’ll be here if you get stuck. You don’t have to do it alone.	\N	\N	\N	\N	\N	\N
5a91667c-48da-46b6-8314-6d687c7aa466	\N	P004	\N	\N	Everyone’s posting like they’re perfect. I feel like a loser in comparison.	Social media has a way of showing everyone’s highlights, not their real life.	\N	\N	\N	\N	\N	\N
25859ad6-d9c8-45e6-918e-8cbf31139a73	\N	\N	\N	\N	But even their bad days look better than mine.	It’s easy to forget how filtered things are. Would you want to take a short break from it together?	\N	\N	\N	\N	\N	\N
7656ef3f-3784-497a-bd90-d995f7f80117	\N	\N	\N	\N	I don’t know. I feel like I’d miss out.	FOMO is real. But sometimes JOMO—the joy of missing out—can give your brain a break. Want to try one hour and check in?	\N	\N	\N	\N	\N	\N
5f502ff5-981c-46eb-829a-0c906b31e756	\N	\N	\N	\N	Yeah... maybe.	I’ll be your check-in buddy. One hour off isn’t forever—but it could help.	\N	\N	\N	\N	\N	\N
5ac9ea70-da27-4c59-b227-511f51f399bd	\N	P004	\N	\N	No one even notices when I’m home. I could disappear and it wouldn’t matter.	That sounds incredibly lonely. Like you're shouting inside and no one hears.	\N	\N	\N	\N	\N	\N
8368085f-cea3-45f5-b9d2-b6158ec8f4e9	\N	\N	\N	\N	Exactly. I just stay in my room because what’s the point?	That space might feel safe—but it also sounds like you’re craving connection. Want to talk about one way to feel seen?	\N	\N	\N	\N	\N	\N
3a7b4c89-14bd-4598-abc7-89de8a0b615e	\N	\N	\N	\N	Like what?	Maybe something small, like choosing the dinner or suggesting a movie? You matter, even if they don’t always show it well.	\N	\N	\N	\N	\N	\N
9cdf93f3-842a-4732-b435-814ae9d40646	\N	\N	\N	\N	Okay. I might try that.	And I’ll be here to help if it feels too hard. You’re not invisible to me.	\N	\N	\N	\N	\N	\N
6e5bc53a-a238-46b8-afc9-2d49deae7aac	\N	P004	\N	\N	What if I pick the wrong major and ruin everything?	That’s a big fear—like one choice will decide your whole life?	\N	\N	\N	\N	\N	\N
d5d05b51-2b9f-44f9-b6e4-4b643de927ba	\N	\N	\N	\N	Yes! And I don’t even know what I’m good at.	It’s totally okay to not have it all figured out. Want to explore what lights you up instead of what locks you in?	\N	\N	\N	\N	\N	\N
9de3428b-7e4b-46fd-98eb-ce39ff7729fa	\N	\N	\N	\N	Maybe. But I still feel lost.	Lots of people feel that way. Think of this as version 1.0—you can update as you learn.	\N	\N	\N	\N	\N	\N
aba27e1a-6ec6-4d5e-801f-0b2c2092c78e	\N	\N	\N	\N	Okay. That feels a little better.	One step at a time. Your path can bend—and still move forward.	\N	\N	\N	\N	\N	\N
463c7696-d9df-4490-99dd-2bf691dad117	\N	P004	\N	\N	If I mess up at the game tomorrow, the coach will bench me.	I can feel how heavy that pressure is. Let’s take a breath and slow down for a sec.	\N	\N	\N	\N	\N	\N
3909ec73-1059-4147-a9ae-202755779d5e	\N	P004	\N	\N	I’m freaking out. The math test is tomorrow and I just know I’m going to fail.	Sounds like your mind is really full right now. Do you want to take a breath with me first?	\N	\N	\N	\N	\N	\N
924d0611-c504-4cb8-a556-7cb2900e6611	\N	\N	\N	\N	Okay…	You’re not alone. A lot of people feel pressure before big tests. What part feels the scariest?	\N	\N	\N	\N	\N	\N
6cc6d80d-1342-4f79-8582-7a4017738845	\N	\N	\N	\N	That I’ll blank out and not remember anything.	That makes sense—our brains sometimes freeze under pressure. Can we practice a calming technique that helps bring you back when that happens?	\N	\N	\N	\N	\N	\N
a8ba54d2-39b1-4e56-9dd6-cb069da9f938	\N	\N	\N	\N	Like what?	One way is to pause and name 3 things you can see, 2 things you can touch, and 1 thing you can hear. It brings you into the present. Do you want to try it now?	\N	\N	\N	\N	\N	\N
f40c5375-b408-4705-8218-e43eb4f96077	\N	\N	\N	\N	Okay… I see your desk, the board, and the window… I feel the chair and my pencil…	Perfect. That’s how we tell the brain we’re safe. Your knowledge is still there—it just needs a calmer space to show up.	\N	\N	\N	\N	\N	\N
5c25bb5d-c097-403a-9e9c-360a743cdeb0	\N	P004	\N	\N	I sit alone at lunch almost every day. No one even looks at me.	That sounds really lonely. I’m glad you told me—it takes courage.	\N	\N	\N	\N	\N	\N
5a597482-b1f2-463c-8dff-47e944323331	\N	\N	\N	\N	It just feels like I don’t matter.	I hear you. That feeling can be really heavy. Can we take a minute together to just breathe and be in this moment?	\N	\N	\N	\N	\N	\N
1d979275-441e-4bc7-847e-72d3d01a30e5	\N	\N	\N	\N	Yeah… okay.	Thank you. Let’s look at something together—sometimes when people seem distant, they’re caught up in their own worries. Do you want to talk about someone you wish would notice you more?	\N	\N	\N	\N	\N	\N
6930fb3e-07b6-45ee-b9de-132e23f75bea	\N	\N	\N	\N	There’s a kid in my science class I think is kind. But I never know what to say.	That’s a great start. We can practice together. You matter. And we can build ways to help others see that too.	\N	\N	\N	\N	\N	\N
50b9f381-4f60-4d33-b2a2-1502fbcfc0a3	\N	P004	\N	\N	I can’t stop thinking about how awkward I sounded at that party. I keep replaying it.	That sounds exhausting—like your brain won’t give you a break.	\N	\N	\N	\N	\N	\N
4b0c76a2-a7d9-4c1a-b518-82d3aa513a15	\N	\N	\N	\N	Yeah. I wish I could just forget it.	I get that. Do you want to pause and breathe for a sec, just to give your body a reset?	\N	\N	\N	\N	\N	\N
4d434ae0-ab8f-4e11-a862-c6014d33439e	\N	\N	\N	\N	Okay…	What if we looked at it a little differently? You’re focusing on one moment—but what else happened that night?	\N	\N	\N	\N	\N	\N
b3a4a68e-1a0b-43ef-aab1-19fee7080cb1	\N	\N	\N	\N	I did make a few people laugh later on…	Exactly. Our minds latch onto what felt wrong, but that’s only part of the story. You’re more than one awkward sentence.	\N	\N	\N	\N	\N	\N
fe7ff911-0711-44c4-aa6d-595e9610bd0e	\N	P004	\N	\N	I’m never going to be as good as everyone else. I don’t even know why I try.	That’s a hard thought to carry. Can we just sit with it together for a second?	\N	\N	\N	\N	\N	\N
33ac29a8-9753-4fe9-b9e8-247b6b6eebcd	\N	\N	\N	\N	Sure.	Thanks. That voice in your head is trying to protect you from disappointment—but it’s not telling the full truth.	\N	\N	\N	\N	\N	\N
82d2389e-6d5a-472b-b16b-66adabc10af2	\N	\N	\N	\N	What do you mean?	Trying is an act of courage. It means you’re choosing to grow. Do you want to talk about one area where you’ve improved—even just a little, or do you want to talk about something else?	\N	\N	\N	\N	\N	\N
1aeffa24-7e52-49da-9493-7c00380baceb	\N	\N	\N	\N	Let's talk about where I've made progress. I guess I’ve gotten better at talking in class…	That matters. Growth often hides in small steps. You’re not falling behind—you’re building forward.	\N	\N	\N	\N	\N	\N
c38e9796-12ef-4bdf-90ed-d7114ff08036	\N	P004	\N	\N	I looked in the mirror this morning and I felt disgusting. I didn’t even want to come to school.	That’s such a painful experience. I’m so sorry you felt that way.	\N	\N	\N	\N	\N	\N
23998e32-1c16-4f8e-af98-d38fca45edc3	\N	\N	\N	\N	It just doesn’t stop. I hate how I look.	Let’s breathe together for a moment. These feelings can overwhelm us fast.	\N	\N	\N	\N	\N	\N
bf48bb8d-4286-43ae-a9ba-faac23ec92c4	\N	\N	\N	\N	*(breathes)*	Thank you. That moment of self-hate is your mind reacting to pressure and comparison. It doesn’t define your worth.	\N	\N	\N	\N	\N	\N
275ab736-2131-4820-ad01-2e23c079a1b2	\N	\N	\N	\N	But I still feel like everyone sees what’s wrong with me.	Our brains are wired to look for danger—and sometimes, that danger is imagined. Do you want to talk about what your body does for you, instead of how it looks?	\N	\N	\N	\N	\N	\N
f59075cd-f709-441b-a849-f6bd62c5ca3b	\N	\N	\N	\N	I guess it lets me run. And I like dancing sometimes.	That’s beautiful. Let’s make space for gratitude alongside the hard thoughts. You are more than your reflection.	\N	\N	\N	\N	\N	\N
62d9de26-a00a-4afa-966c-f042af27b964	\N	P004	\N	\N	I’m freaking out. The math test is tomorrow and I just know I’m going to fail.	Sounds like your mind is really full right now. Want to take a breath with me first?	\N	\N	\N	\N	\N	\N
86c7c3d0-b9d2-4026-8889-5bdf15af33a8	\N	\N	\N	\N	That I’ll blank out and not remember anything.	That makes sense—our brains sometimes freeze under pressure. Do you want to practice a calming technique that helps bring you back when that happens?	\N	\N	\N	\N	\N	\N
e6f999f5-3004-4c8b-987f-7fdf598b06ef	\N	\N	\N	\N	Like what?	One way is to pause and name 3 things you can see, 2 things you can touch, and 1 thing you can hear. It brings you into the present. Want to try it now?	\N	\N	\N	\N	\N	\N
1f0f5b4d-3469-4f01-a0b5-8a068c6bdc72	\N	P004	\N	\N	I sit alone at lunch almost every day. No one even looks at me.	That sounds really lonely. I’m glad you told me—it takes courage.	\N	\N	\N	\N	\N	\N
bd999381-8459-4804-9be4-7694c6a6a024	\N	P004	\N	\N	I can’t stop thinking about how awkward I sounded at that party. I keep replaying it.	That sounds exhausting—like your brain won’t give you a break.	\N	\N	\N	\N	\N	\N
d2a5bf7c-3763-4165-bf2b-334f19df682d	\N	\N	\N	\N	Yeah. I wish I could just forget it.	I get that. do you want to pause and breathe for a sec, just to give your body a reset? Or do you want to continue talking about this?	\N	\N	\N	\N	\N	\N
dffaeee1-8902-42a3-a4e9-740547642731	\N	\N	\N	\N	Okay…let's pause for a minute	What if we looked at it a little differently? You’re focusing on one moment—but what else happened that night?	\N	\N	\N	\N	\N	\N
c3118d1d-5e82-4aac-b3d2-1760964309a2	\N	P004	\N	\N	I can’t sleep. Every time I close my eyes, I think about the news.	It sounds like your brain is staying on high alert. That’s a normal reaction to scary things.	\N	\N	\N	\N	\N	\N
ac032a8d-b2e9-4d9c-ad94-2002d16830d3	\N	\N	\N	\N	I keep hearing the sirens in my head.	It’s like your nervous system doesn’t know the threat is over. Do you to try something to help calm your body?	\N	\N	\N	\N	\N	\N
660650fe-2751-4034-ae77-fd8d2fa071e2	\N	\N	\N	\N	Like what?	Let’s try pushing your feet into the ground and noticing the support. You’re safe right now. Want to try?	\N	\N	\N	\N	\N	\N
01fb1d79-f6a1-4ac8-a6ba-23ec26fddc9d	\N	\N	\N	\N	Okay.	You’re doing great. We can also make a routine for bedtime—something that signals safety, like a warm drink or soft music.	\N	\N	\N	\N	\N	\N
698f84c8-ad73-4c41-a1e6-674698786fd2	\N	P004	\N	\N	My mom’s always yelling at me. I try to stay calm but it never works.	That sounds incredibly frustrating. Like no matter what you do, it blows up?	\N	\N	\N	\N	\N	\N
b16a8bfb-c81e-4bf9-bda2-ae081ddbe821	\N	\N	\N	\N	Exactly.	I hear how much you’re trying. Want to map out some things you can control in those moments?	\N	\N	\N	\N	\N	\N
07e6cecd-80c4-457f-9002-a15df056ed3b	\N	\N	\N	\N	Like walking away?	Yes. That’s a powerful strategy. Also, learning to name how you feel without it escalating. Do you want to practice that together?	\N	\N	\N	\N	\N	\N
f5887274-6930-4c1b-af44-20f942b2181e	\N	\N	\N	\N	I guess.	I’ve got you. Let’s start with, “I’m not feeling heard right now.” Small shifts can open big doors.	\N	\N	\N	\N	\N	\N
53e1c1dd-52f5-4efd-9fa5-e58423402f6a	\N	\N	\N	\N	Okay.	Thanks. Performance pressure is real—but it doesn’t have to own you. Do you want to explore what part you can control?	\N	\N	\N	\N	\N	\N
8c814677-0fbd-43b9-b4a6-0f2373d5607b	\N	\N	\N	\N	Like my effort?	Exactly. You can’t control outcome or coach’s mood—but you can show up, breathe, and focus on your game.	\N	\N	\N	\N	\N	\N
b3ab5740-c4b6-4b11-bba0-b424e47692aa	\N	\N	\N	\N	That helps.	You’ve trained for this. Let the moment be about *presence*, not perfection.	\N	\N	\N	\N	\N	\N
a4c4c27d-8389-4ffb-b5d9-9d838a60da4b	\N	P004	\N	\N	Someone’s been posting stuff about me online. It’s getting worse.	I’m so sorry that’s happening. You don’t deserve that.	\N	\N	\N	\N	\N	\N
91105abd-f544-4d1b-971d-25901be23ceb	\N	\N	\N	\N	It makes me not want to go to school.	I can see how that would make you want to shut down. Can we look at options together?	\N	\N	\N	\N	\N	\N
0bbbb2ac-fcfb-4482-b9bf-431700e5b023	\N	\N	\N	\N	Like reporting it?	Yes. And also building your team—trusted adults, peers, and safe spaces. You don’t have to handle this alone.	\N	\N	\N	\N	\N	\N
13c94d03-4912-454d-9282-27e6dc3fb692	\N	\N	\N	\N	Okay. Will you help me?	Absolutely. We’ll face this together. And we’ll remind your brain: this is not your fault.	\N	\N	\N	\N	\N	\N
31a16100-d012-4399-a4d3-d0d01a9238c5	\N	P004	\N	\N	They had a whole group hangout and didn’t even invite me.	That hurts. You were hoping to be included, and it stings to be left out.	\N	\N	\N	\N	\N	\N
8fe4312b-c84a-41c6-aee7-156c19f4727e	\N	\N	\N	\N	I don’t even want to talk to them now.	That’s valid. It’s okay to feel hurt. Do you want to explore what that feeling is trying to tell you?	\N	\N	\N	\N	\N	\N
6a0acdf2-4099-4e31-8a82-161d7d91fe3e	\N	\N	\N	\N	Like what?	Maybe that you care about belonging. We can work on ways to express that *without* shutting down or lashing out.	\N	\N	\N	\N	\N	\N
cee20742-6234-46e5-af8a-8c3b58a066f7	\N	\N	\N	\N	Yeah… maybe.	You matter, even when others don’t show it. Let’s figure out a step that helps you feel grounded again.	\N	\N	\N	\N	\N	\N
ac9510cb-5816-4a5a-a171-9724bba71c6f	\N	P004	\N	\N	I don’t know who I am anymore. I feel lost.	That’s a powerful feeling—and a common one at your age. Do you want to sit with it for a moment together?	\N	\N	\N	\N	\N	\N
66ef3b5f-6db2-4e2c-8a82-f60ba814b296	\N	\N	\N	\N	It’s scary.	I hear that. Let’s ground ourselves in this moment first. Can you name one thing you know you care about? Or do you want to spend more time doing grounding exercises?	\N	\N	\N	\N	\N	\N
5c886e82-cdc1-4727-8f9a-863ea0696469	\N	\N	\N	\N	let's talk about it. I care about art.	That’s something real. Your identity isn’t a fixed label—it’s something you’re shaping over time.	\N	\N	\N	\N	\N	\N
f1f4c874-c4f1-4136-9fc5-5e968da50e63	\N	\N	\N	\N	But what if I never figure it out?	It’s okay not to have all the answers. Let’s make space for exploration, not judgment.	\N	\N	\N	\N	\N	\N
d19b616d-8513-49d5-a39f-4e4a03e709cf	\N	P004	\N	\N	I saw someone get hurt near the store. I can’t stop thinking about it.	That must’ve been shocking and scary. I’m really glad you’re talking about it.	\N	\N	\N	\N	\N	\N
f286fc4c-abe8-4206-a194-3ff8f0aa2103	\N	\N	\N	\N	I keep replaying it in my head.	That’s a trauma response. Your brain is trying to make sense of something big. Do you want to try grounding yourself in the here-and-now?	\N	\N	\N	\N	\N	\N
cba3dc94-5b27-49d8-af5a-8617fd7054f0	\N	\N	\N	\N	How?	Can you press your hands into your thighs and name what’s around you right now?	\N	\N	\N	\N	\N	\N
aaab9664-25e1-412d-90cf-bb60c0761b2f	\N	\N	\N	\N	Okay… I see your pen, the window, the floor.	That’s it. You’re here. Safe. The memory is real, but it’s not happening now.	\N	\N	\N	\N	\N	\N
2a56f1b3-0a8d-4f68-8624-3a8e834fd84f	\N	P004	\N	\N	What if I don’t get into college? What if I never figure out my life?	Those are really overwhelming thoughts. Do you want to pause for a breath before we dive in?	\N	\N	\N	\N	\N	\N
9311df77-6898-4c7a-9625-b201e414b700	\N	\N	\N	\N	Okay, that sounds good	Thanks. Let’s separate what you know from what your anxiety is guessing. What’s one step you’ve taken toward your goals?	\N	\N	\N	\N	\N	\N
714db67d-b27b-4823-972c-a7aeba301fea	\N	\N	\N	\N	I applied to three schools already.	That’s a big step. Uncertainty is hard, but it doesn’t mean failure—it means you’re moving forward.	\N	\N	\N	\N	\N	\N
4b46ffd1-d34a-478a-8040-ddb1fecd5f37	\N	P004	\N	\N	I can’t stop crying since my dog died. It’s like my chest hurts.	Losing a pet is real grief. I’m so sorry you’re going through this.	\N	\N	\N	\N	\N	\N
044c2203-4914-4959-b830-9aedae3bae4e	\N	\N	\N	\N	I keep expecting to hear his paws at the door.	Those moments of expectation—those are part of how we hold on. It means he mattered deeply.	\N	\N	\N	\N	\N	\N
9b44a703-8003-4fc2-a27a-82cceea095c3	\N	\N	\N	\N	It feels silly to be this sad.	It’s not silly at all. Grief honors love. Do you want to share a memory of him with me?	\N	\N	\N	\N	\N	\N
4dd86b7f-3848-4fc5-9fb9-d09be40ba497	\N	\N	\N	\N	He used to curl up next to me when I was sick.	That’s such a beautiful connection. Your pain is the shape of that love.	\N	\N	\N	\N	\N	\N
9f9ad2a9-9b3b-4768-97c4-4bec5bcf51d1	\N	P004	\N	\N	I’m just done. I don’t care about classes anymore. I’m too tired.	That sounds like burnout—not laziness. You’ve been pushing hard, haven’t you?	\N	\N	\N	\N	\N	\N
f2dd6cb1-9440-4e65-9a34-357f9b0239bd	\N	\N	\N	\N	Yeah. I haven’t had a real break in months.	Your brain and body are telling you something important: it’s time to slow down. Do you want to talk through what rest could look like?	\N	\N	\N	\N	\N	\N
5ed02208-ab81-4a43-ad14-66dd13b1786e	\N	\N	\N	\N	Like skipping assignments?	Maybe pausing non-urgent tasks, or asking for extensions. Rest isn’t quitting—it’s refueling.	\N	\N	\N	\N	\N	\N
61f909b8-b317-4f8e-8cde-e9577e31e6f1	\N	\N	\N	\N	That helps. I feel less guilty now.	You deserve space to breathe. Burnout is a signal—not a personal failure.	\N	\N	\N	\N	\N	\N
e73a665f-e26a-4625-aed3-68c7cfbca256	\N	P004	\N	\N	My best friend and I haven’t talked in a week. I think she’s mad at me.	That silence must feel heavy. Want to talk through what happened?	\N	\N	\N	\N	\N	\N
470f664e-48c8-44a4-8d00-9bffdb4c2eb8	\N	\N	\N	\N	I don’t even know. One day we were fine, then nothing.	Uncertainty can be so painful. Let’s slow down and explore what you’re feeling underneath.	\N	\N	\N	\N	\N	\N
a157ac19-e60c-4af3-89f9-1a16f507fc8f	\N	\N	\N	\N	Mostly hurt. And kind of ashamed.	Those feelings make sense. Do you want to write her a message together—one that shares honestly but gently? Or do you prefer to talk to her face to face?	\N	\N	\N	\N	\N	\N
f5aad14a-9c34-4ea2-86fd-581936871af5	\N	\N	\N	\N	Yeah… I think it might help to write her a message	Let’s try it. You’re not alone in this.	\N	\N	\N	\N	\N	\N
a9582431-8a04-407c-aa72-8591d0e02b18	\N	P004	\N	\N	I got triggered during class and couldn’t focus. It felt like I was floating.	That sounds like dissociation—like your body was present but your mind was protecting you.	\N	\N	\N	\N	\N	\N
58b96ef8-6860-47d8-a67c-de95369688ef	\N	\N	\N	\N	Yeah, exactly.	It’s more common than you think. Do you want to try a few grounding tricks together?	\N	\N	\N	\N	\N	\N
e150e566-4c46-4ff7-8881-5e6c83482179	\N	\N	\N	\N	Okay.	Let’s push your feet into the floor. What do you feel?	\N	\N	\N	\N	\N	\N
d53f8911-f2f5-497d-9a6e-bc8eeafcc650	\N	\N	\N	\N	The carpet. My socks.	My voice is here with you. This moment is safe. We can talk through what happened when you’re ready.	\N	\N	\N	\N	\N	\N
46f08610-64e4-496b-b505-3348b2e65a3d	\N	P004	\N	\N	I hate how I freeze when someone yells. Even if they’re not yelling at me.	That’s a trauma response—your body is remembering something old and reacting to it now.	\N	\N	\N	\N	\N	\N
4bc8626c-4cc9-4efe-bac7-c29d3c3c5520	\N	\N	\N	\N	It’s embarrassing.	There’s nothing wrong with you. This is your nervous system trying to protect you. Do you want to learn ways to feel more in control when that happens, or do you prefer to continue talking about it?	\N	\N	\N	\N	\N	\N
c28f042d-dd0b-47c2-aa7b-d1d480fc1081	\N	\N	\N	\N	Let's learn some techniques	I’ve got a few tricks—like squeezing something in your hand or tapping your fingers. We can practice this together.	\N	\N	\N	\N	\N	\N
4c7a15e8-60fb-4407-9d04-7c67ba05631e	\N	P004	\N	\N	I feel like I don’t fit anywhere—not at school, not even at home.	That sounds like you’re holding a lot of loneliness. I’m really glad you said something.	\N	\N	\N	\N	\N	\N
ce732de8-8baa-4b59-8bc4-108ec8f97e24	\N	\N	\N	\N	I just pretend to be someone else so I don’t get judged.	That kind of masking is exhausting. Let’s take a breath and just let you be fully yourself for a second.	\N	\N	\N	\N	\N	\N
da140f4a-1693-496b-87b8-c122405edacf	\N	\N	\N	\N	Okay.	Thank you. You matter just as you are. Do you want to think together about where your people might be?	\N	\N	\N	\N	\N	\N
514c96c6-45ee-4fcb-b8ba-321dd1057cff	\N	\N	\N	\N	Yeah.	I’m with you in this. We’ll find places you belong.	\N	\N	\N	\N	\N	\N
d90a2987-2216-4a40-bd1b-7052696fca60	\N	P004	\N	\N	Every time someone raises their voice, I flinch. I hate that I do that.	Your body is remembering past danger. That flinch is a survival response—not weakness.	\N	\N	\N	\N	\N	\N
7acbd89e-f62d-4a27-b60e-61c7034fd8d9	\N	\N	\N	\N	I feel broken.	You’re not broken. You adapted to protect yourself. And now we can build new safety signals.	\N	\N	\N	\N	\N	\N
c19ab71c-1ed3-4636-9492-da93c5a51d9f	\N	\N	\N	\N	How?	One way is to practice naming that the present moment is different. Do you want to try together?	\N	\N	\N	\N	\N	\N
12382d97-3131-47f9-acdc-f30d834c322a	\N	\N	\N	\N	Yeah.	Okay—“Right now I’m safe. Right now I’m okay.” Say it with me.	\N	\N	\N	\N	\N	\N
025f58fc-ffb8-43e4-9182-2162710686d3	\N	P004	\N	\N	I get so anxious I feel like I’m going to throw up before I speak in class.	That kind of anxiety shows up in the body—it’s real. Let’s take one breath together to calm your system.	\N	\N	\N	\N	\N	\N
b5306395-7710-4b23-9917-8e0479e7a19b	\N	\N	\N	\N	Okay…	Good. That was a strong first step. Your body’s reacting like you’re in danger—but we know you’re safe right now.	\N	\N	\N	\N	\N	\N
d4792dcd-7ac8-43e6-9ec5-b625d3225e67	\N	\N	\N	\N	It doesn’t feel like it. Everyone’s staring and I freeze.	Freezing is your brain’s way of trying to protect you. Can we plan together how you might ease into speaking?	\N	\N	\N	\N	\N	\N
f886ca1e-88a8-44d1-9dea-d4d3197868fa	\N	\N	\N	\N	I guess. Maybe I could write notes or ask to go later in class.	Those are great control options. You’re not avoiding—you’re preparing.	\N	\N	\N	\N	\N	\N
7c5f0757-f07a-40cb-a7ee-6b6936c36f24	\N	\N	\N	\N	It would help if I had a backup plan, just in case.	Absolutely. Let’s create a script or grounding tool you can keep in your pocket. Confidence comes from practicing safety.	\N	\N	\N	\N	\N	\N
433903eb-dcd8-4489-898c-7428991b24d7	\N	P004	\N	\N	I haven’t told anyone, but I think I might be depressed. I’m just… empty.	Thank you for saying that. I hear the weight you’re carrying.	\N	\N	\N	\N	\N	\N
5e22cfd5-4ca7-4869-b9c3-7f9b9c3cce29	\N	\N	\N	\N	It’s like nothing matters. And I’m tired all the time.	Those are serious signs—and you’re not alone. Depression can feel like a fog that blocks your view of what’s good.	\N	\N	\N	\N	\N	\N
d7dddc97-0ede-416b-a632-0a1ebe065db6	\N	\N	\N	\N	What if people think I’m weak?	It actually takes strength to speak up. You’ve already done something strong. Do you want to talk about next steps, gently?	\N	\N	\N	\N	\N	\N
369702e9-f8b4-4511-b888-d4393d8f9b48	\N	\N	\N	\N	Like what?	We could start by talking to a counselor. Or even journaling your thoughts each night. Small actions can reconnect you to hope. What would you prefer?	\N	\N	\N	\N	\N	\N
63b3e894-13ad-4b35-92a3-7eedb3ce80bb	\N	\N	\N	\N	I’d try journaling. I’m not sure I’m ready to talk.	That’s totally okay. This isn’t a race. Let’s choose what feels safe—and keep checking in.	\N	\N	\N	\N	\N	\N
4a48aba4-ef1c-4a77-a96f-b01b34da5179	\N	P004	\N	\N	My older sibling is always making fun of me. I laugh it off, but it hurts.	Mocking from someone close really stings. I’m glad you shared it.	\N	\N	\N	\N	\N	\N
1e2b9049-6476-4184-a43c-866623dfc02a	\N	\N	\N	\N	It makes me feel small. But when I say something, they say I’m “too sensitive.”	That’s gaslighting—and it erodes your confidence. Let’s build a sentence you can use to hold your space.	\N	\N	\N	\N	\N	\N
7cb73006-8390-42d6-a855-b1ab39dc5ad6	\N	\N	\N	\N	Like what?	How about, “I’m not okay with being talked to that way—it crosses a line for me.” Firm but calm.	\N	\N	\N	\N	\N	\N
15169911-d954-41e2-b75e-c88c45b6f512	\N	\N	\N	\N	What if they ignore me or laugh more?	Then you follow up with action: walking away, setting distance, or telling an adult. You can’t control them—but you can protect your peace. Which options sound good to you?	\N	\N	\N	\N	\N	\N
2d70a791-4f99-4325-8850-4ace6106e56f	\N	\N	\N	\N	I like the sentence. I want to try it.	Let’s practice it together now, so it feels stronger when you need it.	\N	\N	\N	\N	\N	\N
545e5da0-2fd5-4256-b118-093cc294cf03	\N	P004	\N	\N	I can’t focus on anything anymore. My brain feels foggy all the time.	It sounds like your mind is overloaded—not broken.	\N	\N	\N	\N	\N	\N
9f71585a-f3f1-481b-a13c-0b082d08b466	\N	\N	\N	\N	I just keep forgetting stuff. Even simple things.	Stress can shrink focus. Want to map out what’s taking up most of your mental energy?	\N	\N	\N	\N	\N	\N
15bc3f01-5201-4172-9708-c90482cce487	\N	\N	\N	\N	School, my parents arguing, and not sleeping.	That’s a lot for one person. We can’t fix everything at once—but we can add a few things that bring clarity back.	\N	\N	\N	\N	\N	\N
792e63d7-beda-443c-a1b1-d072bc07fded	\N	\N	\N	\N	Like what?	Tiny wins: a daily walk, a phone-free hour, a planner, breathing breaks. Which one feels doable?	\N	\N	\N	\N	\N	\N
12ce2f0c-607f-45c5-ab6a-a946b029786b	\N	\N	\N	\N	Maybe the walk. I miss fresh air.	Perfect. Let’s build from there. Clarity starts with care.	\N	\N	\N	\N	\N	\N
29147779-5d53-4bc2-bcd9-8e0039799287	\N	P004	\N	\N	I keep having nightmares. I wake up sweating and scared.	It sounds like your brain’s trying to process something—even while you sleep.	\N	\N	\N	\N	\N	\N
2e23685e-7a13-4431-87f0-767cd09ffc34	\N	\N	\N	\N	Yeah. I don’t even want to go to bed anymore.	That’s real. Avoiding sleep is your way of trying to stay safe. What helps calm you down after a nightmare?	\N	\N	\N	\N	\N	\N
68356c4a-6826-4e93-b849-df98e7f4a12e	\N	\N	\N	\N	Turning on a light. And holding my blanket tight.	That’s great. Your body is already doing self-soothing. Do you want to build a bedtime ritual around safety?	\N	\N	\N	\N	\N	\N
2c552009-a75a-4b96-8b27-9718b4475056	\N	\N	\N	\N	Like what?	Maybe calming music, a sleep story, drawing a symbol of safety near your bed. We can make it yours. You can choose	\N	\N	\N	\N	\N	\N
16338c88-28d4-420e-a386-ddd6c5531557	\N	\N	\N	\N	Okay. That actually makes me feel a little better.	That’s the goal—more safety, less fear. You deserve restful nights.	\N	\N	\N	\N	\N	\N
b787e17b-4fa6-42d2-8dfb-e2340900b656	\N	P004	\N	\N	Everyone’s talking about university, and I still have no clue what I want to do.	It’s totally okay not to know right now. That uncertainty doesn’t mean failure.	\N	\N	\N	\N	\N	\N
8e6b0c4a-258b-4080-9b6a-8139c237d981	\N	\N	\N	\N	But it feels like I’m falling behind.	You’re on your own path. Can we explore what you’re curious about instead of what box you’re “supposed” to fit into?	\N	\N	\N	\N	\N	\N
2175d896-6d5b-4878-8a4d-77de5bd5f8f4	\N	\N	\N	\N	I like animals. And I’m good at helping people.	That’s a great start. You don’t need a final answer—just a direction to move toward.	\N	\N	\N	\N	\N	\N
e65ffb20-49bb-4825-8a45-85b6c2ec1b33	\N	\N	\N	\N	What if I make the wrong choice?	Most people change careers several times. Let’s look at options you can try or explore without committing forever.	\N	\N	\N	\N	\N	\N
13b0ea6f-38fd-46ad-8a6c-e3a83b573be8	\N	\N	\N	\N	Okay. Maybe I could volunteer or shadow someone.	Exactly. You’re not stuck—you’re experimenting. That’s how real decisions grow.	\N	\N	\N	\N	\N	\N
43aa147f-b3d4-4136-961c-f7ea3099bbb6	\N	P004	\N	\N	I hate being in big groups. My chest tightens and I feel like I can’t breathe.	Social anxiety can feel like physical danger. Let’s pause for a moment—can we do a grounding breath?	\N	\N	\N	\N	\N	\N
b43e320a-f249-436a-8a2d-f1b59d32e0df	\N	\N	\N	\N	Sure.	You’re doing great. Now, what’s the part that feels hardest—being seen? Judged?	\N	\N	\N	\N	\N	\N
f1c3434c-5834-4ad8-9482-b27a5122f15d	\N	\N	\N	\N	All of it. I just want to disappear.	That’s your nervous system going into protect mode. But you’re not broken. Do you want to explore tiny steps that build safety, or do you prefer to continue talking about it?	\N	\N	\N	\N	\N	\N
f04b1169-f5c7-4b8a-ba86-2cb56bd00710	\N	\N	\N	\N	Like what?	Entering early so it’s not a crowd, choosing one familiar face, holding something calming in your hand. Which one feels okay to try?	\N	\N	\N	\N	\N	\N
bc871fbd-e276-4f21-83a6-24dd099d7296	\N	\N	\N	\N	Maybe the familiar face. I could stand near them.	Perfect. You’re not escaping—you’re building a bridge.	\N	\N	\N	\N	\N	\N
5fcf05bf-1178-49d3-847a-0b32950c5c34	\N	P004	\N	\N	I keep comparing myself to people on Instagram. I always feel worse after.	Social media can distort reality. What you’re seeing is curated, not truth.	\N	\N	\N	\N	\N	\N
17f0da47-a96f-4e7e-b6b0-b23b167a4a27	\N	\N	\N	\N	But it still gets in my head. Everyone looks so perfect.	Your brain is reacting to illusion as if it’s real. Let’s name what’s real about you instead.	\N	\N	\N	\N	\N	\N
b91fce58-c828-4b61-8c1f-5425aed369da	\N	\N	\N	\N	Like what?	You show up. You care. You’re honest with your feelings. That matters more than filtered pictures.	\N	\N	\N	\N	\N	\N
a98aabf8-d663-40c5-ae65-a2ad7dd6a112	\N	\N	\N	\N	I still want to scroll. I don’t know how to stop.	Do you want to build a “scroll with intention” plan. Time limits, accounts that inspire instead of shame, a check-in before and after.	\N	\N	\N	\N	\N	\N
d5f01f01-8b28-4d22-81b0-0303a8ab08e8	\N	\N	\N	\N	That sounds doable. Maybe 15 minutes, and only pages that make me feel good.	That’s control. That’s choice. You’re the one driving the experience.	\N	\N	\N	\N	\N	\N
8739e287-d671-4497-a069-9a1c35ca3c1b	\N	P004	\N	\N	My teacher embarrassed me in front of the class today. I just shut down.	That must’ve been painful. Being called out publicly can feel like an attack.	\N	\N	\N	\N	\N	\N
2a2f6051-7c9f-4b3f-91cc-697c69612fcb	\N	\N	\N	\N	Everyone laughed. I wanted to disappear.	Shame does that—it tells us we’re small. But you are not the moment that happened. Do you want to talk through a response plan?	\N	\N	\N	\N	\N	\N
632db642-939f-4b0c-bcef-eb0ad67ab944	\N	\N	\N	\N	Like saying something to the teacher?	Yes—either privately or with support. Even just writing it down can help you reclaim your voice.	\N	\N	\N	\N	\N	\N
3554fd8b-a1bc-4ebd-b517-a82b5f2af19e	\N	\N	\N	\N	What if they don’t listen?	Then you did your part. You spoke up for yourself. That builds self-trust, even if the outcome isn’t perfect.	\N	\N	\N	\N	\N	\N
685dad2c-4464-4bc3-8d70-b0f595638cc1	\N	P004	\N	\N	I don’t get invited to hangouts anymore. I think I’m being slowly pushed out.	That sounds really painful—like invisible rejection.	\N	\N	\N	\N	\N	\N
610f9b00-1429-41c3-9eff-32d25bf382be	\N	\N	\N	\N	Yeah. It hurts worse than a fight because it’s just… silence.	Silent exclusion can feel like erasure. Do you want to look at what you *can* do right now?	\N	\N	\N	\N	\N	\N
6e5bcc01-078a-48f4-8d58-d003761b06e3	\N	\N	\N	\N	Like text them? Or just move on?	Both are valid. You could name your feeling gently or shift your energy to people who see you.	\N	\N	\N	\N	\N	\N
9e57853b-159b-4cd2-94d4-668597eb7e8c	\N	\N	\N	\N	I don’t want to seem desperate.	You won’t. “I’ve noticed some distance and miss being part of things” is brave, not needy.	\N	\N	\N	\N	\N	\N
c9292c3d-d412-43fd-b84c-2953f0c7216d	\N	\N	\N	\N	Okay. I’ll try sending something short.	That’s strong. You deserve friendships that make room for you.	\N	\N	\N	\N	\N	\N
8876ca1c-f697-4bc9-a6fd-5fc9ccfc7ccd	\N	P004	\N	\N	I have so much to do, but I keep putting it off. Then I feel worse.	That sounds like the procrastination spiral—avoidance now, guilt later.	\N	\N	\N	\N	\N	\N
2cf118e3-75f5-4016-8a10-04b4f4bdf1f3	\N	\N	\N	\N	Exactly. I know I’m doing it but I can’t stop.	Let’s look at what’s beneath it. Is it fear of not doing it well? Feeling overwhelmed?	\N	\N	\N	\N	\N	\N
3978008e-d383-4b9f-99d3-1b5e850813d7	\N	\N	\N	\N	All of the above.	I get it. Want to break it down into smaller pieces and pick the *easiest win* to start with?	\N	\N	\N	\N	\N	\N
c3dd8315-a261-466a-bb62-977028123da1	\N	\N	\N	\N	Maybe just opening the document.	Perfect. That one action tells your brain, “I’m showing up.” Then we build from there.	\N	\N	\N	\N	\N	\N
f74b1710-5c8b-41d6-ba4c-420f99074410	\N	\N	\N	\N	So I don’t have to finish everything right now?	Exactly. Progress is movement, not perfection.	\N	\N	\N	\N	\N	\N
efef8088-884f-44a8-8e73-b03eb6f915e5	\N	P004	\N	\N	I start things and never finish them. I lose motivation so fast.	That can feel really frustrating—like you’re letting yourself down.	\N	\N	\N	\N	\N	\N
aab5ddbe-7a3f-4823-b142-dbfe7418f369	\N	\N	\N	\N	Yeah, I feel lazy.	Let’s reframe that. You’re probably not lazy—you might just lose momentum without structure. Can we explore a system that works for your brain?	\N	\N	\N	\N	\N	\N
415112d8-b075-445f-a8d6-f71f689413ab	\N	\N	\N	\N	Like what?	Short bursts with rewards. 20 minutes of focus, then a 5-minute break with music or movement. Want to try it or do you want me to give you another suggestion?	\N	\N	\N	\N	\N	\N
201fb117-c08b-4f4b-a9da-a0cd5b64e0db	\N	\N	\N	\N	That sounds better than sitting for hours.	Exactly. Your brain might need rhythm—not punishment.	\N	\N	\N	\N	\N	\N
14af7e84-8b2f-4e45-b3f6-12cc3d9246f5	\N	P004	\N	\N	I don’t even try anymore because I assume I’ll fail.	That fear is loud. It’s trying to protect you—but at a cost.	\N	\N	\N	\N	\N	\N
9f0739da-afee-4c5c-861a-1b4848ad5d4e	\N	\N	\N	\N	What if I’m just not good enough?	Let’s pause and notice: Is that thought a fact or a fear?	\N	\N	\N	\N	\N	\N
fd7915b4-dafb-48dd-94c0-36e0fe32aa17	\N	\N	\N	\N	A fear.	Exactly. Do you want to name one thing you’ve done well recently—even something small, or we can talk more about your fear. What do you want to do?	\N	\N	\N	\N	\N	\N
eda85bf8-3e6b-4151-805c-34bb6b674fc4	\N	\N	\N	\N	I'll share what I've done before, I helped my little sister with her homework.	That’s connection, contribution, and patience. It matters. You don’t only have to “win” to grow.	\N	\N	\N	\N	\N	\N
c93517de-68d5-4c9b-b3d9-a7dbe201d8e2	\N	P004	\N	\N	I used to love drawing but now I never do it. I don’t see the point.	Sounds like disconnection from something that used to bring you joy.	\N	\N	\N	\N	\N	\N
494be3aa-f319-499d-a824-7b769bc09663	\N	\N	\N	\N	Yeah, it just feels pointless now.	That can be a sign of burnout or emotional fatigue. Do you want to try drawing without pressure—just scribbles, color, no goal?	\N	\N	\N	\N	\N	\N
9c6f2b15-aa01-4bda-a653-196dd9b244e8	\N	\N	\N	\N	I guess. I miss the feeling of getting lost in it.	That feeling is still there. Let’s make space for it again—do you want to try for 10 minutes a day, or 15 minutes a day with no expectations?	\N	\N	\N	\N	\N	\N
857eb2d1-89c6-4603-832f-cf79db9c61c5	\N	\N	\N	\N	Maybe I’ll try tonight.	That’s a spark. Joy often comes back through small doors.	\N	\N	\N	\N	\N	\N
a3df315c-93f8-4cfe-8b14-99bcefe6eaa7	\N	P004	\N	\N	I look around and everyone else seems so motivated. I just feel stuck.	It can feel isolating to think everyone has it figured out. But what you see is the highlight reel.	\N	\N	\N	\N	\N	\N
ff7fcdb7-8429-4ae9-87d4-bc300982f6bc	\N	\N	\N	\N	So I’m not the only one?	Not at all. Most people struggle quietly. Do you want to talk about what *you* want—not what looks good on paper.	\N	\N	\N	\N	\N	\N
68963f1b-d6ff-40a6-a424-86d4578dbb90	\N	\N	\N	\N	I want to feel excited again. Like I’m moving forward.	That’s a powerful goal. Let’s build one habit that creates motion, even if it’s small.	\N	\N	\N	\N	\N	\N
c46ef6bc-2200-46a2-bdbb-dda35ffc72f8	\N	\N	\N	\N	Maybe morning walks with music.	Beautiful. That’s momentum. Action creates clarity—you’re not stuck, you’re restarting.	\N	\N	\N	\N	\N	\N
b49af4f2-6983-40dc-85b0-b8a618148d70	\N	P004	\N	\N	I used to be excited about school, but now I just don’t care anymore.	It sounds like something shifted for you. Do you want to talk about what changed?	\N	\N	\N	\N	\N	\N
def41e7b-e0b1-4bac-81eb-3909dc9d0830	\N	\N	\N	\N	I’m not sure. It’s like everything feels pointless lately.	That sounds like emotional fatigue. Sometimes our minds disconnect to protect us from burnout.	\N	\N	\N	\N	\N	\N
8481fdcc-4f3b-45be-8759-2f09931323df	\N	\N	\N	\N	But isn’t that just being lazy?	Not at all. Disconnection is often a sign your system needs rest or meaning—not that you’re weak.	\N	\N	\N	\N	\N	\N
0d2b8ec2-17d2-4fc0-888a-c9878c7da624	\N	\N	\N	\N	So what do I do if nothing feels meaningful?	We start small. Do you want to think of one thing—however tiny—that brings even a little spark?	\N	\N	\N	\N	\N	\N
539da7d8-849e-4371-959c-7409119ef730	\N	\N	\N	\N	I guess music still helps sometimes.	That’s a clue. Can we pair that with a daily habit? Like listening while organizing your notes or going for a walk?	\N	\N	\N	\N	\N	\N
cbc7329c-343c-4954-ae74-e3ad37acba35	\N	\N	\N	\N	Maybe. That feels lighter than forcing myself to “care.”	Exactly. We’re building from ease, not shame. You don’t have to fake motivation—you can rebuild it gently.	\N	\N	\N	\N	\N	\N
bcf8090e-ce54-44e4-92ff-b09659e2d139	\N	P004	\N	\N	I feel like I have no discipline. I make plans and then ignore them.	That’s a really common experience, especially when the plans are too rigid or heavy.	\N	\N	\N	\N	\N	\N
109cd19b-492d-49cc-88e7-d5b5566dd4bf	\N	\N	\N	\N	But other people seem to just push through.	I hear that comparison creeping in. Want to pause and look at your *own* rhythm instead?	\N	\N	\N	\N	\N	\N
9b269370-da80-4b3d-abd6-daa94021eb87	\N	\N	\N	\N	What do you mean?	Some people operate on structure. Others need flexibility and reward systems. Let’s build one that fits your brain.	\N	\N	\N	\N	\N	\N
50d1770e-7051-44cf-b758-561c6013489e	\N	\N	\N	\N	Like what?	We could try a checklist with flexible blocks: “focus, pause, reward.” Or use visual cues—color-coded tasks, sticky notes. What do you think would work for you?	\N	\N	\N	\N	\N	\N
dedf49f7-4a43-4c55-b0ae-5143782d779d	\N	\N	\N	\N	I like visuals. I need to *see* what I’m doing.	Great insight. That’s not lack of discipline—it’s a different kind of organization. One that actually works for you.	\N	\N	\N	\N	\N	\N
b4003edb-d1de-4827-97f8-1e7717099739	\N	P004	\N	\N	I can’t get started on anything because I’m scared I’ll screw it up.	That fear of failure can be paralyzing. Can I ask—what’s the worst thing that could happen if you did mess up?	\N	\N	\N	\N	\N	\N
e424691a-9c67-43c6-97c8-7f807c28aebc	\N	\N	\N	\N	I’ll disappoint everyone. They’ll know I’m not good enough.	That sounds like a deep belief you’ve been carrying. But what if we rewrote that story?	\N	\N	\N	\N	\N	\N
22883b27-de56-4329-8eed-931ad1e9a1c8	\N	\N	\N	\N	How?	It could start with: “Trying and learning isn’t failure—it’s growth.” Want to say it out loud?	\N	\N	\N	\N	\N	\N
5203362e-c918-4001-bdf2-b89e62901388	\N	\N	\N	\N	Trying and learning isn’t failure—it’s growth.	Hear that shift? That’s reframing. Now, can we pick one task and start with just 5 or 10 minutes, you can choose.	\N	\N	\N	\N	\N	\N
38be52a4-110b-4722-9334-0fca8f8195a6	\N	\N	\N	\N	I guess I could try working on the intro to my essay for 5 minutes.	Perfect. Five minutes. You’re not committing to perfect—just showing up.	\N	\N	\N	\N	\N	\N
98e27af8-2a7b-41c8-90f7-8477c619f9a9	\N	P004	\N	\N	I want to do something meaningful in life, but I don’t know what I’m good at.	It’s so human to want purpose. Can I ask—what moments make you feel most alive?	\N	\N	\N	\N	\N	\N
11e70245-bf7d-4721-9c1b-d588b70dda8c	\N	\N	\N	\N	Maybe when I help someone. Or when I’m being creative.	That’s powerful. Helping and creating—those are values. They point toward your direction.	\N	\N	\N	\N	\N	\N
fd1fdaee-f3f0-4f60-9916-9006c02c339f	\N	\N	\N	\N	But I’m not great at anything specific.	You don’t have to be the best. You only need to be engaged. Do you want to make a list of things you’ve enjoyed or been proud of or do you want to talk about this some more?	\N	\N	\N	\N	\N	\N
1c393c1d-cdac-4608-b129-70312bc015db	\N	\N	\N	\N	Okay… tutoring my cousin, making posters for events, organizing stuff.	Those are all skills. Maybe we can brainstorm paths where they fit—nonprofits, design, teaching.	\N	\N	\N	\N	\N	\N
67448fc5-fe10-4808-80f8-4f3d4de58e57	\N	\N	\N	\N	I’ve never thought of it that way.	It’s a beginning. You’re not lost—you’re in the middle of figuring things out.	\N	\N	\N	\N	\N	\N
93c31777-0e0a-409d-8c16-3c8d9c3bd1ce	\N	P004	\N	\N	Every time I get close to finishing something, I sabotage it.	I hear frustration in that. Can we pause and look at what’s underneath?	\N	\N	\N	\N	\N	\N
90baeca4-454a-414c-acf5-2939d9bcbcbc	\N	\N	\N	\N	Maybe I’m scared of what happens if I actually succeed.	That’s deep honesty. Sometimes we fear success because it means change or pressure.	\N	\N	\N	\N	\N	\N
c7415cb6-830e-4801-8b2f-fb09a53eaba0	\N	\N	\N	\N	Yeah. If I succeed, people expect more—and I might not be able to keep it up.	So it’s safer to stay stuck than risk the pressure of rising?	\N	\N	\N	\N	\N	\N
263d8eb5-885b-47c5-89d2-8909f61cdd22	\N	\N	\N	\N	Exactly.	It makes sense. But you also deserve to see what you’re capable of. Do you want some help to create a success plan *with* boundaries? We can work on this now, or later, you choose.	\N	\N	\N	\N	\N	\N
11bfbd29-c847-444d-b4de-ded275c7e964	\N	\N	\N	\N	Boundaries? What does that mean? Lets work on this now	Yes. Like celebrating small wins, saying no to added pressure, and choosing your pace. You don’t have to sprint just because you can run.	\N	\N	\N	\N	\N	\N
eefd05b9-a8f6-4887-b47b-a021f098c1bd	\N	\N	\N	\N	That helps. I want to finish this time—without burning out.	That’s a strong goal. Let’s build a way for you to cross that finish line with peace, not panic.	\N	\N	\N	\N	\N	\N
a894b00a-0572-43ca-a5ff-26f61bf7430c	\N	P004	\N	\N	I don’t think anyone actually sees me. I’m just... there.	That sounds really lonely. Like you’re in the room, but invisible.	\N	\N	\N	\N	\N	\N
4dc635b7-c7ec-476e-ac98-700dcfd08ce9	\N	\N	\N	\N	Yeah. I could disappear for a day and no one would notice.	I’m noticing you now. And I’m really glad you said something. That takes courage.	\N	\N	\N	\N	\N	\N
bb27a8df-40e6-41ff-b5be-491585a1b1da	\N	\N	\N	\N	I’m just tired of pretending I’m fine.	You shouldn’t have to pretend. What would it be like to show even a small part of how you’re really feeling?	\N	\N	\N	\N	\N	\N
a57a18b5-bbc4-4451-905b-d5a7d5828018	\N	\N	\N	\N	Scary. But maybe kind of freeing too.	We can take it one step at a time. You don’t have to carry this alone.	\N	\N	\N	\N	\N	\N
890eb4f2-f14d-4930-8ac3-7ffd144416fa	\N	P004	\N	\N	I keep messing up with my parents. Every talk turns into a fight.	It sounds like the tension builds up fast. Do you want things to feel different between you?	\N	\N	\N	\N	\N	\N
48f94766-135f-4a4f-8ca7-65e032b26beb	\N	\N	\N	\N	Yeah. But I don’t even know where to start.	What’s the part that hurts the most in those moments?	\N	\N	\N	\N	\N	\N
e925d68e-027d-4ee0-8569-0adc3c4025ce	\N	\N	\N	\N	When they act like I’m just being dramatic or lazy.	It feels like they’re not hearing what’s underneath. Do you think they’d be open to hearing what’s behind your tone—if we wrote it out together?	\N	\N	\N	\N	\N	\N
4ab53c60-6d50-49d1-801f-950af0f0b0d2	\N	\N	\N	\N	Maybe. That might make it easier.	Would you like me to help you shape the words? You deserve to be heard, not just reacted to.	\N	\N	\N	\N	\N	\N
26eb61e4-3fba-4128-a44c-ebb625786bf5	\N	\N	\N	\N	Yes, that would be a great help thank you.	\N	\N	\N	\N	\N	\N	\N
8a0825bd-418f-45a9-ba66-1ab52d3518fe	\N	P004	\N	\N	Everyone expects me to be “the strong one,” but I’m so tired.	That sounds like a heavy mask to wear all the time.	\N	\N	\N	\N	\N	\N
ebd7eecc-79bf-4593-8245-efba66a8115d	\N	\N	\N	\N	Yeah. If I fall apart, it feels like everything else will too.	So you hold it all in to keep everything standing. That must be exhausting.	\N	\N	\N	\N	\N	\N
d2937478-503e-4cdb-9954-07250f82fe1b	\N	\N	\N	\N	It is. But if I stop, I’m afraid I’ll break.	What if breaking isn’t the end—but just a signal to breathe, to ask for help?	\N	\N	\N	\N	\N	\N
4e0cc2d0-ca7b-40e2-8e52-ee2b969a2b9e	\N	\N	\N	\N	I’ve never thought about that.	Being strong doesn’t mean carrying it alone. It means knowing when to rest and let someone else hold the weight for a bit.What do you want to do about it?	\N	\N	\N	\N	\N	\N
86e678bd-a5b5-4a7c-816c-dbfb80d73b71	\N	\N	\N	\N	I think i'll ask for some help	Great idea	\N	\N	\N	\N	\N	\N
d6d718a7-5ef6-4de6-b35e-fb6f5721dee1	\N	P004	\N	\N	I feel like I’m stuck between who I was and who I’m supposed to become.	That in-between space can be really disorienting.	\N	\N	\N	\N	\N	\N
f6baf9ae-99d9-46b1-b07a-949dc5e340fa	\N	\N	\N	\N	It’s like I don’t fit anywhere. Not anymore.	Maybe you’re in the middle of growing—and the old skin doesn’t quite fit, but the new one’s not ready yet.	\N	\N	\N	\N	\N	\N
eda3bcf3-7495-46ba-856a-ab53551b0df3	\N	\N	\N	\N	Yeah… that’s kind of what it feels like.	That place is real. It’s not failure—it’s transition. Can we name something small that still feels solid in the midst of change?	\N	\N	\N	\N	\N	\N
3737bf40-efa7-40c1-b863-4435f4981e9c	\N	\N	\N	\N	My love for animals hasn’t changed.	That’s something steady. Let’s hold onto that while you grow into the next version of yourself.	\N	\N	\N	\N	\N	\N
3d434733-48bf-4990-99fe-54d09f6febc5	\N	P004	\N	\N	I just don’t care about anything anymore. It all feels numb.	Numb can be a form of pain that’s gone underground. Like your feelings got tired of shouting.	\N	\N	\N	\N	\N	\N
955361c0-595a-483f-9383-9d1b2aa3440e	\N	\N	\N	\N	That’s exactly it. I’m just... over it.	Do you want to try and fix this problem, or do you prefer to sit here with the truth of what you’re feeling?	\N	\N	\N	\N	\N	\N
9ca49017-d433-439d-8282-717ef7f5034b	\N	\N	\N	\N	Okay, I"ll sit here with the feeling.	I’m with you in this space. You don’t need to force care to deserve care.	\N	\N	\N	\N	\N	\N
8b56ae56-1c0e-449d-83e1-7f0baeea5df6	\N	\N	\N	\N	Thanks.	I’m glad you let me in. That’s a powerful place to start.	\N	\N	\N	\N	\N	\N
82558402-ac54-4bc5-8128-8773e81fee79	\N	P004	\N	\N	Lately, every time my mom asks me something, I freeze. Like I’m going to get it wrong.	That sounds like there’s a lot of pressure in those moments—even if she doesn’t mean it that way.	\N	\N	\N	\N	\N	\N
93beced4-42ea-4aa9-b798-c76006deae0b	\N	\N	\N	\N	Yeah. It’s like my brain goes blank. I get so tense.	Do you think it’s about the question, or what might happen if you answer “wrong”?	\N	\N	\N	\N	\N	\N
b3f9936e-fb45-4ac1-947e-61538505f8f9	\N	\N	\N	\N	It’s the reaction. She sighs or gets impatient, and then I feel like a disappointment.	That feeling runs deep. You’re not just reacting to her now—you’re reacting to years of feeling judged.	\N	\N	\N	\N	\N	\N
73db6fe7-a7f4-4be4-8c1d-b5c411abcf9f	\N	\N	\N	\N	Exactly.	It makes sense then that your body tenses up to protect you. Do you want to explore what a calmer moment with her might look like?	\N	\N	\N	\N	\N	\N
81194df8-bb27-4984-861e-4c0f944a8efb	\N	\N	\N	\N	I guess I could tell her I need a second to think.	That’s a great step. Naming what you need helps reset the dynamic. You’re allowed to pause.	\N	\N	\N	\N	\N	\N
d07bcf99-d21e-44e1-8158-3f5404a48fec	\N	P004	\N	\N	My dad never talks about emotions. I’ve tried, but he just shuts down.	That must feel so isolating. Like there’s a wall between what you feel and what he’ll let in.	\N	\N	\N	\N	\N	\N
8d503a81-4066-4ac6-812b-d0d2c278187b	\N	\N	\N	\N	Yeah. I want connection, but I don’t want to push him.	Wanting connection isn’t pushing—it’s reaching. And it matters. What have you tried so far?	\N	\N	\N	\N	\N	\N
8b50f301-2f1d-4f45-b1e4-268f19091e77	\N	\N	\N	\N	I once wrote him a letter, but he didn’t bring it up.	That silence can feel like rejection, even if it’s his discomfort speaking. Do you want to try it again, with no expectations?	\N	\N	\N	\N	\N	\N
5fddf8f7-620c-4365-8bd5-8a213771318a	\N	\N	\N	\N	Hard. But maybe worth it.	I can help you shape the words if you want. Even saying, “This is hard for me, but I care,” is a start.	\N	\N	\N	\N	\N	\N
89989d44-f68b-429f-8cdf-5fc8da8cc16b	\N	P004	\N	\N	I always feel like I owe my parents something. Like I can’t make my own choices.	That sounds like a quiet pressure that's always there—shaping your decisions.	\N	\N	\N	\N	\N	\N
ee1493c9-0092-4fa5-9f77-3c818f3beb76	\N	\N	\N	\N	Yeah. Even when I disagree, I feel guilty just thinking it.	Guilt can be a strong force when love and duty get tangled. Can we pause and name what *you* want?	\N	\N	\N	\N	\N	\N
b66ffce8-76bd-402e-ae74-5215fb15ecc9	\N	\N	\N	\N	I want to study art. They want me to do business.	That’s a real conflict. But your desires are valid. What would it feel like to say, “This matters to me, even if it’s not what you pictured”?	\N	\N	\N	\N	\N	\N
4b7b1d76-2556-4ffb-8349-e133adff7c07	\N	\N	\N	\N	Terrifying. But maybe also freeing.	That’s the space where your voice grows. If you want, we can practice how that conversation might sound. You can choose what you prefer.	\N	\N	\N	\N	\N	\N
7d500a1d-b2e8-4f33-b54e-d8a2aa9b8115	\N	P004	\N	\N	I think my parents love me, but I never feel like I’m enough for them.	That’s a painful place to live—always striving, never arriving.	\N	\N	\N	\N	\N	\N
5250e845-09f0-4db6-a47c-4affcb4bc114	\N	\N	\N	\N	Yeah. If I get an A, they ask why it wasn’t an A+.	It’s like the goalpost keeps moving. That constant pressure can chip away at your self-worth.	\N	\N	\N	\N	\N	\N
42fd9621-e747-42d4-9105-3d4a05a2e182	\N	\N	\N	\N	It does. I pretend it doesn’t bother me, but it does.	What would it be like to let them know how it feels when their standards silence your joy?	\N	\N	\N	\N	\N	\N
be7aaa48-ffc0-4e6b-9ccb-cd79f841e3d5	\N	\N	\N	\N	Scary. I don’t think they mean to hurt me.	You can love someone and still ask for change. Want to write a few lines together that name your truth gently?	\N	\N	\N	\N	\N	\N
8720eb36-c109-4cd6-b9ca-59990e2e99d4	\N	\N	\N	\N	Yeah. I’d like that.	Okay. You deserve to feel proud—not just pushed.	\N	\N	\N	\N	\N	\N
8dcad684-eff6-4471-88c6-e3a5fbebea52	\N	P004	\N	\N	Whenever I argue with my parents, I feel sick after. Like I did something wrong even if I didn’t.	That sounds like your nervous system stays stuck in the fight long after it’s over.	\N	\N	\N	\N	\N	\N
895243b6-c3fe-40e3-a7c6-e00f92b9c347	\N	\N	\N	\N	I replay the whole thing in my head, over and over.	That kind of rumination is exhausting. Can we try to unpack what part of the argument hits you the hardest?	\N	\N	\N	\N	\N	\N
2bab7564-d82f-46c3-865f-ea8b32fcc0cd	\N	\N	\N	\N	When they say I’m ungrateful. Even if I was just setting a boundary.	That word lands heavy. Maybe it touches an old belief that your needs are “too much.”	\N	\N	\N	\N	\N	\N
bf160ac6-44bc-4928-8f68-653f1d0bb022	\N	\N	\N	\N	Yeah. That’s exactly it.	I wonder how it would feel to remind yourself: “Setting boundaries is a form of respect—not rejection.”	\N	\N	\N	\N	\N	\N
e17fd3b6-3633-4133-9f87-e1f5fc18b362	\N	\N	\N	\N	I think I need to hear that more often.	Let’s turn it into a phrase you repeat when the guilt starts creeping in. You deserve to feel safe in your own voice.	\N	\N	\N	\N	\N	\N
530e0934-9e1a-4670-a4ec-0fb5bf6eb72e	\N	P004	\N	\N	I always feel like I’m walking on eggshells around my mom. One wrong word and she blows up.	That sounds like you’re constantly on alert—like you have to shrink yourself just to stay safe.	\N	\N	\N	\N	\N	\N
0921f115-90cb-477e-a7ea-1276b83538d6	\N	\N	\N	\N	Exactly. I don’t even speak up anymore.	It makes sense. Your silence isn’t weakness—it’s a survival strategy.	\N	\N	\N	\N	\N	\N
69a24bfd-737a-43c3-9e9d-b53d5f762207	\N	\N	\N	\N	But it’s making me feel small and resentful.	That resentment is a signal that your boundaries are being crossed, even quietly. Want to talk through what safety might look like with her?	\N	\N	\N	\N	\N	\N
08fb586c-287b-438f-848f-f3dab6fed4b6	\N	\N	\N	\N	I don’t even know. Maybe just asking her to not raise her voice.	That’s a strong start. You could say, “I want to talk, but I shut down when it gets loud.”	\N	\N	\N	\N	\N	\N
d7656177-aabc-4589-ab51-29ebdf6b3735	\N	\N	\N	\N	What if she gets mad at that too?	Then you gave her the chance. You didn’t stay silent. That’s growth, even if she’s not ready to meet you there.	\N	\N	\N	\N	\N	\N
8db4809f-1972-44b0-bbb8-3444c71947dc	\N	P004	\N	\N	My parents always compare me to my older brother. I hate it.	It sounds like they don’t realize how much that stings.	\N	\N	\N	\N	\N	\N
eb1aee08-882d-4785-be77-8df04ed71eb0	\N	\N	\N	\N	They always say, “Why can’t you be more like him?”	That kind of comment cuts deep. It makes you feel like who you are isn’t good enough.	\N	\N	\N	\N	\N	\N
724f796f-66cc-4945-a28c-98afc270440d	\N	\N	\N	\N	Exactly. And the worst part is—I’ve started believing it.	Let’s pause right there. You are not your brother, and you’re not meant to be.	\N	\N	\N	\N	\N	\N
e8b7e93b-3386-4269-bd7e-68d12a836659	\N	\N	\N	\N	But I still feel like a disappointment.	You are allowed to be your own person. Maybe next time, you could say, “I’d like to be valued for who I am, not compared to someone else.”	\N	\N	\N	\N	\N	\N
8536d445-5eb1-4b30-a517-cf34f41b9084	\N	\N	\N	\N	I don’t know if I can say that out loud.	If you want, we can write it out together, or we can work on sending it in a message if you prefer.	\N	\N	\N	\N	\N	\N
bd277e22-4c63-428d-905e-33b765da55e3	\N	P004	\N	\N	My dad says he wants me to be honest, but when I am, he shuts me down.	That’s confusing—he asks for truth, but doesn’t create space for it.	\N	\N	\N	\N	\N	\N
0d740824-d7aa-4013-8897-a3ff2cffff42	\N	\N	\N	\N	Yeah. Last time I said how I felt, he called me disrespectful.	That must have felt like a slap to your vulnerability.	\N	\N	\N	\N	\N	\N
8417c911-a78f-439f-9fdc-a3ef0a3509c8	\N	\N	\N	\N	I just stopped trying after that.	It makes sense. Why open up if it’s going to hurt more?	\N	\N	\N	\N	\N	\N
09f4e118-c907-4699-9c28-35284624aef2	\N	\N	\N	\N	So what do I do?	I wonder if naming the pattern might help. Like, “I want to share, but I need to feel safe when I do.”	\N	\N	\N	\N	\N	\N
c5a92b74-2e17-489b-b255-57f3aa7ed1a0	\N	\N	\N	\N	Even saying that feels risky.	And brave. Do you want to rehearse it together or do you prefer to just say it yourself? You deserve to speak your truth without fear.	\N	\N	\N	\N	\N	\N
2045cf83-e7e4-425f-bcbc-0e8795fb69d2	\N	P004	\N	\N	I try so hard to make my parents proud, but I don’t think they ever really see me.	That’s a painful kind of invisibility—being noticed for what you do, but not for who you are.	\N	\N	\N	\N	\N	\N
5f73f798-013e-4c93-ae91-15ff24e21b0f	\N	\N	\N	\N	Yeah. I get good grades, stay out of trouble, help at home… nothing seems to matter.	You’ve been showing up in all the ways they say they want—but your emotional needs are going unmet.	\N	\N	\N	\N	\N	\N
c87c52a2-89a4-4017-b439-f22b61a30ca7	\N	\N	\N	\N	Right. I don’t want more chores—I want them to *know* me.	That’s so important. Can we think of a gentle way to invite them into your world?	\N	\N	\N	\N	\N	\N
9b3d65fd-73b8-4871-b778-452d13f26296	\N	\N	\N	\N	Maybe writing a note? I don’t do well talking in person.	That’s totally fine. You could share something you’ve never said before, like what lights you up or what hurts you.	\N	\N	\N	\N	\N	\N
cb094e5c-722e-4a90-83b5-ab0e78d0b0ff	\N	\N	\N	\N	I like that. It might finally open a door.	Exactly. You’re not asking for praise—you’re asking to be *seen*.	\N	\N	\N	\N	\N	\N
f9949818-283f-4249-9c9c-318a70118042	\N	P004	\N	\N	Every time I say no to my mom, she acts like I betrayed her.	It sounds like saying no isn’t safe—it becomes personal, like an attack.	\N	\N	\N	\N	\N	\N
df7dd1b6-e9a8-4c3c-9d27-c85d7a92c867	\N	\N	\N	\N	Yeah, then I feel guilty for even trying to set a boundary.	That’s emotional pressure disguised as closeness. It’s not your job to meet all her needs.	\N	\N	\N	\N	\N	\N
a022206d-af06-4abe-8669-401654352f4f	\N	\N	\N	\N	But I don’t want to hurt her feelings.	I hear that. Can we reframe “no” as “I care, and I also need space”?	\N	\N	\N	\N	\N	\N
d34296a4-2659-4c87-9560-9fd71e9760d2	\N	\N	\N	\N	How would I even say that?	You can try: “I love you, and I also need to say no right now so I don’t burn out.” or we can think of another line together. What do you prefer?	\N	\N	\N	\N	\N	\N
14cd2e71-8057-4b4e-8ce6-88e855763fd4	\N	\N	\N	\N	That sounds more kind than how I usually say it.	Kindness and firmness can live together. And you’re allowed to protect your energy.	\N	\N	\N	\N	\N	\N
785e559e-d24b-45d8-93b4-1087fe2e275a	\N	P004	\N	\N	I like this guy but I have no idea if he actually likes me back. It’s driving me crazy.	That sounds like a storm of wondering—and no clear signals.	\N	\N	\N	\N	\N	\N
4c2e4465-70c0-40ed-b1a9-3ae87a141bff	\N	\N	\N	\N	Yeah. One day he talks to me for hours, the next day it’s like I don’t exist.	That emotional whiplash is confusing. It’s okay to want clarity—you’re not “needy” for wondering where you stand.	\N	\N	\N	\N	\N	\N
43f11e33-aae9-45a2-98e2-d866c3c8d02a	\N	\N	\N	\N	Should I ask him? What if I scare him off?	It’s scary to be direct, but it’s also exhausting to keep guessing. How would it feel to say, “I’ve noticed I’m unsure where I stand with you”?	\N	\N	\N	\N	\N	\N
4b773509-7dcb-45a6-9613-3860559084dc	\N	\N	\N	\N	That feels honest, but terrifying.	Honest *is* brave. And you deserve a relationship that brings peace, not confusion.	\N	\N	\N	\N	\N	\N
bc3628d9-1320-4842-b489-ab34f2dffa96	\N	\N	\N	\N	I just want to know the truth, even if it hurts.	And that shows maturity. Let’s figure out how to ask in a way that feels most true to you.	\N	\N	\N	\N	\N	\N
13ee0620-1ac3-4f37-8468-7b6783739f10	\N	P004	\N	\N	My girlfriend broke up with me last week and I still can’t breathe.	It sounds like your whole body is grieving, not just your heart.	\N	\N	\N	\N	\N	\N
ae02406b-5597-4219-87ad-cfb45f84d2d8	\N	\N	\N	\N	I keep going over what I did wrong.	Breakups trigger a deep need to make sense of things. But not every ending is about failure.	\N	\N	\N	\N	\N	\N
9a3b7f82-7d2e-48ca-8af3-bfd2b1b46e9c	\N	\N	\N	\N	It still feels like I wasn’t enough.	That belief can linger, but it isn’t truth. Want to talk about what you *gave* in that relationship?	\N	\N	\N	\N	\N	\N
a9c69889-1e7a-4fd8-af32-54ef63c2f560	\N	\N	\N	\N	I tried hard to listen. I always showed up.	That matters. You were present and real. Maybe this pain isn’t about your worth—but about loss.	\N	\N	\N	\N	\N	\N
962f60e3-3283-4bea-98c6-0c5727ca606c	\N	\N	\N	\N	So what do I do with it?	We sit with it, gently. And when you’re ready, we talk about how to carry the pain without letting it define you.	\N	\N	\N	\N	\N	\N
b9270a3d-4c82-466d-9130-769406cabaed	\N	P004	\N	\N	My boyfriend keeps making jokes that hurt me, but when I tell him, he says I’m too sensitive.	That sounds like he’s avoiding accountability—and turning it on you.	\N	\N	\N	\N	\N	\N
4a523229-556b-4386-933c-23958c6ef379	\N	\N	\N	\N	I don’t want to seem dramatic, but I cry after.	Your tears are valid. Jokes that hurt repeatedly aren’t harmless—they’re communication.	\N	\N	\N	\N	\N	\N
8758fa6e-5059-4255-a935-3ea6fa3aa94b	\N	\N	\N	\N	What if he doesn’t mean to?	Even if the intent isn’t to harm, the impact still matters. How would it feel to say, “That joke doesn’t sit right with me—it hurts”?	\N	\N	\N	\N	\N	\N
5de37e9b-1e2b-4b4c-b833-f94f18ac5b3f	\N	\N	\N	\N	I’m scared he’ll get defensive.	You can’t control his reaction, but you can control your truth. Let’s practice the sentence together.	\N	\N	\N	\N	\N	\N
79e0c56c-fd0b-42ce-a4e4-7ffce0a618e4	\N	\N	\N	\N	Okay. I want to feel strong when I say it.	And you will. Standing up for yourself is strength—even when your voice shakes.	\N	\N	\N	\N	\N	\N
80171bd0-5476-49f1-9d3f-ab7f9f95949a	\N	P004	\N	\N	I’ve never had a relationship and I feel like I’m falling behind everyone else.	That’s a hard feeling—like the world’s racing ahead and you’re stuck on pause.	\N	\N	\N	\N	\N	\N
6f1acae4-f502-47a0-9c2f-6b106b43ee42	\N	\N	\N	\N	Yeah. Everyone around me is dating and I’m just… waiting.	Waiting doesn’t mean lacking. Want to explore what you actually want—not just what’s expected?	\N	\N	\N	\N	\N	\N
b554150e-237d-4275-af64-5f113643570d	\N	\N	\N	\N	I don’t know. Maybe I just want someone to get me.	That’s a powerful start. Relationships aren’t milestones—they’re connections. would you like to explore how you can be more active or would you like to explore your current situation and see if you are seeing the full picture of what is happening around you. Somethimes we have blind spots and we miss things, especially when it comes to social interactions.	\N	\N	\N	\N	\N	\N
990ccac9-8d09-4cc6-bb5d-bd6cd35fcc7f	\N	\N	\N	\N	OK, this is interesting, maybe I have blind spots? I'dlike to explore that.	Great, let's start	\N	\N	\N	\N	\N	\N
2694e2ce-07b7-4cce-a9d3-053af6ffde9b	\N	P004	\N	\N	I feel like I’m always the one chasing in relationships. No one ever chooses me first.	It sounds like that ache goes deep, like being second place to everyone.	\N	\N	\N	\N	\N	\N
e9b7911a-6529-4158-9f7c-716b76c66f9f	\N	\N	\N	\N	Exactly. I text first, I plan things. If I stop, it’s silence.	It sounds like you’ve learned to hustle for love—and it’s exhausting.	\N	\N	\N	\N	\N	\N
8843ec86-fd06-4e5b-b32c-7d21c1977503	\N	\N	\N	\N	Yeah. And then I start wondering if I’m just not worth the effort.	Let’s pause. It is easy to confuse lack of communication with self worth. would you like to try something new?	\N	\N	\N	\N	\N	\N
8de5e5f0-0487-4c2d-8324-06a95f84259e	\N	\N	\N	\N	sure, but what?	You can make a list of communication expectations that you have and then go over it and see if it makes sense to have these expectations? You can dive deep into trying to understand why you would think less of yourself as a sesponce to someone elses communication style.	\N	\N	\N	\N	\N	\N
1dfc8167-518e-4eb7-b835-97adb3d30722	\N	\N	\N	\N	I think I have to separate my self worth from the way people communicate with me. yes.	OK, great. Would you like to start by writing your healthy communication expectations.	\N	\N	\N	\N	\N	\N
ed11f7ce-7aa5-4652-b169-042bb0a11d08	\N	\N	\N	\N	Ye, thanks, I'll start there	\N	\N	\N	\N	\N	\N	\N
52d3665b-a689-474b-8a4e-088ed9837a19	\N	P004	\N	\N	I feel like I’m always the one sharing in my relationship. He just listens but never opens up.	That can feel one-sided—like you’re giving emotional energy without getting any back.	\N	\N	\N	\N	\N	\N
41844f4b-4744-481c-b817-b0a753874f2b	\N	\N	\N	\N	Yeah. I want to know what he’s feeling, but he just shrugs things off.	It sounds like you’re craving connection, not just conversation.	\N	\N	\N	\N	\N	\N
4de5c2a1-3e97-419f-9ae1-0d592efa9f91	\N	\N	\N	\N	Exactly. It’s like I’m in it alone.	Have you ever told him how that feels—not as a complaint, but as a need?	\N	\N	\N	\N	\N	\N
80c222b5-b7da-4089-9a0c-228e48d38fc8	\N	\N	\N	\N	No… I guess I don’t want to seem clingy.	Needing emotional closeness isn’t clingy. It’s human.  you can try  saying, “I feel closest to you when you share too”? Or, "this is how I feel connected and it will be great to try it my way sometimes"	\N	\N	\N	\N	\N	\N
815b71e5-f90e-4ebc-aa27-12aaeb60bf3f	\N	\N	\N	\N	That actually sounds okay. I want to try.	Good. You deserve to feel seen and heard, not just like a listener.	\N	\N	\N	\N	\N	\N
afe9c05b-d74d-4fe8-90d2-6df0285354b7	\N	P004	\N	\N	I let my guard down with someone and now I regret it. He’s acting distant.	That can be such a vulnerable spot—giving trust and not knowing if it’ll be held.	\N	\N	\N	\N	\N	\N
e1ed53b5-5f4c-49ee-8432-a889b7536e07	\N	\N	\N	\N	Yeah. I feel stupid for opening up.	Let’s pause there. You’re not stupid—you were brave. His behavior doesn’t erase that.	\N	\N	\N	\N	\N	\N
49a502d5-a01b-4d82-bda5-32febb2a3492	\N	\N	\N	\N	But now I just want to shut down again.	I get that urge. But healing doesn’t come from walls—it comes from clarity. Do you want to think through what you *want* to say to him, or do you need another minute to "be" in it?	\N	\N	\N	\N	\N	\N
1b82da44-7921-4ccf-9cad-923e175423d4	\N	\N	\N	\N	I think I want to  ask what changed.	Then let’s do it. Your voice still matters, even if someone else pulled away.	\N	\N	\N	\N	\N	\N
f36fd048-0876-4a6d-9614-cbc2f049e435	\N	P004	\N	\N	My girlfriend keeps checking my phone and getting upset about little things.	That sounds like a trust issue that’s getting really invasive.	\N	\N	\N	\N	\N	\N
8f99e659-35d3-4b5a-918b-51d4df029e2a	\N	\N	\N	\N	Yeah. I haven’t done anything wrong, but I feel guilty anyway.	That guilt might not be yours to carry. Want to explore where your line is—what feels respectful versus what feels controlling?	\N	\N	\N	\N	\N	\N
b1e77658-c67a-42cd-818d-9889d8f1dbe0	\N	\N	\N	\N	I don’t want to lose her, but I don’t like feeling watched.	You’re allowed to want love and privacy. Maybe we can figure out how to say, “I want us to trust each other without needing proof.”	\N	\N	\N	\N	\N	\N
319e9f44-8414-47c5-8b5b-a362a783ee24	\N	\N	\N	\N	That sounds right. I need space without guilt.	Exactly. Boundaries protect connection—they don’t threaten it. Do you think you can work out how to say it on your own, or do you want to figure out the wording together?	\N	\N	\N	\N	\N	\N
ba821e29-cb00-41d5-a0f0-601b11fe49c7	\N	\N	\N	\N	I think I can manage this on my own.	Great!	\N	\N	\N	\N	\N	\N
56955065-249e-48d9-8ccb-01d66f578b68	\N	P004	\N	\N	I’m starting to feel like I lose myself in every relationship. I become who they want.	That sounds like you’ve learned to adapt to stay connected—but at the cost of your identity.	\N	\N	\N	\N	\N	\N
1a40beb7-74c7-4cc1-97a9-99cf66461688	\N	\N	\N	\N	Yes. I don’t even know what *I* like anymore.	Let’s sit with that. When you’re with someone, what parts of you shrink?	\N	\N	\N	\N	\N	\N
352bf4c3-60f7-4a73-98f0-2f9121c75ad6	\N	\N	\N	\N	My opinions, my hobbies, even how I dress.	That’s a big signal. Real love won’t ask you to disappear.	\N	\N	\N	\N	\N	\N
843a5658-bd98-4654-9a8b-b854fe5234cb	\N	\N	\N	\N	So how do I stay *me* next time?	We can build anchors—your values, your joy, your voice. Even one boundary like, “I still need solo time on weekends” can help.	\N	\N	\N	\N	\N	\N
1a784709-f1bd-4366-aa65-5670e0a917f6	\N	\N	\N	\N	I want that. I want to keep my center.	And you can. Relationships should expand you, not erase you.	\N	\N	\N	\N	\N	\N
bfb35d79-c67e-4dd4-b16f-5a14f53e13dc	\N	P004	\N	\N	He says he loves me, but then he jokes about things I’ve told him in private.	That feels like a betrayal—laughing with your secrets instead of holding them.	\N	\N	\N	\N	\N	\N
128dc088-9b86-4ffd-b919-cc02b24c4408	\N	\N	\N	\N	Yeah. I brush it off but I feel hurt every time.	It makes sense. Trust isn’t just about not lying—it’s about how someone protects what you share.	\N	\N	\N	\N	\N	\N
b84fca03-b354-462b-a0ad-35cc03374c81	\N	\N	\N	\N	So is that a red flag?	Only you can decide—but your hurt is real. Want to talk about what you need for this to feel safe again?	\N	\N	\N	\N	\N	\N
86632237-5379-471d-abb4-db8b10e2f580	\N	\N	\N	\N	I think I need him to understand that some things aren’t jokes.	Exactly. Maybe saying, “When you joke about that, it makes me feel unsafe sharing with you” could open the door.	\N	\N	\N	\N	\N	\N
ee5f1a31-11bb-42aa-ab53-9cb8cfc7cbfa	\N	\N	\N	\N	Okay. I need to say something.	And you deserve to. Trust should feel like safety, not silence.	\N	\N	\N	\N	\N	\N
868787ef-c8bd-40e7-97cb-10a507c801b5	\N	P004	\N	\N	I told him I liked him and he said he “wasn’t sure.” I feel so embarrassed.	Thanks for trusting me with that. What was it like for you to say it out loud to him?	\N	\N	\N	\N	\N	\N
51f90500-aec6-45c1-b87a-04a22214dce1	\N	\N	\N	\N	I was shaking. I’ve never said that to anyone before.	That sounds like it took a lot of courage. What did you expect might happen when you told him?	\N	\N	\N	\N	\N	\N
cf195ca9-9e42-43b7-8662-12023d9286ac	\N	\N	\N	\N	I hoped he’d say it back—or at least something more than “I’m not sure.”	Yeah, that must have left you wondering what he really meant. What do you think “not sure” means coming from him?	\N	\N	\N	\N	\N	\N
277af786-9f86-4988-aa9b-5bb32d17e4fe	\N	\N	\N	\N	I honestly don’t know. I’ve been trying to guess ever since.	That sounds exhausting—to hold all that uncertainty by yourself. Would it help to explore what you need right now, regardless of what he’s feeling?	\N	\N	\N	\N	\N	\N
a7d58d8a-1c8c-4004-955c-9bf107b64eb6	\N	\N	\N	\N	Yeah… I just don’t know what to do next.	You’ve got a few options. Would you like to:	\N	\N	\N	\N	\N	\N
e74003f8-c402-4af3-abd1-e346c95850ac	\N	\N	\N	\N	\N	– Give yourself space from him for a few days to clear your thoughts?	\N	\N	\N	\N	\N	\N
b84cddcf-a7b3-4bdf-a56b-f81c78159db4	\N	\N	\N	\N	\N	– Talk to him again and ask for more clarity about where he stands?	\N	\N	\N	\N	\N	\N
5aa2f712-e03f-4c8f-98ba-22b148713463	\N	\N	\N	\N	\N	– Focus on writing down what you want from a relationship, with or without him in it?	\N	\N	\N	\N	\N	\N
e8482225-0c54-4a46-adfc-36370fbf8d00	\N	\N	\N	\N	\N	Which of these feels right for where you are, or is there something else you’re thinking?	\N	\N	\N	\N	\N	\N
ea1eb8b2-e698-47fd-8f55-66ceed0b32c7	\N	\N	\N	\N	I think I want space. I need to reset.	That sounds like a wise move. Giving yourself space lets you listen to your own voice.	\N	\N	\N	\N	\N	\N
d9cabfc6-48e0-4421-901d-d864ec016d3b	\N	\N	\N	\N	I want to ask them next time—what do they actually mean?	That’s powerful. Curiosity instead of defensiveness creates room for change.	\N	\N	\N	\N	\N	\N
2c6dd754-4d15-4594-b0e1-758c701311f3	\N	\N	\N	\N	\N	And just so you know—putting yourself out there doesn’t mean you failed. Vulnerability is a form of strength, even if it feels raw. The “not sure” response says more about where he is than who you are.	\N	\N	\N	\N	\N	\N
cd997082-c6db-4a52-a9ba-db27ad447ec2	\N	P004	\N	\N	Lately my mom keeps checking my phone. I feel like I can’t breathe.	That sounds really invasive. What’s it like for you when that happens?	\N	\N	\N	\N	\N	\N
a75b4564-0e24-4d15-860f-a988b98d64b9	\N	\N	\N	\N	I just freeze. I don’t even want to be home.	What do you think she’s hoping to find—or afraid she’ll miss?	\N	\N	\N	\N	\N	\N
96dee2fd-2cdd-4ee4-b628-8231723b06f1	\N	\N	\N	\N	I think she’s just paranoid. I’ve never given her a reason to not trust me.	Would it help to explore how you might tell her how this makes you feel, or what kind of boundaries feel fair?	\N	\N	\N	\N	\N	\N
073ddac8-eadf-41a8-90d1-fe06c424dbb9	\N	\N	\N	\N	Maybe. But she gets super defensive.	Let’s think of what you can do next. Would you like to:	\N	\N	\N	\N	\N	\N
a067a68c-a581-4a13-a96b-070b15bd5d1b	\N	\N	\N	\N	\N	Write down how this is impacting your trust and share it with her calmly?	\N	\N	\N	\N	\N	\N
b5d825ef-1fb5-4140-a841-a42d9e18971b	\N	\N	\N	\N	\N	Or ask for a time to talk when things are not heated?	\N	\N	\N	\N	\N	\N
d3f6a3b2-e8c8-47f1-bad6-7b26098174fe	\N	\N	\N	\N	\N	Or talk to another adult first to help mediate?	\N	\N	\N	\N	\N	\N
8ae2cbbb-71f3-4e7d-adfc-eabcbb7f1bfa	\N	\N	\N	\N	I think writing it out first will help.	Good choice. It gives you a way to clarify your voice before reacting.	\N	\N	\N	\N	\N	\N
7734684b-3903-4503-9c2e-3298e16ee423	\N	\N	\N	\N	\N	Sometimes, when parents fear losing control, they try to micromanage. But trust grows from mutual respect, not surveillance.	\N	\N	\N	\N	\N	\N
311ce4d1-5a8d-4f80-8af3-4a57ffb4820c	\N	P004	\N	\N	My dad keeps comparing me to my older brother. I can’t take it anymore.	That sounds heavy. What’s the impact on you when those comparisons happen?	\N	\N	\N	\N	\N	\N
d964b761-d9af-4424-8499-e948f4bd0c47	\N	\N	\N	\N	I feel like I’ll never be enough.	What do you think your dad sees in your brother that he doesn’t acknowledge in you?	\N	\N	\N	\N	\N	\N
2182f87f-95e9-4947-b733-b1cf25b47443	\N	\N	\N	\N	Like he’s the “successful one,” and I’m just the “lazy one.”	That must hurt. Would it help to find a way to express your own strengths—or to tell your dad how these comparisons affect your motivation?	\N	\N	\N	\N	\N	\N
7b82dc9d-c98f-4b06-b55c-eaa2db8cdc7c	\N	\N	\N	\N	Maybe both. I want him to see *me*.	Would you like to:	\N	\N	\N	\N	\N	\N
26a6ca40-e64d-4551-a29c-583e93890c74	\N	\N	\N	\N	\N	– Write or speak directly to your dad about how this makes you feel?	\N	\N	\N	\N	\N	\N
19cfc510-2feb-4247-b3f0-4668b75d1e5a	\N	\N	\N	\N	\N	– Ask for help from someone else in the family to communicate this?	\N	\N	\N	\N	\N	\N
b0940dc1-fdf9-413c-8408-eaf9f73ee543	\N	\N	\N	\N	\N	– Focus for now on what makes you proud of yourself—and share that?	\N	\N	\N	\N	\N	\N
65ac37d9-e349-4c69-bf4b-e85d09dab2e2	\N	\N	\N	\N	I think I want to tell him straight up.	That kind of directness takes guts—and clarity.	\N	\N	\N	\N	\N	\N
7ee71e8a-636f-4dbe-af1e-ee0d62bbeccc	\N	\N	\N	\N	\N	Parents often compare as a way of motivating, but it can backfire. Emotional identity needs to be nurtured separately, not competitively.	\N	\N	\N	\N	\N	\N
2a8c290c-786d-41e1-9d3a-e3d8da0b21e0	\N	P004	\N	\N	My parents are getting divorced and they keep putting me in the middle.	It sounds like you’re stuck between two people you care about, being pulled in both directions.	\N	\N	\N	\N	\N	\N
2ab964a3-b6b4-4039-a348-e02370b66874	\N	\N	\N	\N	Exactly. They both want me to “take their side.”	What’s it like for you to hear their arguments or complaints about each other?	\N	\N	\N	\N	\N	\N
9d96afb2-97e8-4e98-8150-6b7bdfe02662	\N	\N	\N	\N	It just makes me want to disappear.	That’s a lot to carry. Want to talk through ways to protect your space while still caring for both of them?	\N	\N	\N	\N	\N	\N
b90bafeb-20ee-4cf2-a3bc-bcda06c366a2	\N	\N	\N	\N	Yeah. I don’t want to hurt either of them.	Here are a few options:	\N	\N	\N	\N	\N	\N
b3dd25d7-eb4c-4e4c-b17b-9d5048cc4fba	\N	\N	\N	\N	– Set a clear boundary like, “I can’t be the one to solve this—it’s between you two.”	You can set a clear boundary like, “I can’t be the one to solve this—it’s between you two.”	\N	\N	\N	\N	\N	\N
80ca5d44-6507-48d5-bbfe-4464da3c6166	\N	\N	\N	\N	– Ask a trusted adult or counselor to help you say that if it feels too hard alone.	Or you can ask a trusted adult or counselor to help you say that if it feels too hard alone.	\N	\N	\N	\N	\N	\N
80458153-e20b-400f-8667-c07ff0c7dc2d	\N	\N	\N	\N	– Limit conversations when they become about the other parent.	Or you can limit conversations when they become about the other parent.	\N	\N	\N	\N	\N	\N
07102daa-060a-44c7-bf10-ea4b8df87095	\N	\N	\N	\N	I think I need help saying it.	That’s wise. Support makes boundary-setting stronger.	\N	\N	\N	\N	\N	\N
454455df-1e8a-4e3a-9f25-5464b56fb4cf	\N	\N	\N	\N	\N	Kids should never be used as emotional referees. Divorce is hard enough—your job is to feel safe, not split.	\N	\N	\N	\N	\N	\N
c5e694b3-2c3f-426a-b90b-fb3fbce825fc	\N	P004	\N	\N	I told my mom I want to take a gap year before college and she flipped out.	That sounds intense. What was her reaction like?	\N	\N	\N	\N	\N	\N
a6d05461-7fe4-42cf-8b68-a54829199069	\N	\N	\N	\N	She said I was wasting my future.	What do "you" want out of the gap year? What’s driving your decision?	\N	\N	\N	\N	\N	\N
779b03fb-ffc5-4062-89a1-3b8f1424fb28	\N	\N	\N	\N	I want to breathe. I’ve been in school nonstop since I was five.	I hear that. Would it help to explore how you can express that desire in a way she might understand?	\N	\N	\N	\N	\N	\N
6f301514-9aff-4405-99bd-be5a62e80fae	\N	\N	\N	\N	Maybe. But she only sees academics as success.	Would you like to:	\N	\N	\N	\N	\N	\N
47fea657-78a6-4820-95e9-ac306ffaa0af	\N	\N	\N	\N	– Make a plan to show her how your year will include growth, not just rest?	Make a plan to show her how your year will include growth, not just rest?	\N	\N	\N	\N	\N	\N
ac895d0e-bf15-4543-943a-423a2e311b44	\N	\N	\N	\N	– Ask to talk with someone she trusts (like a teacher or mentor) who supports your idea?	Or ask to talk with someone she trusts (like a teacher or mentor) who supports your idea?	\N	\N	\N	\N	\N	\N
fdd9869a-ddc5-4ecf-9285-27da4a2e9816	\N	\N	\N	\N	– Delay the conversation for a bit and build your confidence first?	Or would you prefer to delay the conversation for a bit and build your confidence first?	\N	\N	\N	\N	\N	\N
cb57d324-0165-4476-8a61-4bc605ba892d	\N	\N	\N	\N	I want to make a plan to show her.	That’s a smart step. Sometimes people fear what they don’t understand until they see structure.	\N	\N	\N	\N	\N	\N
bbd82b46-147f-4005-8509-1617a46947bd	\N	\N	\N	\N	\N	A gap year, when used intentionally, can increase maturity, resilience, and even motivation for future studies.	\N	\N	\N	\N	\N	\N
a7e34d52-0e71-4c36-959a-4efac669e876	\N	P004	\N	\N	My parents always say “you’re so emotional” like it’s a bad thing.	It sounds like that label has become a way to shut you down. How does it feel when they say that?	\N	\N	\N	\N	\N	\N
66798c5a-8a49-45b8-8bff-231445511ff1	\N	\N	\N	\N	I feel like there’s something wrong with me.	What do you think they mean when they say “emotional”? What’s behind that word for them?	\N	\N	\N	\N	\N	\N
49b1c07c-1e62-4499-ae91-93106a242b6e	\N	\N	\N	\N	I guess they don’t like it when I cry or get upset.	Would it help to talk about the role emotions actually play in communication—or to show them how labeling shuts you down?	\N	\N	\N	\N	\N	\N
2a2b2c23-e4ba-4125-8f86-6284c4d27cd6	\N	\N	\N	\N	Maybe both. I want to stop being afraid to feel.	Would you like to:	\N	\N	\N	\N	\N	\N
34697d86-f743-4bed-a01e-242e75af0ddd	\N	\N	\N	\N	– Start journaling or talking about your emotions more openly, even if they don't always respond well?	Start journaling or talking about your emotions more openly, even if they don't always respond well?	\N	\N	\N	\N	\N	\N
dc164a86-4b6c-41b0-8c9e-956b304599a9	\N	\N	\N	\N	– Ask them, “What do you mean when you say that?” next time it happens, to open the door?	Ask them, “What do you mean when you say that?” next time it happens, to open the door?	\N	\N	\N	\N	\N	\N
23dd6131-a3c7-46be-999d-4de2b461c582	\N	\N	\N	\N	– Share something about emotional health and how it's part of being strong—not weak?	Share something about emotional health and how it's part of being strong—not weak?	\N	\N	\N	\N	\N	\N
ec2678c4-8afd-4018-bfa7-000f113f9132	\N	\N	\N	\N	\N	Being emotionally aware is not a flaw—it’s a superpower, especially when you learn how to name and use those feelings with clarity.	\N	\N	\N	\N	\N	\N
bd880f21-8a0e-4ef0-bcb2-5be05171a083	\N	P004	\N	\N	His mom invited me to a family dinner. I said yes, but now I’m freaking out.	That sounds like a big step. What’s making you feel nervous about it?	\N	\N	\N	\N	\N	\N
568e354e-dbbd-437a-9edc-725f4950640b	\N	\N	\N	\N	What if they don’t like me? What if I say something wrong?	What are you imagining could happen that would feel the most uncomfortable?	\N	\N	\N	\N	\N	\N
e646e443-e074-4cea-94ae-4bd0a1d1e9d2	\N	\N	\N	\N	That I’ll embarrass myself or he’ll see I’m not good enough.	Would it help to explore what parts of this dinner you can prepare for, and what you might let go of?	\N	\N	\N	\N	\N	\N
09c14a72-fd8a-4d40-a3a9-992f9c312b52	\N	\N	\N	\N	Maybe. I want to feel more in control of the situation.	Here are a few options:	\N	\N	\N	\N	\N	\N
e0d54950-6106-4e2b-bf12-24e710463b85	\N	\N	\N	\N	\N	– Talk with him about what to expect and what his parents are like.	\N	\N	\N	\N	\N	\N
a733eefe-4d0d-4836-a3ae-468bbba95251	\N	\N	\N	\N	\N	– Set a goal for yourself, like, “I’ll be kind and honest—that’s enough.”	\N	\N	\N	\N	\N	\N
24052280-d60a-4b20-aa49-ab2d1e220b66	\N	\N	\N	\N	\N	– Do a mock conversation with a friend to shake off nerves.	\N	\N	\N	\N	\N	\N
69609291-9ef1-4604-b846-1bb16db6f6fe	\N	\N	\N	\N	\N	Which of those would help you feel a little steadier?	\N	\N	\N	\N	\N	\N
40b4cde6-de6f-4669-a8fd-54a8896f1821	\N	\N	\N	\N	I want to ask him more about his family and what to expect.	Great choice. Feeling prepared gives your nervous system a sense of safety.	\N	\N	\N	\N	\N	\N
f044996f-27c9-4c51-827f-869cf4375394	\N	\N	\N	\N	\N	Meeting the family often brings up fears of judgment, but it’s also a chance to be yourself—at your pace.	\N	\N	\N	\N	\N	\N
05f476c5-7804-4964-9fa5-7f324aa1b555	\N	P004	\N	\N	I think he’s going to propose, and I’m panicking.	It sounds like a lot is coming up for you. What makes you think that?	\N	\N	\N	\N	\N	\N
393bc878-a164-4bb4-8f4f-613ea6200aca	\N	\N	\N	\N	He keeps hinting at “the next step,” and I just freeze.	I hear that. What does “marriage” bring up for you emotionally right now?	\N	\N	\N	\N	\N	\N
5d7df05a-a013-4fae-a233-84ad44da9f1d	\N	\N	\N	\N	Pressure. Like this is all happening too fast.	Would it help to explore how to talk with him about your pace and comfort without hurting the relationship?	\N	\N	\N	\N	\N	\N
2da832f1-e410-4c61-9e00-1d21405844b6	\N	\N	\N	\N	Yeah. But I don’t know how to say it.	Let’s brainstorm some ways. Would you like to:	\N	\N	\N	\N	\N	\N
05127c7f-4282-43df-94df-e2f5cdc72dad	\N	\N	\N	\N	– Start with a statement like, “I care about you deeply, and I need to move more slowly”?	Start with a statement like, “I care about you deeply, and I need to move more slowly”?	\N	\N	\N	\N	\N	\N
e411eec9-4561-4a9b-b70c-25e9a38a73c0	\N	\N	\N	\N	– Ask for a pause to reflect together about the future?	Or would you prefer to ask for a pause to reflect together about the future?	\N	\N	\N	\N	\N	\N
5c609a58-6998-4709-a1c3-a40b296587be	\N	\N	\N	\N	– Talk to someone else first to sort your feelings?	Or talk to someone else first to sort your feelings?	\N	\N	\N	\N	\N	\N
a8299c09-791a-40c1-baee-c75a64f6ed4a	\N	\N	\N	\N	I want to try the first one. Say it gently.	Perfect. Expressing clarity with warmth helps build trust, not break it.	\N	\N	\N	\N	\N	\N
4c1ec65b-9bd4-4d0f-95fc-358f04a0bf8f	\N	\N	\N	\N	\N	Big milestones like marriage can stir up anxiety—even in good relationships. Going slow doesn’t mean “no.” It means respecting your timing.	\N	\N	\N	\N	\N	\N
94e15247-4fa8-4319-bd2b-f05dae4358cc	\N	P004	\N	\N	She said “I love you,” and I panicked. I didn’t say it back.	That sounds like it caught you off guard. What was your first reaction inside?	\N	\N	\N	\N	\N	\N
b1d34616-68d1-4536-b8fe-ab30d851b38f	\N	\N	\N	\N	I froze. Not because I don’t care, but because it felt too soon.	What does “I love you” mean to you at this point in a relationship?	\N	\N	\N	\N	\N	\N
f96cac39-6061-4d75-a9bc-9498d57fe335	\N	\N	\N	\N	Commitment. Depth. And I’m not quite there yet.	Would it help to explore ways to stay honest without pushing her away?	\N	\N	\N	\N	\N	\N
91906c2b-8de8-4612-8f44-010b442fc337	\N	\N	\N	\N	Yes, because I do care a lot.	Here are some ways to make you feel more in control:	\N	\N	\N	\N	\N	\N
cbfbcc05-e426-4e6c-99cd-877e6d15c41c	\N	\N	\N	\N	– Acknowledge her feelings with gratitude and share where you’re at: “I really care about you and I’m still growing into those words.”	You could acknowledge her feelings with gratitude and share where you’re at by saying something like: “I really care about you and I’m still growing into those words.”	\N	\N	\N	\N	\N	\N
77a2b05f-957d-432c-a8a1-ca68f903c47d	\N	\N	\N	\N	– Suggest revisiting the conversation when it feels right.	You can suggest revisiting the conversation when it feels right.	\N	\N	\N	\N	\N	\N
49858348-130e-460a-b39f-dcdb21706cfe	\N	\N	\N	\N	– Talk about what love means to each of you.	Or you can talk about what love means to each of you.	\N	\N	\N	\N	\N	\N
a1446cbb-8e1c-48d8-ab9c-20daea706b98	\N	\N	\N	\N	What would feel most authentic to you?	What would feel most authentic to you?	\N	\N	\N	\N	\N	\N
9bcb221a-b4b1-42e2-874b-5f6db7c69110	\N	\N	\N	\N	I want to be honest but kind. Maybe say I’m still catching up emotionally.	That’s thoughtful. Emotional timing doesn’t always sync up—and that’s okay.	\N	\N	\N	\N	\N	\N
0ad77d48-b60c-4be4-b46f-063676d1bb46	\N	\N	\N	\N	\N	Love isn’t a race. It’s a dialogue. The healthiest relationships allow room to grow into the words.	\N	\N	\N	\N	\N	\N
e8c43406-1156-4844-b15c-af604d405059	\N	P004	\N	\N	He wants to move in together, but I’m not sure I’m ready.	That’s a big transition. What makes you unsure right now?	\N	\N	\N	\N	\N	\N
d32af5e1-cb80-4689-b0b6-8a0d6c3cac16	\N	\N	\N	\N	I like having my own space. And I’m afraid of what might change.	What part of your independence feels most important to protect?	\N	\N	\N	\N	\N	\N
a58246df-7d67-4d0b-a80a-09d163418c97	\N	\N	\N	\N	Having a place to recharge. I need that time alone.	Would it help to explore whether there’s a way to keep that, even if the relationship deepens?	\N	\N	\N	\N	\N	\N
4aaf829c-6607-4600-bebc-1cbab5173084	\N	\N	\N	\N	Maybe. I just don’t want to lose myself.	Here are some options of what you can do	\N	\N	\N	\N	\N	\N
f2fdc54a-a974-4486-87ab-9b040ee5a087	\N	\N	\N	\N	– Talk to him about a trial weekend or shared routine before a full move.	You can talk to him about a trial weekend or shared routine before a full move.	\N	\N	\N	\N	\N	\N
0639de4f-0e5e-4fa5-9989-71cbb5b19e0f	\N	\N	\N	\N	– Explore a shared living arrangement where you each still have alone time.	You can explore a shared living arrangement where you each still have alone time.	\N	\N	\N	\N	\N	\N
27aa0585-1d77-4baf-a26b-a801dcb6df2f	\N	\N	\N	\N	– Consider keeping separate places longer and checking in about it later.	You can consider keeping separate places longer and checking in about it later.	\N	\N	\N	\N	\N	\N
33f8479c-d826-4aad-b4ba-5d3e97e17f6c	\N	\N	\N	\N	Which of these might feel like a starting point?	Which of these might feel like a good starting point for you?	\N	\N	\N	\N	\N	\N
2fa3921e-ab21-4723-b390-3e281e74a05b	\N	\N	\N	\N	Maybe the trial idea. I want to see how it feels.	That’s a wise step. Trying something small before a big leap lets you stay connected *and* grounded.	\N	\N	\N	\N	\N	\N
e0a2ff3f-a685-4593-8d71-c698c8d2adfd	\N	\N	\N	\N	\N	Moving in is not just about logistics—it’s about emotional rhythm. Make sure both of yours are heard.	\N	\N	\N	\N	\N	\N
e2e1c6d8-93b6-4bc8-b78e-63ab05a91293	\N	P004	\N	\N	I don’t know if I want to stay in this relationship, but I feel bad leaving.	That sounds painful. What’s keeping you from making a decision?	\N	\N	\N	\N	\N	\N
d741a1b7-af91-4e46-a29a-0c54de743f66	\N	\N	\N	\N	I care about them. But I also feel stuck.	What do you feel when you imagine staying—and when you imagine leaving?	\N	\N	\N	\N	\N	\N
8978531e-59e2-4748-87d6-c61f6f43de52	\N	\N	\N	\N	Staying feels heavy. Leaving feels guilty.	Would it help to sort through whether you’re staying for love, or out of fear of hurting someone?	\N	\N	\N	\N	\N	\N
a2ab1be0-8918-4b85-a45d-28ace4a3e734	\N	\N	\N	\N	Yeah. I’ve been avoiding that.	Here are a few next steps you could try:	\N	\N	\N	\N	\N	\N
fdecb4fc-e854-49e1-b02e-5f327203cd76	\N	\N	\N	\N	\N	– Journal about what you want and need, apart from anyone else., then see if you can assess which is stronger. writing something can often offer clarity.	\N	\N	\N	\N	\N	\N
084625c7-b5e5-47ea-a8b1-b4ff204ca8c6	\N	\N	\N	\N	\N	Or, you can sit and talk with a friend that you trust, do the same thing and then ask them to repeat it for you - hearing someone else saying it can help you see the situation more clearly.	\N	\N	\N	\N	\N	\N
6cb93f5b-89fc-4db7-845d-494ee9508c9f	\N	\N	\N	\N	\N	what would you prefer?	\N	\N	\N	\N	\N	\N
4985de39-0777-406a-ad53-f6ec2a593883	\N	\N	\N	\N	Maybe journaling. I don’t know what I feel yet.	That’s a solid start. Giving yourself space to listen inward is the first sign of self-respect.	\N	\N	\N	\N	\N	\N
28a02606-a755-4e62-9f99-b5e3e0175845	\N	\N	\N	\N	\N	remember, Relationships end sometimes—not out of failure, but because people grow. The goal is clarity, not guilt.	\N	\N	\N	\N	\N	\N
23ea3962-0e4c-44b7-8ce5-18f9c709a61d	\N	P004	\N	\N	I get anxious when he doesn’t text me back right away. My mind goes wild.	That sounds really overwhelming. What do you notice happens in your body or thoughts when that happens?	\N	\N	\N	\N	\N	\N
6d90e202-10c1-4b99-a51f-fc23597dcb75	\N	\N	\N	\N	My chest tightens and I start imagining he’s mad or losing interest.	What do you think those thoughts are trying to protect you from?	\N	\N	\N	\N	\N	\N
7a524df5-e47c-45c5-8278-1727251a9785	\N	\N	\N	\N	Probably rejection. I’ve been ghosted before.	Would it help to explore ways to manage the anxiety in the moment, and talk to him about how communication affects you?	\N	\N	\N	\N	\N	\N
15142343-b493-4387-a1bc-25d9a38e8f83	\N	\N	\N	\N	Yeah. But I don’t want to sound clingy.	Here are a few options:	\N	\N	\N	\N	\N	\N
9edab750-6212-4d12-be3b-7334bc8a4ced	\N	\N	\N	\N	\N	– Practice grounding techniques when the urge to overthink hits.	\N	\N	\N	\N	\N	\N
962ce9e2-66a3-4742-9df2-e1a1452b8158	\N	\N	\N	\N	I want to ask him about texting expectations.	That’s a great way to build clarity.	\N	\N	\N	\N	\N	\N
fc20ff58-8c4a-4c1f-a222-d3d1105b83e7	\N	\N	\N	\N	\N	Our brains react to uncertainty like danger, especially if we've been hurt before. Healthy communication can soothe those old alarms.	\N	\N	\N	\N	\N	\N
05eb035b-82a3-48c3-9b5a-ee446d0d086c	\N	P004	\N	\N	She shares everything with her ex and says they’re “just friends.” It bothers me.	That sounds like a tough spot. What feels hardest about it for you?	\N	\N	\N	\N	\N	\N
1fc73529-3613-4435-a776-7d9eab7bba12	\N	\N	\N	\N	It’s like she tells him things before me. I feel pushed aside.	What do you think that dynamic says about what you need in a relationship?	\N	\N	\N	\N	\N	\N
fae5c4b6-d7d2-4839-aa08-0d2801544ec0	\N	\N	\N	\N	I need to feel like I’m the one she leans on.	Would you like to explore ways to talk to her about your needs without making demands?	\N	\N	\N	\N	\N	\N
d5bbabb7-cf66-4ca4-ba6b-c067ffadfc31	\N	\N	\N	\N	Yeah, I want to say something without sounding jealous.	Here are some ideas:	\N	\N	\N	\N	\N	\N
36d706ce-5340-4482-92bd-c379814a40b9	\N	\N	\N	\N	\N	– Ask her gently, “Can we talk about how much you share with your ex?”	\N	\N	\N	\N	\N	\N
e153f16c-f4f7-440b-8d35-93d6331930ff	\N	\N	\N	\N	I’ll try asking to talk. I want to be honest.	Honesty with care builds real intimacy.	\N	\N	\N	\N	\N	\N
518b7d43-c67f-443d-83eb-4ec939b698bd	\N	\N	\N	\N	\N	remember, Past relationships can linger in subtle ways, but current ones deserve clear space and priority.	\N	\N	\N	\N	\N	\N
d3cb305e-4f69-424d-a3d3-fcf7fe9f31b7	\N	P004	\N	\N	He jokes in public about things I told him in private. It makes me shut down.	That must feel like your trust is being exposed. What’s it like for you when that happens?	\N	\N	\N	\N	\N	\N
e1b4afe2-5383-4216-8f68-bdb98b6766cb	\N	\N	\N	\N	I feel stupid and betrayed. Like I can't relax around him anymore.	Do you think he understands the impact of those comments?	\N	\N	\N	\N	\N	\N
473e1ea3-b470-47db-9d6c-fe8aeea9e554	\N	\N	\N	\N	No. He says I’m “too sensitive.”	Would you like help thinking through how to set a boundary that protects your voice?	\N	\N	\N	\N	\N	\N
429e8942-25d8-430b-b83d-d929ede48460	\N	\N	\N	\N	Yes, please. I don’t want to keep quiet about this.	Here are some ways to take control:	\N	\N	\N	\N	\N	\N
5b3e921b-b6da-4f09-a875-aa326adb6f72	\N	\N	\N	\N	\N	– Say something like, “When you share private things as jokes, I feel unsafe.”	\N	\N	\N	\N	\N	\N
1c136462-b24f-4c83-abd3-28014a5736ab	\N	\N	\N	\N	\N	Which approach feels most true to you?	\N	\N	\N	\N	\N	\N
65f39b45-0edf-4381-a480-5c640bf7f01a	\N	\N	\N	\N	Maybe the first. I want to say how it made me feel.	That’s a strong start.	\N	\N	\N	\N	\N	\N
5fa593c3-1ae4-4c7c-8a67-90f64c973fc3	\N	\N	\N	\N	\N	Emotional safety is just as important as physical safety. Jokes that cross trust lines aren't harmless—they chip away at closeness.	\N	\N	\N	\N	\N	\N
22c8e6e8-5b92-4a40-be5a-69cd886b9af4	\N	P004	\N	\N	She said she needed space, but I don’t know what that means. Is it over?	It’s hard sitting in the unknown. What do you think she meant by “space”?	\N	\N	\N	\N	\N	\N
fdfbc162-0a21-4f50-a1ec-c92ea14c7a1d	\N	\N	\N	\N	I honestly don’t know. She didn’t explain.	What’s your gut telling you right now about what you need?	\N	\N	\N	\N	\N	\N
c9602418-3c94-41e3-bf01-8d8f5504ca1e	\N	\N	\N	\N	I want to respect her, but I’m spiraling.	Here are some options of what you could do:	\N	\N	\N	\N	\N	\N
04846c0c-eab6-46c7-8812-776879d509cb	\N	\N	\N	\N	– Ask her to clarify what “space” means to her?	Ask her to clarify what “space” means to her?	\N	\N	\N	\N	\N	\N
fae664c1-9320-4d26-843d-f973ad5af964	\N	\N	\N	\N	– Focus on your own needs right now and create a self-care plan?	Focus on your own needs right now and create a self-care plan?	\N	\N	\N	\N	\N	\N
17317426-4ec1-411d-b441-9f97e28bff18	\N	\N	\N	\N	– Talk to someone neutral to help ground yourself?	Talk to someone neutral to help ground yourself?	\N	\N	\N	\N	\N	\N
75ea86c3-39c6-41c6-9883-d1c4f19e0ebf	\N	\N	\N	\N	I think I need to ask her directly.	That shows strength. Asking for clarity helps you stop guessing and start breathing.	\N	\N	\N	\N	\N	\N
4c32777a-b42e-4847-93be-e9cbdbafacf8	\N	\N	\N	\N	\N	“Space” can mean many things. What matters is how each person defines it—and whether both feel respected.	\N	\N	\N	\N	\N	\N
3105ea4f-d7fc-4196-964b-7647bdefae20	\N	P004	\N	\N	I feel like I’m always the one initiating everything in this relationship.	That sounds exhausting. What does it feel like to carry most of the effort?	\N	\N	\N	\N	\N	\N
f5a1d934-bfcb-4def-96a7-330e6fc42a9f	\N	\N	\N	\N	Like I care more than they do. It’s starting to wear me down.	What do you think is behind their lack of effort—or how do you interpret it?	\N	\N	\N	\N	\N	\N
7ae2e682-e4ba-46ac-95be-4367f26719f6	\N	\N	\N	\N	I’m not sure. I just know I feel alone in this.	Would you like to explore how to share your need for balance—or decide if this is the right dynamic for you?	\N	\N	\N	\N	\N	\N
8554f446-3753-4cef-b196-b9a716d54fda	\N	\N	\N	\N	Yes, I need to speak up.	Here are some choices:	\N	\N	\N	\N	\N	\N
af703e81-9db0-432d-8939-e717d860e36c	\N	\N	\N	\N	\N	You could say something like: “I’ve noticed I’m doing a lot of the work—can we talk about that?”	\N	\N	\N	\N	\N	\N
9358cf40-825d-4cae-9ffb-a235933c83c1	\N	\N	\N	\N	\N	Or you could pause your initiating and see what happens.	\N	\N	\N	\N	\N	\N
fdb3397f-5117-47c0-8229-2d6a471121c1	\N	\N	\N	\N	\N	Or you could reflect on whether this pattern has shown up in other relationships, too.	\N	\N	\N	\N	\N	\N
350edcba-7c53-42df-bd44-735611ab7aee	\N	\N	\N	\N	\N	Which step feels right for now?	\N	\N	\N	\N	\N	\N
063284c5-c7a4-4252-981c-19f176ab126d	\N	\N	\N	\N	Maybe I’ll speak up and take a little step back too.	That’s a good balance.	\N	\N	\N	\N	\N	\N
1787d889-65e5-41a8-9250-d3d9a635c3b5	\N	\N	\N	\N	\N	Mutual effort is part of healthy connection. If love only flows one way, it starts to feel like work instead of warmth.	\N	\N	\N	\N	\N	\N
79fc6bf8-b091-49bc-a380-14bac94500f4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
eaca111e-a3fe-4f84-8faa-803873e7144c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types", "owner_id", "type") FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."buckets_analytics" ("name", "type", "format", "created_at", "updated_at", "id", "deleted_at") FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."buckets_vectors" ("id", "type", "created_at", "updated_at") FROM stdin;
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version", "owner_id", "user_metadata") FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."s3_multipart_uploads" ("id", "in_progress_size", "upload_signature", "bucket_id", "key", "version", "owner_id", "created_at", "user_metadata") FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."s3_multipart_uploads_parts" ("id", "upload_id", "size", "part_number", "bucket_id", "key", "etag", "owner_id", "version", "created_at") FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY "storage"."vector_indexes" ("id", "name", "bucket_id", "data_type", "dimension", "distance_metric", "metadata_configuration", "created_at", "updated_at") FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 194, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict eExbfGlpsLCMi1UM8lcuububVRT4MoOZ3OSIVgqi2tkzhDuWEYJsrBzPfZ0BPex

RESET ALL;
