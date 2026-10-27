CREATE TABLE organizacao (
  id_organizacao INTEGER NOT NULL,
  razao_social   VARCHAR(150) NOT NULL,
  cnpj           VARCHAR(14) NOT NULL,
  email_contato  VARCHAR(120),
  ativa          BOOLEAN DEFAULT TRUE NOT NULL,
  CONSTRAINT pk_organizacao PRIMARY KEY (id_organizacao),
  CONSTRAINT uq_organizacao_cnpj UNIQUE (cnpj)
);

CREATE TABLE treinamento (
  id_treinamento             INTEGER NOT NULL,
  nome                       VARCHAR(120) NOT NULL,
  descricao                  VARCHAR(500),
  carga_horaria_h            INTEGER NOT NULL,
  frequencia_minima_pct      INTEGER DEFAULT 75 NOT NULL,
  nota_minima                DECIMAL(4,2) DEFAULT 7 NOT NULL,
  validade_certificado_meses INTEGER,
  ativo                      BOOLEAN DEFAULT TRUE NOT NULL,
  CONSTRAINT pk_treinamento PRIMARY KEY (id_treinamento),
  CONSTRAINT ck_treinamento_carga CHECK (carga_horaria_h > 0),
  CONSTRAINT ck_treinamento_freq CHECK (frequencia_minima_pct BETWEEN 0 AND 100),
  CONSTRAINT ck_treinamento_nota CHECK (nota_minima BETWEEN 0 AND 10),
  CONSTRAINT ck_treinamento_validade CHECK (validade_certificado_meses > 0)
);

CREATE TABLE instrutor (
  id_instrutor  INTEGER NOT NULL,
  nome          VARCHAR(120) NOT NULL,
  cpf           VARCHAR(11) NOT NULL,
  email         VARCHAR(120),
  especialidade VARCHAR(100),
  ativo         BOOLEAN DEFAULT TRUE NOT NULL,
  CONSTRAINT pk_instrutor PRIMARY KEY (id_instrutor),
  CONSTRAINT uq_instrutor_cpf UNIQUE (cpf)
);

CREATE TABLE pessoa (
  id_pessoa      INTEGER NOT NULL,
  id_organizacao INTEGER NOT NULL,
  nome           VARCHAR(120) NOT NULL,
  cpf            VARCHAR(11) NOT NULL,
  email          VARCHAR(120),
  cargo          VARCHAR(80),
  CONSTRAINT pk_pessoa PRIMARY KEY (id_pessoa),
  CONSTRAINT uq_pessoa_cpf UNIQUE (cpf),
  CONSTRAINT fk_pessoa_organizacao FOREIGN KEY (id_organizacao)
    REFERENCES organizacao (id_organizacao)
);

CREATE TABLE treinamento_requisito (
  id_treinamento           INTEGER NOT NULL,
  id_treinamento_requisito INTEGER NOT NULL,
  CONSTRAINT pk_trein_req PRIMARY KEY (id_treinamento, id_treinamento_requisito),
  CONSTRAINT fk_trein_req_treinamento FOREIGN KEY (id_treinamento)
    REFERENCES treinamento (id_treinamento),
  CONSTRAINT fk_trein_req_requisito FOREIGN KEY (id_treinamento_requisito)
    REFERENCES treinamento (id_treinamento),
  CONSTRAINT ck_trein_req_diferente CHECK (id_treinamento <> id_treinamento_requisito)
);

CREATE TABLE contratacao (
  id_contratacao   INTEGER NOT NULL,
  id_organizacao   INTEGER NOT NULL,
  id_treinamento   INTEGER NOT NULL,
  data_contratacao DATE DEFAULT CURRENT_DATE NOT NULL,
  qtd_vagas        INTEGER NOT NULL,
  situacao         VARCHAR(15) DEFAULT 'ATIVA' NOT NULL,
  CONSTRAINT pk_contratacao PRIMARY KEY (id_contratacao),
  CONSTRAINT fk_contratacao_organizacao FOREIGN KEY (id_organizacao)
    REFERENCES organizacao (id_organizacao),
  CONSTRAINT fk_contratacao_treinamento FOREIGN KEY (id_treinamento)
    REFERENCES treinamento (id_treinamento),
  CONSTRAINT ck_contratacao_vagas CHECK (qtd_vagas > 0),
  CONSTRAINT ck_contratacao_situacao CHECK (situacao IN ('ATIVA', 'CONCLUIDA', 'CANCELADA'))
);

CREATE TABLE turma (
  id_turma           INTEGER NOT NULL,
  id_contratacao     INTEGER NOT NULL,
  codigo             VARCHAR(20) NOT NULL,
  data_inicio        DATE NOT NULL,
  data_fim           DATE NOT NULL,
  local_realizacao   VARCHAR(120) NOT NULL,
  capacidade         INTEGER NOT NULL,
  permite_turma_mista BOOLEAN DEFAULT FALSE NOT NULL,
  situacao           VARCHAR(15) DEFAULT 'PLANEJADA' NOT NULL,
  CONSTRAINT pk_turma PRIMARY KEY (id_turma),
  CONSTRAINT uq_turma_codigo UNIQUE (codigo),
  CONSTRAINT fk_turma_contratacao FOREIGN KEY (id_contratacao)
    REFERENCES contratacao (id_contratacao),
  CONSTRAINT ck_turma_datas CHECK (data_fim >= data_inicio),
  CONSTRAINT ck_turma_capacidade CHECK (capacidade > 0),
  CONSTRAINT ck_turma_situacao CHECK (situacao IN
    ('PLANEJADA', 'EM_ANDAMENTO', 'CONCLUIDA', 'CANCELADA'))
);

CREATE TABLE turma_instrutor (
  id_turma     INTEGER NOT NULL,
  id_instrutor INTEGER NOT NULL,
  papel        VARCHAR(30) DEFAULT 'TITULAR' NOT NULL,
  CONSTRAINT pk_turma_instrutor PRIMARY KEY (id_turma, id_instrutor),
  CONSTRAINT fk_turma_instr_turma FOREIGN KEY (id_turma)
    REFERENCES turma (id_turma),
  CONSTRAINT fk_turma_instr_instrutor FOREIGN KEY (id_instrutor)
    REFERENCES instrutor (id_instrutor),
  CONSTRAINT ck_turma_instr_papel CHECK (papel IN ('TITULAR', 'AUXILIAR'))
);

CREATE TABLE encontro (
  id_encontro    INTEGER NOT NULL,
  id_turma       INTEGER NOT NULL,
  data_encontro  DATE NOT NULL,
  horario_inicio TIME NOT NULL,
  horario_fim    TIME NOT NULL,
  CONSTRAINT pk_encontro PRIMARY KEY (id_encontro),
  CONSTRAINT fk_encontro_turma FOREIGN KEY (id_turma)
    REFERENCES turma (id_turma),
  CONSTRAINT uq_encontro_turma_data_hora UNIQUE (id_turma, data_encontro, horario_inicio),
  CONSTRAINT ck_encontro_horario CHECK (horario_fim > horario_inicio)
);

CREATE TABLE matricula (
  id_matricula   INTEGER NOT NULL,
  id_turma       INTEGER NOT NULL,
  id_pessoa      INTEGER NOT NULL,
  data_matricula DATE DEFAULT CURRENT_DATE NOT NULL,
  situacao       VARCHAR(15) DEFAULT 'INSCRITO' NOT NULL,
  nota_final     DECIMAL(4,2),
  CONSTRAINT pk_matricula PRIMARY KEY (id_matricula),
  CONSTRAINT uq_matricula_turma_pessoa UNIQUE (id_turma, id_pessoa),
  CONSTRAINT fk_matricula_turma FOREIGN KEY (id_turma)
    REFERENCES turma (id_turma),
  CONSTRAINT fk_matricula_pessoa FOREIGN KEY (id_pessoa)
    REFERENCES pessoa (id_pessoa),
  CONSTRAINT ck_matricula_situacao CHECK (situacao IN
    ('INSCRITO', 'CONCLUIDO', 'REPROVADO', 'CANCELADO')),
  CONSTRAINT ck_matricula_nota CHECK (nota_final BETWEEN 0 AND 10)
);

CREATE TABLE presenca (
  id_encontro  INTEGER NOT NULL,
  id_matricula INTEGER NOT NULL,
  presente     BOOLEAN DEFAULT FALSE NOT NULL,
  CONSTRAINT pk_presenca PRIMARY KEY (id_encontro, id_matricula),
  CONSTRAINT fk_presenca_encontro FOREIGN KEY (id_encontro)
    REFERENCES encontro (id_encontro),
  CONSTRAINT fk_presenca_matricula FOREIGN KEY (id_matricula)
    REFERENCES matricula (id_matricula)
);

CREATE TABLE certificado (
  id_certificado     INTEGER NOT NULL,
  id_matricula       INTEGER NOT NULL,
  codigo_verificacao VARCHAR(30) NOT NULL,
  data_emissao       DATE DEFAULT CURRENT_DATE NOT NULL,
  data_validade      DATE,
  CONSTRAINT pk_certificado PRIMARY KEY (id_certificado),
  CONSTRAINT uq_certificado_matricula UNIQUE (id_matricula),
  CONSTRAINT uq_certificado_codigo UNIQUE (codigo_verificacao),
  CONSTRAINT fk_certificado_matricula FOREIGN KEY (id_matricula)
    REFERENCES matricula (id_matricula),
  CONSTRAINT ck_certificado_validade CHECK (data_validade >= data_emissao)
);

COMMIT;





































