-- =========================================================================
-- ÍNDICE 1: Otimização de busca de matrículas por turma
-- =========================================================================
-- Justificativa: A consulta e contagem de alunos matriculados em uma turma 
-- (utilizada em views operacionais e validações de capacidade) é altamente 
-- recorrente. Indexar a chave estrangeira id_turma na tabela matricula acelera 
-- os joins e contagens frequentes sem sobrecarregar o SGBD.
CREATE INDEX idx_matricula_turma ON matricula (id_turma);


-- =========================================================================
-- ÍNDICE 2: Otimização de filtro por data de início de turmas
-- =========================================================================
-- Justificativa: Relatórios gerenciais e consultas de turmas ativas costumam 
-- filtrar e ordenar os registros por período de realização (data_inicio). 
-- A criação deste índice reduz o custo de varredura sequencial (PLAN NATURAL) 
-- na tabela de turmas.
CREATE INDEX idx_turma_data_inicio ON turma (data_inicio);