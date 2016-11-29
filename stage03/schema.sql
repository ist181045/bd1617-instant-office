/**
 * BD Instant Office
 * BD225179 16'17
 *
 * @author Rui Ventura (ist181045)
 * @author Diogo Freitas (ist181586)
 * @author Sara Azinhal (ist181700)
 */

DROP TABLE IF EXISTS Estado;
DROP TABLE IF EXISTS Paga;
DROP TABLE IF EXISTS Aluga;
DROP TABLE IF EXISTS Reserva;
DROP TABLE IF EXISTS Oferta;
DROP TABLE IF EXISTS Posto;
DROP TABLE IF EXISTS Espaco;
DROP TABLE IF EXISTS Fiscaliza;
DROP TABLE IF EXISTS Arrenda;
DROP TABLE IF EXISTS Alugavel;
DROP TABLE IF EXISTS Edificio;
DROP TABLE IF EXISTS Fiscal;
DROP TABLE IF EXISTS User;


CREATE TABLE User VALUES (
  nif      VARCHAR(9)   NOT NULL UNIQUE,
  nome     VARCHAR(80)  NOT NULL,
  telefone VARCHAR(26)  NOT NULL,
  PRIMARY KEY(nif)
);

CREATE TABLE Fiscal VALUES (
  id      INT          NOT NULL UNIQUE,
  empresa VARCHAR(255) NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE Edificio VALUES (
  morada VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY(morada)
);

CREATE TABLE Alugavel VALUES (
  morada VARCHAR(255) NOT NULL,
  codigo VARCHAR(255) NOT NULL,
  foto   VARCHAR(255) NOT NULL,
  PRIMARY KEY(morada, codigo),
  FOREIGN KEY(morada) REFERENCES Edificio(morada)
);

CREATE TABLE Arrenda VALUES (
  morada VARCHAR(255) NOT NULL,
  codigo VARCHAR(255) NOT NULL,
  nif    VARCHAR(9)   NOT NULL.
  PRIMARY KEY(morada, codigo),
  FOREIGN KEY(morada, codigo) REFERENCES Alugavel(morada, codigo),
  FOREIGN KEY(nif) REFERENCES User(nif)
);

CREATE TABLE Fiscaliza VALUES (
  id     INT          NOT NULL,
  morada VARCHAR(255) NOT NULL,
  codigo VARCHAR(255) NOT NULL,
  PRIMARY KEY(id, morada, codigo),
  FOREIGN KEY(id) REFERENCES Fiscal(id),
  FOREIGN KEY(morada, codigo) REFERENCES Arrenda(morada, codigo)
);

CREATE TABLE Espaco VALUES (
  morada VARCHAR(255) NOT NULL,
  codigo VARCHAR(255) NOT NULL,
  PRIMARY KEY(morada, codigo),
  FOREIGN KEY(morada, codigo) REFERENCES Alugavel(morada, codigo)
);

CREATE TABLE Posto VALUES (
  morada        VARCHAR(255) NOT NULL,
  codigo        VARCHAR(255) NOT NULL,
  codigo_espaco VARCHAR(255) NOT NULL,
  PRIMARY KEY(morada, codigo),
  FOREIGN KEY(morada, codigo) REFERENCES Alugavel(morada, codigo),
  FOREIGN KEY(morada, codigo_espaco) REFERENCES Espaco(morada, codigo)
);

CREATE TABLE Oferta VALUES (
  morada        VARCHAR(255)  NOT NULL,
  codigo        NUMERIC(20)   NOT NULL,
  data_inicio   DATE          NOT NULL,
  data_fim      DATE          NOT NULL,
  tarifa        DECIMAL(19,4) NOT NULL,
  PRIMARY KEY(morada, codigo),
  FOREIGN KEY(morada, codigo) REFERENCES Alugavel(morada, codigo),
);

CREATE TABLE Reserva VALUES (
  numero VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY(numero)
)

CREATE TABLE Aluga VALUES (
  morada        VARCHAR(255)  NOT NULL,
  codigo        NUMERIC(20)   NOT NULL,
  data_inicio   DATE          NOT NULL,
  nif           VARCHAR(9)    NOT NULL,
  numero        VARCHAR(255)  NOT NULL,
  PRIMARY KEY(morada, codigo, data_inicio, nif, numero),
  FOREIGN KEY(morada, codigo, data_inicio)
    REFERENCES Oferta(morada, codigo, data_inicio),
  FOREIGN KEY(nif) REFERENCES User(nif),
  FOREIGN KEY(numero) REFERENCES Reserva(numero)
);

CREATE TABLE Paga VALUES (
  numero VARCHAR(255) NOT NULL UNIQUE,
  data   TIMESTAMP    NOT NULL,
  metodo VARCHAR(255) NOT NULL,
  PRIMARY KEY(numero),
  FOREIGN KEY(numero) REFERENCES Reserva(numero)
);

CREATE TABLE Estado VALUES (
  numero     VARCHAR(255) NOT NULL,
  time_stamp TIMESTAMP    NOT NULL,
  estado     VARCHAR(255) NOT NULL,
  PRIMARY KEY(numero, time_stamp),
  FOREIGN KEY(numero) REFERENCES Reserva(numero)
);
