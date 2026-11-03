// FIXA - BUSCAS

// VISUALIZACAO DO MODELO
MATCH (n:FixaModelo)
OPTIONAL MATCH (n)-[r]->(m:FixaModelo)
RETURN n, r, m;

// ATRIBUTOS DAS ENTIDADES
MATCH (n:FixaModelo)
RETURN n.nome AS entidade,
       n.rotulo AS rotulo,
       n.atributos AS atributos,
       n.tipos AS tipos,
       n.chave_primaria AS chave_primaria
ORDER BY entidade;

// CARDINALIDADES
MATCH (a:FixaModelo)-[r]->(b:FixaModelo)
RETURN a.nome AS origem,
       type(r) AS relacionamento,
       b.nome AS destino,
       r.cardinalidade_origem AS cardinalidade_origem,
       r.cardinalidade_destino AS cardinalidade_destino,
       r.papel AS papel
ORDER BY origem, destino, relacionamento, papel;

// PERCURSO DE ATRIBUICAO NO MODELO
MATCH caminho =
    (os:FixaModelo {nome: 'ordem_servico'})
    <-[:ORIGINA]-(problema:FixaModelo {nome: 'problema'})
    <-[:LOCALIZA]-(local:FixaModelo {nome: 'local_unidade'})
    <-[:CONTEM]-(unidade:FixaModelo {nome: 'unidade'})
    -[:REUNE]->(tecnico:FixaModelo {nome: 'usuario'})
    -[:POSSUI]->(aptidao:FixaModelo {nome: 'aptidao'})
RETURN caminho;

// NEGOCIO - TECNICOS APTOS PARA UMA ORDEM DE SERVICO
MATCH caminho =
    (os:OrdemServico {id: $ordem_servico_id})
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
ORDER BY nota_aptidao DESC, tecnico, tecnico_id;
