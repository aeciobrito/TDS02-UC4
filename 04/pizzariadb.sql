CREATE DATABASE IF NOT EXISTS PizzariaDB;
USE PizzariaDB;

-- Tabela de Clientes
CREATE TABLE IF NOT EXISTS Clientes (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    endereco VARCHAR(255) NULL,
    PRIMARY KEY (id),
    CONSTRAINT uq_telefone UNIQUE (telefone)
);

-- Tabela de Pizzas
CREATE TABLE IF NOT EXISTS Pizzas (
    id INT NOT NULL AUTO_INCREMENT,
    sabor VARCHAR(50) NOT NULL,
    ingredientes TEXT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT uq_sabor UNIQUE (sabor)
);

-- Tabela de Pedidos
CREATE TABLE IF NOT EXISTS Pedidos (
    id INT NOT NULL AUTO_INCREMENT,
    cliente_id INT NULL,
    data_hora DATETIME NOT NULL,
    status VARCHAR(20) DEFAULT 'Em preparo',
    valor_total DECIMAL(10, 2) NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_pedidos_clientes
        FOREIGN KEY (cliente_id)
        REFERENCES Clientes (id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Tabela de Itens do Pedido
CREATE TABLE IF NOT EXISTS Pedido_Itens (
    pedido_id INT NOT NULL,
    pizza_id INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    valor_unitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (pedido_id, pizza_id),
    CONSTRAINT fk_itens_pedidos
        FOREIGN KEY (pedido_id)
        REFERENCES Pedidos (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_itens_pizzas
        FOREIGN KEY (pizza_id)
        REFERENCES Pizzas (id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);