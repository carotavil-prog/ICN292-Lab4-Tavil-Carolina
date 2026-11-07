DROP DATABASE IF EXISTS austral;
CREATE DATABASE austral;
USE austral;
# tablas --------------------------
CREATE TABLE autores (
    id_autor INT AUTO_INCREMENT,
    nombre VARCHAR(80) NOT NULL,
    pais VARCHAR(60),
    genero ENUM('Cómic', 'Ensayo', 'Infantil', 'Novela', 'Poesía') NOT NULL,
    PRIMARY KEY (id_autor)
);

CREATE TABLE colecciones (
    id_coleccion INT AUTO_INCREMENT,
    titulo VARCHAR(120) NOT NULL,
    fecha_publicacion DATE,
    PRIMARY KEY (id_coleccion)
);

CREATE TABLE libros (
    id_libro INT AUTO_INCREMENT,
    id_autor INT,
    id_coleccion INT,
    titulo VARCHAR(120) NOT NULL,
    paginas INT,
    ejemplares_vendidos INT,
    anio INT,
    PRIMARY KEY (id_libro),
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor),
    FOREIGN KEY (id_coleccion) REFERENCES colecciones(id_coleccion)
);

CREATE TABLE pagos (
    id_pago INT AUTO_INCREMENT,
    id_autor INT,
    fecha_pago DATE,
    monto DECIMAL(10,2),
    PRIMARY KEY (id_pago),
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor)
);

#base de datos-----------------------------------------
#autoress
INSERT INTO autores (nombre, pais, genero) VALUES
('Elena Pizarro', 'Chile', 'Novela'),
('Harold Finch', 'Inglaterra', 'Ensayo'),
('Rodrigo Bahamonde', 'Chile', 'Poesía'),
('Valentina Correa', 'Argentina', 'Infantil'),
('Nora Keller', 'Estados Unidos', 'Novela'),
('Kenji Arakawa', NULL, 'Cómic');
#libros
INSERT INTO libros (id_autor, id_coleccion, titulo, paginas, ejemplares_vendidos, anio) VALUES
(1, 1, 'Cielo de Enero', 210, 1500, 2024),
(1, 1, 'Marea Baja', 185, 800, 2023),
(1, 2, 'El Norte', 200, 2200, 2024),
(2, 1, 'Estrellas que Caen', 240, 3000, 2022),
(2, 2, 'Máquinas', 215, 450, 2024),
(3, 1, 'Luz Artificial', 300, 1200, 2024),
(3, 3, 'Ruido Blanco', 280, 600, 2023),
(4, 1, 'El Barrio de Lila', 190, 5000, 2024),
(4, 2, 'Antes del Amanecer', 205, 2700, 2024),
(4, 1, 'La Calle 8', 175, 900, 2023),
(5, 3, 'Flor de Hierro', 195, 4100, 2024),
(5, 1, 'Hora Dorada', 220, 1800, 2022);
#pagos
INSERT INTO pagos (id_autor, fecha_pago, monto) VALUES
(1, '2024-05-12', 450000.50),
(1, '2024-08-20', 300000.00),
(3, '2024-07-10', 520000.75);

#consultas entregable 2----------------------
#consulta 1-----------------------
SELECT nombre, genero
FROM autores
WHERE pais <> 'Chile' OR pais IS NULL
ORDER BY nombre ASC;
#consulta 2----------------------
SELECT titulo, paginas
FROM libros
WHERE paginas BETWEEN 190 AND 220
ORDER BY paginas ASC;
#consulta 3----------------------
SELECT 
    COUNT(*) AS total_libros,
    SUM(ejemplares_vendidos) AS suma_ejemplares,
    AVG(paginas) AS promedio_paginas,
    MIN(anio) AS anio_antiguo,
    MAX(ejemplares_vendidos) AS max_ejemplares
FROM libros;
#consulta 4---------------------
SELECT DISTINCT genero
FROM autores
ORDER BY genero ASC;
#consulta 5------------------
SELECT a.nombre, COUNT(*) AS libros_2024
FROM autores a
JOIN libros l ON a.id_autor = l.id_autor
WHERE l.anio = 2024
GROUP BY a.id_autor, a.nombre
HAVING COUNT(*) > 1
ORDER BY a.nombre ASC;
#consulta 6-------------------

SELECT titulo, ejemplares_vendidos
FROM libros
WHERE anio = 2024 AND ejemplares_vendidos > 2000
ORDER BY ejemplares_vendidos DESC
LIMIT 3;
#consulta 7--------------------
INSERT INTO libros (id_autor, id_coleccion, titulo, paginas, ejemplares_vendidos, anio) 
VALUES (3, 1, 'Papel Mojado', 260, 50, 2024);
SELECT * FROM libros WHERE titulo = 'Papel Mojado';
DELETE FROM libros WHERE titulo = 'Papel Mojado';
SELECT * FROM libros WHERE titulo = 'Papel Mojado';

#consulta 8--------------------
SELECT titulo, ejemplares_vendidos 
FROM libros 
WHERE titulo = 'Cielo de Enero';

UPDATE libros 
SET ejemplares_vendidos = ejemplares_vendidos + 100 
WHERE titulo = 'Cielo de Enero';

SELECT titulo, ejemplares_vendidos 
FROM libros 
WHERE titulo = 'Cielo de Enero';

#consulta 9-------------------
SELECT l.titulo AS libro, c.titulo AS coleccion, c.fecha_publicacion
FROM libros l
JOIN colecciones c ON l.id_coleccion = c.id_coleccion;
#consulta 10------------------
SELECT a.nombre, p.fecha_pago, p.monto
FROM pagos p
JOIN autores a ON p.id_autor = a.id_autor;

SELECT a.nombre, SUM(p.monto) AS total_pagado
FROM pagos p
JOIN autores a ON p.id_autor = a.id_autor
GROUP BY a.id_autor, a.nombre;