USE pousadadb;

SELECT * FROM cliente;
SELECT * FROM telefone;

SELECT cliente.*, telefone.telefone FROM cliente 
INNER JOIN telefone
ON cliente.codcliente = telefone.codCliente;

-- Hospedagem com Cliente (nome)
SELECT cliente.nomeCliente, hospedagem.estado, hospedagem.dataInicio, hospedagem.dataFim FROM hospedagem
INNER JOIN cliente
ON hospedagem.codCliente = cliente.codCliente;

-- Hospedagem com Chale (localizacao)
SELECT hospedagem.estado, hospedagem.dataInicio, hospedagem.dataFim, chale.localizacao FROM hospedagem
INNER JOIN chale
ON hospedagem.codChale = chale.codChale;

-- Hospedagem com Cliente (nome) e Chale (localizacao)
SELECT hospedagem.estado, hospedagem.dataInicio, hospedagem.dataFim, cliente.nomeCliente, chale.localizacao FROM hospedagem
INNER JOIN cliente 
	ON hospedagem.codCliente = cliente.codCliente
INNER JOIN chale 
	ON hospedagem.codChale = chale.codChale;






