-- ============================================================================
-- BAR DO PEIXE | MASSA DE DADOS FICTICIA
-- LOTE 01: EXATAMENTE 15 REGISTROS
-- ============================================================================
-- Referencia: Entrega 2, secao 1.1 (porte) e secao 4 (massa de dados).
-- Pre-requisito: o script de estrutura, constraints, views e triggers
-- ja deve ter sido executado com sucesso no banco bar_do_peixe.
--
-- IMPORTANTE:
-- 1) Todos os nomes, o fornecedor, o CNPJ e o telefone abaixo sao ficticios.
-- 2) Executar este lote APENAS UMA VEZ em um banco sem esses cadastros.
-- 3) Nao apaga nem modifica registros existentes.
-- 4) Os proximos lotes de 15 registros dependem de autorizacao do grupo.
-- 5) Nao ha pedidos nem movimentacoes neste lote: eles exigem cadastros
--    anteriores e serao inseridos em lotes posteriores, com integridade.
--
-- Justificativa do volume (contexto do projeto):
--   FUNCIONARIO: 4 de aproximadamente 10 pessoas da equipe.
--   MESA:        4 de aproximadamente 20 mesas em funcionamento.
--   PRODUTO:     3 de aproximadamente 25 itens do cardapio.
--   INSUMOS:     3 itens iniciais para controle e alerta de estoque.
--   FORNECEDOR:  1 cadastro inicial para compras futuras.
-- TOTAL: 4 + 4 + 3 + 3 + 1 = 15 registros.
-- ============================================================================

USE Bar_do_Peixe;

-- Uma unica transacao permite confirmar este lote em conjunto.
START TRANSACTION;

-- ---------------------------------------------------------------------------
-- BLOCO 01 - FUNCIONARIO | 4 registros | RF05 / RN05
-- Objetivo: representar parte dos colaboradores de salao, cozinha e gestao.
-- Funcoes e turnos ficam cadastrados, conforme a regra RN05.
-- ---------------------------------------------------------------------------
INSERT INTO Funcionario (NM_Funcionario, TP_Funcao, TP_Turno) VALUES
('Marina Oliveira', 'Gerente', 'Dia'),
('Caio Fernandes', 'Atendente', 'Dia'),
('Larissa Monteiro', 'Cozinheiro', 'Noite'),
('Rafael Almeida', 'Ajudante', 'Noite');

-- ---------------------------------------------------------------------------
-- BLOCO 02 - MESA | 4 registros | RN01 / P3
-- Objetivo: identificar mesas distintas e suas capacidades.
-- Quatro registros representam uma amostra das vinte mesas do bar.
-- NR_Mesa e unico e QT_Lugares precisa ser maior que zero.
-- ---------------------------------------------------------------------------
INSERT INTO Mesa (NR_Mesa, TP_Situacao, QT_Lugares) VALUES
(1, 'Livre', 4),
(2, 'Livre', 4),
(3, 'Livre', 2),
(4, 'Livre', 6);

-- ---------------------------------------------------------------------------
-- BLOCO 03 - PRODUTO | 3 registros | RF03 / RN03
-- Objetivo: iniciar um cardapio misto com alimentos e bebidas.
-- Os precos sao ilustrativos e NAO sao precos reais da organizacao.
-- 'Alimento' e 'Bebida' separam as categorias para consultas posteriores.
-- ---------------------------------------------------------------------------
INSERT INTO Produto (NM_Produto, TP_Categoria, VL_Preco, ST_Produto) VALUES
('Prato feito de peixe', 'Alimento', 29.90, 'Ativo'),
('Refrigerante lata 350 ml', 'Bebida', 6.50, 'Ativo'),
('Porcao de batata frita', 'Alimento', 22.00, 'Ativo');

-- ---------------------------------------------------------------------------
-- BLOCO 04 - INSUMOS | 3 registros | P2 / RF04 / RF06 / RN06
-- Objetivo: registrar saldos e minimos para futuras consultas de alerta.
-- Unidade 'kg' representa quilogramas; 'un' representa unidades.
-- Refrigerante com estoque 5 e minimo 12 ilustra necessidade de reposicao.
-- Valores sao ficticios; ainda NAO existe movimentacao de entrada/saida.
-- ---------------------------------------------------------------------------
INSERT INTO Insumos (NM_Insumo, UN_Medida, QT_Estoque, QT_Minima) VALUES
('File de peixe', 'kg', 8.000, 3.000),
('Arroz branco', 'kg', 12.000, 4.000),
('Refrigerante lata 350 ml', 'un', 5.000, 12.000);

-- ---------------------------------------------------------------------------
-- BLOCO 05 - FORNECEDOR | 1 registro | P4
-- Objetivo: cadastrar uma origem possivel para compras futuras.
-- CNPJ 00000000000000 e telefone 00000000000 sao placeholders ficticios
-- para demonstracao; nao devem ser tratados como documentos reais validos.
-- O campo NR_CNPJ exige 14 caracteres e aceita unicidade.
-- ---------------------------------------------------------------------------
INSERT INTO Fornecedor (NM_Fornecedor, NR_CNPJ, NR_Telefone, ST_Fornecedor) VALUES
('Distribuidora Exemplo LTDA', '00000000000000', '00000000000', 'Ativo');

COMMIT;

-- ---------------------------------------------------------------------------
-- CONFERENCIA DO LOTE 01 (consultas somente leitura)
-- Retornam a quantidade acumulada de linhas de cada tabela de cadastro.
-- Em banco inicialmente vazio, esperado: 4 + 4 + 3 + 3 + 1 = 15.
-- ---------------------------------------------------------------------------
SELECT 'Funcionario' AS Tabela, COUNT(*) AS Registros FROM Funcionario
UNION ALL SELECT 'Mesa', COUNT(*) FROM Mesa
UNION ALL SELECT 'Produto', COUNT(*) FROM Produto
UNION ALL SELECT 'Insumos', COUNT(*) FROM Insumos
UNION ALL SELECT 'Fornecedor', COUNT(*) FROM Fornecedor;

-- Demonstra RF06: a view deve incluir o refrigerante abaixo do minimo.
SELECT * FROM vw_alerta_estoque;

-- ============================================================================
-- FIM DO LOTE 01 (15 registros). PROXIMO LOTE SOMENTE COM AUTORIZACAO.
-- ============================================================================

-- ============================================================================
-- BAR DO PEIXE | LOTE 02: MAIS 15 REGISTROS FICTICIOS
-- ACUMULADO: LOTE 01 (15) + LOTE 02 (15) = 30 REGISTROS
-- ============================================================================
-- Referencia: Entrega 2, secao 1.1 e secao 4.
-- Este bloco e um complemento do Lote 01, e NAO o substitui.
-- PRE-REQUISITO: executar o Lote 01 primeiro, no mesmo banco.
-- ATENCAO: executar cada lote apenas uma vez para evitar duplicacoes.
-- Foram escolhidas apenas tabelas de cadastro, que nao precisam de FKs
-- de outros registros. Nenhum trigger de pedidos ou estoque e acionado.
-- Nenhum dado real de clientes, empregados ou fornecedores foi utilizado.
--
-- Justificativa do volume acumulado frente ao porte do Bar do Peixe:
-- FUNCIONARIO: +2 = 6 de aproximadamente 10 trabalhadores.
-- MESA:        +4 = 8 de aproximadamente 20 mesas.
-- PRODUTO:     +5 = 8 de aproximadamente 25 opcoes no cardapio.
-- INSUMOS:     +3 = 6 componentes para o controle de estoque.
-- FORNECEDOR:  +1 = 2 origens ficticias para compras posteriores.
-- TOTAL LOTE 02: 2 + 4 + 5 + 3 + 1 = 15 registros.
-- ============================================================================

USE Bar_do_Peixe;
START TRANSACTION;

-- ---------------------------------------------------------------------------
-- BLOCO 06 - FUNCIONARIO | +2 registros | RF05 / RN05
-- Amplia a equipe para representar atendimento e cozinha em turnos distintos.
-- ---------------------------------------------------------------------------
INSERT INTO Funcionario (NM_Funcionario, TP_Funcao, TP_Turno) VALUES
('Bianca Ribeiro', 'Atendente', 'Noite'),
('Eduardo Nogueira', 'Cozinheiro', 'Dia');

-- ---------------------------------------------------------------------------
-- BLOCO 07 - MESA | +4 registros | RN01 / P3
-- Acrescenta mesas de numeros ineditos para futuras comandas e pedidos.
-- ---------------------------------------------------------------------------
INSERT INTO Mesa (NR_Mesa, TP_Situacao, QT_Lugares) VALUES
(5, 'Livre', 4),
(6, 'Livre', 2),
(7, 'Livre', 4),
(8, 'Livre', 6);

-- ---------------------------------------------------------------------------
-- BLOCO 08 - PRODUTO | +5 registros | RF03 / RN03
-- Cardapio ficticio com pratos, lanches, doces e bebidas, permitindo
-- consultas por categoria e futura montagem de pedidos mistos.
-- ---------------------------------------------------------------------------
INSERT INTO Produto (NM_Produto, TP_Categoria, VL_Preco, ST_Produto) VALUES
('Prato feito de frango', 'Alimento', 27.90, 'Ativo'),
('Sanduiche de queijo', 'Alimento', 14.00, 'Ativo'),
('Suco de laranja 300 ml', 'Bebida', 8.00, 'Ativo'),
('Agua mineral 500 ml', 'Bebida', 4.50, 'Ativo'),
('Pudim de leite', 'Alimento', 9.00, 'Ativo');

-- ---------------------------------------------------------------------------
-- BLOCO 09 - INSUMOS | +3 registros | P2 / RF04 / RF06 / RN06
-- Complementa os insumos para futuras fichas tecnicas e movimentacoes.
-- O frango com saldo igual ao minimo ilustra alerta preventivo RN06.
-- QT_Estoque e saldo inicial ficticio; ainda sem movimentacao vinculada.
-- ---------------------------------------------------------------------------
INSERT INTO Insumos (NM_Insumo, UN_Medida, QT_Estoque, QT_Minima) VALUES
('File de frango', 'kg', 3.000, 3.000),
('Batata para fritura', 'kg', 10.000, 4.000),
('Agua mineral 500 ml', 'un', 18.000, 8.000);

-- ---------------------------------------------------------------------------
-- BLOCO 10 - FORNECEDOR | +1 registro | P4
-- Segundo fornecedor ficticio para simular compras de origens diversas.
-- O CNPJ e propositalmente um identificador de teste, nao documento real.
-- ---------------------------------------------------------------------------
INSERT INTO Fornecedor (NM_Fornecedor, NR_CNPJ, NR_Telefone, ST_Fornecedor) VALUES
('Abastecimento Modelo LTDA', '11111111111111', '00000000001', 'Ativo');

COMMIT;

-- ---------------------------------------------------------------------------
-- CONFERENCIA ACUMULADA DOS LOTES 01 E 02 (SOMENTE LEITURA)
-- Estes totais sao esperados se o banco estava vazio antes do Lote 01.
-- 6 funcionarios + 8 mesas + 8 produtos + 6 insumos + 2 fornecedores = 30.
-- ---------------------------------------------------------------------------
SELECT 'Funcionario' AS Tabela, COUNT(*) AS Registros FROM Funcionario
UNION ALL SELECT 'Mesa', COUNT(*) FROM Mesa
UNION ALL SELECT 'Produto', COUNT(*) FROM Produto
UNION ALL SELECT 'Insumos', COUNT(*) FROM Insumos
UNION ALL SELECT 'Fornecedor', COUNT(*) FROM Fornecedor;

-- Conferencia da RN06: insumos no minimo ou abaixo dele.
-- Deve incluir o refrigerante do Lote 01 e o frango do Lote 02.
SELECT * FROM vw_alerta_estoque;

-- ============================================================================
-- FIM DO LOTE 02: 15 NOVOS REGISTROS | TOTAL ARMAZENADO NO ARQUIVO: 30
-- PROXIMO LOTE SOMENTE MEDIANTE NOVA AUTORIZACAO DO GRUPO.
-- ============================================================================

-- ============================================================================
-- BAR DO PEIXE | LOTE 03: MAIS 15 REGISTROS FICTICIOS
-- ACUMULADO: LOTE 01 (15) + LOTE 02 (15) + LOTE 03 (15) = 45 REGISTROS
-- ============================================================================
-- Referencia: Entrega 2, secoes 1.1 e 4 (massa de dados ficticia e realista).
-- PRE-REQUISITO: lotes 01 e 02 executados uma unica vez, na ordem indicada,
-- em um banco inicialmente vazio e sem cadastros adicionais interferindo nos
-- identificadores AUTO_INCREMENT. Executar o arquivo consolidado completo
-- apenas se nenhum dos lotes tiver sido executado antes.
--
-- Justificativa do volume acumulado segundo o porte informado:
-- FUNCIONARIO: +4 = 10, cobrindo aproximadamente 10 colaboradores.
-- MESA:        +5 = 13, aproximando-se das 20 mesas do estabelecimento.
-- PRODUTO:     +3 = 11, cobrindo parte dos 25 itens do cardapio.
-- INSUMOS:     +0 = 6, com saldos e limites para futuros testes.
-- FORNECEDOR:  +0 = 2, para simular compras posteriores.
-- FICHA_TECNICA: +3 = 3, associacoes entre produtos e insumos (N:N).
-- TOTAL DO LOTE 03: 4 + 5 + 3 + 3 = 15 registros.
-- Os nomes, produtos e precos abaixo sao ilustrativos e nao correspondem
-- a informacoes pessoais ou comerciais reais do Bar do Peixe.
-- ============================================================================

USE Bar_do_Peixe;
START TRANSACTION;

-- ---------------------------------------------------------------------------
-- BLOCO 11 - FUNCIONARIO | +4 registros | RF05 / RN05
-- Completa uma equipe ficticia de dez pessoas, com funcao e turno definidos.
-- Nao cria controle de acesso (RN09): isso depende da camada de aplicacao.
-- ---------------------------------------------------------------------------
INSERT INTO Funcionario (NM_Funcionario, TP_Funcao, TP_Turno) VALUES
('Patricia Costa', 'Atendente', 'Dia'),
('Leandro Martins', 'Ajudante', 'Dia'),
('Camila Azevedo', 'Caixa', 'Noite'),
('Tiago Moreira', 'Atendente', 'Noite');

-- ---------------------------------------------------------------------------
-- BLOCO 12 - MESA | +5 registros | P3 / RN01
-- Amplia o cadastro com mesas 9 a 13, numeros ainda nao utilizados.
-- Permanecem livres, permitindo abrir comandas em lotes futuros.
-- ---------------------------------------------------------------------------
INSERT INTO Mesa (NR_Mesa, TP_Situacao, QT_Lugares) VALUES
(9, 'Livre', 4),
(10, 'Livre', 2),
(11, 'Livre', 4),
(12, 'Livre', 6),
(13, 'Livre', 4);

-- ---------------------------------------------------------------------------
-- BLOCO 13 - PRODUTO | +3 registros | RF03 / RN03
-- Acrescenta variedade ao cardapio ficticio com alimento, lanche e bebida.
-- Os precos servem somente para os futuros cenarios de venda e pagamento.
-- ---------------------------------------------------------------------------
INSERT INTO Produto (NM_Produto, TP_Categoria, VL_Preco, ST_Produto) VALUES
('Prato feito de carne', 'Alimento', 31.90, 'Ativo'),
('Pao de queijo', 'Alimento', 7.00, 'Ativo'),
('Cafe coado', 'Bebida', 5.00, 'Ativo');

-- ---------------------------------------------------------------------------
-- BLOCO 14 - FICHA_TECNICA | +3 registros | RF04 / RN04
-- Vincula produtos do cardapio a insumos existentes, representando a
-- composicao do prato (relacionamento muitos-para-muitos PRODUTO x INSUMOS).
-- QT_Consumida esta na mesma unidade cadastrada em INSUMOS (kg ou un).
-- Estes registros NAO fazem baixa de estoque por si mesmos.
-- ATENCAO: IDs 1, 3 e 5 referem-se a cadastros dos Lotes 01 e 02,
-- supondo execucao sequencial em banco inicialmente vazio.
-- Produto 1: prato feito de peixe; Insumo 1: file de peixe (0,250 kg).
-- Produto 1: prato feito de peixe; Insumo 2: arroz branco (0,150 kg).
-- Produto 3: porcao de batata frita; Insumo 5: batata (0,300 kg).
-- ---------------------------------------------------------------------------
INSERT INTO Ficha_Tecnica (ID_Produto, ID_Insumos, QT_Consumida) VALUES
(1, 1, 0.250),
(1, 2, 0.150),
(3, 5, 0.300);

COMMIT;

-- ---------------------------------------------------------------------------
-- CONFERENCIA DOS LOTES 01, 02 E 03 (SOMENTE LEITURA)
-- Expectativa em banco originalmente vazio:
--   10 funcionarios + 13 mesas + 11 produtos + 6 insumos
--   + 2 fornecedores + 3 fichas tecnicas = 45 registros.
-- ---------------------------------------------------------------------------
SELECT 'Funcionario' AS Tabela, COUNT(*) AS Registros FROM Funcionario
UNION ALL SELECT 'Mesa', COUNT(*) FROM Mesa
UNION ALL SELECT 'Produto', COUNT(*) FROM Produto
UNION ALL SELECT 'Insumos', COUNT(*) FROM Insumos
UNION ALL SELECT 'Fornecedor', COUNT(*) FROM Fornecedor
UNION ALL SELECT 'Ficha_Tecnica', COUNT(*) FROM Ficha_Tecnica;

-- Consulta para conferir os vinculos de ingredientes com produtos (RF04).
SELECT p.NM_Produto, i.NM_Insumo, ft.QT_Consumida, i.UN_Medida
FROM Ficha_Tecnica ft
JOIN Produto p ON p.ID_Produto = ft.ID_Produto
JOIN Insumos i ON i.ID_Insumos = ft.ID_Insumos
ORDER BY p.ID_Produto, i.ID_Insumos;

-- ==========================================================================
-- FIM DO LOTE 03: 15 NOVOS REGISTROS | ACUMULADO NO ARQUIVO: 45 REGISTROS
-- NOVOS LOTES DEPENDEM DE AUTORIZACAO EXPRESSA DO GRUPO.
-- ==========================================================================


-- ==========================================================================
-- BAR DO PEIXE | LOTE 04: MAIS 15 REGISTROS FICTICIOS
-- ACUMULADO: LOTE 01 (15) + 02 (15) + 03 (15) + 04 (15) = 60 REGISTROS
-- ==========================================================================
-- Referencia: Entrega 2, secoes 1.1 e 4.
-- O estabelecimento tem aproximadamente 20 mesas, 25 produtos e 10
-- colaboradores. Este lote completa as 20 mesas e amplia o cardapio para
-- 15 produtos. Acrescenta 2 insumos e 2 associacoes de ficha tecnica.
-- PRE-REQUISITOS: lotes 01, 02 e 03 executados anteriormente, nessa ordem,
-- em banco inicialmente vazio. Alternativamente, executar este arquivo
-- consolidado UMA UNICA VEZ em banco com estrutura criada, mas sem registros.
-- ATENCAO: os identificadores em Ficha_Tecnica pressupõem IDs gerados na
-- ordem dos lotes, sem insercoes externas nem execucoes repetidas.
-- Todos os produtos e valores sao ficticios para demonstracao academica.
-- RESUMO LOTE 04: 7 mesas + 4 produtos + 2 insumos + 2 fichas = 15.
-- ============================================================================

USE Bar_do_Peixe;
START TRANSACTION;

-- ---------------------------------------------------------------------------
-- BLOCO 15 - MESA | +7 registros | RN01 / P3
-- Completa o cadastro de 20 mesas, coerente com o porte levantado.
-- Numeros 14 a 20 nao se repetem e as capacidades sao positivas.
-- ---------------------------------------------------------------------------
INSERT INTO Mesa (NR_Mesa, TP_Situacao, QT_Lugares) VALUES
(14, 'Livre', 4),
(15, 'Livre', 2),
(16, 'Livre', 4),
(17, 'Livre', 6),
(18, 'Livre', 4),
(19, 'Livre', 2),
(20, 'Livre', 4);

-- ---------------------------------------------------------------------------
-- BLOCO 16 - PRODUTO | +4 registros | RF03 / RN03
-- Amplia o cardapio com duas refeicoes, um lanche e uma bebida.
-- Precos ficticios e nao negativos respeitam CK_Produto_Preco.
-- ---------------------------------------------------------------------------
INSERT INTO Produto (NM_Produto, TP_Categoria, VL_Preco, ST_Produto) VALUES
('Macarrao ao molho de tomate', 'Alimento', 24.90, 'Ativo'),
('Misto quente', 'Alimento', 13.50, 'Ativo'),
('Cha gelado 300 ml', 'Bebida', 7.50, 'Ativo'),
('Omelete com salada', 'Alimento', 21.90, 'Ativo');

-- ---------------------------------------------------------------------------
-- BLOCO 17 - INSUMOS | +2 registros | P2 / RF04 / RF06
-- Cadastra materia-prima para futuros pedidos e fichas tecnicas.
-- Cha com saldo inferior ao minimo ilustra alerta de reposicao RN06.
-- Os estoques iniciais nao geram movimentos automaticamente.
-- ---------------------------------------------------------------------------
INSERT INTO Insumos (NM_Insumo, UN_Medida, QT_Estoque, QT_Minima) VALUES
('Macarrao seco', 'kg', 6.000, 2.000),
('Cha gelado 300 ml', 'un', 4.000, 10.000);

-- ---------------------------------------------------------------------------
-- BLOCO 18 - FICHA_TECNICA | +2 registros | RF04 / RN04
-- Relaciona produtos e insumos ja existentes, sem baixar estoque.
-- (4, 4): prato feito de frango e file de frango (0,250 kg por prato).
-- (2, 3): refrigerante lata e insumo refrigerante (1 unidade por venda).
-- Referencias dependem de AUTO_INCREMENT sequencial em banco vazio.
-- ---------------------------------------------------------------------------
INSERT INTO Ficha_Tecnica (ID_Produto, ID_Insumos, QT_Consumida) VALUES
(4, 4, 0.250),
(2, 3, 1.000);

COMMIT;

-- ---------------------------------------------------------------------------
-- CONFERENCIA ACUMULADA DE TODOS OS LOTES (SOMENTE LEITURA)
-- EXPECTATIVA: 10 funcionarios + 20 mesas + 15 produtos + 8 insumos
--             + 2 fornecedores + 5 fichas tecnicas = 60 registros.
-- A consulta devolve contagens reais apos a importacao no MySQL.
-- ---------------------------------------------------------------------------
SELECT 'Funcionario' AS Tabela, COUNT(*) AS Registros FROM Funcionario
UNION ALL SELECT 'Mesa', COUNT(*) FROM Mesa
UNION ALL SELECT 'Produto', COUNT(*) FROM Produto
UNION ALL SELECT 'Insumos', COUNT(*) FROM Insumos
UNION ALL SELECT 'Fornecedor', COUNT(*) FROM Fornecedor
UNION ALL SELECT 'Ficha_Tecnica', COUNT(*) FROM Ficha_Tecnica;

-- Deve retornar refrigerante, file de frango e cha gelado entre os alertas.
SELECT * FROM vw_alerta_estoque;

-- ==========================================================================
-- FIM DO LOTE 04: 15 NOVOS REGISTROS | TOTAL ACUMULADO: 60 REGISTROS
-- PROXIMOS LOTES SOMENTE COM NOVA AUTORIZACAO EXPRESSA DO GRUPO.
-- ==========================================================================


-- ==========================================================================
-- BAR DO PEIXE | LOTE 05: MAIS 15 REGISTROS FICTICIOS
-- ACUMULADO: 15 + 15 + 15 + 15 + 15 = 75 REGISTROS
-- ==========================================================================
-- Referencia: Entrega 2, secoes 1.1 e 4.
-- O lote amplia o cardapio para 20 dos aproximadamente 25 produtos e
-- acrescenta insumos para preparo. Inicia um exemplo de atendimento realista:
-- comanda aberta, pedido de cozinha e respectivo item.
-- DISTRIBUICAO: 5 PRODUTO + 3 INSUMOS + 4 FICHA_TECNICA + 1 COMANDA
--              + 1 PEDIDO + 1 ITEM_PEDIDO = EXATAMENTE 15 registros.
-- PRE-REQUISITO: lotes 01 a 04 inseridos uma unica vez, sem outras insercoes
-- que modifiquem os identificadores AUTO_INCREMENT esperados.
-- Todos os nomes, precos, estoques, datas e situacoes sao ficticios.
-- Nao sao criadas tabelas nem alteradas regras, views ou triggers existentes.
-- ========================================================================== 

USE Bar_do_Peixe;
START TRANSACTION;

-- --------------------------------------------------------------------------
-- BLOCO 19 - PRODUTO | +5 registros | RF03 / RN03
-- Amplia o cardapio com novas opcoes de comida e bebida; valores ilustrativos.
-- No banco inicialmente vazio, esses produtos recebem IDs 16 a 20.
-- --------------------------------------------------------------------------
INSERT INTO Produto (NM_Produto, TP_Categoria, VL_Preco, ST_Produto) VALUES
('Suco de maracuja 300 ml', 'Bebida', 8.50, 'Ativo'),
('Tapioca de queijo', 'Alimento', 16.00, 'Ativo'),
('Ovos mexidos com pao', 'Alimento', 15.00, 'Ativo'),
('Arroz temperado', 'Alimento', 12.00, 'Ativo'),
('Agua com gas 500 ml', 'Bebida', 5.00, 'Ativo');

-- --------------------------------------------------------------------------
-- BLOCO 20 - INSUMOS | +3 registros | RF04 / RF06 / RN06
-- Materias-primas de produtos recem-cadastrados. Os saldos representam um
-- estoque inicial ficticio, nao movimentacoes ocorridas neste lote.
-- A polpa de maracuja esta no limite minimo, permitindo verificar o alerta.
-- Os IDs esperados em banco vazio e sequencial sao 9, 10 e 11.
-- --------------------------------------------------------------------------
INSERT INTO Insumos (NM_Insumo, UN_Medida, QT_Estoque, QT_Minima) VALUES
('Polpa de maracuja', 'kg', 2.000, 2.000),
('Queijo mussarela', 'kg', 5.000, 2.000),
('Ovos', 'un', 36.000, 12.000);

-- --------------------------------------------------------------------------
-- BLOCO 21 - FICHA_TECNICA | +4 registros | RF04
-- Composicao dos produtos em unidades compativeis com cada insumo:
-- produto 16 (suco) -> insumo 9 (polpa), 0,120 kg;
-- produto 17 (tapioca) -> insumo 10 (queijo), 0,080 kg;
-- produto 18 (ovos mexidos) -> insumo 11 (ovos), 2 unidades;
-- produto 19 (arroz temperado) -> insumo 2 (arroz), 0,120 kg.
-- A ficha tecnica NAO altera QT_Estoque; a baixa ocorre em movimentacoes.
-- --------------------------------------------------------------------------
INSERT INTO Ficha_Tecnica (ID_Produto, ID_Insumos, QT_Consumida) VALUES
(16, 9, 0.120),
(17, 10, 0.080),
(18, 11, 2.000),
(19, 2, 0.120);

-- --------------------------------------------------------------------------
-- BLOCO 22 - COMANDA | +1 registro | P3 / RN01 / RF07
-- Abre comanda para a mesa 1, cadastrada no Lote 01.
-- 'Aberta' nao aciona a regra de encerramento RN07.
-- No banco vazio e sequencial, a nova comanda recebe ID_Comanda = 1.
-- --------------------------------------------------------------------------
INSERT INTO Comanda (ST_Comanda, DT_Abertura, id_Mesa) VALUES
('Aberta', '2026-11-09 12:10:00', 1);

-- --------------------------------------------------------------------------
-- BLOCO 23 - PEDIDO | +1 registro | P1 / RF01 / RF02 / RN10
-- Pedido de cozinha registrado pelo atendente ID 2 na comanda ID 1.
-- O trigger RN10 autoriza a operacao porque a comanda esta aberta.
-- 'Pendente' permite que a view VW_Fila_Cozinha exiba este pedido.
-- --------------------------------------------------------------------------
INSERT INTO Pedido (id_Funcionario, DT_Hora_Pedido, ST_Pedido, TP_Setor, id_Comanda) VALUES
(2, '2026-11-09 12:12:00', 'Pendente', 'Cozinha', 1);

-- --------------------------------------------------------------------------
-- BLOCO 24 - ITEM_PEDIDO | +1 registro | RF01 / RN01
-- Vincula uma tapioca (Produto ID 17) ao Pedido ID 1.
-- VL_Unitario registra o preco ficticio praticado no momento do pedido;
-- VL_Total e calculado em consultas (QT_Item * VL_Unitario), conforme 3FN.
-- Nao adiciona pagamento nem encerra a comanda neste lote.
-- --------------------------------------------------------------------------
INSERT INTO Item_Pedido (id_Pedido, id_Produto, QT_Item, VL_Unitario) VALUES
(1, 17, 1, 16.00);

COMMIT;

-- --------------------------------------------------------------------------
-- CONFERENCIA CONSOLIDADA APOS OS LOTES 01 A 05 (SOMENTE LEITURA)
-- Esperado em banco originalmente vazio, sem insercoes externas:
-- 10 funcionarios + 20 mesas + 20 produtos + 11 insumos + 2 fornecedores
-- + 9 fichas tecnicas + 1 comanda + 1 pedido + 1 item de pedido = 75.
-- --------------------------------------------------------------------------
SELECT 'Funcionario' AS Tabela, COUNT(*) AS Registros FROM Funcionario
UNION ALL SELECT 'Mesa', COUNT(*) FROM Mesa
UNION ALL SELECT 'Produto', COUNT(*) FROM Produto
UNION ALL SELECT 'Insumos', COUNT(*) FROM Insumos
UNION ALL SELECT 'Fornecedor', COUNT(*) FROM Fornecedor
UNION ALL SELECT 'Ficha_Tecnica', COUNT(*) FROM Ficha_Tecnica
UNION ALL SELECT 'Comanda', COUNT(*) FROM Comanda
UNION ALL SELECT 'Pedido', COUNT(*) FROM Pedido
UNION ALL SELECT 'Item_Pedido', COUNT(*) FROM Item_Pedido;

-- RN02: o pedido 1 deve aparecer na fila da cozinha.
SELECT * FROM vw_fila_cozinha;
-- RN06: a polpa de maracuja deve aparecer como estoque no minimo.
SELECT * FROM vw_alerta_estoque;

-- ==========================================================================
-- FIM DO LOTE 05: 15 NOVOS REGISTROS | TOTAL ACUMULADO: 75
-- NOVO LOTE DEPENDE DE AUTORIZACAO EXPRESSA DO GRUPO.
-- ==========================================================================

-- ==========================================================================
-- BAR DO PEIXE | LOTE 06: MAIS 15 REGISTROS FICTICIOS
-- ACUMULADO: 6 LOTES X 15 REGISTROS = 90 REGISTROS
-- ==========================================================================
-- Referencia: Entrega 2, secoes 1.1 e 4 (volume coerente e casos variados).
-- Este lote completa 25 produtos ficticios no cardapio e acrescenta:
-- duas fichas tecnicas, duas comandas, dois pedidos, dois itens de pedido,
-- um pagamento parcial e uma movimentacao de entrada de estoque.
-- DISTRIBUICAO: 5 PRODUTO + 2 FICHA_TECNICA + 2 COMANDA + 2 PEDIDO
--             + 2 ITEM_PEDIDO + 1 PAGAMENTO + 1 CONTROLE_INSUMOS = 15.
-- PRE-REQUISITO: lotes 01 a 05 inseridos, na ordem, uma unica vez em banco
-- originalmente vazio; FKs abaixo presumem AUTO_INCREMENT sequencial.
-- IMPORTANTE: executar este lote apenas uma vez. Para importar o arquivo
-- consolidado inteiro, usar banco com a estrutura criada e sem dados.
-- Os valores, nomes, datas e situacoes sao exclusivamente ficticios.
-- Nenhuma coluna, tabela, chave, view ou trigger e alterado neste lote.
-- ==========================================================================

USE Bar_do_Peixe;
START TRANSACTION;

-- --------------------------------------------------------------------------
-- BLOCO 25 - PRODUTO | +5 registros | RF03 / RN03
-- Completa os 25 itens ficticios, entre refeicoes, doces e bebidas.
-- Esperam-se IDs 21 a 25 em banco inicialmente vazio e sequencial.
-- --------------------------------------------------------------------------
INSERT INTO Produto (NM_Produto, TP_Categoria, VL_Preco, ST_Produto) VALUES
('Caldo de peixe', 'Alimento', 18.00, 'Ativo'),
('Porcao de frango grelhado', 'Alimento', 24.00, 'Ativo'),
('Agua de coco 300 ml', 'Bebida', 7.00, 'Ativo'),
('Bolo de cenoura', 'Alimento', 8.50, 'Ativo'),
('Cafe com leite', 'Bebida', 6.00, 'Ativo');

-- --------------------------------------------------------------------------
-- BLOCO 26 - FICHA_TECNICA | +2 registros | RF04
-- Produto 21 consome 0,180 kg do insumo 1 (file de peixe).
-- Produto 22 consome 0,220 kg do insumo 4 (file de frango).
-- Vinculos de composicao NAO fazem baixa automatica de estoque.
-- --------------------------------------------------------------------------
INSERT INTO Ficha_Tecnica (ID_Produto, ID_Insumos, QT_Consumida) VALUES
(21, 1, 0.180),
(22, 4, 0.220);

-- --------------------------------------------------------------------------
-- BLOCO 27 - COMANDA | +2 registros | P3 / RN01 / RF07
-- Comandas abertas para as mesas 2 e 3 (ja cadastradas).
-- IDs esperados das comandas: 2 e 3. Ambas seguem abertas neste lote.
-- --------------------------------------------------------------------------
INSERT INTO Comanda (ST_Comanda, DT_Abertura, id_Mesa) VALUES
('Aberta', '2026-11-07 13:05:00', 2),
('Aberta', '2026-11-09 18:30:00', 3);

-- --------------------------------------------------------------------------
-- BLOCO 28 - PEDIDO | +2 registros | P1 / RN08 / RN10
-- Pedido 2: cancelado, mas preservado no historico (comanda 2).
-- Pedido 3: pendente, destinado a cozinha (comanda 3).
-- Ambos sao vinculados a comandas abertas, respeitando trigger RN10.
-- Funcionarios 2 e 5 foram cadastrados em lotes anteriores.
-- --------------------------------------------------------------------------
INSERT INTO Pedido (id_Funcionario, DT_Hora_Pedido, ST_Pedido, TP_Setor, id_Comanda) VALUES
(2, '2026-11-07 13:07:00', 'Cancelado', 'Cozinha', 2),
(5, '2026-11-09 18:35:00', 'Pendente', 'Cozinha', 3);

-- --------------------------------------------------------------------------
-- BLOCO 29 - ITEM_PEDIDO | +2 registros | RF01 / RN01
-- Pedido 2: um caldo de peixe cancelado (nao conta para faturamento).
-- Pedido 3: uma porcao de frango grelhado, valor de R$ 24,00.
-- Valores totais nao sao armazenados; calculam-se em consultas.
-- --------------------------------------------------------------------------
INSERT INTO Item_Pedido (id_Pedido, id_Produto, QT_Item, VL_Unitario) VALUES
(2, 21, 1, 18.00),
(3, 22, 1, 24.00);

-- --------------------------------------------------------------------------
-- BLOCO 30 - PAGAMENTO | +1 registro | P3 / RN07
-- Registra recebimento parcial de R$ 10,00 na comanda 3, cujo pedido
-- valido soma R$ 24,00. A comanda permanece aberta: o trigger RN07 deve
-- impedir seu encerramento enquanto houver saldo nao coberto.
-- A existencia da linha nao equivale a confirmacao bancaria externa.
-- --------------------------------------------------------------------------
INSERT INTO Pagamento (id_Comanda, DT_Pagamento, TP_Pagamento, VL_Pagamento) VALUES
(3, '2026-11-09 18:42:00', 'Pix', 10.00);

-- --------------------------------------------------------------------------
-- BLOCO 31 - CONTROLE_INSUMOS | +1 registro | P2 / RF04 / RN04
-- Entrada de 3 unidades de refrigerante (insumo 3), cadastrado com saldo
-- inicial 5 e minimo 12. O trigger de estoque eleva o saldo para 8:
-- continua abaixo do minimo, mantendo um exemplo para VW_Alerta_Estoque.
-- Nao executar separadamente mais de uma vez: a entrada soma ao estoque.
-- --------------------------------------------------------------------------
INSERT INTO Controle_Insumos
    (id_Insumos, DT_Movimentacao, TP_Movimentacao, QT_Movimentacao)
VALUES
    (3, '2026-11-09 08:00:00', 'Entrada', 3.000);

COMMIT;

-- --------------------------------------------------------------------------
-- CONFERENCIA ACUMULADA DOS LOTES 01 A 06 (SOMENTE LEITURA)
-- Esperado em banco originalmente vazio, sem insercoes externas:
-- 10 funcionarios + 20 mesas + 25 produtos + 11 insumos + 2 fornecedores
-- + 11 fichas tecnicas + 3 comandas + 3 pedidos + 3 itens de pedido
-- + 1 pagamento + 1 movimentacao = 90 registros.
-- --------------------------------------------------------------------------
SELECT 'Funcionario' AS Tabela, COUNT(*) AS Registros FROM Funcionario
UNION ALL SELECT 'Mesa', COUNT(*) FROM Mesa
UNION ALL SELECT 'Produto', COUNT(*) FROM Produto
UNION ALL SELECT 'Insumos', COUNT(*) FROM Insumos
UNION ALL SELECT 'Fornecedor', COUNT(*) FROM Fornecedor
UNION ALL SELECT 'Ficha_Tecnica', COUNT(*) FROM Ficha_Tecnica
UNION ALL SELECT 'Comanda', COUNT(*) FROM Comanda
UNION ALL SELECT 'Pedido', COUNT(*) FROM Pedido
UNION ALL SELECT 'Item_Pedido', COUNT(*) FROM Item_Pedido
UNION ALL SELECT 'Pagamento', COUNT(*) FROM Pagamento
UNION ALL SELECT 'Controle_Insumos', COUNT(*) FROM Controle_Insumos;

-- RN08: o pedido 2 deve existir no historico com status 'Cancelado'.
SELECT ID_Pedido, ST_Pedido, id_Comanda FROM Pedido WHERE ID_Pedido = 2;
-- RN02: o pedido 3 deve aparecer, e o pedido 2 cancelado nao deve aparecer.
SELECT * FROM vw_fila_cozinha;
-- RN06: o insumo 3 deve continuar abaixo do estoque minimo apos a entrada.
SELECT * FROM vw_alerta_estoque WHERE ID_Insumos = 3;
-- RN07: evidencia de pagamento parcial, sem encerrar a comanda.
SELECT c.ID_Comanda, c.ST_Comanda,
       COALESCE(SUM(pg.VL_Pagamento), 0) AS Total_Pago
FROM Comanda c
LEFT JOIN Pagamento pg ON pg.id_Comanda = c.ID_Comanda
WHERE c.ID_Comanda = 3
GROUP BY c.ID_Comanda, c.ST_Comanda;

-- ==========================================================================
-- FIM DO LOTE 06: 15 NOVOS REGISTROS | TOTAL ACUMULADO: 90 REGISTROS
-- PROXIMO LOTE SOMENTE COM AUTORIZACAO EXPRESSA DO GRUPO.
-- ==========================================================================


-- ==========================================================================
-- BAR DO PEIXE | LOTE 07: MAIS 15 REGISTROS FICTICIOS
-- ACUMULADO: 7 LOTES X 15 REGISTROS = 105 REGISTROS
-- ==========================================================================
-- Referencia: Entrega 2, secoes 1.1 e 4 (operacoes e volumes realistas).
-- Este lote desenvolve os processos de compras, atendimento, recebimento,
-- pagamentos e estoque. As transacoes comerciais e datas sao ficticias.
-- DISTRIBUICAO: 2 COMPRA + 3 ITEM_COMPRA + 2 PAGAMENTO + 1 COMANDA
--             + 1 PEDIDO + 2 ITEM_PEDIDO + 1 FICHA_TECNICA
--             + 3 CONTROLE_INSUMOS = EXATAMENTE 15 novos registros.
-- PRE-REQUISITO: lotes 01 a 06 executados, em ordem, apenas uma vez em um
-- banco inicialmente vazio; IDs abaixo dependem dessa ordem de importacao.
-- NAO executar o arquivo consolidado inteiro sobre um banco que ja recebeu
-- lotes anteriores. Para esse caso, executar SOMENTE os INSERTs deste lote.
-- Nao cria/altera tabelas, chaves, views, triggers ou regras de negocio.
-- ==========================================================================

USE Bar_do_Peixe;
START TRANSACTION;

-- --------------------------------------------------------------------------
-- BLOCO 32 - COMPRA | +2 registros | P4
-- Cadastra duas compras simuladas de fornecedores ja existentes (IDs 1 e 2).
-- NR_Nota_Fiscal sao identificadores internos ficticios, NAO notas reais.
-- IDs esperados das compras: 1 e 2 (banco inicialmente vazio).
-- --------------------------------------------------------------------------
INSERT INTO Compra (id_Fornecedor, DT_Compra, NR_Nota_Fiscal) VALUES
(1, '2026-11-06 09:00:00', 'NF-FICT-2026-0001'),
(2, '2026-11-08 10:30:00', 'NF-FICT-2026-0002');

-- --------------------------------------------------------------------------
-- BLOCO 33 - ITEM_COMPRA | +3 registros | P4 / RF04
-- Detalha os insumos de cada compra com quantidade e valor historico.
-- Compra 1: 2 kg de file de peixe (insumo 1) e 3 kg de arroz (insumo 2).
-- Compra 2: 4 kg de batata para fritura (insumo 5).
-- O total monetario sera calculado por QT_Comprada * VL_Unitario; a insercao
-- de ITEM_COMPRA nao altera automaticamente o saldo fisico dos insumos.
-- --------------------------------------------------------------------------
INSERT INTO Item_Compra (id_Insumos, id_Compra, QT_Comprada, VL_Unitario) VALUES
(1, 1, 2.000, 32.00),
(2, 1, 3.000, 7.50),
(5, 2, 4.000, 8.00);

-- --------------------------------------------------------------------------
-- BLOCO 34 - PAGAMENTO | +2 registros | P3 / RF07 / RN07
-- Comanda 1: quita a tapioca de R$ 16,00 do pedido 1 (dinheiro).
-- Comanda 3: completa os R$ 24,00 do pedido 3 (R$ 10,00 de Pix no Lote 06
--             + R$ 14,00 em cartao de debito neste lote).
-- As comandas permanecem com status 'Aberta'; este lote nao as encerra.
-- Os pagamentos nao representam conciliacao bancaria comprovada.
-- --------------------------------------------------------------------------
INSERT INTO Pagamento (id_Comanda, DT_Pagamento, TP_Pagamento, VL_Pagamento) VALUES
(1, '2026-11-09 12:45:00', 'Dinheiro', 16.00),
(3, '2026-11-09 18:49:00', 'Debito', 14.00);

-- --------------------------------------------------------------------------
-- BLOCO 35 - COMANDA | +1 registro | P3 / RN01
-- Abre comanda 4 para a mesa 4, que ja esta cadastrada.
-- 'Aberta' permite receber pedidos conforme RN10.
-- --------------------------------------------------------------------------
INSERT INTO Comanda (ST_Comanda, DT_Abertura, id_Mesa) VALUES
('Aberta', '2026-11-08 12:00:00', 4);

-- --------------------------------------------------------------------------
-- BLOCO 36 - PEDIDO | +1 registro | P1 / RN01 / RN02 / RN10
-- Pedido 4: funcionario 7 registra dois alimentos da comanda 4.
-- Setor 'Cozinha' torna este pedido elegivel para a view de preparacao.
-- O trigger de comanda permite o INSERT porque ela permanece aberta.
-- --------------------------------------------------------------------------
INSERT INTO Pedido (id_Funcionario, DT_Hora_Pedido, ST_Pedido, TP_Setor, id_Comanda) VALUES
(7, '2026-11-08 12:03:00', 'Pendente', 'Cozinha', 4);

-- --------------------------------------------------------------------------
-- BLOCO 37 - ITEM_PEDIDO | +2 registros | P1 / RF01
-- Pedido 4 possui: 1 prato feito de peixe (produto 1) e 1 porcao de batata
-- (produto 3). Total apuravel: 1 x 29,90 + 1 x 22,00 = R$ 51,90.
-- Como a comanda 4 nao tem pagamento, devera continuar aberta (RN07).
-- --------------------------------------------------------------------------
INSERT INTO Item_Pedido (id_Pedido, id_Produto, QT_Item, VL_Unitario) VALUES
(4, 1, 1, 29.90),
(4, 3, 1, 22.00);

-- --------------------------------------------------------------------------
-- BLOCO 38 - FICHA_TECNICA | +1 registro | RF04 / RN04
-- Vincula agua mineral 500 ml (produto 7) a uma unidade de agua em estoque
-- (insumo 6). Esta associacao nao movimenta QT_Estoque por si so.
-- --------------------------------------------------------------------------
INSERT INTO Ficha_Tecnica (ID_Produto, ID_Insumos, QT_Consumida) VALUES
(7, 6, 1.000);

-- --------------------------------------------------------------------------
-- BLOCO 39 - CONTROLE_INSUMOS | +3 registros | P2 / RF04 / RN04 / RN06
-- Lanca os recebimentos fisicos correspondentes a dois itens de compra:
--   Entrada de 2 kg de peixe: saldo de 8 para 10 kg (insumo 1).
--   Entrada de 3 kg de arroz: saldo de 12 para 15 kg (insumo 2).
-- E uma saida simulada por consumo de 0,500 kg de batata (insumo 5),
-- diminuindo seu saldo de 10 para 9,500 kg.
-- A compra de batata existe, mas o recebimento fisico correspondente nao
-- e registrado neste lote; compra e recebimento sao etapas separadas.
-- Os triggers validam o tipo, registram o historico e ajustam os saldos.
-- --------------------------------------------------------------------------
INSERT INTO Controle_Insumos
    (id_Insumos, DT_Movimentacao, TP_Movimentacao, QT_Movimentacao)
VALUES
    (1, '2026-11-06 10:00:00', 'Entrada', 2.000),
    (2, '2026-11-06 10:05:00', 'Entrada', 3.000),
    (5, '2026-11-08 13:00:00', 'Saida', 0.500);

COMMIT;

-- --------------------------------------------------------------------------
-- CONFERENCIA ACUMULADA DOS LOTES 01 A 07 (SOMENTE LEITURA)
-- Esperado em banco originalmente vazio, sem operacoes externas:
-- 10 funcionarios + 20 mesas + 25 produtos + 11 insumos + 2 fornecedores
-- + 12 fichas tecnicas + 4 comandas + 4 pedidos + 5 itens de pedido
-- + 3 pagamentos + 4 movimentacoes + 2 compras + 3 itens de compra
-- = 105 registros, distribuidos nas 13 tabelas.
-- --------------------------------------------------------------------------
SELECT 'Funcionario' AS Tabela, COUNT(*) AS Registros FROM Funcionario
UNION ALL SELECT 'Mesa', COUNT(*) FROM Mesa
UNION ALL SELECT 'Produto', COUNT(*) FROM Produto
UNION ALL SELECT 'Insumos', COUNT(*) FROM Insumos
UNION ALL SELECT 'Fornecedor', COUNT(*) FROM Fornecedor
UNION ALL SELECT 'Ficha_Tecnica', COUNT(*) FROM Ficha_Tecnica
UNION ALL SELECT 'Comanda', COUNT(*) FROM Comanda
UNION ALL SELECT 'Pedido', COUNT(*) FROM Pedido
UNION ALL SELECT 'Item_Pedido', COUNT(*) FROM Item_Pedido
UNION ALL SELECT 'Pagamento', COUNT(*) FROM Pagamento
UNION ALL SELECT 'Controle_Insumos', COUNT(*) FROM Controle_Insumos
UNION ALL SELECT 'Compra', COUNT(*) FROM Compra
UNION ALL SELECT 'Item_Compra', COUNT(*) FROM Item_Compra;

-- Confere a totalizacao dos tres itens de compras ficticias (P4).
SELECT c.ID_Compra, SUM(ic.QT_Comprada * ic.VL_Unitario) AS VL_Total_Compra
FROM Compra c JOIN Item_Compra ic ON ic.id_Compra = c.ID_Compra
GROUP BY c.ID_Compra ORDER BY c.ID_Compra;

-- Confere quantidade, preco e valor calculado dos itens do Pedido 4 (RF01).
SELECT ip.id_Pedido, SUM(ip.QT_Item * ip.VL_Unitario) AS VL_Total_Pedido
FROM Item_Pedido ip WHERE ip.id_Pedido = 4 GROUP BY ip.id_Pedido;

-- RN06: alerta para insumos com estoque no limite ou abaixo do minimo.
SELECT * FROM vw_alerta_estoque;

-- RN07: total de pagamentos registrados por comanda (nao encerra contas).
SELECT id_Comanda, SUM(VL_Pagamento) AS Total_Pago
FROM Pagamento GROUP BY id_Comanda ORDER BY id_Comanda;

-- ==========================================================================
-- FIM DO LOTE 07: 15 NOVOS REGISTROS | TOTAL ACUMULADO: 105
-- PROXIMO LOTE SOMENTE COM AUTORIZACAO EXPRESSA DO GRUPO.
-- ==========================================================================


-- ==========================================================================
-- BAR DO PEIXE | LOTE 08: PRIMEIRA AMOSTRA OPERACIONAL PARA DASHBOARD
-- 10 NOVOS REGISTROS | ACUMULADO: 115 REGISTROS (105 + 10)
-- ==========================================================================
-- Referencia: Entrega 2, secoes 1.1, 3 e 4.
-- Meta de representatividade: simular gradualmente atendimentos em diferentes
-- dias e horarios, tomando os ~75 clientes/dia apenas como referencia de porte.
-- NAO ha cadastro de clientes no modelo aprovado: pedidos sao por comanda/mesa.
-- Distribuicao: 2 COMANDA + 2 PEDIDO + 4 ITEM_PEDIDO + 2 PAGAMENTO = 10.
-- Os dados de outubro/novembro, os valores e os processos sao FICTICIOS.
-- Este lote nao cria ou altera tabelas, colunas, views, triggers ou FKs.
-- Depende dos lotes 01 a 07 executados UMA VEZ, na ordem, em banco vazio.
-- Os IDs de comanda e pedido pressupõem AUTO_INCREMENT sequencial, sem outras
-- insercoes nesses cadastros. Nao reexecutar este lote: evita duplicacoes.
-- UMA COMANDA ENCERRADA = estado alterado por UPDATE; nao conta como INSERT.
-- ========================================================================== 

USE Bar_do_Peixe;
START TRANSACTION;

-- --------------------------------------------------------------------------
-- BLOCO 40 - COMANDA | +2 registros | P3 / RN01 / RF07
-- C5: mesa 5, atendimento de outubro para comparativo mensal.
-- C6: mesa 6, atendimento de novembro, usado para conta pendente.
-- As mesas 5 e 6 ja existem e possuem capacidades adequadas.
-- --------------------------------------------------------------------------
INSERT INTO Comanda (ST_Comanda, DT_Abertura, id_Mesa) VALUES
('Aberta', '2026-10-27 12:00:00', 5),
('Aberta', '2026-11-05 15:10:00', 6);

-- --------------------------------------------------------------------------
-- BLOCO 41 - PEDIDO | +2 registros | P1 / RN01 / RN03 / RF01 / RF03
-- P5: cozinha, concluido, contabilizavel no faturamento de outubro.
-- P6: bebidas, pendente, demonstra a separacao operacional por setor.
-- Vinculos: pedido 5 -> comanda 5; pedido 6 -> comanda 6.
-- --------------------------------------------------------------------------
INSERT INTO Pedido (id_Funcionario, DT_Hora_Pedido, ST_Pedido, TP_Setor, id_Comanda) VALUES
(2, '2026-10-27 12:04:00', 'Concluido', 'Cozinha', 5),
(5, '2026-11-05 15:13:00', 'Pendente', 'Bebidas', 6);

-- --------------------------------------------------------------------------
-- BLOCO 42 - ITEM_PEDIDO | +4 registros | P1 / RF01 / RN03
-- Pedido 5: peixe R$ 29,90 + batata R$ 22,00 = R$ 51,90.
-- Pedido 6: refrigerante R$ 6,50 + agua mineral R$ 4,50 = R$ 11,00.
-- VL_Unitario conserva o preco historico; o total e derivado por SELECT.
-- Produtos/valores usam os cadastros anteriores; nao ha preco inventado aqui.
-- --------------------------------------------------------------------------
INSERT INTO Item_Pedido (id_Pedido, id_Produto, QT_Item, VL_Unitario) VALUES
(5, 1, 1, 29.90),
(5, 3, 1, 22.00),
(6, 2, 1, 6.50),
(6, 7, 1, 4.50);

-- --------------------------------------------------------------------------
-- BLOCO 43 - PAGAMENTO | +2 registros | P3 / RF07 / RN07
-- Recebimento da comanda 5 dividido entre Pix (30,00) e dinheiro (21,90).
-- Total recebido = R$ 51,90, exatamente igual ao consumo valido de P5.
-- Comanda 6 nao possui pagamento e permanece aberta (conta pendente).
-- --------------------------------------------------------------------------
INSERT INTO Pagamento (id_Comanda, DT_Pagamento, TP_Pagamento, VL_Pagamento) VALUES
(5, '2026-10-27 12:45:00', 'Pix', 30.00),
(5, '2026-10-27 12:46:00', 'Dinheiro', 21.90);

-- --------------------------------------------------------------------------
-- BLOCO 44 - ATUALIZACAO DE ESTADO | 0 NOVOS REGISTROS | RN07 / RN10
-- Valida um fechamento bem-sucedido: o trigger RN07 confere o consumo
-- e os pagamentos antes de aceitar 'Encerrada'. Preserva o historico.
-- A comanda 6 continua 'Aberta', demonstrando pendencia financeira.
-- --------------------------------------------------------------------------
UPDATE Comanda SET ST_Comanda = 'Encerrada'
WHERE ID_Comanda = 5 AND ST_Comanda = 'Aberta';

COMMIT;

-- --------------------------------------------------------------------------
-- CONFERENCIA DO LOTE 08 (SOMENTE LEITURA)
-- Esperado em banco vazio antes dos lotes 01 a 07: 115 linhas no total.
-- A soma abaixo retorna uma linha com o total em 13 tabelas.
-- --------------------------------------------------------------------------
SELECT
 (SELECT COUNT(*) FROM Funcionario) +
 (SELECT COUNT(*) FROM Mesa) +
 (SELECT COUNT(*) FROM Produto) +
 (SELECT COUNT(*) FROM Insumos) +
 (SELECT COUNT(*) FROM Fornecedor) +
 (SELECT COUNT(*) FROM Ficha_Tecnica) +
 (SELECT COUNT(*) FROM Comanda) +
 (SELECT COUNT(*) FROM Pedido) +
 (SELECT COUNT(*) FROM Item_Pedido) +
 (SELECT COUNT(*) FROM Pagamento) +
 (SELECT COUNT(*) FROM Controle_Insumos) +
 (SELECT COUNT(*) FROM Compra) +
 (SELECT COUNT(*) FROM Item_Compra) AS Total_Registros;

-- G01 (exemplo de indicador): arrecadacao por mes de pagamento.
-- 'Atende' P3 / RF07: evidencia diferentes periodos e recebimentos.
SELECT DATE_FORMAT(DT_Pagamento,'%Y-%m') AS Mes,
       SUM(VL_Pagamento) AS Total_Recebido
FROM Pagamento
GROUP BY DATE_FORMAT(DT_Pagamento,'%Y-%m')
ORDER BY Mes;

-- A01 (exemplo de auditoria): comanda aberta com consumo nao quitado.
-- 'Verifica' P3 / RN07: a comanda 6 deve aparecer, entre outras abertas.
-- Usa somente pedidos nao cancelados; evita multiplicar itens por pagamentos.
SELECT c.ID_Comanda, c.ST_Comanda,
       COALESCE((SELECT SUM(ip.QT_Item*ip.VL_Unitario)
                 FROM Pedido p JOIN Item_Pedido ip ON ip.id_Pedido=p.ID_Pedido
                 WHERE p.id_Comanda=c.ID_Comanda
                   AND LOWER(TRIM(p.ST_Pedido)) <> 'cancelado'),0) AS Total_Consumo,
       COALESCE((SELECT SUM(pg.VL_Pagamento)
                 FROM Pagamento pg WHERE pg.id_Comanda=c.ID_Comanda),0) AS Total_Pago
FROM Comanda c
WHERE c.ST_Comanda='Aberta'
HAVING Total_Consumo > Total_Pago;

-- FIM DO LOTE 08: 10 INSERCOES | ACUMULADO: 115 | PARAR AQUI.
-- PROXIMOS 10 REGISTROS SOMENTE COM AUTORIZACAO EXPRESSA DO GRUPO.
