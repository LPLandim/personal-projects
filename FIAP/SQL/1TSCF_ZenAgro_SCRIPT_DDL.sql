--Gabriela Soares Teixeira - RM98853
--Gustavo Santana Pereira - RM98935
--Lucas Paes Landim Pereira - RM550394
--Renan Macedo Carrara Coimbra- RM552187


DROP TABLE t_desp_pos_clta CASCADE CONSTRAINTS;

DROP TABLE t_despesa_lavoura CASCADE CONSTRAINTS;

DROP TABLE t_outro_custo CASCADE CONSTRAINTS;

DROP TABLE t_producao CASCADE CONSTRAINTS;

DROP TABLE t_produtor CASCADE CONSTRAINTS;

DROP TABLE t_renda_fator CASCADE CONSTRAINTS;


CREATE TABLE t_desp_pos_clta (
    cd_desp_pos_clta      NUMBER(8) NOT NULL,
    cd_producao           NUMBER(8) NOT NULL,
    vl_seguro_agricola    NUMBER(8, 2) NOT NULL,
    vl_transporte_interno NUMBER(8, 2) NOT NULL,
    vl_armazenagem        NUMBER(8, 2) NOT NULL,
    vl_cessr              NUMBER(8, 2) NOT NULL,
    vl_total_pos_clta     NUMBER(8, 2) NOT NULL,
    vl_assist_tecnica     NUMBER(8, 2),
    cd_produtor           NUMBER(8) NOT NULL
);

ALTER TABLE t_desp_pos_clta ADD CONSTRAINT pk_t_desp_pos_clta PRIMARY KEY ( cd_desp_pos_clta );

CREATE TABLE t_despesa_lavoura (
    cd_lavoura                NUMBER(8) NOT NULL,
    cd_producao               NUMBER(8) NOT NULL,
    tp_operacao               VARCHAR2(30) NOT NULL,
    vl_aluguel_maquina        NUMBER(8, 2) NOT NULL,
    vl_mao_obra               NUMBER(8, 2) NOT NULL,
    vl_semente                NUMBER(8, 2) NOT NULL,
    vl_fertilizante           NUMBER(8, 2) NOT NULL,
    vl_agrotoxico             NUMBER(8, 2) NOT NULL,
    vl_despesa_administrativa NUMBER(8, 2) NOT NULL,
    vl_outra_despesa          NUMBER(8, 2) NOT NULL,
    vl_total_lavoura          NUMBER(8, 2) NOT NULL,
    cd_produtor               NUMBER(8) NOT NULL
);

ALTER TABLE t_despesa_lavoura ADD CONSTRAINT pk_t_desp_lav PRIMARY KEY ( cd_lavoura );

CREATE TABLE t_outro_custo (
    cd_custo            NUMBER(8) NOT NULL,
    cd_producao         NUMBER(8) NOT NULL,
    vl_manutencao_geral NUMBER(8, 2) NOT NULL,
    vl_encargos         NUMBER(8, 2) NOT NULL,
    vl_juros            NUMBER(8, 2) NOT NULL,
    vl_servico_div      NUMBER(8, 2) NOT NULL,
    vl_depreciacao      NUMBER(8, 2) NOT NULL,
    cd_produtor         NUMBER(8) NOT NULL
);

ALTER TABLE t_outro_custo ADD CONSTRAINT pk_t_outro_custo PRIMARY KEY ( cd_custo );

CREATE TABLE t_producao (
    cd_producao     NUMBER(8) NOT NULL,
    cd_renda_fat    NUMBER(8) NOT NULL,
    nm_estado       VARCHAR2(30) NOT NULL,
    nm_municipio    VARCHAR2(30) NOT NULL,
    dt_inicio_safra DATE NOT NULL,
    dt_fim_safra    DATE NOT NULL,
    ds_produto      VARCHAR2(30) NOT NULL,
    cd_produtor     NUMBER(8) NOT NULL
);

CREATE UNIQUE INDEX t_producao__idx ON
    t_producao (
        cd_renda_fat
    ASC );

ALTER TABLE t_producao ADD CONSTRAINT pk_t_producao PRIMARY KEY ( cd_producao,
                                                                  cd_produtor );

CREATE TABLE t_produtor (
    cd_produtor   NUMBER(8) NOT NULL,
    nm_produtor   VARCHAR2(30) NOT NULL,
    ds_endereco   VARCHAR2(100) NOT NULL,
    dt_nascimento DATE NOT NULL,
    nr_cpf        NUMBER(12) NOT NULL,
    nr_cnpj       NUMBER(15) NOT NULL,
    nr_telefone   NUMBER(11) NOT NULL,
    tp_produto    VARCHAR2(30) NOT NULL
);

ALTER TABLE t_produtor ADD CONSTRAINT pk_t_produtor PRIMARY KEY ( cd_produtor );

CREATE TABLE t_renda_fator (
    cd_renda_fat      NUMBER(8) NOT NULL,
    vl_remun_esperada NUMBER(8, 2) NOT NULL,
    vl_terra          NUMBER(8, 2) NOT NULL
);

ALTER TABLE t_renda_fator ADD CONSTRAINT pk_t_renda_fator PRIMARY KEY ( cd_renda_fat );

ALTER TABLE t_despesa_lavoura
    ADD CONSTRAINT fk_t_desp_lavo_t_prod FOREIGN KEY ( cd_producao,
                                                       cd_produtor )
        REFERENCES t_producao ( cd_producao,
                                cd_produtor );

ALTER TABLE t_desp_pos_clta
    ADD CONSTRAINT fk_t_desp_pos_colh_t_prod FOREIGN KEY ( cd_producao,
                                                           cd_produtor )
        REFERENCES t_producao ( cd_producao,
                                cd_produtor );

ALTER TABLE t_outro_custo
    ADD CONSTRAINT fk_t_outro_custo_t_producao FOREIGN KEY ( cd_producao,
                                                             cd_produtor )
        REFERENCES t_producao ( cd_producao,
                                cd_produtor );

ALTER TABLE t_producao
    ADD CONSTRAINT fk_t_producao_t_produtor FOREIGN KEY ( cd_produtor )
        REFERENCES t_produtor ( cd_produtor );

ALTER TABLE t_producao
    ADD CONSTRAINT fk_t_producao_t_renda_fator FOREIGN KEY ( cd_renda_fat )
        REFERENCES t_renda_fator ( cd_renda_fat );





