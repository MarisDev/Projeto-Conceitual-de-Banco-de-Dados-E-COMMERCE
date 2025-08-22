CREATE DATABASE Ecommerce;
USE Ecommerce;

-- CLIENTE (superclasse)
CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY,
    nome VARCHAR(100),
    identificacao VARCHAR(20),
    tipo_cliente VARCHAR(10) -- 'PF' ou 'PJ'
);

-- SUBCLASSES
CREATE TABLE ClientePF (
    idClientePF INT PRIMARY KEY,
    cpf VARCHAR(14),
    data_nascimento DATE,
    contato VARCHAR(50),
    Cliente_idCliente INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE ClientePJ (
    idClientePJ INT PRIMARY KEY,
    cnpj VARCHAR(18),
    razao_social VARCHAR(100),
    contato VARCHAR(50),
    Cliente_idCliente INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

-- ENDEREÇO
CREATE TABLE Endereco (
    idEndereco INT PRIMARY KEY,
    rua VARCHAR(100),
    cidade VARCHAR(50),
    estado VARCHAR(50),
    Cliente_idCliente INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

-- CARRINHO
CREATE TABLE Carrinho (
    idCarrinho INT PRIMARY KEY,
    data_criacao DATE,
    Cliente_idCliente INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

-- PRODUTO
CREATE TABLE Produto (
    idProduto INT PRIMARY KEY,
    nome VARCHAR(100),
    valor DECIMAL(10,2)
);

-- FORNECEDOR
CREATE TABLE Fornecedor (
    idFornecedor INT PRIMARY KEY,
    razao_social VARCHAR(100),
    cnpj VARCHAR(18)
);

-- DISPONIBILIDADE DE PRODUTO
CREATE TABLE DisponibilidadeProduto (
    Produto_idProduto INT,
    Fornecedor_idFornecedor INT,
    PRIMARY KEY (Produto_idProduto, Fornecedor_idFornecedor),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (Fornecedor_idFornecedor) REFERENCES Fornecedor(idFornecedor)
);

-- ESTOQUE
CREATE TABLE Estoque (
    idEstoque INT PRIMARY KEY,
    local VARCHAR(100)
);

CREATE TABLE Estoque_has_Produto (
    Estoque_idEstoque INT,
    Produto_idProduto INT,
    quantidade INT,
    PRIMARY KEY (Estoque_idEstoque, Produto_idProduto),
    FOREIGN KEY (Estoque_idEstoque) REFERENCES Estoque(idEstoque),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

-- PAGAMENTO
CREATE TABLE Pagamento (
    idPagamento INT PRIMARY KEY,
    forma_pagamento VARCHAR(50),
    valor DECIMAL(10,2)
);

-- PEDIDO
CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY,
    status VARCHAR(20),
    descricao VARCHAR(100),
    valor DECIMAL(10,2),
    Cliente_idCliente INT,
    Pagamento_idPagamento INT,
    Endereco_idEndereco INT,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (Pagamento_idPagamento) REFERENCES Pagamento(idPagamento),
    FOREIGN KEY (Endereco_idEndereco) REFERENCES Endereco(idEndereco)
);

-- RELAÇÃO PEDIDO/PRODUTO
CREATE TABLE RelacaoPedidoProduto (
    Pedido_idPedido INT,
    Produto_idProduto INT,
    quantidade INT,
    PRIMARY KEY (Pedido_idPedido, Produto_idProduto),
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

-- ENTREGA
CREATE TABLE Entrega (
    idEntrega INT PRIMARY KEY,
    status VARCHAR(20),
    codigo_rastreio VARCHAR(30),
    previsao DATE,
    Pedido_idPedido INT,
    transportadora VARCHAR(50),
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido)
);
