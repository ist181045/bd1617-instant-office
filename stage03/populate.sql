/**
 * BD Instant Office
 * BD225179 16'17
 *
 * @author Corpo Docente de BD225179
 */

INSERT INTO Edificio VALUES ('IST');
INSERT INTO Edificio VALUES ('FEUP');
INSERT INTO Edificio VALUES ('Catolica');
INSERT INTO Edificio VALUES ('ISEL');


-- Senhorios
INSERT INTO User VALUES ('123456719', 'Jorge Poeta', '992323123');
INSERT INTO User VALUES ('113056729', 'António Martins', '992333123');
INSERT INTO User VALUES ('133956139', 'David Manuel', '992323124');
INSERT INTO User VALUES ('143856248', 'Nuno Sousa', '992323125');

-- Arrendatarios
INSERT INTO User VALUES ('153756357', 'Armando Sousa', '992323126');
INSERT INTO User VALUES ('163656466', 'Gonçalo Santos', '992323127');
INSERT INTO User VALUES ('173516575', 'Alberto Silva', '992323128');
INSERT INTO User VALUES ('183426684', 'Rubim Guerreiro', '992323129');
INSERT INTO User VALUES ('193336793', 'Anacleto Vieira', '993323123');
INSERT INTO User VALUES ('103246782', 'Luis Raposo', '995323123');
INSERT INTO User VALUES ('120456781', 'Rui Vitória', '997323123');

INSERT INTO Fiscal VALUES (1, 'ASAE');
INSERT INTO Fiscal VALUES (2, 'CIA');
INSERT INTO Fiscal VALUES (3, 'PJ');
INSERT INTO Fiscal VALUES (4, 'FBI');


INSERT INTO Alugavel VALUES ('IST', 'Central', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('IST', 'DEI', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('IST', 'Lab1', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('IST', 'Lab2', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('IST', 'Lab3', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('IST', 'DEG', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('IST', 'DEQ', 'http://lorempixel.com/400/200/');

INSERT INTO Alugavel VALUES ('FEUP', 'Central', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('FEUP', 'DEI', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('FEUP', 'DEG', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('FEUP', 'DEQ', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('FEUP', 'Lab1', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('FEUP', 'Lab2', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('FEUP', 'Lab3', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('FEUP', 'Lab4', 'http://lorempixel.com/400/200/');

INSERT INTO Alugavel VALUES ('Catolica', 'Central', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('Catolica', 'DMKT', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('Catolica', 'Sala1', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('Catolica', 'Sala2', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('Catolica', 'DG', 'http://lorempixel.com/400/200/');

INSERT INTO Alugavel VALUES ('ISEL', 'Central', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('ISEL', 'DEI', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('ISEL', 'DEG', 'http://lorempixel.com/400/200/');
INSERT INTO Alugavel VALUES ('ISEL', 'DEQ', 'http://lorempixel.com/400/200/');

INSERT INTO Arrenda VALUES ('IST', 'Central', '123456719');
INSERT INTO Arrenda VALUES ('IST', 'DEI', '123456719');
INSERT INTO Arrenda VALUES ('IST', 'Lab1', '123456719');
INSERT INTO Arrenda VALUES ('IST', 'Lab2', '123456719');
INSERT INTO Arrenda VALUES ('IST', 'Lab3', '123456719');
INSERT INTO Arrenda VALUES ('IST', 'DEG', '123456719');
INSERT INTO Arrenda VALUES ('IST', 'DEQ', '123456719');

INSERT INTO Arrenda VALUES ('FEUP', 'Central', '113056729');
INSERT INTO Arrenda VALUES ('FEUP', 'DEI', '113056729');
INSERT INTO Arrenda VALUES ('FEUP', 'DEG', '113056729');
INSERT INTO Arrenda VALUES ('FEUP', 'DEQ', '113056729');
INSERT INTO Arrenda VALUES ('FEUP', 'Lab1', '113056729');
INSERT INTO Arrenda VALUES ('FEUP', 'Lab2', '113056729');
INSERT INTO Arrenda VALUES ('FEUP', 'Lab3', '113056729');
INSERT INTO Arrenda VALUES ('FEUP', 'Lab4', '113056729');

INSERT INTO Arrenda VALUES ('Catolica', 'Central', '133956139');
INSERT INTO Arrenda VALUES ('Catolica', 'DMKT', '133956139');
INSERT INTO Arrenda VALUES ('Catolica', 'Sala1', '133956139');
INSERT INTO Arrenda VALUES ('Catolica', 'Sala2', '133956139');
INSERT INTO Arrenda VALUES ('Catolica', 'DG', '133956139');

INSERT INTO Arrenda VALUES ('ISEL', 'Central', '143856248');
INSERT INTO Arrenda VALUES ('ISEL', 'DEI', '143856248');
INSERT INTO Arrenda VALUES ('ISEL', 'DEG', '143856248');
INSERT INTO Arrenda VALUES ('ISEL', 'DEQ', '143856248');


INSERT INTO Fiscaliza VALUES (1, 'IST', 'Central');
INSERT INTO Fiscaliza VALUES (1, 'IST', 'DEI');
INSERT INTO Fiscaliza VALUES (1, 'IST', 'Lab1');
INSERT INTO Fiscaliza VALUES (1, 'FEUP', 'Central');
INSERT INTO Fiscaliza VALUES (2, 'FEUP', 'Central');
INSERT INTO Fiscaliza VALUES (2, 'FEUP', 'DEQ');
INSERT INTO Fiscaliza VALUES (3, 'FEUP', 'DEI');
INSERT INTO Fiscaliza VALUES (4, 'Catolica', 'Central');
INSERT INTO Fiscaliza VALUES (2, 'Catolica', 'DG');


INSERT INTO Espaco VALUES ('IST', 'Central');
INSERT INTO Espaco VALUES ('IST', 'DEI');
INSERT INTO Espaco VALUES ('IST', 'DEG');
INSERT INTO Espaco VALUES ('IST', 'DEQ');

INSERT INTO Posto VALUES ('IST', 'Lab1', 'DEI');
INSERT INTO Posto VALUES ('IST', 'Lab2', 'DEI');
INSERT INTO Posto VALUES ('IST', 'Lab3', 'DEI');


INSERT INTO Espaco VALUES ('FEUP', 'Central');
INSERT INTO Espaco VALUES ('FEUP', 'DEI');
INSERT INTO Espaco VALUES ('FEUP', 'DEG');
INSERT INTO Espaco VALUES ('FEUP', 'DEQ');

INSERT INTO Posto VALUES ('FEUP', 'Lab1', 'DEG');
INSERT INTO Posto VALUES ('FEUP', 'Lab2', 'DEG');
INSERT INTO Posto VALUES ('FEUP', 'Lab3', 'DEG');
INSERT INTO Posto VALUES ('FEUP', 'Lab4', 'DEG');


INSERT INTO Espaco VALUES ('Catolica', 'Central');
INSERT INTO Espaco VALUES ('Catolica', 'DMKT');
INSERT INTO Espaco VALUES ('Catolica', 'DG');

INSERT INTO Posto VALUES ('Catolica', 'Sala1', 'DMKT');
INSERT INTO Posto VALUES ('Catolica', 'Sala2', 'DMKT');


INSERT INTO Espaco VALUES ('ISEL', 'Central');
INSERT INTO Espaco VALUES ('ISEL', 'DEI');
INSERT INTO Espaco VALUES ('ISEL', 'DEG');
INSERT INTO Espaco VALUES ('ISEL', 'DEQ');


INSERT INTO Oferta VALUES ('IST', 'Central', '2016-01-01', '2016-01-31', 19.99);
INSERT INTO Oferta VALUES ('IST', 'DEI', '2016-01-01', '2016-01-31', 49.99);
INSERT INTO Oferta VALUES ('IST', 'DEG', '2016-01-01', '2016-01-31', 39.99);
INSERT INTO Oferta VALUES ('IST', 'DEQ', '2016-01-01', '2016-01-31', 29.99);
INSERT INTO Oferta VALUES ('IST', 'DEI', '2016-02-01', '2016-02-28', 49.99);
INSERT INTO Oferta VALUES ('IST', 'DEG', '2016-02-01', '2016-02-28', 39.99);
INSERT INTO Oferta VALUES ('IST', 'DEQ', '2016-02-01', '2016-02-28', 29.99);

INSERT INTO Oferta VALUES ('FEUP', 'Central', '2016-01-01', '2016-01-31', 23.99);
INSERT INTO Oferta VALUES ('FEUP', 'DEI', '2016-01-01', '2016-01-31', 32.00);
INSERT INTO Oferta VALUES ('FEUP', 'Lab1', '2016-01-01', '2016-01-31', 25.00);
INSERT INTO Oferta VALUES ('FEUP', 'Lab2', '2016-01-01', '2016-01-31', 15.00);
INSERT INTO Oferta VALUES ('FEUP', 'Lab3', '2016-01-01', '2016-01-31', 15.00);
INSERT INTO Oferta VALUES ('FEUP', 'Lab4', '2016-01-01', '2016-01-31', 15.00);

INSERT INTO Oferta VALUES ('Catolica', 'Central', '2016-01-01', '2016-01-31', 17.00);
INSERT INTO Oferta VALUES ('Catolica', 'Sala1', '2016-01-01', '2016-01-31', 4.00);
INSERT INTO Oferta VALUES ('Catolica', 'Sala2', '2016-01-01', '2016-01-31', 2.00);
INSERT INTO Oferta VALUES ('Catolica', 'Central', '2016-02-01', '2016-02-28', 17.00);

INSERT INTO Oferta VALUES ('ISEL', 'Central', '2016-01-01', '2016-01-31', 89.00);
INSERT INTO Oferta VALUES ('ISEL', 'DEI', '2016-01-01', '2016-01-31', 29.00);
INSERT INTO Oferta VALUES ('ISEL', 'DEG', '2016-01-01', '2016-01-31', 49.00);
INSERT INTO Oferta VALUES ('ISEL', 'DEQ', '2016-01-01', '2016-01-31', 29.00);
INSERT INTO Oferta VALUES ('ISEL', 'Central', '2016-02-01', '2016-02-28', 89.00);
INSERT INTO Oferta VALUES ('ISEL', 'DEI', '2016-02-01', '2016-02-28', 29.00);
INSERT INTO Oferta VALUES ('ISEL', 'DEG', '2016-02-01', '2016-02-28', 49.00);
INSERT INTO Oferta VALUES ('ISEL', 'DEQ', '2016-02-01', '2016-02-28', 29.00);


INSERT INTO Reserva VALUES ('2016-1');
INSERT INTO Reserva VALUES ('2016-2');
INSERT INTO Reserva VALUES ('2016-3');
INSERT INTO Reserva VALUES ('2016-4');
INSERT INTO Reserva VALUES ('2016-5');
INSERT INTO Reserva VALUES ('2016-6');
INSERT INTO Reserva VALUES ('2016-7');
INSERT INTO Reserva VALUES ('2016-8');
INSERT INTO Reserva VALUES ('2016-9');
INSERT INTO Reserva VALUES ('2016-10');
INSERT INTO Reserva VALUES ('2016-11');
INSERT INTO Reserva VALUES ('2016-12');
INSERT INTO Reserva VALUES ('2016-13');


INSERT INTO Aluga VALUES ('IST', 'Central', '2016-01-01', '120456781', '2016-1');
INSERT INTO Aluga VALUES ('IST', 'DEI', '2016-01-01', '153756357', '2016-2');
INSERT INTO Aluga VALUES ('IST', 'DEG', '2016-01-01', '163656466', '2016-3');
INSERT INTO Aluga VALUES ('IST', 'DEQ', '2016-01-01', '163656466', '2016-4');
INSERT INTO Aluga VALUES ('IST', 'DEI', '2016-02-01', '120456781', '2016-5');

INSERT INTO Aluga VALUES ('FEUP', 'Central', '2016-01-01', '183426684', '2016-6');
INSERT INTO Aluga VALUES ('FEUP', 'Lab1', '2016-01-01', '173516575', '2016-7');

INSERT INTO Aluga VALUES ('Catolica', 'Central', '2016-01-01', '193336793', '2016-8');
INSERT INTO Aluga VALUES ('Catolica', 'Sala1', '2016-01-01', '103246782', '2016-9');
INSERT INTO Aluga VALUES ('Catolica', 'Sala2', '2016-01-01', '103246782', '2016-10');

INSERT INTO Aluga VALUES ('ISEL', 'Central', '2016-01-01', '103246782', '2016-11');
INSERT INTO Aluga VALUES ('ISEL', 'DEI', '2016-01-01', '103246782', '2016-12');
INSERT INTO Aluga VALUES ('ISEL', 'Central', '2016-02-01', '103246782', '2016-13');


INSERT INTO Paga VALUES ('2016-1', '2016-01-02 10:43:41', 'Cartão Crédito');
INSERT INTO Paga VALUES ('2016-2', '2016-01-02 11:33:25', 'Cartão Crédito');
INSERT INTO Paga VALUES ('2016-3', '2016-01-02 12:23:42', 'Paypal');
INSERT INTO Paga VALUES ('2016-4', '2016-01-01 08:43:23', 'Cartão Crédito');
INSERT INTO Paga VALUES ('2016-6', '2016-01-02 11:53:38', 'Cartão Crédito');
INSERT INTO Paga VALUES ('2016-7', '2016-01-03 08:33:03', 'Paypal');
INSERT INTO Paga VALUES ('2016-8', '2016-01-02 19:13:14', 'Cartão Crédito');
INSERT INTO Paga VALUES ('2016-9', '2016-01-01 18:23:46', 'Paypal');
INSERT INTO Paga VALUES ('2016-10', '2016-01-02 12:03:37', 'Cartão Crédito');
INSERT INTO Paga VALUES ('2016-11', '2016-01-01 13:23:25', 'Paypal');
INSERT INTO Paga VALUES ('2016-13', '2016-02-01 09:21:05', 'Cartão Crédito');


INSERT INTO Estado VALUES ('2016-1', '2016-01-01 02:53:21', 'Aceite');
INSERT INTO Estado VALUES ('2016-1', '2016-01-02 10:43:41', 'Paga');
INSERT INTO Estado VALUES ('2016-2', '2016-01-01 01:13:15', 'Aceite');
INSERT INTO Estado VALUES ('2016-2', '2016-01-02 11:33:25', 'Paga');
INSERT INTO Estado VALUES ('2016-3', '2016-01-01 11:03:22', 'Aceite');
INSERT INTO Estado VALUES ('2016-3', '2016-01-02 12:23:42', 'Paga');
INSERT INTO Estado VALUES ('2016-4', '2016-01-01 02:13:23', 'Aceite');
INSERT INTO Estado VALUES ('2016-4', '2016-01-01 08:43:23', 'Paga');
INSERT INTO Estado VALUES ('2016-5', '2016-01-01 12:23:21', 'Aceite');
INSERT INTO Estado VALUES ('2016-6', '2016-01-01 02:23:33', 'Aceite');
INSERT INTO Estado VALUES ('2016-6', '2016-01-02 11:53:38', 'Paga');
INSERT INTO Estado VALUES ('2016-7', '2016-01-02 01:23:03', 'Aceite');
INSERT INTO Estado VALUES ('2016-7', '2016-01-03 08:33:03', 'Paga');
INSERT INTO Estado VALUES ('2016-8', '2016-01-01 13:13:14', 'Aceite');
INSERT INTO Estado VALUES ('2016-8', '2016-01-02 19:13:14', 'Paga');
INSERT INTO Estado VALUES ('2016-9', '2016-01-01 10:13:46', 'Aceite');
INSERT INTO Estado VALUES ('2016-9', '2016-01-01 18:23:46', 'Paga');
INSERT INTO Estado VALUES ('2016-10', '2016-01-01 10:33:17', 'Aceite');
INSERT INTO Estado VALUES ('2016-10', '2016-01-02 12:03:37', 'Paga');
INSERT INTO Estado VALUES ('2016-11', '2016-01-01 11:03:15', 'Aceite');
INSERT INTO Estado VALUES ('2016-11', '2016-01-01 13:23:25', 'Paga');
INSERT INTO Estado VALUES ('2016-12', '2016-01-01 01:33:19', 'Aceite');
INSERT INTO Estado VALUES ('2016-13', '2016-02-01 07:15:27', 'Aceite');
INSERT INTO Estado VALUES ('2016-13', '2016-02-01 09:21:05', 'Paga');
