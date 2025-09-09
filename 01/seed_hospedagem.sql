-- Usar o banco de dados criado anteriormente
USE PousadaDB;

-- -----------------------------------------------------
-- Inserção de Dados
-- -----------------------------------------------------

-- 1. Inserir Clientes
INSERT INTO Cliente (nomeCliente, rgCliente, enderecoCliente, bairroCliente, cidadeCliente, estadoCliente, CEPCliente, nascimentoCliente) VALUES
('João da Silva', '11.222.333-4', 'Rua das Flores, 123', 'Centro', 'Campos do Jordão', 'SP', '12460-000', '1985-04-10'),
('Maria Oliveira', '22.333.444-5', 'Avenida Principal, 456', 'Vila Madalena', 'São Paulo', 'SP', '05445-000', '1992-08-22'),
('Pedro Souza', '33.444.555-6', 'Travessa dos Pássaros, 789', 'Jardim das Rosas', 'Monte Verde', 'MG', '37653-000', '1978-11-30');

-- 2. Inserir Telefones para os Clientes
INSERT INTO Telefone (codCliente, telefone, tipoTelefone) VALUES
(1, '(12) 99999-1111', 'Celular'),
(1, '(12) 3663-1111', 'Residencial'),
(2, '(11) 98888-2222', 'Celular'),
(3, '(35) 97777-3333', 'Celular');

-- 3. Inserir Itens para os Chalés
INSERT INTO Item (nomeItem, descricaoItem) VALUES
('Frigobar', 'Frigobar com capacidade para 50 litros.'),
('Ar Condicionado', 'Ar condicionado quente e frio.'),
('Lareira', 'Lareira a lenha funcional.'),
('TV a Cabo', 'Televisão com pacote completo de canais.'),
('Cama de Casal', 'Cama de casal padrão com colchão de molas.'),
('Cama de Solteiro', 'Cama de solteiro padrão.'),
('Wi-Fi', 'Acesso à internet sem fio de alta velocidade.');

-- 4. Inserir Chalés com o padrão de localização
INSERT INTO Chale (localizacao, capacidade, valorAltaEstacao, valorBaixaEstacao) VALUES
('Pavilhão A - A1', 2, 450.00, 300.00), -- Chalé para casal
('Pavilhão A - A2', 4, 600.00, 450.00), -- Chalé família
('Pavilhão B - B1', 2, 500.00, 350.00), -- Chalé para casal com vista
('Pavilhão C - C1', 6, 800.00, 600.00); -- Chalé maior para grupos

-- 5. Associar Itens aos Chalés
INSERT INTO Chale_Item (codChale, nomeItem) VALUES
-- Chalé A1 (Casal)
(1, 'Frigobar'),
(1, 'Lareira'),
(1, 'TV a Cabo'),
(1, 'Cama de Casal'),
(1, 'Wi-Fi'),
-- Chalé A2 (Família)
(2, 'Frigobar'),
(2, 'Ar Condicionado'),
(2, 'TV a Cabo'),
(2, 'Cama de Casal'),
(2, 'Cama de Solteiro'),
(2, 'Wi-Fi'),
-- Chalé B1 (Casal com vista)
(3, 'Frigobar'),
(3, 'Ar Condicionado'),
(3, 'Lareira'),
(3, 'TV a Cabo'),
(3, 'Cama de Casal'),
(3, 'Wi-Fi'),
-- Chalé C1 (Grupos)
(4, 'Frigobar'),
(4, 'Lareira'),
(4, 'TV a Cabo'),
(4, 'Cama de Casal'),
(4, 'Cama de Solteiro'),
(4, 'Wi-Fi');

-- 6. Inserir Serviços
INSERT INTO Servico (nomeServico, valorServico) VALUES
('Café da Manhã no Quarto', 50.00),
('Lavanderia (Cesto)', 75.00),
('Passeio a Cavalo (Pessoa)', 120.00),
('Decoração Romântica', 200.00);


-- 7. Inserir Hospedagens (Finalizadas e Ativas)
-- Lembre-se que hoje é 2025-09-04

-- Hospedagem 1: FINALIZADA
-- Cliente: João da Silva, Chalé: A1
INSERT INTO Hospedagem (codCliente, codChale, estado, dataInicio, dataFim, qtdPessoas, desconto, valorFinal) VALUES
(1, 1, 'Finalizada', '2025-07-10', '2025-07-15', 2, 50.00, 1450.00); -- Supondo 5 dias x 300 (baixa estação) = 1500 - 50 = 1450

-- Hospedagem 2: FINALIZADA
-- Cliente: Maria Oliveira, Chalé: B1
INSERT INTO Hospedagem (codCliente, codChale, estado, dataInicio, dataFim, qtdPessoas, desconto, valorFinal) VALUES
(2, 3, 'Finalizada', '2025-08-01', '2025-08-04', 2, 0.00, 1050.00); -- Supondo 3 dias x 350 (baixa estação) = 1050

-- Hospedagem 3: ABERTA (ATIVA)
-- Cliente: Pedro Souza, Chalé: A2
-- A data de início é anterior a hoje, e a data de fim é NULA, indicando que a hospedagem está em andamento.
INSERT INTO Hospedagem (codCliente, codChale, estado, dataInicio, dataFim, qtdPessoas, desconto, valorFinal) VALUES
(3, 2, 'Ativa', '2025-09-01', NULL, 3, 0.00, NULL);

-- Hospedagem 4: FINALIZADA
-- Cliente: João da Silva, Chalé: C1
INSERT INTO Hospedagem (codCliente, codChale, estado, dataInicio, dataFim, qtdPessoas, desconto, valorFinal) VALUES
(1, 4, 'Finalizada', '2025-06-20', '2025-06-25', 5, 100.00, 3900.00); -- Supondo 5 dias x 800 (alta estação - junho) = 4000 - 100 = 3900


-- 8. Associar Serviços às Hospedagens

-- Serviços para a Hospedagem 1 (João da Silva, Finalizada)
INSERT INTO Hospedagem_Servico (codHospedagem, dataServico, codServico, valorServico) VALUES
(1, '2025-07-11', 1, 50.00),  -- Café da Manhã no Quarto
(1, '2025-07-12', 3, 240.00); -- Passeio a Cavalo (para 2 pessoas, valor ajustado na inserção)

-- Serviços para a Hospedagem 3 (Pedro Souza, Ativa)
INSERT INTO Hospedagem_Servico (codHospedagem, dataServico, codServico, valorServico) VALUES
(3, '2025-09-02', 2, 75.00); -- Lavanderia

-- Serviços para a Hospedagem 4 (João da Silva, Finalizada)
INSERT INTO Hospedagem_Servico (codHospedagem, dataServico, codServico, valorServico) VALUES
(4, '2025-06-21', 4, 200.00); -- Decoração Romântica

-- Confirmação final das inserções
SELECT 'Dados de exemplo inseridos com sucesso!' AS status;