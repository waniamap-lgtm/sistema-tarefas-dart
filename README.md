# TaskReport Dart

## Sobre o projeto
O **TaskReport Dart** é uma ferramenta de processamento e análise de dados desenvolvida em Dart. O objetivo deste projeto é simular o tratamento de dados vindos de uma API, aplicando técnicas de limpeza, conversão de tipos (números e monetários) e análise de indicadores financeiros e operacionais de tarefas.

## Funcionalidades
- **Tratamento de Dados:** Limpeza de textos nulos e formatação de strings para números.
- **POO:** Estrutura baseada em classes (`ItemTrabalho` e `Tarefa`) com herança.
- **Relatórios:** Exibição organizada de todas as tarefas processadas.
- **Filtros e Cálculos:** Identificação de tarefas concluídas/pendentes, soma de valores e média de custos.
- **Análise de Qualidade:** Identificação automática de tarefas com dados incompletos.

## Detalhes da Solução Técnica
Para garantir a eficiência e a estabilidade do sistema, as seguintes lógicas foram aplicadas no código:
- **Arquitetura (POO):** A classe `Tarefa` especializa a classe base `ItemTrabalho` (Herança). O estado da tarefa é protegido (Encapsulamento) através do atributo privado `_status`, que é acessado de forma segura via um *getter* público.
- **Higienização de Dados:** Aplicação de `trim()` e `toLowerCase()` para padronizar textos. O código usa `double.tryParse`, `int.tryParse` e `replaceAll` para converter valores monetários e horas (em formato de texto) para números reais, prevenindo quebras na execução.
- **Regras de Negócio e Cálculos:**
  - Uso de **Switch-case** para categorizar e padronizar os status válidos do sistema de forma organizada.
  - Utilização de métodos funcionais como `where()` para filtrar tarefas específicas e `fold()` para consolidar as somas financeiras e horas totais.
  - Implementação de um **Operador Ternário** para verificar de forma rápida se os dados essenciais da tarefa (título, valor ou horas) estão zerados ou ausentes.

## Gestão do Projeto
Este projeto foi desenvolvido utilizando a metodologia Kanban para garantir o acompanhamento de todas as etapas.
- **Quadro de Gestão:** [Acesse o nosso quadro no Trello](https://trello.com/invite/b/6a1a282a514845c8146a4865/ATTIb32334f4245eca57992b17508a9d42bf71D24D66/meu-quadro-do-trello)

## Tecnologias utilizadas
- **Linguagem:** Dart (versão estável)
- **Paradigma:** Orientação a Objetos (POO)
- **Versionamento:** Git e GitHub
- **Gestão:** Trello

## Como executar
1. Certifique-se de ter o [Dart SDK](https://dart.dev/get-dart) instalado em sua máquina.
2. Clone este repositório.
3. No terminal, dentro da pasta do projeto, execute:
```bash
   dart run main.dart