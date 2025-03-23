-- Crear la base de datos
CREATE DATABASE hidroponia_db;

-- Conectar a la base de datos
\c hidroponia_db;

-- Crear un usuario exclusivo para esta base de datos
CREATE USER hidroponia_user WITH ENCRYPTED PASSWORD 'segura123';
GRANT CONNECT ON DATABASE hidroponia_db TO hidroponia_user;
GRANT USAGE, CREATE ON SCHEMA public TO hidroponia_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO hidroponia_user;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO hidroponia_user;

-- Crear tabla de roles
CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    descripcion TEXT
);

-- Crear tabla de estados de usuario
CREATE TABLE estados (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    descripcion TEXT
);

-- Crear tabla de usuarios
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre_usuario VARCHAR(50) UNIQUE NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    contrasena TEXT NOT NULL,
    rol_id INT NOT NULL,
    estado_id INT NOT NULL,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (rol_id) REFERENCES roles(id) ON DELETE CASCADE,
    FOREIGN KEY (estado_id) REFERENCES estados(id) ON DELETE CASCADE
);

-- Índices adicionales para mejorar el rendimiento
CREATE INDEX idx_usuarios_correo ON usuarios(correo);
CREATE INDEX idx_usuarios_nombre_usuario ON usuarios(nombre_usuario);

-- Insertar datos de prueba
INSERT INTO roles (nombre, descripcion) VALUES ('admin', 'Administrador del sistema');
INSERT INTO roles (nombre, descripcion) VALUES ('usuario', 'Usuario estándar');

INSERT INTO estados (nombre, descripcion) VALUES ('activo', 'Cuenta activa');
INSERT INTO estados (nombre, descripcion) VALUES ('inactivo', 'Cuenta inactiva');
INSERT INTO estados (nombre, descripcion) VALUES ('bloqueado', 'Cuenta bloqueada por intentos fallidos');

INSERT INTO usuarios (nombre_usuario, correo, contrasena, rol_id, estado_id)
VALUES ('admin', 'admin@example.com', crypt('password123', gen_salt('bf')), 1, 1);
