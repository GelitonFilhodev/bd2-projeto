SET ECHO ON;

-- 1. PK duplicada (id 1 já existe)
INSERT INTO organizacao (id_organizacao, razao_social, cnpj) VALUES (1, 'Empresa Teste', '99999999999999');

-- 2. UNIQUE: CNPJ repetido
INSERT INTO organizacao (id_organizacao, razao_social, cnpj) VALUES (99, 'Empresa Teste', '11222333000181');

-- 3. UNIQUE: CPF repetido
INSERT INTO pessoa (id_pessoa, id_organizacao, nome, cpf) VALUES (99, 1, 'Teste', '10000000001');

-- 4. FK: organização inexistente
INSERT INTO pessoa (id_pessoa, id_organizacao, nome, cpf) VALUES (99, 999, 'Teste', '99999999999');

-- 5. NOT NULL: razão social nula
INSERT INTO organizacao (id_organizacao, razao_social, cnpj) VALUES (99, NULL, '99999999999999');

-- 6. CHECK: frequência mínima 150%
INSERT INTO treinamento (id_treinamento, nome, carga_horaria_h, frequencia_minima_pct) VALUES (99, 'Teste', 8, 150);

-- 7. CHECK: nota mínima 11
INSERT INTO treinamento (id_treinamento, nome, carga_horaria_h, nota_minima) VALUES (99, 'Teste', 8, 11);

-- 8. CHECK: carga horária zero
INSERT INTO treinamento (id_treinamento, nome, carga_horaria_h) VALUES (99, 'Teste', 0);

-- 9. CHECK: turma terminando antes de começar
INSERT INTO turma VALUES (99, 1, 'TESTE-DATAS', '2026-12-10', '2026-12-01', 'Sala X', 10, FALSE, 'PLANEJADA');

-- 10. CHECK: encontro com fim antes do início
INSERT INTO encontro VALUES (99, 1, '2026-12-01', '10:00:00', '09:00:00');

-- 11. CHECK: situação de matrícula inválida
INSERT INTO matricula VALUES (99, 2, 1, '2026-10-27', 'XPTO', NULL);

-- 12. CHECK: nota final 11
INSERT INTO matricula VALUES (99, 2, 1, '2026-10-27', 'INSCRITO', 11);

-- 13. UNIQUE: mesma pessoa duas vezes na mesma turma
INSERT INTO matricula VALUES (99, 1, 1, '2026-10-27', 'INSCRITO', NULL);

-- 14. CHECK: validade do certificado anterior à emissão
INSERT INTO certificado VALUES (99, 3, 'CERT-TESTE-1', '2026-12-01', '2026-11-01');

-- 15. UNIQUE: segundo certificado para a mesma matrícula
INSERT INTO certificado VALUES (99, 1, 'CERT-TESTE-2', '2026-12-01', NULL);

-- 16. CHECK: treinamento como requisito dele mesmo
INSERT INTO treinamento_requisito VALUES (1, 1);

-- 17. PK composta: presença duplicada
INSERT INTO presenca VALUES (1, 1, TRUE);

-- 18. FK: apagar organização que tem pessoas e contratações
DELETE FROM organizacao WHERE id_organizacao = 1;

-- Conferência: nada disso pode ter alterado os dados
SELECT (SELECT COUNT(*) FROM organizacao) AS orgs,
       (SELECT COUNT(*) FROM pessoa) AS pessoas,
       (SELECT COUNT(*) FROM treinamento) AS treinamentos,
       (SELECT COUNT(*) FROM turma) AS turmas,
       (SELECT COUNT(*) FROM matricula) AS matriculas,
       (SELECT COUNT(*) FROM certificado) AS certificados
FROM RDB$DATABASE;