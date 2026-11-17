SET TERM ^ ;

CREATE OR ALTER EXCEPTION ex_matricula_invalida 'Matricula invalida.'^

-- Procedure 1: matricula uma pessoa em uma turma, validando turma e pessoa
CREATE OR ALTER PROCEDURE sp_matricular_funcionario (
    p_id_matricula INTEGER,
    p_id_turma INTEGER,
    p_id_pessoa INTEGER
)
AS
DECLARE VARIABLE v_situacao_turma VARCHAR(15);
DECLARE VARIABLE v_org_pessoa INTEGER;
BEGIN
    SELECT situacao FROM turma
    WHERE id_turma = :p_id_turma
    INTO :v_situacao_turma;

    IF (v_situacao_turma IS NULL) THEN
        EXCEPTION ex_matricula_invalida 'Turma nao encontrada.';

    IF (v_situacao_turma NOT IN ('PLANEJADA', 'EM_ANDAMENTO')) THEN
        EXCEPTION ex_matricula_invalida 'A turma nao aceita novas matriculas.';

    SELECT id_organizacao FROM pessoa
    WHERE id_pessoa = :p_id_pessoa
    INTO :v_org_pessoa;

    IF (v_org_pessoa IS NULL) THEN
        EXCEPTION ex_matricula_invalida 'Pessoa nao encontrada.';

    -- capacidade e turma mista sao validadas pelos triggers de matricula
    INSERT INTO matricula (id_matricula, id_turma, id_pessoa, data_matricula, situacao)
    VALUES (:p_id_matricula, :p_id_turma, :p_id_pessoa, CURRENT_DATE, 'INSCRITO');
END^

-- Procedure 2: registra a nota e define a situacao (nota minima E frequencia minima)
CREATE OR ALTER PROCEDURE sp_atualizar_nota_matricula (
    p_id_matricula INTEGER,
    p_nova_nota DECIMAL(4,2)
)
AS
DECLARE VARIABLE v_id_turma INTEGER;
DECLARE VARIABLE v_situacao_atual VARCHAR(15);
DECLARE VARIABLE v_nota_minima DECIMAL(4,2);
DECLARE VARIABLE v_freq_minima INTEGER;
DECLARE VARIABLE v_total_encontros INTEGER;
DECLARE VARIABLE v_presencas INTEGER;
DECLARE VARIABLE v_freq DECIMAL(5,2);
DECLARE VARIABLE v_situacao VARCHAR(15);
BEGIN
    IF (p_nova_nota IS NULL OR p_nova_nota < 0 OR p_nova_nota > 10) THEN
        EXCEPTION ex_matricula_invalida 'Nota deve estar entre 0 e 10.';

    SELECT m.id_turma, m.situacao, t.nota_minima, t.frequencia_minima_pct
    FROM matricula m
    JOIN turma tu ON m.id_turma = tu.id_turma
    JOIN contratacao c ON tu.id_contratacao = c.id_contratacao
    JOIN treinamento t ON c.id_treinamento = t.id_treinamento
    WHERE m.id_matricula = :p_id_matricula
    INTO :v_id_turma, :v_situacao_atual, :v_nota_minima, :v_freq_minima;

    IF (v_id_turma IS NULL) THEN
        EXCEPTION ex_matricula_invalida 'Matricula nao encontrada.';

    IF (v_situacao_atual = 'CANCELADO') THEN
        EXCEPTION ex_matricula_invalida 'Matricula cancelada nao pode receber nota.';

    SELECT COUNT(*) FROM encontro
    WHERE id_turma = :v_id_turma
    INTO :v_total_encontros;

    IF (v_total_encontros = 0) THEN
        EXCEPTION ex_matricula_invalida 'Turma sem encontros cadastrados.';

    -- encontro sem registro de presenca conta como falta
    SELECT COUNT(*) FROM presenca
    WHERE id_matricula = :p_id_matricula AND presente = TRUE
    INTO :v_presencas;

    v_freq = (v_presencas * 100.0) / v_total_encontros;

    IF (p_nova_nota >= v_nota_minima AND v_freq >= v_freq_minima) THEN
        v_situacao = 'CONCLUIDO';
    ELSE
        v_situacao = 'REPROVADO';

    UPDATE matricula
    SET nota_final = :p_nova_nota,
        situacao = :v_situacao
    WHERE id_matricula = :p_id_matricula;
END^

SET TERM ; ^