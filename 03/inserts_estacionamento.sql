USE EstacionamentoDB;

INSERT INTO Cliente (nome, cpf, telefone) VALUES
('João da Silva', '111.222.333-44', '(11) 98765-4321'),
('Maria Oliveira', '222.333.444-55', '(21) 91234-5678'), -- Esta cliente terá dois veículos
('Pedro Souza', '333.444.555-66', '(31) 95555-1234'),
('Ana Costa', '444.555.666-77', '(51) 98888-7777');

INSERT INTO Vaga (localizacao, tipoVaga) VALUES
('A-01', 'Média'),
('A-02', 'Média'),
('B-05', 'Grande'),
('C-10', 'Pequena'), 
('B-06', 'Grande');

INSERT INTO Veiculo (cliente_id, placa, modelo, cor) VALUES
(1, 'ABC-1234', 'Honda Civic', 'Prata'),    -- Veículo do João
(2, 'XYZ-9876', 'Fiat Toro', 'Vermelho'),   -- 1º Veículo da Maria
(2, 'GHI-5544', 'Hyundai HB20', 'Branco'),  -- 2º Veículo da Maria
(3, 'JKL-1122', 'Chevrolet Onix', 'Preto'), -- Veículo do Pedro
(4, 'MNO-3344', 'Honda Biz', 'Azul');       -- Veículo (moto) da Ana

INSERT INTO RegistroEstacionamento (veiculo_id, vaga_id, dataHoraEntrada, dataHoraSaida, valorFinal) VALUES
-- Cenário 1: Estacionamento finalizado (João)
(1, 1, '2025-09-10 08:30:00', '2025-09-10 10:45:00', 12.50),

-- Cenário 2: Estacionamento EM ABERTO (Pedro). O carro ainda está na vaga.
(4, 3, '2025-09-11 14:00:00', NULL, NULL),

-- Cenário 3: Outro registro finalizado para o mesmo carro do João
(1, 2, '2025-09-08 15:00:00', '2025-09-08 19:30:00', 22.00),

-- Cenário 4: Um registro finalizado para o primeiro carro da Maria.
(2, 5, '2025-09-11 09:00:15', '2025-09-11 12:20:30', 18.75),

-- Cenário 5: Estacionamento EM ABERTO para o segundo carro da Maria.
(3, 1, '2025-09-11 16:10:00', NULL, NULL),

-- Cenário 6: Registro rápido e finalizado para a moto da Ana.
(5, 4, '2025-09-09 11:00:00', '2025-09-09 11:35:00', 4.50);