# Explicação das Escolhas e Restrições:

1.  **`PRIMARY KEY` (PK - Chave Primária):**

      * Em tabelas como `Cliente`, `Chale`, `Hospedagem` e `Servico`, foi utilizado um `INT NOT NULL AUTO_INCREMENT`. Esta é uma prática comum para criar um identificador único e numérico para cada registro, que é gerenciado automaticamente pelo banco de dados.
      * Em tabelas associativas como `Chale_Item` e `Hospedagem_Servico`, e na tabela `Telefone`, a chave primária é **composta**, formada pelas chaves estrangeiras. Isso garante a unicidade da relação entre as entidades. Por exemplo, em `Chale_Item`, a combinação de `codChale` e `nomeItem` deve ser única.

2.  **`FOREIGN KEY` (FK - Chave Estrangeira):**

      * Estas restrições são cruciais para manter a **integridade referencial** do banco de dados. Elas garantem que um registro em uma tabela "filha" (ex: `Hospedagem`) só pode existir se o registro correspondente na tabela "mãe" (ex: `Cliente`) também existir.

3.  **Ações de Chave Estrangeira (`ON DELETE` e `ON UPDATE`):**

      * **`ON DELETE CASCADE`**: Usado em `Telefone` e `Chale_Item`. Se um registro pai for deletado (ex: um `Cliente`), todos os registros filhos relacionados (seus `Telefone`s) serão automaticamente deletados. Isso é útil para dados que não fazem sentido existir sem o seu "dono".
      * **`ON DELETE RESTRICT`**: Usado em `Hospedagem` e `Hospedagem_Servico`. Esta opção impede que um registro pai (como um `Cliente` ou um `Chale`) seja deletado se ele estiver sendo referenciado por um registro filho (uma `Hospedagem`). Isso é fundamental para manter o histórico de dados e evitar a exclusão acidental de informações importantes.
      * **`ON UPDATE CASCADE`**: Usado na maioria das chaves estrangeiras. Se o valor da chave primária na tabela pai for alterado (o que é raro para chaves numéricas com `AUTO_INCREMENT`, mas é uma boa prática), a alteração será automaticamente propagada para os registros correspondentes na tabela filha, mantendo a consistência.

4.  **Tipos de Dados:**

      * **`INT`**: Para códigos e identificadores numéricos.
      * **`VARCHAR(n)`**: Para textos de tamanho variável, como nomes e endereços.
      * **`CHAR(2)`**: Para `estadoCliente`, pois siglas de estados no Brasil têm tamanho fixo de 2 caracteres.
      * **`DATE`**: Para armazenar datas, como `nascimentoCliente` e `dataInicio`.
      * **`DECIMAL(10, 2)`**: Para valores monetários, garantindo a precisão de duas casas decimais.
      * **`TEXT`**: Para descrições mais longas, como em `descricaoItem`.

5.  **`UNIQUE` Constraint:**

      * A restrição `UNIQUE` na coluna `rgCliente` da tabela `Cliente` garante que não haverá dois clientes cadastrados com o mesmo número de RG, adicionando uma camada extra de consistência aos dados, além da chave primária.