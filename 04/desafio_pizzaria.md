### **Exercício Proposto: Banco de Dados para a "Pizzaria SQL"**

#### **Objetivo**

Você foi contratado para desenvolver o sistema de banco de dados para uma nova pizzaria. O sistema precisa gerenciar clientes, o cardápio de pizzas e os pedidos realizados. O objetivo é criar um esquema de banco de dados relacional, normalizado e eficiente.

#### **Descrição do Sistema e Regras de Negócio**

1.  **Clientes:** O sistema precisa armazenar um cadastro dos clientes. As informações essenciais são o nome completo, um telefone de contato (que deve ser único, pois será usado para identificar o cliente) e o endereço de entrega.

2.  **Cardápio de Pizzas:** A pizzaria tem um cardápio fixo. Para cada pizza, precisamos saber seu nome (sabor, que deve ser único), uma breve descrição dos ingredientes e o seu preço unitário. Uma pizza não pode ser removida do cardápio se ela fizer parte do histórico de algum pedido.

3.  **Pedidos:** Esta é a entidade central. Um pedido é realizado por um, e somente um, cliente em uma data e hora específicas. O mais importante é que um pedido pode conter **várias pizzas diferentes** e **quantidades variadas** de cada uma (ex: 2 pizzas de Calabresa e 1 de Quatro Queijos). Para cada item dentro de um pedido, é crucial registrar a quantidade e o valor unitário da pizza no momento da compra, pois os preços no cardápio podem mudar no futuro. Cada pedido também deve ter um status (ex: 'Em preparo', 'A caminho', 'Entregue') e um valor total calculado.

#### **Sua Tarefa**

1.  Identificar as entidades e seus atributos.
2.  Definir os tipos de dados, chaves primárias e estrangeiras.
3.  Criar a tabela de ligação necessária para representar o relacionamento N-para-N entre pedidos e pizzas.
4.  Definir as regras de integridade referencial (`ON DELETE`, `ON UPDATE`) apropriadas para cada relacionamento.
5.  Escrever o script SQL completo com os comandos `CREATE TABLE`.

### Solução SQL Criação do Banco:

```sql
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
```

### Inserts no Banco de Dados

```sql
-- Inserindo Clientes
INSERT INTO Clientes (nome, telefone, endereco) VALUES
('Ana Beatriz', '11988887777', 'Rua das Flores, 123'),
('Carlos Silva', '11977776666', 'Avenida Paulista, 1000'),
('Maria Souza', '21966665555', 'Praça da Sé, 456'),
('Bruno Mendes', '11955554444', 'Rua Augusta, 789');

-- Inserindo Pizzas
INSERT INTO Pizzas (sabor, ingredientes, valor) VALUES
('Calabresa', 'Molho de tomate, queijo mussarela, calabresa fatiada, cebola e azeitonas.', 45.00),
('Mussarela', 'Molho de tomate, queijo mussarela e orégano.', 40.00),
('Quatro Queijos', 'Molho de tomate, mussarela, parmesão, provolone e gorgonzola.', 55.00),
('Frango com Catupiry', 'Molho de tomate, frango desfiado, catupiry e milho.', 52.50),
('Portuguesa', 'Molho, mussarela, presunto, ovo, cebola, pimentão e azeitona.', 50.00);

-- Pedidos e Itens
INSERT INTO Pedidos (cliente_id, data_hora, status, valor_total) VALUES (3, '2025-09-11 20:00:00', 'Entregue', 97.50);
INSERT INTO Pedido_Itens (pedido_id, pizza_id, quantidade, valor_unitario) VALUES
(1, 1, 1, 45.00),
(1, 4, 1, 52.50);

INSERT INTO Pedidos (cliente_id, data_hora, status, valor_total) VALUES (1, '2025-09-11 20:15:00', 'Entregue', 110.00);
INSERT INTO Pedido_Itens (pedido_id, pizza_id, quantidade, valor_unitario) VALUES
(2, 3, 2, 55.00);

INSERT INTO Pedidos (cliente_id, data_hora, status, valor_total) VALUES (2, '2025-09-12 19:30:00', 'Em preparo', 50.00);
INSERT INTO Pedido_Itens (pedido_id, pizza_id, quantidade, valor_unitario) VALUES
(3, 5, 1, 50.00);

INSERT INTO Pedidos (cliente_id, data_hora, status, valor_total) VALUES (3, '2025-09-12 18:45:00', 'A caminho', 40.00);
INSERT INTO Pedido_Itens (pedido_id, pizza_id, quantidade, valor_unitario) VALUES
(4, 2, 1, 40.00);
```