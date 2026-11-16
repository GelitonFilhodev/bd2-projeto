-- =========================================================================
-- 1. JOIN envolvendo 3 ou mais tabelas (Lista participantes, suas orgs e treinamentos)
-- =========================================================================
SELECT 
    p.nome AS funcionario,
    o.razao_social AS organizacao,
    t.nome AS treinamento,
    tu.codigo AS turma
FROM matricula m
JOIN pessoa p ON m.id_pessoa = p.id_pessoa
JOIN organizacao o ON p.id_organizacao = o.id_organizacao
JOIN turma tu ON m.id_turma = tu.id_turma
JOIN contratacao c ON tu.id_contratacao = c.id_contratacao
JOIN treinamento t ON c.id_treinamento = t.id_treinamento;


-- =========================================================================
-- 2. JOIN envolvendo 3 ou mais tabelas (Instrutores e suas turmas ministradas)
-- =========================================================================
SELECT 
    i.nome AS instrutor,
    ti.papel,
    tu.codigo AS codigo_turma,
    t.nome AS treinamento
FROM turma_instrutor ti
JOIN instrutor i ON ti.id_instrutor = i.id_instrutor
JOIN turma tu ON ti.id_turma = tu.id_turma
JOIN contratacao c ON tu.id_contratacao = c.id_contratacao
JOIN treinamento t ON c.id_treinamento = t.id_treinamento;


-- =========================================================================
-- 3. JOIN envolvendo 3 ou mais tabelas (Certificados emitidos e dados do aluno)
-- =========================================================================
SELECT 
    p.nome AS aluno,
    o.razao_social AS organizacao,
    cert.codigo_verificacao,
    cert.data_emissao
FROM certificado cert
JOIN matricula m ON cert.id_matricula = m.id_matricula
JOIN pessoa p ON m.id_pessoa = p.id_pessoa
JOIN organizacao o ON p.id_organizacao = o.id_organizacao;


-- =========================================================================
-- 4. GROUP BY e funções de agregação (Quantidade de funcionários por organização)
-- =========================================================================
SELECT 
    o.razao_social,
    COUNT(p.id_pessoa) AS total_funcionarios
FROM organizacao o
LEFT JOIN pessoa p ON o.id_organizacao = p.id_organizacao
GROUP BY o.razao_social;


-- =========================================================================
-- 5. GROUP BY e funções de agregação (Média de notas finais por treinamento)
-- =========================================================================
SELECT 
    t.nome AS treinamento,
    AVG(m.nota_final) AS media_notas,
    COUNT(m.id_matricula) AS total_matriculados
FROM treinamento t
JOIN contratacao c ON t.id_treinamento = c.id_treinamento
JOIN turma tu ON c.id_contratacao = tu.id_contratacao
JOIN matricula m ON tu.id_turma = m.id_turma
WHERE m.nota_final IS NOT NULL
GROUP BY t.nome;


-- =========================================================================
-- 6. Consulta com HAVING (Organizações com mais de 1 funcionário cadastrado)
-- =========================================================================
SELECT 
    o.razao_social,
    COUNT(p.id_pessoa) AS qtd_funcionarios
FROM organizacao o
JOIN pessoa p ON o.id_organizacao = p.id_organizacao
GROUP BY o.razao_social
HAVING COUNT(p.id_pessoa) > 0;


-- =========================================================================
-- 7. Subconsulta (Pessoas que possuem nota final superior à média geral)
-- =========================================================================
SELECT 
    p.nome,
    m.nota_final
FROM matricula m
JOIN pessoa p ON m.id_pessoa = p.id_pessoa
WHERE m.nota_final > (SELECT AVG(nota_final) FROM matricula WHERE nota_final IS NOT NULL);


-- =========================================================================
-- 8. Subconsulta (Treinamentos que possuem carga horária maior que a média)
-- =========================================================================
SELECT 
    nome,
    carga_horaria_h
FROM treinamento
WHERE carga_horaria_h > (SELECT AVG(carga_horaria_h) FROM treinamento);


-- =========================================================================
-- 9. Consulta Livre de Apoio (Contratações ativas e suas respectivas vagas)
-- =========================================================================
SELECT 
    o.razao_social,
    t.nome AS treinamento,
    c.qtd_vagas,
    c.situacao
FROM contratacao c
JOIN organizacao o ON c.id_organizacao = o.id_organizacao
JOIN treinamento t ON c.id_treinamento = t.id_treinamento
WHERE c.situacao = 'ATIVA';


-- =========================================================================
-- 10. Consulta Livre de Apoio (Relação de pré-requisitos entre treinamentos)
-- =========================================================================
SELECT 
    t1.nome AS treinamento_principal,
    t2.nome AS requisito_necessario
FROM treinamento_requisito tr
JOIN treinamento t1 ON tr.id_treinamento = t1.id_treinamento
JOIN treinamento t2 ON tr.id_treinamento_requisito = t2.id_treinamento;


