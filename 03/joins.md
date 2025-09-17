## 1
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

## 2

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

**Sintaxe Básica LEFT JOIN:**

```sql
SELECT colunas
FROM TabelaA -- Tabela da Esquerda
LEFT JOIN TabelaB ON TabelaA.chave = TabelaB.chave; -- Tabela da Direita
```


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