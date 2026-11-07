# Banco de dados Bar do Peixe-agilidade e controle de insumos
Criação de um projeto universitário para desenvolvimento, análise de requisitos e modelagem de banco de dados para o Bar do Peixe. O projeto tem como foco auxiliar o comércio na automatização de processos e na implementação de um banco de dados, proporcionando maior agilidade no atendimento e melhor controle de insumos.

**Integrantes:**

| Integrante | RGM |
|---|---|
| Christian Badolato Santos | 47224011 |
| Davi Barros Correia | 47204885 |
| Guilherme Pereira Ferreira da Silva | 47228903 |
| Jonatas do Nascimento Lima | 46929720 |

---

## Introdução: 

**Problema:** O bar tem um problema de agilidade nos processos, pois ele é feito de forma analógica através de papel e caneta. Outro problema é em relação a movimentação de insumos para melhor gerenciamento e ganho de tempo.

**Objetivo:** O projeto pretende melhorar a agilidade dos processos entre os funcionários e organizar o controle de insumos de forma eficiente e ágil.

**Delimitação:** esta etapa abrange levantamento, requisitos e modelagem conceitual/documental. A implementação, as telas e a validação operacional do sistema não fazem parte da entrega atual.

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

1. **Atendimento:** Processo de atendimento realizado pelos colaboradores, no qual ele atende o cliente com o objetivo de fazê-lo/ajudar a realizar um pedido. E também contribuem com a organização das mesas e entrega dos pedidos aos clientes.
  
2. **Recebimento de pedidos:** É o processo realizado após o cliente realizar o pedido, atualmente, o pedido é anotado em papel e passado ao cozinheiro, imediatamente, que irá preparar o pedido e devolvê-lo ao atendente, que leverá o pedido pronto ao cliente que estará aguardando.
  
3. **Controle de insumos:** O processo que é realizado para controlar os insumos é feito a "olho", de forma manual, assim que é percebido que determinada mercadoria está acabando é solicitado reposição.
  
4. **Compra com fornecedor/recebimento de mercadoria:** A compra com o fornecedor é feita através do celular com contato direto com o fornecedor, algumas mercadorias são adquiridas de forma avulsa, através de supermercados, padarias e etc. Ao chegar a mercadoria no bar ela é recebida e conferida pelo dono. Não Possui cadastro para fornecedores.
  
5. **Cobrança do pedido:** A cobrança do pedido é feita após o consumo cliente, os pedidos são todos anotados em somente uma "comanda" ou repassados de boca também, o que contribui para que alguns clientes passem despercebido sem efetuar o pagamento dos produtos que consumiu.
  
6. **Cardápio / Preço:** E um cardápio comum com todas as opções que bar oferece, PF(Prato Feito), Prato do dia, Lanches e doces e Bebidas Variadas. Os preços variam conforme o produto desejado, sendo os almoços o mais caros e lanches mais simples e baratos. Bebidas variam de acordo com tipo e os PF são mais baratos.

7. **Fechamento de caixa:** procedimento ainda não confirmado com o proprietário; permanece como levantamento pendente, não como funcionalidade já modelada.   

8. **Contas a Pagar:** Em relação as despesas o proprietário deixa cerca de 90% da renda Bruta no estabelecimento, entre as despesas por alto pelo que nos foi informado são: Funcionários CLT, (água, Luz, Internet), gás e fornecedores (Comidas e Bebidas) "Caso Acabe acaba comprando por fora".

9. **Baixa de Insumos:** A media de baixa e de uma unidade por prato, (carnes, frangos, bebidas e lanches). E porções de arroz, graus e saladas.   
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

## 4. Regras de negócio e restrições

As informações a seguir distinguem **práticas observadas** de **regras propostas para o sistema**. Regras propostas precisam de validação com o estabelecimento antes da implementação.

| Código | Regra | Natureza / observação |
|---|---|---|
| RN01 | Cada pedido deverá estar associado a uma comanda e a um funcionário responsável. | Proposta do sistema |
| RN02 | Cada item de pedido deverá indicar produto, quantidade e valor unitário. | Proposta do sistema |
| RN03 | Os pedidos devem ser encaminhados ao setor correspondente (cozinha ou bebidas). | Proposta do sistema |
| RN04 | Compras devem identificar fornecedor, data, itens e documentação fiscal aplicável. | Proposta; conferir procedimento fiscal real |
| RN05 | As movimentações de insumos devem registrar item, tipo, quantidade e data. | Proposta do sistema |
| RN06 | O sistema deverá identificar insumos que atinjam o estoque mínimo. | Proposta vinculada ao RF06 |
| RN07 | Uma comanda somente deverá ser encerrada após a conferência dos pagamentos. | Proposta; mecanismo de confirmação ainda não está no DER |
| RN08 | O consumo atual é anotado em comanda física e repassado à cozinha. | Prática atual, a ser substituída pelo RF02 |
| RN09 | Cancelamentos atualmente são comunicados informalmente entre funcionários. | Prática atual; regra digital de cancelamento pendente |
| RN10 | A conferência de validade é realizada semanalmente pelo proprietário. | Prática relatada |

**Restrições:** o horário relatado de operação é das 6h às 21h30, de segunda a sábado, incluindo feriados. A venda de bebidas alcoólicas deve observar a legislação aplicável, incluindo a proibição de venda a menores de 18 anos. Regras fiscais de compras e vendas devem ser confirmadas com o responsável contábil. O modelo ainda não implementa validação de idade ou emissão fiscal.

**Pendências de levantamento:** fechamento de caixa, cancelamento formal, registro de contas a pagar e necessidade real de cadastro de clientes.


## 5. Dicionário de dados — alinhado ao último DER

O arquivo [`Dicionario_Dados_Bar_do_Peixe_Atualizado.html`](Dicionario_Dados_Bar_do_Peixe_Atualizado.html) contém o detalhamento dos atributos. A relação abaixo reproduz as **13 entidades e os atributos do último DER enviado**. Tipos SQL no HTML são sugestões, pois o diagrama não define SGBD ou tipos físicos.

**Convenções utilizadas:** `ID_` identificador; `NM_` nome; `NR_` número; `TP_` tipo; `ST_` situação; `DT_` data/hora; `QT_` quantidade; `VL_` valor; `UN_` unidade. `PK` = chave primária e `FK` = chave estrangeira. A nomenclatura reproduz a imagem, mesmo quando ainda necessita padronização.


### FUNCIONARIO

| Atributo | Tipo sugerido | Chave | Descrição |
|---|---|---|---|

| ID_Funcionario | INTEGER | PK | Identificador do funcionário |

| NM_Funcionario | VARCHAR(120) | — | Nome |

| TP_Funcao | VARCHAR(30) | — | Função |

| TP_Turno | VARCHAR(10) | — | Turno |



### PEDIDO

| Atributo | Tipo sugerido | Chave | Descrição |
|---|---|---|---|

| ID_Pedido | INTEGER | PK | Identificador do pedido |

| DT_Hora_Pedido | DATETIME | — | Data e hora |

| ST_Pedido | VARCHAR(20) | — | Situação do pedido |

| TP_Setor | VARCHAR(20) | — | Setor de destino |

| ID_Funcionario | INTEGER | FK | Referência a FUNCIONARIO |

| ID_Comanda | INTEGER | FK | Referência a COMANDA |



### ITEM_PEDIDO

| Atributo | Tipo sugerido | Chave | Descrição |
|---|---|---|---|

| ID_Item_Pedido | INTEGER | PK | Identificador do item |

| ID_Pedido | INTEGER | FK | Referência a PEDIDO |

| ID_Produto | INTEGER | FK | Referência a PRODUTO |

| QT_Item | INTEGER | — | Quantidade solicitada |

| VL_Unitario | DECIMAL(10,2) | — | Valor unitário |

| VL_Total | DECIMAL(10,2) | — | Valor total do item |



### PRODUTO

| Atributo | Tipo sugerido | Chave | Descrição |
|---|---|---|---|

| ID_Produto | INTEGER | PK | Identificador do produto |

| NM_Produto | VARCHAR(120) | — | Nome do produto |

| TP_Categoria | VARCHAR(40) | — | Categoria |

| VL_Preco | DECIMAL(10,2) | — | Preço de venda |

| ST_Produto | VARCHAR(20) | — | Situação do produto |



### CLIENTE

| Atributo | Tipo sugerido | Chave | Descrição |
|---|---|---|---|

| ID_Cliente | INTEGER | PK | Identificador do cliente |

| DT_Cliente | DATE | — | Data associada ao cliente; significado a confirmar |



### MESA

| Atributo | Tipo sugerido | Chave | Descrição |
|---|---|---|---|

| ID_Mesa | INTEGER | PK | Identificador da mesa |

| NR_Mesa | INTEGER | — | Número da mesa |

| ID_Cliente | INTEGER | FK | Referência a CLIENTE |

| TP_Situacao | VARCHAR(20) | — | Situação da mesa |

| QT_Lugares | INTEGER | — | Quantidade de lugares |



### COMANDA

| Atributo | Tipo sugerido | Chave | Descrição |
|---|---|---|---|

| ID_Comanda | INTEGER | PK | Identificador da comanda |

| ID_Mesa | INTEGER | FK | Referência a MESA |

| ST_Comanda | VARCHAR(20) | — | Situação da comanda |

| DT_Abertura | DATETIME | — | Data de abertura |



### PAGAMENTO

| Atributo | Tipo sugerido | Chave | Descrição |
|---|---|---|---|

| ID_Pagamento | INTEGER | PK | Identificador do pagamento |

| DT_Pagamento | DATETIME | — | Data do pagamento |

| TP_Pagamento | VARCHAR(20) | — | Forma de pagamento |

| ID_Comanda | INTEGER | FK | Referência a COMANDA |

| VL_Pagamento | DECIMAL(10,2) | — | Valor do pagamento |



### FORNECEDOR

| Atributo | Tipo sugerido | Chave | Descrição |
|---|---|---|---|

| ID_Fornecedor | INTEGER | PK | Identificador do fornecedor |

| ST_Fornecedor | VARCHAR(20) | — | Situação do fornecedor |

| NR_Telefone | VARCHAR(20) | — | Telefone |

| NR_CNPJ | VARCHAR(18) | — | CNPJ |

| NM_Fornecedor | VARCHAR(120) | — | Nome do fornecedor |



### COMPRA

| Atributo | Tipo sugerido | Chave | Descrição |
|---|---|---|---|

| ID_Compra | INTEGER | PK | Identificador da compra |

| ID_Fornecedor | INTEGER | FK | Referência a FORNECEDOR |

| VL_Compra | DECIMAL(10,2) | — | Valor da compra |

| NR_Nota_Fiscal | VARCHAR(44) | — | Identificador fiscal |

| DT_Compra | DATE | — | Data da compra |



### ITEM_COMPRA

| Atributo | Tipo sugerido | Chave | Descrição |
|---|---|---|---|

| ID_Item_Compra | INTEGER | PK | Identificador do item de compra |

| ID_Insumos | INTEGER | FK | Referência a INSUMOS |

| ID_Compra | INTEGER | FK | Referência a COMPRA |

| QT_Comprada | DECIMAL(12,3) | — | Quantidade comprada |

| VL_Unitario | DECIMAL(10,2) | — | Preço unitário |

| VL_Total | DECIMAL(10,2) | — | Valor total do item |



### INSUMOS

| Atributo | Tipo sugerido | Chave | Descrição |
|---|---|---|---|

| ID_Insumos | INTEGER | PK | Identificador do insumo |

| NM_Insumo | VARCHAR(120) | — | Nome do insumo |

| UN_Medida | VARCHAR(15) | — | Unidade de medida |

| QT_Estoque | DECIMAL(12,3) | — | Quantidade em estoque |

| QT_Minima | DECIMAL(12,3) | — | Estoque mínimo |



### CONTROLE_INSUMOS

| Atributo | Tipo sugerido | Chave | Descrição |
|---|---|---|---|

| ID_Movimentacao | INTEGER | PK | Identificador da movimentação |

| ID_Insumos | INTEGER | FK | Referência a INSUMOS |

| QT_Movimentacao | DECIMAL(12,3) | — | Quantidade movimentada |

| TP_Movimentacao | VARCHAR(20) | — | Tipo de movimentação |

| DT_Movimentacao | DATETIME | — | Data da movimentação |



### Convenções e proteção dos dados

- **SGBD, versão e collation:** ainda não definidos pelo grupo; não são apresentados como decisões concluídas.
- **Integridade:** identificadores `PK` devem ser únicos; `FK` devem referenciar registros existentes. Nulidade, restrições `CHECK` e índices serão definidos na modelagem lógica.
- **LGPD:** dados de clientes e funcionários devem ser limitados ao necessário, com acesso por perfil e retenção adequada. O propósito de `DT_Cliente` ainda precisa ser esclarecido.
- **Histórico/log:** `CONTROLE_INSUMOS` registra movimentações de estoque, mas **não equivale** a um log geral de auditoria; trilhas de alteração de pedidos, pagamentos e cadastros ainda não foram modeladas.
- **Fluxo de dados previsto:** mesa → comanda → pedido → item de pedido → produto; comanda → pagamento; fornecedor → compra → item de compra → insumo → controle de insumos.


## 6. Modelagem conceitual — entidades e relacionamentos

**Entidades:** `FUNCIONARIO`, `PEDIDO`, `ITEM_PEDIDO`, `PRODUTO`, `CLIENTE`, `MESA`, `COMANDA`, `PAGAMENTO`, `FORNECEDOR`, `COMPRA`, `ITEM_COMPRA`, `INSUMOS` e `CONTROLE_INSUMOS`.

O quadro abaixo **transcreve as cardinalidades desenhadas**, sem afirmar que todas já foram validadas. Os valores estão na mesma ordem visual das entidades.

| Entidade A | Relacionamento | Entidade B | Próximo a A | Próximo a B |
|---|---|---|---|---|


| FUNCIONARIO | Realiza | PEDIDO | (1,N) | (1,1) |

| PEDIDO | Possui | ITEM_PEDIDO | (1,N) | (1,1) |

| ITEM_PEDIDO | Refere-se a | PRODUTO | (0,N) | (1,1) |

| CLIENTE | Pedi | MESA | (1,1) | (1,N) |

| MESA | Vincula | COMANDA | (1,N) | (1,1) |

| PEDIDO | Pertence a | COMANDA | (1,N) | (1,1) |

| COMANDA | Possui | PAGAMENTO | (1,1) | (1,N) |

| PRODUTO | Consome | INSUMOS | (1,N) | (1,1) |

| FORNECEDOR | Realiza | COMPRA | (1,N) | (1,1) |

| COMPRA | Possui | ITEM_COMPRA | (1,N) | (1,1) |

| ITEM_COMPRA | Rel | INSUMOS | (0,N) | (1,1) |

| INSUMOS | Movimenta | CONTROLE_INSUMOS | (1,N) | (1,1) |


**Pontos a validar no modelo:**

1. `CLIENTE` e `ID_Cliente` em `MESA` contradizem a justificativa anterior de que não existe cadastro de clientes; confirmar se a entidade deve permanecer.
2. `DT_Cliente` está sem significado de negócio definido.
3. `PRODUTO`–`INSUMOS` não registra a quantidade consumida por receita; a baixa automática por prato exige detalhamento adicional.
4. `COMANDA`–`PAGAMENTO` precisa permitir comandas abertas sem pagamento e esclarecer pagamentos divididos e confirmação.
5. Conferir a leitura das cardinalidades no brModelo e as participações mínimas de funcionários, mesas, fornecedores e insumos.
6. O diagrama mistura atributos de chave estrangeira com relacionamentos conceituais; confirmar com o professor o nível de modelagem exigido.


## 7. Diagrama Entidade-Relacionamento (DER)

O último DER foi revisado para incluir `ITEM_PEDIDO`, `ITEM_COMPRA`, `MESA`, `COMANDA`, `CLIENTE` e a movimentação de insumos. **O arquivo da imagem final precisa ser adicionado ao repositório** com o nome abaixo para que o link funcione.

![DER atualizado do Bar do Peixe](DER_Bar_do_Peixe_Atualizado.png)

> Nota: a imagem reflete o último desenho fornecido pelo grupo. As ressalvas de cardinalidade da seção 6 permanecem abertas.


## 8. Justificativa técnica

A modelagem separa as atividades de atendimento, compras e estoque para reduzir duplicidade de informações e permitir rastrear operações. `PEDIDO` representa o atendimento registrado por funcionário; `ITEM_PEDIDO` detalha produtos, quantidades e valores. `COMANDA` reúne pedidos e pagamentos relacionados à mesa, apoiando o fechamento da conta.

`COMPRA` registra a aquisição junto a `FORNECEDOR`, enquanto `ITEM_COMPRA` descreve os insumos comprados. `INSUMOS` representa o saldo e o nível mínimo; `CONTROLE_INSUMOS` registra entradas, saídas e ajustes. `PRODUTO` descreve o que é vendido no cardápio.

A entidade `CLIENTE` foi mantida **somente para refletir o último DER**, apesar da justificativa anterior de não cadastrar consumidores. Sua permanência precisa ser confirmada. O relacionamento de consumo entre `PRODUTO` e `INSUMOS` também carece de quantidade por receita, caso se deseje baixa automática de ingredientes.

As cardinalidades e os atributos devem ser revisados em conjunto com o dicionário antes da aprovação final, evitando que a justificativa descreva um comportamento diferente do diagrama.


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



### Complemento — atualização documental

Nesta revisão, o ChatGPT foi utilizado como apoio à comparação entre o README, o arquivo de Issues, o último DER enviado em imagem e o dicionário de dados atualizado. O apoio incluiu reorganização das seções, transcrição de entidades e atributos, identificação de divergências e sugestões de pontos para validação. **A conferência técnica e a decisão sobre o modelo final permanecem sob responsabilidade do grupo.**

**Fontes desta revisão:** README anterior, Issues Cid, último DER fornecido pelo grupo e dicionário HTML atualizado. Não foram realizadas entrevistas adicionais nem testes do sistema nesta etapa.


## 10. Conclusão

O levantamento no Bar do Peixe identificou dificuldades no registro manual de pedidos, na comunicação entre salão e cozinha e no controle de insumos. A proposta de modelagem documenta funcionários, pedidos, itens, produtos, mesas, comandas, pagamentos, fornecedores, compras e movimentações de estoque, oferecendo uma base para um sistema futuro.

A inclusão de `ITEM_PEDIDO`, `ITEM_COMPRA`, `MESA` e `COMANDA` amplia a rastreabilidade dos processos em relação à versão inicial. O trabalho permanece **na etapa de modelagem**, não sendo correto afirmar que as funcionalidades já foram implementadas ou testadas.

**Próximos passos:** validar as regras com o proprietário, resolver a necessidade de `CLIENTE`, revisar cardinalidades, definir como ocorrerá a baixa de ingredientes por produto, concluir o dicionário lógico e implementar/testar o sistema posteriormente.
