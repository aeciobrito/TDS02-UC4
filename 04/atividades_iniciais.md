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