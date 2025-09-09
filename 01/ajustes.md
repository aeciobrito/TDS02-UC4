# Ajustes

1.  **Relação Cliente-Hospedagem:**
    * **Adição da Chave Estrangeira `codCliente` na Tabela `Hospedagem`**: O diagrama mostra uma linha de relacionamento entre `Cliente` e `Hospedagem`, indicando que uma hospedagem pertence a um cliente. Para implementar isso no banco de dados, é essencial adicionar a coluna `codCliente` na tabela `Hospedagem` como uma chave estrangeira (`FOREIGN KEY`) que referencia a tabela `Cliente`. Sem essa coluna, seria impossível saber qual cliente fez qual hospedagem.

2.  **Relação Chale-Hospedagem:**
    * **Adição da Chave Estrangeira `codChale` na Tabela `Hospedagem`**: De forma similar à anterior, o diagrama conecta `Chale` a `Hospedagem`. Para que cada registro de hospedagem esteja associado a um chalé específico, a coluna `codChale` foi adicionada à tabela `Hospedagem` como chave estrangeira.

3.  **Tabela `Hospedagem_Servico` (Serviços da Hospedagem):**
    * **Adição da Coluna `dataServico`**: Foi incluída a coluna `dataServico` e adicionada à chave primária composta (`codHospedagem`, `dataServico`, `codServico`). Isso permite registrar o mesmo serviço (ex: "Café da Manhã no Quarto") várias vezes para a mesma hospedagem, contanto que seja em dias diferentes. O diagrama original não previa essa granularidade.
    * **Armazenamento do `valorServico`**: A coluna `valorServico` foi adicionada para registrar o preço do serviço no momento em que ele foi consumido. Isso é uma boa prática para garantir a consistência histórica dos valores, pois o preço de um serviço no catálogo (`Servico.valorServico`) pode mudar com o tempo.

4.  **Restrições de Integridade (`UNIQUE`):**
    * **RG Único para Cliente**: Foi adicionada uma restrição `UNIQUE` na coluna `rgCliente` da tabela `Cliente`. Embora não esteja explícito no diagrama, essa regra de negócio é comum e importante para evitar a duplicidade de clientes com base em um documento oficial.
