-- =========================================================================
-- CASO TRANSACIONAL: Registro de nova contratação com a turma correspondente
-- =========================================================================
-- Operações: (1) inserir a contratação; (2) inserir a turma ligada a ela.
-- Por que atômico: uma contratação sem turma (ou uma turma apontando para
-- uma contratação inexistente) deixa o banco inconsistente. Ou as duas
-- operações são gravadas, ou nenhuma.

-- ---------- Caso 1: COMMIT (tudo certo) ----------
SET TRANSACTION;

INSERT INTO contratacao (id_contratacao, id_organizacao, id_treinamento, data_contratacao, qtd_vagas, situacao)
VALUES (99, 1, 1, CURRENT_DATE, 10, 'ATIVA');

INSERT INTO turma (id_turma, id_contratacao, codigo, data_inicio, data_fim,
                   local_realizacao, capacidade, permite_turma_mista, situacao)
VALUES (99, 99, 'NR10-2026-D', '2026-12-07', '2026-12-09',
        'Auditório Vale Verde', 10, FALSE, 'PLANEJADA');

COMMIT;

SELECT id_contratacao FROM contratacao WHERE id_contratacao = 99;  -- retorna 1 linha
SELECT id_turma FROM turma WHERE id_turma = 99;                    -- retorna 1 linha


-- ---------- Caso 2: ROLLBACK (a 2ª operação falha) ----------
SET TRANSACTION;

INSERT INTO contratacao (id_contratacao, id_organizacao, id_treinamento, data_contratacao, qtd_vagas, situacao)
VALUES (98, 1, 1, CURRENT_DATE, 10, 'ATIVA');

-- data_fim < data_inicio: viola ck_turma_datas e a operação falha
INSERT INTO turma (id_turma, id_contratacao, codigo, data_inicio, data_fim,
                   local_realizacao, capacidade, permite_turma_mista, situacao)
VALUES (98, 98, 'NR10-2026-E', '2026-12-09', '2026-12-07',
        'Auditório Vale Verde', 10, FALSE, 'PLANEJADA');

ROLLBACK;

SELECT id_contratacao FROM contratacao WHERE id_contratacao = 98;  -- vazio: a contratação também foi desfeita