# INNER JOINS
## 1 - VER OS DETALHES DE UM PEDIDO ESPECÍFICO
## Pedido.id, pizza.sabor, pedido_item.quantidade, pedido_item.valorUnitario

```sql
SELECT pedidos.id, pizzas.sabor, pedido_itens.quantidade, pedido_itens.valor_unitario
FROM pedidos
INNER JOIN pedido_itens ON pedidos.id = pedido_itens.pedido_id
INNER JOIN pizzas ON pedido_itens.pizza_id = pizzas.id;
```

## 2 - Listar todos os pedidos entreges com o nome e telefone do cliente
## pedido.id, pedido.dataHora, cliente.nome, cliente.telefone


# LEFT JOINS
## 3 - Mostrar todos os clientes e a quantidade de pedidos que cada um fez. clientes sem pedidos devem aparecer com 0
## cliente.nome, *COUNT*

## 4 - Descobrir quais pizzas do cardápio NUNCA foram vendidas
## pizzas.sabor, pizzas.valor
