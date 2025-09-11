### **Aula Prática: Dominando os `JOINs` em SQL**

Aula prática de `JOINs`.

Hoje, vamos aprender a fazer uma das coisas mais poderosas em bancos de dados relacionais: **combinar informações de várias tabelas**. Os dados raramente moram em um lugar só. O nome do cliente está em uma tabela, sua hospedagem em outra, e o chalé que ele ocupou em uma terceira. O `JOIN` é a "cola" que une tudo isso para gerar relatórios e consultas úteis.

Vamos focar nos dois tipos de `JOIN` que você usará em 95% do seu tempo: `INNER JOIN` e `LEFT JOIN`.

-----

### **1. `INNER JOIN`: A Junção dos Dados em Comum**

Pense no `INNER JOIN` como um "detetive" que só traz resultados quando encontra uma correspondência exata em **ambas** as tabelas que você está ligando. Se um cliente existe mas nunca fez uma hospedagem, ele não aparecerá em uma consulta que une `Cliente` e `Hospedagem`.

É a intersecção perfeita entre dois ou mais conjuntos de dados.

#### **Exemplo Prático 1: Relatório Básico de Hospedagens**

  * **Consulta desejada:** "Quero ver uma lista de todas as hospedagens, mostrando o nome do cliente, a localização do chalé em que ele ficou e as datas de início e fim."
  * **Objetivo:** Criar um relatório operacional para a recepção ou para o financeiro, consolidando as informações mais importantes de uma estadia.
  * **Implementação:**

<!-- end list -->

```sql
SELECT
    -- Selecionamos colunas de tabelas diferentes usando o formato tabela.coluna
    cl.nomeCliente,
    ch.localizacao AS localizacao_chale,
    h.dataInicio,
    h.dataFim,
    h.estado
FROM
    Hospedagem AS h -- A tabela Hospedagem é nosso ponto de partida
INNER JOIN
    Cliente AS cl ON h.codCliente = cl.codCliente -- 1. Juntamos com Cliente pela chave em comum
INNER JOIN
    Chale AS ch ON h.codChale = ch.codChale; -- 2. Juntamos com Chale pela chave em comum
```

**Resultado:** Esta consulta retornará uma lista apenas com as hospedagens registradas, pois todas elas têm um `codCliente` e um `codChale` correspondentes nas outras tabelas.

#### **Exemplo Prático 2: Serviços Consumidos em uma Hospedagem Específica**

  * **Consulta desejada:** "O cliente da hospedagem de código `1` (João da Silva) ligou para fechar a conta. Preciso ver todos os serviços extras que ele consumiu, em qual data e o valor de cada um."
  * **Objetivo:** Detalhar os gastos de uma hospedagem específica para gerar a fatura final do cliente.
  * **Implementação:**

<!-- end list -->

```sql
SELECT
    h.codHospedagem,
    s.nomeServico,
    hs.dataServico,
    hs.valorServico -- Valor cobrado no dia
FROM
    Hospedagem_Servico AS hs -- Partimos da tabela que liga hospedagem e serviço
INNER JOIN
    Servico AS s ON hs.codServico = s.codServico
INNER JOIN
    Hospedagem AS h ON hs.codHospedagem = h.codHospedagem
WHERE
    hs.codHospedagem = 1; -- Filtramos para a hospedagem de interesse
```

**Resultado:** Vemos uma lista detalhada dos serviços apenas daquela hospedagem, pois o `INNER JOIN` garante que só teremos resultados onde o `codServico` e o `codHospedagem` existem em suas respectivas tabelas.

-----

### **2. `LEFT JOIN`: Trazendo Tudo de um Lado, Mesmo Sem Par do Outro**

O `LEFT JOIN` é diferente. Ele diz: "Traga-me **todos** os registros da tabela da esquerda (`FROM...`) e, se encontrar uma correspondência na tabela da direita (`LEFT JOIN...`), traga os dados dela também. Se não encontrar, preencha com `NULL` (vazio)."

É perfeito para perguntas como "O que está sem uso?" ou "Quem nunca fez tal coisa?".

#### **Exemplo Prático 1: Relatório de Ocupação dos Chalés**

  * **Consulta desejada:** "Preciso de um mapa de todos os chalés da pousada. Quero ver a localização de **todos** eles e, para os que estiverem ocupados (`estado = 'Ativa'`), quero saber o nome do hóspede."
  * **Objetivo:** Gerar um painel de controle para a recepção saber quais chalés estão livres e quais estão ocupados, e por quem. Um `INNER JOIN` aqui só mostraria os chalés ocupados.
  * **Implementação:**

<!-- end list -->

```sql
SELECT
    ch.localizacao,
    ch.capacidade,
    cl.nomeCliente AS hospede_atual,
    h.dataInicio
FROM
    Chale AS ch -- A tabela da ESQUERDA. Queremos TODOS os chalés.
LEFT JOIN
    Hospedagem AS h ON ch.codChale = h.codChale AND h.estado = 'Ativa' -- Juntamos com hospedagens, mas APENAS as ativas
LEFT JOIN
    Cliente AS cl ON h.codCliente = cl.codCliente; -- Juntamos com o cliente, se houver hospedagem ativa
```

**Resultado:** A lista mostrará **todos os 4 chalés**. Nos chalés que não têm uma hospedagem ativa correspondente, as colunas `hospede_atual` e `dataInicio` aparecerão como `NULL`. Isso nos diz exatamente quais estão vagos.

#### **Exemplo Prático 2: Identificando Itens Pouco Utilizados**

  * **Consulta desejada:** "Quais itens do nosso catálogo nunca foram oferecidos em nenhum chalé? Talvez possamos removê-los do sistema."
  * **Objetivo:** Otimizar o catálogo de itens, encontrando aqueles que não estão associados a nenhum chalé.
  * **Implementação:**

<!-- end list -->

```sql
-- Primeiro, vamos adicionar um item que não está em uso para o exemplo funcionar
INSERT INTO Item (nomeItem, descricaoItem) VALUES ('Banheira de Hidromassagem', 'Item novo para avaliação');

-- Agora, a consulta
SELECT
    i.nomeItem,
    i.descricaoItem
FROM
    Item AS i -- A tabela da ESQUERDA. Queremos TODOS os itens.
LEFT JOIN
    Chale_Item AS ci ON i.nomeItem = ci.nomeItem -- Tentamos encontrar a correspondência na tabela de associação
WHERE
    ci.codChale IS NULL; -- O segredo! Filtramos onde a correspondência NÃO foi encontrada.
```

**Resultado:** A consulta retornará "Banheira de Hidromassagem", pois, ao tentar fazer a junção com `Chale_Item`, não encontrou nenhuma correspondência para este item, resultando em um `codChale` nulo para ele.

### **Resumo e Dica Final**

  * **Use `INNER JOIN` quando:** Você só quer os resultados que têm correspondência em todas as tabelas. É o seu "pão com manteiga" para relatórios do dia a dia.
  * **Use `LEFT JOIN` quando:** Você precisa de todos os registros de uma tabela (a da esquerda) e quer saber quais deles têm (ou não têm) correspondência em outra. É perfeito para encontrar "o que falta".

**Dica:** A ordem das tabelas importa no `LEFT JOIN`, mas não no `INNER JOIN`. Uma boa prática é sempre pensar: "Qual é a lista completa que eu quero ver?" e colocar essa tabela na cláusula `FROM` (à esquerda).

Pratique com essas consultas e tente criar as suas próprias. Por exemplo: "Quais clientes fizeram mais de uma hospedagem?" ou "Qual o valor total já gasto em serviços por cada cliente?". Os `JOINs` são a chave para responder a praticamente qualquer pergunta\!