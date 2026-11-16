-- =========================================================================
-- CASO TRANSACIONAL: Registro de Nova Contratação com Geração Automática de Turma
-- =========================================================================
-- Explicação: Uma contratação de treinamento exige obrigatoriamente a abertura 
-- inicial de uma turma correspondente. Ambas as operações devem ocorrer de forma 
-- atômica (unidade lógica). Se houver erro, ocorre ROLLBACK; caso contrário, COMMIT.

SET TRANSACTION;

BEGIN
    -- Operação 1: Inserir a nova contratação
    INSERT INTO contratacao (id_contratacao, id_organizacao, id_treinamento, data_contratacao, qtd_vagas, situacao)
    VALUES (99, 1, 1, CURRENT_DATE, 10, 'ATIVA');

    -- Operação 2: Criar a turma correspondente à contratação
    INSERT INTO turma (id_turma, id_contratacao, codigo, data_inicio, data_fim, local, capacidade, permite_turma_mista, situacao)
    VALUES (99, 99, 'TURMA-TESTE-TRANS', CURRENT_DATE, CURRENT_DATE + 30, 'Presencial', 10, TRUE, 'ABERTA');

    -- Se tudo ocorreu com sucesso:
    COMMIT;
WHEN ANY DO
    -- Se ocorreu qualquer falha, desfaz as operações de forma atômica:
    ROLLBACK;
END