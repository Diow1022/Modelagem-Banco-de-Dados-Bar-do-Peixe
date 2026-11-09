# Bar do Peixe — Entrega 2: Modelo Lógico, Implementação SQL e Apresentação Final

### Integrantes

| Nome completo do aluno | RGM | Usuário do GitHub |
| :---- | :---- | :---- |
| Christian Badolato Santos | 47224011 | christianbadolato | 
| Davi Barros Correia | 47204885 | DaviBarrosDev |
| Guilherme Pereira Ferreira da Silva | 47228903 | GuilhermePFS |
| Jonatas do Nascimento Lima | 46929720 | Diow1022 |

## 1.1 Revisão do Modelo Conceitual

### Caracterização da organização

- **Nome e natureza:** Bar do Peixe, bar/restaurante, mesma organização da Entrega 1.
- **Contexto e porte:** organização com fins lucrativos e operação de pequeno porte, com 10 pessoas
  envolvidas (funcionários CLT, gerente e dono). Funciona de segunda a sábado e em feriados,
  das 6h00 às 21h30. Cardápio com PF, prato do dia, lanches, doces e bebidas.
  Volume de operação: 20 mesas; cardápio com 25 itens (bebidas e alimentos); 75 clientes por dia.
- **Problemas e necessidades identificados:**
  - **P1** — Pedidos anotados em papel e repassados à cozinha sem registro, o que torna o atendimento lento e sem histórico.
  - **P2** — Controle de insumos feito "a olho": reposição só é pedida quando o item está acabando, sem saldo nem estoque mínimo registrados.
  - **P3** — Consumo anotado numa única comanda ou só de boca, o que permite clientes saírem sem pagar o que consumiram.
  - **P4** — Compras feitas por celular ou avulsas, sem cadastro de fornecedores e sem registro de itens, valores e notas fiscais.
- **Escopo do sistema:** o banco cobre todo o ciclo da organização: funcionários, mesas, comandas,
  pedidos e itens, produtos do cardápio, pagamentos, fornecedores, compras, insumos e movimentações de insumos.
  
- **Justificativa da escolha:** contato acessível com o dono, porte adequado (nem muito pequeno nem grande)
  e ausência de qualquer banco de dados na organização.
- **Evidências da organização:**
  - Endereço: Av. Celso Garcia, 5292 — Tatuapé, São Paulo/SP, CEP 03064-000
  - Telefone: (11) 2098-3262
  - Instagram: https://www.instagram.com/bardopeixeofficial
  - Google Meu Negócio: https://maps.app.goo.gl/7zCdZ3GKtsPwUSph9
  - Fotos do local: pasta de fotos `Fotos Projeto Bar do Peixe/Fachada.png`, `Fotos Projeto Bar do Peixe/Fachada 2.png` .
- **Responsável pela organização:** Françoal, telefone: 11 96524-2018.
- **Vínculo com o bar:** nenhum dos integrantes possui vínculo.
  
---

### Relato da entrevista

- **Quem:** Françoal, Dono. Integrantes presentes: Christian Badolato Santos, Davi Barros Correia, Jonatas do Nascimento Lima.
- **Quando e onde:** 4 de setembro 2026, no Bar do Peixe, Av. Celso Garcia, 5292 — Tatuapé, São Paulo/SP.
- **Comprovação:** Foto da entrevista `Fotos Projeto Bar do Peixe/Foto em Grupo.png`.

**Achados obtidos pela observação presencial**
- Pedido anotado em papel e entregue ao cozinheiro.
- Estoque conferido "a olho", sem planilha ou caderno.
- Consumo da mesa anotado em uma única comanda de papel.

**Achados obtidos pelas respostas do entrevistado**
- Compras com fornecedores são feitas por celular; parte da mercadoria é comprada avulsa
  (supermercado, padaria) quando acaba; o dono confere o recebimento; não há cadastro de fornecedores.
- Despesas principais: funcionários CLT, água, luz, internet, gás e fornecedores.
- A baixa média de insumos é de uma unidade por prato (carnes, frango, bebidas e lanches),
  além de porções de arroz, salada e outros acompanhamentos.
- A conferência de validade é feita semanalmente pelo dono.
- Cancelamentos são comunicados informalmente entre funcionários.
- Funcionamento: segunda a sábado e feriados, das 6h00 às 21h30.

**O que mudou em relação à Entrega 1**

Em 27 de outubro, o grupo contatou o dono e confirmou:
- **Fechamento de caixa:** Ocorre 2 fechamentos por dia, um no período da tarde e o outro da noite, um fechamento no final da semana e outro no fim do mês. 
- **Movimento:** cerca de 75 clientes por dia

**Resumo do levantamento:** o levantamento completo está em `levantamento/levantamento.md`.

### 2. Processos de negócios

1. **Atendimento:** Processo de atendimento realizado pelos colaboradores, no qual ele atende o cliente com o objetivo de fazê-lo/ajudar a realizar um pedido. E também contribuem com a organização das mesas e entrega dos pedidos aos clientes.
  
2. **Recebimento de pedidos:** É o processo realizado após o cliente realizar o pedido, atualmente, o pedido é anotado em papel e passado ao cozinheiro, imediatamente, que irá preparar o pedido e devolvê-lo ao atendente, que leverá o pedido pronto ao cliente que estará aguardando.
  
3. **Controle de insumos:** O processo que é realizado para controlar os insumos é feito a "olho", de forma manual, assim que é percebido que determinada mercadoria está acabando é solicitado reposição.
  
4. **Compra com fornecedor/recebimento de mercadoria:** A compra com o fornecedor é feita através do celular com contato direto com o fornecedor, algumas mercadorias são adquiridas de forma avulsa, através de supermercados, padarias e etc. Ao chegar a mercadoria no bar ela é recebida e conferida pelo dono. Não Possui cadastro para fornecedores.
  
5. **Cobrança do pedido:** A cobrança do pedido é feita após o consumo cliente, os pedidos são todos anotados em somente uma "comanda" ou repassados de boca também, o que contribui para que alguns clientes passem despercebido sem efetuar o pagamento dos produtos que consumiu.
  
6. **Cardápio / Preço:** E um cardápio comum com todas as opções que bar oferece, PF(Prato Feito), Prato do dia, Lanches e doces e Bebidas Variadas. Os preços variam conforme o produto desejado, sendo os almoços o mais caros e lanches mais simples e baratos. Bebidas variam de acordo com tipo e os PF são mais baratos.

7. **Fechamento de caixa:** procedimento ainda não confirmado com o proprietário; permanece como levantamento pendente, não como funcionalidade já modelada.   

8. **Contas a Pagar:** Em relação as despesas o proprietário deixa cerca de 80% da renda Bruta no estabelecimento, entre as despesas por alto pelo que nos foi informado são: Funcionários CLT, (água, Luz, Internet), gás e fornecedores (Comidas e Bebidas) "Caso Acabe acaba comprando por fora".

9. **Baixa de Insumos:** A media de baixa e de uma unidade por prato, (carnes, frangos, bebidas e lanches). E porções de arroz, graus e saladas.

## 3. Requisitos do Sistema

**Regras de negócio

-**RN01**	Todo pedido deve estar associado a uma comanda e a uma mesa identificada.	RF01

-**RN02**	Pedidos destinados à cozinha devem aparecer na fila de preparo após o registro.	RF02

-**RN03**	Produtos devem ser classificados como alimentos ou bebidas para direcionamento ao setor responsável.	RF03

-**RN04**	Toda movimentação de estoque deve registrar o produto, a quantidade, a data e o tipo de movimentação.	RF04

-**RN05**	Cada funcionário deve possuir uma função e um turno de trabalho cadastrados.	RF05

-**RN06**	Produtos com estoque igual ou inferior ao mínimo estabelecido devem gerar alertas de reposição.	RF06

-**RN07**	Uma comanda somente pode ser encerrada após a confirmação do pagamento.	RF07

-**RN08**	Pedidos cancelados devem permanecer registrados no histórico do sistema.	RF01, RF07

-**RN09**	Apenas funcionários autorizados podem realizar operações administrativas.	RF05

-**RN10**	Uma comanda encerrada não pode receber novos pedidos.	RF01, RF07

# 1.1 — Revisão do Modelo Conceitual

Comparação objetiva das alterações do **Modelo Conceitual 1** (imagem) para o **Modelo Conceitual 2** (PDF).

**Contagem:** o Modelo 1 possui **7 entidades e 6 relacionamentos**; o Modelo 2 possui **12 entidades e 11 relacionamentos**. Foram acrescentadas cinco entidades: `ITEM_PEDIDO`, `ITEM_COMPRA`, `MESA`, `COMANDA` e `INSUMOS`.

## Quadro 1 — Mudanças estruturais

Tabela no formato de revisão solicitado pelo esqueleto da Entrega 2:

| Aspecto no Modelo 1 | O que mudou no Modelo 2 | Por quê |
| --- | --- | --- |
| PEDIDO ligado diretamente a PRODUTOS por “Inclui”. | Inclusão de ITEM_PEDIDO, com relações PEDIDO–ITEM_PEDIDO e ITEM_PEDIDO–PRODUTO. | Permite discriminar os itens de cada pedido. |
| PEDIDO ligado diretamente a PAGAMENTO por “Gera”. | Inclusão de MESA e COMANDA; PEDIDO pertence à COMANDA e COMANDA possui PAGAMENTO. | Permite reunir pedidos e pagamentos vinculados à comanda de uma mesa. |
| COMPRA ligada diretamente a PRODUTOS por “Contém”. | Inclusão de ITEM_COMPRA e INSUMOS; COMPRA–ITEM_COMPRA–INSUMOS. | Permite detalhar as quantidades e os valores dos insumos comprados. |
| CONTROLE_INSUMOS associado a PRODUTOS, com dados de local. | INSUMOS passa a se relacionar a CONTROLE_INSUMOS por “Movimenta”; dados passam a descrever movimentações. | Separa cadastro de insumos e registro de suas movimentações. |
| PRODUTOS e CONTROLE_INSUMOS sem relação explícita de composição de receitas. | Criado o relacionamento PRODUTO–INSUMOS “Consome”, com QT_Consumida. | Registra a quantidade de insumo consumida por produto. |
| FUNCIONARIO “Faz” PEDIDO. | Relacionamento renomeado para “Realiza” e cardinalidades representadas em lados trocados. | Mudança nominal e da representação da participação. |
| FORNECEDOR “Fornece” COMPRA. | Relacionamento renomeado para “Realiza” e cardinalidades representadas em lados trocados. | Mudança nominal e da representação da participação. |

**Observação:** as razões da terceira coluna são justificativas técnicas decorrentes das mudanças visíveis. Não foram fornecidos os apontamentos de correção da Entrega 1; portanto, esta tabela não os atribui ao professor.

## Quadro 2 — Mudanças de atributos

| Entidade | Alteração observada no Modelo 2 |
| --- | --- |
| FUNCIONARIO | NOME_FUNCIONARIO passa a NM_Funcionario; permanecem identificador, função e turno. |
| PEDIDO | Adicionado ST_Pedido; ID_FUNCIONARIO(FK) deixa de aparecer como atributo; TP_SETOR aparece no PDF como TP_Serto. |
| PRODUTOS → PRODUTO | Adicionados NM_Produto, TP_Categoria, VL_Preco e ST_Produto; QT_Produto deixa de aparecer; TP_PRODUTO é substituído por TP_Categoria. |
| PAGAMENTO | ID_PEDIDO(FK) e IN_CONFIRMADO deixam de aparecer; DT_HORA_PAGAMENTO, TP_FORMA_PAGAMENTO e VALOR_PAGO passam a DT_Pagamento, TP_Pagamento e VL_Pagamento. |
| FORNECEDOR | Adicionados ST_Fornecedor e NR_Telefone; nome e CNPJ usam nomenclatura NM_Fornecedor e NR_CNPJ. |
| COMPRA | ID_FORNECEDOR(FK) deixa de aparecer como atributo; DATA_COMPRA, NF_NOTA_FISCAL e TOTAL_COMPRA passam a DT_Compra, NR_Nota_Fiscal e VL_Compra. |
| CONTROLE_INSUMOS | Deixa de apresentar ID_LOCAL, TP_LOCAL, QT_LOCAL e ID_PRODUTO(FK); passa a ID_Movimentacao, QT_Movimentacao, TP_Movimentacao e DT_Movimentacao. |
| Novas entidades | ITEM_PEDIDO: ID_Item_Pedido, QT_Item, VL_Unitario, VL_Total. MESA: ID_Mesa, NR_Mesa, TP_Situacao, QT_Lugares. COMANDA: ID_Comanda, ST_Comanda, DT_Abertura. |
| Novas entidades (continuação) | ITEM_COMPRA: ID_Item_Compra, QT_Comprada, VL_Unitario, VL_Total. INSUMOS: ID_Insumos, NM_Insumo, QT_Estoque, QT_Minima, UN_Medida. |

## Quadro 3 — Comparação das cardinalidades já existentes no Modelo 1

As cardinalidades abaixo foram transcritas **exatamente conforme aparecem ao lado de cada entidade** nos diagramas. A indicação “substituído” significa que o relacionamento direto não existe mais no Modelo 2.

| Relacionamento do Modelo 1 | Cardinalidades no Modelo 1 | Como ficou no Modelo 2 | Mudança |
| --- | --- | --- | --- |
| FUNCIONARIO–PEDIDO | FUNCIONARIO (0,n); PEDIDO (1,1) | FUNCIONARIO (1,1); PEDIDO (0,n) | Pares invertidos; “Faz” → “Realiza”. |
| FORNECEDOR–COMPRA | FORNECEDOR (0,n); COMPRA (1,1) | FORNECEDOR (1,1); COMPRA (0,n) | Pares invertidos; “Fornece” → “Realiza”. |
| PEDIDO–PRODUTOS | PEDIDO (1,1); PRODUTOS (0,n) | Sem relação direta; substituída por PEDIDO–ITEM_PEDIDO–PRODUTO. | Incluída entidade ITEM_PEDIDO. |
| COMPRA–PRODUTOS | COMPRA (1,n); PRODUTOS (0,n) | Sem relação direta; substituída por COMPRA–ITEM_COMPRA–INSUMOS. | Compra passa a registrar itens e insumos. |
| CONTROLE_INSUMOS–PRODUTOS | CONTROLE_INSUMOS (1,1); PRODUTOS (0,n) | Sem relação direta; INSUMOS passa a ligar-se a CONTROLE_INSUMOS. | Modificada estrutura do controle de estoque. |
| PEDIDO–PAGAMENTO | PEDIDO (1,1); PAGAMENTO (0,n) | Sem relação direta; COMANDA (1,1); PAGAMENTO (0,n). | Pagamento passa a vincular-se à COMANDA. |

## Quadro 4 — Cardinalidades de todos os relacionamentos do Modelo 2

| Relacionamento | Cardinalidades exibidas no Modelo 2 |
| --- | --- |
| FUNCIONARIO — Realiza — PEDIDO | FUNCIONARIO (1,1); PEDIDO (0,n) |
| PEDIDO — Possui — ITEM_PEDIDO | PEDIDO (1,1); ITEM_PEDIDO (1,n) |
| ITEM_PEDIDO — Refere-se — PRODUTO | ITEM_PEDIDO (0,n); PRODUTO (1,1) |
| PEDIDO — Pertence a — COMANDA | PEDIDO (1,1); COMANDA (0,n) |
| MESA — Vincula — COMANDA | MESA (1,1); COMANDA (0,n) |
| COMANDA — Possui — PAGAMENTO | COMANDA (1,1); PAGAMENTO (0,n) |
| FORNECEDOR — Realiza — COMPRA | FORNECEDOR (1,1); COMPRA (0,n) |
| COMPRA — Possui — ITEM_COMPRA | COMPRA (1,1); ITEM_COMPRA (1,n) |
| ITEM_COMPRA — Rel — INSUMOS | ITEM_COMPRA (0,n); INSUMOS (1,1) |
| PRODUTO — Consome — INSUMOS | PRODUTO (0,n); INSUMOS (0,n) |
| INSUMOS — Movimenta — CONTROLE_INSUMOS | INSUMOS (1,1); CONTROLE_INSUMOS (0,n) |

**Fonte:** imagem `Modelo Conceitual 1 BRMW.png` e PDF `Modelo Conceitual 2 - BRMW.pdf`. Esta comparação registra as alterações exibidas, sem julgar sua correção ou sugerir novas mudanças.


### 3.1 Requisitos Funcionais

- **RF01** — O sistema deve permitir o registro de pedidos de clientes, substituindo o controle atual em caderno.
- **RF02** — O sistema deve enviar o pedido registrado no sistema e gerar uma comanda através de uma pequena impressora que deve ser deixada na cozinha. 
- **RF03** — O sistema deve separar visualmente e operacionalmente os pedidos de **bebidas** dos pedidos de **cozinha/alimentos**.
- **RF04** — O sistema deve permitir o controle de insumos, com registro de entrada (compras) e saída (consumo/venda) de itens, ainda o controle de estoque vai ser validado por uma pessoa física, só deve haver registros para ajudar no que precisar ser comprado.
- **RF05** — O sistema deve permitir o cadastro de funcionários, indicando função (cozinheiro, ajudante, atendente etc.) e turno (dia/noite).
- **RF06** — O sistema deve alertar quando o insumos de bebidas ou de mistura (carnes, batata, arroz) estiver próximo do nível mínimo de reposição, o critério da reposição fica a cargo da entidade Insumos que possui um atributo de quantidade mínima de estoque para o envio de notificação.
- **RF07** — O sistema deve permitir o fechamento de pedidos/contas de clientes.

### 3.2 Requisitos Não Funcionais

- **RNF01 (Desempenho):** o sistema deve responder de forma rápida na comunicação entre salão e cozinha, já que a agilidade do atendimento é um problema identificado hoje.
- **RNF02 (Usabilidade):** a interface deve ser simples de operar, considerando que a equipe está migrando do papel para um sistema digital pela primeira vez.
- **RNF03 (Disponibilidade):** o sistema deve estar disponível todos os dias de funcionamento (segunda a sábado e feriados, das 6h00 às 21h30), sem indisponibilidade nesse intervalo.
- **RNF04 (Segurança):** o acesso às funcionalidades deve ser diferenciado por perfil (ex.: cozinha, salão, gestão), evitando alterações indevidas em pedidos ou insumos.
- **RNF05 (Escalabilidade):** o sistema deve suportar o uso simultâneo por múltiplos funcionários (em média 10 funcionários, contando com o dono) sem perda de desempenho.

### 3.3 Conversão do Modelo Conceitual para o Modelo Lógico

**Convenções utilizadas:** `ID_` identificador; `NM_` nome; `NR_` número; `TP_` tipo; `ST_` situação; `DT_` data/hora; `QT_` quantidade; `VL_` valor; `UN_` unidade. `PK` = chave primária e `FK` = chave estrangeira.

#### Entidades → Tabelas

As 12 entidades do DER viraram 12 tabelas. A entidade associativa `CONSOME` virou a 13ª tabela.

| Entidade do DER | Tabela no modelo lógico | Observação |
|---|---|---|
| Funcionario | FUNCIONARIO | — |
| Pedido | PEDIDO | — |
| Item_Pedido | ITEM_PEDIDO | Detalha produto, quantidade e valor de cada pedido |
| Produto | PRODUTO | — |
| Mesa | MESA | — |
| Comanda | COMANDA | — |
| Pagamento | PAGAMENTO | — |
| Fornecedor | FORNECEDOR | — |
| Compra | COMPRA | — |
| Item_Compra | ITEM_COMPRA | Detalha insumo, quantidade e valor de cada compra |
| Insumos | INSUMOS | — |
| Controle_Insumos | CONTROLE_INSUMOS | Registra as movimentações de estoque |
| Consome (associativa) | CONSOME | Resolve o N:N entre PRODUTO e INSUMOS |

#### Atributos → Colunas

Cada atributo do DER virou uma coluna. Todos são simples e monovalorados, então nenhum exigiu tabela adicional.

| Tipo de atributo | Tipo de dado |
|---|---|
| Identificadores (`ID_`) | INT |
| Nomes, situações, tipos (`NM_`, `ST_`, `TP_`) | VARCHAR |
| Documentos e telefones (`NR_`) | VARCHAR (CNPJ: CHAR) |
| Datas com hora (`DT_`) | DATETIME |
| Valores monetários (`VL_`) | DECIMAL(10,2) |
| Quantidades (`QT_`) | DECIMAL(12,3), exceto `QT_Item` e `QT_Lugares` (INT) |

#### Relacionamentos → Chaves

Cada relacionamento 1:N gerou uma chave estrangeira na tabela do lado N. As cardinalidades são as desenhadas no DER, na mesma ordem visual das entidades.

| Entidade A | Relacionamento | Entidade B | Próximo a A | Próximo a B | Tabela com a FK | FK |
|---|---|---|---|---|---|---|
| FUNCIONARIO | Realiza | PEDIDO | (1,1) | (0,n) | PEDIDO | ID_Funcionario |
| PEDIDO | Possui | ITEM_PEDIDO | (1,1) | (1,n) | ITEM_PEDIDO | ID_Pedido |
| ITEM_PEDIDO | Refere-se a | PRODUTO | (0,n) | (1,1) | ITEM_PEDIDO | ID_Produto |
| PEDIDO | Pertence a | COMANDA | (1,1) | (0,n) | PEDIDO | ID_Comanda |
| MESA | Vincula | COMANDA | (1,1) | (0,n) | COMANDA | ID_Mesa |
| COMANDA | Possui | PAGAMENTO | (1,1) | (0,n) | PAGAMENTO | ID_Comanda |
| FORNECEDOR | Realiza | COMPRA | (1,1) | (0,n) | COMPRA | ID_Fornecedor |
| COMPRA | Possui | ITEM_COMPRA | (1,1) | (1,n) | ITEM_COMPRA | ID_Compra |
| ITEM_COMPRA | Rel | INSUMOS | (0,n) | (1,1) | ITEM_COMPRA | ID_Insumos |
| INSUMOS | Movimenta | CONTROLE_INSUMOS | (1,1) | (0,n) | CONTROLE_INSUMOS | ID_Insumos |
| PRODUTO | Consome | INSUMOS | (0,n) | (0,n) | CONSOME | ID_Produto, ID_Insumos |

#### Cardinalidades

| Tipo | Relacionamentos | Como foi tratado |
|---|---|---|
| 1:N | 10 relacionamentos da tabela acima | FK no lado N |
| N:N | PRODUTO e INSUMOS | Tabela associativa `CONSOME`, com PK composta (`ID_Produto`, `ID_Insumos`), formada por duas FKs, e o atributo próprio `QT_Consumida` |
| 1:1 | Nenhum | — |

Os relacionamentos com (1,n) fazem todo pedido ter ao menos um item e toda compra ter ao menos um item de compra. Os com (0,n) permitem, por exemplo, comanda sem pagamento, situação necessária para representar o problema P3.

#### Generalização/especialização

O DER não possui generalização/especialização, portanto não houve estratégia de conversão.

### 3.4 Definição de Chaves Primárias e Estrangeiras

#### Chaves primárias

| Tabela | Chave primária | Tipo |
|---|---|---|
| FUNCIONARIO | ID_Funcionario | Simples |
| PEDIDO | ID_Pedido | Simples |
| ITEM_PEDIDO | ID_Item_Pedido | Simples |
| PRODUTO | ID_Produto | Simples |
| MESA | ID_Mesa | Simples |
| COMANDA | ID_Comanda | Simples |
| PAGAMENTO | ID_Pagamento | Simples |
| FORNECEDOR | ID_Fornecedor | Simples |
| COMPRA | ID_Compra | Simples |
| ITEM_COMPRA | ID_Item_Compra | Simples |
| INSUMOS | ID_Insumos | Simples |
| CONTROLE_INSUMOS | ID_Movimentacao | Simples |
| CONSOME | (ID_Produto, ID_Insumos) | Composta |

#### Chaves estrangeiras

| Tabela | Chave estrangeira | Tabela referenciada | Chave referenciada |
|---|---|---|---|
| PEDIDO | ID_Funcionario | FUNCIONARIO | ID_Funcionario |
| PEDIDO | ID_Comanda | COMANDA | ID_Comanda |
| ITEM_PEDIDO | ID_Pedido | PEDIDO | ID_Pedido |
| ITEM_PEDIDO | ID_Produto | PRODUTO | ID_Produto |
| COMANDA | ID_Mesa | MESA | ID_Mesa |
| PAGAMENTO | ID_Comanda | COMANDA | ID_Comanda |
| COMPRA | ID_Fornecedor | FORNECEDOR | ID_Fornecedor |
| ITEM_COMPRA | ID_Compra | COMPRA | ID_Compra |
| ITEM_COMPRA | ID_Insumos | INSUMOS | ID_Insumos |
| CONTROLE_INSUMOS | ID_Insumos | INSUMOS | ID_Insumos |
| CONSOME | ID_Produto | PRODUTO | ID_Produto |
| CONSOME | ID_Insumos | INSUMOS | ID_Insumos |

#### Resumo por tabela

| Tabela | PK | FKs |
|---|---|---|
| FUNCIONARIO | ID_Funcionario | — |
| PEDIDO | ID_Pedido | ID_Funcionario, ID_Comanda |
| ITEM_PEDIDO | ID_Item_Pedido | ID_Pedido, ID_Produto |
| PRODUTO | ID_Produto | — |
| MESA | ID_Mesa | — |
| COMANDA | ID_Comanda | ID_Mesa |
| PAGAMENTO | ID_Pagamento | ID_Comanda |
| FORNECEDOR | ID_Fornecedor | — |
| COMPRA | ID_Compra | ID_Fornecedor |
| ITEM_COMPRA | ID_Item_Compra | ID_Compra, ID_Insumos |
| INSUMOS | ID_Insumos | — |
| CONTROLE_INSUMOS | ID_Movimentacao | ID_Insumos |
| CONSOME | (ID_Produto, ID_Insumos) | ID_Produto, ID_Insumos |

O modelo tem 13 tabelas, 13 chaves primárias (12 simples e 1 composta) e 12 chaves estrangeiras. Em `CONSOME`, as duas colunas da chave primária composta são também chaves estrangeiras (marca `PK, FK` no modelo lógico).

# 1.4 Processo de Normalização (1FN, 2FN e 3FN)

## 1FN: eliminação de grupos repetitivos e atributos multivalorados

**Alteração 1: criada a tabela FICHA_TECNICA.** O relacionamento N:N PRODUTO–INSUMOS (com `QT_Consumida`) exigiria uma lista de insumos dentro de cada produto.

Antes:

| ID_Produto | NM_Produto | Insumos |
|---|---|---|
| 1 | Peixe frito | Tilápia (400 g), Farinha (50 g), Óleo (100 ml) |

Depois, com chave composta (`ID_Produto`, `ID_Insumos`):

| ID_Produto | ID_Insumos | QT_Consumida |
|---|---|---|
| 1 | 10 | 400 |
| 1 | 11 | 50 |
| 1 | 12 | 100 |

**Alteração 2: chaves estrangeiras explicitadas em 8 tabelas.**

| Tabela | FK incluída | Referencia |
|---|---|---|
| COMANDA | ID_Mesa | MESA |
| PEDIDO | ID_Comanda | COMANDA |
| PEDIDO | ID_Funcionario | FUNCIONARIO |
| ITEM_PEDIDO | ID_Pedido | PEDIDO |
| ITEM_PEDIDO | ID_Produto | PRODUTO |
| PAGAMENTO | ID_Comanda | COMANDA |
| COMPRA | ID_Fornecedor | FORNECEDOR |
| ITEM_COMPRA | ID_Compra | COMPRA |
| ITEM_COMPRA | ID_Insumos | INSUMOS |
| CONTROLE_INSUMOS | ID_Insumos | INSUMOS |
| FICHA_TECNICA | ID_Produto, ID_Insumos | PRODUTO, INSUMOS |

**Alteração 3:** o atributo `TP_Serto` foi corrigido para `TP_Setor`.

## 2FN: eliminação de dependências parciais

Nenhuma alteração. A única tabela com chave composta é a FICHA_TECNICA, e `QT_Consumida` depende do par (`ID_Produto`, `ID_Insumos`) inteiro.

## 3FN: eliminação de dependências transitivas

| # | Atributo removido | Motivo | Como é obtido |
|---|---|---|---|
| 1 | ITEM_PEDIDO.VL_Total | Calculado: QT_Item × VL_Unitario | Consulta ou view |
| 2 | ITEM_COMPRA.VL_Total | Calculado: QT_Comprada × VL_Unitario | Consulta ou view |
| 3 | COMPRA.VL_Compra | Soma dos itens da compra | Soma de ITEM_COMPRA |

## Justificativa do processo

| Forma normal | Por que foi necessária no Bar do Peixe |
|---|---|

### 1.5 Justificativa Técnica — Chaves Primárias e Estrangeiras

**Chaves Primárias (PK)**

As chaves primárias foram utilizadas para garantir a identificação única de cada registro nas entidades do banco de dados do Bar do Peixe. A utilização de identificadores como `ID_Funcionario`, `ID_Pedido`, `ID_Produto`, `ID_Comanda` e `ID_Pagamento` evita duplicidades e permite localizar informações de maneira precisa.

A escolha por identificadores numéricos facilita a organização dos registros, a criação de relacionamentos e a manutenção do banco de dados, independentemente de alterações em informações como nomes, descrições ou valores.

Nas entidades `ITEM_PEDIDO` e `ITEM_COMPRA`, foram utilizados identificadores próprios para individualizar os itens registrados em cada operação, permitindo que diferentes produtos ou insumos sejam associados a um mesmo pedido ou compra.

**Chaves Estrangeiras (FK)**

As chaves estrangeiras foram utilizadas para estabelecer os relacionamentos entre as tabelas, garantindo a integridade referencial e evitando registros associados a informações inexistentes.

No modelo lógico do Bar do Peixe, esses relacionamentos permitem:

- **FUNCIONARIO → PEDIDO:** identificar o funcionário responsável pelo registro de cada pedido.
- **MESA → COMANDA:** associar cada comanda à mesa correspondente.
- **COMANDA → PEDIDO:** organizar os pedidos pertencentes a uma determinada comanda.
- **PEDIDO → ITEM_PEDIDO:** relacionar os itens registrados ao pedido correspondente.
- **PRODUTO → ITEM_PEDIDO:** identificar quais produtos foram solicitados em cada item.
- **COMANDA → PAGAMENTO:** vincular os pagamentos à comanda correspondente.
- **FORNECEDOR → COMPRA:** identificar o fornecedor responsável por cada compra.
- **COMPRA → ITEM_COMPRA:** relacionar os insumos adquiridos à compra realizada.
- **INSUMOS → ITEM_COMPRA:** identificar os insumos registrados nos itens de compra.
- **INSUMOS → CONTROLE_INSUMOS:** relacionar os registros de movimentação aos respectivos insumos.

O relacionamento entre `PRODUTO` e `INSUMOS`, representado como muitos-para-muitos no modelo conceitual, necessita de uma tabela associativa no modelo lógico, utilizando chaves estrangeiras para identificar os produtos e os insumos consumidos.

**Justificativa geral**

A utilização de PKs e FKs proporciona maior consistência e confiabilidade ao banco de dados, permitindo integrar os processos de atendimento, pedidos, pagamentos, compras e controle de insumos.

Essa estrutura reduz o risco de registros duplicados ou referências inválidas, facilita as consultas SQL e contribui para a manutenção e expansão futura do sistema de gerenciamento do Bar do Peixe.

| 1FN | A baixa automática de estoque exige saber quanto de cada insumo cada prato consome. Sem a FICHA_TECNICA, isso ficaria em listas dentro de células, e sem as FKs os relacionamentos não poderiam ser implementados. |
| 2FN | Verificada para garantir que nome e preço do produto, e os dados dos insumos, fiquem apenas nas suas tabelas, e não repetidos em cada item de pedido ou de compra. |
| 3FN | Totais calculados guardados no banco podem divergir da soma dos itens. Removidos, o valor passa a ter uma única origem. |

