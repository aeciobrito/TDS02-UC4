USE estacionamentoDB;

SELECT * FROM cliente;
SELECT * FROM veiculo;

SELECT cliente.*, veiculo.placa, veiculo.modelo FROM cliente
LEFT JOIN veiculo
ON cliente.id = veiculo.cliente_id;

INSERT INTO Cliente (nome, cpf, telefone) VALUES
('Luis', '555.666.777-88', '(11) 99999-2221');