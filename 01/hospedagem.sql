-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS PousadaDB;
USE PousadaDB;

-- Tabela `Cliente`
CREATE TABLE IF NOT EXISTS Cliente (
  codCliente INT NOT NULL AUTO_INCREMENT,
  nomeCliente VARCHAR(100) NOT NULL,
  rgCliente VARCHAR(20) UNIQUE NOT NULL,
  enderecoCliente VARCHAR(255) NULL,
  bairroCliente VARCHAR(100) NULL,
  cidadeCliente VARCHAR(100) NULL,
  estadoCliente CHAR(2) NULL,
  CEPCliente VARCHAR(9) NULL,
  nascimentoCliente DATE NULL,
  PRIMARY KEY (codCliente)
);

-- Armazena os números de telefone dos clientes.
-- A relação é de 1 para N (um cliente pode ter vários telefones).
CREATE TABLE IF NOT EXISTS Telefone (
  codCliente INT NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  tipoTelefone VARCHAR(20) NULL,
  -- A chave primária é composta pelo código do cliente e pelo número de telefone.
  -- Isso impede que o mesmo número de telefone seja cadastrado mais de uma vez para o mesmo cliente.
  PRIMARY KEY (codCliente, telefone),
  -- Adiciona a restrição de chave estrangeira para garantir a integridade referencial.
  -- Se um cliente for excluído, seus telefones associados também serão excluídos (ON DELETE CASCADE).
  -- Se o código do cliente for atualizado (raro, mas possível), a mudança será refletida aqui (ON UPDATE CASCADE).
  CONSTRAINT fk_Telefone_Cliente
    FOREIGN KEY (codCliente)
    REFERENCES Cliente (codCliente)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Chale (
  codChale INT NOT NULL AUTO_INCREMENT,
  localizacao VARCHAR(100) NULL,
  capacidade INT NULL,
  valorAltaEstacao DECIMAL(10, 2) NULL,
  valorBaixaEstacao DECIMAL(10, 2) NULL,
  PRIMARY KEY (codChale)
);

CREATE TABLE IF NOT EXISTS Item (
  nomeItem VARCHAR(50) NOT NULL,
  descricaoItem TEXT NULL,
  -- A chave primária é o próprio nome do item.
  PRIMARY KEY (nomeItem)
);

-- Tabela associativa (N para N) que relaciona os itens presentes em cada chalé.
CREATE TABLE IF NOT EXISTS Chale_Item (
  codChale INT NOT NULL,
  nomeItem VARCHAR(50) NOT NULL,
  -- A chave primária é composta pelo código do chalé e o nome do item.
  -- Isso garante que um item não possa ser associado ao mesmo chalé mais de uma vez.
  PRIMARY KEY (codChale, nomeItem),
  -- Chave estrangeira para a tabela Chale.
  -- Se um chalé for excluído, todos os seus registros de itens associados serão excluídos.
  CONSTRAINT fk_Chale_Item_Chale
    FOREIGN KEY (codChale)
    REFERENCES Chale (codChale)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  -- Chave estrangeira para a tabela Item.
  -- Se um item for excluído do catálogo, ele será removido da lista de itens de todos os chalés.
  -- A opção ON DELETE RESTRICT poderia ser usada se a regra de negócio fosse impedir a exclusão de um item que está em uso por um chalé.
  CONSTRAINT fk_Chale_Item_Item
    FOREIGN KEY (nomeItem)
    REFERENCES Item (nomeItem)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS Servico (
  codServico INT NOT NULL AUTO_INCREMENT,
  nomeServico VARCHAR(100) NOT NULL,
  valorServico DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (codServico)
);

CREATE TABLE IF NOT EXISTS Hospedagem (
  codHospedagem INT NOT NULL AUTO_INCREMENT,
  codCliente INT NOT NULL,
  codChale INT NOT NULL,
  estado VARCHAR(50) NULL,
  dataInicio DATE NOT NULL,
  dataFim DATE NULL,
  qtdPessoas INT NULL,
  desconto DECIMAL(10, 2) NULL DEFAULT 0.00,
  valorFinal DECIMAL(10, 2) NULL,
  PRIMARY KEY (codHospedagem),
  -- Chave estrangeira para a tabela Cliente.
  -- ON DELETE RESTRICT é usado para impedir que um cliente seja excluído se ele tiver uma hospedagem registrada.
  -- Isso previne a perda de histórico.
  CONSTRAINT fk_Hospedagem_Cliente
    FOREIGN KEY (codCliente)
    REFERENCES Cliente (codCliente)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  -- Chave estrangeira para a tabela Chale.
  -- ON DELETE RESTRICT impede que um chalé seja excluído se estiver associado a uma hospedagem.
  CONSTRAINT fk_Hospedagem_Chale
    FOREIGN KEY (codChale)
    REFERENCES Chale (codChale)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

-- Tabela associativa (N para N) que registra os serviços consumidos em cada hospedagem.
CREATE TABLE IF NOT EXISTS Hospedagem_Servico (
  codHospedagem INT NOT NULL,
  dataServico DATE NOT NULL,
  codServico INT NOT NULL,
  valorServico DECIMAL(10, 2) NOT NULL,
  -- A chave primária composta garante que o mesmo serviço não possa ser registrado
  -- para a mesma hospedagem na mesma data mais de uma vez.
  PRIMARY KEY (codHospedagem, dataServico, codServico),
  -- Chave estrangeira para a tabela Hospedagem.
  -- Se uma hospedagem for excluída, todos os registros de serviços consumidos nela também serão.
  CONSTRAINT fk_Hospedagem_Servico_Hospedagem
    FOREIGN KEY (codHospedagem)
    REFERENCES Hospedagem (codHospedagem)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  -- Chave estrangeira para a tabela Servico.
  -- Impede que um serviço seja excluído do catálogo se ele já foi consumido em alguma hospedagem.
  CONSTRAINT fk_Hospedagem_Servico_Servico
    FOREIGN KEY (codServico)
    REFERENCES Servico (codServico)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);