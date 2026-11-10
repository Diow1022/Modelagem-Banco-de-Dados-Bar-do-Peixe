-- =============================================================
-- BAR DO PEIXE | ESTRUTURA INICIAL CORRIGIDA (MySQL 8 / XAMPP)
-- Versao comentada baseada em entrega 2.md, com tres alteracoes autorizadas.
-- Inclui regras operacionais que nao alteram o modelo logico.
-- Nao inclui massa de dados nem demonstracoes de UPDATE/DELETE.
-- Nao executa DROP TABLE nem modifica tabelas previamente existentes.
-- =============================================================

-- 1. BANCO DE DADOS
-- Cria um espaco proprio para as tabelas e seleciona-o para uso.
-- IF NOT EXISTS evita erro caso o banco ja exista.
CREATE DATABASE IF NOT EXISTS Bar_do_Peixe
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE Bar_do_Peixe;

-- 2. TABELAS (PK, NOT NULL e tipos de dados)
-- As 12 entidades mais a associativa totalizam 13 tabelas.
-- AUTO_INCREMENT gera identificadores apenas para PKs simples.
-- DATETIME DEFAULT CURRENT_TIMESTAMP sugere o momento do registro.
-- ENGINE=InnoDB habilita FKs e transacoes no MySQL.
-- -------------------------------------------------------------
-- TABELA FUNCIONARIO
-- RF05 / RN05: cadastra colaboradores, funcao e turno de trabalho.
-- ID_Funcionario identifica cada funcionario e sera referenciado em PEDIDO.
-- -------------------------------------------------------------
CREATE TABLE Funcionario (
    ID_Funcionario INT AUTO_INCREMENT PRIMARY KEY,
    NM_Funcionario VARCHAR(120) NOT NULL,
    TP_Funcao VARCHAR(30) NOT NULL,
    TP_Turno VARCHAR(10) NOT NULL
) ENGINE = InnoDB;

-- -------------------------------------------------------------
-- TABELA MESA
-- RN01 / P3: registra mesas, numero, situacao e capacidade.
-- O numero da mesa e unico, evitando duplicidade operacional.
-- -------------------------------------------------------------
CREATE TABLE Mesa (
    ID_Mesa INT AUTO_INCREMENT PRIMARY KEY,
    NR_Mesa INT NOT NULL,
    TP_Situacao VARCHAR(20) NOT NULL,
    QT_Lugares INT NOT NULL
) ENGINE = InnoDB;

-- -------------------------------------------------------------
-- TABELA COMANDA
-- P3 / RN01 / RF07: agrupa o consumo associado a uma mesa.
-- ST_Comanda indica a situacao; o trigger abaixo valida o fechamento
-- com base nos pagamentos ja registrados (RN07).
-- -------------------------------------------------------------
CREATE TABLE Comanda (
    ID_Comanda INT AUTO_INCREMENT PRIMARY KEY,
    ST_Comanda VARCHAR(20) NOT NULL,
    DT_Abertura DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_Mesa INT NOT NULL
) ENGINE = InnoDB;

-- -------------------------------------------------------------
-- TABELA PEDIDO
-- P1 / RF01 / RF02 / RF03: registra pedidos, seu funcionario e comanda.
-- TP_Setor identifica o destino do pedido (por exemplo, cozinha ou bebidas).
-- Nome corrigido conforme a secao de normalizacao da Entrega 2.
-- -------------------------------------------------------------
CREATE TABLE Pedido (
    ID_Pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_Funcionario INT NOT NULL,
    DT_Hora_Pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ST_Pedido VARCHAR(20) NOT NULL,
    TP_Setor VARCHAR(20), -- Campo padronizado conforme o modelo logico
    id_Comanda INT NOT NULL
) ENGINE = InnoDB;

-- -------------------------------------------------------------
-- TABELA PRODUTO
-- RF03: identifica alimentos e bebidas do cardapio e seus precos.
-- ST_Produto e textual, pois descreve a situacao do item.
-- -------------------------------------------------------------
CREATE TABLE Produto (
    ID_Produto INT AUTO_INCREMENT PRIMARY KEY,
    NM_Produto VARCHAR(120) NOT NULL,
    TP_Categoria VARCHAR(40) NOT NULL,
    VL_Preco DECIMAL(10,2) NOT NULL,
    ST_Produto VARCHAR(20) NOT NULL
) ENGINE = InnoDB;

-- -------------------------------------------------------------
-- TABELA ITEM_PEDIDO
-- RF01: detalha produtos, quantidades e preco historico do pedido.
-- Valor total do item nao e armazenado para evitar redundancia (3FN).
-- Em consulta: QT_Item * VL_Unitario AS VL_Total.
-- -------------------------------------------------------------
CREATE TABLE Item_Pedido (
    ID_Item_Pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_Pedido INT NOT NULL,
    id_Produto INT NOT NULL,
    QT_Item INT NOT NULL,
    VL_Unitario DECIMAL(10,2) NOT NULL
) ENGINE = InnoDB;

-- -------------------------------------------------------------
-- TABELA PAGAMENTO
-- P3 / RF07: registra os pagamentos vinculados a cada comanda.
-- O saldo da comanda deve ser conferido antes de encerra-la.
-- -------------------------------------------------------------
CREATE TABLE Pagamento (
    ID_Pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_Comanda INT NOT NULL,
    DT_Pagamento DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    TP_Pagamento VARCHAR(20) NOT NULL,
    VL_Pagamento DECIMAL(10,2) NOT NULL
) ENGINE = InnoDB;

-- -------------------------------------------------------------
-- TABELA INSUMOS
-- P2 / RF04 / RF06 / RN06: cadastra insumos, unidade, estoque e minimo.
-- Permite consultas de alerta de reposicao.
-- -------------------------------------------------------------
CREATE TABLE Insumos (
    ID_Insumos INT AUTO_INCREMENT PRIMARY KEY,
    NM_Insumo VARCHAR(120) NOT NULL,
    UN_Medida VARCHAR(15) NOT NULL,
    QT_Estoque DECIMAL(12,3) NOT NULL,
    QT_Minima DECIMAL(12,3) NOT NULL
) ENGINE = InnoDB;

-- -------------------------------------------------------------
-- TABELA CONTROLE_INSUMOS
-- P2 / RF04 / RN04: registra historico de entradas e saidas.
-- Triggers posteriores tratam a movimentacao e atualizam o saldo.
-- Lancamentos sao imutaveis; ajuste de erro exige outra movimentacao.
-- -------------------------------------------------------------
CREATE TABLE Controle_Insumos (
    ID_Movimentacao INT AUTO_INCREMENT PRIMARY KEY,
    id_Insumos INT NOT NULL,
    DT_Movimentacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    TP_Movimentacao VARCHAR(20) NOT NULL,
    QT_Movimentacao DECIMAL(12,3) NOT NULL
) ENGINE = InnoDB;

-- -------------------------------------------------------------
-- TABELA FORNECEDOR
-- P4: cadastra fornecedores, CNPJ, telefone e situacao.
-- NR_CNPJ e unico e armazenado sem pontuacao (14 caracteres).
-- -------------------------------------------------------------
CREATE TABLE Fornecedor (
    ID_Fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    NM_Fornecedor VARCHAR(120) NOT NULL,
    NR_CNPJ CHAR(14) NOT NULL,
    NR_Telefone VARCHAR(20) NOT NULL,
    ST_Fornecedor VARCHAR(20) NOT NULL
) ENGINE = InnoDB;

-- -------------------------------------------------------------
-- TABELA COMPRA
-- P4: registra a compra, fornecedor e nota fiscal.
-- VL_Compra nao e armazenado: e calculado somando os itens (3FN).
-- Em consulta: SUM(QT_Comprada * VL_Unitario) para cada compra.
-- -------------------------------------------------------------
CREATE TABLE Compra (
    ID_Compra INT AUTO_INCREMENT PRIMARY KEY,
    id_Fornecedor INT NOT NULL,
    DT_Compra DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    NR_Nota_Fiscal VARCHAR(44) NOT NULL
) ENGINE = InnoDB;

-- -------------------------------------------------------------
-- TABELA ITEM_COMPRA
-- P4 / RF04: discrimina insumos, quantidades e valores adquiridos.
-- VL_Total nao e armazenado para evitar redundancia (3FN).
-- Em consulta: QT_Comprada * VL_Unitario AS VL_Total.
-- -------------------------------------------------------------
CREATE TABLE Item_Compra (
    ID_Item_Compra INT AUTO_INCREMENT PRIMARY KEY,
    id_Insumos INT NOT NULL,
    id_Compra INT NOT NULL,
    QT_Comprada DECIMAL(12,3) NOT NULL,
    VL_Unitario DECIMAL(10,2) NOT NULL
) ENGINE = InnoDB;

-- -------------------------------------------------------------
-- TABELA FICHA_TECNICA
-- RF04: tabela associativa N:N entre PRODUTO e INSUMOS.
-- A PK composta evita duplicar a mesma associacao produto/insumo.
-- Nome FICHA_TECNICA adotado conforme a normalizacao na Entrega 2.
-- -------------------------------------------------------------
CREATE TABLE Ficha_Tecnica (
    ID_Produto INT NOT NULL,
    ID_Insumos INT NOT NULL,
    QT_Consumida DECIMAL(12,3) NOT NULL,
    PRIMARY KEY (ID_Produto, ID_Insumos)
) ENGINE = InnoDB;

-- 3. CONSTRAINTS ADICIONAIS
-- UNIQUE: impede duplicacao de numero de mesa e CNPJ de fornecedor.
-- Unicidade de identificadores de negocio
ALTER TABLE Mesa ADD CONSTRAINT UQ_Mesa_Numero UNIQUE (NR_Mesa);
ALTER TABLE Fornecedor ADD CONSTRAINT UQ_Fornecedor_CNPJ UNIQUE (NR_CNPJ);

-- CHECK: restringe valores impossiveis (precos e quantidades negativas).
-- CHECK nao implementa todas as regras RN01 a RN10.
-- Regras de dominio basicas; revisar conforme regras de negocio oficiais
ALTER TABLE Mesa ADD CONSTRAINT CK_Mesa_Numero CHECK (NR_Mesa > 0);
ALTER TABLE Mesa ADD CONSTRAINT CK_Mesa_Lugares CHECK (QT_Lugares > 0);
ALTER TABLE Produto ADD CONSTRAINT CK_Produto_Preco CHECK (VL_Preco >= 0);
ALTER TABLE Item_Pedido ADD CONSTRAINT CK_Item_Pedido_Quantidade CHECK (QT_Item > 0);
ALTER TABLE Item_Pedido ADD CONSTRAINT CK_Item_Pedido_Unitario CHECK (VL_Unitario >= 0);
ALTER TABLE Pagamento ADD CONSTRAINT CK_Pagamento_Valor CHECK (VL_Pagamento > 0);
ALTER TABLE Insumos ADD CONSTRAINT CK_Insumos_Estoque CHECK (QT_Estoque >= 0);
ALTER TABLE Insumos ADD CONSTRAINT CK_Insumos_Minimo CHECK (QT_Minima >= 0);
ALTER TABLE Controle_Insumos ADD CONSTRAINT CK_Movimentacao_Quantidade CHECK (QT_Movimentacao > 0);
ALTER TABLE Item_Compra ADD CONSTRAINT CK_Item_Compra_Quantidade CHECK (QT_Comprada > 0);
ALTER TABLE Item_Compra ADD CONSTRAINT CK_Item_Compra_Unitario CHECK (VL_Unitario >= 0);
ALTER TABLE Ficha_Tecnica ADD CONSTRAINT CK_Ficha_Tecnica_Quantidade CHECK (QT_Consumida > 0);

-- FKs: impedem referencias a registros inexistentes.
-- Nao ha ON DELETE CASCADE: exclusoes devem ser avaliadas com cuidado
-- para preservar historico de pedidos, cancelamentos e pagamentos.
-- Integridade referencial
-- MESA -> COMANDA: uma comanda aponta para uma mesa existente.
ALTER TABLE Comanda
    ADD CONSTRAINT FK_Comanda_Mesa FOREIGN KEY (id_Mesa)
    REFERENCES Mesa (ID_Mesa);
-- FUNCIONARIO -> PEDIDO e COMANDA -> PEDIDO: responsabilidade e conta.
ALTER TABLE Pedido
    ADD CONSTRAINT FK_Pedido_Funcionario FOREIGN KEY (id_Funcionario)
    REFERENCES Funcionario (ID_Funcionario),
    ADD CONSTRAINT FK_Pedido_Comanda FOREIGN KEY (id_Comanda)
    REFERENCES Comanda (ID_Comanda);
-- PEDIDO -> ITEM_PEDIDO e PRODUTO -> ITEM_PEDIDO: itens detalhados.
ALTER TABLE Item_Pedido
    ADD CONSTRAINT FK_Item_Pedido_Pedido FOREIGN KEY (id_Pedido)
    REFERENCES Pedido (ID_Pedido),
    ADD CONSTRAINT FK_Item_Pedido_Produto FOREIGN KEY (id_Produto)
    REFERENCES Produto (ID_Produto);
-- COMANDA -> PAGAMENTO: valores recebidos associados a conta.
ALTER TABLE Pagamento
    ADD CONSTRAINT FK_Pagamento_Comanda FOREIGN KEY (id_Comanda)
    REFERENCES Comanda (ID_Comanda);
-- INSUMOS -> CONTROLE_INSUMOS: historico por insumo.
ALTER TABLE Controle_Insumos
    ADD CONSTRAINT FK_Controle_Insumos_Insumo FOREIGN KEY (id_Insumos)
    REFERENCES Insumos (ID_Insumos);
-- FORNECEDOR -> COMPRA: origem da aquisicao.
ALTER TABLE Compra
    ADD CONSTRAINT FK_Compra_Fornecedor FOREIGN KEY (id_Fornecedor)
    REFERENCES Fornecedor (ID_Fornecedor);
-- COMPRA -> ITEM_COMPRA e INSUMOS -> ITEM_COMPRA: compra detalhada.
ALTER TABLE Item_Compra
    ADD CONSTRAINT FK_Item_Compra_Insumo FOREIGN KEY (id_Insumos)
    REFERENCES Insumos (ID_Insumos),
    ADD CONSTRAINT FK_Item_Compra_Compra FOREIGN KEY (id_Compra)
    REFERENCES Compra (ID_Compra);
-- PRODUTO <-> INSUMOS: duas FKs formam associacao N:N.
ALTER TABLE Ficha_Tecnica
    ADD CONSTRAINT FK_Ficha_Tecnica_Produto FOREIGN KEY (ID_Produto)
    REFERENCES Produto (ID_Produto),
    ADD CONSTRAINT FK_Ficha_Tecnica_Insumo FOREIGN KEY (ID_Insumos)
    REFERENCES Insumos (ID_Insumos);

-- PROXIMAS ETAPAS (massa de dados e demonstracoes em outro momento):
-- 4. INSERT INTO (massa de dados)
-- 5. SELECT com JOIN
-- 6. UPDATE
-- 7. DELETE
-- 8. Consultas gerenciais G01, G02... com codigos de requisitos
-- 9. Consultas de auditoria A01, A02... com codigos de RN

-- =============================================================
-- 4. REGRAS OPERACIONAIS / TRIGGERS (SEM ALTERAR TABELAS)
-- =============================================================
-- Estas regras utilizam apenas os atributos que ja existem no modelo
-- logico aprovado. Todas as criacoes ficam APOS tabelas e FKs.
-- IMPORTANTE: os estados abaixo usam as grafias de referencia:
--   Comanda: 'Encerrada'; Pedido: 'Cancelado';
--   Movimentacao: 'Entrada' e 'Saida'.
-- A aplicacao deve usar a mesma convencao de valores.
-- Para uma instalacao em banco ja existente, executar apenas uma vez;
-- este arquivo completo foi pensado para um banco novo/vazio.
-- =============================================================

DELIMITER $$

-- -------------------------------------------------------------
-- TRIGGER RN10: BLOQUEAR PEDIDO NOVO EM COMANDA ENCERRADA
-- P1 / RF01 / RN10: impede abertura de novos pedidos quando a
-- comanda ja esta encerrada. A FK ja garante que a comanda existe.
-- SELECT FOR UPDATE protege a verificacao contra fechamento simultaneo.
-- -------------------------------------------------------------
CREATE TRIGGER TRG_Pedido_Validar_Comanda_Insert
BEFORE INSERT ON Pedido
FOR EACH ROW
BEGIN
    DECLARE v_status VARCHAR(20);

    SELECT ST_Comanda INTO v_status
    FROM Comanda
    WHERE ID_Comanda = NEW.id_Comanda
    FOR UPDATE;

    IF LOWER(TRIM(v_status)) = 'encerrada' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'RN10: comanda encerrada nao aceita novos pedidos';
    END IF;
END$$

-- -------------------------------------------------------------
-- TRIGGER RN10: BLOQUEAR TRANSFERENCIA PARA COMANDA ENCERRADA
-- RF01 / RN10: protege tambem UPDATE de id_Comanda em PEDIDO.
-- Nao modifica pedidos antigos; apenas evita novo vinculo indevido.
-- -------------------------------------------------------------
CREATE TRIGGER TRG_Pedido_Validar_Comanda_Update
BEFORE UPDATE ON Pedido
FOR EACH ROW
BEGIN
    DECLARE v_status VARCHAR(20);

    IF NEW.id_Comanda <> OLD.id_Comanda THEN
        SELECT ST_Comanda INTO v_status
        FROM Comanda
        WHERE ID_Comanda = NEW.id_Comanda
        FOR UPDATE;

        IF LOWER(TRIM(v_status)) = 'encerrada' THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'RN10: nao mover pedido para comanda encerrada';
        END IF;
    END IF;
END$$

-- -------------------------------------------------------------
-- TRIGGER RN07: CONFERENCIA FINANCEIRA ANTES DE FECHAR COMANDA
-- P3 / RF07 / RN07: ao mudar a situacao para 'Encerrada', compara
-- o total dos itens de pedidos nao cancelados com pagamentos.
-- VL_Total nao e uma coluna: o valor e calculado em cada consulta.
-- Sem coluna de confirmacao, a existencia de PAGAMENTO representa,
-- APENAS nesta versao, pagamento registrado/considerado recebido.
-- O trigger NAO comprova liquidacao bancaria nem estorno.
-- Uma comanda sem itens ou sem pagamentos nao pode ser encerrada.
-- -------------------------------------------------------------
CREATE TRIGGER TRG_Comanda_Validar_Encerramento
BEFORE UPDATE ON Comanda
FOR EACH ROW
BEGIN
    DECLARE v_total_consumo DECIMAL(18,2) DEFAULT 0;
    DECLARE v_total_pago DECIMAL(18,2) DEFAULT 0;
    DECLARE v_itens INT DEFAULT 0;

    IF LOWER(TRIM(NEW.ST_Comanda)) = 'encerrada'
       AND LOWER(TRIM(OLD.ST_Comanda)) <> 'encerrada' THEN

        SELECT COUNT(ip.ID_Item_Pedido),
               COALESCE(SUM(ip.QT_Item * ip.VL_Unitario), 0)
          INTO v_itens, v_total_consumo
        FROM Pedido p
        JOIN Item_Pedido ip ON ip.id_Pedido = p.ID_Pedido
        WHERE p.id_Comanda = NEW.ID_Comanda
          AND LOWER(TRIM(p.ST_Pedido)) <> 'cancelado';

        SELECT COALESCE(SUM(pg.VL_Pagamento), 0)
          INTO v_total_pago
        FROM Pagamento pg
        WHERE pg.id_Comanda = NEW.ID_Comanda;

        IF v_itens = 0 OR v_total_consumo <= 0 THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'RN07: comanda sem consumo valido nao pode encerrar';
        END IF;

        IF v_total_pago < v_total_consumo THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'RN07: pagamento registrado insuficiente';
        END IF;
    END IF;
END$$

-- -------------------------------------------------------------
-- TRIGGER RN08: PRESERVAR HISTORICO DE PEDIDOS CANCELADOS
-- RF01 / RN08: cancelamentos devem alterar ST_Pedido para
-- 'Cancelado', e nao apagar o pedido do banco de dados.
-- A FK de ITEM_PEDIDO tambem pode impedir exclusoes referenciadas.
-- -------------------------------------------------------------
CREATE TRIGGER TRG_Pedido_Preservar_Cancelado
BEFORE DELETE ON Pedido
FOR EACH ROW
BEGIN
    IF LOWER(TRIM(OLD.ST_Pedido)) = 'cancelado' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'RN08: pedido cancelado deve permanecer no historico';
    END IF;
END$$

-- -------------------------------------------------------------
-- TRIGGER RN04: VALIDAR ENTRADA OU SAIDA DE INSUMOS
-- P2 / RF04 / RN04: evita movimentos sem classificacao valida.
-- Nao cria movimentacoes automaticas ao inserir ITEM_COMPRA:
-- recebimento fisico e registro de compra sao etapas diferentes.
-- -------------------------------------------------------------
CREATE TRIGGER TRG_Movimentacao_Validar_Insert
BEFORE INSERT ON Controle_Insumos
FOR EACH ROW
BEGIN
    IF LOWER(TRIM(NEW.TP_Movimentacao)) NOT IN ('entrada', 'saida') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'RN04: movimentacao deve ser Entrada ou Saida';
    END IF;
END$$

-- -------------------------------------------------------------
-- TRIGGER RF04: ATUALIZAR ESTOQUE AO REGISTRAR MOVIMENTACAO
-- P2 / RF04: Entrada soma; Saida subtrai apenas se houver saldo.
-- Um UPDATE condicional previne estoque negativo e concorrencia
-- entre duas saidas sobre o mesmo insumo.
-- Os checks existentes ja exigem quantidade de movimento positiva.
-- O insert e o ajuste de saldo participam da mesma transacao InnoDB.
-- -------------------------------------------------------------
CREATE TRIGGER TRG_Movimentacao_Aplicar_Estoque
AFTER INSERT ON Controle_Insumos
FOR EACH ROW
BEGIN
    IF LOWER(TRIM(NEW.TP_Movimentacao)) = 'entrada' THEN
        UPDATE Insumos
           SET QT_Estoque = QT_Estoque + NEW.QT_Movimentacao
         WHERE ID_Insumos = NEW.id_Insumos;
    ELSE
        UPDATE Insumos
           SET QT_Estoque = QT_Estoque - NEW.QT_Movimentacao
         WHERE ID_Insumos = NEW.id_Insumos
           AND QT_Estoque >= NEW.QT_Movimentacao;

        IF ROW_COUNT() = 0 THEN
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'RF04: estoque insuficiente para a saida';
        END IF;
    END IF;
END$$

-- -------------------------------------------------------------
-- TRIGGERS RN04: NAO REESCREVER / APAGAR HISTORICO DE ESTOQUE
-- P2 / RN04: alterar ou remover uma movimentacao ja registrada
-- causaria divergencia entre historico e QT_Estoque.
-- Para corrigir um lancamento, registre uma nova movimentacao
-- compensatoria, com a operacao inversa.
-- -------------------------------------------------------------
CREATE TRIGGER TRG_Movimentacao_Bloquear_Update
BEFORE UPDATE ON Controle_Insumos
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'RN04: registro imutavel; use movimentacao compensatoria';
END$$

CREATE TRIGGER TRG_Movimentacao_Bloquear_Delete
BEFORE DELETE ON Controle_Insumos
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'RN04: historico de estoque nao pode ser apagado';
END$$

DELIMITER ;

-- =============================================================
-- 5. VIEWS: CONSULTAS PARA OPERACAO (SEM NOVAS TABELAS)
-- =============================================================
-- VIEW RF02 / RN02: alimenta fila de cozinha na interface ou
-- na integracao com a impressora. A view nao imprime sozinha:
-- o backend deve ler os registros e efetuar o envio/impressao.
-- Pedidos cancelados nao aparecem na fila.
CREATE VIEW VW_Fila_Cozinha AS
SELECT
    p.ID_Pedido,
    p.DT_Hora_Pedido,
    p.ST_Pedido,
    p.TP_Setor,
    p.id_Comanda,
    c.id_Mesa,
    m.NR_Mesa
FROM Pedido p
JOIN Comanda c ON c.ID_Comanda = p.id_Comanda
JOIN Mesa m ON m.ID_Mesa = c.id_Mesa
WHERE LOWER(TRIM(p.TP_Setor)) = 'cozinha'
  AND LOWER(TRIM(p.ST_Pedido)) <> 'cancelado';

-- VIEW RF06 / RN06 / P2: lista insumos com estoque no minimo
-- ou abaixo dele. Notificacoes visuais dependem da aplicacao.
CREATE VIEW VW_Alerta_Estoque AS
SELECT ID_Insumos, NM_Insumo, UN_Medida, QT_Estoque, QT_Minima
FROM Insumos
WHERE QT_Estoque <= QT_Minima;

-- =============================================================
-- 6. LIMITES DA IMPLEMENTACAO SEM MUDANCA DO MODELO LOGICO
-- =============================================================
-- RN09 / RNF04: permissao por funcionario exige autenticacao e
-- autorizacao no backend; TP_Funcao e um cadastro, nao uma sessao.
-- Nenhuma coluna, tabela de usuario ou perfil foi acrescentada.
-- RN07: nao existe campo de pagamento confirmado. O trigger usa
-- valores de PAGAMENTO como recebidos e nao representa estornos.
-- RN02 / RF02: a view prepara fila, mas impressora exige software.
-- RN03 / RF03: TP_Categoria e TP_Setor existem, mas separar itens
-- de um pedido misto entre setores depende do backend/interface.
-- RN04: QT_Estoque deve ser alterado pela inclusao de movimentos;
-- usuarios/aplicacoes com permissao para UPDATE direto em Insumos
-- ainda podem causar divergencias. Configurar permissoes na app.
-- RN08: protege DELETE de pedidos cancelados, mas aplicacoes com
-- poderes administrativos podem alterar status; controlar acesso.
-- Cardinalidade pedido-compra com pelo menos 1 item nao e imposta
-- por FK: validar na transacao da aplicacao antes da confirmacao.
-- Nao foram criadas novas tabelas, colunas, FKs ou constraints.
-- =============================================================

-- PROXIMAS ETAPAS SEGUNDO ROTEIRO DA ENTREGA:
-- INSERT INTO (secao 4), SELECT/JOIN, exemplos UPDATE e DELETE,
-- consultas gerenciais G01..., consultas de auditoria A01...
-- Os exemplos de DELETE devem respeitar as regras de historico.
