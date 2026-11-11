-- ============================================================
-- BAR DO PEIXE | CONSULTAS GERENCIAIS E DE AUDITORIA
-- Compatibilidade: tabelas do docs/script.sql (branch main)
-- Executar APOS criar a estrutura e carregar a massa de dados.
-- Apenas SELECT: nao altera dados nem estrutura.
-- ============================================================
USE Bar_do_Peixe;

-- G01 - Quantos pedidos foram registrados, em quais situacoes e por quais funcionarios?
-- Atende: P1, KPI03 (quantidade de pedidos), KPI06 (situacao dos pedidos).
-- Periodo: por dia; total por situacao e funcionario.
SELECT DATE(p.DT_Hora_Pedido) AS Dia,
       p.ST_Pedido AS Situacao_Pedido,
       f.ID_Funcionario, f.NM_Funcionario,
       COUNT(DISTINCT p.ID_Pedido) AS Quantidade_Pedidos,
       COUNT(ip.ID_Item_Pedido) AS Linhas_De_Itens
FROM Pedido p
JOIN Funcionario f ON f.ID_Funcionario = p.id_Funcionario
JOIN Comanda c ON c.ID_Comanda = p.id_Comanda
LEFT JOIN Item_Pedido ip ON ip.id_Pedido = p.ID_Pedido
GROUP BY DATE(p.DT_Hora_Pedido), p.ST_Pedido,
         f.ID_Funcionario, f.NM_Funcionario
ORDER BY Dia DESC, Situacao_Pedido, f.NM_Funcionario;

-- G02 - Quais insumos atingiram o minimo e qual foi sua ultima movimentacao?
-- Atende: P2, KPI07 (insumos no minimo ou abaixo dele).
-- Medida: saldo atual e diferenca para o minimo; nao e previsao de demanda.
SELECT i.ID_Insumos, i.NM_Insumo, i.UN_Medida,
       i.QT_Estoque, i.QT_Minima,
       (i.QT_Minima - i.QT_Estoque) AS Diferenca_Para_Minimo,
       MAX(ci.DT_Movimentacao) AS Ultima_Movimentacao
FROM Insumos i
LEFT JOIN Controle_Insumos ci ON ci.id_Insumos = i.ID_Insumos
WHERE i.QT_Estoque <= i.QT_Minima
GROUP BY i.ID_Insumos, i.NM_Insumo, i.UN_Medida,
         i.QT_Estoque, i.QT_Minima
ORDER BY Diferenca_Para_Minimo DESC, i.NM_Insumo;

-- G03 - Quais comandas tem diferenca entre consumo valido e pagamento registrado?
-- Atende: P3, KPI09 (divergencia financeira por comanda).
-- Valores negativos significam pagamento menor que o consumo.
-- Usa agregacoes separadas para nao multiplicar linhas de pagamentos e itens.
SELECT c.ID_Comanda, m.NR_Mesa, c.ST_Comanda, c.DT_Abertura,
       COALESCE(v.Total_Consumo, 0) AS Total_Consumo,
       COALESCE(pg.Total_Pago, 0) AS Total_Pago,
       ROUND(COALESCE(pg.Total_Pago, 0) - COALESCE(v.Total_Consumo, 0), 2) AS Diferenca,
       CASE
           WHEN COALESCE(pg.Total_Pago, 0) < COALESCE(v.Total_Consumo, 0) THEN 'Pagamento insuficiente'
           WHEN COALESCE(pg.Total_Pago, 0) > COALESCE(v.Total_Consumo, 0) THEN 'Pagamento superior'
           ELSE 'Conciliado'
       END AS Diagnostico
FROM Comanda c
JOIN Mesa m ON m.ID_Mesa = c.id_Mesa
LEFT JOIN (
    SELECT p.id_Comanda, SUM(ip.QT_Item * ip.VL_Unitario) AS Total_Consumo
    FROM Pedido p
    JOIN Item_Pedido ip ON ip.id_Pedido = p.ID_Pedido
    WHERE LOWER(TRIM(p.ST_Pedido)) <> 'cancelado'
    GROUP BY p.id_Comanda
) v ON v.id_Comanda = c.ID_Comanda
LEFT JOIN (
    SELECT id_Comanda, SUM(VL_Pagamento) AS Total_Pago
    FROM Pagamento GROUP BY id_Comanda
) pg ON pg.id_Comanda = c.ID_Comanda
ORDER BY ABS(COALESCE(pg.Total_Pago, 0) - COALESCE(v.Total_Consumo, 0)) DESC,
         c.ID_Comanda;

-- G04 - Quanto foi comprado de cada fornecedor e quantas compras foram registradas?
-- Atende: P4, KPI08 (valor das compras).
-- Periodo: mes da compra; compras sem itens aparecem com valor zero.
SELECT DATE_FORMAT(c.DT_Compra, '%Y-%m') AS Mes,
       f.ID_Fornecedor, f.NM_Fornecedor,
       COUNT(DISTINCT c.ID_Compra) AS Quantidade_Compras,
       ROUND(COALESCE(SUM(ic.QT_Comprada * ic.VL_Unitario), 0), 2) AS Valor_Compras
FROM Compra c
JOIN Fornecedor f ON f.ID_Fornecedor = c.id_Fornecedor
LEFT JOIN Item_Compra ic ON ic.id_Compra = c.ID_Compra
GROUP BY DATE_FORMAT(c.DT_Compra, '%Y-%m'), f.ID_Fornecedor, f.NM_Fornecedor
ORDER BY Mes DESC, Valor_Compras DESC;

-- G05 - Quanto foi registrado em pagamentos por mes e forma de pagamento?
-- Atende: KPI01 (total de pagamentos), KPI05 (distribuicao por forma).
-- Participacao percentual calculada sobre total de cada mes.
SELECT DATE_FORMAT(pg.DT_Pagamento, '%Y-%m') AS Mes,
       pg.TP_Pagamento AS Forma_Pagamento,
       COUNT(*) AS Quantidade_Pagamentos,
       ROUND(SUM(pg.VL_Pagamento), 2) AS Total_Pagamentos,
       ROUND(100 * SUM(pg.VL_Pagamento) /
           NULLIF((SELECT SUM(p2.VL_Pagamento)
                   FROM Pagamento p2
                   WHERE DATE_FORMAT(p2.DT_Pagamento, '%Y-%m') =
                         DATE_FORMAT(pg.DT_Pagamento, '%Y-%m')), 0), 2) AS Participacao_Percentual
FROM Pagamento pg
GROUP BY DATE_FORMAT(pg.DT_Pagamento, '%Y-%m'), pg.TP_Pagamento
ORDER BY Mes DESC, Total_Pagamentos DESC;

-- G06 - Qual o valor dos pedidos validos por dia?
-- Atende: KPI02 (soma do consumo de pedidos nao cancelados).
-- Os totais usam os precos historicos registrados em Item_Pedido.
SELECT DATE(p.DT_Hora_Pedido) AS Dia,
       COUNT(DISTINCT p.ID_Pedido) AS Pedidos_Validos,
       ROUND(COALESCE(SUM(ip.QT_Item * ip.VL_Unitario), 0), 2) AS Valor_Pedidos_Validos
FROM Pedido p
LEFT JOIN Item_Pedido ip ON ip.id_Pedido = p.ID_Pedido
WHERE LOWER(TRIM(p.ST_Pedido)) <> 'cancelado'
GROUP BY DATE(p.DT_Hora_Pedido)
ORDER BY Dia DESC;

-- G07 - Quais produtos tiveram maior quantidade vendida?
-- Atende: KPI04 (ranking de produtos vendidos).
-- Pedidos cancelados excluidos; valores utilizam preco historico.
SELECT pr.ID_Produto, pr.NM_Produto, pr.TP_Categoria,
       SUM(ip.QT_Item) AS Unidades_Vendidas,
       ROUND(SUM(ip.QT_Item * ip.VL_Unitario), 2) AS Valor_Registrado
FROM Item_Pedido ip
JOIN Pedido p ON p.ID_Pedido = ip.id_Pedido
JOIN Produto pr ON pr.ID_Produto = ip.id_Produto
WHERE LOWER(TRIM(p.ST_Pedido)) <> 'cancelado'
GROUP BY pr.ID_Produto, pr.NM_Produto, pr.TP_Categoria
ORDER BY Unidades_Vendidas DESC, Valor_Registrado DESC, pr.NM_Produto;


-- G08 - Ticket medio por comanda
-- Atende: KPI10
-- Considera pedidos nao cancelados

SELECT
    DATE_FORMAT(Comanda.DT_Abertura, '%Y-%m') AS Mes,
    COUNT(*) AS Comandas_Com_Consumo,
    ROUND(SUM(Consumo.Total_Consumo), 2) AS Consumo_Total,
    ROUND(AVG(Consumo.Total_Consumo), 2) AS Ticket_Medio_Comanda

FROM Comanda

INNER JOIN (
    SELECT
        Pedido.id_Comanda,
        SUM(
            Item_Pedido.QT_Item * Item_Pedido.VL_Unitario
        ) AS Total_Consumo

    FROM Pedido

    INNER JOIN Item_Pedido
        ON Item_Pedido.id_Pedido = Pedido.ID_Pedido

    WHERE LOWER(TRIM(Pedido.ST_Pedido)) <> 'cancelado'

    GROUP BY Pedido.id_Comanda

    HAVING Total_Consumo > 0

) AS Consumo
    ON Consumo.id_Comanda = Comanda.ID_Comanda

GROUP BY DATE_FORMAT(Comanda.DT_Abertura, '%Y-%m')

ORDER BY Mes DESC;


-- ============================================================
-- AUDITORIAS (A01 - A08)
-- ATENCAO: algumas auditorias sao controles operacionais ou
-- verificacoes complementares; nao substituem triggers/permissoes.
-- ============================================================

-- A01 - Existem pedidos sem comanda, mesa ou funcionario associado?
-- Verifica: RN01 (pedido ligado a comanda e mesa).
-- FKs/NOT NULL normalmente impedem estes casos; retorno vazio e esperado.
SELECT p.ID_Pedido, p.id_Comanda, p.id_Funcionario,
       c.id_Mesa
FROM Pedido p
LEFT JOIN Comanda c ON c.ID_Comanda = p.id_Comanda
LEFT JOIN Mesa m ON m.ID_Mesa = c.id_Mesa
LEFT JOIN Funcionario f ON f.ID_Funcionario = p.id_Funcionario
WHERE c.ID_Comanda IS NULL OR m.ID_Mesa IS NULL OR f.ID_Funcionario IS NULL;

-- A02 - Existem pedidos nao cancelados sem nenhum item?
-- Verifica: integridade do pedido associada a RN01/RF01;
-- reforca a cardinalidade minima prevista no modelo logico.
SELECT p.ID_Pedido, p.ST_Pedido, p.DT_Hora_Pedido, p.id_Comanda
FROM Pedido p
LEFT JOIN Item_Pedido ip ON ip.id_Pedido = p.ID_Pedido
WHERE LOWER(TRIM(p.ST_Pedido)) <> 'cancelado'
GROUP BY p.ID_Pedido, p.ST_Pedido, p.DT_Hora_Pedido, p.id_Comanda
HAVING COUNT(ip.ID_Item_Pedido) = 0;

-- A03 - Ha insumos com movimentacao de tipo invalido ou quantidade nao positiva?
-- Verifica: RN04 (tipo, data, quantidade e insumo da movimentacao).
-- O trigger valida INSERT; FKs/CHECKs verificam outras partes.
SELECT ci.ID_Movimentacao, ci.id_Insumos, ci.DT_Movimentacao,
       ci.TP_Movimentacao, ci.QT_Movimentacao
FROM Controle_Insumos ci
WHERE ci.DT_Movimentacao IS NULL
   OR ci.id_Insumos IS NULL
   OR ci.QT_Movimentacao <= 0
   OR LOWER(TRIM(ci.TP_Movimentacao)) NOT IN ('entrada', 'saida');

-- A04 - Ha funcionarios sem funcao ou turno devidamente preenchidos?
-- Verifica: RN05 (funcao e turno de cada funcionario).
-- NOT NULL nao impede string vazia, por isso a checagem complementar.
SELECT f.ID_Funcionario, f.NM_Funcionario, f.TP_Funcao, f.TP_Turno
FROM Funcionario f
WHERE TRIM(f.TP_Funcao) = '' OR TRIM(f.TP_Turno) = '';

-- A05 - Existem insumos no minimo ou abaixo dele a sinalizar?
-- Monitora: RN06 (alerta de reposicao). Nao e falha de integridade.
SELECT i.ID_Insumos, i.NM_Insumo, i.QT_Estoque, i.QT_Minima
FROM Insumos i
WHERE i.QT_Estoque <= i.QT_Minima
ORDER BY i.QT_Estoque - i.QT_Minima;

-- A06 - Existem comandas encerradas com pagamento inferior ao consumo
--       ou sem consumo valido?
-- Verifica: RN07 (condicao para encerramento).
-- Registro de pagamento nao prova liquidacao bancaria nesta versao.
SELECT c.ID_Comanda, c.ST_Comanda,
       COALESCE(v.Total_Consumo, 0) AS Total_Consumo,
       COALESCE(pg.Total_Pago, 0) AS Total_Pago
FROM Comanda c
LEFT JOIN (
    SELECT p.id_Comanda, SUM(ip.QT_Item * ip.VL_Unitario) AS Total_Consumo
    FROM Pedido p JOIN Item_Pedido ip ON ip.id_Pedido = p.ID_Pedido
    WHERE LOWER(TRIM(p.ST_Pedido)) <> 'cancelado'
    GROUP BY p.id_Comanda
) v ON v.id_Comanda = c.ID_Comanda
LEFT JOIN (
    SELECT id_Comanda, SUM(VL_Pagamento) AS Total_Pago
    FROM Pagamento GROUP BY id_Comanda
) pg ON pg.id_Comanda = c.ID_Comanda
WHERE LOWER(TRIM(c.ST_Comanda)) = 'encerrada'
  AND (COALESCE(v.Total_Consumo, 0) <= 0
       OR COALESCE(pg.Total_Pago, 0) < COALESCE(v.Total_Consumo, 0));

-- A07 - Existem produtos sem categoria preenchida?
-- Verifica parcialmente: RN03 (classificacao alimento/bebida).
-- Nao valida se a categoria textual corresponde ao tipo correto.
SELECT p.ID_Produto, p.NM_Produto, p.TP_Categoria
FROM Produto p
WHERE TRIM(p.TP_Categoria) = '';

-- A08 - Ha pedidos em comandas encerradas sem itens ou com valor total
--       de itens inferior/igual a zero?
-- Monitora: RN07 e integridade operacional de pedidos.
-- NAO comprova RN10: falta data/hora do encerramento da comanda.
SELECT c.ID_Comanda, p.ID_Pedido, p.ST_Pedido,
       COUNT(ip.ID_Item_Pedido) AS Quantidade_Itens,
       COALESCE(SUM(ip.QT_Item * ip.VL_Unitario), 0) AS Valor_Itens
FROM Comanda c
JOIN Pedido p ON p.id_Comanda = c.ID_Comanda
LEFT JOIN Item_Pedido ip ON ip.id_Pedido = p.ID_Pedido
WHERE LOWER(TRIM(c.ST_Comanda)) = 'encerrada'
  AND LOWER(TRIM(p.ST_Pedido)) <> 'cancelado'
GROUP BY c.ID_Comanda, p.ID_Pedido, p.ST_Pedido
HAVING COUNT(ip.ID_Item_Pedido) = 0
    OR COALESCE(SUM(ip.QT_Item * ip.VL_Unitario), 0) <= 0;

-- LIMITES DE AUDITORIA:
-- RN02: VW_Fila_Cozinha apresenta o pedido, mas nao prova a impressao.
-- RN08: nao se consegue provar um DELETE passado sem trilha de auditoria.
-- RN09: cadastro de funcao nao prova autorizacao de acesso.
-- RN10: trigger bloqueia insercoes em comanda encerrada, mas sem
--       DT_Encerramento nao se audita historicamente o momento de inclusao.
-- Nao criar coluna ou alterar DER apenas para essas SELECTs.



--Script
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
