# Banco de dados Bar do Peixe-agilidade e controle de estoque
Criação de um projeto universitário para desenvolvimento, análise de requisitos e modelagem de banco de dados para o Bar do Peixe. O projeto tem como foco auxiliar o comércio na automatização de processos e na implementação de um banco de dados, proporcionando maior agilidade no atendimento e melhor controle de estoque.

## Introdução: 
**Problema:** *O bar tem um problema de agilidade nos processos, pois ele é feito de forma analógica através de papel e caneta. Outro problema é em relação ao controle de estoque para melhor gerenciamento e ganho de tempo.*
**Objetivo:** *O projeto pretende melhorar a agilidade dos processos entre os funcionários e organizar o controle de estoque de forma eficiente e ágil.*
**Delimitação:** *Será incluído um sistema rápido, dinâmico e intuitivo. Não será incluído grandes arquiteturas de sistema e quantidade massiva de informação.*

## Desenvolvimento

### 1. Caracterização da organização
- **Nome e natureza da Organização:** *Bar do Peixe, bar/restaurante*
- **Contexto e porte:** *Com fins lucrativos; operação de pequeno porte; ao todo são 10 pessoas envolvidas, contando com funcionários, gerente e dono/patrão; Atendimento, cozinhar, gerenciamento de estoque, organização das mesas, limpeza.*
- **Problemas e necessidades identificados:** *Falta de agilidade nos processos, controle de estoque, excesso de uso de papel. Falta de recursos tecnológicos.*
- **Justificativa da escolha:** *Escolhemos o Bar do peixe primeiramente por ter contato mais acessível com o dono e também pelo porte da empresa que se encaixa com as exigências do professor(nem muito pequena ou grande) e como a empresa não possui nenhum banco de dados se torna uma boa oportunidade de trabalho para nós.*
- **Evidências da Organização:** *Av. Celso Garcia, 5292 - Tatuapé, São Paulo - SP, 03064-000, https://www.instagram.com/bardopeixeofficial?igsh=NTg1aDUwaGE2OXNz&utm_source=qr.*

---

### 2. Processos de negócios
- *Atendimento;*
- *Recebimento de pedidos;*
- *Controle de estoque;*
- *Compra com fornecedor/recebimento de mercadoria;*
- *Cobrança do pedido;*

## 3. Requisitos do Sistema

### 3.1 Requisitos Funcionais

- **RF01** — O sistema deve permitir o registro de pedidos de clientes, substituindo o controle atual em caderno.
- **RF02** — O sistema deve enviar o pedido registrado diretamente para a tela da cozinha, sem necessidade de comanda física.
- **RF03** — O sistema deve separar visualmente e operacionalmente os pedidos de **bebidas** dos pedidos de **cozinha/alimentos**.
- **RF04** — O sistema deve permitir o controle de estoque, com registro de entrada (compras) e saída (consumo/venda) de itens.
- **RF05** — O sistema deve permitir o cadastro de funcionários, indicando função (cozinheiro, ajudante, atendente etc.) e turno (dia/noite).
- **RF06** — O sistema deve alertar quando o estoque de bebidas ou de mistura (carnes, batata, arroz) estiver próximo do nível mínimo de reposição.
- **RF07** — O sistema deve permitir o fechamento de pedidos/contas de clientes.

### 3.2 Requisitos Não Funcionais

- **RNF01 (Desempenho):** o sistema deve responder de forma imediata na comunicação entre salão e cozinha, já que a agilidade do atendimento é um problema identificado hoje.
- **RNF02 (Usabilidade):** a interface deve ser simples e rápida de operar, considerando que a equipe está migrando do papel para um sistema digital pela primeira vez.
- **RNF03 (Disponibilidade):** o sistema deve estar disponível todos os dias de funcionamento (segunda a sábado e feriados, das 6h00 às 21h30), sem indisponibilidade nesse intervalo.
- **RNF04 (Segurança):** o acesso às funcionalidades deve ser diferenciado por perfil (ex.: cozinha, salão, gestão), evitando alterações indevidas em pedidos ou estoque.
- **RNF05 (Escalabilidade):** o sistema deve suportar o uso simultâneo por múltiplos funcionários (em média 10 funcionários, contando com o dono) sem perda de desempenho.

---

## 4. Regras de Negócio

**Regras operacionais:**

- Um pedido só pode ser considerado atendido/fechado quando o item correspondente estiver disponível no estoque (comida ou bebida).
- Uma compra só pode ser registrada no sistema mediante nota fiscal correspondente, vinculada ao CNPJ do estabelecimento.
- Um pedido só pode ser preparado pelo setor correspondente (bebida ou cozinha), de acordo com o tipo de item solicitado.
- Um pedido só é considerado fechado quando há um pagamento confirmado vinculado a ele.

**Restrições organizacionais:**

- O estabelecimento funciona apenas dentro do horário definido (6h00 às 21h30), de segunda a sábado, incluindo feriados — o horário de funcionamento define a janela padrão de operação, registros fora desse período são exceção e devem ser identificáveis.
- Há exigência legal de emissão e lançamento de nota fiscal para toda compra, vinculada ao CNPJ do estabelecimento — não é apenas prática interna, é obrigação tributária, e por isso o modelo precisa garantir rastreabilidade entre compra, fornecedor e nota fiscal.
 
---

## 5. Dicionário de Dados Conceitual (Preliminar)


**PRODUTO**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_PRODUTO | Identificador único do produto (integer, PK) | Obrigatório |
| NM_PRODUTO | Nome do produto (ex.: "Cerveja Lata 350ml", "Sobrecoxa") | Obrigatório |
| TP_CATEGORIA | Categoria do produto: bebida ou alimento | Obrigatório; usado para separar fluxo de cozinha e de bebidas |
| ID_LOCAL | Local de armazenamento do produto (FK para ESTOQUE_LOCAL) | Obrigatório; sustenta o relacionamento PRODUTO–ESTOQUE_LOCAL |
| QT_ESTOQUE_ATUAL | Quantidade disponível em estoque | Obrigatório; não pode ser negativo |
| QT_ESTOQUE_MINIMO | Quantidade mínima antes de disparar alerta de reposição | Definido conforme histórico de consumo |

**ESTOQUE_LOCAL**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_LOCAL | Identificador do local físico de armazenamento | Obrigatório, PK |
| NM_LOCAL | Nome/identificação do local (ex.: "Freezer 1", "Estoque seco") | Obrigatório |
| TP_LOCAL | Tipo de armazenamento (freezer, estoque geral) | Obrigatório |

**FORNECEDOR**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_FORNECEDOR | Identificador único do fornecedor | Obrigatório, PK |
| NM_FORNECEDOR | Nome/razão social do fornecedor | Obrigatório |
| NR_CNPJ_FORNECEDOR | CNPJ do fornecedor | Obrigatório para vínculo fiscal da compra |

**COMPRA**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_COMPRA | Identificador único da compra | Obrigatório, PK |
| DT_COMPRA | Data da compra | Obrigatório |
| ID_FORNECEDOR | Referência ao fornecedor (FK) | Obrigatório |
| NR_NOTA_FISCAL | Número da nota fiscal vinculada ao CNPJ do Bar do Peixe | Obrigatório; toda compra deve ter nota registrada |
| VL_TOTAL_COMPRA | Valor total da compra | Obrigatório, numérico positivo |

**ITEM_COMPRA**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_ITEM_COMPRA | Identificador único do item dentro da compra | Obrigatório, PK |
| ID_COMPRA | Referência à compra (FK) | Obrigatório |
| ID_PRODUTO | Referência ao produto adquirido (FK) | Obrigatório; o produto tem seu QT_ESTOQUE_ATUAL incrementado |
| QT_ITEM_COMPRA | Quantidade adquirida do produto nessa compra | Obrigatório, maior que zero |
| VL_UNITARIO | Valor unitário pago pelo produto nessa compra | Obrigatório, numérico positivo |

**FUNCIONARIO**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_FUNCIONARIO | Identificador único do funcionário | Obrigatório, PK |
| NM_FUNCIONARIO | Nome do funcionário | Obrigatório |
| TP_FUNCAO | Função exercida (cozinheiro, ajudante, atendente etc.) | Obrigatório |
| TP_TURNO | Turno de trabalho (dia/noite) | Obrigatório |

**PEDIDO**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_PEDIDO | Identificador único do pedido | Obrigatório, PK |
| DT_HORA_PEDIDO | Data e hora do pedido | Obrigatório |
| TP_SETOR | Setor de destino do pedido (bebida ou cozinha) | Obrigatório; define o fluxo de atendimento |
| ID_FUNCIONARIO | Funcionário responsável pelo registro do pedido (FK) | Obrigatório |
| IN_FINALIZADO | Indica se o pedido já foi entregue/fechado | Booleano |

**ITEM_PEDIDO**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_ITEM_PEDIDO | Identificador único do item dentro do pedido | Obrigatório, PK |
| ID_PEDIDO | Referência ao pedido (FK) | Obrigatório |
| ID_PRODUTO | Referência ao produto pedido (FK) | Obrigatório; produto deve existir em estoque |
| QT_ITEM | Quantidade solicitada do produto | Obrigatório, maior que zero |

**PAGAMENTO**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_PAGAMENTO | Identificador único do pagamento | Obrigatório, PK |
| ID_PEDIDO | Referência ao pedido pago (FK) | Obrigatório |
| DT_HORA_PAGAMENTO | Data e hora em que o pagamento foi registrado | Obrigatório |
| VL_PAGO | Valor pago referente ao pedido | Obrigatório, numérico positivo |
| TP_FORMA_PAGAMENTO | Forma de pagamento utilizada (dinheiro, cartão ou PIX) | Obrigatório |
| IN_CONFIRMADO | Indica se o pagamento foi confirmado | Booleano; um pedido só é considerado fechado quando há pagamento confirmado vinculado a ele |

---

## 6. Modelagem Conceitual (Entidades, Atributos, Relacionamentos)

**Entidades reconhecidas e justificativa:**

- **PRODUTO** — representa cada item vendido ou usado (bebida ou insumo de cozinha); é o núcleo do controle de estoque solicitado pelo estabelecimento.
- **ESTOQUE_LOCAL** — representa onde o produto é fisicamente guardado (ex.: os 3 freezers e o estoque geral); necessário porque o espaço de armazenamento é citado como pequeno e relevante para o controle.
- **FORNECEDOR** — representa quem vende a mercadoria ao bar; necessário para rastrear compras e notas fiscais.
- **COMPRA** — representa cada operação de reposição de estoque, vinculando fornecedor, data e nota fiscal — essencial já que a mercadoria é o maior item de despesa do negócio.
- **ITEM_COMPRA** — entidade associativa entre COMPRA e PRODUTO, pois uma compra pode reabastecer vários produtos e cada produto pode ser comprado várias vezes.
- **FUNCIONARIO** — representa a equipe (cozinheiros, ajudantes, atendentes), necessária para registrar quem lançou cada pedido e organizar turnos.
- **PEDIDO** — representa a solicitação do cliente no balcão/mesa; é o elemento central do fluxo "salão → cozinha/bebidas" que o estabelecimento quer digitalizar.
- **ITEM_PEDIDO** — entidade associativa entre PEDIDO e PRODUTO, pois um pedido pode conter vários produtos e cada produto pode aparecer em vários pedidos.

**Atributos e classificações:**

*Classificação de cada atributo quanto ao seu papel na entidade (chave, descritivo, numérico, categórico, temporal ou booleano).*

| Entidade | Atributo | Classificação |
|---|---|---|
| PRODUTO | ID_PRODUTO | Chave primária |
| PRODUTO | NM_PRODUTO | Descritivo (texto) |
| PRODUTO | TP_CATEGORIA | Categórico |
| PRODUTO | ID_LOCAL | Chave estrangeira |
| PRODUTO | QT_ESTOQUE_ATUAL | Numérico |
| PRODUTO | QT_ESTOQUE_MINIMO | Numérico |
| ESTOQUE_LOCAL | ID_LOCAL | Chave primária |
| ESTOQUE_LOCAL | NM_LOCAL | Descritivo (texto) |
| ESTOQUE_LOCAL | TP_LOCAL | Categórico |
| FORNECEDOR | ID_FORNECEDOR | Chave primária |
| FORNECEDOR | NM_FORNECEDOR | Descritivo (texto) |
| FORNECEDOR | NR_CNPJ_FORNECEDOR | Identificador externo |
| COMPRA | ID_COMPRA | Chave primária |
| COMPRA | DT_COMPRA | Temporal (data) |
| COMPRA | ID_FORNECEDOR | Chave estrangeira |
| COMPRA | NR_NOTA_FISCAL | Identificador externo |
| COMPRA | VL_TOTAL_COMPRA | Numérico (monetário) |
| ITEM_COMPRA | ID_ITEM_COMPRA | Chave primária |
| ITEM_COMPRA | ID_COMPRA | Chave estrangeira |
| ITEM_COMPRA | ID_PRODUTO | Chave estrangeira |
| ITEM_COMPRA | QT_ITEM_COMPRA | Numérico |
| ITEM_COMPRA | VL_UNITARIO | Numérico (monetário) |
| FUNCIONARIO | ID_FUNCIONARIO | Chave primária |
| FUNCIONARIO | NM_FUNCIONARIO | Descritivo (texto) |
| FUNCIONARIO | TP_FUNCAO | Categórico |
| FUNCIONARIO | TP_TURNO | Categórico |
| PEDIDO | ID_PEDIDO | Chave primária |
| PEDIDO | DT_HORA_PEDIDO | Temporal (data/hora) |
| PEDIDO | TP_SETOR | Categórico |
| PEDIDO | ID_FUNCIONARIO | Chave estrangeira |
| PEDIDO | IN_FINALIZADO | Booleano |
| ITEM_PEDIDO | ID_ITEM_PEDIDO | Chave primária |
| ITEM_PEDIDO | ID_PEDIDO | Chave estrangeira |
| ITEM_PEDIDO | ID_PRODUTO | Chave estrangeira |
| ITEM_PEDIDO | QT_ITEM | Numérico |
| PAGAMENTO | ID_PAGAMENTO | Chave primária |
| PAGAMENTO | ID_PEDIDO | Chave estrangeira |
| PAGAMENTO | DT_HORA_PAGAMENTO | Temporal (data/hora) |
| PAGAMENTO | VL_PAGO | Numérico (monetário) |
| PAGAMENTO | TP_FORMA_PAGAMENTO | Categórico |
| PAGAMENTO | IN_CONFIRMADO | Booleano |

**Relacionamentos pertinentes:**

| Entidade | Relaciona-se com | Cardinalidade |
|---|---|---|
| PEDIDO | ITEM_PEDIDO | 1:N — um pedido pode ter vários itens |
| PRODUTO | ITEM_PEDIDO | 1:N — um produto pode aparecer em vários itens de pedido |
| FUNCIONARIO | PEDIDO | 1:N — um funcionário registra vários pedidos |
| PRODUTO | ESTOQUE_LOCAL | N:1 — cada produto fica armazenado em um local (ex.: um dos 3 freezers) |
| FORNECEDOR | COMPRA | 1:N — um fornecedor realiza várias compras ao longo do tempo |
| COMPRA | ITEM_COMPRA | 1:N — uma compra pode conter vários itens |
| PRODUTO | ITEM_COMPRA | 1:N — um produto pode aparecer em várias compras ao longo do tempo |

**Restrições e políticas organizacionais aplicadas ao modelo:**

- Separação de `TP_SETOR` em PEDIDO garante, a nível de dado, a divisão entre fluxo de bebidas e cozinha exigida pelo estabelecimento.
- `NR_NOTA_FISCAL` obrigatório em COMPRA reflete a exigência fiscal (nota lançada no CNPJ) já praticada pelo bar.
- `QT_ESTOQUE_MINIMO` em PRODUTO viabiliza o alerta de reposição citado como necessidade.
- `ID_LOCAL` em PRODUTO garante que cada item esteja vinculado a um dos locais físicos de armazenamento (ex.: um dos 3 freezers), refletindo o espaço reduzido citado pelo estabelecimento.
- `ITEM_COMPRA` evita duplicar o mesmo item em várias compras dentro do registro de COMPRA, mantendo o histórico de preço unitário por aquisição.
- Não foi modelada uma entidade CLIENTE, já que o atendimento é por comanda avulsa (balcão/mesa), sem cadastro de cliente identificado.
---
