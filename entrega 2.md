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

**Resumo do levantamento:** o levantamento completo está em [`levantamento/levantamento.md`](levantamento/levantamento.md).

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
