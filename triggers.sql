SET TERM ^ ;

-- -------------------------------------------------------------------------
-- Exceções
-- -------------------------------------------------------------------------

CREATE OR ALTER EXCEPTION ex_capacidade_turma
    'Capacidade maxima da turma atingida.'^

CREATE OR ALTER EXCEPTION ex_contratacao_ativa
    'Nao e permitido excluir uma contratacao ATIVA.'^


-- -------------------------------------------------------------------------
-- Trigger 1: Valida se a capacidade da turma foi atingida antes de inserir
-- -------------------------------------------------------------------------

CREATE OR ALTER TRIGGER trg_valida_capacidade_turma
FOR matricula
ACTIVE BEFORE INSERT
POSITION 0
AS
    DECLARE VARIABLE v_capacidade INTEGER;
    DECLARE VARIABLE v_total_atual INTEGER;
BEGIN

    -- Busca a capacidade máxima da turma
    SELECT capacidade
    FROM turma
    WHERE id_turma = NEW.id_turma
    INTO :v_capacidade;

    -- Busca o total atual de matrículas na turma
    SELECT COUNT(*)
    FROM matricula
    WHERE id_turma = NEW.id_turma
    INTO :v_total_atual;

    -- Verifica se a capacidade foi atingida
    IF (:v_total_atual >= :v_capacidade) THEN
        EXCEPTION ex_capacidade_turma;

END^


-- -------------------------------------------------------------------------
-- Trigger 2: Impede exclusão de contratações que estejam com situação ATIVA
-- -------------------------------------------------------------------------

CREATE OR ALTER TRIGGER trg_valida_exclusao_contratacao
FOR contratacao
ACTIVE BEFORE DELETE
POSITION 0
AS
BEGIN

    IF (OLD.situacao = 'ATIVA') THEN
        EXCEPTION ex_contratacao_ativa;

END^


SET TERM ; ^