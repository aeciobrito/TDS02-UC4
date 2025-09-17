CREATE DATABASE IF NOT EXISTS PizzariaDB;
USE PizzariaDB;

-- Tabela de Clientes
CREATE TABLE IF NOT EXISTS Clientes (
    codCliente INT NOT NULL AUTO_INCREMENT,
    nomeCliente VARCHAR(100) NOT NULL,
    telefoneCliente VARCHAR(20) NOT NULL,
    enderecoCliente VARCHAR(255) NULL,
    PRIMARY KEY (codCliente),
    CONSTRAINT uq_telefoneCliente UNIQUE (telefoneCliente)
);

-- Tabela do Cardápio de Pizzas
CREATE TABLE IF NOT EXISTS Pizzas (
    codPizza INT NOT NULL AUTO_INCREMENT,
    saborPizza VARCHAR(50) NOT NULL,
    ingredientes TEXT NULL,
    valorPizza DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (codPizza),
    CONSTRAINT uq_saborPizza UNIQUE (saborPizza)
);

-- Tabela Principal de Pedidos
CREATE TABLE IF NOT EXISTS Pedidos (
    codPedido INT NOT NULL AUTO_INCREMENT,
    codCliente INT NULL, -- Pode ser nulo se o cliente não quiser se cadastrar
    dataHoraPedido DATETIME NOT NULL,
    statusPedido VARCHAR(20) DEFAULT 'Em preparo',
    valorTotalPedido DECIMAL(10, 2) NULL,
    PRIMARY KEY (codPedido),
    -- Se um cliente for excluído, os pedidos permanecem mas sem vínculo (SET NULL)
    CONSTRAINT fk_Pedidos_Clientes
        FOREIGN KEY (codCliente)
        REFERENCES Clientes (codCliente)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Tabela de Ligação (Itens de cada Pedido)
CREATE TABLE IF NOT EXISTS Pedido_Itens (
    codPedido INT NOT NULL,
    codPizza INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    valorUnitario DECIMAL(10, 2) NOT NULL, -- Preço da pizza no momento do pedido
    PRIMARY KEY (codPedido, codPizza), -- Chave primária composta
    -- Se um pedido for excluído, seus itens também são (CASCADE)
    CONSTRAINT fk_Itens_Pedidos
        FOREIGN KEY (codPedido)
        REFERENCES Pedidos (codPedido)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    -- Impede que uma pizza do cardápio seja excluída se estiver em um pedido (RESTRICT)
    CONSTRAINT fk_Itens_Pizzas
        FOREIGN KEY (codPizza)
        REFERENCES Pizzas (codPizza)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);