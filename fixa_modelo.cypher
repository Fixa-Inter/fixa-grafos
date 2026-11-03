// FIXA - MODELO DE GRAFOS

// IDENTIFICADORES
CREATE CONSTRAINT fixa_super_admin_identidade IF NOT EXISTS
FOR (n:SuperAdmin) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_instituicao_identidade IF NOT EXISTS
FOR (n:Instituicao) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_unidade_identidade IF NOT EXISTS
FOR (n:Unidade) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_plano_identidade IF NOT EXISTS
FOR (n:Plano) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_contrato_identidade IF NOT EXISTS
FOR (n:Contrato) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_pagamento_identidade IF NOT EXISTS
FOR (n:Pagamento) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_usuario_identidade IF NOT EXISTS
FOR (n:Usuario) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_usuario_atividade_diaria_identidade IF NOT EXISTS
FOR (n:UsuarioAtividadeDiaria) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_aptidao_identidade IF NOT EXISTS
FOR (n:Aptidao) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_feedback_identidade IF NOT EXISTS
FOR (n:Feedback) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_local_unidade_identidade IF NOT EXISTS
FOR (n:LocalUnidade) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_evento_identidade IF NOT EXISTS
FOR (n:Evento) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_categoria_equipamento_identidade IF NOT EXISTS
FOR (n:CategoriaEquipamento) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_marca_equipamento_identidade IF NOT EXISTS
FOR (n:MarcaEquipamento) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_modelo_equipamento_identidade IF NOT EXISTS
FOR (n:ModeloEquipamento) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_equipamento_identidade IF NOT EXISTS
FOR (n:Equipamento) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_problema_identidade IF NOT EXISTS
FOR (n:Problema) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_ocorrencia_identidade IF NOT EXISTS
FOR (n:Ocorrencia) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_ordem_servico_identidade IF NOT EXISTS
FOR (n:OrdemServico) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_ordem_servico_status_auditoria_identidade IF NOT EXISTS
FOR (n:OrdemServicoStatusAuditoria) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_ordem_servico_tecnico_auditoria_identidade IF NOT EXISTS
FOR (n:OrdemServicoTecnicoAuditoria) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_tarefa_identidade IF NOT EXISTS
FOR (n:Tarefa) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_observacao_conclusao_identidade IF NOT EXISTS
FOR (n:ObservacaoConclusao) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_foto_identidade IF NOT EXISTS
FOR (n:Foto) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_turno_identidade IF NOT EXISTS
FOR (n:Turno) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_pagamento_auditoria_identidade IF NOT EXISTS
FOR (n:PagamentoAuditoria) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_problema_auditoria_identidade IF NOT EXISTS
FOR (n:ProblemaAuditoria) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_usuario_auditoria_identidade IF NOT EXISTS
FOR (n:UsuarioAuditoria) REQUIRE n.id IS UNIQUE;

CREATE CONSTRAINT fixa_catalogo_dados_identidade IF NOT EXISTS
FOR (n:CatalogoDados) REQUIRE (n.esquema, n.tabela, n.coluna) IS UNIQUE;

// CHAVES ALTERNATIVAS
CREATE CONSTRAINT fixa_super_admin_email IF NOT EXISTS
FOR (n:SuperAdmin) REQUIRE n.email IS UNIQUE;

CREATE CONSTRAINT fixa_instituicao_email_corporativo IF NOT EXISTS
FOR (n:Instituicao) REQUIRE n.email_corporativo IS UNIQUE;

CREATE CONSTRAINT fixa_instituicao_dominio_email IF NOT EXISTS
FOR (n:Instituicao) REQUIRE n.dominio_email IS UNIQUE;

CREATE CONSTRAINT fixa_unidade_cnpj IF NOT EXISTS
FOR (n:Unidade) REQUIRE n.cnpj IS UNIQUE;

CREATE CONSTRAINT fixa_usuario_email IF NOT EXISTS
FOR (n:Usuario) REQUIRE n.email IS UNIQUE;

CREATE CONSTRAINT fixa_usuario_id_unidade_id IF NOT EXISTS
FOR (n:Usuario) REQUIRE (n.id, n.unidade_id) IS UNIQUE;

CREATE CONSTRAINT fixa_usuario_atividade_diaria_data_atividade_usuario_banco IF NOT EXISTS
FOR (n:UsuarioAtividadeDiaria) REQUIRE (n.data_atividade, n.usuario_banco) IS UNIQUE;

CREATE CONSTRAINT fixa_aptidao_usuario_id_categoria_problema IF NOT EXISTS
FOR (n:Aptidao) REQUIRE (n.usuario_id, n.categoria_problema) IS UNIQUE;

CREATE CONSTRAINT fixa_ordem_servico_problema_id IF NOT EXISTS
FOR (n:OrdemServico) REQUIRE n.problema_id IS UNIQUE;

// CONCLUSAO
CREATE CONSTRAINT fixa_observacao_conclusao_ordem_servico IF NOT EXISTS
FOR (n:ObservacaoConclusao) REQUIRE n.ordem_servico_id IS UNIQUE;

// PERFIL
CREATE CONSTRAINT fixa_foto_usuario IF NOT EXISTS
FOR (n:Foto) REQUIRE n.usuario_id IS UNIQUE;

// IDENTIDADE DO MODELO
CREATE CONSTRAINT fixa_modelo_nome IF NOT EXISTS
FOR (n:FixaModelo) REQUIRE n.nome IS UNIQUE;

// ENTIDADES DO MODELO

// SUPERADMIN
MERGE (n:FixaModelo {nome: "super_admin"})
SET n:ModeloSuperAdmin,
    n.rotulo = "SuperAdmin",
    n.atributos = ["id", "nome", "email", "senha_hash", "esta_ativo"],
    n.tipos = ["BIGSERIAL", "VARCHAR(100)", "VARCHAR(100)", "VARCHAR(255)", "BOOLEAN"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "nome", "email", "senha_hash", "esta_ativo"],
    n.regras = ["Equipe interna da plataforma; independente dos perfis de usuario."]
REMOVE n:SuperAdmin;

// INSTITUICAO
MERGE (n:FixaModelo {nome: "instituicao"})
SET n:ModeloInstituicao,
    n.rotulo = "Instituicao",
    n.atributos = ["id", "nome", "tipo_instituicao", "email_corporativo", "dominio_email", "data_criacao", "esta_ativo"],
    n.tipos = ["BIGSERIAL", "VARCHAR(100)", "INTEGER", "VARCHAR(100)", "VARCHAR(100)", "TIMESTAMP", "BOOLEAN"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "nome", "tipo_instituicao", "dominio_email", "data_criacao", "esta_ativo"],
    n.regras = []
REMOVE n:Instituicao;

// UNIDADE
MERGE (n:FixaModelo {nome: "unidade"})
SET n:ModeloUnidade,
    n.rotulo = "Unidade",
    n.atributos = ["id", "instituicao_id", "nome", "cnpj", "logradouro", "numero", "complemento", "bairro", "cidade", "estado", "cep", "data_criacao", "esta_ativo"],
    n.tipos = ["BIGSERIAL", "BIGINT", "VARCHAR(100)", "VARCHAR(14)", "VARCHAR(100)", "VARCHAR(10)", "VARCHAR(100)", "VARCHAR(100)", "VARCHAR(100)", "VARCHAR(2)", "VARCHAR(8)", "TIMESTAMP", "BOOLEAN"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "instituicao_id", "nome", "cnpj", "logradouro", "numero", "bairro", "cidade", "estado", "cep", "data_criacao", "esta_ativo"],
    n.regras = ["Um ou vários usuários, locais e turnos por unidade."]
REMOVE n:Unidade;

// PLANO
MERGE (n:FixaModelo {nome: "plano"})
SET n:ModeloPlano,
    n.rotulo = "Plano",
    n.atributos = ["id", "nome", "valor", "descricao", "duracao_meses", "data_criacao", "esta_ativo"],
    n.tipos = ["BIGSERIAL", "VARCHAR(100)", "DECIMAL(10, 2)", "VARCHAR(255)", "INTEGER", "TIMESTAMP", "BOOLEAN"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "nome", "valor", "duracao_meses", "data_criacao", "esta_ativo"],
    n.regras = []
REMOVE n:Plano;

// CONTRATO
MERGE (n:FixaModelo {nome: "contrato"})
SET n:ModeloContrato,
    n.rotulo = "Contrato",
    n.atributos = ["id", "plano_id", "unidade_id", "data_inicio", "data_fim", "status", "data_criacao"],
    n.tipos = ["BIGSERIAL", "BIGINT", "BIGINT", "DATE", "DATE", "INTEGER", "TIMESTAMP"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "plano_id", "unidade_id", "data_inicio", "data_fim", "status", "data_criacao"],
    n.regras = []
REMOVE n:Contrato;

// PAGAMENTO
MERGE (n:FixaModelo {nome: "pagamento"})
SET n:ModeloPagamento,
    n.rotulo = "Pagamento",
    n.atributos = ["id", "contrato_id", "data_pagamento", "valor_pago", "status", "metodo_pagamento", "data_criacao"],
    n.tipos = ["BIGSERIAL", "BIGINT", "TIMESTAMP", "DECIMAL(10, 2)", "INTEGER", "INTEGER", "TIMESTAMP"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "contrato_id", "data_pagamento", "valor_pago", "metodo_pagamento", "data_criacao"],
    n.regras = []
REMOVE n:Pagamento;

// USUARIO
MERGE (n:FixaModelo {nome: "usuario"})
SET n:ModeloUsuario,
    n.rotulo = "Usuario",
    n.atributos = ["id", "unidade_id", "nome_completo", "email", "tipo_acesso", "senha_hash", "cargo", "data_nascimento", "data_criacao", "data_atualizacao", "esta_ativo", "primeiro_acesso"],
    n.tipos = ["BIGSERIAL", "BIGINT", "VARCHAR(100)", "VARCHAR(100)", "INTEGER", "VARCHAR(255)", "VARCHAR(100)", "DATE", "TIMESTAMP", "TIMESTAMP", "BOOLEAN", "BOOLEAN"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "unidade_id", "nome_completo", "email", "tipo_acesso", "senha_hash", "cargo", "data_nascimento", "data_criacao", "esta_ativo", "primeiro_acesso"],
    n.regras = ["Perfis: 1 Administrador; 2 Gestor; 3 Técnico; 4 Solicitante.", "Zero ou uma foto de perfil por usuário."]
REMOVE n:Usuario;

// USUARIOATIVIDADEDIARIA
MERGE (n:FixaModelo {nome: "usuario_atividade_diaria"})
SET n:ModeloUsuarioAtividadeDiaria,
    n.rotulo = "UsuarioAtividadeDiaria",
    n.atributos = ["id", "usuario_banco", "data_atividade"],
    n.tipos = ["BIGSERIAL", "TEXT", "DATE"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "usuario_banco", "data_atividade"],
    n.regras = ["Conta PostgreSQL por dia; usuario_banco não é FK para usuario do aplicativo."]
REMOVE n:UsuarioAtividadeDiaria;

// APTIDAO
MERGE (n:FixaModelo {nome: "aptidao"})
SET n:ModeloAptidao,
    n.rotulo = "Aptidao",
    n.atributos = ["id", "usuario_id", "categoria_problema", "nota", "data_criacao", "esta_ativo"],
    n.tipos = ["BIGSERIAL", "BIGINT", "INTEGER", "DECIMAL(4, 2)", "TIMESTAMP", "BOOLEAN"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "usuario_id", "categoria_problema", "nota", "data_criacao", "esta_ativo"],
    n.regras = ["Uma aptidão por usuário e categoria; no máximo dez por usuário."]
REMOVE n:Aptidao;

// FEEDBACK
MERGE (n:FixaModelo {nome: "feedback"})
SET n:ModeloFeedback,
    n.rotulo = "Feedback",
    n.atributos = ["id", "usuario_id", "comentario", "ideia_central", "data_criacao"],
    n.tipos = ["BIGSERIAL", "BIGINT", "VARCHAR(255)", "VARCHAR(255)", "TIMESTAMP"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "usuario_id", "data_criacao"],
    n.regras = []
REMOVE n:Feedback;

// LOCALUNIDADE
MERGE (n:FixaModelo {nome: "local_unidade"})
SET n:ModeloLocalUnidade,
    n.rotulo = "LocalUnidade",
    n.atributos = ["id", "unidade_id", "nome", "tipo_local_unidade", "descricao", "data_criacao", "data_atualizacao", "esta_ativo"],
    n.tipos = ["BIGSERIAL", "BIGINT", "VARCHAR(100)", "INTEGER", "VARCHAR(255)", "TIMESTAMP", "TIMESTAMP", "BOOLEAN"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "unidade_id", "nome", "tipo_local_unidade", "descricao", "data_criacao", "esta_ativo"],
    n.regras = []
REMOVE n:LocalUnidade;

// EVENTO
MERGE (n:FixaModelo {nome: "evento"})
SET n:ModeloEvento,
    n.rotulo = "Evento",
    n.atributos = ["id", "usuario_id", "local_unidade_id", "titulo", "descricao", "descricao_local", "observacao", "data_hora_inicio", "data_hora_fim", "data_criacao", "data_atualizacao", "esta_ativo"],
    n.tipos = ["BIGSERIAL", "BIGINT", "BIGINT", "VARCHAR(100)", "VARCHAR(255)", "VARCHAR(255)", "VARCHAR(255)", "TIMESTAMP", "TIMESTAMP", "TIMESTAMP", "TIMESTAMP", "BOOLEAN"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "usuario_id", "local_unidade_id", "titulo", "descricao", "descricao_local", "data_hora_inicio", "data_hora_fim", "data_criacao", "esta_ativo"],
    n.regras = []
REMOVE n:Evento;

// CATEGORIAEQUIPAMENTO
MERGE (n:FixaModelo {nome: "categoria_equipamento"})
SET n:ModeloCategoriaEquipamento,
    n.rotulo = "CategoriaEquipamento",
    n.atributos = ["id", "usuario_id", "nome", "descricao", "data_criacao", "data_atualizacao", "esta_ativo"],
    n.tipos = ["BIGSERIAL", "BIGINT", "VARCHAR(100)", "VARCHAR(255)", "TIMESTAMP", "TIMESTAMP", "BOOLEAN"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "usuario_id", "nome", "descricao", "data_criacao", "esta_ativo"],
    n.regras = []
REMOVE n:CategoriaEquipamento;

// MARCAEQUIPAMENTO
MERGE (n:FixaModelo {nome: "marca_equipamento"})
SET n:ModeloMarcaEquipamento,
    n.rotulo = "MarcaEquipamento",
    n.atributos = ["id", "nome", "descricao", "data_criacao", "data_atualizacao", "esta_ativo"],
    n.tipos = ["BIGSERIAL", "VARCHAR(100)", "VARCHAR(255)", "TIMESTAMP", "TIMESTAMP", "BOOLEAN"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "nome", "descricao", "data_criacao", "esta_ativo"],
    n.regras = []
REMOVE n:MarcaEquipamento;

// MODELOEQUIPAMENTO
MERGE (n:FixaModelo {nome: "modelo_equipamento"})
SET n:ModeloModeloEquipamento,
    n.rotulo = "ModeloEquipamento",
    n.atributos = ["id", "marca_equipamento_id", "categoria_equipamento_id", "nome", "descricao", "data_criacao", "data_atualizacao", "esta_ativo"],
    n.tipos = ["BIGSERIAL", "BIGINT", "BIGINT", "VARCHAR(100)", "VARCHAR(255)", "TIMESTAMP", "TIMESTAMP", "BOOLEAN"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "marca_equipamento_id", "categoria_equipamento_id", "nome", "descricao", "data_criacao", "esta_ativo"],
    n.regras = []
REMOVE n:ModeloEquipamento;

// EQUIPAMENTO
MERGE (n:FixaModelo {nome: "equipamento"})
SET n:ModeloEquipamento,
    n.rotulo = "Equipamento",
    n.atributos = ["id", "usuario_id", "modelo_equipamento_id", "local_unidade_id", "codigo", "data_criacao", "data_atualizacao", "esta_ativo"],
    n.tipos = ["BIGSERIAL", "BIGINT", "BIGINT", "BIGINT", "VARCHAR(100)", "TIMESTAMP", "TIMESTAMP", "BOOLEAN"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "usuario_id", "modelo_equipamento_id", "local_unidade_id", "codigo", "data_criacao", "esta_ativo"],
    n.regras = []
REMOVE n:Equipamento;

// PROBLEMA
MERGE (n:FixaModelo {nome: "problema"})
SET n:ModeloProblema,
    n.rotulo = "Problema",
    n.atributos = ["id", "usuario_id", "categoria_equipamento_id", "local_unidade_id", "titulo", "descricao_problema", "descricao_local", "motivo_recusa", "data_criacao", "data_atualizacao", "esta_ativo", "status"],
    n.tipos = ["BIGSERIAL", "BIGINT", "BIGINT", "BIGINT", "VARCHAR(100)", "VARCHAR(255)", "VARCHAR(255)", "VARCHAR(255)", "TIMESTAMP", "TIMESTAMP", "BOOLEAN", "INTEGER"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "usuario_id", "categoria_equipamento_id", "local_unidade_id", "titulo", "descricao_problema", "descricao_local", "data_criacao", "esta_ativo", "status"],
    n.regras = ["Uma ou várias fotos por problema."]
REMOVE n:Problema;

// OCORRENCIA
MERGE (n:FixaModelo {nome: "ocorrencia"})
SET n:ModeloOcorrencia,
    n.rotulo = "Ocorrencia",
    n.atributos = ["id", "usuario_id", "local_unidade_id", "categoria_equipamento_id", "categoria_problema", "titulo", "descricao_ocorrencia", "descricao_local", "prioridade", "data_criacao", "data_atualizacao", "esta_ativo"],
    n.tipos = ["BIGSERIAL", "BIGINT", "BIGINT", "BIGINT", "INTEGER", "VARCHAR(100)", "VARCHAR(255)", "VARCHAR(255)", "INTEGER", "TIMESTAMP", "TIMESTAMP", "BOOLEAN"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "usuario_id", "local_unidade_id", "categoria_equipamento_id", "categoria_problema", "titulo", "descricao_ocorrencia", "descricao_local", "prioridade", "data_criacao", "esta_ativo"],
    n.regras = []
REMOVE n:Ocorrencia;

// ORDEMSERVICO
MERGE (n:FixaModelo {nome: "ordem_servico"})
SET n:ModeloOrdemServico,
    n.rotulo = "OrdemServico",
    n.atributos = ["id", "problema_id", "usuario_id", "status_ordem_servico", "categoria_problema", "data_prevista", "prioridade", "data_criacao", "data_atualizacao", "esta_ativo"],
    n.tipos = ["BIGSERIAL", "BIGINT", "BIGINT", "INTEGER", "INTEGER", "TIMESTAMP", "INTEGER", "TIMESTAMP", "TIMESTAMP", "BOOLEAN"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "problema_id", "usuario_id", "status_ordem_servico", "categoria_problema", "data_prevista", "prioridade", "data_criacao", "esta_ativo"],
    n.regras = ["Cada problema origina zero ou uma OS.", "Cada OS possui um responsável atual e zero ou uma observação de conclusão.", "Na finalização da OS, a observação de conclusão é obrigatória."]
REMOVE n:OrdemServico;

// ORDEMSERVICOSTATUSAUDITORIA
MERGE (n:FixaModelo {nome: "ordem_servico_status_auditoria"})
SET n:ModeloOrdemServicoStatusAuditoria,
    n.rotulo = "OrdemServicoStatusAuditoria",
    n.atributos = ["id", "ordem_servico_id", "status_anterior", "status_novo", "data_alteracao"],
    n.tipos = ["BIGSERIAL", "BIGINT", "INTEGER", "INTEGER", "TIMESTAMP"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "ordem_servico_id", "status_anterior", "status_novo", "data_alteracao"],
    n.regras = []
REMOVE n:OrdemServicoStatusAuditoria;

// ORDEMSERVICOTECNICOAUDITORIA
MERGE (n:FixaModelo {nome: "ordem_servico_tecnico_auditoria"})
SET n:ModeloOrdemServicoTecnicoAuditoria,
    n.rotulo = "OrdemServicoTecnicoAuditoria",
    n.atributos = ["id", "ordem_servico_id", "tecnico_anterior_id", "tecnico_novo_id", "data_alteracao"],
    n.tipos = ["BIGSERIAL", "BIGINT", "BIGINT", "BIGINT", "TIMESTAMP"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "ordem_servico_id", "tecnico_anterior_id", "tecnico_novo_id", "data_alteracao"],
    n.regras = []
REMOVE n:OrdemServicoTecnicoAuditoria;

// TAREFA
MERGE (n:FixaModelo {nome: "tarefa"})
SET n:ModeloTarefa,
    n.rotulo = "Tarefa",
    n.atributos = ["id", "ordem_servico_id", "status_ordem_servico", "titulo", "descricao", "data_criacao", "data_atualizacao", "esta_ativo"],
    n.tipos = ["BIGSERIAL", "BIGINT", "INTEGER", "VARCHAR(100)", "VARCHAR(255)", "TIMESTAMP", "TIMESTAMP", "BOOLEAN"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "ordem_servico_id", "status_ordem_servico", "titulo", "descricao", "data_criacao", "esta_ativo"],
    n.regras = []
REMOVE n:Tarefa;

// OBSERVACAOCONCLUSAO
MERGE (n:FixaModelo {nome: "observacao_conclusao"})
SET n:ModeloObservacaoConclusao,
    n.rotulo = "ObservacaoConclusao",
    n.atributos = ["id", "ordem_servico_id", "dificuldade", "observacao", "data_criacao", "data_atualizacao", "esta_ativo"],
    n.tipos = ["BIGSERIAL", "BIGINT", "INTEGER", "VARCHAR(255)", "TIMESTAMP", "TIMESTAMP", "BOOLEAN"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "ordem_servico_id", "dificuldade", "observacao", "data_criacao", "esta_ativo"],
    n.regras = ["Uma ou várias fotos por observação de conclusão."]
REMOVE n:ObservacaoConclusao;

// FOTO
MERGE (n:FixaModelo {nome: "foto"})
SET n:ModeloFoto,
    n.rotulo = "Foto",
    n.atributos = ["id", "problema_id", "ocorrencia_id", "ordem_servico_id", "observacao_conclusao_id", "usuario_id", "url", "esta_ativo", "data_criacao"],
    n.tipos = ["BIGSERIAL", "BIGINT", "BIGINT", "BIGINT", "BIGINT", "BIGINT", "VARCHAR(255)", "BOOLEAN", "TIMESTAMP"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "url", "esta_ativo", "data_criacao"],
    n.regras = ["Cada foto pertence a exatamente um problema, ocorrência, OS, observação de conclusão ou usuário."]
REMOVE n:Foto;

// TURNO
MERGE (n:FixaModelo {nome: "turno"})
SET n:ModeloTurno,
    n.rotulo = "Turno",
    n.atributos = ["id", "unidade_id", "nome", "hora_inicio", "hora_fim", "atravessa_meia_noite", "data_criacao", "esta_ativo"],
    n.tipos = ["BIGSERIAL", "BIGINT", "VARCHAR(100)", "INTEGER", "INTEGER", "BOOLEAN", "TIMESTAMP", "BOOLEAN"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "unidade_id", "nome", "hora_inicio", "hora_fim", "atravessa_meia_noite", "data_criacao", "esta_ativo"],
    n.regras = []
REMOVE n:Turno;

// PAGAMENTOAUDITORIA
MERGE (n:FixaModelo {nome: "pagamento_auditoria"})
SET n:ModeloPagamentoAuditoria,
    n.rotulo = "PagamentoAuditoria",
    n.atributos = ["id", "pagamento_id", "operacao", "dados_anteriores", "dados_novos", "data_alteracao"],
    n.tipos = ["BIGSERIAL", "BIGINT", "TEXT", "JSONB", "JSONB", "TIMESTAMP"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "pagamento_id", "operacao", "data_alteracao"],
    n.regras = ["pagamento_id é histórico e não possui FK; a auditoria pode sobreviver ao registro original."]
REMOVE n:PagamentoAuditoria;

// PROBLEMAAUDITORIA
MERGE (n:FixaModelo {nome: "problema_auditoria"})
SET n:ModeloProblemaAuditoria,
    n.rotulo = "ProblemaAuditoria",
    n.atributos = ["id", "problema_id", "operacao", "dados_anteriores", "dados_novos", "data_alteracao"],
    n.tipos = ["BIGSERIAL", "BIGINT", "TEXT", "JSONB", "JSONB", "TIMESTAMP"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "problema_id", "operacao", "data_alteracao"],
    n.regras = ["problema_id é histórico e não possui FK; a auditoria pode sobreviver ao registro original."]
REMOVE n:ProblemaAuditoria;

// USUARIOAUDITORIA
MERGE (n:FixaModelo {nome: "usuario_auditoria"})
SET n:ModeloUsuarioAuditoria,
    n.rotulo = "UsuarioAuditoria",
    n.atributos = ["id", "usuario_id", "operacao", "dados_anteriores", "dados_novos", "data_alteracao"],
    n.tipos = ["BIGSERIAL", "BIGINT", "TEXT", "JSONB", "JSONB", "TIMESTAMP"],
    n.chave_primaria = ["id"],
    n.obrigatorios = ["id", "usuario_id", "operacao", "data_alteracao"],
    n.regras = ["usuario_id é histórico e não possui FK; a auditoria pode sobreviver ao registro original."]
REMOVE n:UsuarioAuditoria;

// CATALOGODADOS
MERGE (n:FixaModelo {nome: "catalogo_dados"})
SET n:ModeloCatalogoDados,
    n.rotulo = "CatalogoDados",
    n.atributos = ["esquema", "tabela", "coluna", "descricao_tabela", "descricao_coluna", "tipo_dado", "aceita_nulo", "valor_padrao", "regras_banco", "regras_negocio", "nivel_acesso", "atualizado_em"],
    n.tipos = ["TEXT", "TEXT", "TEXT", "TEXT", "TEXT", "TEXT", "BOOLEAN", "TEXT", "TEXT", "TEXT", "TEXT", "TIMESTAMPTZ"],
    n.chave_primaria = ["esquema", "tabela", "coluna"],
    n.obrigatorios = ["esquema", "tabela", "coluna", "descricao_tabela", "descricao_coluna", "tipo_dado", "aceita_nulo", "regras_negocio", "nivel_acesso", "atualizado_em"],
    n.regras = ["Identidade composta por esquema, tabela e coluna."]
REMOVE n:CatalogoDados;

// RELACIONAMENTOS DO MODELO

// INSTITUICAO - POSSUI - UNIDADE
MATCH (origem:FixaModelo {nome: "instituicao"})
MATCH (destino:FixaModelo {nome: "unidade"})
MERGE (origem)-[r:POSSUI {vinculo: "unidade.instituicao_id"}]->(destino)
SET r.origem = "instituicao",
    r.destino = "unidade",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// UNIDADE - FIRMA - CONTRATO
MATCH (origem:FixaModelo {nome: "unidade"})
MATCH (destino:FixaModelo {nome: "contrato"})
MERGE (origem)-[r:FIRMA {vinculo: "contrato.unidade_id"}]->(destino)
SET r.origem = "unidade",
    r.destino = "contrato",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// PLANO - FUNDAMENTA - CONTRATO
MATCH (origem:FixaModelo {nome: "plano"})
MATCH (destino:FixaModelo {nome: "contrato"})
MERGE (origem)-[r:FUNDAMENTA {vinculo: "contrato.plano_id"}]->(destino)
SET r.origem = "plano",
    r.destino = "contrato",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// CONTRATO - RECEBE - PAGAMENTO
MATCH (origem:FixaModelo {nome: "contrato"})
MATCH (destino:FixaModelo {nome: "pagamento"})
MERGE (origem)-[r:RECEBE {vinculo: "pagamento.contrato_id"}]->(destino)
SET r.origem = "contrato",
    r.destino = "pagamento",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// UNIDADE - REUNE - USUARIO
MATCH (origem:FixaModelo {nome: "unidade"})
MATCH (destino:FixaModelo {nome: "usuario"})
MERGE (origem)-[r:REUNE {vinculo: "usuario.unidade_id"}]->(destino)
SET r.origem = "unidade",
    r.destino = "usuario",
    r.cardinalidade_origem = "1,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// UNIDADE - CONTEM - LOCALUNIDADE
MATCH (origem:FixaModelo {nome: "unidade"})
MATCH (destino:FixaModelo {nome: "local_unidade"})
MERGE (origem)-[r:CONTEM {vinculo: "local_unidade.unidade_id"}]->(destino)
SET r.origem = "unidade",
    r.destino = "local_unidade",
    r.cardinalidade_origem = "1,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// UNIDADE - OFERECE - TURNO
MATCH (origem:FixaModelo {nome: "unidade"})
MATCH (destino:FixaModelo {nome: "turno"})
MERGE (origem)-[r:OFERECE {vinculo: "turno.unidade_id"}]->(destino)
SET r.origem = "unidade",
    r.destino = "turno",
    r.cardinalidade_origem = "1,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// USUARIO - PARTICIPA - TURNO
MATCH (origem:FixaModelo {nome: "usuario"})
MATCH (destino:FixaModelo {nome: "turno"})
MERGE (origem)-[r:PARTICIPA {vinculo: "turno_usuario"}]->(destino)
SET r.origem = "usuario",
    r.destino = "turno",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "0,n",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "0,n",
    r.tabela_associativa = "turno_usuario",
    r.atributos = ["id", "turno_id", "usuario_id", "data_criacao", "esta_ativo"],
    r.tipos = ["BIGSERIAL", "BIGINT", "BIGINT", "TIMESTAMP", "BOOLEAN"],
    r.chave_primaria = ["id"],
    r.obrigatorios = ["id", "turno_id", "usuario_id", "data_criacao", "esta_ativo"],
    r.regras = ["Um único vínculo por par usuário/turno."];

// USUARIO - POSSUI - APTIDAO
MATCH (origem:FixaModelo {nome: "usuario"})
MATCH (destino:FixaModelo {nome: "aptidao"})
MERGE (origem)-[r:POSSUI {vinculo: "aptidao.usuario_id"}]->(destino)
SET r.origem = "usuario",
    r.destino = "aptidao",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// USUARIO - ENVIA - FEEDBACK
MATCH (origem:FixaModelo {nome: "usuario"})
MATCH (destino:FixaModelo {nome: "feedback"})
MERGE (origem)-[r:ENVIA {vinculo: "feedback.usuario_id"}]->(destino)
SET r.origem = "usuario",
    r.destino = "feedback",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// USUARIO - REGISTRA - EVENTO
MATCH (origem:FixaModelo {nome: "usuario"})
MATCH (destino:FixaModelo {nome: "evento"})
MERGE (origem)-[r:REGISTRA {vinculo: "evento.usuario_id"}]->(destino)
SET r.origem = "usuario",
    r.destino = "evento",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// LOCALUNIDADE - SEDIA - EVENTO
MATCH (origem:FixaModelo {nome: "local_unidade"})
MATCH (destino:FixaModelo {nome: "evento"})
MERGE (origem)-[r:SEDIA {vinculo: "evento.local_unidade_id"}]->(destino)
SET r.origem = "local_unidade",
    r.destino = "evento",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// USUARIO - CADASTRA - CATEGORIAEQUIPAMENTO
MATCH (origem:FixaModelo {nome: "usuario"})
MATCH (destino:FixaModelo {nome: "categoria_equipamento"})
MERGE (origem)-[r:CADASTRA {vinculo: "categoria_equipamento.usuario_id"}]->(destino)
SET r.origem = "usuario",
    r.destino = "categoria_equipamento",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// MARCAEQUIPAMENTO - IDENTIFICA - MODELOEQUIPAMENTO
MATCH (origem:FixaModelo {nome: "marca_equipamento"})
MATCH (destino:FixaModelo {nome: "modelo_equipamento"})
MERGE (origem)-[r:IDENTIFICA {vinculo: "modelo_equipamento.marca_equipamento_id"}]->(destino)
SET r.origem = "marca_equipamento",
    r.destino = "modelo_equipamento",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// CATEGORIAEQUIPAMENTO - CLASSIFICA - MODELOEQUIPAMENTO
MATCH (origem:FixaModelo {nome: "categoria_equipamento"})
MATCH (destino:FixaModelo {nome: "modelo_equipamento"})
MERGE (origem)-[r:CLASSIFICA {vinculo: "modelo_equipamento.categoria_equipamento_id"}]->(destino)
SET r.origem = "categoria_equipamento",
    r.destino = "modelo_equipamento",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// USUARIO - VINCULA - EQUIPAMENTO
MATCH (origem:FixaModelo {nome: "usuario"})
MATCH (destino:FixaModelo {nome: "equipamento"})
MERGE (origem)-[r:VINCULA {vinculo: "equipamento.usuario_id"}]->(destino)
SET r.origem = "usuario",
    r.destino = "equipamento",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// MODELOEQUIPAMENTO - ESPECIFICA - EQUIPAMENTO
MATCH (origem:FixaModelo {nome: "modelo_equipamento"})
MATCH (destino:FixaModelo {nome: "equipamento"})
MERGE (origem)-[r:ESPECIFICA {vinculo: "equipamento.modelo_equipamento_id"}]->(destino)
SET r.origem = "modelo_equipamento",
    r.destino = "equipamento",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// LOCALUNIDADE - ABRIGA - EQUIPAMENTO
MATCH (origem:FixaModelo {nome: "local_unidade"})
MATCH (destino:FixaModelo {nome: "equipamento"})
MERGE (origem)-[r:ABRIGA {vinculo: "equipamento.local_unidade_id"}]->(destino)
SET r.origem = "local_unidade",
    r.destino = "equipamento",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// USUARIO - RELATA - PROBLEMA
MATCH (origem:FixaModelo {nome: "usuario"})
MATCH (destino:FixaModelo {nome: "problema"})
MERGE (origem)-[r:RELATA {vinculo: "problema.usuario_id"}]->(destino)
SET r.origem = "usuario",
    r.destino = "problema",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// LOCALUNIDADE - LOCALIZA - PROBLEMA
MATCH (origem:FixaModelo {nome: "local_unidade"})
MATCH (destino:FixaModelo {nome: "problema"})
MERGE (origem)-[r:LOCALIZA {vinculo: "problema.local_unidade_id"}]->(destino)
SET r.origem = "local_unidade",
    r.destino = "problema",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// CATEGORIAEQUIPAMENTO - CLASSIFICA - PROBLEMA
MATCH (origem:FixaModelo {nome: "categoria_equipamento"})
MATCH (destino:FixaModelo {nome: "problema"})
MERGE (origem)-[r:CLASSIFICA {vinculo: "problema.categoria_equipamento_id"}]->(destino)
SET r.origem = "categoria_equipamento",
    r.destino = "problema",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// USUARIO - REGISTRA - OCORRENCIA
MATCH (origem:FixaModelo {nome: "usuario"})
MATCH (destino:FixaModelo {nome: "ocorrencia"})
MERGE (origem)-[r:REGISTRA {vinculo: "ocorrencia.usuario_id"}]->(destino)
SET r.origem = "usuario",
    r.destino = "ocorrencia",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// LOCALUNIDADE - LOCALIZA - OCORRENCIA
MATCH (origem:FixaModelo {nome: "local_unidade"})
MATCH (destino:FixaModelo {nome: "ocorrencia"})
MERGE (origem)-[r:LOCALIZA {vinculo: "ocorrencia.local_unidade_id"}]->(destino)
SET r.origem = "local_unidade",
    r.destino = "ocorrencia",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// CATEGORIAEQUIPAMENTO - CLASSIFICA - OCORRENCIA
MATCH (origem:FixaModelo {nome: "categoria_equipamento"})
MATCH (destino:FixaModelo {nome: "ocorrencia"})
MERGE (origem)-[r:CLASSIFICA {vinculo: "ocorrencia.categoria_equipamento_id"}]->(destino)
SET r.origem = "categoria_equipamento",
    r.destino = "ocorrencia",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// PROBLEMA - ORIGINA - ORDEMSERVICO
MATCH (origem:FixaModelo {nome: "problema"})
MATCH (destino:FixaModelo {nome: "ordem_servico"})
MERGE (origem)-[r:ORIGINA {vinculo: "ordem_servico.problema_id"}]->(destino)
SET r.origem = "problema",
    r.destino = "ordem_servico",
    r.cardinalidade_origem = "0,1",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,1",
    r.cardinalidade_sql_destino = "1,1";

// USUARIO - ASSUME - ORDEMSERVICO
MATCH (origem:FixaModelo {nome: "usuario"})
MATCH (destino:FixaModelo {nome: "ordem_servico"})
MERGE (origem)-[r:ASSUME {vinculo: "ordem_servico.usuario_id"}]->(destino)
SET r.origem = "usuario",
    r.destino = "ordem_servico",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// ORDEMSERVICO - CONTEM - TAREFA
MATCH (origem:FixaModelo {nome: "ordem_servico"})
MATCH (destino:FixaModelo {nome: "tarefa"})
MERGE (origem)-[r:CONTEM {vinculo: "tarefa.ordem_servico_id"}]->(destino)
SET r.origem = "ordem_servico",
    r.destino = "tarefa",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// ORDEMSERVICO - RECEBE - OBSERVACAOCONCLUSAO
MATCH (origem:FixaModelo {nome: "ordem_servico"})
MATCH (destino:FixaModelo {nome: "observacao_conclusao"})
MERGE (origem)-[r:RECEBE {vinculo: "observacao_conclusao.ordem_servico_id"}]->(destino)
SET r.origem = "ordem_servico",
    r.destino = "observacao_conclusao",
    r.cardinalidade_origem = "0,1",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// PROBLEMA - APRESENTA - FOTO
MATCH (origem:FixaModelo {nome: "problema"})
MATCH (destino:FixaModelo {nome: "foto"})
MERGE (origem)-[r:APRESENTA {vinculo: "foto.problema_id"}]->(destino)
SET r.origem = "problema",
    r.destino = "foto",
    r.cardinalidade_origem = "1,n",
    r.cardinalidade_destino = "0,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "0,1";

// OCORRENCIA - APRESENTA - FOTO
MATCH (origem:FixaModelo {nome: "ocorrencia"})
MATCH (destino:FixaModelo {nome: "foto"})
MERGE (origem)-[r:APRESENTA {vinculo: "foto.ocorrencia_id"}]->(destino)
SET r.origem = "ocorrencia",
    r.destino = "foto",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "0,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "0,1";

// ORDEMSERVICO - APRESENTA - FOTO
MATCH (origem:FixaModelo {nome: "ordem_servico"})
MATCH (destino:FixaModelo {nome: "foto"})
MERGE (origem)-[r:APRESENTA {vinculo: "foto.ordem_servico_id"}]->(destino)
SET r.origem = "ordem_servico",
    r.destino = "foto",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "0,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "0,1";

// OBSERVACAOCONCLUSAO - APRESENTA - FOTO
MATCH (origem:FixaModelo {nome: "observacao_conclusao"})
MATCH (destino:FixaModelo {nome: "foto"})
MERGE (origem)-[r:APRESENTA {vinculo: "foto.observacao_conclusao_id"}]->(destino)
SET r.origem = "observacao_conclusao",
    r.destino = "foto",
    r.cardinalidade_origem = "1,n",
    r.cardinalidade_destino = "0,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "0,1";

// USUARIO - POSSUI - FOTO
MATCH (origem:FixaModelo {nome: "usuario"})
MATCH (destino:FixaModelo {nome: "foto"})
MERGE (origem)-[r:POSSUI {vinculo: "foto.usuario_id"}]->(destino)
SET r.origem = "usuario",
    r.destino = "foto",
    r.cardinalidade_origem = "0,1",
    r.cardinalidade_destino = "0,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "0,1";

// ORDEMSERVICO - REGISTRA - ORDEMSERVICOSTATUSAUDITORIA
MATCH (origem:FixaModelo {nome: "ordem_servico"})
MATCH (destino:FixaModelo {nome: "ordem_servico_status_auditoria"})
MERGE (origem)-[r:REGISTRA {vinculo: "ordem_servico_status_auditoria.ordem_servico_id"}]->(destino)
SET r.origem = "ordem_servico",
    r.destino = "ordem_servico_status_auditoria",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// ORDEMSERVICO - REGISTRA - ORDEMSERVICOTECNICOAUDITORIA
MATCH (origem:FixaModelo {nome: "ordem_servico"})
MATCH (destino:FixaModelo {nome: "ordem_servico_tecnico_auditoria"})
MERGE (origem)-[r:REGISTRA {vinculo: "ordem_servico_tecnico_auditoria.ordem_servico_id"}]->(destino)
SET r.origem = "ordem_servico",
    r.destino = "ordem_servico_tecnico_auditoria",
    r.cardinalidade_origem = "0,n",
    r.cardinalidade_destino = "1,1",
    r.cardinalidade_sql_origem = "0,n",
    r.cardinalidade_sql_destino = "1,1";

// ORDEMSERVICOTECNICOAUDITORIA - REFERENCIA - USUARIO
MATCH (origem:FixaModelo {nome: "ordem_servico_tecnico_auditoria"})
MATCH (destino:FixaModelo {nome: "usuario"})
MERGE (origem)-[r:REFERENCIA {vinculo: "ordem_servico_tecnico_auditoria.tecnico_anterior_id"}]->(destino)
SET r.origem = "ordem_servico_tecnico_auditoria",
    r.destino = "usuario",
    r.cardinalidade_origem = "1,1",
    r.cardinalidade_destino = "0,n",
    r.cardinalidade_sql_origem = "1,1",
    r.cardinalidade_sql_destino = "0,n",
    r.papel = "tecnico_anterior";

// ORDEMSERVICOTECNICOAUDITORIA - REFERENCIA - USUARIO
MATCH (origem:FixaModelo {nome: "ordem_servico_tecnico_auditoria"})
MATCH (destino:FixaModelo {nome: "usuario"})
MERGE (origem)-[r:REFERENCIA {vinculo: "ordem_servico_tecnico_auditoria.tecnico_novo_id"}]->(destino)
SET r.origem = "ordem_servico_tecnico_auditoria",
    r.destino = "usuario",
    r.cardinalidade_origem = "1,1",
    r.cardinalidade_destino = "0,n",
    r.cardinalidade_sql_origem = "1,1",
    r.cardinalidade_sql_destino = "0,n",
    r.papel = "tecnico_novo";

// VISUALIZACAO DO MODELO
MATCH (n:FixaModelo)
OPTIONAL MATCH (n)-[r]->(m:FixaModelo)
RETURN n, r, m;

// PERCURSO DE ATRIBUICAO NO MODELO
MATCH caminho =
    (os:FixaModelo {nome: 'ordem_servico'})
    <-[:ORIGINA]-(problema:FixaModelo {nome: 'problema'})
    <-[:LOCALIZA]-(local:FixaModelo {nome: 'local_unidade'})
    <-[:CONTEM]-(unidade:FixaModelo {nome: 'unidade'})
    -[:REUNE]->(tecnico:FixaModelo {nome: 'usuario'})
    -[:POSSUI]->(aptidao:FixaModelo {nome: 'aptidao'})
RETURN caminho;

// NEGOCIO - TECNICOS APTOS POR ORDEM DE SERVICO
MATCH caminho =
    (os:OrdemServico)
    <-[:ORIGINA]-(problema:Problema)
    <-[:LOCALIZA]-(local:LocalUnidade)
    <-[:CONTEM]-(unidade:Unidade)
    -[:REUNE]->(tecnico:Usuario)
    -[:POSSUI]->(aptidao:Aptidao)
WHERE tecnico.tipo_acesso = 3
  AND tecnico.esta_ativo = true
  AND aptidao.esta_ativo = true
  AND unidade.esta_ativo = true
  AND local.esta_ativo = true
  AND problema.esta_ativo = true
  AND os.esta_ativo = true
  AND aptidao.categoria_problema = os.categoria_problema
RETURN DISTINCT
    os.id AS ordem_servico_id,
    problema.titulo AS problema,
    unidade.nome AS unidade,
    tecnico.id AS tecnico_id,
    tecnico.nome_completo AS tecnico,
    aptidao.nota AS nota_aptidao,
    caminho
ORDER BY ordem_servico_id, nota_aptidao DESC, tecnico, tecnico_id;
