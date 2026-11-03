<div align="center">

# FIXA · Modelo de Grafos

Representação em grafos das entidades, relacionamentos e percursos de negócio da plataforma FIXA.

![Neo4j](https://img.shields.io/badge/Neo4j-Graph_Database-4581C3?logo=neo4j&logoColor=white)
![Cypher](https://img.shields.io/badge/Cypher-Queries-008CC1)
![Modelagem](https://img.shields.io/badge/Modelagem-Domínio-6C63FF)
![Licença](https://img.shields.io/badge/License-MIT-green)

</div>

---

## ✨ Visão geral

Este repositório concentra os scripts Cypher usados para representar o domínio do FIXA no Neo4j.

O modelo transforma as principais entidades da plataforma em nós conectados, permitindo explorar dependências, percorrer fluxos de manutenção e analisar relações entre instituições, unidades, usuários, equipamentos, problemas, ocorrências e ordens de serviço.

## 🚀 Funcionalidades

- Criação de constraints de identidade para os nós do modelo
- Definição das entidades do domínio FIXA
- Representação dos relacionamentos entre instituições e unidades
- Modelagem de planos, contratos e pagamentos
- Representação de usuários, turnos, aptidões e feedbacks
- Modelagem de locais, eventos e equipamentos
- Relacionamento entre categorias, marcas e modelos de equipamentos
- Representação de problemas e ocorrências de manutenção
- Percurso entre problemas e ordens de serviço
- Associação de técnicos às ordens de serviço
- Representação de tarefas, observações e fotos
- Modelagem dos históricos de status e técnicos
- Representação de registros de auditoria
- Consultas para visualização do modelo completo
- Consultas de contagem de entidades e relacionamentos
- Percursos para identificação de técnicos aptos por ordem de serviço

## 🧩 Entidades representadas

| Domínio | Nós principais |
| --- | --- |
| **Organização** | Instituição, unidade, plano e contrato |
| **Financeiro** | Pagamento e auditoria de pagamento |
| **Pessoas** | Usuário, superadministrador, turno e aptidão |
| **Estrutura física** | Local da unidade |
| **Equipamentos** | Categoria, marca, modelo e equipamento |
| **Manutenção** | Problema, ocorrência, ordem de serviço e tarefa |
| **Comunicação** | Feedback, evento, observação e foto |
| **Auditoria** | Atividade diária e históricos de usuário, problema e ordem de serviço |
| **Governança** | Catálogo de dados |

## 🔗 Relacionamentos de negócio

O grafo representa, entre outros, os seguintes percursos:

- Instituições possuem unidades
- Unidades reúnem usuários e contêm locais
- Usuários possuem aptidões e participam de turnos
- Locais abrigam equipamentos
- Marcas e categorias classificam modelos de equipamentos
- Usuários relatam problemas e registram ocorrências
- Problemas originam ordens de serviço
- Técnicos assumem ordens de serviço
- Ordens de serviço contêm tarefas e observações
- Problemas, ocorrências e ordens de serviço podem apresentar fotos
- Alterações operacionais geram registros de auditoria

## 📁 Arquivos

| Arquivo | Responsabilidade |
| --- | --- |
| `fixa_modelo.cypher` | Constraints, entidades, relacionamentos e percursos do modelo |
| `fixa_consultas.cypher` | Consultas de exploração, contagem e análise do grafo |
| `LICENSE` | Licença do projeto |

## 🧰 Tecnologias

| Área | Tecnologia |
| --- | --- |
| **Banco de grafos** | Neo4j |
| **Linguagem de consulta** | Cypher |
| **Abordagem** | Modelagem orientada a grafos |
| **Domínio** | Gestão de manutenção e ativos |

## 📄 Licença

Este projeto é distribuído sob a licença MIT. Consulte o arquivo [LICENSE](LICENSE).

---

<div align="center">
  Desenvolvido pela <strong>Fixa-Inter</strong>.
</div>
