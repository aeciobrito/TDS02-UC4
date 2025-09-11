CREATE DATABASE IF NOT EXISTS EstacionamentoDB;
USE EstacionamentoDB;

CREATE TABLE IF NOT EXISTS Cliente (
    id INT NOT  NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR (20) NULL
);

CREATE TABLE IF NOT EXISTS Veiculo (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    placa VARCHAR(10) NOT NULL UNIQUE,
    modelo VARCHAR(50) NULL,
    cor VARCHAR(30) NULL,
    CONSTRAINT fk_veiculo_cliente 
    FOREIGN KEY (cliente_id)
    REFERENCES Cliente (id)
);

CREATE TABLE IF NOT EXISTS Vaga (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    localizacao VARCHAR (50) NOT NULL UNIQUE,
    tipoVaga VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS RegistroEstacionamento (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    veiculo_id INT NOT NULL,
    vaga_id INT NOT NULL,
    dataHoraEntrada DATETIME NOT NULL,
    dataHoraSaida DATETIME NULL,
    valorFinal DECIMAL (10, 2) NULL,
    CONSTRAINT fk_registro_veiculo FOREIGN KEY (veiculo_id) REFERENCES Veiculo (id),
    CONSTRAINT fk_registro_vaga FOREIGN KEY (vaga_id) REFERENCES Vaga (id)
);







