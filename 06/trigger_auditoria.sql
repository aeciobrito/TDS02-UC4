-- Table básica de auditoria dos agendamentos
CREATE TABLE AuditoriaAgendamento(
	id INT IDENTITY(1,1) PRIMARY KEY,
	descricao VARCHAR(500) NOT NULL,
	dataHora DATETIME2 NOT NULL DEFAULT GETDATE() -- GETDATE() pega data e hora atuais
);
GO

-- Criação do gatilho para a Auditoria de Agendamento
CREATE TRIGGER trg_LogNovaHospedagem
ON Hospedagem -- O trigger é para a tabela Hospedagem
AFTER INSERT -- Ele será disparado depois que uma linha for inserida
AS
BEGIN
	-- Variáveis em SQL: Armazenam dados temporariamente.
	DECLARE @clienteId INT;
	DECLARE @chaleId INT;
	DECLARE @dataInicio DATE;
	DECLARE @clienteNome VARCHAR(100);

	-- Corpo do Trigger (gatilho)
	SELECT
		@clienteId = inserted.cliente_id,
		@chaleId = inserted.chale_id,
		@dataInicio = inserted.dataInicio
	FROM inserted;

	SELECT @clienteNome = nome FROM Cliente WHERE id = @clienteId;

	-- Inserimos o log na tabela de auditoria:
	INSERT INTO AuditoriaAgendamento (descricao)
	VALUES (
		CONCAT('Nova hospedagem agendada para o cliente', @clienteNome, ' no chalé ID: ', @chaleId, ' a partir de ', @dataInicio, '.')
	);
END
GO