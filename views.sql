SET TERM ^ ;

-- View 1: Resumo operacional de turmas e ocupação de vagas
CREATE OR ALTER VIEW vw_resumo_turmas AS
SELECT 
    tu.id_turma,
    tu.codigo AS codigo_turma,
    t.nome AS treinamento,
    tu.data_inicio,
    tu.data_fim,
    tu.capacidade,
    (SELECT COUNT(*) FROM matricula m WHERE m.id_turma = tu.id_turma) AS total_matriculados,
    tu.situacao
FROM turma tu
JOIN contratacao c ON tu.id_contratacao = c.id_contratacao
JOIN treinamento t ON c.id_treinamento = t.id_treinamento^

-- View 2: Histórico detalhado de capacitações por participante
CREATE OR ALTER VIEW vw_historico_participante AS
SELECT 
    p.id_pessoa,
    p.nome AS funcionario,
    o.razao_social AS organizacao,
    t.nome AS treinamento,
    tu.codigo AS turma,
    m.data_matricula,
    m.situacao AS situacao_matricula,
    m.nota_final
FROM matricula m
JOIN pessoa p ON m.id_pessoa = p.id_pessoa
JOIN organizacao o ON p.id_organizacao = o.id_organizacao
JOIN turma tu ON m.id_turma = tu.id_turma
JOIN contratacao c ON tu.id_contratacao = c.id_contratacao
JOIN treinamento t ON c.id_treinamento = t.id_treinamento^

SET TERM ; ^