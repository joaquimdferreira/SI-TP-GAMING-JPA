CREATE TABLE REGIAO (
    id_regiao SERIAL NOT NULL,
    nome_regiao VARCHAR(30) NOT NULL,
    CONSTRAINT reg_id_regiao PRIMARY KEY (id_regiao),
    CONSTRAINT reg_nome_regiao UNIQUE (nome_regiao)
);

CREATE TABLE JOGADOR(
    id_jogador SERIAL NOT NULL,
    email VARCHAR(30) NOT NULL CHECK(email LIKE '%_@__%.__%'),
    nome VARCHAR(15) NOT NULL,
    estado VARCHAR(10) NOT NULL DEFAULT 'Ativo' CHECK(estado IN ('Ativo', 'Inativo', 'Banido')),
    id_regiao INTEGER NOT NULL,
    CONSTRAINT jgd_id_jogador PRIMARY KEY (id_jogador),
    FOREIGN KEY (id_regiao) REFERENCES REGIAO (id_regiao),
    CONSTRAINT jgd_nome UNIQUE (nome),
    CONSTRAINT jgd_email UNIQUE (email)
);

CREATE TABLE JOGO (
    ref_jogo CHAR(10) NOT NULL CHECK(ref_jogo SIMILAR TO '[AZa-z0-9]{10}'),
    nome VARCHAR(50) NOT NULL,
    url VARCHAR(50) NOT NULL CHECK(url LIKE 'www.%_.__%'),
    CONSTRAINT jgo_ref_jogo PRIMARY KEY (ref_jogo),
    CONSTRAINT jgo_nome UNIQUE (nome)
);

CREATE TABLE COMPRA (
    id_compra SERIAL NOT NULL,
    id_jogador INTEGER NOT NULL,
    ref_jogo CHAR(10) NOT NULL,
    data TIMESTAMP NOT NULL CHECK(NOW() > data),
    preco NUMERIC(4,2) NOT NULL CHECK(preco > 0),
    CONSTRAINT com_id_compra PRIMARY KEY (id_compra),
    FOREIGN KEY (id_jogador) REFERENCES JOGADOR (id_jogador),
    FOREIGN KEY (ref_jogo) REFERENCES JOGO (ref_jogo)
);

CREATE TABLE PARTIDA (
    n_partida SERIAL NOT NULL,
    ref_jogo CHAR(10) NOT NULL,
    data_inicio TIMESTAMP NOT NULL CHECK(NOW() > data_inicio),
    data_fim TIMESTAMP CHECK((data_fim is null) or (data_fim is not null and NOW() > data_fim and data_fim > data_inicio)),
    id_regiao INTEGER NOT NULL,
    CONSTRAINT par_n_partida PRIMARY KEY (n_partida),
    FOREIGN KEY (ref_jogo) REFERENCES JOGO (ref_jogo),
    FOREIGN KEY (id_regiao) REFERENCES REGIAO (id_regiao)
);

--verificar se o jogador pertence a regiao com um check especial
CREATE TABLE PARTIDA_NORMAL (
    n_partida INTEGER NOT NULL,
    id_jogador SERIAL NOT NULL,
    dificuldade SMALLINT NOT NULL CHECK(dificuldade < 6 AND dificuldade > 0),
    pontuacao INTEGER NOT NULL,
    FOREIGN KEY (n_partida) REFERENCES PARTIDA (n_partida),
    FOREIGN KEY (id_jogador) REFERENCES JOGADOR (id_jogador),
    CONSTRAINT pno_n_partida PRIMARY KEY (n_partida)
);

--verificar se o jogador pertence a regiao
--para estado terminada, data fim nao Ã© nula
CREATE TABLE PARTIDA_MULTIJOGADOR (
    n_partida INTEGER NOT NULL,
    id_jogador INTEGER NOT NULL,
    pontuacao INTEGER NOT NULL CHECK((estado IN ('Por iniciar', 'A aguardar jogadores') AND pontuacao = 0) OR estado IN ('Em curso', 'Terminada')),
    estado VARCHAR(30) NOT NULL CHECK(estado IN ('Por iniciar', 'A aguardar jogadores', 'Em curso', 'Terminada')),
    FOREIGN KEY (n_partida) REFERENCES PARTIDA (n_partida),
    FOREIGN KEY (id_jogador) REFERENCES JOGADOR(id_jogador),
    CONSTRAINT pmu_pk PRIMARY KEY (n_partida, id_jogador)
);

CREATE TABLE CRACHA (
    id_cracha SERIAL NOT NULL,
    nome_cracha VARCHAR(50) NOT NULL,
    ref_jogo CHAR(10) NOT NULL,
    pontos_limite INTEGER NOT NULL,
    url_imagem VARCHAR(50) NOT NULL CHECK(url_imagem LIKE 'www.%_.__%'),
    CONSTRAINT cra_id_cracha PRIMARY KEY (id_cracha),
    CONSTRAINT cra_nome_cracha UNIQUE (nome_cracha, ref_jogo),
    FOREIGN KEY (ref_jogo) REFERENCES JOGO (ref_jogo)
);

--verificar se jogador tem o jogo
CREATE TABLE CRACHA_JOGADOR (
    id_cracha INTEGER NOT NULL,
    id_jogador INTEGER NOT NULL,
    CONSTRAINT crj_id_cracha PRIMARY KEY (id_cracha, id_jogador),
    FOREIGN KEY (id_cracha) REFERENCES CRACHA (id_cracha),
    FOREIGN KEY (id_jogador) REFERENCES JOGADOR (id_jogador)
);

--Estatística de cada jogador               CRIAR FUNÇÕES DEFAULT
CREATE TABLE ESTATISTICA_JOGADOR (
    id_jogador INTEGER NOT NULL,
    n_partidas INTEGER NOT NULL,
    n_jogos INTEGER NOT NULL,
    total_pontos_jogador INTEGER,
    CONSTRAINT ejd_id_jogador PRIMARY KEY (id_jogador),
    FOREIGN KEY (id_jogador) REFERENCES JOGADOR (id_jogador)
);

--Estatística de cada jogo                  CRIAR FUNÇÕES DEFAULT
CREATE TABLE ESTATISTICA_JOGO (
    ref_jogo CHAR(10) NOT NULL,
    n_partidas INTEGER NOT NULL,
    n_jogadores INTEGER NOT NULL,
    total_pontos_jogo INTEGER NOT NULL,
    CONSTRAINT ejg_ref_jogo PRIMARY KEY (ref_jogo),
    FOREIGN KEY (ref_jogo) REFERENCES JOGO (ref_jogo)
);

--jogadores teem de ser da mesma regiao
CREATE TABLE AMIGOS (
    id_jogador1 INTEGER NOT NULL CHECK(id_jogador1 != id_jogador2),
    id_jogador2 INTEGER NOT NULL,
    CONSTRAINT ami_id_jogador PRIMARY KEY (id_jogador1, id_jogador2),
    FOREIGN KEY (id_jogador1) REFERENCES JOGADOR (id_jogador),
    FOREIGN KEY (id_jogador2) REFERENCES JOGADOR (id_jogador)
);

CREATE TABLE CONVERSA (
    id_conversa SERIAL NOT NULL,
    nome_conversa VARCHAR(30) NOT NULL,
    id_jogador INTEGER NOT NULL,
    CONSTRAINT con_id_conversa PRIMARY KEY (id_conversa, id_jogador),
    FOREIGN KEY (id_jogador) REFERENCES JOGADOR (id_jogador)
);

CREATE TABLE MENSAGEM (
    id_mensagem SERIAL NOT NULL,
    id_conversa INTEGER NOT NULL,
    data TIMESTAMP NOT NULL CHECK(NOW() >= data),
    texto TEXT NOT NULL,
    id_jogador INTEGER NOT NULL,
    CONSTRAINT men_id_mensagem PRIMARY KEY (id_mensagem, id_conversa),
    FOREIGN KEY (id_conversa, id_jogador) REFERENCES CONVERSA (id_conversa, id_jogador)
);