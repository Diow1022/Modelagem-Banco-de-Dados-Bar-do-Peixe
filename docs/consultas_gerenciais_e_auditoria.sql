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

-- G08 - Qual o ticket medio por comanda com consumo valido, a cada mes?
-- Atende: KPI10 (media do consumo de comandas com itens nao cancelados).
-- Periodo: mes de abertura da comanda. Inclui comandas abertas com consumo.
SELECT DATE_FORMAT(c.DT_Abertura, '%Y-%m') AS Mes,
       COUNT(*) AS Comandas_Com_Consumo,
       ROUND(SUM(v.Total_Consumo), 2) AS Consumo_Total,
       ROUND(AVG(v.Total_Consumo), 2) AS Ticket_Medio_Comanda
FROM Comanda c
JOIN (
    SELECT p.id_Comanda,
           SUM(ip.QT_Item * ip.VL_Unitario) AS Total_Consumo
    FROM Pedido p
    JOIN Item_Pedido ip ON ip.id_Pedido = p.ID_Pedido
    WHERE LOWER(TRIM(p.ST_Pedido)) <> 'cancelado'
    GROUP BY p.id_Comanda
    HAVING SUM(ip.QT_Item * ip.VL_Unitario) > 0
) v ON v.id_Comanda = c.ID_Comanda
GROUP BY DATE_FORMAT(c.DT_Abertura, '%Y-%m')
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
