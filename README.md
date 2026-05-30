# Sistema de Monitoramento Pedagógico e Atendimentos (Bilingual Education)

Criei este banco de dados relacional em MySQL para resolver um problema bem comum na minha rotina escolar: a dispersão de informações sobre o acompanhamento dos alunos. 

Em cenários de Educação Bilíngue, os professores geram pareceres muito ricos sobre habilidades específicas (como *phonics*, *blending*, nível de engajamento e adaptação). O problema é que essas anotações costumam ficar perdidas em relatórios físicos ou planilhas isoladas, dificultando a visão do histórico do aluno. 

A ideia desse projeto é centralizar esses dados de forma estruturada para que a coordenação pedagógica consiga cruzar informações rapidamente e tomar decisões com base em dados reais.

## O que foi aplicado na prática (Conceitos Técnicos)
Em vez de usar dados fictícios e genéricos, usei a estrutura da escola para aplicar os conceitos de banco de dados:
* **Modelagem Relacional:** Uso de Chaves Primárias (PK) e Chaves Estrangeiras (FK) para garantir que as tabelas conversem entre si sem duplicar dados.
* **Integridade Referencial:** Travas no banco para impedir que um atendimento seja registrado para um aluno que não existe.
* **Subqueries Dinâmicas:** Uso de seleções internas dentro do `INSERT` para buscar os IDs dos alunos e professores direto pelo nome, evitando erros manuais de digitação de ID.
* **Junções e Abstração:** Cruzamento de dados com `INNER JOIN` e criação de `VIEWS` para gerar relatórios limpos com apenas um comando.

## Como o banco foi estruturado
O ecossistema é dividido em 4 tabelas que se conectam logicamente:
1. `professores`: Cadastro da equipe docente bilíngue e suas matérias.
2. `turmas`: Organização das turmas vinculadas aos seus respectivos professores regentes.
3. `alunos`: Registro dos estudantes e sua enturmação.
4. `atendimentos`: A tabela principal onde o histórico é construído (conecta o aluno, o professor que atendeu, a data, o status do caso e o parecer qualitativo).

## Como rodar o script no MySQL Workbench
1. Abra o arquivo `script_sistema_escolar.sql` no seu Workbench.
2. Execute o bloco inicial para criar e ativar o banco de dados (`sistema_escolar`).
3. Rode as queries de criação de tabelas na ordem correta (Professores ➡️ Turmas ➡️ Alunos ➡️ Atendimentos) por conta das dependências de chaves estrangeiras.
4. Execute as inserções de dados e teste o comando de `UPDATE` criado para gerenciar a evolução dos status.
5. Para ver o relatório final unificado sem precisar digitar códigos longos, basta rodar o comando da nossa View: `SELECT * FROM vw_relatorio_atendimentos_bilingue;`.

## 🔮 O que pretendo implementar a seguir (Roadmap)
- [x] Criação de `VIEWS` para automatizar o relatório geral da coordenação e permitir filtros rápidos por Status (Pendente, Em Acompanhamento, Concluído).
- [ ] Construção de uma `TRIGGER` (gatilho de segurança) para impedir que erros de digitação permitam salvar datas futuras nos atendimentos.
- [ ] Conectar esse banco ao Power BI ou Looker Studio para transformar os pareceres de texto e contagens de atendimento em um dashboard visual de evolução do aluno.
