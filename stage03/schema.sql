/**
 * BD Instant Office
 * BD225179 16'17
 *
 * @author Corpo Docente de BD225179
 */

/* Drop tables, if they exist (rebuild schema) */
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

/* Start building */
CREATE TABLE User (
  nif      VARCHAR(9)   NOT NULL UNIQUE,
  nome     VARCHAR(80)  NOT NULL,
  telefone VARCHAR(26)  NOT NULL,
  PRIMARY KEY(nif)
);

CREATE TABLE Fiscal (
  id      INT          NOT NULL UNIQUE,
  empresa VARCHAR(255) NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE Edificio (
  morada VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY(morada)
);

CREATE TABLE Alugavel (
  morada VARCHAR(255) NOT NULL,
  codigo VARCHAR(255) NOT NULL,
  foto   VARCHAR(255) NOT NULL,
  PRIMARY KEY(morada, codigo),
  FOREIGN KEY(morada) REFERENCES Edificio(morada)
);

CREATE TABLE Arrenda (
  morada VARCHAR(255) NOT NULL,
  codigo VARCHAR(255) NOT NULL,
  nif    VARCHAR(9)   NOT NULL,
  PRIMARY KEY(morada, codigo),
  FOREIGN KEY(morada, codigo) REFERENCES Alugavel(morada, codigo),
  FOREIGN KEY(nif) REFERENCES User(nif)
);

CREATE TABLE Fiscaliza (
  id     INT          NOT NULL,
  morada VARCHAR(255) NOT NULL,
  codigo VARCHAR(255) NOT NULL,
  PRIMARY KEY(id, morada, codigo),
  FOREIGN KEY(id) REFERENCES Fiscal(id),
  FOREIGN KEY(morada, codigo) REFERENCES Arrenda(morada, codigo)
);

CREATE TABLE Espaco (
  morada VARCHAR(255) NOT NULL,
  codigo VARCHAR(255) NOT NULL,
  PRIMARY KEY(morada, codigo),
  FOREIGN KEY(morada, codigo) REFERENCES Alugavel(morada, codigo)
);

CREATE TABLE Posto (
  morada        VARCHAR(255) NOT NULL,
  codigo        VARCHAR(255) NOT NULL,
  codigo_espaco VARCHAR(255) NOT NULL,
  PRIMARY KEY(morada, codigo),
  FOREIGN KEY(morada, codigo) REFERENCES Alugavel(morada, codigo),
  FOREIGN KEY(morada, codigo_espaco) REFERENCES Espaco(morada, codigo)
);

CREATE TABLE Oferta (
  morada      VARCHAR(255)  NOT NULL,
  codigo      VARCHAR(255)  NOT NULL,
  data_inicio DATE          NOT NULL,
  data_fim    DATE          NOT NULL,
  tarifa      NUMERIC(19,4) NOT NULL,
  PRIMARY KEY(morada, codigo, data_inicio),
  FOREIGN KEY(morada, codigo) REFERENCES Alugavel(morada, codigo)
);

CREATE TABLE Reserva (
  numero VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY(numero)
);

CREATE TABLE Aluga (
  morada      VARCHAR(255) NOT NULL,
  codigo      VARCHAR(255) NOT NULL,
  data_inicio DATE         NOT NULL,
  nif         VARCHAR(9)   NOT NULL,
  numero      VARCHAR(255) NOT NULL,
  PRIMARY KEY(morada, codigo, data_inicio, nif, numero),
  FOREIGN KEY(morada, codigo, data_inicio)
    REFERENCES Oferta(morada, codigo, data_inicio),
  FOREIGN KEY(nif) REFERENCES User(nif),
  FOREIGN KEY(numero) REFERENCES Reserva(numero)
);

CREATE TABLE Paga (
  numero VARCHAR(255) NOT NULL UNIQUE,
  data   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  metodo VARCHAR(255) NOT NULL,
  PRIMARY KEY(numero),
  FOREIGN KEY(numero) REFERENCES Reserva(numero)
);

CREATE TABLE Estado (
  numero     VARCHAR(255) NOT NULL,
  time_stamp TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  estado     VARCHAR(255) NOT NULL,
  PRIMARY KEY(numero, time_stamp),
  FOREIGN KEY(numero) REFERENCES Reserva(numero)
);
