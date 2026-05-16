# Sistema de Monitoramento Pedagógico e Atendimentos (Bilingual Education)

Este repositório contém o modelo e os scripts de um banco de dados relacional desenvolvido em MySQL para centralizar, estruturar e otimizar o acompanhamento individual de alunos pela coordenação pedagógica e equipe docente.

## 📝 Contexto e Problema do Cenário Real
Na rotina de gestão e coordenação de escolas (especialmente em cenários de Educação Bilíngue), o monitoramento do desenvolvimento de habilidades específicas (como *phonics*, *blending* e adaptação) e os pareceres de atendimentos individuais costumam ficar dispersos em documentos físicos ou planilhas isoladas. 

Este projeto resolve essa dor ao propor uma modelagem relacional que centraliza o histórico crônico de atendimentos, permitindo cruzamento de dados ágil para tomadas de decisão pedagógicas.

## 🛠️ Tecnologias Utilizadas
* **Banco de Dados:** MySQL
* **Ferramenta de Desenvolvimento:** MySQL Workbench
* **Conceitos Aplicados:** Chaves Primárias (PK), Chaves Estrangeiras (FK), Integridade Referencial, Subqueries Dinâmicas e Junções de Tabelas (INNER JOIN).

## 📐 Arquitetura do Banco de Dados
O banco está estruturado em 4 tabelas principais correlacionadas:
* `professores`: Cadastro da equipe docente e suas respectivas disciplinas.
* `turmas`: Organização das turmas da instituição, vinculadas aos seus professores regentes.
* `alunos`: Registro dos estudantes matriculados e sua respectiva enturmação.
* `atendimentos`: Tabela fato que centraliza o histórico de acompanhamento, conectando alunos, professores, datas e pareceres qualitativos.

## 🚀 Como Executar o Projeto
1. Copie o script contido no arquivo `script_sistema_escolar.sql` deste repositório.
2. Execute o bloco inicial no seu MySQL Workbench para criar e ativar o schema `sistema_escolar`.
3. Execute as queries de criação de tabelas (`CREATE TABLE`).
4. Rode as queries de inserção de dados. O script utiliza **subqueries** para capturar os IDs de forma dinâmica pelo nome, mitigando erros de integridade referencial.
5. Utilize as queries de `INNER JOIN` fornecidas no fim do script para extrair relatórios unificados (Aluno x Turma x Professor x Parecer).

## 🔮 Próximos Passos (Roadmap de Evolução)
- [ ] Implementação de `VIEWS` para automação de relatórios mensais de atendimento.
- [ ] Criação de `TRIGGERS` (gatilhos) para sinalizar quando um aluno atingir um teto crítico de atendimentos no mês.
- [ ] Integração do banco de dados com ferramentas de Data Viz (Power BI / Looker Studio) para geração de dashboards de evolução do aluno.
