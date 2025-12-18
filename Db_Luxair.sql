-- SCHEMA DI PERSISTENZA DEI DATI A SUPPORTO DELL'AZIENDA LUXAIR

-- INIZIO TABELLE (MODELLO RELAZIONALE)

-- 1. TABELLA PASSEGGERO
CREATE TABLE Passeggero (
    PassengerID INT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    DataNascita DATE NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Telefono VARCHAR(20),
    Fedelta INT DEFAULT 0,
    Preferenze TEXT
);


-- 2. TABELLA UTENTE APP
CREATE TABLE UtenteApp (
    AppUserID INT PRIMARY KEY,
    PassengerID INT UNIQUE NOT NULL,
    Username VARCHAR(50) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    UltimoAccesso TIMESTAMP,
    PreferenzeApp TEXT,
    FOREIGN KEY (PassengerID) REFERENCES Passeggero(PassengerID)
        ON DELETE CASCADE
);


-- 3. TABELLA PRENOTAZIONE
CREATE TABLE Prenotazione (
    BookingID INT PRIMARY KEY,
    PassengerID INT NOT NULL,
    DataPrenotazione TIMESTAMP NOT NULL,
    StatoPrenotazione VARCHAR(20) NOT NULL,
    OriginePrenotazione VARCHAR(20) NOT NULL,
    FOREIGN KEY (PassengerID) REFERENCES Passeggero(PassengerID)
        ON DELETE CASCADE
);


-- 4. TABELLA AEROPORTO
CREATE TABLE Aeroporto (
    AirportID INT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Citta VARCHAR(50) NOT NULL,
    Paese VARCHAR(50) NOT NULL,
    CodiceIATA CHAR(3) UNIQUE NOT NULL,
    CodiceICAO CHAR(4) UNIQUE NOT NULL
);


-- 5. TABELLA AEREO
CREATE TABLE Aereo (
    AircraftID INT PRIMARY KEY,
    Modello VARCHAR(50) NOT NULL,
    NumeroMatricola VARCHAR(20) UNIQUE NOT NULL,
    CapacitaPosti INT NOT NULL,
    Tipo VARCHAR(20)
);


-- 6. TABELLA TRATTA
CREATE TABLE Tratta (
    RouteID INT PRIMARY KEY,
    AeroportoPartenzaID INT NOT NULL,
    AeroportoArrivoID INT NOT NULL,
    Distanza DECIMAL(8,2),
    FOREIGN KEY (AeroportoPartenzaID) REFERENCES Aeroporto(AirportID),
    FOREIGN KEY (AeroportoArrivoID) REFERENCES Aeroporto(AirportID)
);


-- 7. TABELLA SCALO
CREATE TABLE Scalo (
    StopoverID INT PRIMARY KEY,
    RouteID INT NOT NULL,
    AeroportoID INT NOT NULL,
    OraArrivoPrevista TIMESTAMP,
    OraPartenzaPrevista TIMESTAMP,
    DurataStimata TIME,
    FOREIGN KEY (RouteID) REFERENCES Tratta(RouteID) ON DELETE CASCADE,
    FOREIGN KEY (AeroportoID) REFERENCES Aeroporto(AirportID)
);


-- 8. TABELLA VOLO
CREATE TABLE Volo (
    FlightID INT PRIMARY KEY,
    NumeroVolo VARCHAR(10) NOT NULL,
    RouteID INT NOT NULL,
    AircraftID INT NOT NULL,
    DataPartenza DATE NOT NULL,
    OraPartenza TIME NOT NULL,
    Durata TIME,
    StatoVolo VARCHAR(20) NOT NULL,
    FOREIGN KEY (RouteID) REFERENCES Tratta(RouteID),
    FOREIGN KEY (AircraftID) REFERENCES Aereo(AircraftID)
);


-- 9. TABELLA PERSONALE DI BORDO
CREATE TABLE PersonaleDiBordo (
    CrewID INT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    Ruolo VARCHAR(30) NOT NULL,
    Certificazioni TEXT
);


-- 10. TABELLA FLIGHTCREW
CREATE TABLE FlightCrew (
    FlightID INT NOT NULL,
    CrewID INT NOT NULL,
    PRIMARY KEY (FlightID, CrewID),
    FOREIGN KEY (FlightID) REFERENCES Volo(FlightID) ON DELETE CASCADE,
    FOREIGN KEY (CrewID) REFERENCES PersonaleDiBordo(CrewID) ON DELETE CASCADE
);


-- 11. TABELLA BIGLIETTO
CREATE TABLE Biglietto (
    TicketID INT PRIMARY KEY,
    BookingID INT NOT NULL,
    FlightID INT NOT NULL,
    PNR VARCHAR(10) UNIQUE NOT NULL,
    Classe VARCHAR(20) NOT NULL,
    StatoBiglietto VARCHAR(20) NOT NULL,
    BagaglioIncluso VARCHAR(50),
    ServiziExtra TEXT,
    PassengerID INT,
    FOREIGN KEY (BookingID) REFERENCES Prenotazione(BookingID) ON DELETE CASCADE,
    FOREIGN KEY (FlightID) REFERENCES Volo(FlightID) ON DELETE CASCADE,
    FOREIGN KEY (PassengerID) REFERENCES Passeggero(PassengerID)
);


-- 12. TABELLA PAGAMENTO
CREATE TABLE Pagamento (
    PaymentID INT PRIMARY KEY,
    TicketID INT NOT NULL,
    MetodoPagamento VARCHAR(20) NOT NULL,
    DataPagamento TIMESTAMP NOT NULL,
    Importo DECIMAL(10,2) NOT NULL,
    StatoPagamento VARCHAR(20) NOT NULL,
    FOREIGN KEY (TicketID) REFERENCES Biglietto(TicketID) ON DELETE CASCADE
);


-- 13. TABELLA POSTO
CREATE TABLE Posto (
    SeatID INT PRIMARY KEY,
    FlightID INT NOT NULL,
    NumeroPosto VARCHAR(5) NOT NULL,
    Classe VARCHAR(20) NOT NULL,
    Stato VARCHAR(20) NOT NULL,
    FOREIGN KEY (FlightID) REFERENCES Volo(FlightID) ON DELETE CASCADE
);


-- 14. TABELLA CHECK-IN
CREATE TABLE CheckIn (
    CheckInID INT PRIMARY KEY,
    TicketID INT UNIQUE NOT NULL,
    TipoCheckIn VARCHAR(20) NOT NULL,
    DataCheckIn TIMESTAMP NOT NULL,
    PostoAssegnato INT,
    CartaImbarcoGenerata BOOLEAN DEFAULT FALSE,
    NumeroPosto VARCHAR(5),
    FOREIGN KEY (TicketID) REFERENCES Biglietto(TicketID) ON DELETE CASCADE,
    FOREIGN KEY (PostoAssegnato) REFERENCES Posto(SeatID)
);


--APPLICAZIONE FORME NORMALI E DENORMALIZZAZIONE
--1. Aggiunta di NumeroPosto in CheckIn
ALTER TABLE CheckIn
ADD NumeroPosto VARCHAR(5);

--   mantenimento del vincolo FK opzionale con Posto
ALTER TABLE CheckIn
ADD CONSTRAINT FK_CheckIn_Posto_NumeroPosto
FOREIGN KEY (NumeroPosto) REFERENCES Posto(NumeroPosto);

--2. Alter Table di Biglietto
ADD PassengerID INT;

-- Aggiunta del vincolo di FK verso Passeggero
ALTER TABLE Biglietto
ADD CONSTRAINT FK_Biglietto_Passeggero
FOREIGN KEY (PassengerID) REFERENCES Passeggero(PassengerID);


-- INDICI PER MIGLIORARE LE PERFORMANCE
-- Passeggero
CREATE INDEX idx_Passeggero_Email ON Passeggero(Email);
CREATE INDEX idx_Passeggero_NomeCognome ON Passeggero(Nome, Cognome);

-- Biglietto
CREATE INDEX idx_Biglietto_PassengerID ON Biglietto(PassengerID);
CREATE INDEX idx_Biglietto_PNR ON Biglietto(PNR);
CREATE INDEX idx_Biglietto_Stato ON Biglietto(StatoBiglietto);
CREATE INDEX idx_Biglietto_PassengerID_FlightID ON Biglietto(PassengerID, FlightID);

-- CheckIn
CREATE INDEX idx_CheckIn_TicketID ON CheckIn(TicketID);
CREATE INDEX idx_CheckIn_NumeroPosto ON CheckIn(NumeroPosto);

-- Volo
CREATE INDEX idx_Volo_NumeroVolo ON Volo(NumeroVolo);
CREATE INDEX idx_Volo_DataPartenza ON Volo(DataPartenza);
CREATE INDEX idx_Volo_NumeroVolo_Data ON Volo(NumeroVolo, DataPartenza);

-- Scalo
CREATE INDEX idx_Scalo_RouteID ON Scalo(RouteID);
CREATE INDEX idx_Scalo_AeroportoID ON Scalo(AeroportoID);

-- Pagamento
CREATE INDEX idx_Pagamento_TicketID ON Pagamento(TicketID);
CREATE INDEX idx_Pagamento_DataPagamento ON Pagamento(DataPagamento);

-- Posto
CREATE INDEX idx_Posto_FlightID_Numero ON Posto(FlightID, NumeroPosto);

-- Query SQL rappresentative delle operazioni tipiche.
-- Di seguito sono riportate alcune query SQL rappresentative delle principali operazioni tipiche del contesto applicativo 
-- di una compagnia aerea, quali la ricerca di voli e biglietti disponibili, la consultazione dello storico delle prenotazioni 
-- e la verifica della validità di un biglietto.

-- Popolamento tabelle principali
-- Inserimento aeroporti
INSERT INTO Aeroporto (AirportID, Nome, Citta, Paese, CodiceIATA, CodiceICAO)
VALUES 
(1, 'Aeroporto di Lussemburgo', 'Lussemburgo', 'Lussemburgo', 'LUX', 'ELLX'),
(2, 'Aeroporto di Roma Fiumicino', 'Roma', 'Italia', 'FCO', 'LIRF');

-- Inserimento aerei
INSERT INTO Aereo (AircraftID, Modello, NumeroMatricola, CapacitaPosti, Tipo)
VALUES
(1, 'Airbus A320', 'LX-001', 180, 'Passeggeri');

-- Inserimento tratte
INSERT INTO Tratta (RouteID, AeroportoPartenzaID, AeroportoArrivoID, Distanza)
VALUES (1, 1, 2, 1400);

-- Inserimento voli
INSERT INTO Volo (FlightID, NumeroVolo, RouteID, AircraftID, DataPartenza, OraPartenza, Durata, StatoVolo)
VALUES
(101, 'LG123', 1, 1, '2025-07-15', '10:00:00', '02:00:00', 'Programmato'),
(102, 'LG124', 1, 1, '2025-07-15', '15:00:00', '02:00:00', 'Cancellato');

-- Inserimento passeggeri
INSERT INTO Passeggero (PassengerID, Nome, Cognome, DataNascita, Email, Telefono, Fedelta)
VALUES
(10, 'Mario', 'Rossi', '1985-03-21', 'mario.rossi@email.com', '1234567890', 50),
(11, 'Luisa', 'Bianchi', '1990-07-11', 'luisa.bianchi@email.com', '0987654321', 30);

-- Inserimento prenotazioni
INSERT INTO Prenotazione (BookingID, PassengerID, DataPrenotazione, StatoPrenotazione, OriginePrenotazione)
VALUES
(201, 10, '2025-06-01 09:00:00', 'Confermata', 'App'),
(202, 10, '2025-06-15 11:30:00', 'Confermata', 'SitoWeb');

-- Inserimento biglietti
INSERT INTO Biglietto (TicketID, BookingID, FlightID, PNR, Classe, StatoBiglietto, PassengerID)
VALUES
(301, 201, 101, 'ABCD1234', 'Economy', 'Disponibile', 10),
(302, 201, 101, 'EFGH5678', 'Business', 'Venduto', 10),
(303, 202, 102, 'IJKL9012', 'Economy', 'Disponibile', 10);


-- Inizio Query.
-- Query 1 – Ricerca voli disponibili per tratta e data
SELECT  
    v.FlightID,
    v.NumeroVolo,
    ap_partenza.Citta AS CittaPartenza,
    ap_arrivo.Citta AS CittaArrivo,
    v.DataPartenza,
    v.OraPartenza,
    v.StatoVolo
FROM Volo v
JOIN Tratta t ON v.RouteID = t.RouteID
JOIN Aeroporto ap_partenza ON t.AeroportoPartenzaID = ap_partenza.AirportID
JOIN Aeroporto ap_arrivo ON t.AeroportoArrivoID = ap_arrivo.AirportID
WHERE ap_partenza.CodiceIATA = 'LUX'
  AND ap_arrivo.CodiceIATA = 'FCO'
  AND v.DataPartenza = '2025-07-15'
  AND v.StatoVolo = 'Programmato';

-- Query 2 – Biglietti disponibili per un volo specifico
SELECT 
    b.TicketID,
    b.PNR,
    b.Classe,
    b.StatoBiglietto
FROM Biglietto b
WHERE b.FlightID = 101
  AND b.StatoBiglietto = 'Disponibile';

-- Query 3 – Storico prenotazioni di un passeggero
SELECT 
    p.BookingID,
    p.DataPrenotazione,
    p.StatoPrenotazione,
    v.NumeroVolo,
    v.DataPartenza,
    b.PNR,
    b.Classe,
    b.StatoBiglietto
FROM Prenotazione p
JOIN Biglietto b ON p.BookingID = b.BookingID
JOIN Volo v ON b.FlightID = v.FlightID
WHERE p.PassengerID = 10
ORDER BY p.DataPrenotazione DESC;

-- Query 4 – Prenotazioni future di un passeggero (solo voli ancora disponibili)
SELECT 
    p.BookingID,
    p.DataPrenotazione,
    v.NumeroVolo,
    v.DataPartenza,
    b.PNR,
    b.Classe,
    b.StatoBiglietto
FROM Prenotazione p
JOIN Biglietto b ON p.BookingID = b.BookingID
JOIN Volo v ON b.FlightID = v.FlightID
WHERE p.PassengerID = 10
  AND b.StatoBiglietto = 'Disponibile'
  AND v.DataPartenza >= CURRENT_DATE
ORDER BY v.DataPartenza ASC;

-- Query 5 – Verifica validità di un biglietto tramite PNR
SELECT 
    b.PNR,
    b.StatoBiglietto,
    v.NumeroVolo,
    v.DataPartenza,
    v.StatoVolo
FROM Biglietto b
JOIN Volo v ON b.FlightID = v.FlightID
WHERE b.PNR = 'ABCD1234';

-- Aggiornamento necessario per far funzionare la query 4.
-- La query 4 filtra solo i voli con DataPartenza >= CURRENT_DATE.
-- Poiché i dati di test inseriti potevano essere nel passato rispetto alla data corrente,
-- aggiorno la data dei voli a una data futura per garantire che la query restituisca risultati.
UPDATE Volo
SET DataPartenza = '2026-07-15'
WHERE FlightID = 101;

