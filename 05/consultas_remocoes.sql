SELECT
	Clientes.id,
	Clientes.nome,
	Clientes.cpf,
	Veiculos.placa,
	Veiculos.modelo
FROM
	Clientes
INNER JOIN
	Veiculos ON Clientes.id = Veiculos.cliente_id

SELECT * FROM Clientes;

SELECT * FROM Veiculos;

DELETE FROM Clientes WHERE id = 7;

SELECT 
	RegistrosEstacionamento.data_hora_entrada,
	RegistrosEstacionamento.data_hora_saida,
	RegistrosEstacionamento.valor_final,
	Veiculos.placa,
	Veiculos.modelo,
	Vagas.localizacao
FROM 
	RegistrosEstacionamento
INNER JOIN
	Veiculos ON RegistrosEstacionamento.veiculo_id = Veiculos.id
INNER JOIN
	Vagas ON RegistrosEstacionamento.vaga_id = Vagas.id

SELECT * FROM Vagas;
DELETE FROM Vagas WHERE localizacao = 'A1';