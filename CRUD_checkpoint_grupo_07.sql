show databases;

USE mydb;

-- Ingreso de registros en tablas tipo de interes & tipos de cuenta
INSERT INTO mydb.types_interes (id,name) VALUES
    (1, 'Interés Fijo'),
    (2, 'Interés Variable'),
    (3,'Otros Intereses');

INSERT INTO mydb.types_account (name) VALUES
    ('C.A.'),
    ('C.C.'),
    ('Otras');


-- Actualizacion de registros 
UPDATE mydb.types_account
SET name = 'CAJA DE AHORRO'
WHERE id=1;

-- Ejecutar con modo safe desactivado
UPDATE mydb.types_account
SET name = 'CAJA DE AHORRO'
WHERE name = 'C.A.';

UPDATE mydb.types_account
SET name = 'CUENTA CORRIENTE'
WHERE id = 2;

-- Ejecutar con modo safe desactivado
UPDATE mydb.types_account
SET name = 'CUENTA CORRIENTE'
WHERE name = 'C.C.';


-- Eliminacion de registros
DELETE FROM mydb.types_account
WHERE id=3;


-- Query de tablas
SELECT * FROM mydb.types_account;
SELECT * FROM mydb.types_interes;