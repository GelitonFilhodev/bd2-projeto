SET TERM ^ ;

-- Procedure 1: Matricular funcionário em uma turma
CREATE OR ALTER PROCEDURE sp_matricular_funcionario (
    p_id_matricula INTEGER,
    p_id_turma INTEGER,
    p_id_pessoa INTEGER
)
AS
BEGIN
    INSERT INTO matricula (id_matricula, id_turma, id_pessoa, data_matricula, situacao)
    VALUES (:p_id_matricula, :p_id_turma, :p_id_pessoa, CURRENT_DATE, 'ATIVA');
END^

-- Procedure 2: Atualizar nota final e situação de conclusão do aluno
CREATE OR ALTER PROCEDURE sp_atualizar_nota_matricula (
    p_id_matricula INTEGER,
    p_nova_nota DECIMAL(4,2)
)
AS
DECLARE VARIABLE v_nota_minima DECIMAL(4,2);
DECLARE VARIABLE v_situacao VARCHAR(15);
BEGIN
    -- Busca a nota mínima do treinamento através do relacionamento
    SELECT t.nota_minima
    FROM matricula m
    JOIN turma tu ON m.id_turma = tu.id_turma
    JOIN contratacao c ON tu.id_contratacao = c.id_contratacao
    JOIN treinamento t ON c.id_treinamento = t.id_treinamento
    WHERE m.id_matricula = :p_id_matricula
    INTO :v_nota_minima;

    -- Define a situação com base na nota mínima
    IF (:p_nova_nota >= :v_nota_minima) THEN
        v_situacao = 'CONCLUIDA';
    ELSE
        v_situacao = 'REPROVADO';

    UPDATE matricula
    SET nota_final = :p_nova_nota,
        situacao = :v_situacao
    WHERE id_matricula = :p_id_matricula;
END^

SET TERM ; ^