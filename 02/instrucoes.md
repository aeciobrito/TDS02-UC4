
### **Exercício de Modelagem de Banco de Dados: Sistema de Estacionamento**

#### **Objetivo**

Projetar e criar o esquema de um banco de dados relacional para gerenciar as operações de um estacionamento de veículos. Você deverá aplicar os conceitos de modelagem de dados, criação de tabelas, definição de chaves primárias e estrangeiras, e estabelecimento de regras de integridade referencial, inspirando-se na estrutura do banco de dados `PousadaDB` apresentado anteriormente.

#### **Descrição do Sistema**

O sistema de estacionamento "Sempre Rápido" precisa de um novo banco de dados para controlar o fluxo de veículos de seus clientes. O funcionamento do sistema deve seguir as seguintes regras de negócio:

1.  **Clientes:** O estacionamento precisa manter um cadastro de seus clientes. Para cada cliente, é necessário armazenar um nome completo, o CPF (que é único por cliente) e um número de telefone para contato. Um cliente pode não ter nenhum veículo cadastrado ou pode ter vários.

2.  **Veículos:** O sistema deve registrar os veículos associados a cada cliente. Cada veículo pertence a um, e somente um, cliente. As informações essenciais de um veículo são sua placa (que deve ser única em todo o sistema), modelo e cor. A exclusão de um cliente do sistema deve resultar na exclusão de todos os veículos associados a ele.

3.  **Vagas:** O estacionamento é composto por vagas fixas. Cada vaga tem um código único de identificação e uma localização descritiva (ex: "Setor A-01", "Setor B-12"). Além disso, as vagas são classificadas por tipo, como "Pequena" (para motos), "Média" (para carros de passeio) e "Grande" (para SUVs e utilitários). Uma vaga não pode ser removida do sistema se houver registros históricos de estacionamento associados a ela.

4.  **Registro de Estacionamento:** Esta é a operação central do sistema. Toda vez que um veículo entra no estacionamento, um novo registro de uso é criado. Este registro deve conter:

      * Qual veículo está estacionando.
      * Em qual vaga ele está parando.
      * A data e a hora exatas da entrada.

    Quando o veículo sai, o mesmo registro é atualizado com a data e a hora exatas da saída. O sistema também deve ter um campo para armazenar o valor final a ser pago, que será calculado e preenchido no momento da saída. É fundamental para o histórico do estacionamento que um veículo com registros de uso não possa ser excluído.

#### **Sua Tarefa**

Com base na descrição acima, você deve:

1.  Identificar as entidades principais do sistema.
2.  Definir os atributos para cada entidade, escolhendo os tipos de dados mais adequados.
3.  Estabelecer os relacionamentos entre as entidades, definindo as chaves primárias e estrangeiras.
4.  ~~Determinar as regras de integridade referencial (`ON DELETE` e `ON UPDATE`) mais apropriadas para cada relacionamento, justificando suas escolhas (por exemplo, por que usar `CASCADE` em uma situação e `RESTRICT` em outra).~~
5.  Escrever o script SQL completo com os comandos `CREATE TABLE` para construir o banco de dados.
