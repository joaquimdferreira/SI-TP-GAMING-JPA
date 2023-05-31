--REGIOES
INSERT INTO REGIAO(id_regiao, nome_regiao)
VALUES
        (DEFAULT, 'Europa'),
        (DEFAULT, 'Asia'),
        (DEFAULT, 'America'),
        (DEFAULT, 'Africa'),
        (DEFAULT, 'Oceania');

--JOGADORES REGIAO 1
INSERT INTO JOGADOR(id_jogador, email, nome, estado, id_regiao)
VALUES
        (DEFAULT, 'manuel@gmail.com', 'SuperManuel4', 'Ativo', 1),
        (DEFAULT, 'tiago@gmail.com', 'TiagoTurbo', 'Inativo', 1),
        (DEFAULT, 'antoniocostapm@gmail.com', 'ToinoDoAco', 'Banido', 1),
        (DEFAULT, 'jose@gmail.com', '1904jose', 'Ativo', 1),
        (DEFAULT, 'ruben@gmail.com', 'amorimDepress', 'Inativo', 1),
        (DEFAULT, 'cavacosilva@gmail.com', 'decadenciaSilva', 'Banido', 1);

--JOGADORES REGIAO 2
INSERT INTO JOGADOR(id_jogador, email, nome, estado, id_regiao)
VALUES
        (DEFAULT, 'salvador@gmail.com', 'EurovisaoWinner', 'Ativo', 2),
        (DEFAULT, 'menteinativa@gmail.com', 'semideias24', 'Inativo', 2),
        (DEFAULT, 'assadordefrangos@gmail.com', 'PassosDoCoelho', 'Banido', 2),
        (DEFAULT, 'pepetripeiro@gmail.com', 'VermelhoDireto', 'Ativo', 2),
        (DEFAULT, 'ricardosic@gmail.com', 'RicardoAPereira', 'Inativo', 2),
        (DEFAULT, 'fernando@gmail.com', 'EsOFernando4', 'Banido', 2);

--JOGADORES REGIAO 3
INSERT INTO JOGADOR(id_jogador, email, nome, estado, id_regiao)
VALUES
        (DEFAULT, 'emmanuelle.macron@gmail.com', 'ViveLaFrance', 'Ativo', 3),
        (DEFAULT, 'alunoisel44444@gmail.com', 'AlunoISEL', 'Inativo', 3),
        (DEFAULT, 'avrelian@gmail.com', 'RestitvtorOrbis', 'Banido', 3),
        (DEFAULT, 'trajan@gmail.com', 'PaxRomana', 'Ativo', 3),
        (DEFAULT, 'octavian@gmail.com', 'CaesarAugvstvs', 'Inativo', 3),
        (DEFAULT, 'jvlivscaesar@gmail.com', 'EtTvBrvtvs', 'Banido', 3);

--JOGADORES REGIAO 4
INSERT INTO JOGADOR(id_jogador, email, nome, estado, id_regiao)
VALUES
        (DEFAULT, 'artorias@gmail.com', 'Abysswalker7', 'Ativo', 4),
        (DEFAULT, 'gwyn@gmail.com', 'LordOfCinder', 'Inativo', 4),
        (DEFAULT, 'iosif.stalin@gmail.com', 'ManOfSteel4', 'Banido', 4),
        (DEFAULT, 'winstonchurchill@gmail.com', 'Bulldog65', 'Ativo', 4),
        (DEFAULT, 'ronaldo@gmail.com', 'CR7', 'Inativo', 4),
        (DEFAULT, 'erlinghaaland@gmail.com', 'BallRobot8', 'Banido', 4);

--JOGADORES REGIAO 5
INSERT INTO JOGADOR(id_jogador, email, nome, estado, id_regiao)
VALUES
        (DEFAULT, 'luke.s@gmail.com', 'Skywalker34', 'Ativo', 5),
        (DEFAULT, 'grandma5@gmail.com', 'BakeCookies123', 'Inativo', 5),
        (DEFAULT, 'tonystark@gmail.com', 'IAmIronMan', 'Banido', 5),
        (DEFAULT, 'peterparker@gmail.com', 'Spidey96', 'Ativo', 5),
        (DEFAULT, 'vespasian@hotmail.com', 'BrittaniaRomana', 'Inativo', 5),
        (DEFAULT, 'deuspatriarei@gmail.com', 'HonrarPatria', 'Banido', 5);

--JOGOS
INSERT INTO JOGO(ref_jogo, nome, url)
VALUES
        ('n1n6sl7bhv', 'Europa Universalis IV', 'www.eu4.com'),
        ('v83u1zs4hq', 'Hearts of Iron IV', 'www.hoi4.com'),
        ('9d1q35q4rj', 'Crusader Kings III', 'www.ck3.com'),
        ('9kgr1hjcgf', 'Xadrez', 'www.chess.pt'),
        ('znbzp6x4u8', 'League Of Legends', 'www.lol.tv'),
        ('8tmtxdxjbe', 'Elden Ring', 'www.eldenring.com'),
        ('t2b4r1gs05', 'Minecraft', 'www.minecraft.net'),
        ('r2qwvkx9ms', 'Cookie Clicker', 'www.cookieclicker.com'),
        ('jkujbp6oad', 'Dark Souls III', 'www.ds3.com'),
        ('z6038h2yfq', 'Dark Souls Remastered', 'www.dsr.com');

--COMPRAS
INSERT INTO COMPRA(id_compra, id_jogador, ref_jogo, data, preco)
VALUES
        (DEFAULT, 1, '9kgr1hjcgf', TO_TIMESTAMP('13/6/2022 17:3:58', 'DD/MM/YYYY HH24:MI:SS'), 65.77),
        (DEFAULT, 1, 'z6038h2yfq', TO_TIMESTAMP('4/5/2021 8:45:54', 'DD/MM/YYYY HH24:MI:SS'), 27.73),
        (DEFAULT, 1, '9d1q35q4rj', TO_TIMESTAMP('8/3/2019 17:30:6', 'DD/MM/YYYY HH24:MI:SS'), 86.43),
        (DEFAULT, 1, '8tmtxdxjbe', TO_TIMESTAMP('7/3/2019 16:10:3', 'DD/MM/YYYY HH24:MI:SS'), 24.99),

        (DEFAULT, 2, '9kgr1hjcgf', TO_TIMESTAMP('4/10/2022 20:8:44', 'DD/MM/YYYY HH24:MI:SS'), 57.91),

        (DEFAULT, 3, '9d1q35q4rj', TO_TIMESTAMP('28/1/2021 5:21:30', 'DD/MM/YYYY HH24:MI:SS'), 74.72),
        (DEFAULT, 3, 'znbzp6x4u8', TO_TIMESTAMP('9/8/2018 1:15:39', 'DD/MM/YYYY HH24:MI:SS'), 12.89),
        (DEFAULT, 3, '9kgr1hjcgf', TO_TIMESTAMP('23/2/2020 15:48:53', 'DD/MM/YYYY HH24:MI:SS'), 11.42),

        (DEFAULT, 4, 'r2qwvkx9ms', TO_TIMESTAMP('27/12/2022 8:35:37', 'DD/MM/YYYY HH24:MI:SS'), 74.94),
        (DEFAULT, 4, 'n1n6sl7bhv', TO_TIMESTAMP('23/7/2022 21:38:51', 'DD/MM/YYYY HH24:MI:SS'), 58.17),

        (DEFAULT, 5, '8tmtxdxjbe', TO_TIMESTAMP('7/2/2018 5:0:26', 'DD/MM/YYYY HH24:MI:SS'), 40.29),

        (DEFAULT, 6, 'z6038h2yfq', TO_TIMESTAMP('26/8/2020 9:52:3', 'DD/MM/YYYY HH24:MI:SS'), 99.05),
        (DEFAULT, 6, 'r2qwvkx9ms', TO_TIMESTAMP('12/10/2020 21:27:35', 'DD/MM/YYYY HH24:MI:SS'), 38.95),

        (DEFAULT, 7, 'v83u1zs4hq', TO_TIMESTAMP('2/8/2020 15:35:28', 'DD/MM/YYYY HH24:MI:SS'), 70.71),
        (DEFAULT, 7, '9d1q35q4rj', TO_TIMESTAMP('7/11/2019 9:46:12', 'DD/MM/YYYY HH24:MI:SS'), 12.87),
        (DEFAULT, 7, 't2b4r1gs05', TO_TIMESTAMP('6/4/2019 12:10:29', 'DD/MM/YYYY HH24:MI:SS'), 47.98),

        (DEFAULT, 8, 'z6038h2yfq', TO_TIMESTAMP('26/10/2019 12:55:54', 'DD/MM/YYYY HH24:MI:SS'), 81.18),
        (DEFAULT, 8, 't2b4r1gs05', TO_TIMESTAMP('14/7/2019 16:4:1', 'DD/MM/YYYY HH24:MI:SS'), 6.49),
        (DEFAULT, 8, 'v83u1zs4hq', TO_TIMESTAMP('9/11/2021 23:59:9', 'DD/MM/YYYY HH24:MI:SS'), 62.32),

        (DEFAULT, 9, 'jkujbp6oad', TO_TIMESTAMP('14/8/2021 5:39:22', 'DD/MM/YYYY HH24:MI:SS'), 54.14),

        (DEFAULT, 10, 'n1n6sl7bhv', TO_TIMESTAMP('3/12/2019 2:5:26', 'DD/MM/YYYY HH24:MI:SS'), 40.98),
        (DEFAULT, 10, '9d1q35q4rj', TO_TIMESTAMP('28/11/2021 5:57:12', 'DD/MM/YYYY HH24:MI:SS'), 68.45),

        (DEFAULT, 11, 'v83u1zs4hq', TO_TIMESTAMP('10/3/2018 3:30:41', 'DD/MM/YYYY HH24:MI:SS'), 22.09),
        (DEFAULT, 11, 'n1n6sl7bhv', TO_TIMESTAMP('27/4/2021 15:49:30', 'DD/MM/YYYY HH24:MI:SS'), 19.87),

        (DEFAULT, 12, '9d1q35q4rj', TO_TIMESTAMP('20/7/2021 12:36:21', 'DD/MM/YYYY HH24:MI:SS'), 47.41),

        (DEFAULT, 13, 'jkujbp6oad', TO_TIMESTAMP('20/7/2021 1:31:0', 'DD/MM/YYYY HH24:MI:SS'), 11.4),
        (DEFAULT, 13, 'z6038h2yfq', TO_TIMESTAMP('7/11/2021 4:47:36', 'DD/MM/YYYY HH24:MI:SS'), 97.33),
        (DEFAULT, 13, '8tmtxdxjbe', TO_TIMESTAMP('9/7/2022 8:12:33', 'DD/MM/YYYY HH24:MI:SS'), 92.68),

        (DEFAULT, 14, 'z6038h2yfq', TO_TIMESTAMP('21/11/2022 18:44:55', 'DD/MM/YYYY HH24:MI:SS'), 5.83),
        (DEFAULT, 14, 'v83u1zs4hq', TO_TIMESTAMP('14/9/2020 21:9:27', 'DD/MM/YYYY HH24:MI:SS'), 79.21),

        (DEFAULT, 15, 'jkujbp6oad', TO_TIMESTAMP('24/8/2018 22:56:49', 'DD/MM/YYYY HH24:MI:SS'), 89.95),
        (DEFAULT, 15, '8tmtxdxjbe', TO_TIMESTAMP('25/12/2021 18:27:37', 'DD/MM/YYYY HH24:MI:SS'), 69.31),

        (DEFAULT, 16, 'jkujbp6oad', TO_TIMESTAMP('12/3/2018 11:40:43', 'DD/MM/YYYY HH24:MI:SS'), 65.68),
        (DEFAULT, 16, 'r2qwvkx9ms', TO_TIMESTAMP('8/8/2022 8:21:51', 'DD/MM/YYYY HH24:MI:SS'), 40.31),
        (DEFAULT, 16, 'znbzp6x4u8', TO_TIMESTAMP('28/8/2018 17:29:39', 'DD/MM/YYYY HH24:MI:SS'), 78.64),

        (DEFAULT, 17, 'znbzp6x4u8', TO_TIMESTAMP('20/4/2020 6:38:13', 'DD/MM/YYYY HH24:MI:SS'), 79.72),

        (DEFAULT, 18, 'n1n6sl7bhv', TO_TIMESTAMP('11/7/2018 2:51:40', 'DD/MM/YYYY HH24:MI:SS'), 98.92),

        (DEFAULT, 19, 't2b4r1gs05', TO_TIMESTAMP('6/6/2021 9:27:23', 'DD/MM/YYYY HH24:MI:SS'), 39.19),

        (DEFAULT, 20, 'znbzp6x4u8', TO_TIMESTAMP('19/10/2020 16:40:37', 'DD/MM/YYYY HH24:MI:SS'), 39.36),
        (DEFAULT, 20, 't2b4r1gs05', TO_TIMESTAMP('1/12/2021 21:18:46', 'DD/MM/YYYY HH24:MI:SS'), 94.37),
        (DEFAULT, 20, 'n1n6sl7bhv', TO_TIMESTAMP('10/3/2018 11:21:53', 'DD/MM/YYYY HH24:MI:SS'), 37.59),

        (DEFAULT, 21, '9d1q35q4rj', TO_TIMESTAMP('2/5/2019 18:6:53', 'DD/MM/YYYY HH24:MI:SS'), 70.43),

        (DEFAULT, 22, '9d1q35q4rj', TO_TIMESTAMP('6/11/2021 4:13:5', 'DD/MM/YYYY HH24:MI:SS'), 3.32),
        (DEFAULT, 22, 'znbzp6x4u8', TO_TIMESTAMP('17/1/2022 11:27:36', 'DD/MM/YYYY HH24:MI:SS'), 57.49),
        (DEFAULT, 22, 'n1n6sl7bhv', TO_TIMESTAMP('8/9/2021 17:42:36', 'DD/MM/YYYY HH24:MI:SS'), 88.66),

        (DEFAULT, 23, 'n1n6sl7bhv', TO_TIMESTAMP('26/11/2022 18:39:26', 'DD/MM/YYYY HH24:MI:SS'), 10.51),

        (DEFAULT, 24, 'n1n6sl7bhv', TO_TIMESTAMP('2/12/2020 7:20:38', 'DD/MM/YYYY HH24:MI:SS'), 96.48),

        (DEFAULT, 25, 't2b4r1gs05', TO_TIMESTAMP('15/6/2022 11:19:47', 'DD/MM/YYYY HH24:MI:SS'), 66.35),

        (DEFAULT, 26, '9d1q35q4rj', TO_TIMESTAMP('28/3/2022 2:6:51', 'DD/MM/YYYY HH24:MI:SS'), 0.54),
        (DEFAULT, 26, 'n1n6sl7bhv', TO_TIMESTAMP('7/10/2022 23:54:32', 'DD/MM/YYYY HH24:MI:SS'), 35.35),

        (DEFAULT, 27, '9kgr1hjcgf', TO_TIMESTAMP('22/12/2022 3:51:12', 'DD/MM/YYYY HH24:MI:SS'), 77.27),

        (DEFAULT, 28, 'r2qwvkx9ms', TO_TIMESTAMP('11/9/2018 5:46:38', 'DD/MM/YYYY HH24:MI:SS'), 2.8),
        (DEFAULT, 28, 'n1n6sl7bhv', TO_TIMESTAMP('14/9/2020 10:49:38', 'DD/MM/YYYY HH24:MI:SS'), 65.72),

        (DEFAULT, 29, 'znbzp6x4u8', TO_TIMESTAMP('25/3/2020 8:10:0', 'DD/MM/YYYY HH24:MI:SS'), 13.19),
        (DEFAULT, 29, '9kgr1hjcgf', TO_TIMESTAMP('19/7/2019 14:44:5', 'DD/MM/YYYY HH24:MI:SS'), 40.13),
        (DEFAULT, 29, 't2b4r1gs05', TO_TIMESTAMP('9/8/2018 4:36:27', 'DD/MM/YYYY HH24:MI:SS'), 41.25),
        
        (DEFAULT, 30, '9kgr1hjcgf', TO_TIMESTAMP('10/4/2021 13:43:41', 'DD/MM/YYYY HH24:MI:SS'), 92.3),
        (DEFAULT, 30, 'znbzp6x4u8', TO_TIMESTAMP('28/10/2018 13:28:6', 'DD/MM/YYYY HH24:MI:SS'), 94.27),
        (DEFAULT, 30, 'z6038h2yfq', TO_TIMESTAMP('16/5/2021 14:30:33', 'DD/MM/YYYY HH24:MI:SS'), 55.42);

--PARTIDAS
INSERT INTO PARTIDA(n_partida, ref_jogo, data_inicio, data_fim, id_regiao)
VALUES
--Estas sao partidas normais
(
        DEFAULT,
        'n1n6sl7bhv',
        TO_TIMESTAMP('11/4/2023 16:58:15', 'DD/MM/YYYY HH24:MI:SS'),
        NULL,
        1
),
(
        DEFAULT,
        'n1n6sl7bhv',
        TO_TIMESTAMP('13/4/2023 0:19:3', 'DD/MM/YYYY HH24:MI:SS'),
        NULL,
        5
),
(
        DEFAULT,
        'v83u1zs4hq',
        TO_TIMESTAMP('15/9/2018 0:26:58', 'DD/MM/YYYY HH24:MI:SS'),
        TO_TIMESTAMP('15/9/2018 1:25:27', 'DD/MM/YYYY HH24:MI:SS'),
        2
),
(
        DEFAULT,
        'v83u1zs4hq',
        TO_TIMESTAMP('12/12/2021 19:22:26', 'DD/MM/YYYY HH24:MI:SS'),
        TO_TIMESTAMP('12/12/2021 20:18:44', 'DD/MM/YYYY HH24:MI:SS'),
        2
),
(
        DEFAULT,
        '9d1q35q4rj',
        TO_TIMESTAMP('15/2/2022 11:58:1', 'DD/MM/YYYY HH24:MI:SS'),
        TO_TIMESTAMP('15/2/2022 12:57:58', 'DD/MM/YYYY HH24:MI:SS'),
        4
),
(
        DEFAULT,
        '9d1q35q4rj',
        TO_TIMESTAMP('9/9/2020 15:38:52', 'DD/MM/YYYY HH24:MI:SS'),
        TO_TIMESTAMP('9/9/2020 16:34:36', 'DD/MM/YYYY HH24:MI:SS'),
        5
),
(
        DEFAULT,
        '9d1q35q4rj',
        TO_TIMESTAMP('13/10/2022 16:29:38', 'DD/MM/YYYY HH24:MI:SS'),
        TO_TIMESTAMP('13/10/2022 17:20:40', 'DD/MM/YYYY HH24:MI:SS'),
        2
),
(
        DEFAULT,
        '9kgr1hjcgf',
        TO_TIMESTAMP('7/6/2021 0:50:49', 'DD/MM/YYYY HH24:MI:SS'),
        TO_TIMESTAMP('7/6/2021 1:44:41', 'DD/MM/YYYY HH24:MI:SS'),
        1
),
--Estas sao partidas multijogador
(
        DEFAULT,
        '9kgr1hjcgf',
        TO_TIMESTAMP('8/7/2021 14:47:42', 'DD/MM/YYYY HH24:MI:SS'),
        NULL,
        1
),
(
        DEFAULT,
        '9kgr1hjcgf',
        TO_TIMESTAMP('1/11/2018 1:43:29', 'DD/MM/YYYY HH24:MI:SS'),
        NULL,
        2
),
(
        DEFAULT,
        'znbzp6x4u8',
        TO_TIMESTAMP('9/6/2022 9:58:17', 'DD/MM/YYYY HH24:MI:SS'),
        TO_TIMESTAMP('9/6/2022 10:55:48', 'DD/MM/YYYY HH24:MI:SS'),
        5
),
(
        DEFAULT,
        'znbzp6x4u8',
        TO_TIMESTAMP('10/9/2018 10:49:24', 'DD/MM/YYYY HH24:MI:SS'),
        NULL,
        5
),
(
        DEFAULT,
        'n1n6sl7bhv',
        TO_TIMESTAMP('7/9/2020 1:27:56', 'DD/MM/YYYY HH24:MI:SS'),
        TO_TIMESTAMP('7/9/2020 2:20:29', 'DD/MM/YYYY HH24:MI:SS'),
        2
),
(
        DEFAULT,
        't2b4r1gs05',
        TO_TIMESTAMP('12/1/2022 12:57:50', 'DD/MM/YYYY HH24:MI:SS'),
        TO_TIMESTAMP('12/1/2022 13:51:17', 'DD/MM/YYYY HH24:MI:SS'),
        2
),
(
        DEFAULT,
        't2b4r1gs05',
        TO_TIMESTAMP('19/12/2022 5:25:52', 'DD/MM/YYYY HH24:MI:SS'),
        TO_TIMESTAMP('19/12/2022 6:19:29', 'DD/MM/YYYY HH24:MI:SS'),
        4
),
(
        DEFAULT,
        'r2qwvkx9ms',
        TO_TIMESTAMP('6/6/2021 16:32:3', 'DD/MM/YYYY HH24:MI:SS'),
        TO_TIMESTAMP('6/6/2021 17:26:8', 'DD/MM/YYYY HH24:MI:SS'),
        2
),
(
        DEFAULT,
        '8tmtxdxjbe',
        TO_TIMESTAMP('6/6/2021 16:32:3', 'DD/MM/YYYY HH24:MI:SS'),
        TO_TIMESTAMP('6/6/2021 17:26:8', 'DD/MM/YYYY HH24:MI:SS'),
        1
);

--PARTIDAS NORMAIS
INSERT INTO PARTIDA_NORMAL(n_partida, id_jogador, dificuldade, pontuacao)
VALUES
        (1,  4, 3, 20),
        (2, 28, 1, 45),
        (3, 7, 2, 180),
        (4, 8, 5, 500),
        (5, 21, 4, 50),
        (6, 26, 1, 700),
        (7, 12, 2, 589),
        (8, 3, 5, 125);

--PARTIDAS MULTIJOGADOR
INSERT INTO PARTIDA_MULTIJOGADOR(n_partida, id_jogador, pontuacao, estado)
VALUES
        (9, 2, 0, 'A aguardar jogadores'),
        (9, 3, 0, 'A aguardar jogadores'),

        (10, 2, 0, 'Por iniciar'),

        (11, 29, 368, 'Terminada'),

        (12, 29, 467, 'Em curso'),
        (12, 30, 450, 'Em curso'),

        (13, 10, 678, 'Terminada'),
        (13, 11, 474, 'Terminada'),

        (14, 8, 645, 'Terminada'),

        (15, 19, 742, 'Terminada'),
        (15, 20, 404, 'Terminada'),

        (16, 4, 654, 'Terminada'),
        (16, 6, 632, 'Terminada'),

        (17, 1, 4000, 'Em curso');

--CRACHAS
INSERT INTO CRACHA(id_cracha, nome_cracha, ref_jogo, pontos_limite, url_imagem)
VALUES
        (DEFAULT, 'World Conquest', 'n1n6sl7bhv', 1000, 'www.eu4c1.com'),
        (DEFAULT, 'Big Blue Blob', 'n1n6sl7bhv', 600, 'www.eu4c2.com'),
        (DEFAULT, 'One Faith', 'n1n6sl7bhv', 1500, 'www.eu4c3.com'),

        (DEFAULT, 'Join a Faction', 'v83u1zs4hq', 300, 'www.hoi4c1.com'),
        (DEFAULT, '30 Minutes of Hell', 'v83u1zs4hq', 600, 'www.hoi4c2.com'),
        (DEFAULT, 'World Conquest', 'v83u1zs4hq', 1000, 'www.hoi4c3.com'),

        (DEFAULT, 'Alliance', '9d1q35q4rj', 700, 'www.ck3c1.com'),
        (DEFAULT, 'Empire Not Only in Name', '9d1q35q4rj', 800, 'www.ck3c2.com'),
        (DEFAULT, 'Crusader King', '9d1q35q4rj', 1200, 'www.ck3c3.com'),

        (DEFAULT, 'Ganha um Jogo', '9kgr1hjcgf', 200, 'www.chsc1.com'),
        (DEFAULT, 'Ganha 10 Jogos', '9kgr1hjcgf', 600, 'www.chsc2.com'),
        (DEFAULT, 'Ganha 50 Jogos', '9kgr1hjcgf', 1000, 'www.chsc3.com'),

        (DEFAULT, 'Mata um Inimigo', 'znbzp6x4u8', 100, 'www.lolc1.com'),
        (DEFAULT, 'Ganha um Jogo', 'znbzp6x4u8', 600, 'www.lolc2.com'),
        (DEFAULT, 'Fun With Friends', 'znbzp6x4u8', 9000, 'www.lolc3.com'),

        (DEFAULT, 'Age of Stars', '8tmtxdxjbe', 150, 'www.erc1.com'),
        (DEFAULT, 'Shardbearer Rykard', '8tmtxdxjbe', 1000, 'www.erc2.com'),
        (DEFAULT, 'Shardbearer Melania ', '8tmtxdxjbe', 5000, 'www.erc3.com'),

        (DEFAULT, 'Hot Topic', 't2b4r1gs05', 1000, 'www.mcc1.com'),
        (DEFAULT, 'Getting Hardware', 't2b4r1gs05', 2000, 'www.mcc2.com'),
        (DEFAULT, 'Ice Bucket Challenge', 't2b4r1gs05', 3000, 'www.mcc3.com'),

        (DEFAULT, 'Bake 1 Million Cookies', 'r2qwvkx9ms', 1000, 'www.ccc1.com'),
        (DEFAULT, 'Bake 1 Trillion Cookies', 'r2qwvkx9ms', 3000, 'www.ccc2.com'),
        (DEFAULT, 'Bake 1 Quadrillion Cookies', 'r2qwvkx9ms', 5000, 'www.ccc3.com'),

        (DEFAULT, 'Enkindle', 'jkujbp6oad', 400, 'www.ds3c1.com'),
        (DEFAULT, 'Abyss Watchers', 'jkujbp6oad', 7000, 'www.ds3c2.com'),
        (DEFAULT, 'The Dark Soul', 'jkujbp6oad', 15000, 'www.ds3c3.com'),

        (DEFAULT, 'Ornstein and Smough', 'z6038h2yfq', 200, 'www.ds1c1.com'),
        (DEFAULT, 'Knights Honour', 'z6038h2yfq', 700, 'www.ds1c2.com'),
        (DEFAULT, 'The Dark Soul', 'z6038h2yfq', 1100, 'www.ds1c3.com');

--CRACHA JOGADORES
INSERT INTO CRACHA_JOGADOR(id_cracha, id_jogador)
VALUES
        (1, 4), (2, 4), (2, 10),
        (4, 8), (5, 8), (5, 11),
        (6, 8), (6, 11), (6, 14),
        (9, 21), (10, 27), (10, 2),
        (11, 27), (11, 2), (11, 3),
        (13, 3), (14, 3), (14, 17),
        (14, 16), (15, 3), (16, 5),
        (17, 5), (18, 5), (19, 7),
        (19, 8), (20, 7), (22, 16),
        (22, 28), (23, 16), (24, 16),
        (24, 28), (28, 14), (29, 14),
        (30, 14), (25, 16), (28, 13);

--AMIGOS
INSERT INTO AMIGOS(id_jogador1, id_jogador2)
VALUES
        (1,4),(4,6),(3,6),(2,5),(2,1),
        (7,8),(8,9),(11,7),(12,7),(8,10),
        (13,14),(15,17),(18,13),(17,14),(16,13),
        (19,24),(19,23),(23,22),(22,21),(20,23),
        (30,26),(25,29),(27,28),(28,25),(30,27);

--CONVERSAS
INSERT INTO CONVERSA(id_conversa, nome_conversa, id_jogador)
VALUES
        (DEFAULT, 'grupo1', 1),
        (1, 'grupo1', 2),
        (1, 'grupo1', 3),
        (DEFAULT, 'conversaTasca', 6),
        (2, 'conversaTasca', 2),
        (DEFAULT, 'jogos', 27),
        (DEFAULT, 'unicornio', 1),
        (4, 'unicornio', 15),
        (4, 'unicornio', 6),
        (DEFAULT, 'monster', 18);

--MENSAGENS
INSERT INTO MENSAGEM(id_mensagem, id_conversa, data, texto, id_jogador)
VALUES
        (DEFAULT, 1, TO_TIMESTAMP('13/4/2023 0:19:3', 'DD/MM/YYYY HH24:MI:SS'), 'Ui...RIP', 1),
        (DEFAULT, 1, TO_TIMESTAMP('13/4/2023 0:34:3', 'DD/MM/YYYY HH24:MI:SS'), 'Acontece, é lidar', 2),
        (1, 4, TO_TIMESTAMP('13/4/2023 0:19:3', 'DD/MM/YYYY HH24:MI:SS'), 'Bora, praia, sem desculpas!!', 15);
