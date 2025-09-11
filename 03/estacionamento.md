
### **Aula Prática de SQL: Dominando os JOINs no Sistema de Estacionamento**

Agora que nosso banco de dados `EstacionamentoDB` está criado e populado, vamos aprender a extrair informações ricas dele.

Os dados raramente moram em uma única tabela. Temos clientes em `Cliente`, seus carros em `Veiculo` e o uso do estacionamento em `RegistroEstacionamento`. Como conectar tudo isso para responder perguntas como: "Qual o nome do dono do carro com a placa ABC-1234?"

É para isso que servem os **JOINs**. Eles são a ferramenta fundamental para combinar dados de múltiplas tabelas em uma única consulta. Hoje, vamos focar nos dois tipos mais importantes e utilizados no dia a dia: `INNER JOIN` e `LEFT JOIN`.

-----

### **1. INNER JOIN: A Junção Essencial**

O `INNER JOIN` é o tipo mais comum de junção. Ele combina linhas de duas ou mais tabelas, mas **apenas se a condição de junção for verdadeira**. Pense nele como a "interseção" dos seus dados. Ele só retorna resultados onde há uma correspondência em **ambas** as tabelas.

**Sintaxe Básica:**

```sql
SELECT colunas
FROM TabelaA
INNER JOIN TabelaB ON TabelaA.chave = TabelaB.chave;
```

#### **Exemplo Prático 1.1: Quem é o dono de cada veículo?**

  * **Objetivo:** Precisamos de uma lista que mostre a placa de cada veículo e o nome do seu respectivo dono. A informação da placa está na tabela `Veiculo` e o nome do dono na tabela `Cliente`.

  * **Implementação:** Vamos juntar `Cliente` e `Veiculo` usando a coluna que elas têm em comum: `codCliente`.

<!-- end list -->

```sql
SELECT
  v.placa,
  v.modelo,
  c.nomeCliente
FROM Veiculo AS v -- Usar "AS" para criar um apelido (alias) torna a consulta mais limpa
INNER JOIN Cliente AS c ON v.codCliente = c.codCliente;
```

**Resultado Esperado:**
| placa    | modelo        | nomeCliente    |
|----------|---------------|----------------|
| ABC-1234 | Honda Civic   | João da Silva  |
| XYZ-9876 | Fiat Toro     | Maria Oliveira |
| GHI-5544 | Hyundai HB20  | Maria Oliveira |
| JKL-1122 | Chevrolet Onix| Pedro Souza    |
| MNO-3344 | Honda Biz     | Ana Costa      |

#### **Exemplo Prático 1.2: Relatório de Estacionamentos Ativos**

  * **Objetivo:** A gerência quer ver, em tempo real, todos os veículos que estão **atualmente** no pátio. A consulta precisa mostrar o nome do cliente, a placa do veículo e a localização da vaga que ele está ocupando.

  * **Implementação:** Essa consulta é mais complexa e exige juntar 4 tabelas\!

    1.  `RegistroEstacionamento` para pegar os dados de entrada.
    2.  `Veiculo` para pegar a placa.
    3.  `Cliente` (através do `Veiculo`) para pegar o nome do dono.
    4.  `Vaga` para pegar a localização.
        O critério para um carro "estar no pátio" é a `dataHoraSaida` ser `NULL`.

<!-- end list -->

```sql
SELECT
  c.nomeCliente,
  v.placa,
  v.modelo,
  vg.localizacao,
  r.dataHoraEntrada
FROM RegistroEstacionamento AS r
INNER JOIN Veiculo AS v ON r.codVeiculo = v.codVeiculo
INNER JOIN Cliente AS c ON v.codCliente = c.codCliente
INNER JOIN Vaga AS vg ON r.codVaga = vg.codVaga
WHERE r.dataHoraSaida IS NULL; -- A condição mágica para saber quem ainda não saiu!
```

**Resultado Esperado (baseado nos nossos dados e na data atual):**
| nomeCliente    | placa    | modelo       | localizacao | dataHoraEntrada     |
|----------------|----------|--------------|-------------|---------------------|
| Pedro Souza    | JKL-1122 | Chevrolet Onix| B-05        | 2025-09-11 14:00:00 |
| Maria Oliveira | GHI-5544 | Hyundai HB20 | A-01        | 2025-09-11 16:10:00 |

-----

### **2. LEFT JOIN: Vendo o Quadro Completo (Até o que Falta)**

E se quisermos listar todos os clientes, **mesmo aqueles que não têm um carro cadastrado**? O `INNER JOIN` não os mostraria. É aqui que entra o `LEFT JOIN`.

O `LEFT JOIN` retorna **todos** os registros da tabela à esquerda (`FROM TabelaA...`) e os registros correspondentes da tabela à direita. Se não houver correspondência na tabela da direita, as colunas dela virão com o valor `NULL`.

**Sintaxe Básica:**

```sql
SELECT colunas
FROM TabelaA -- Tabela da Esquerda
LEFT JOIN TabelaB ON TabelaA.chave = TabelaB.chave; -- Tabela da Direita
```

#### **Exemplo Prático 2.1: Listar todas as vagas e ver quais estão ocupadas**

  * **Objetivo:** Queremos uma lista de **todas as vagas** do estacionamento e, se alguma estiver ocupada, mostrar a placa do veículo que está nela. As vagas livres devem aparecer na lista.

  * **Implementação:** Usamos `Vaga` como a tabela da esquerda, pois queremos garantir que todas as vagas apareçam. Juntamos com os registros de estacionamento em aberto (`dataHoraSaida IS NULL`).

<!-- end list -->

```sql
SELECT
  vg.localizacao,
  vg.tipoVaga,
  v.placa AS placa_veiculo_ocupando -- Damos um nome diferente para a coluna
FROM Vaga AS vg
LEFT JOIN RegistroEstacionamento AS r ON vg.codVaga = r.codVaga AND r.dataHoraSaida IS NULL
LEFT JOIN Veiculo AS v ON r.codVeiculo = v.codVeiculo; -- Fazemos outro JOIN para buscar a placa
```

**Resultado Esperado:**
| localizacao | tipoVaga | placa\_veiculo\_ocupando |
|-------------|----------|------------------------|
| A-01        | Média    | GHI-5544               |
| A-02        | Média    | NULL                   |
| B-05        | Grande   | JKL-1122               |
| C-10        | Pequena  | NULL                   |
| B-06        | Grande   | NULL                   |

Veja que as vagas A-02, C-10 e B-06 apareceram com `NULL` na placa, indicando que estão livres. Um `INNER JOIN` teria omitido essas vagas do resultado\!

#### **Exemplo Prático 2.2: Encontrando Recursos Inutilizados**

  * **Objetivo:** A gerência suspeita que algumas vagas **nunca** foram utilizadas desde a inauguração. Como podemos confirmar isso?

  * **Implementação:** Este é um uso clássico e poderoso do `LEFT JOIN`. Listamos todas as vagas (`Vaga`) e as juntamos com todos os registros de uso (`RegistroEstacionamento`). Se uma vaga nunca foi usada, ela não terá correspondência na tabela de registros. O segredo é filtrar onde a chave da tabela da direita (`RegistroEstacionamento`) é `NULL`.

<!-- end list -->

```sql
SELECT
  vg.localizacao,
  vg.tipoVaga
FROM Vaga AS vg
LEFT JOIN RegistroEstacionamento AS r ON vg.codVaga = r.codVaga
WHERE r.codRegistro IS NULL; -- Filtra apenas pelas vagas que NÃO encontraram correspondência
```

**Resultado Esperado:**
*Nesta consulta, com os dados que inserimos, todas as vagas foram usadas pelo menos uma vez, então o resultado será uma lista vazia. Se a Vaga 'B-06' não tivesse sido usada no registro do Fiat Toro, ela apareceria aqui. Este é um exemplo perfeito de como auditar dados.*

### **Conclusão e Desafio**

Hoje vimos que:

  * `INNER JOIN` é para quando você quer a **interseção** dos dados, ou seja, resultados que existem em ambas as tabelas.
  * `LEFT JOIN` é para quando você quer **todos os dados de uma tabela principal** (a da esquerda) e quer complementá-los com dados de outra, aceitando que algumas informações podem não existir (resultando em `NULL`).

**Desafio para você:**
Crie uma consulta que liste **todos os veículos cadastrados** e conte quantas vezes cada um já esteve no estacionamento. Veículos que nunca foram utilizados devem aparecer na lista com a contagem "0". (Dica: você precisará de um `LEFT JOIN` e de funções de agregação como `COUNT()` e `GROUP BY`).