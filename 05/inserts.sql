USE EstacionamentoDB;
GO

-- Inserindo Clientes
INSERT INTO Clientes (nome, cpf, telefone) VALUES
('João Silva', '123.456.789-00', '11999999999'),
('Maria Oliveira', '987.654.321-00', '11888888888'),
('Carlos Souza', '111.222.333-44', NULL), -- Cliente sem veículo
('Ana Lima', '555.666.777-88', '11777777777'); -- Cliente sem veículo

-- Inserindo Vagas
INSERT INTO Vagas (localizacao, tipo) VALUES
('A1', 'Compacto'),
('A2', 'SUV'),
('B1', 'Moto'),
('B2', 'Compacto'),
('C1', 'SUV'); -- Vaga sem nenhum estacionamento

-- Inserindo Veículos
INSERT INTO Veiculos (cliente_id, placa, modelo, cor) VALUES
(1, 'ABC1234', 'Fiat Uno', 'Prata'),     -- Veículo com registro
(1, 'XYZ5678', 'Honda Civic', 'Preto'), -- Veículo sem registro
(2, 'DEF4321', 'Toyota Corolla', 'Branco'); -- Veículo com registro

-- Inserindo Registros de Estacionamento
INSERT INTO RegistrosEstacionamento (veiculo_id, vaga_id, data_hora_entrada, data_hora_saida, valor_final) VALUES
(1, 1, '2025-09-22 08:00:00', '2025-09-22 10:00:00', 20.00),
(3, 2, '2025-09-22 09:30:00', NULL, NULL); -- Ainda estacionado

-- Situações atendidas:
-- - João Silva tem dois veículos, um com e outro sem registro.
-- - Maria Oliveira tem um veículo com registro.
-- - Carlos e Ana são clientes sem veículos.
-- - Vaga C1 está sem nenhum registro.
-- - Veículo XYZ5678 está sem registro.
-- - Vaga B1 e B2 estão sem uso.

-- Inserindo novos Clientes
INSERT INTO Clientes (nome, cpf, telefone) VALUES
('Fernando Rocha', '222.333.444-55', '11666666666'),
('Luciana Martins', '333.444.555-66', '11555555555'),
('Bruno Ferreira', '444.555.666-77', NULL); -- Cliente sem telefone

-- Inserindo Veículos (sem registros de estacionamento)
INSERT INTO Veiculos (cliente_id, placa, modelo, cor) VALUES
-- Veículos de Fernando Rocha
(5, 'GHI1234', 'Chevrolet Onix', 'Cinza'),
(5, 'JKL5678', 'Renault Kwid', 'Vermelho'),

-- Veículo de Luciana Martins
(6, 'MNO9012', 'Volkswagen Polo', 'Azul'),

-- Veículos de Bruno Ferreira
(7, 'PQR3456', 'Hyundai HB20', 'Preto'),
(7, 'STU7890', 'Ford Ka', 'Branco');