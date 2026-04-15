DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
USE hospital;

-- Area administrativa 
CREATE TABLE hospital(
    id_hospital INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    provincia VARCHAR(50) NOT NULL
);

CREATE TABLE departamento (
    id_departamento INT AUTO_INCREMENT PRIMARY KEY ,
    nombre VARCHAR(100) NOT NULL,
    id_hospital INT ,
    FOREIGN KEY (id_hospital) REFERENCES hospital(id_hospital)
);

CREATE TABLE personalAdministrativo (
    id_admin INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni varchar(20) UNIQUE NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento)
);

CREATE TABLE turno (
    id_turno INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL
);

CREATE TABLE rol (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL
);

CREATE TABLE empleado (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    id_rol INT,
    id_turno INT,
    FOREIGN KEY (id_rol) REFERENCES rol(id_rol),
    FOREIGN KEY (id_turno) REFERENCES turno(id_turno)
);

CREATE TABLE horario (
    id_horario INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT,
    dia_semana ENUM('Lunes','Martes','Miércoles','Jueves','Viernes','Sábado','Domingo') NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE guardia (
    id_guardia INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT,
    fecha DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    observaciones TEXT NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE area (
    id_area INT AUTO_INCREMENT PRIMARY KEY,
    nombre_area VARCHAR(100) NOT NULL,
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento)
);

CREATE TABLE empleado_area (
    id_empleado INT,
    id_area INT,
    PRIMARY KEY (id_empleado, id_area),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_area) REFERENCES area(id_area)
);


-- Area Medica

CREATE TABLE medico (
    id_medico INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(15) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    fecha_ingreso DATE NOT NULL
);

CREATE TABLE especialidad (
    id_especialidad INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    descripcion TEXT
);

CREATE TABLE medico_especialidad (
    id_medico INT,
    id_especialidad INT,
	PRIMARY KEY (id_medico, id_especialidad),
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico),
    FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad)
);

CREATE TABLE consultorio (
    id_consultorio INT PRIMARY KEY AUTO_INCREMENT,
    numero INT NOT NULL,
    piso INT NOT NULL,
    especialidad_asignada INT,
    FOREIGN KEY (especialidad_asignada) REFERENCES especialidad(id_especialidad)
);

CREATE TABLE paciente (
    id_paciente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(15) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    sexo CHAR(1) NOT NULL,
    direccion VARCHAR(200) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

CREATE TABLE cita (
    id_cita INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT,
    id_medico INT,
    id_consultorio INT,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    motivo TEXT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico),
    FOREIGN KEY (id_consultorio) REFERENCES consultorio(id_consultorio)
);

CREATE TABLE enfermero (
    id_enfermero INT PRIMARY KEY AUTO_INCREMENT,
    id_cita int,
    id_empleado int,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(15) NOT NULL,
    turno VARCHAR(20) NOT NULL,
    foreign key(id_cita) references cita(id_cita),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

CREATE TABLE diagnostico (
    id_diagnostico INT PRIMARY KEY AUTO_INCREMENT,
    id_medico INT,
    id_paciente INT,
    descripcion TEXT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico)
);

CREATE TABLE receta (
    id_receta INT PRIMARY KEY AUTO_INCREMENT,
    id_medico INT,
    id_diagnostico INT,
    medicamento VARCHAR(100) NOT NULL,
    dosis VARCHAR(50) NOT NULL,
    duracion VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_diagnostico) REFERENCES diagnostico(id_diagnostico),
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico)
);

CREATE TABLE tratamiento (
    id_tratamiento INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    duracion_aproximada VARCHAR(50) NOT NULL
);

CREATE TABLE paciente_tratamiento (
    id_paciente INT,
    id_tratamiento INT,
    fecha_inicio DATE,
    fecha_fin DATE,
	PRIMARY KEY (id_paciente, id_tratamiento),
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    FOREIGN KEY (id_tratamiento) REFERENCES tratamiento(id_tratamiento)
);

CREATE TABLE estudioMedico (
    id_estudio INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL, 
    descripcion TEXT NOT NULL,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE laboratorio (
    id_laboratorio INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL
);

CREATE TABLE resultadoEstudio (
    id_resultado INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT,
    id_estudio INT,
    id_laboratorio INT,
    fecha DATE,
    resultado TEXT,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    FOREIGN KEY (id_estudio) REFERENCES estudioMedico(id_estudio),
    FOREIGN KEY (id_laboratorio) REFERENCES laboratorio(id_laboratorio)
);

CREATE TABLE habitacion (
    id_habitacion INT PRIMARY KEY AUTO_INCREMENT,
    numero INT NOT NULL,
    piso INT NOT NULL,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE cama (
    id_cama INT PRIMARY KEY AUTO_INCREMENT,
    id_habitacion INT,
    numero_cama INT NOT NULL,
    estado VARCHAR(20) NOT NULL, -- disponible, ocupada
    FOREIGN KEY (id_habitacion) REFERENCES habitacion(id_habitacion)
);

CREATE TABLE internacion (
    id_internacion INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT,
    id_cama INT,
    fecha_ingreso DATE NOT NULL,
    fecha_egreso DATE NOT NULL,
    motivo TEXT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    FOREIGN KEY (id_cama) REFERENCES cama(id_cama)
);

CREATE TABLE cirugia (
    id_cirugia INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT,
    tipo VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    duracion TIME NOT NULL,
    resultado TEXT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente)
);

CREATE TABLE anestesia (
    id_anestesia INT PRIMARY KEY AUTO_INCREMENT,
    id_cirugia INT,
    tipo VARCHAR(100)  NOT NULL,
    cantidad_ml DECIMAL(5,2)  NOT NULL,
    observaciones TEXT  NOT NULL,
    FOREIGN KEY (id_cirugia) REFERENCES cirugia(id_cirugia)
);

CREATE TABLE equipoQuirurgico (
    id_equipo INT PRIMARY KEY AUTO_INCREMENT,
    id_cirugia INT,
    nombre_equipo VARCHAR(100)  NOT NULL,
    cantidad_usada INT  NOT NULL,
    FOREIGN KEY (id_cirugia) REFERENCES cirugia(id_cirugia)
);

CREATE TABLE urgencia (
    id_urgencia INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT,
    fecha_ingreso DATETIME NOT NULL,
    gravedad VARCHAR(50) NOT NULL,
    descripcion TEXT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente)
);

-- Farmacia y suministros

CREATE TABLE categoriaMedicamento (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE medicamento (
    id_medicamento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT  NOT NULL,
    id_categoria INT  NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoriaMedicamento(id_categoria)
);

CREATE TABLE stockFarmacia (
    id_stock INT AUTO_INCREMENT PRIMARY KEY,
    id_medicamento INT,
    cantidad INT NOT NULL,
    fecha_actualizacion DATE NOT NULL,
    FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento)
);

CREATE TABLE proveedor (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    direccion TEXT NOT NULL
);

CREATE TABLE pedidoMedicamento (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT,
    id_medicamento INT,
    cantidad INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    estado ENUM('Pendiente', 'Recibido', 'Cancelado') NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
    FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento)
);

CREATE TABLE insumoMedico (
    id_insumo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE stockInsumo (
    id_stock_insumo INT AUTO_INCREMENT PRIMARY KEY,
    id_insumo INT,
    cantidad INT NOT NULL,
    fecha_actualizacion DATE NOT NULL,
    FOREIGN KEY (id_insumo) REFERENCES insumoMedico(id_insumo)
);

CREATE TABLE solicitudInsumo (
    id_solicitud INT AUTO_INCREMENT PRIMARY KEY,
    id_insumo INT,
    cantidad INT NOT NULL,
    fecha_solicitud DATE NOT NULL,
    solicitado_por VARCHAR(100) NOT NULL,
    estado ENUM('Pendiente', 'Aprobado', 'Rechazado') NOT NULL,
    FOREIGN KEY (id_insumo) REFERENCES insumoMedico(id_insumo)
);

-- Area financiera
CREATE TABLE metodoPago (
    id_metodo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT NOT NULL
);

CREATE TABLE seguro (
    id_seguro INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL NOT NULL,
    telefono_contacto VARCHAR(20) NOT NULL,
    direccion VARCHAR(150) NOT NULL
);

CREATE TABLE cobertura (
    id_cobertura INT AUTO_INCREMENT PRIMARY KEY,
    id_seguro INT,
    descripcion TEXT NOT NULL,
    porcentaje_cobertura DECIMAL(5,2) NOT NULL, -- por ejemplo: 80.00 = 80%
    FOREIGN KEY (id_seguro) REFERENCES seguro(id_seguro)
);

CREATE TABLE factura (
    id_factura INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT,
    id_metodo INT,
    id_cobertura INT,
    fecha_emision DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    observaciones TEXT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    FOREIGN KEY (id_metodo) REFERENCES metodoPago(id_metodo),
    FOREIGN KEY (id_cobertura) REFERENCES cobertura(id_cobertura)
);