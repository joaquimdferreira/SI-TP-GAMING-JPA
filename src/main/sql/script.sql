---d)---
---procedimento que cria um novo jogador---
--      SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
CREATE OR REPLACE PROCEDURE novoJogador_trans(
    this_email VARCHAR(30),
    this_nome VARCHAR(15),
    this_id_regiao INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_regiao FROM REGIAO WHERE id_regiao = this_id_regiao)
    THEN
	    RAISE EXCEPTION SQLSTATE 'P0002' USING MESSAGE = 'id_regiao % not found';
    ELSEIF EXISTS (SELECT email FROM JOGADOR WHERE email = this_email)
    THEN
        RAISE EXCEPTION 'email % already exists', this_email USING errcode=45000;
    ELSEIF EXISTS (SELECT nome FROM JOGADOR WHERE nome = this_nome)
    THEN
        RAISE EXCEPTION 'name % already exists', this_nome USING errcode=45001;
    END IF;
    INSERT INTO JOGADOR (email, nome, id_regiao) values (this_email, this_nome, this_id_regiao);
END;
$$;

CREATE OR REPLACE PROCEDURE novoJogador(
    this_email VARCHAR(30),
    this_nome VARCHAR(15),
    this_id_regiao INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    CALL novoJogador_trans(this_email, this_nome, this_id_regiao);
    EXCEPTION
	    WHEN no_data_found THEN
	        ROLLBACK;
        WHEN sqlstate '45000' THEN
	        ROLLBACK;
        WHEN sqlstate '45001' THEN
	        ROLLBACK;
END;
$$;

---procedimento que desativa um jogador---
--      SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
CREATE OR REPLACE PROCEDURE desativarJogador_trans(
    this_nome VARCHAR(15)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT nome FROM JOGADOR WHERE nome = this_nome)
    THEN
        RAISE EXCEPTION SQLSTATE 'P0002' USING MESSAGE = 'nome not found';
    END IF;
    UPDATE JOGADOR SET estado='Inativo' WHERE nome=this_nome;
END;
$$;

CREATE OR REPLACE PROCEDURE desativarJogador(
    this_nome VARCHAR(15)
)
LANGUAGE plpgsql
AS $$
BEGIN
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    CALL desativarJogador_trans(this_nome);
    EXCEPTION
	    WHEN no_data_found THEN
	        ROLLBACK;
END;
$$;

---procedimento que bane um jogador---
--      SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
CREATE OR REPLACE PROCEDURE banirJogador_trans(
    this_nome VARCHAR(15)
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT nome FROM JOGADOR WHERE nome = this_nome)
    THEN
        RAISE EXCEPTION SQLSTATE 'P0002' USING MESSAGE = 'nome not found';
    END IF;
    UPDATE JOGADOR SET estado='Banido' WHERE nome=this_nome;
END;
$$;

CREATE OR REPLACE PROCEDURE banirJogador(
    this_nome VARCHAR(15)
)
LANGUAGE plpgsql
AS $$
BEGIN
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    CALL banirJogador_trans(this_nome);
    EXCEPTION
	    WHEN no_data_found THEN
	        ROLLBACK;
END;
$$;



---e)---
---Retorna o total de pontos de um certo jogador
--      SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
CREATE OR REPLACE FUNCTION totalPontosJogador(
    this_id_jogador INTEGER
)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_jogador FROM JOGADOR WHERE id_jogador = this_id_jogador)
    THEN
        RAISE EXCEPTION SQLSTATE 'P0002' USING MESSAGE = 'id_jogador not found';
    END IF;
    IF NOT EXISTS (SELECT pontuacao FROM PARTIDA_NORMAL WHERE id_jogador=this_id_jogador) 
    AND NOT EXISTS (SELECT pontuacao FROM PARTIDA_MULTIJOGADOR WHERE id_jogador=this_id_jogador)
    THEN
        RETURN 0;
    ELSE
        RETURN (
            SELECT (CASE 
                WHEN pontos_normal IS NULL THEN pontos_multijogador 
                WHEN pontos_multijogador IS NULL THEN pontos_normal 
                ELSE (pontos_normal + pontos_multijogador)
            END) AS pontos
            FROM(
                SELECT id_jogador, SUM(pontuacao) AS pontos_normal 
                FROM PARTIDA_NORMAL
                WHERE id_jogador = this_id_jogador
                GROUP BY id_jogador
            ) AS PN FULL JOIN (
                SELECT id_jogador, SUM(pontuacao) AS pontos_multijogador 
                FROM PARTIDA_MULTIJOGADOR
                WHERE id_jogador = this_id_jogador
                GROUP BY id_jogador
            ) AS PM 
            ON PN.id_jogador = PM.id_jogador
            );
        END IF;
END;
$$;



---f)---
---Retorna o número total de jogos diferentes que um jogador participou
--      SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
CREATE OR REPLACE FUNCTION totalJogosJogador(
    this_id_jogador INTEGER
)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT id_jogador FROM JOGADOR WHERE id_jogador = this_id_jogador)
    THEN
        RAISE EXCEPTION SQLSTATE 'P0002' USING MESSAGE = 'id_jogador not found';
    END IF;
    RETURN(
        SELECT count(DISTINCT ref_jogo) AS cnt_jogos
        FROM(
            SELECT n_partida, id_jogador
            FROM PARTIDA_NORMAL
            WHERE id_jogador = this_id_jogador
        ) AS PN FULL JOIN (
            SELECT n_partida, id_jogador
            FROM PARTIDA_MULTIJOGADOR
            WHERE id_jogador = this_id_jogador
        ) AS PM 
        ON PN.id_jogador = PM.id_jogador
        JOIN PARTIDA P
        ON PN.n_partida = P.n_partida OR PM.n_partida = P.n_partida
    );
END;
$$;



---g---
-- Obtém os total de pontos de um jogo por jogador e retorna uma tabela com o identificador do jogador e o total de pontos
--      SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
CREATE OR REPLACE FUNCTION pontosJogoPorJogador(this_jogo CHAR(10))
RETURNS TABLE (id_jogador integer, pontos bigint)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT ref_jogo FROM JOGO WHERE ref_jogo = this_jogo)
    THEN
        RAISE EXCEPTION SQLSTATE 'P0002' USING MESSAGE = 'ref_jogo not found';
    END IF;
    RETURN QUERY SELECT
        (CASE 
            WHEN PN.id_jogador IS NULL THEN PM.id_jogador 
            ELSE PN.id_jogador 
        END) AS jogador, 
        (CASE WHEN pontos_normal IS NULL THEN pontos_multijogador 
            WHEN pontos_multijogador IS NULL THEN pontos_normal 
            ELSE (pontos_normal + pontos_multijogador) END) AS pontos
        FROM ( SELECT PNOR.id_jogador, SUM(pontuacao) AS pontos_normal 
                FROM PARTIDA_NORMAL PNOR
                INNER JOIN PARTIDA PAR ON PNOR.n_partida = PAR.n_partida
                WHERE ref_jogo = this_jogo
                GROUP BY PNOR.id_jogador) AS PN
        FULL JOIN ( SELECT PMJ.id_jogador, SUM(pontuacao) AS pontos_multijogador 
                FROM PARTIDA_MULTIJOGADOR PMJ
                INNER JOIN PARTIDA PAR2 ON PMJ.n_partida = PAR2.n_partida                   
                WHERE ref_jogo = this_jogo
                GROUP BY PMJ.id_jogador) AS PM
        ON PN.id_jogador = PM.id_jogador;
END;
$$;



---h)---
--Atribui um crachá a um utilizador
--      SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
CREATE OR REPLACE PROCEDURE associarCracha_procedure(
    this_jogador INTEGER,
    this_jogo CHAR(10),
    this_cracha VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
DECLARE
    min_pontos INTEGER;
    cracha_id INTEGER;
BEGIN
    IF NOT EXISTS (SELECT * FROM CRACHA WHERE nome_cracha = this_cracha) OR
        NOT EXISTS (SELECT * FROM COMPRA WHERE id_jogador = this_jogador AND ref_jogo = this_jogo)
    THEN
        RAISE EXCEPTION SQLSTATE 'P0002' USING MESSAGE = 'ref_jogo or nome_cracha not found';
    END IF;
    SELECT pontos_limite, id_cracha INTO min_pontos, cracha_id FROM CRACHA WHERE nome_cracha = this_cracha AND ref_jogo = this_jogo;
    IF NOT EXISTS (SELECT * FROM pontosJogoPorJogador(this_jogo) WHERE id_jogador = this_jogador AND pontos >= min_pontos)
    THEN
        RAISE EXCEPTION SQLSTATE '31312' USING MESSAGE = 'jogador doesnt have enough point for cracha';
    END IF;
    IF EXISTS (SELECT * FROM CRACHA_JOGADOR WHERE id_cracha = cracha_id AND id_jogador = this_jogador)
    THEN
        RAISE EXCEPTION SQLSTATE '35672' USING MESSAGE = 'jogador already has cracha';
    END IF;

    INSERT INTO CRACHA_JOGADOR(id_cracha, id_jogador)
    VALUES (cracha_id, this_jogador);
END;
$$;

CREATE OR REPLACE PROCEDURE associarCracha_call(
    this_jogador INTEGER,
    this_jogo CHAR(10),
    this_cracha VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
BEGIN
    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    CALL associarCracha_procedure(this_jogador, this_jogo, this_cracha);
    EXCEPTION
	    WHEN no_data_found THEN
	        ROLLBACK;
        WHEN sqlstate '31312' THEN
	        ROLLBACK;
        WHEN sqlstate '35672' THEN
	        ROLLBACK;
END;
$$;

CREATE OR REPLACE PROCEDURE associarCracha(
    this_jogador INTEGER,
    this_jogo CHAR(10),
    this_cracha VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
BEGIN
    ROLLBACK;
    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    CALL associarCracha_call(this_jogador, this_jogo, this_cracha);
END;
$$;



---i)---
--Inicia uma conversa associando automaticamente um jogador
--      SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
CREATE OR REPLACE PROCEDURE iniciarConversa_procedure(
    IN this_jogador INTEGER,
    IN this_conversa VARCHAR(30),
    OUT ret_id_conversa INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT nome FROM JOGADOR WHERE id_jogador = this_jogador)
    THEN
        RAISE EXCEPTION SQLSTATE 'P0002' USING MESSAGE = 'id_jogador not found';
    END IF;
    IF EXISTS (SELECT * FROM CONVERSA WHERE nome_conversa = this_conversa)
    THEN
        RAISE EXCEPTION '% already exists', this_conversa USING errcode=45000;
    END IF;
    INSERT INTO CONVERSA(nome_conversa, id_jogador)
    VALUES(this_conversa, this_jogador);
    SELECT id_conversa INTO ret_id_conversa FROM CONVERSA WHERE nome_conversa = this_conversa AND id_jogador = this_jogador;
END;
$$;

CREATE OR REPLACE PROCEDURE iniciarConversa(
    IN this_jogador INTEGER,
    IN this_conversa VARCHAR(30),
    OUT ret_id_conversa INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    CALL iniciarConversa_procedure(this_jogador, this_conversa, ret_id_conversa);
    EXCEPTION
	    WHEN no_data_found THEN
	        ROLLBACK;
        WHEN sqlstate '45000' THEN
	        ROLLBACK;
END;
$$;



---j)---
--Junta um jogador a uma conversa
--      SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
CREATE OR REPLACE PROCEDURE juntarConversa_procedure(
    this_jogador INTEGER,
    this_conversa INTEGER
)
LANGUAGE plpgsql
AS $$
DECLARE
    c_nome VARCHAR(30);
BEGIN
    IF NOT EXISTS(SELECT * FROM CONVERSA WHERE id_conversa = this_conversa)
    THEN
        RAISE EXCEPTION SQLSTATE 'P0002' USING MESSAGE = 'id_conversa not found';
    END IF;
    IF EXISTS (SELECT * FROM CONVERSA WHERE id_conversa = this_conversa AND id_jogador = this_jogador)
    THEN
        RAISE EXCEPTION 'id_jogador is already associated with %', this_conversa USING errcode=45000;
    END IF;
    SELECT nome_conversa INTO c_nome FROM CONVERSA WHERE id_conversa = this_conversa;
    INSERT INTO CONVERSA(id_conversa, nome_conversa, id_jogador)
    VALUES(this_conversa, c_nome, this_jogador);
END;
$$;

CREATE OR REPLACE PROCEDURE juntarConversa(
    this_jogador INTEGER,
    this_conversa INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    CALL juntarConversa_procedure(this_jogador, this_conversa);
    EXCEPTION
	    WHEN no_data_found THEN
	        ROLLBACK;
        WHEN sqlstate '45000' THEN
	        ROLLBACK;
END;
$$;



---k)---
--Insere nova mensagem associando ao jogador
--      SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
CREATE OR REPLACE PROCEDURE enviarMensagem_logic(
    this_jogador INTEGER,
    this_conversa INTEGER,
    this_text TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE 
    val_msg INTEGER := 1;
BEGIN
    IF NOT EXISTS(SELECT * FROM CONVERSA WHERE id_conversa = this_conversa)
    THEN
        RAISE EXCEPTION 'id_conversa % doesnt exist', this_conversa USING errcode=45000;
    END IF;
    IF NOT EXISTS(SELECT * FROM JOGADOR WHERE id_jogador = this_jogador)
    THEN
        RAISE EXCEPTION SQLSTATE 'P0002' USING MESSAGE = 'id_jogador not found';
    END IF;

    IF EXISTS(SELECT * FROM MENSAGEM WHERE id_conversa = this_conversa)
    THEN
        SELECT id_mensagem INTO val_msg FROM MENSAGEM WHERE id_conversa = 1 ORDER BY id_mensagem DESC LIMIT 1;
        val_msg = val_msg + 1;
    END IF;
    IF NOT EXISTS(SELECT * FROM CONVERSA WHERE id_conversa = this_conversa AND id_jogador = this_jogador)
    THEN
        CALL juntarConversa(this_jogador, this_conversa);
    END IF;

    INSERT INTO MENSAGEM(id_mensagem, id_conversa, data, texto, id_jogador)
    VALUES(val_msg, this_conversa, NOW(), this_text, this_jogador);
END;
$$;

CREATE OR REPLACE PROCEDURE enviarMensagem_call(
    this_jogador INTEGER,
    this_conversa INTEGER,
    this_text TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    CALL enviarMensagem_logic(this_jogador, this_conversa, this_text);
    EXCEPTION
	    WHEN no_data_found THEN
	        ROLLBACK;
        WHEN sqlstate '45000' THEN
	        ROLLBACK;
END;
$$;

CREATE OR REPLACE PROCEDURE enviarMensagem(
    this_jogador INTEGER,
    this_conversa INTEGER,
    this_text TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    ROLLBACK;
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
    CALL enviarMensagem_call(this_jogador, this_conversa, this_text);
END;
$$;



---l)---
--Cria uma vista que contém informação de todos os jogadores que não têm estado de Banido
CREATE OR REPLACE FUNCTION PartidasPorJogador(              --VERIFICAR E TESTAR
    this_jogador INTEGER
)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    n_pn INTEGER;
    n_pm INTEGER;
BEGIN
    SELECT COUNT(id_jogador) INTO n_pn FROM PARTIDA_NORMAL WHERE id_jogador = this_jogador;
    SELECT COUNT(id_jogador) INTO n_pm FROM PARTIDA_MULTIJOGADOR WHERE id_jogador = this_jogador;
    RETURN(n_pn+n_pm);
END;
$$;

CREATE OR REPLACE FUNCTION get_jti_data()
RETURNS TABLE (
    v_id_jogador integer, 
    v_estado VARCHAR(10), 
    v_email VARCHAR(30), 
    v_nome VARCHAR(15), 
    n_jogos INTEGER, 
    n_partidas INTEGER, 
    pontos_total INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
        SELECT id_jogador, 
            estado, 
            email,
            nome,
            totalJogosJogador(J.id_jogador) AS n_jogos, 
            PartidasPorJogador(J.id_jogador) AS n_partidas, 
            totalPontosJogador(J.id_jogador) AS pontos_total
        FROM(SELECT * FROM JOGADOR WHERE estado != 'Banido') J;
END;
$$;

CREATE OR REPLACE VIEW JOGADOR_TOTAL_INFO
AS SELECT v_id_jogador as id_jogador, v_estado as estado, v_email as email, v_nome as nome, n_jogos, n_partidas, pontos_total FROM get_jti_data();



---m)---
--Trigger que quando uma partida termina atribui automaticamente os crachás do jogo a que pertence
CREATE OR REPLACE FUNCTION jogoTerminado()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    this_id_jogador INTEGER := NEW.id_jogador;
    this_pont INTEGER := NEW.pontuacao;
    this_n_partida INTEGER := NEW.n_partida;
    this_jogo CHAR(10);
    this_cracha VARCHAR(50);
BEGIN	
    SELECT ref_jogo INTO this_jogo
    FROM PARTIDA
    WHERE n_partida = this_n_partida;

    FOR this_cracha IN (SELECT nome_cracha 
                        FROM CRACHA 
                        WHERE ref_jogo=this_jogo AND this_pont>=pontos_limite)
        LOOP	
        CALL associarCracha_procedure(this_id_jogador, this_jogo, this_cracha);
        END LOOP;
    RETURN NULL;
END;
$$;

CREATE OR REPLACE TRIGGER AutoCracha
AFTER UPDATE ON PARTIDA_MULTIJOGADOR
FOR EACH ROW
WHEN (OLD.estado IS DISTINCT FROM NEW.estado AND NEW.estado='Terminada')
EXECUTE FUNCTION jogoTerminado();


---n)---
--Trigger que permite após fazer delete a jogadorTotalInfo pôr todos os jogadores envolvidos no estado banido
CREATE OR REPLACE FUNCTION trigger_ban()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN 
    UPDATE JOGADOR SET estado = 'Banido' WHERE id_jogador = OLD.id_jogador;
    RETURN NULL;
END;
$$;

CREATE OR REPLACE TRIGGER AutoBanJogador
INSTEAD OF DELETE ON JOGADOR_TOTAL_INFO
FOR EACH ROW
EXECUTE FUNCTION trigger_ban();









---Funções auxiliares para tabelas de estatística---
--ESTATISTICA JOGADOR--
CREATE OR REPLACE PROCEDURE update_estatistica_jogador()
LANGUAGE plpgsql
AS $$
DECLARE
    npartidas INTEGER;
    njogos INTEGER;
    totalpontos INTEGER;
    jogador RECORD;
BEGIN
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
    FOR jogador IN SELECT id_jogador FROM JOGADOR LOOP
        npartidas := PartidasPorJogador(jogador.id_jogador);
        njogos := totalJogosJogador(jogador.id_jogador);
        totalpontos := totalPontosJogador(jogador.id_jogador);
        IF EXISTS(SELECT * FROM ESTATISTICA_JOGADOR WHERE id_jogador = jogador.id_jogador) THEN
            UPDATE ESTATISTICA_JOGADOR 
            SET n_partidas = npartidas, n_jogos = njogos, total_pontos_jogador = totalpontos
            WHERE id_jogador = jogador.id_jogador;
        ELSE
            INSERT INTO ESTATISTICA_JOGADOR(id_jogador, n_partidas, n_jogos, total_pontos_jogador)
            VALUES (jogador.id_jogador, npartidas, njogos, totalpontos);
        END IF;
    END LOOP;
    EXCEPTION WHEN OTHERS THEN ROLLBACK;
END;
$$;



--ESTATISTICA JOGO--
CREATE OR REPLACE FUNCTION totalJogadoresJogo(
    this_jogo CHAR(10)
)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT ref_jogo FROM JOGO WHERE ref_jogo = this_jogo)
    THEN
        RAISE EXCEPTION SQLSTATE 'P0002' USING MESSAGE = 'ref_jogo not found';
    END IF;
    RETURN(
        SELECT count(DISTINCT (CASE 
            WHEN PN.id_jogador IS NULL THEN PM.id_jogador 
            ELSE PN.id_jogador 
        END)) AS cnt_jgdrs
        FROM(
            SELECT n_partida, id_jogador
            FROM PARTIDA_NORMAL
        ) AS PN FULL JOIN (
            SELECT n_partida, id_jogador
            FROM PARTIDA_MULTIJOGADOR
        ) AS PM 
        ON PN.id_jogador = PM.id_jogador
        JOIN PARTIDA P
        ON PN.n_partida = P.n_partida OR PM.n_partida = P.n_partida
        WHERE ref_jogo = this_jogo
    );
END;
$$;

CREATE OR REPLACE PROCEDURE update_estatistica_jogo()
LANGUAGE plpgsql
AS $$
DECLARE
    npartidas INTEGER;
    njogadores INTEGER;
    totalpontos INTEGER;
    jogo RECORD;
BEGIN
    FOR jogo IN SELECT ref_jogo FROM JOGO LOOP
        SELECT COUNT(n_partida) INTO npartidas FROM PARTIDA WHERE ref_jogo = jogo.ref_jogo;
        njogadores := totalJogadoresJogo(jogo.ref_jogo);
        SELECT SUM(pontos) INTO totalpontos FROM pontosJogoPorJogador(jogo.ref_jogo);
        IF totalpontos IS NULL THEN totalpontos := 0; END IF;
        IF EXISTS(SELECT * FROM ESTATISTICA_JOGO WHERE ref_jogo = jogo.ref_jogo) THEN
            UPDATE ESTATISTICA_JOGO
            SET n_partidas = npartidas, n_jogadores = njogadores, total_pontos_jogo = totalpontos
            WHERE ref_jogo = jogo.ref_jogo;
        ELSE
            INSERT INTO ESTATISTICA_JOGO(ref_jogo, n_partidas, n_jogadores, total_pontos_jogo)
            VALUES (jogo.ref_jogo, npartidas, njogadores, totalpontos);
        END IF;
    END LOOP;
END;
$$;
