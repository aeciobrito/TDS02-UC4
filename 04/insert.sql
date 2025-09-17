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

------ INSERT ADICIONAL PARA MAIS RESULTADOS NAS CONSULTAS ------

-- Inserindo um cliente novo que ainda não fez pedidos.
INSERT INTO Clientes (nome, telefone, endereco) VALUES 
('Juliana Alves', '11944443333', 'Alameda Santos, 500');

-- Inserindo uma pizza nova que ainda não foi vendida.
INSERT INTO Pizzas (sabor, ingredientes, valor) VALUES 
('Marguerita', 'Molho de tomate, mussarela, tomate fresco e manjericão.', 42.00);

-- Inserindo um pedido que não tem um cliente cadastrado (venda de balcão).
-- Note que o 'cliente_id' é NULL.
INSERT INTO Pedidos (cliente_id, data_hora, status, valor_total) VALUES 
(NULL, '2025-09-13 12:00:00', 'Entregue', 42.00);
-- O pedido acima (que terá o id 5) precisa de um item. Vamos adicionar a pizza nova.
INSERT INTO Pedido_Itens (pedido_id, pizza_id, quantidade, valor_unitario) VALUES 
(5, 6, 1, 42.00);