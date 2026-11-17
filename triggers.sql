SET TERM ^ ;

-- -------------------------------------------------------------------------
-- Exceções
-- -------------------------------------------------------------------------

CREATE OR ALTER EXCEPTION ex_capacidade_turma
    'Capacidade maxima da turma atingida.'^

CREATE OR ALTER EXCEPTION ex_contratacao_ativa
    'Nao e permitido excluir uma contratacao ATIVA.'^

CREATE OR ALTER EXCEPTION ex_turma_nao_mista
    'Turma nao permite participantes de outra organizacao.'^


-- -------------------------------------------------------------------------
-- Trigger 1: valida capacidade da turma (matrícula CANCELADO não ocupa vaga)
-- -------------------------------------------------------------------------

CREATE OR ALTER TRIGGER trg_valida_capacidade_turma
FOR matricula
ACTIVE BEFORE INSERT
POSITION 0
AS
    DECLARE VARIABLE v_capacidade INTEGER;
    DECLARE VARIABLE v_total_atual INTEGER;
BEGIN
    SELECT capacidade
    FROM turma
    WHERE id_turma = NEW.id_turma
    INTO :v_capacidade;

    SELECT COUNT(*)
    FROM matricula
    WHERE id_turma = NEW.id_turma
      AND situacao <> 'CANCELADO'
    INTO :v_total_atual;

    IF (:v_total_atual >= :v_capacidade) THEN
        EXCEPTION ex_capacidade_turma;
END^


-- -------------------------------------------------------------------------
-- Trigger 2: impede exclusão de contratações ATIVAS
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


-- -------------------------------------------------------------------------
-- Trigger 3: pessoa de outra organização só entra em turma mista
-- -------------------------------------------------------------------------

CREATE OR ALTER TRIGGER trg_matricula_turma_mista
FOR matricula
ACTIVE BEFORE INSERT
POSITION 1
AS
    DECLARE VARIABLE v_mista BOOLEAN;
    DECLARE VARIABLE v_org_contratante INTEGER;
    DECLARE VARIABLE v_org_pessoa INTEGER;
BEGIN
    SELECT tu.permite_turma_mista, c.id_organizacao
    FROM turma tu
    JOIN contratacao c ON tu.id_contratacao = c.id_contratacao
    WHERE tu.id_turma = NEW.id_turma
    INTO :v_mista, :v_org_contratante;

    SELECT id_organizacao
    FROM pessoa
    WHERE id_pessoa = NEW.id_pessoa
    INTO :v_org_pessoa;

    IF (NOT v_mista AND v_org_pessoa <> v_org_contratante) THEN
        EXCEPTION ex_turma_nao_mista;
END^

SET TERM ; ^