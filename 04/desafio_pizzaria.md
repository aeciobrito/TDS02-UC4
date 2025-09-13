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