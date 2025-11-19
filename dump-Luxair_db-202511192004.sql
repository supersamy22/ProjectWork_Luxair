--
-- PostgreSQL database dump
--

\restrict agEMbas0lnMWGihSxtCgSjDC3Td3D5aAMSBfCBNfVbk1rnahlG1WSc1TDv0JUwV

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-11-19 20:04:09

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 17690)
-- Name: aereo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aereo (
    aircraftid integer NOT NULL,
    modello character varying(50) NOT NULL,
    numeromatricola character varying(20) NOT NULL,
    capacitaposti integer NOT NULL,
    tipo character varying(20)
);


ALTER TABLE public.aereo OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 17675)
-- Name: aeroporto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aeroporto (
    airportid integer NOT NULL,
    nome character varying(50) NOT NULL,
    citta character varying(50) NOT NULL,
    paese character varying(50) NOT NULL,
    codiceiata character(3) NOT NULL,
    codiceicao character(4) NOT NULL
);


ALTER TABLE public.aeroporto OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 17787)
-- Name: biglietto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.biglietto (
    ticketid integer NOT NULL,
    bookingid integer NOT NULL,
    flightid integer NOT NULL,
    pnr character varying(10) NOT NULL,
    classe character varying(20) NOT NULL,
    statobiglietto character varying(20) NOT NULL,
    bagaglioincluso character varying(50),
    serviziextra text,
    passengerid integer
);


ALTER TABLE public.biglietto OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 17848)
-- Name: checkin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.checkin (
    checkinid integer NOT NULL,
    ticketid integer NOT NULL,
    tipocheckin character varying(20) NOT NULL,
    datacheckin timestamp without time zone NOT NULL,
    postoassegnato integer,
    cartaimbarcogenerata boolean DEFAULT false,
    numeroposto character varying(5)
);


ALTER TABLE public.checkin OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 17770)
-- Name: flightcrew; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flightcrew (
    flightid integer NOT NULL,
    crewid integer NOT NULL
);


ALTER TABLE public.flightcrew OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 17817)
-- Name: pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pagamento (
    paymentid integer NOT NULL,
    ticketid integer NOT NULL,
    metodopagamento character varying(20) NOT NULL,
    datapagamento timestamp without time zone NOT NULL,
    importo numeric(10,2) NOT NULL,
    statopagamento character varying(20) NOT NULL
);


ALTER TABLE public.pagamento OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 17625)
-- Name: passeggero; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.passeggero (
    passengerid integer NOT NULL,
    nome character varying(50) NOT NULL,
    cognome character varying(50) NOT NULL,
    datanascita date NOT NULL,
    email character varying(100) NOT NULL,
    telefono character varying(20),
    fedelta integer DEFAULT 0,
    preferenze text
);


ALTER TABLE public.passeggero OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 17759)
-- Name: personaledibordo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personaledibordo (
    crewid integer NOT NULL,
    nome character varying(50) NOT NULL,
    cognome character varying(50) NOT NULL,
    ruolo character varying(30) NOT NULL,
    certificazioni text
);


ALTER TABLE public.personaledibordo OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 17833)
-- Name: posto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posto (
    seatid integer NOT NULL,
    flightid integer NOT NULL,
    numeroposto character varying(5) NOT NULL,
    classe character varying(20) NOT NULL,
    stato character varying(20) NOT NULL
);


ALTER TABLE public.posto OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 17660)
-- Name: prenotazione; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prenotazione (
    bookingid integer NOT NULL,
    passengerid integer NOT NULL,
    dataprenotazione timestamp without time zone NOT NULL,
    statoprenotazione character varying(20) NOT NULL,
    origineprenotazione character varying(20) NOT NULL
);


ALTER TABLE public.prenotazione OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 17719)
-- Name: scalo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scalo (
    stopoverid integer NOT NULL,
    routeid integer NOT NULL,
    aeroportoid integer NOT NULL,
    oraarrivoprevista timestamp without time zone,
    orapartenzaprevista timestamp without time zone,
    duratastimata time without time zone
);


ALTER TABLE public.scalo OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 17701)
-- Name: tratta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tratta (
    routeid integer NOT NULL,
    aeroportopartenzaid integer NOT NULL,
    aeroportoarrivoid integer NOT NULL,
    distanza numeric(8,2)
);


ALTER TABLE public.tratta OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 17640)
-- Name: utenteapp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utenteapp (
    appuserid integer NOT NULL,
    passengerid integer NOT NULL,
    username character varying(50) NOT NULL,
    passwordhash character varying(255) NOT NULL,
    ultimoaccesso timestamp without time zone,
    preferenzeapp text
);


ALTER TABLE public.utenteapp OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 17737)
-- Name: volo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.volo (
    flightid integer NOT NULL,
    numerovolo character varying(10) NOT NULL,
    routeid integer NOT NULL,
    aircraftid integer NOT NULL,
    datapartenza date NOT NULL,
    orapartenza time without time zone NOT NULL,
    durata time without time zone,
    statovolo character varying(20) NOT NULL
);


ALTER TABLE public.volo OWNER TO postgres;

--
-- TOC entry 5137 (class 0 OID 17690)
-- Dependencies: 223
-- Data for Name: aereo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aereo (aircraftid, modello, numeromatricola, capacitaposti, tipo) FROM stdin;
\.


--
-- TOC entry 5136 (class 0 OID 17675)
-- Dependencies: 222
-- Data for Name: aeroporto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aeroporto (airportid, nome, citta, paese, codiceiata, codiceicao) FROM stdin;
\.


--
-- TOC entry 5143 (class 0 OID 17787)
-- Dependencies: 229
-- Data for Name: biglietto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.biglietto (ticketid, bookingid, flightid, pnr, classe, statobiglietto, bagaglioincluso, serviziextra, passengerid) FROM stdin;
\.


--
-- TOC entry 5146 (class 0 OID 17848)
-- Dependencies: 232
-- Data for Name: checkin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.checkin (checkinid, ticketid, tipocheckin, datacheckin, postoassegnato, cartaimbarcogenerata, numeroposto) FROM stdin;
\.


--
-- TOC entry 5142 (class 0 OID 17770)
-- Dependencies: 228
-- Data for Name: flightcrew; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flightcrew (flightid, crewid) FROM stdin;
\.


--
-- TOC entry 5144 (class 0 OID 17817)
-- Dependencies: 230
-- Data for Name: pagamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pagamento (paymentid, ticketid, metodopagamento, datapagamento, importo, statopagamento) FROM stdin;
\.


--
-- TOC entry 5133 (class 0 OID 17625)
-- Dependencies: 219
-- Data for Name: passeggero; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.passeggero (passengerid, nome, cognome, datanascita, email, telefono, fedelta, preferenze) FROM stdin;
\.


--
-- TOC entry 5141 (class 0 OID 17759)
-- Dependencies: 227
-- Data for Name: personaledibordo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personaledibordo (crewid, nome, cognome, ruolo, certificazioni) FROM stdin;
\.


--
-- TOC entry 5145 (class 0 OID 17833)
-- Dependencies: 231
-- Data for Name: posto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posto (seatid, flightid, numeroposto, classe, stato) FROM stdin;
\.


--
-- TOC entry 5135 (class 0 OID 17660)
-- Dependencies: 221
-- Data for Name: prenotazione; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prenotazione (bookingid, passengerid, dataprenotazione, statoprenotazione, origineprenotazione) FROM stdin;
\.


--
-- TOC entry 5139 (class 0 OID 17719)
-- Dependencies: 225
-- Data for Name: scalo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scalo (stopoverid, routeid, aeroportoid, oraarrivoprevista, orapartenzaprevista, duratastimata) FROM stdin;
\.


--
-- TOC entry 5138 (class 0 OID 17701)
-- Dependencies: 224
-- Data for Name: tratta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tratta (routeid, aeroportopartenzaid, aeroportoarrivoid, distanza) FROM stdin;
\.


--
-- TOC entry 5134 (class 0 OID 17640)
-- Dependencies: 220
-- Data for Name: utenteapp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utenteapp (appuserid, passengerid, username, passwordhash, ultimoaccesso, preferenzeapp) FROM stdin;
\.


--
-- TOC entry 5140 (class 0 OID 17737)
-- Dependencies: 226
-- Data for Name: volo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.volo (flightid, numerovolo, routeid, aircraftid, datapartenza, orapartenza, durata, statovolo) FROM stdin;
\.


--
-- TOC entry 4930 (class 2606 OID 17700)
-- Name: aereo aereo_numeromatricola_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aereo
    ADD CONSTRAINT aereo_numeromatricola_key UNIQUE (numeromatricola);


--
-- TOC entry 4932 (class 2606 OID 17698)
-- Name: aereo aereo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aereo
    ADD CONSTRAINT aereo_pkey PRIMARY KEY (aircraftid);


--
-- TOC entry 4924 (class 2606 OID 17687)
-- Name: aeroporto aeroporto_codiceiata_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeroporto
    ADD CONSTRAINT aeroporto_codiceiata_key UNIQUE (codiceiata);


--
-- TOC entry 4926 (class 2606 OID 17689)
-- Name: aeroporto aeroporto_codiceicao_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeroporto
    ADD CONSTRAINT aeroporto_codiceicao_key UNIQUE (codiceicao);


--
-- TOC entry 4928 (class 2606 OID 17685)
-- Name: aeroporto aeroporto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeroporto
    ADD CONSTRAINT aeroporto_pkey PRIMARY KEY (airportid);


--
-- TOC entry 4949 (class 2606 OID 17799)
-- Name: biglietto biglietto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.biglietto
    ADD CONSTRAINT biglietto_pkey PRIMARY KEY (ticketid);


--
-- TOC entry 4951 (class 2606 OID 17801)
-- Name: biglietto biglietto_pnr_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.biglietto
    ADD CONSTRAINT biglietto_pnr_key UNIQUE (pnr);


--
-- TOC entry 4964 (class 2606 OID 17857)
-- Name: checkin checkin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checkin
    ADD CONSTRAINT checkin_pkey PRIMARY KEY (checkinid);


--
-- TOC entry 4966 (class 2606 OID 17859)
-- Name: checkin checkin_ticketid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checkin
    ADD CONSTRAINT checkin_ticketid_key UNIQUE (ticketid);


--
-- TOC entry 4947 (class 2606 OID 17776)
-- Name: flightcrew flightcrew_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flightcrew
    ADD CONSTRAINT flightcrew_pkey PRIMARY KEY (flightid, crewid);


--
-- TOC entry 4959 (class 2606 OID 17827)
-- Name: pagamento pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento
    ADD CONSTRAINT pagamento_pkey PRIMARY KEY (paymentid);


--
-- TOC entry 4912 (class 2606 OID 17639)
-- Name: passeggero passeggero_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passeggero
    ADD CONSTRAINT passeggero_email_key UNIQUE (email);


--
-- TOC entry 4914 (class 2606 OID 17637)
-- Name: passeggero passeggero_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.passeggero
    ADD CONSTRAINT passeggero_pkey PRIMARY KEY (passengerid);


--
-- TOC entry 4945 (class 2606 OID 17769)
-- Name: personaledibordo personaledibordo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personaledibordo
    ADD CONSTRAINT personaledibordo_pkey PRIMARY KEY (crewid);


--
-- TOC entry 4962 (class 2606 OID 17842)
-- Name: posto posto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posto
    ADD CONSTRAINT posto_pkey PRIMARY KEY (seatid);


--
-- TOC entry 4922 (class 2606 OID 17669)
-- Name: prenotazione prenotazione_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazione
    ADD CONSTRAINT prenotazione_pkey PRIMARY KEY (bookingid);


--
-- TOC entry 4938 (class 2606 OID 17726)
-- Name: scalo scalo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scalo
    ADD CONSTRAINT scalo_pkey PRIMARY KEY (stopoverid);


--
-- TOC entry 4934 (class 2606 OID 17708)
-- Name: tratta tratta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tratta
    ADD CONSTRAINT tratta_pkey PRIMARY KEY (routeid);


--
-- TOC entry 4916 (class 2606 OID 17652)
-- Name: utenteapp utenteapp_passengerid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utenteapp
    ADD CONSTRAINT utenteapp_passengerid_key UNIQUE (passengerid);


--
-- TOC entry 4918 (class 2606 OID 17650)
-- Name: utenteapp utenteapp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utenteapp
    ADD CONSTRAINT utenteapp_pkey PRIMARY KEY (appuserid);


--
-- TOC entry 4920 (class 2606 OID 17654)
-- Name: utenteapp utenteapp_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utenteapp
    ADD CONSTRAINT utenteapp_username_key UNIQUE (username);


--
-- TOC entry 4943 (class 2606 OID 17748)
-- Name: volo volo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volo
    ADD CONSTRAINT volo_pkey PRIMARY KEY (flightid);


--
-- TOC entry 4952 (class 1259 OID 17872)
-- Name: idx_biglietto_passengerid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_biglietto_passengerid ON public.biglietto USING btree (passengerid);


--
-- TOC entry 4953 (class 1259 OID 17875)
-- Name: idx_biglietto_passengerid_flightid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_biglietto_passengerid_flightid ON public.biglietto USING btree (passengerid, flightid);


--
-- TOC entry 4954 (class 1259 OID 17873)
-- Name: idx_biglietto_pnr; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_biglietto_pnr ON public.biglietto USING btree (pnr);


--
-- TOC entry 4955 (class 1259 OID 17874)
-- Name: idx_biglietto_stato; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_biglietto_stato ON public.biglietto USING btree (statobiglietto);


--
-- TOC entry 4967 (class 1259 OID 17877)
-- Name: idx_checkin_numeroposto; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_checkin_numeroposto ON public.checkin USING btree (numeroposto);


--
-- TOC entry 4968 (class 1259 OID 17876)
-- Name: idx_checkin_ticketid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_checkin_ticketid ON public.checkin USING btree (ticketid);


--
-- TOC entry 4956 (class 1259 OID 17884)
-- Name: idx_pagamento_datapagamento; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pagamento_datapagamento ON public.pagamento USING btree (datapagamento);


--
-- TOC entry 4957 (class 1259 OID 17883)
-- Name: idx_pagamento_ticketid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pagamento_ticketid ON public.pagamento USING btree (ticketid);


--
-- TOC entry 4909 (class 1259 OID 17870)
-- Name: idx_passeggero_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_passeggero_email ON public.passeggero USING btree (email);


--
-- TOC entry 4910 (class 1259 OID 17871)
-- Name: idx_passeggero_nomecognome; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_passeggero_nomecognome ON public.passeggero USING btree (nome, cognome);


--
-- TOC entry 4960 (class 1259 OID 17885)
-- Name: idx_posto_flightid_numero; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_posto_flightid_numero ON public.posto USING btree (flightid, numeroposto);


--
-- TOC entry 4935 (class 1259 OID 17882)
-- Name: idx_scalo_aeroportoid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scalo_aeroportoid ON public.scalo USING btree (aeroportoid);


--
-- TOC entry 4936 (class 1259 OID 17881)
-- Name: idx_scalo_routeid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scalo_routeid ON public.scalo USING btree (routeid);


--
-- TOC entry 4939 (class 1259 OID 17879)
-- Name: idx_volo_datapartenza; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_volo_datapartenza ON public.volo USING btree (datapartenza);


--
-- TOC entry 4940 (class 1259 OID 17878)
-- Name: idx_volo_numerovolo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_volo_numerovolo ON public.volo USING btree (numerovolo);


--
-- TOC entry 4941 (class 1259 OID 17880)
-- Name: idx_volo_numerovolo_data; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_volo_numerovolo_data ON public.volo USING btree (numerovolo, datapartenza);


--
-- TOC entry 4979 (class 2606 OID 17802)
-- Name: biglietto biglietto_bookingid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.biglietto
    ADD CONSTRAINT biglietto_bookingid_fkey FOREIGN KEY (bookingid) REFERENCES public.prenotazione(bookingid) ON DELETE CASCADE;


--
-- TOC entry 4980 (class 2606 OID 17807)
-- Name: biglietto biglietto_flightid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.biglietto
    ADD CONSTRAINT biglietto_flightid_fkey FOREIGN KEY (flightid) REFERENCES public.volo(flightid) ON DELETE CASCADE;


--
-- TOC entry 4981 (class 2606 OID 17812)
-- Name: biglietto biglietto_passengerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.biglietto
    ADD CONSTRAINT biglietto_passengerid_fkey FOREIGN KEY (passengerid) REFERENCES public.passeggero(passengerid);


--
-- TOC entry 4984 (class 2606 OID 17865)
-- Name: checkin checkin_postoassegnato_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checkin
    ADD CONSTRAINT checkin_postoassegnato_fkey FOREIGN KEY (postoassegnato) REFERENCES public.posto(seatid);


--
-- TOC entry 4985 (class 2606 OID 17860)
-- Name: checkin checkin_ticketid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checkin
    ADD CONSTRAINT checkin_ticketid_fkey FOREIGN KEY (ticketid) REFERENCES public.biglietto(ticketid) ON DELETE CASCADE;


--
-- TOC entry 4977 (class 2606 OID 17782)
-- Name: flightcrew flightcrew_crewid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flightcrew
    ADD CONSTRAINT flightcrew_crewid_fkey FOREIGN KEY (crewid) REFERENCES public.personaledibordo(crewid) ON DELETE CASCADE;


--
-- TOC entry 4978 (class 2606 OID 17777)
-- Name: flightcrew flightcrew_flightid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flightcrew
    ADD CONSTRAINT flightcrew_flightid_fkey FOREIGN KEY (flightid) REFERENCES public.volo(flightid) ON DELETE CASCADE;


--
-- TOC entry 4982 (class 2606 OID 17828)
-- Name: pagamento pagamento_ticketid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagamento
    ADD CONSTRAINT pagamento_ticketid_fkey FOREIGN KEY (ticketid) REFERENCES public.biglietto(ticketid) ON DELETE CASCADE;


--
-- TOC entry 4983 (class 2606 OID 17843)
-- Name: posto posto_flightid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posto
    ADD CONSTRAINT posto_flightid_fkey FOREIGN KEY (flightid) REFERENCES public.volo(flightid) ON DELETE CASCADE;


--
-- TOC entry 4970 (class 2606 OID 17670)
-- Name: prenotazione prenotazione_passengerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prenotazione
    ADD CONSTRAINT prenotazione_passengerid_fkey FOREIGN KEY (passengerid) REFERENCES public.passeggero(passengerid) ON DELETE CASCADE;


--
-- TOC entry 4973 (class 2606 OID 17732)
-- Name: scalo scalo_aeroportoid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scalo
    ADD CONSTRAINT scalo_aeroportoid_fkey FOREIGN KEY (aeroportoid) REFERENCES public.aeroporto(airportid);


--
-- TOC entry 4974 (class 2606 OID 17727)
-- Name: scalo scalo_routeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scalo
    ADD CONSTRAINT scalo_routeid_fkey FOREIGN KEY (routeid) REFERENCES public.tratta(routeid) ON DELETE CASCADE;


--
-- TOC entry 4971 (class 2606 OID 17714)
-- Name: tratta tratta_aeroportoarrivoid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tratta
    ADD CONSTRAINT tratta_aeroportoarrivoid_fkey FOREIGN KEY (aeroportoarrivoid) REFERENCES public.aeroporto(airportid);


--
-- TOC entry 4972 (class 2606 OID 17709)
-- Name: tratta tratta_aeroportopartenzaid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tratta
    ADD CONSTRAINT tratta_aeroportopartenzaid_fkey FOREIGN KEY (aeroportopartenzaid) REFERENCES public.aeroporto(airportid);


--
-- TOC entry 4969 (class 2606 OID 17655)
-- Name: utenteapp utenteapp_passengerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utenteapp
    ADD CONSTRAINT utenteapp_passengerid_fkey FOREIGN KEY (passengerid) REFERENCES public.passeggero(passengerid) ON DELETE CASCADE;


--
-- TOC entry 4975 (class 2606 OID 17754)
-- Name: volo volo_aircraftid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volo
    ADD CONSTRAINT volo_aircraftid_fkey FOREIGN KEY (aircraftid) REFERENCES public.aereo(aircraftid);


--
-- TOC entry 4976 (class 2606 OID 17749)
-- Name: volo volo_routeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.volo
    ADD CONSTRAINT volo_routeid_fkey FOREIGN KEY (routeid) REFERENCES public.tratta(routeid);


-- Completed on 2025-11-19 20:04:09

--
-- PostgreSQL database dump complete
--

\unrestrict agEMbas0lnMWGihSxtCgSjDC3Td3D5aAMSBfCBNfVbk1rnahlG1WSc1TDv0JUwV

