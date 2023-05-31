do $testes$
begin

---teste d)---
do language plpgsql
$$
begin 
---procedimento que cria um novo jogador---
    raise notice 'd) -> Testes não intrusivos SP com nível 2';
    raise notice 'Teste 1: procedimento que cria um novo jogador';

	CALL novoJogador('zoruark5@gmail.com', 'LugiaSB', 1);
	if exists (select * from JOGADOR where nome = 'LugiaSB') then
	    raise notice 'Teste 1.1 - Inserir/criar novo jogador com dados bem passados: Resultado OK';
	else
	    raise notice 'Teste 1.1 - Inserir/criar novo jogador com dados bem passados: Resultado FAIL';
	end if;

	CALL novoJogador('szrt@hotmail.com', 'fhTY78', 13);
	if exists (select * from JOGADOR where nome = 'fhTY78') then
	    raise notice 'Teste 1.2 - Inserir/criar novo jogador com id da região inexistente: Resultado OK';
	else
	    raise notice 'Teste 1.2 - Inserir/criar novo jogador com id da região inexistente: Resultado FAIL';
	end if;

    CALL novoJogador('salvador@gmail.com', 'TioDeCascais', 2);
	if exists (select * from JOGADOR where nome = 'TioDeCascais') then
	    raise notice 'Teste 1.3 - Inserir/criar novo jogador com email existente: Resultado OK';
	else
	    raise notice 'Teste 1.3 - Inserir/criar novo jogador com email existente: Resultado FAIL';
	end if;

---procedimento que desativa um jogador---
    raise notice 'Teste 2: procedimento que desativa um jogador';

    CALL desativarJogador('SuperManuel4');
	if exists (select * from JOGADOR where nome = 'SuperManuel4' and estado = 'Inativo') then
	    raise notice 'Teste 2.1 - Desativar jogador com nome existente: Resultado OK';
	else
	    raise notice 'Teste 2.1 - Desativar jogador com nome existente: Resultado FAIL';
	end if;
    
	CALL desativarJogador('Cervantes');
	if exists (select * from JOGADOR where nome = 'Cervantes') then
	    raise notice 'Teste 2.2 - Desativar jogador com nome inexistente: Resultado OK';
	else
	    raise notice 'Teste 2.2 - Desativar jogador com nome inexistente: Resultado FAIL';
	end if;

---procedimento que bane um jogador---
    raise notice 'Teste 3: procedimento que bane um jogador';

    CALL banirJogador('TiagoTurbo');
    if exists (select * from JOGADOR where nome = 'TiagoTurbo' and estado = 'Banido') then
	    raise notice 'Teste 3.1 - Banir jogador com nome existente: Resultado OK';
	else
	    raise notice 'Teste 3.1 - Banir jogador com nome existente: Resultado FAIL';
	end if;

    CALL banirJogador('Lotus');
    if exists (select * from JOGADOR where nome = 'Lotus' and estado = 'Banido') then
	    raise notice 'Teste 3.2 - Banir jogador com nome inexistente: Resultado OK';
	else
	    raise notice 'Teste 3.2 - Banir jogador com nome inexistente: Resultado FAIL';
	end if;

    ROLLBACK;
end;
$$;



---teste e)---
do
$$
declare k integer;
        code char(5) default '00000';
	    msg text;
        n integer;
begin
   raise notice 'e) -> Teste 4: função que retorna o total de pontos de um certo jogador';
   rollback;
   SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
   begin
      n = 4;
      k=totalPontosJogador(n);
	  if k <> 674 then
	      raise notice 'teste de totalPontosJogador(%) = % : Resultado FAIL', n, k;
	  else
	      raise notice 'teste de totalPontosJogador(%) = % : Resultado OK', n, k;
	  end if;
	  n = 29;
      k=totalPontosJogador(n);
	  if k <> 835 then
	      raise notice 'teste de totalPontosJogador(%) = % : Resultado FAIL',n,k;
	  else
	      raise notice 'teste de totalPontosJogador(%) = % : Resultado OK',n,k;
	  end if;
      n = 1;
      k=totalPontosJogador(n);
	  if k <> 0 then
	      raise notice 'teste de totalPontosJogador(%) = % : Resultado FAIL', n, k;
	  else
	      raise notice 'teste de totalPontosJogador(%) = % : Resultado OK', n, k;
	  end if;
      n = 33;
      k=totalPontosJogador(n);
      exception
      when others then
		      GET stacked DIAGNOSTICS 
                          code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;   
		      raise notice 'code=%, msg=%',code,msg;
			  raise notice 'teste de totalPontosJogador(%) : Resultado FAIL',n;
   end;
end;
$$;



---teste f)---
do
$$
declare k integer;
        code char(5) default '00000';
	    msg text;
        n integer;
begin
   raise notice 'f) -> Teste 5: função que retorna o número total de jogos diferentes que um jogador participou';
   rollback;
   SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
   begin
      n = 8;
      k=totalJogosJogador(n);
	  if k <> 2 then
	      raise notice 'teste de totalJogosJogador(%) = % : Resultado FAIL', n, k;
	  else
	      raise notice 'teste de totalJogosJogador(%) = % : Resultado OK', n, k;
	  end if;

	  n = 29;
      k=totalJogosJogador(n);
	  if k <> 1 then
	      raise notice 'teste de totalJogosJogador(%) = % : Resultado FAIL',n,k;
	  else
	      raise notice 'teste de totalJogosJogador(%) = % : Resultado OK',n,k;
	  end if;

      n = 1;
      k=totalJogosJogador(n);
	  if k <> 0 then
	      raise notice 'teste de totalJogosJogador(%) = % : Resultado FAIL', n, k;
	  else
	      raise notice 'teste de totalJogosJogador(%) = % : Resultado OK', n, k;
	  end if;
      
      n = 34;
      k=totalJogosJogador(n);
      exception
      when others then
		      GET stacked DIAGNOSTICS 
                          code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;   
		      raise notice 'code=%, msg=%',code,msg;
			  raise notice 'teste de totalJogosJogador(%) : Resultado FAIL',n;
   end;
end;
$$;



---teste g)---
do
$$
declare n CHAR(10);
        code char(5) default '00000';
	    msg text;
begin
   raise notice 'g) -> Teste 6: função que obtém os total de pontos de um jogo por jogador e retorna uma tabela com o identificador do jogador e o total de pontos';
   rollback;
   SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
   begin
      n = 'znbzp6x4u8';
	  if exists (
        SELECT * FROM pontosJogoPorJogador(n) WHERE id_jogador=29 and pontos=835
      ) then
	      raise notice 'teste de pontosJogoPorJogador(%) : Resultado OK',n;
	  else
	      raise notice 'teste de pontosJogoPorJogador(%) : Resultado FAIL',n;
	  end if;
      if exists (
        SELECT * FROM pontosJogoPorJogador('znbzp6x4u8') WHERE id_jogador=30 and pontos=450
      ) then
	      raise notice 'teste de pontosJogoPorJogador(%) : Resultado OK',n;
	  else
	      raise notice 'teste de pontosJogoPorJogador(%) : Resultado FAIL',n;
	  end if;
      n = 'a8bzp344u8';
      SELECT * FROM pontosJogoPorJogador(n);
      exception
      when others then
		      GET stacked DIAGNOSTICS 
                          code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;   
		      raise notice 'code=%, msg=%',code,msg;
			  raise notice 'teste de totalJogosJogador(%) : Resultado FAIL',n;
   end;
end;
$$;



---teste h)---
do language plpgsql
$$
begin 
    raise notice 'h) -> Testes não intrusivos SP com nível 3';
    raise notice 'Teste 7: procedimento que atribui um crachá a um utilizador';

	CALL associarCracha(29, 'znbzp6x4u8', 'Ganha um Jogo');
	if exists (select * from CRACHA_JOGADOR where id_jogador = 29 and id_cracha = 14) then
	    raise notice 'Teste 7.1 - Associar crachá a um jogador com dados bem passados: Resultado OK';
	else
	    raise notice 'Teste 7.1 - Associar crachá a um jogador com dados bem passados: Resultado FAIL';
	end if;

    CALL associarCracha(4, 'n1n6sl7bhv', 'World Conquest');
    if exists (select * from CRACHA_JOGADOR where id_jogador = 4 and id_cracha = 1) then
	    raise notice 'Teste 7.2 - Associar crachá a um jogador que já o tem: Resultado FAIL';
	else
	    raise notice 'Teste 7.2 - Associar crachá a um jogador que já o tem: Resultado OK';
	end if;

    CALL associarCracha(4, '41n6sljbJv', 'Yare Yare');
    if exists (select * from CRACHA_JOGADOR where id_jogador = 6) then
	    raise notice 'Teste 7.3 - Associar crachá que não existe a um jogador: Resultado OK';
	else
	    raise notice 'Teste 7.3 - Associar crachá que não existe a um jogador: Resultado FAIL';
	end if;

    ROLLBACK;
end;
$$;



---teste i)---
do language plpgsql
$$
declare res INTEGER;
begin 
    raise notice 'i) -> Testes não intrusivos SP com nível 2';
    raise notice 'Teste 8: procedimento que inicia uma conversa associando automaticamente um jogador';

	CALL iniciarConversa(3, 'MARVEL', res);
	if exists (select * from CONVERSA where nome_conversa='MARVEL') then
	    raise notice 'Teste 8.1 - Iniciar conversa inexistente com um jogador: Resultado OK';
	else
	    raise notice 'Teste 8.1 - Iniciar conversa inexistente com um jogador: Resultado FAIL';
	end if;

    CALL iniciarConversa(14, 'grupo1', res);
	if exists (select * from CONVERSA where nome_conversa='grupo1' AND id_jogador = 14) then
	    raise notice 'Teste 8.2 - Iniciar conversa existente com um jogador: Resultado OK';
	else
	    raise notice 'Teste 8.2 - Iniciar conversa existente com um jogador: Resultado FAIL';
	end if;

    ROLLBACK;
end;
$$;



---teste j)---
do language plpgsql
$$
begin 
    raise notice 'j) -> Testes não intrusivos SP com nível 2';
    raise notice 'Teste 9: procedimento que junta um jogador a uma conversa';

	CALL juntarConversa(11, 3);
	if exists (select * from CONVERSA where id_jogador=11 AND id_conversa=3) then
	    raise notice 'Teste 9.1 - Juntar jogador a conversa existente: Resultado OK';
	else
	    raise notice 'Teste 9.1 - Juntar jogador a conversa existente: Resultado FAIL';
	end if;

    CALL juntarConversa(11, 9);
	if exists (select * from CONVERSA where id_jogador=11 AND id_conversa=9) then
	    raise notice 'Teste 9.2 - Juntar jogador a conversa inexistente: Resultado OK';
	else
	    raise notice 'Teste 9.2 - Juntar jogador a conversa inexistente: Resultado FAIL';
	end if;

    ROLLBACK;
end;
$$;



---teste k)---
do language plpgsql
$$
begin 
    raise notice 'k) -> Testes não intrusivos SP com nível 3';
    raise notice 'Teste 10: procedimento que insere nova mensagem associando ao jogador';

	CALL enviarMensagem(3, 1, 'Tenho trabalhos a fazer, desculpem-me');
	if exists (select * from MENSAGEM where texto='Tenho trabalhos a fazer, desculpem-me') then
	    raise notice 'Teste 10.1 - Jogador duma conversa envia mensagem com os dados bem: Resultado OK';
	else
	    raise notice 'Teste 10.1 - Jogador duma conversa envia mensagem com os dados bem: Resultado FAIL';
	end if;

    ROLLBACK;
end;
$$;
/*
do language plpgsql
$$
begin 

	CALL enviarMensagem(13, 5, 'QUAIS SÃO OS VOSSOS MONSTROS FAVORITOS???');
	if exists (select * from CONVERSA where id_jogador=13 AND id_conversa=5) then
	    raise notice 'Teste 10.2 - Jogador envia mensagem numa conversa e é inserido com os dados bem: Resultado OK';
	else
	    raise notice 'Teste 10.2 - Jogador envia mensagem numa conversa e é inserido com os dados bem: Resultado FAIL';
	end if;

    ROLLBACK;
end;
$$;

do language plpgsql
$$
begin 

	CALL enviarMensagem(13, 34, 'QUAIS SÃO OS VOSSOS MONSTROS FAVORITOS???');
	if exists (select * from CONVERSA where id_jogador=13 AND id_conversa=34) then
	    raise notice 'Teste 10.3 - Jogador envia mensagem numa conversa inexistente e é inserido: Resultado OK';
	else
	    raise notice 'Teste 10.3 - Jogador envia mensagem numa conversa inexistente e é inserido: Resultado FAIL';
	end if;

    ROLLBACK;
end;
$$;
*/


---teste l)---
do language plpgsql
$$
begin 
   raise notice 'l) -> Teste 11: função que cria uma vista que contém informação de todos os jogadores que não têm estado de Banido';

	CREATE OR REPLACE VIEW JOGADOR_TOTAL_INFO
	AS SELECT v_id_jogador as id_jogador, v_estado as estado, v_email as email, v_nome as nome, n_jogos, n_partidas, pontos_total FROM get_jti_data();
	if exists (select * from JOGADOR_TOTAL_INFO where estado!='Banido') then
	    raise notice 'Teste 11.1 - Buscar tabela de jogadores que não têm o estado como banido: Resultado OK';
	else
	    raise notice 'Teste 11.1 - Buscar tabela de jogadores que não têm o estado como banido: Resultado FAIL';
	end if;

    ROLLBACK;
end;
$$;



---teste m)---
do language plpgsql
$$ 
declare 
       code char(5) default '00000';
	   msg text;
begin 
     raise notice 'm) -> Teste 12: trigger que quando uma partida termina atribui automaticamente os crachás do jogo a que pertence';

	 UPDATE PARTIDA_MULTIJOGADOR SET pontuacao = 7000, estado = 'Terminada' WHERE n_partida = 17 AND id_jogador = 1;
     assert exists (select * from CRACHA_JOGADOR WHERE id_jogador = 1 AND id_cracha = 16), 'Teste 12.1 - trigger AutoCracha: Resultado FAIL';
	 assert exists (select * from CRACHA_JOGADOR WHERE id_jogador = 1 AND id_cracha = 17), 'Teste 12.1 - trigger AutoCracha: Resultado FAIL';
	 assert exists (select * from CRACHA_JOGADOR WHERE id_jogador = 1 AND id_cracha = 18), 'Teste 12.1 - trigger AutoCracha: Resultado FAIL';
	 raise notice 'Teste 12.1 - trigger AutoCracha: Resultado OK';	

	 UPDATE PARTIDA_MULTIJOGADOR SET estado = 'Terminada' WHERE n_partida = 10 AND id_jogador = 2;
     assert not exists (select * from CRACHA_JOGADOR WHERE id_jogador = 2 AND id_cracha = 10), 'Teste 12.2 - trigger AutoCracha: Resultado FAIL';
	 assert not exists (select * from CRACHA_JOGADOR WHERE id_jogador = 2 AND id_cracha = 11), 'Teste 12.2 - trigger AutoCracha: Resultado FAIL';
	 raise notice 'Teste 12.2 - trigger AutoCracha: Resultado OK';	
	 				  
	 exception
	 	   when ASSERT_FAILURE then
		     GET stacked DIAGNOSTICS 
                          code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;   
		      raise notice 'code=%, msg=%',code,msg;

		   when others then
		      GET stacked DIAGNOSTICS 
                          code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;   
		      raise notice 'code=%, msg=%',code,msg;

	 rollback;
end;
$$;



---teste n)---
do language plpgsql
$$ 
declare 
       code char(5) default '00000';
	   msg text;
begin 
     raise notice 'n) -> Teste 13: trigger que permite após fazer delete a jogadorTotalInfo pôr todos os jogadores envolvidos no estado banido';

	 CREATE OR REPLACE VIEW JOGADOR_TOTAL_INFO
	 AS SELECT v_id_jogador as id_jogador, v_estado as estado, v_email as email, v_nome as nome, n_jogos, n_partidas, pontos_total FROM get_jti_data();


	 DELETE FROM JOGADOR_TOTAL_INFO WHERE id_jogador = 19;
     assert not exists (select * from JOGADOR_TOTAL_INFO WHERE id_jogador = 19), 'Teste 13.1 - trigger AutoBanJogador: Resultado FAIL';
	 raise notice 'Teste 13.1 - trigger AutoBanJogador: Resultado OK';	

	 DELETE FROM JOGADOR_TOTAL_INFO WHERE id_jogador = 1;
     assert not exists (select * from JOGADOR_TOTAL_INFO WHERE id_jogador = 1), 'Teste 13.1 - trigger AutoBanJogador: Resultado FAIL';
	 raise notice 'Teste 13.1 - trigger AutoBanJogador: Resultado OK';	
	
	 exception
	 	   when ASSERT_FAILURE then
		     GET stacked DIAGNOSTICS 
                          code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;   
		      raise notice 'code=%, msg=%',code,msg;

		   when others then
		      GET stacked DIAGNOSTICS 
                          code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;   
		      raise notice 'code=%, msg=%',code,msg;
	 
	 rollback;
end;
$$;



end; $testes$