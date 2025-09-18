# Todos os exercícios se resolvem com apenas 1 JOIN

#### **INNER JOIN**

* **1. Listar os pedidos e os nomes dos clientes que os fizeram.**

    * **Objetivo:** Queremos ver o `id` e a `data_hora` de cada pedido ao lado do `nome` do cliente correspondente.

* **2. Mostrar os sabores de pizza em cada item de pedido.**

    * **Objetivo:** Queremos ver o `sabor` de cada pizza, a `quantidade` pedida e o `valor_unitario` registrado na venda.

#### **LEFT JOIN**

O `LEFT JOIN` traz **todos** os registros da tabela da **esquerda** e tenta combinar com os da direita. Se não houver combinação, os campos da tabela da direita ficarão com o valor `NULL`.

  * **1. Listar TODOS os clientes e os pedidos que eles fizeram.**

      * **Objetivo:** Queremos garantir que todos os clientes da nossa base apareçam, mesmo aqueles que nunca compraram. Exiba o `nome` do cliente e o `id` do pedido.

  * **2. Descobrir quais pizzas do cardápio nunca foram vendidas.**

      * **Objetivo:** Queremos verificar no nosso cardápio (`Pizzas`) quais sabores ainda não tiveram saída. Exiba apenas o `sabor` da pizza.

# RESPOSTAS:

# 1. Listar os pedidos e os nomes dos clientes que os fizeram.
# Objetivo: Queremos ver o id e a data_hora de cada pedido ao lado do nome do cliente correspondente.

SELECT 
	Pedidos.id, 
    Pedidos.data_hora, 
    clientes.nome 
FROM Pedidos
INNER JOIN clientes ON clientes.id = pedidos.cliente_id;

# 2. Mostrar os sabores de pizza em cada item de pedido.
# Objetivo: Queremos ver o sabor de cada pizza, a quantidade pedida e o valor_unitario registrado na venda.
-- VERSÃO 1
SELECT
	Pizzas.sabor,
    Pedido_Itens.quantidade,
    Pedido_Itens.valor_unitario
FROM Pizzas
INNER JOIN Pedido_Itens ON Pedido_Itens.pizza_id = Pizzas.id;
-- VERSÃO 2
SELECT
	Pizzas.sabor,
    Pedido_Itens.quantidade,
    Pedido_Itens.valor_unitario
FROM Pedido_Itens
INNER JOIN Pizzas ON Pedido_Itens.pizza_id = Pizzas.id;

#### LEFT JOINS

# 1. Listar TODOS os clientes e os pedidos que eles fizeram.
# Objetivo: Queremos garantir que todos os clientes da nossa base apareçam, mesmo aqueles que nunca compraram. Exiba o nome do cliente e o id do pedido.

SELECT * FROM Clientes
LEFT JOIN Pedidos ON Clientes.id = Pedidos.cliente_id
ORDER BY clientes.id;

#2. Descobrir quais pizzas do cardápio nunca foram vendidas.
# Objetivo: Queremos verificar no nosso cardápio (Pizzas) quais sabores ainda não tiveram saída. Exiba apenas o sabor da pizza.

SELECT * 
FROM Pizzas
LEFT JOIN Pedido_Itens ON Pizzas.id = Pedido_Itens.pizza_id
WHERE pedido_itens.pedido_id IS NULL;