DROP DATABASE meuBanco;
CREATE DATABASE meuBanco;
USE meuBanco;

-- TABELA SETOR

CREATE TABLE setor (
    idSetor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    tipo VARCHAR(50),
    capacidade INT
) ENGINE=InnoDB;

-- TABELA INGRESSOS
CREATE TABLE ingressos (
    id_ingresso INT AUTO_INCREMENT PRIMARY KEY,
    preco DECIMAL(10,2),
    assento VARCHAR(10),
    status VARCHAR(20),
    idSetor INT,
    FOREIGN KEY (idSetor) REFERENCES setor(idSetor)
) ENGINE=InnoDB;

-- TABELA ESTADIO
CREATE TABLE estadio (
    idEstadio INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    endereco VARCHAR(200),
    capacidade INT
) ENGINE=InnoDB;

-- TABELA EVENTOS
CREATE TABLE eventos (
    id_Evento INT AUTO_INCREMENT PRIMARY KEY,
    data DATE,
    horario TIME,
    classificacao_indicativa VARCHAR(20),
    idEstadio INT,
    FOREIGN KEY (idEstadio) REFERENCES estadio(idEstadio)
) ENGINE=InnoDB;

-- TABELA EVENTO ESPORTIVO
CREATE TABLE evento_esportivo (
    id_Evento INT PRIMARY KEY,
    modalidade VARCHAR(50),
    competicao VARCHAR(50),
    FOREIGN KEY (id_Evento) REFERENCES eventos(id_Evento)
) ENGINE=InnoDB;

-- TABELA EVENTO CULTURAL
CREATE TABLE evento_cultural (
    id_Evento INT PRIMARY KEY,
    tipo VARCHAR(50),
    FOREIGN KEY (id_Evento) REFERENCES eventos(id_Evento)
) ENGINE=InnoDB;

-- TABELA PESSOA
CREATE TABLE pessoa (
    cpf VARCHAR(14) PRIMARY KEY,
    nome VARCHAR(100),
    telefone VARCHAR(20),
    email VARCHAR(100)
) ENGINE=InnoDB;

-- TABELA FUNCIONARIOS
CREATE TABLE funcionarios (
    cpf VARCHAR(14) PRIMARY KEY,
    salario DECIMAL(10,2),
    funcao VARCHAR(50),
    FOREIGN KEY (cpf) REFERENCES pessoa(cpf)
) ENGINE=InnoDB;

-- TABELA CLIENTES
CREATE TABLE clientes (
    cpf VARCHAR(14) PRIMARY KEY,
    compras INT,
    data_de_nascimento DATE,
    FOREIGN KEY (cpf) REFERENCES pessoa(cpf)
) ENGINE=InnoDB;

-- TABELA LOJAS
CREATE TABLE lojas (
    idLoja INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    localizacao VARCHAR(100),
    idEstadio INT,
    FOREIGN KEY (idEstadio) REFERENCES estadio(idEstadio)
) ENGINE=InnoDB;

-- TABELA TRABALHA (FUNCIONARIOS x LOJAS)
CREATE TABLE trabalha (
    cpf VARCHAR(14),
    idLoja INT,
    PRIMARY KEY (cpf, idLoja),
    FOREIGN KEY (cpf) REFERENCES funcionarios(cpf),
    FOREIGN KEY (idLoja) REFERENCES lojas(idLoja)
) ENGINE=InnoDB;

-- TABELA PRODUTOS
CREATE TABLE produto (
    codigo_produto INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(100),
    descricao VARCHAR(200),
    estoque INT
) ENGINE=InnoDB;

-- LOJA VENDE PRODUTOS (N:N)
CREATE TABLE loja_vende (
    idLoja INT,
    codigo_produto INT,
    PRIMARY KEY (idLoja, codigo_produto),
    FOREIGN KEY (idLoja) REFERENCES lojas(idLoja),
    FOREIGN KEY (codigo_produto) REFERENCES produto(codigo_produto)
) ENGINE=InnoDB;

-- CLIENTE CONSOME PRODUTOS (N:N)
CREATE TABLE consome (
    cpf VARCHAR(14),
    codigo_produto INT,
    quantidade INT,
    PRIMARY KEY (cpf, codigo_produto),
    FOREIGN KEY (cpf) REFERENCES clientes(cpf),
    FOREIGN KEY (codigo_produto) REFERENCES produto(codigo_produto)
) ENGINE=InnoDB;

-- TABELA FORNECEDORES
CREATE TABLE fornecedores (
    idFornecedores INT AUTO_INCREMENT PRIMARY KEY,
    endereco VARCHAR(200),
    telefone VARCHAR(20)
) ENGINE=InnoDB;

-- LOJA x FORNECEDORES (N:N)
CREATE TABLE loja_fornecedores (
    idLoja INT,
    idFornecedores INT,
    PRIMARY KEY (idLoja, idFornecedores),
    FOREIGN KEY (idLoja) REFERENCES lojas(idLoja),
    FOREIGN KEY (idFornecedores) REFERENCES fornecedores(idFornecedores)
) ENGINE=InnoDB;

-- TABELA ESTACIONAMENTO
CREATE TABLE estacionamento (
    ticket INT AUTO_INCREMENT PRIMARY KEY,
    preco DECIMAL(10,2),
    placa_veiculo VARCHAR(10),
    idEstadio INT,
    FOREIGN KEY (idEstadio) REFERENCES estadio(idEstadio)
) ENGINE=InnoDB;

-- ESTADIO VENDE INGRESSOS (1:N)
CREATE TABLE vende_ingresso (
    idEstadio INT,
    id_ingresso INT,
    PRIMARY KEY (idEstadio, id_ingresso),
    FOREIGN KEY (idEstadio) REFERENCES estadio(idEstadio),
    FOREIGN KEY (id_ingresso) REFERENCES ingressos(id_ingresso)
) ENGINE=InnoDB;
