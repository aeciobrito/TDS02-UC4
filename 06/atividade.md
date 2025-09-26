# Atividade Prática
Crie um trigger que, ao inserir um novo serviço consumido na tabela Hospedagem_Servico, atualize automaticamente o campo valorFinal na tabela Hospedagem correspondente, somando o valor do novo serviço ao total existente.

### Dicas:

- O trigger será na tabela Hospedagem_Servico, disparado por um AFTER INSERT.
- Você precisará pegar o hospedagem_id e o valor da tabela inserted.
- Use um comando UPDATE na tabela Hospedagem para somar o novo valor.
- Cuidado com valores NULL! Se valorFinal for nulo, a soma NULL + 50 resulta em NULL. Use a função ISNULL(valorFinal, 0) para tratar isso.