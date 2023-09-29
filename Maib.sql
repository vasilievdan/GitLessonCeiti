CREATE DATABASE maib;
Use maib;

CREATE TABLE Clienti (
    ID INT PRIMARY KEY,
    Nume VARCHAR(255),
    Prenume VARCHAR(255),
    Email VARCHAR(255),
    Telefon VARCHAR(15)
);

CREATE TABLE Conturi (
    ID INT PRIMARY KEY,
    Client_ID INT,
    IBAN VARCHAR(30),
    Sold DECIMAL(10, 2),
    Data_Deschiderii DATE
);

CREATE TABLE Tranzactii (
    ID INT PRIMARY KEY,
    Cont_Sursa_ID INT,
    Cont_Destinatie_ID INT,
    Suma DECIMAL(10, 2),
    Data_Tranzactiei DATE
);
-- Inserare înregistrări în tabela Clienti
INSERT INTO Clienti (ID, Nume, Prenume, Email, Telefon)
VALUES
    (1, 'Popescu', 'Ion', 'ion.popescu@example.com', '0721123456'),
    (2, 'Ionescu', 'Maria', 'maria.ionescu@example.com', '0732123456'),
    (3, 'Radu', 'Andrei', 'andrei.radu@example.com', '0743123456'),
    (4, 'Dumitrescu', 'Elena', 'elena.dumitrescu@example.com', '0754123456'),
    (5, 'Stoica', 'Mihai', 'mihai.stoica@example.com', '0765123456'),
    (6, 'Mihaila', 'Ana', 'ana.mihaila@example.com', '0776123456'),
    (7, 'Gheorghe', 'George', 'george.gheorghe@example.com', '0787123456'),
    (8, 'Florescu', 'Adina', 'adina.florescu@example.com', '0798123456'),
    (9, 'Constantin', 'Marian', 'marian.constantin@example.com', '0809123456'),
    (10, 'Popa', 'Andreea', 'andreea.popa@example.com', '0810123456'),
    (11, 'Chiriac', 'Cristian', 'cristian.chiriac@example.com', '0821123456'),
    (12, 'Stanescu', 'Elena', 'elena.stanescu@example.com', '0832123456'),
    (13, 'Dragomir', 'Alexandru', 'alexandru.dragomir@example.com', '0843123456'),
    (14, 'Georgescu', 'Simona', 'simona.georgescu@example.com', '0854123456'),
    (15, 'Popovici', 'Mirela', 'mirela.popovici@example.com', '0865123456');

-- Inserare înregistrări în tabela Conturi
INSERT INTO Conturi (ID, Client_ID, IBAN, Sold, Data_Deschiderii)
VALUES
    (1, 1, 'RO12ABCD1234567890123456', 1500.00, '2023-01-15'),
    (2, 2, 'RO34EFGH2345678901234567', 2500.00, '2023-02-20'),
    (3, 3, 'RO56IJKL3456789012345678', 3500.00, '2023-03-25'),
    (4, 4, 'RO78MNOP4567890123456789', 4500.00, '2023-04-10'),
    (5, 5, 'RO90QRST5678901234567890', 5500.00, '2023-05-05'),
    (6, 6, 'RO12UVWX6789012345678901', 6000.00, '2023-06-10'),
    (7, 7, 'RO34YZAB7890123456789012', 7000.00, '2023-07-15'),
    (8, 8, 'RO56CDEF8901234567890123', 8000.00, '2023-08-20'),
    (9, 9, 'RO78GHIJ9012345678901234', 9000.00, '2023-09-25'),
    (10, 10, 'RO90KLMN0123456789012345', 10000.00, '2023-10-30'),
    (11, 11, 'RO12OPQR1234567890123456', 11000.00, '2023-11-05'),
    (12, 12, 'RO34STUV2345678901234567', 12000.00, '2023-12-10'),
    (13, 13, 'RO56WXYZ3456789012345678', 13000.00, '2024-01-15'),
    (14, 14, 'RO78ABCD4567890123456789', 14000.00, '2024-02-20'),
    (15, 15, 'RO90EFGH5678901234567890', 15000.00, '2024-03-25');

INSERT INTO Tranzactii (ID, Cont_Sursa_ID, Cont_Destinatie_ID, Suma, Data_Tranzactiei)
VALUES
    (1, 1, 2, 200.00, '2023-01-16'),
    (2, 2, 3, 300.00, '2023-02-21'),
    (3, 3, 4, 400.00, '2023-03-26'),
    (4, 4, 5, 500.00, '2023-04-11'),
    (5, 5, 1, 100.00, '2023-05-06'),
    (6, 1, 3, 50.00, '2023-05-07'),
    (7, 2, 4, 75.00, '2023-05-08'),
    (8, 3, 5, 125.00, '2023-05-09'),
    (9, 4, 1, 150.00, '2023-05-10'),
    (10, 5, 2, 100.00, '2023-05-11'),
    (11, 1, 4, 200.00, '2023-05-12'),
    (12, 2, 5, 300.00, '2023-05-13'),
    (13, 3, 1, 400.00, '2023-05-14'),
    (14, 4, 2, 500.00, '2023-05-15'),
    (15, 5, 3, 600.00, '2023-05-16');

	Select *FROM CONTURI;

-- Adăugarea coloanei Telefon_Criptat în tabelul Clienti
ALTER TABLE Clienti
ADD Telefon_Criptat VARBINARY(MAX);

-- Adăugarea coloanei Sold_Criptat în tabelul Conturi
ALTER TABLE Conturi
ADD Sold_Criptat VARBINARY(MAX);
-- Criptarea și inserarea datelor de telefon în Clienti
UPDATE Clienti
SET Telefon_Criptat = ENCRYPTBYKEY(KEY_GUID('MySymmetricKey'), CAST(Telefon AS NVARCHAR(255)));

-- Criptarea și inserarea datelor de sold în Conturi
UPDATE Conturi
SET Sold_Criptat = ENCRYPTBYKEY(KEY_GUID('MySymmetricKey'), CAST(Sold AS NVARCHAR(255)));
-- Decriptarea datelor de telefon în tabelul Clienti
SELECT ID, Nume, Prenume, Email, CONVERT(NVARCHAR(255), DECRYPTBYKEY(Telefon_Criptat)) AS Telefon
FROM Clienti;

-- Decriptarea datelor de sold în tabelul Conturi
SELECT ID, Client_ID, IBAN, CAST(DECRYPTBYKEY(Sold_Criptat) AS DECIMAL(10, 2)) AS Sold, Data_Deschiderii
FROM Conturi;

-- Inserare în tabelul Tranzactii
BEGIN TRANSACTION;
INSERT INTO Tranzactii (Cont_Sursa_ID, Cont_Destinatie_ID, Suma, Data_Tranzactiei)
VALUES (1, 2, 300.00, '2023-09-28');

-- Criptare la nivel de coloane cu Always Encrypted
CREATE TABLE TabelaExemplu (
    ID INT PRIMARY KEY,
    Nume NVARCHAR(255),
    Prenume NVARCHAR(255) ENCRYPTED WITH (COLUMN_ENCRYPTION_KEY = ColumnKey,ENCRYPTION_TYPE = Deterministic, ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256')
);

-- Inserarea datelor criptate
INSERT INTO TabelaExemplu (ID, Nume, Prenume)
VALUES
    (1, 'Popescu', 'EncryptedValue1'),
    (2, 'Ionescu', 'EncryptedValue2');

-- Decriptarea datelor
SELECT ID, Nume, DecryptByKey(Prenume) AS Prenume_decriptat FROM TabelaExemplu;


