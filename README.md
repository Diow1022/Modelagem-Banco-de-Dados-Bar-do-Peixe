# Banco de dados Bar do Peixe-agilidade e controle de insumos
Criação de um projeto universitário para desenvolvimento, análise de requisitos e modelagem de banco de dados para o Bar do Peixe. O projeto tem como foco auxiliar o comércio na automatização de processos e na implementação de um banco de dados, proporcionando maior agilidade no atendimento e melhor controle de insumos.

**Integrantes:**
Christian Badolato Santos
RGM - 47224011/
Davi Barros Correia
RGM - 47204885/
Guilherme Pereira Ferreira da Silva
RGM - 47228903/
Jonatas do Nascimento Lima
RGM - 46929720

---

## Introdução: 

**Problema:** O bar tem um problema de agilidade nos processos, pois ele é feito de forma analógica através de papel e caneta. Outro problema é em relação a movimentação de insumos para melhor gerenciamento e ganho de tempo.

**Objetivo:** O projeto pretende melhorar a agilidade dos processos entre os funcionários e organizar o controle de insumos de forma eficiente e ágil.

**Delimitação:** Será incluído um sistema rápido, dinâmico e intuitivo. Não será incluído grandes arquiteturas de sistema e quantidade massiva de informação.

---

## Desenvolvimento

### 1. Caracterização da organização

- **Nome e natureza da Organização:** Bar do Peixe, bar/restaurante
  
- **Contexto e porte:** Com fins lucrativos; operação de pequeno porte; ao todo são 10 pessoas envolvidas, contando com funcionários, gerente e dono/patrão; Atendimento, cozinhar, gerenciamento de insumos, organização das mesas, limpeza.
  
- **Problemas e necessidades identificados:** Falta de agilidade nos processos, controle de insumos, excesso de uso de papel. Falta de recursos tecnológicos.
  
- **Justificativa da escolha:** Escolhemos o Bar do peixe primeiramente por ter contato mais acessível com o dono e também pelo porte da empresa que se encaixa com as exigências do professor(nem muito pequena ou grande) e como a empresa não possui nenhum banco de dados se torna uma boa oportunidade de trabalho para nós.
  
- **Evidências da Organização:** telefone:(11) 2098-3262 Av. Celso Garcia, 5292 - Tatuapé, São Paulo - SP, 03064-000, https://www.instagram.com/bardopeixeofficial?igsh=NTg1aDUwaGE2OXNz&utm_source=qr.

---

### 2. Processos de negócios

- **Atendimento:** Processo de atendimento realizado pelos colaboradores, no qual ele atende o cliente com o objetivo de fazê-lo/ajudar a realizar um pedido. E também contribuem com a organização das mesas e entrega dos pedidos aos clientes.
  
- **Recebimento de pedidos:** É o processo realizado após o cliente realizar o pedido, atualmente, o pedido é anotado em papel e passado ao cozinheiro, imediatamente, que irá preparar o pedido e devolvê-lo ao atendente, que leverá o pedido pronto ao cliente que estará aguardando.
  
- **Controle de insumos:** O processo que é realizado para controlar os insumos é feito a "olho", de forma manual, assim que é percebido que determinada mercadoria está acabando é solicitado reposição.
  
- **Compra com fornecedor/recebimento de mercadoria:** A compra com o fornecedor é feita através do celular com contato direto com o fornecedor, algumas mercadorias são adquiridas de forma avulsa, através de supermercados, padarias e etc. Ao chegar a mercadoria no bar ela é recebida e conferida pelo dono.
  
- **Cobrança do pedido:** A cobrança do pedido é feita após o consumo cliente, os pedidos são todos anotados em somente uma "comanda" ou repassados de boca também, o que contribui para que alguns clientes passem despercebido sem efetuar o pagamento dos produtos que consumiu.

---

## 3. Requisitos do Sistema

### 3.1 Requisitos Funcionais

- **RF01** — O sistema deve permitir o registro de pedidos de clientes, substituindo o controle atual em caderno.
- **RF02** — O sistema deve enviar o pedido registrado diretamente para a tela da cozinha, sem necessidade de comanda física.
- **RF03** — O sistema deve separar visualmente e operacionalmente os pedidos de **bebidas** dos pedidos de **cozinha/alimentos**.
- **RF04** — O sistema deve permitir o controle de insumos, com registro de entrada (compras) e saída (consumo/venda) de itens.
- **RF05** — O sistema deve permitir o cadastro de funcionários, indicando função (cozinheiro, ajudante, atendente etc.) e turno (dia/noite).
- **RF06** — O sistema deve alertar quando o insumos de bebidas ou de mistura (carnes, batata, arroz) estiver próximo do nível mínimo de reposição.
- **RF07** — O sistema deve permitir o fechamento de pedidos/contas de clientes.

### 3.2 Requisitos Não Funcionais

- **RNF01 (Desempenho):** o sistema deve responder de forma rápida na comunicação entre salão e cozinha, já que a agilidade do atendimento é um problema identificado hoje.
- **RNF02 (Usabilidade):** a interface deve ser simples de operar, considerando que a equipe está migrando do papel para um sistema digital pela primeira vez.
- **RNF03 (Disponibilidade):** o sistema deve estar disponível todos os dias de funcionamento (segunda a sábado e feriados, das 6h00 às 21h30), sem indisponibilidade nesse intervalo.
- **RNF04 (Segurança):** o acesso às funcionalidades deve ser diferenciado por perfil (ex.: cozinha, salão, gestão), evitando alterações indevidas em pedidos ou insumos.
- **RNF05 (Escalabilidade):** o sistema deve suportar o uso simultâneo por múltiplos funcionários (em média 10 funcionários, contando com o dono) sem perda de desempenho.

---

## 4. Regras de Negócio

**Regras operacionais:**

- Um pedido só pode ser considerado atendido/fechado quando o item correspondente estiver disponível no insumos (comida ou bebida).
- Uma compra só pode ser registrada no sistema mediante nota fiscal correspondente, vinculada ao CNPJ do estabelecimento.
- Um pedido só pode ser preparado pelo setor correspondente (bebida ou cozinha), de acordo com o tipo de item solicitado.
- Um pedido só é considerado fechado quando há um pagamento confirmado vinculado a ele.

**Restrições organizacionais:**

- O estabelecimento funciona apenas dentro do horário definido (6h00 às 21h30), de segunda a sábado, incluindo feriados — o horário de funcionamento define a janela padrão de operação, registros fora desse período são exceção e devem ser identificáveis.
- Há exigência legal de emissão e lançamento de nota fiscal para toda compra, vinculada ao CNPJ do estabelecimento — não é apenas prática interna, é obrigação tributária, e por isso o modelo precisa garantir rastreabilidade entre compra, fornecedor e nota fiscal.
 
---

## 5. Dicionário de Dados Conceitual (Preliminar)


**PRODUTOS**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_PRODUTO | Identificador único do produto (integer, PK) | Obrigatório |
| TIPO_PRODUTO | Categoria do produto: bebida ou alimento | Obrigatório; usado para separar fluxo de cozinha e de bebidas |
| QT_PRODUTO | Quantidade disponível em insumos | Obrigatório; não pode ser negativo |


**CONTROLE_INSUMOS**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_LOCAL | Identificador do local físico de armazenamento | Obrigatório, PK |
| QT_LOCAL | Identificador de Quantidade Produto insumos | Obrigatório |
| TP_LOCAL | Tipo de armazenamento (freezer, insumos geral) | Obrigatório |
| ID_PRODUTO | Referência a PRODUTOS (FK)| Obrigatório |

 

**FORNECEDOR**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_FORNECEDOR | Identificador único do fornecedor | Obrigatório, PK |
| NOME_FORNECEDOR | Nome/razão social do fornecedor | Obrigatório |
| CNPJ_FORNECEDOR | CNPJ do fornecedor | Obrigatório para vínculo fiscal da compra |

**COMPRA_FORNECEDOR**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_COMPRA | Identificador único da compra | Obrigatório, PK |
| DATA_COMPRA | Data da compra | Obrigatório |
| ID_FORNECEDOR | Referência ao fornecedor (FK) | Obrigatório |
| NF_NOTA_FISCAL | Número da nota fiscal vinculada ao CNPJ do Bar do Peixe | Obrigatório; toda compra deve ter nota registrada |
| TOTAL_COMPRA | Valor total da compra | Obrigatório, numérico positivo |

**FUNCIONARIO**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_FUNCIONARIO | Identificador único do funcionário | Obrigatório, PK |
| NOME_FUNCIONARIO | Nome do Civil e Social | Obrigatório |
| TP_FUNCAO | Função exercida (cozinheiro, ajudante, atendente etc.) | Obrigatório |
| TP_TURNO | Turno de trabalho (dia/noite) | Obrigatório |

**PEDIDO**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_PEDIDO | Identificador único do pedido | Obrigatório, PK |
| DT_HORA_PEDIDO | Data e hora do pedido | Obrigatório |
| TP_SETOR | Setor de destino do pedido (bebida ou cozinha) | Obrigatório; define o fluxo de atendimento |
| ID_FUNCIONARIO | Funcionário responsável pelo registro do pedido (FK) | Obrigatório |


**PAGAMENTO**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| ID_PAGAMENTO | Identificador único do pagamento | Obrigatório, PK |
| ID_PEDIDO | Referência ao pedido pago (FK) | Obrigatório |
| DT_HORA_PAGAMENTO | Data e hora em que o pagamento foi registrado | Obrigatório |
| VALOR_PAGO | Valor pago referente ao pedido | Obrigatório, numérico positivo |
| TP_FORMA_PAGAMENTO | Forma de pagamento utilizada (dinheiro, cartão ou PIX) | Obrigatório |
| IN_CONFIRMADO | Indica se o pagamento foi confirmado | Booleano; um pedido só é considerado fechado quando há pagamento confirmado vinculado a ele |

---

## 6. Modelagem Conceitual (Entidades, Atributos, Relacionamentos)

**Entidades reconhecidas e justificativa:**

- **PRODUTOS** — representa cada item vendido ou usado (bebida ou insumo de cozinha); é o núcleo do controle de insumos solicitado pelo estabelecimento.
- **CONTROLE_INSUMOS** — representa onde o produto é fisicamente guardado (ex.: os 3 freezers e o insumos geral); necessário porque o espaço de armazenamento é citado como pequeno e relevante para o controle.
- **FORNECEDOR** — representa quem vende a mercadoria ao bar; necessário para rastrear compras e notas fiscais.
- **COMPRA_FORNECEDOR** — representa cada operação de reposição de insumos, vinculando fornecedor, data e nota fiscal — essencial já que a mercadoria é o maior item de despesa do negócio.
- **FUNCIONARIO** — representa a equipe (cozinheiros, ajudantes, atendentes), necessária para registrar quem lançou cada pedido e organizar turnos.
- **PEDIDO** — representa a solicitação do cliente no balcão/mesa; é o elemento central do fluxo "salão → cozinha/bebidas" que o estabelecimento quer digitalizar.
- **PAGAMENTO** representa o pagamento feito pelo cliente e elementos que comprovam essa transação como, (DATA, TIPO de PAGAMENTO, VALOR PAGO e etc).

**Atributos e classificações:**

*Classificação de cada atributo quanto ao seu papel na entidade (chave, descritivo, numérico, categórico, temporal ou booleano).*

| Entidade | Atributo | Classificação |
|---|---|---|
| PRODUTOS | ID_PRODUTO | Chave primária |
| PRODUTOS | NM_PRODUTO | Descritivo (texto) |
| PRODUTOS | TP_CATEGORIA | Categórico |
| PRODUTOS | ID_LOCAL | Chave estrangeira |
| PRODUTOS | QT_INSUMOS_ATUAL | Numérico |
| PRODUTOS | QT_INSUMOS_MINIMO | Numérico |

| CONTROLE_INSUMOS | ID_LOCAL | Chave primária |
| CONTROLE_INSUMOS | NM_LOCAL | Descritivo (texto) |
| CONTROLE_INSUMOS | TP_LOCAL | Categórico |

| FORNECEDOR | ID_FORNECEDOR | Chave primária |
| FORNECEDOR | NOME_FORNECEDOR | Descritivo (texto) |
| FORNECEDOR | CNPJ_FORNECEDOR | Identificador externo |

| COMPRA_FORNECEDOR | ID_COMPRA | Chave primária |
| COMPRA_FORNECEDOR | DATA_COMPRA | Temporal (data) |
| COMPRA_FORNECEDOR | ID_FORNECEDOR | Chave estrangeira |
| COMPRA_FORNECEDOR | NF_NOTA_FISCAL | Identificador externo |
| COMPRA_FORNECEDOR | TOTAL_COMPRA | Numérico (monetário) |

| FUNCIONARIO | ID_FUNCIONARIO | Chave primária |
| FUNCIONARIO | NM_FUNCIONARIO | Descritivo (texto) |
| FUNCIONARIO | TP_FUNCAO | Categórico |
| FUNCIONARIO | TP_TURNO | Categórico |

| PEDIDO | ID_PEDIDO | Chave primária |
| PEDIDO | DT_HORA_PEDIDO | Temporal (data/hora) |
| PEDIDO | TP_SETOR | Categórico |
| PEDIDO | ID_FUNCIONARIO | Chave estrangeira |

| PAGAMENTO | ID_PAGAMENTO | Chave primária |
| PAGAMENTO | ID_PEDIDO | Chave estrangeira |
| PAGAMENTO | DT_HORA_PAGAMENTO | Temporal (data/hora) |
| PAGAMENTO | VALOR_PAGO | Numérico (monetário) |
| PAGAMENTO | TP_FORMA_PAGAMENTO | Categórico |
| PAGAMENTO | IN_CONFIRMADO | Booleano |

**Relacionamentos pertinentes:**

| Entidade | Relaciona-se com | Cardinalidade |
|---|---|---|

**|FORNECEDOR — FORNECE — COMPRA_FORNECEDOR|**
**FORNECEDOR: (0,n)**
**COMPRA_FORNECEDOR: (1,1)**

**|COMPRA_FORNECEDOR — CONTÉM — PRODUTOS|**
**COMPRA_FORNECEDOR: (1,n)**
**PRODUTOS: (0,n)**

**|CONTROLE_INSUMOS — ARMAZENADOS — PRODUTOS|**
**CONTROLE_INSUMOS: (1,n)**
**PRODUTOS: (0,n)**

**|FUNCIONARIO — FAZ — PEDIDO|**
**FUNCIONARIO: (0,n)**
**PEDIDO: (1,1)**

**|PEDIDO — INCLUI — PRODUTOS|**
**PEDIDO: (1,1)**
**PRODUTOS: (0,n)**

**|PEDIDO — GERA — PAGAMENTO|**
**PEDIDO: (1,1)**
**PAGAMENTO: (0,1)**


**Restrições e políticas organizacionais aplicadas ao modelo:**

- Separação de `TP_SETOR` em PEDIDO garante, a nível de dado, a divisão entre fluxo de bebidas e cozinha exigida pelo estabelecimento.
- `NF_NOTA_FISCAL` obrigatório em COMPRA reflete a exigência fiscal (nota lançada no CNPJ) já praticada pelo bar.
- `ID_LOCAL` em PRODUTO garante que cada item esteja vinculado a um dos locais físicos de armazenamento (ex.: um dos 3 freezers), refletindo o espaço reduzido citado pelo estabelecimento.
- Não foi modelada uma entidade CLIENTE, já que o atendimento é por comanda avulsa (balcão/mesa), sem cadastro de cliente identificado 
---

## 7. Diagrama Entidade-Relacionamento (DER)

- Anexado em imagem 

---

## 8. Justificativa Técnica

A modelagem do Bar do Peixe representa apenas as entidades necessárias para resolver os dois problemas centrais da organização: a falta de agilidade no fluxo salão–cozinha/bebidas e a ausência de controle de insumos.

**Por que essas entidades e não outras.** `PRODUTOS` foi separado de `INSUMOS_LOCAL` porque um mesmo produto pode estar distribuído em vários locais físicos (freezers, insumos geral), o que um atributo único não representaria. `FORNECEDOR` foi separado de `COMPRA` para evitar redundância de dados cadastrais a cada nova compra. Não foi modelada uma entidade `CLIENTE`, pois o atendimento é por comanda avulsa, sem identificação do consumidor.

**Por que esses atributos.** Foram mantidos apenas os atributos usados nos processos reais mapeados. O atributo `IN_PERECIVEL` foi descartado por não corresponder a nenhuma regra de negócio observada. Já `NF_NOTA_FISCAL` foi mantido obrigatório por representar uma exigência legal (vínculo fiscal ao CNPJ), não apenas prática interna.

**Por que esses relacionamentos e cardinalidades.** `FUNCIONARIO–PEDIDO (1,1)` garante que todo pedido tenha um responsável identificado. `PEDIDO–PAGAMENTO (1,1):(1,1)` reflete que um pedido só fecha com um pagamento confirmado vinculado a ele, sem parciais. `INSUMOS_LOCAL–PRODUTOS (0,n):(0,n)` permite que um produto esteja em mais de um local ao mesmo tempo.

---

## 9. Uso de Inteligência Artificial

**Ferramenta e etapa** - Claude(Anthropic), versão Sonnet5 -  foi usado nesta entrega para organização e sugestões de ideias, criação do corpo deste README com base no esqueleto de entrega anexado no Blackboard, criação do dicionário de dados em HTML, do fluxograma e do DER anexado (baseado nas informações fornecidas e revisões do conteúdo), e principalmente tirando dúvidas, explicando processos e respondendo se considerava coerente incluir ou excluir tal informação.

**Motivação** - Foi recorrido ao uso desta ferramenta devido à falta de conhecimento na matéria, adquirindo assim uma base sólida para começar.

**Prompt(s) utilizados** - "preciso fazer um dicionário de banco de dados, e quero que você me explique como, e por onde, com base nos arquivos anexados." / "vou te passar aqui algumas informações sobre o bar do peixe, que é o estabelecimento que escolhemos, para você me ajudar a fazer com base nesse esqueleto do README (anexei todas as informações que coletamos na visita ao bar)" / "revise o dicionário e as informações contidas nele para evitar erros e após isso gere esse arquivo .html por favor" / "em relação ao corpo do README, na seção 4 de regras de negócio, percebi que você não entendeu muito bem o conceito, então irei reforçar o que está sendo pedido nessa parte abaixo: ( escrevi as requisições do professor), com base nisso revise esse modelo já editado abaixo e remova o que for incoerente e adicione o necessário: (anexei um modelo que editei retirando algumas informações desnecessárias para mais uma revisão."

**Resposta recebida** - Em resumo, a IA me forneceu um esqueleto de como ficaria aproximadamente o dicionário de dados (ainda sem as informações da instituição). Após isso, enviei as informações do estabelecimento para formar um corpo de texto mais específico e ela o fez. Também me respondeu tirando algumas dúvidas técnicas, como o que significavam as siglas PK e FK, o que era viável incluir na modelagem ou não, fez revisões e descartou informações irrelevantes ou que foram mal interpretadas por ela.

**Fontes consultadas e verificadas** - Não foram citadas fontes.

**Trechos rejeitados ou corrigidos** - Houve falha da ferramenta de IA nas seções 4 e 6. Na seção 4, ela misturou requisitos não funcionais e contexto/justificativa de negócio com as regras de negócio. Por exemplo: "O maior item de despesa do estabelecimento é a mercadoria..." — isso não é uma regra nem uma restrição, é um fato/contexto do negócio. Não impõe condição nenhuma nem limita o modelo — é justificativa, não regra, e foi removido. E, na seção 6, foi esquecida a parte: Atributos e classificações (quais atributos pertencem a cada entidade). Foi incluído e revisado.

**Justificativa da escolha final** - Pois algumas respostas e sugestões estavam superficiais ou exageradas demais, por vezes sugerindo dados incoerentes e desnecessários para uma seção do trabalho específica, nos levando a editar e adicionar informações mais relevantes.

**Reflexão crítica** - Em alguns momentos, foi percebido pelo grupo que havia dados desnecessários ou irrelevantes para a nossa modelagem, como a inclusão de uma linha (IN_PERECIVEL) na tabela de dicionário de dados da parte de PRODUTOS, para que os produtos perecíveis fossem registrados separadamente no sistema para um controle de insumos mais detalhado. O que, sendo analisado pelo grupo, foi visto que isso não era uma funcionalidade relevante, tendo em vista que esse não é o principal problema do estabelecimento, e sim um controle de insumos geral, sendo os produtos perecíveis ou não.


**Outra utilização**


**Ferramenta e etapa** - Claude (Anthropic), versão Sonnet5 — utilizado para apoio na seção "Justificativa Técnica" do README, a partir das informações já levantadas sobre as entidades, atributos e relacionamentos do modelo (Bar do Peixe)

**Motivação** - O grupo definiu as entidades, atributos, relacionamentos e cardinalidades do DER, mas teve dificuldade em estruturar por escrito a justificativa técnica de forma clara.

**Prompt(s) utilizados** - "Me ajude a fazer o item 8 justificativa técnica, enviei o esqueleto para você ter referencia e o meu arquivo readme onde tem as informações necessarias para você, quero que me devolva um texto respondendo";/"Agora faça um resumo de cada coisa, mantenha o mesmo esquema que você fez".

**Resposta recebida** - A IA gerou um texto estruturado em tópicos ("Por que essas entidades e não outras", "Por que esses atributos", "Por que esses relacionamentos e cardinalidades"), justificando cada decisão de modelagem com base nas informações fornecidas no README.

**Fontes consultadas e verificadas** - Não foram citadas fontes.

**Trechos rejeitados ou corrigidos** - Foi solicitado a troca do termo "insumos" por "controle de insumos" em todo o texto, para manter a coerência com o restante do README. Também foi solicitado um resumo do texto original (que estava mais longo).

**Justificativa da escolha final** - Foi decidido manter a estrutura em tópicos por facilitar a leitura e prosseguir com a versão resumida, tornando o conteúdo mais objetivo e alinhado, além de adaptar e remover trechos considerados dispensáveis.

**Reflexão crítica** - O conteúdo gerado dependeu das informações que foram disponibilizadas. Também foi necessária uma revisão para garantir a coerência e definir o nível de detalhe ao trabalho, tendo em vista que a IA tende a gerar textos mais extensos do que o necessário.



---
