CREATE DATABASE EstacionamentoDB;
GO

USE EstacionamentoDB;
GO

CREATE TABLE Clientes (
	id INT IDENTITY(1,1) PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	cpf VARCHAR(14) NOT NULL UNIQUE,
	telefone VARCHAR(20) NULL
);
GO

CREATE TABLE Vagas (
	id INT IDENTITY(1,1) PRIMARY KEY,
	localizacao VARCHAR(50) NOT NULL,
	tipo VARCHAR(20) NULL
);
GO

CREATE TABLE Veiculos (
	id INT IDENTITY(1,1) PRIMARY KEY,
	cliente_id INT NOT NULL,
	placa VARCHAR(10) NOT NULL UNIQUE,
	modelo VARCHAR(50) NULL,
	cor VARCHAR(30) NULL,
	CONSTRAINT FK_Veiculo_Cliente
		FOREIGN KEY (cliente_id) REFERENCES Clientes (id)
);
GO

CREATE TABLE RegistrosEstacionamento (
	id INT IDENTITY(1,1) PRIMARY KEY,
	veiculo_id INT NOT NULL,
	vaga_id INT NOT NULL,
	data_hora_entrada DATETIME2 NOT NULL,
	data_hora_saida DATETIME2 NULL,
	valor_final DECIMAL (10, 2) NULL,
	CONSTRAINT FK_Registro_Veiculo
		FOREIGN KEY (veiculo_id) REFERENCES Veiculos (id),
	CONSTRAINT FK_Registro_Vaga
		FOREIGN KEY (vaga_id) REFERENCES Vagas (id)
);
GO
