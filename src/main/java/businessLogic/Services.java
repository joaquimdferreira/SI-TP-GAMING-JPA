package businessLogic;

import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.Query;
import jakarta.persistence.StoredProcedureQuery;
import model.Cracha;
import model.mappers.Mappers;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

public class Services {
    EntityManager em;
    BufferedReader reader;
    Mappers mappers;
    public Services(EntityManager em, BufferedReader reader) {
        this.em = em;
        this.reader = reader;
        this.mappers = new Mappers(em);
    }

    public void createJogador() throws IOException {            //WORKING
        System.out.println("Criar Jogador");
        System.out.print("Email: ");
        String email = reader.readLine();

        System.out.print("Nome: ");
        String nome = reader.readLine();

        System.out.print("Regiao: ");
        String regiao = reader.readLine();
        int id_regiao = Integer.parseInt(regiao);

        em.getTransaction().begin();
        try {
            Query q = em.createNativeQuery("call novoJogador_trans(?1, ?2, ?3)");
            q.setParameter(1, email);
            q.setParameter(2, nome);
            q.setParameter(3, id_regiao);

            q.executeUpdate();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            System.out.println("\nOperação Cancelada\n");
        }
    }

    public void desativarJogador() throws IOException {     //WORKING
        System.out.println("Desativar Jogador");
        System.out.print("Nome: ");
        String nome = reader.readLine();

        em.getTransaction().begin();
        try {
            Query q = em.createNativeQuery("call desativarJogador_trans(?1)");
            q.setParameter(1, nome);

            q.executeUpdate();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            System.out.println("\nOperação Cancelada\n");
        }
    }

    public void banirJogador() throws IOException {         //WORKING
        System.out.println("Banir Jogador");
        System.out.print("Nome: ");
        String nome = reader.readLine();

        em.getTransaction().begin();
        try {
            Query q = em.createNativeQuery("call banirJogador_trans(?1)");
            q.setParameter(1, nome);

            q.executeUpdate();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            System.out.println("\nOperação Cancelada\n");
        }
    }

    public void totalPontosJogador() throws IOException {           //WORKING
        System.out.println("Total de Pontos de Jogador");
        System.out.print("Id do Jogador: ");
        String id = reader.readLine();
        int id_jogador;
        try {
             id_jogador = Integer.parseInt(id);
        } catch (NumberFormatException e) {
            System.out.println("Id must be a number;");
            return;
        }
        em.getTransaction().begin();
        try {
            StoredProcedureQuery q = em.createStoredProcedureQuery("totalPontosJogador");
            q.registerStoredProcedureParameter(1, Integer.class, ParameterMode.IN);
            q.registerStoredProcedureParameter(2, Integer.class, ParameterMode.OUT);
            q.setParameter(1, id_jogador);

            q.execute();
            int total = (int) q.getOutputParameterValue(2);
            em.getTransaction().commit();
            System.out.println("Total de pontos: "+total);
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            System.out.println("\nOperação Cancelada\n");
        }
    }

    public void totalJogosJogador() throws IOException {           //WORKING
        System.out.println("Total de Jogos de Jogador");
        System.out.print("Id do Jogador: ");
        String id = reader.readLine();
        int id_jogador;
        try {
            id_jogador = Integer.parseInt(id);
        } catch (NumberFormatException e) {
            System.out.println("Id must be a number;");
            return;
        }
        em.getTransaction().begin();
        try {
            StoredProcedureQuery q = em.createStoredProcedureQuery("totalJogosJogador");
            q.registerStoredProcedureParameter(1, Integer.class, ParameterMode.IN);
            q.registerStoredProcedureParameter(2, Integer.class, ParameterMode.OUT);
            q.setParameter(1, id_jogador);

            q.execute();
            int total = (int) q.getOutputParameterValue(2);
            em.getTransaction().commit();
            System.out.println("Total número de jogos participados: "+total);
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            System.out.println("\nOperação Cancelada\n");
        }
    }

    public void pontosJogoPorJogador() throws IOException {           //WORKING
        System.out.println("Total Pontos por Jogador num Jogo");
        System.out.print("Id do Jogo: ");
        String ref = reader.readLine();
        em.getTransaction().begin();
        try {
            StoredProcedureQuery q = em.createStoredProcedureQuery("pontosJogoPorJogador");
            q.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
            q.setParameter(1, ref);
            List<Object[]> l = (List<Object[]>) q.getResultList();
            for(Object[] x : l) {
                int id_jogador = (Integer)x[0];
                long pontos = (Long)x[1];
                System.out.printf("Jogador/Pontos: %d/ %d \n", id_jogador, pontos);
            }

            q.execute();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            System.out.println("\nOperação Cancelada\n");
        }
    }

    public void associarCracha() throws IOException {           //WORKING
        System.out.println("Associar Cracha");
        System.out.print("Jogador Id: ");
        String id = reader.readLine();
        int id_jogador;
        try {
            id_jogador = Integer.parseInt(id);
        } catch (NumberFormatException e) {
            System.out.println("Id must be a number;");
            return;
        }
        System.out.print("Referencia Jogo: ");
        String ref = reader.readLine();
        System.out.print("Cracha: ");
        String tro = reader.readLine();
        em.getTransaction().begin();
        try {
            Query q = em.createNativeQuery("call associarCracha_procedure(?1, ?2, ?3)");
            q.setParameter(1, id_jogador);
            q.setParameter(2, ref);
            q.setParameter(3, tro);

            q.executeUpdate();
            em.getTransaction().commit();
            System.out.println("Crachá associado com sucesso!");
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            System.out.println("\nOperação Cancelada\n");
        }
    }

    public void iniciarConversa() throws IOException {          //WORKING
        System.out.println("Iniciar Conversa");
        System.out.print("Jogador Id: ");
        String id = reader.readLine();
        int id_jogador;
        try {
            id_jogador = Integer.parseInt(id);
        } catch (NumberFormatException e) {
            System.out.println("Id must be a number;");
            return;
        }
        System.out.print("Nome Conversa: ");
        String nome = reader.readLine();
        em.getTransaction().begin();
        try {
            StoredProcedureQuery q = em.createStoredProcedureQuery("iniciarConversa_function");
            q.registerStoredProcedureParameter(1, Integer.class, ParameterMode.IN);
            q.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
            q.registerStoredProcedureParameter(3, Integer.class, ParameterMode.OUT);
            q.setParameter(1, id_jogador);
            q.setParameter(2, nome);

            q.execute();
            int con_id = (int) q.getOutputParameterValue(3);
            em.getTransaction().commit();
            System.out.printf("Conversa criada com ID %d\n", con_id);
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            System.out.println("\nOperação Cancelada\n");
        }
    }

    public void juntarConversa() throws IOException {           //WORKING
        System.out.println("Juntar a Conversa");
        System.out.print("Jogador Id: ");
        String j = reader.readLine();
        System.out.print("Conversa Id: ");
        String c = reader.readLine();
        int id_jogador;
        int id_conversa;
        try {
            id_jogador = Integer.parseInt(j);
            id_conversa = Integer.parseInt(c);
        } catch (NumberFormatException e) {
            System.out.println("Id must be a number;");
            return;
        }
        em.getTransaction().begin();
        try {
            Query q = em.createNativeQuery("call juntarConversa_procedure(?1, ?2)");
            q.setParameter(1, id_jogador);
            q.setParameter(2, id_conversa);

            q.executeUpdate();
            em.getTransaction().commit();
            System.out.printf("Jogador com ID %d foi juntado à conversa com ID %d\n", id_jogador, id_conversa);
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            System.out.println("\nOperação Cancelada\n");
        }
    }

    public void enviarMensagem() throws IOException {           //WORKING
        System.out.println("Enviar Mensagem");
        System.out.print("Jogador Id: ");
        String j = reader.readLine();
        System.out.print("Conversa Id: ");
        String c = reader.readLine();
        int id_jogador;
        int id_conversa;
        try {
            id_jogador = Integer.parseInt(j);
            id_conversa = Integer.parseInt(c);
        } catch (NumberFormatException e) {
            System.out.println("Id must be a number;");
            return;
        }
        System.out.print("Texto: ");
        String texto = reader.readLine();
        em.getTransaction().begin();
        try {
            Query q = em.createNativeQuery("call enviarMensagem_logic(?1, ?2, ?3)");
            q.setParameter(1, id_jogador);
            q.setParameter(2, id_conversa);
            q.setParameter(3, texto);

            q.executeUpdate();
            em.getTransaction().commit();
            System.out.printf("Mensagem enviada com sucesso!");
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            System.out.println("\nOperação Cancelada\n");
        }
    }

    public void jogadorTotalInfo() {
        em.getTransaction().begin();
        System.out.println("Criando vista... ");
        try {
            Query q = em.createNativeQuery("CREATE OR REPLACE VIEW JOGADOR_TOTAL_INFO " +
                    "AS SELECT v_id_jogador as id_jogador, v_estado as estado, v_email as email, " +
                    "v_nome as nome, n_jogos, n_partidas, pontos_total " +
                    "FROM get_jti_data()");

            Query v = em.createNativeQuery("SELECT * FROM JOGADOR_TOTAL_INFO");

            q.executeUpdate();
            System.out.println("Vista criada\n");

            List<Object[]> l = (List<Object[]>) v.getResultList();
            System.out.println("Info atual de todos os jogadores:\n");
            System.out.println("Nome,  ID,  Estado,  Email,  Número de jogos,  Número de partidas,  Pontuação Total");
            for(Object[] x : l) {
                int id_jogador = (Integer)x[0];
                String estado = (String) x[1];
                String email = (String)x[2];
                String nome = (String)x[3];
                int n_jogos = (Integer)x[4];
                int n_partidas = (Integer)x[5];
                int pontos_total = (Integer)x[6];
                System.out.printf(" - %s, %d, %s, %s, %d, %d, %d\n",
                        nome, id_jogador, estado, email, n_jogos, n_partidas, pontos_total);
            }
            System.out.println();

            em.getTransaction().commit();

        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            System.out.println("\nOperação Cancelada\n");
        }
    }

    public void associarCracha2() throws IOException {
        System.out.println("Associar Cracha");
        System.out.print("Jogador Id: ");
        String id = reader.readLine();
        int id_jogador;
        try {
            id_jogador = Integer.parseInt(id);
        } catch (NumberFormatException e) {
            System.out.println("Id must be a number;");
            return;
        }
        System.out.print("Referencia Jogo: ");
        String ref = reader.readLine();
        System.out.print("Cracha: ");
        String tro = reader.readLine();
        em.getTransaction().begin();
        try {
            em.createNativeQuery("SET TRANSACTION ISOLATION LEVEL REPEATABLE READ").executeUpdate();
            Query checkCracha = em.createNativeQuery("SELECT * FROM CRACHA WHERE nome_cracha = '"+tro+"'");
            List<?> crachaResultList = checkCracha.getResultList();
            Query checkCompra = em.createNativeQuery(String.format(
                    "SELECT * FROM COMPRA WHERE id_jogador = "+id_jogador+" and ref_jogo = '"+ref+"'"
            ));
            List<?> compraResultList = checkCompra.getResultList();
            if(crachaResultList.isEmpty() || compraResultList.isEmpty())
                throw new RuntimeException("NOT FOUND IN ASSOCIAR CRACHA 2");
            Query getCrachaInfo = em.createNativeQuery(String.format(
                    "SELECT * FROM CRACHA WHERE nome_cracha = '"+tro+"' AND ref_jogo = '"+ref+"'"
            ));
            Object[] o = (Object[]) getCrachaInfo.getSingleResult();
            Cracha c = new Cracha((Integer) o[0], (String) o[1], (Integer) o[3], (String) o[4]);
            int lim_pontos = c.getPontos();
            int c_id = c.getId();
            String jogadorPontosJogo = String.format("SELECT * FROM (SELECT (CASE WHEN PN.id_jogador IS NULL THEN PM.id_jogador ELSE PN.id_jogador END) AS jogador, " +
                    "(CASE WHEN pontos_normal IS NULL THEN pontos_multijogador WHEN pontos_multijogador IS NULL THEN pontos_normal " +
                    "ELSE (pontos_normal + pontos_multijogador) END) AS pontos FROM ( SELECT PNOR.id_jogador, SUM(pontuacao) AS pontos_normal " +
                    "FROM PARTIDA_NORMAL PNOR INNER JOIN PARTIDA PAR ON PNOR.n_partida = PAR.n_partida WHERE ref_jogo = '"+ref+"' " +
                    "GROUP BY PNOR.id_jogador) AS PN FULL JOIN ( SELECT PMJ.id_jogador, SUM(pontuacao) AS pontos_multijogador " +
                    "FROM PARTIDA_MULTIJOGADOR PMJ INNER JOIN PARTIDA PAR2 ON PMJ.n_partida = PAR2.n_partida WHERE ref_jogo = '"+ref+"' " +
                    "GROUP BY PMJ.id_jogador) AS PM ON PN.id_jogador = PM.id_jogador)as R WHERE r.jogador = "+id_jogador+" AND r.pontos >= "+lim_pontos
            );
            em.createNativeQuery(jogadorPontosJogo).getSingleResult();
            if(!em.createNativeQuery(String.format("SELECT * FROM CRACHA_JOGADOR WHERE id_cracha = "+c_id+" AND id_jogador = "+id_jogador+"")).getResultList().isEmpty())
                throw new RuntimeException("JOGADOR JA TEM CRACHA");
            em.createNativeQuery(String.format("INSERT INTO CRACHA_JOGADOR(id_cracha, id_jogador) " +
                    "VALUES ("+c_id+", "+id_jogador+")")).executeUpdate();
            em.getTransaction().commit();
            System.out.println("Cracha Associado");
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            System.out.println("\nOperação Cancelada\n");
        }
    }

    public void associarCracha3() throws IOException {
        System.out.println("Associar Cracha");
        System.out.print("Jogador Id: ");
        String id = reader.readLine();
        int id_jogador;
        try {
            id_jogador = Integer.parseInt(id);
        } catch (NumberFormatException e) {
            System.out.println("Id must be a number;");
            return;
        }
        System.out.print("Referencia Jogo: ");
        String ref = reader.readLine();
        System.out.print("Cracha: ");
        String tro = reader.readLine();
        em.getTransaction().begin();
        try {
            em.createNativeQuery("SET TRANSACTION ISOLATION LEVEL REPEATABLE READ").executeUpdate();
            Query checkCracha = em.createNativeQuery("SELECT * FROM CRACHA WHERE nome_cracha = '"+tro+"'");
            List<?> crachaResultList = checkCracha.getResultList();
            Query checkCompra = em.createNativeQuery(String.format(
                    "SELECT * FROM COMPRA WHERE id_jogador = "+id_jogador+" and ref_jogo = '"+ref+"'"
            ));
            List<?> compraResultList = checkCompra.getResultList();
            if(crachaResultList.isEmpty() || compraResultList.isEmpty())
                throw new RuntimeException("NOT FOUND IN ASSOCIAR CRACHA 2");
            Query getCrachaInfo = em.createNativeQuery(String.format(
                    "SELECT * FROM CRACHA WHERE nome_cracha = '"+tro+"' AND ref_jogo = '"+ref+"'"
            ));
            Object[] o = (Object[]) getCrachaInfo.getSingleResult();
            Cracha c = new Cracha((Integer) o[0], (String) o[1], (Integer) o[3], (String) o[4]);
            int lim_pontos = c.getPontos();
            int c_id = c.getId();
            StoredProcedureQuery jogadorPontosJogo = em.createStoredProcedureQuery("pontosJogoPorJogador");
            jogadorPontosJogo.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
            jogadorPontosJogo.setParameter(1, ref);
            long j_pontos = ((List<Object[]>)jogadorPontosJogo.getResultList()).stream()
                    .filter( t -> (Integer)t[0] == id_jogador)
                    .map( t2 -> (Long)t2[1]).findFirst().get();
            if(lim_pontos > j_pontos)throw new RuntimeException("JOGADOR NAO TEM PONTOS SUFICIENTES");
            em.createNativeQuery(String.format("INSERT INTO CRACHA_JOGADOR(id_cracha, id_jogador) " +
                    "VALUES ("+c_id+", "+id_jogador+")")).executeUpdate();
            em.getTransaction().commit();
            System.out.println("Cracha Associado");
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
            System.out.println("\nOperação Cancelada\n");
        }
    }
}
