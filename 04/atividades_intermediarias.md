# Todos os exercícios se resolvem com apenas 2 JOINS

Agora que entendemos como juntar duas tabelas, vamos praticar juntando três tabelas em uma única consulta.

  * **Exercício 1: Relatório Detalhado de Itens Vendidos**

      * **Tarefa:** Crie uma consulta que mostre os detalhes de todos os itens já pedidos. A consulta deve ligar os pedidos aos seus itens e os itens às informações das pizzas.
      * **Campos a exibir:**
          * Da tabela `Pedidos`, mostre o campo `id`.
          * Da tabela `Pedidos`, mostre o campo `data_hora`.
          * Da tabela `Pizzas`, mostre o campo `sabor`.
          * Da tabela `Pedido_Itens`, mostre o campo `quantidade`.


  * **Exercício 2: Quais clientes pediram quais pizzas?**

      * **Tarefa:** Gere um relatório que mostre o nome do cliente e o sabor da pizza para cada item de pedido que ele realizou. Isso requer ligar o cliente ao pedido, e o pedido ao item, e o item à pizza.
      * **Campos a exibir:**
          * Da tabela `Clientes`, mostre o campo `nome`.
          * Da tabela `Pedidos`, mostre a `data_hora` do pedido.
          * Da tabela `Pizzas`, mostre o `sabor` da pizza.
