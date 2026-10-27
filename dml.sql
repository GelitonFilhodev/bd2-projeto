-- ORGANIZACAO
INSERT INTO organizacao VALUES (1, 'Agroindústria Vale Verde Ltda', '11222333000181', 'rh@valeverde.com.br', TRUE);
INSERT INTO organizacao VALUES (2, 'TechSerra Soluções em TI S.A.', '22333444000172', 'treinamento@techserra.com.br', TRUE);
INSERT INTO organizacao VALUES (3, 'Hospital Santa Clara', '33444555000163', 'rh@santaclara.org.br', TRUE);
INSERT INTO organizacao VALUES (4, 'Construtora Horizonte Ltda', '44555666000154', 'dp@horizonte.eng.br', TRUE);
INSERT INTO organizacao VALUES (5, 'Logística Rio Norte', '55666777000145', 'contato@rionorte.com.br', FALSE);

-- TREINAMENTO (id, nome, descricao, carga_h, freq_min, nota_min, validade_meses, ativo)
INSERT INTO treinamento VALUES (1, 'NR-10 Segurança em Instalações Elétricas', 'Norma regulamentadora de eletricidade', 40, 75, 7, 24, TRUE);
INSERT INTO treinamento VALUES (2, 'NR-35 Trabalho em Altura', 'Segurança em atividades acima de 2 metros', 8, 90, 7, 24, TRUE);
INSERT INTO treinamento VALUES (3, 'Excel Básico', 'Planilhas, fórmulas e formatação', 16, 75, 6, NULL, TRUE);
INSERT INTO treinamento VALUES (4, 'Excel Avançado', 'Tabelas dinâmicas, macros e análise de dados', 24, 75, 7, 36, TRUE);
INSERT INTO treinamento VALUES (5, 'Liderança e Gestão de Equipes', 'Comunicação, feedback e delegação', 20, 80, 7, NULL, TRUE);
INSERT INTO treinamento VALUES (6, 'Gestão de Projetos Ágeis', 'Scrum e Kanban na prática', 32, 75, 7, 36, TRUE);
INSERT INTO treinamento VALUES (7, 'Primeiros Socorros no Trabalho', 'Atendimento inicial a emergências', 12, 90, 7, 12, TRUE);

-- TREINAMENTO_REQUISITO (treinamento, exige)
INSERT INTO treinamento_requisito VALUES (4, 3);
INSERT INTO treinamento_requisito VALUES (6, 5);
INSERT INTO treinamento_requisito VALUES (2, 7);

-- INSTRUTOR
INSERT INTO instrutor VALUES (1, 'Carlos Eduardo Menezes', '12345678901', 'carlos@capacita.com', 'Segurança do Trabalho', TRUE);
INSERT INTO instrutor VALUES (2, 'Fernanda Albuquerque', '23456789012', 'fernanda@capacita.com', 'Tecnologia e Planilhas', TRUE);
INSERT INTO instrutor VALUES (3, 'Ricardo Tavares', '34567890123', 'ricardo@capacita.com', 'Gestão e Liderança', TRUE);
INSERT INTO instrutor VALUES (4, 'Juliana Prado', '45678901234', 'juliana@capacita.com', 'Saúde e Primeiros Socorros', TRUE);
INSERT INTO instrutor VALUES (5, 'Marcos Antunes', '56789012345', 'marcos@capacita.com', 'Segurança do Trabalho', FALSE);

-- PESSOA (id, organizacao, nome, cpf, email, cargo)
INSERT INTO pessoa VALUES (1, 1, 'Ana Beatriz Lima', '10000000001', 'ana.lima@valeverde.com.br', 'Técnica de Segurança');
INSERT INTO pessoa VALUES (2, 1, 'João Pedro Santos', '10000000002', 'joao.santos@valeverde.com.br', 'Eletricista');
INSERT INTO pessoa VALUES (3, 1, 'Maria Clara Souza', '10000000003', 'maria.souza@valeverde.com.br', 'Supervisora de Produção');
INSERT INTO pessoa VALUES (4, 2, 'Lucas Ferreira', '10000000004', 'lucas.ferreira@techserra.com.br', 'Analista de Sistemas');
INSERT INTO pessoa VALUES (5, 2, 'Patrícia Gomes', '10000000005', 'patricia.gomes@techserra.com.br', 'Gerente de TI');
INSERT INTO pessoa VALUES (6, 2, 'Rafael Oliveira', '10000000006', 'rafael.oliveira@techserra.com.br', 'Desenvolvedor');
INSERT INTO pessoa VALUES (7, 2, 'Larissa Duarte', '10000000007', 'larissa.duarte@techserra.com.br', 'Analista Financeira');
INSERT INTO pessoa VALUES (8, 3, 'Camila Rocha', '10000000008', 'camila.rocha@santaclara.org.br', 'Enfermeira');
INSERT INTO pessoa VALUES (9, 3, 'Bruno Almeida', '10000000009', 'bruno.almeida@santaclara.org.br', 'Técnico de Manutenção');
INSERT INTO pessoa VALUES (10, 3, 'Teresa Nunes', '10000000010', 'teresa.nunes@santaclara.org.br', 'Coordenadora Administrativa');
INSERT INTO pessoa VALUES (11, 4, 'Diego Martins', '10000000011', 'diego.martins@horizonte.eng.br', 'Encarregado de Obras');
INSERT INTO pessoa VALUES (12, 4, 'Helena Barros', '10000000012', 'helena.barros@horizonte.eng.br', 'Engenheira Civil');
INSERT INTO pessoa VALUES (13, 4, 'Gustavo Pinto', '10000000013', 'gustavo.pinto@horizonte.eng.br', 'Auxiliar Administrativo');
INSERT INTO pessoa VALUES (14, 5, 'Felipe Araújo', '10000000014', 'felipe.araujo@rionorte.com.br', 'Motorista');

-- CONTRATACAO (id, organizacao, treinamento, data, vagas, situacao)
INSERT INTO contratacao VALUES (1, 1, 1, '2026-02-16', 20, 'ATIVA');
INSERT INTO contratacao VALUES (2, 2, 3, '2026-03-23', 15, 'CONCLUIDA');
INSERT INTO contratacao VALUES (3, 2, 4, '2026-09-21', 10, 'ATIVA');
INSERT INTO contratacao VALUES (4, 3, 7, '2026-04-20', 12, 'CONCLUIDA');
INSERT INTO contratacao VALUES (5, 4, 2, '2026-07-20', 15, 'CONCLUIDA');
INSERT INTO contratacao VALUES (6, 2, 5, '2026-08-31', 12, 'CONCLUIDA');
INSERT INTO contratacao VALUES (7, 3, 6, '2026-09-28', 10, 'CANCELADA');
INSERT INTO contratacao VALUES (8, 4, 1, '2026-10-05', 10, 'ATIVA');

-- TURMA (id, contratacao, codigo, inicio, fim, local, capacidade, mista, situacao)
INSERT INTO turma VALUES (1, 1, 'NR10-2026-A', '2026-03-09', '2026-03-11', 'Auditório Vale Verde', 10, FALSE, 'CONCLUIDA');
INSERT INTO turma VALUES (2, 1, 'NR10-2026-B', '2026-11-16', '2026-11-18', 'Auditório Vale Verde', 10, FALSE, 'PLANEJADA');
INSERT INTO turma VALUES (3, 2, 'EXCELB-2026-A', '2026-04-13', '2026-04-14', 'Laboratório TechSerra', 15, FALSE, 'CONCLUIDA');
INSERT INTO turma VALUES (4, 3, 'EXCELA-2026-A', '2026-10-13', '2026-11-03', 'Laboratório TechSerra', 10, FALSE, 'EM_ANDAMENTO');
INSERT INTO turma VALUES (5, 4, 'PS-2026-A', '2026-05-18', '2026-05-19', 'Auditório Hospital Santa Clara', 12, TRUE, 'CONCLUIDA');
INSERT INTO turma VALUES (6, 5, 'NR35-2026-A', '2026-08-17', '2026-08-17', 'Canteiro Horizonte Obras', 15, FALSE, 'CONCLUIDA');
INSERT INTO turma VALUES (7, 6, 'LID-2026-A', '2026-09-21', '2026-09-23', 'Sala de Treinamento Centro', 12, TRUE, 'CONCLUIDA');
INSERT INTO turma VALUES (8, 7, 'AGIL-2026-A', '2026-10-19', '2026-10-23', 'Sala de Treinamento Santa Clara', 10, FALSE, 'CANCELADA');
INSERT INTO turma VALUES (9, 8, 'NR10-2026-C', '2026-11-09', '2026-11-11', 'Sala Horizonte Obras', 10, FALSE, 'PLANEJADA');

-- TURMA_INSTRUTOR (turma, instrutor, papel)
INSERT INTO turma_instrutor VALUES (1, 1, 'TITULAR');
INSERT INTO turma_instrutor VALUES (1, 5, 'AUXILIAR');
INSERT INTO turma_instrutor VALUES (2, 1, 'TITULAR');
INSERT INTO turma_instrutor VALUES (3, 2, 'TITULAR');
INSERT INTO turma_instrutor VALUES (4, 2, 'TITULAR');
INSERT INTO turma_instrutor VALUES (5, 4, 'TITULAR');
INSERT INTO turma_instrutor VALUES (6, 1, 'TITULAR');
INSERT INTO turma_instrutor VALUES (6, 4, 'AUXILIAR');
INSERT INTO turma_instrutor VALUES (7, 3, 'TITULAR');
INSERT INTO turma_instrutor VALUES (8, 3, 'TITULAR');
INSERT INTO turma_instrutor VALUES (9, 1, 'TITULAR');

-- ENCONTRO (id, turma, data, inicio, fim)
INSERT INTO encontro VALUES (1, 1, '2026-03-09', '08:00:00', '17:00:00');
INSERT INTO encontro VALUES (2, 1, '2026-03-10', '08:00:00', '17:00:00');
INSERT INTO encontro VALUES (3, 1, '2026-03-11', '08:00:00', '17:00:00');
INSERT INTO encontro VALUES (4, 3, '2026-04-13', '08:00:00', '16:00:00');
INSERT INTO encontro VALUES (5, 3, '2026-04-14', '08:00:00', '16:00:00');
INSERT INTO encontro VALUES (6, 4, '2026-10-13', '09:00:00', '15:00:00');
INSERT INTO encontro VALUES (7, 4, '2026-10-20', '09:00:00', '15:00:00');
INSERT INTO encontro VALUES (8, 4, '2026-11-03', '09:00:00', '15:00:00');
INSERT INTO encontro VALUES (9, 5, '2026-05-18', '08:00:00', '14:00:00');
INSERT INTO encontro VALUES (10, 5, '2026-05-19', '08:00:00', '14:00:00');
INSERT INTO encontro VALUES (11, 6, '2026-08-17', '08:00:00', '16:00:00');
INSERT INTO encontro VALUES (12, 7, '2026-09-21', '14:00:00', '18:00:00');
INSERT INTO encontro VALUES (13, 7, '2026-09-22', '14:00:00', '18:00:00');
INSERT INTO encontro VALUES (14, 7, '2026-09-23', '14:00:00', '18:00:00');

-- MATRICULA (id, turma, pessoa, data, situacao, nota_final)
-- Turma 1: NR-10 (org 1)
INSERT INTO matricula VALUES (1, 1, 1, '2026-02-23', 'CONCLUIDO', 9.00);
INSERT INTO matricula VALUES (2, 1, 2, '2026-02-23', 'CONCLUIDO', 8.00);
INSERT INTO matricula VALUES (3, 1, 3, '2026-02-23', 'REPROVADO', 5.50);
-- Turma 3: Excel Básico (org 2)
INSERT INTO matricula VALUES (4, 3, 4, '2026-03-30', 'CONCLUIDO', 8.50);
INSERT INTO matricula VALUES (5, 3, 5, '2026-03-30', 'CONCLUIDO', 9.50);
INSERT INTO matricula VALUES (6, 3, 6, '2026-03-30', 'CONCLUIDO', 6.00);
INSERT INTO matricula VALUES (7, 3, 7, '2026-03-30', 'REPROVADO', 4.00);
-- Turma 4: Excel Avançado, em andamento (org 2)
INSERT INTO matricula VALUES (8, 4, 4, '2026-09-28', 'INSCRITO', NULL);
INSERT INTO matricula VALUES (9, 4, 5, '2026-09-28', 'INSCRITO', NULL);
INSERT INTO matricula VALUES (10, 4, 7, '2026-09-28', 'INSCRITO', NULL);
-- Turma 5: Primeiros Socorros, turma mista (orgs 3 e 4)
INSERT INTO matricula VALUES (11, 5, 8, '2026-05-04', 'CONCLUIDO', 9.00);
INSERT INTO matricula VALUES (12, 5, 9, '2026-05-04', 'CONCLUIDO', 7.50);
INSERT INTO matricula VALUES (13, 5, 10, '2026-05-04', 'CONCLUIDO', 8.00);
INSERT INTO matricula VALUES (14, 5, 11, '2026-05-04', 'CONCLUIDO', 8.50);
INSERT INTO matricula VALUES (15, 5, 13, '2026-05-04', 'REPROVADO', 6.00);
-- Turma 6: NR-35 (org 4)
INSERT INTO matricula VALUES (16, 6, 11, '2026-08-03', 'CONCLUIDO', 9.00);
INSERT INTO matricula VALUES (17, 6, 12, '2026-08-03', 'CONCLUIDO', 7.50);
INSERT INTO matricula VALUES (18, 6, 13, '2026-08-03', 'REPROVADO', 5.00);
-- Turma 7: Liderança, turma mista (orgs 2 e 3)
INSERT INTO matricula VALUES (19, 7, 5, '2026-09-07', 'CONCLUIDO', 9.00);
INSERT INTO matricula VALUES (20, 7, 6, '2026-09-07', 'CONCLUIDO', 7.00);
INSERT INTO matricula VALUES (21, 7, 10, '2026-09-07', 'CONCLUIDO', 8.50);
INSERT INTO matricula VALUES (22, 7, 4, '2026-09-07', 'REPROVADO', 7.50);
-- Turma 8: cancelada
INSERT INTO matricula VALUES (23, 8, 10, '2026-10-05', 'CANCELADO', NULL);
INSERT INTO matricula VALUES (24, 8, 8, '2026-10-05', 'CANCELADO', NULL);
-- Turmas futuras
INSERT INTO matricula VALUES (25, 2, 3, '2026-10-12', 'INSCRITO', NULL);
INSERT INTO matricula VALUES (26, 9, 12, '2026-10-19', 'INSCRITO', NULL);
INSERT INTO matricula VALUES (27, 9, 11, '2026-10-19', 'INSCRITO', NULL);

-- PRESENCA (encontro, matricula, presente)
-- Turma 1 (encontros 1 a 3)
INSERT INTO presenca VALUES (1, 1, TRUE);
INSERT INTO presenca VALUES (2, 1, TRUE);
INSERT INTO presenca VALUES (3, 1, TRUE);
INSERT INTO presenca VALUES (1, 2, TRUE);
INSERT INTO presenca VALUES (2, 2, TRUE);
INSERT INTO presenca VALUES (3, 2, TRUE);
INSERT INTO presenca VALUES (1, 3, TRUE);
INSERT INTO presenca VALUES (2, 3, TRUE);
INSERT INTO presenca VALUES (3, 3, TRUE);
-- Turma 3 (encontros 4 e 5)
INSERT INTO presenca VALUES (4, 4, TRUE);
INSERT INTO presenca VALUES (5, 4, TRUE);
INSERT INTO presenca VALUES (4, 5, TRUE);
INSERT INTO presenca VALUES (5, 5, TRUE);
INSERT INTO presenca VALUES (4, 6, TRUE);
INSERT INTO presenca VALUES (5, 6, TRUE);
INSERT INTO presenca VALUES (4, 7, TRUE);
INSERT INTO presenca VALUES (5, 7, FALSE);
-- Turma 4 (encontros 6 e 7 já ocorreram; o 8 é futuro)
INSERT INTO presenca VALUES (6, 8, TRUE);
INSERT INTO presenca VALUES (7, 8, TRUE);
INSERT INTO presenca VALUES (6, 9, TRUE);
INSERT INTO presenca VALUES (7, 9, TRUE);
INSERT INTO presenca VALUES (6, 10, TRUE);
INSERT INTO presenca VALUES (7, 10, FALSE);
-- Turma 5 (encontros 9 e 10)
INSERT INTO presenca VALUES (9, 11, TRUE);
INSERT INTO presenca VALUES (10, 11, TRUE);
INSERT INTO presenca VALUES (9, 12, TRUE);
INSERT INTO presenca VALUES (10, 12, TRUE);
INSERT INTO presenca VALUES (9, 13, TRUE);
INSERT INTO presenca VALUES (10, 13, TRUE);
INSERT INTO presenca VALUES (9, 14, TRUE);
INSERT INTO presenca VALUES (10, 14, TRUE);
INSERT INTO presenca VALUES (9, 15, TRUE);
INSERT INTO presenca VALUES (10, 15, FALSE);
-- Turma 6 (encontro 11)
INSERT INTO presenca VALUES (11, 16, TRUE);
INSERT INTO presenca VALUES (11, 17, TRUE);
INSERT INTO presenca VALUES (11, 18, FALSE);
-- Turma 7 (encontros 12 a 14)
INSERT INTO presenca VALUES (12, 19, TRUE);
INSERT INTO presenca VALUES (13, 19, TRUE);
INSERT INTO presenca VALUES (14, 19, TRUE);
INSERT INTO presenca VALUES (12, 20, TRUE);
INSERT INTO presenca VALUES (13, 20, TRUE);
INSERT INTO presenca VALUES (14, 20, TRUE);
INSERT INTO presenca VALUES (12, 21, TRUE);
INSERT INTO presenca VALUES (13, 21, TRUE);
INSERT INTO presenca VALUES (14, 21, TRUE);
INSERT INTO presenca VALUES (12, 22, TRUE);
INSERT INTO presenca VALUES (13, 22, TRUE);
INSERT INTO presenca VALUES (14, 22, FALSE);

-- CERTIFICADO (id, matricula, codigo, emissao, validade)
INSERT INTO certificado VALUES (1, 1, 'CERT-2026-0001', '2026-03-13', '2028-03-13');
INSERT INTO certificado VALUES (2, 2, 'CERT-2026-0002', '2026-03-13', '2028-03-13');
INSERT INTO certificado VALUES (3, 4, 'CERT-2026-0003', '2026-04-16', NULL);
INSERT INTO certificado VALUES (4, 5, 'CERT-2026-0004', '2026-04-16', NULL);
INSERT INTO certificado VALUES (5, 6, 'CERT-2026-0005', '2026-04-16', NULL);
INSERT INTO certificado VALUES (6, 11, 'CERT-2026-0006', '2026-05-21', '2027-05-21');
INSERT INTO certificado VALUES (7, 12, 'CERT-2026-0007', '2026-05-21', '2027-05-21');
INSERT INTO certificado VALUES (8, 13, 'CERT-2026-0008', '2026-05-21', '2027-05-21');
INSERT INTO certificado VALUES (9, 14, 'CERT-2026-0009', '2026-05-21', '2027-05-21');
INSERT INTO certificado VALUES (10, 16, 'CERT-2026-0010', '2026-08-19', '2028-08-19');
INSERT INTO certificado VALUES (11, 17, 'CERT-2026-0011', '2026-08-19', '2028-08-19');
INSERT INTO certificado VALUES (12, 19, 'CERT-2026-0012', '2026-09-25', NULL);
INSERT INTO certificado VALUES (13, 20, 'CERT-2026-0013', '2026-09-25', NULL);