package businessLogic;

import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.Query;
import jakarta.persistence.StoredProcedureQuery;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;
import java.util.Objects;

public class Services {
    EntityManager em;
    BufferedReader reader;
    public Services(EntityManager em, BufferedReader reader) {
        this.em = em;
        this.reader = reader;
    }

    void createJogador() throws IOException {
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
            StoredProcedureQuery q = em.createStoredProcedureQuery("novoJogador_trans");
            q.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
            q.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
            q.registerStoredProcedureParameter(3, Integer.class, ParameterMode.IN);

            q.setParameter(1, email);
            q.setParameter(2, nome);
            q.setParameter(3, id_regiao);

            q.execute();

            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        }
    }

    void desativarJogador() throws IOException {
        System.out.println("Desativar Jogador");
        System.out.print("Nome: ");
        String nome = reader.readLine();

        em.getTransaction().begin();
        try {
            StoredProcedureQuery q = em.createStoredProcedureQuery("desativarJogador_trans");
            q.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
            q.setParameter(1, nome);
            q.execute();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        }
    }

    void banirJogador() throws IOException {
        System.out.println("Banir Jogador");
        System.out.print("Nome: ");
        String nome = reader.readLine();

        em.getTransaction().begin();
        try {
            StoredProcedureQuery q = em.createStoredProcedureQuery("banirJogador_trans");
            q.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
            q.setParameter(1, nome);
            q.execute();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        }
    }

    void totalPontosJogador() throws IOException {
        System.out.println("Total de Pontos de Jogador");
        System.out.print("Id: ");
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
            em.getTransaction().commit();
            int total = (int) q.getOutputParameterValue(2);
            System.out.println("Total de pontos: "+total);
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        }
    }

    void totalJogosJogador() throws IOException {
        System.out.println("Total de Jogos de Jogador");
        System.out.print("Id: ");
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
            em.getTransaction().commit();
            int total = (int) q.getOutputParameterValue(2);
            System.out.println("Total de pontos: "+total);
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        }
    }

    void pontosJogoPorJogador() throws IOException {
        System.out.println("Jogo - Pontos por Jogador");
        System.out.print("Id: ");
        String ref = reader.readLine();
        em.getTransaction().begin();
        try {
            StoredProcedureQuery q = em.createStoredProcedureQuery("totalJogosJogador");
            q.registerStoredProcedureParameter(1, String.class, ParameterMode.IN);
            q.setParameter(1, ref);
            q.execute();
            em.getTransaction().commit();
            List<Object[]> l = (List<Object[]>) q.getResultList();
            for(Object[] x : l) {
                int id_jogador = (Integer)x[0];
                int pontos = (Integer)x[1];
                System.out.printf("Jogador/Pontos: %d/ %d \n", id_jogador, pontos);
            }
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        }
    }

    void associarCracha() throws IOException {
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
            StoredProcedureQuery q = em.createStoredProcedureQuery("associarCracha");
            q.registerStoredProcedureParameter(1, Integer.class, ParameterMode.IN);
            q.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
            q.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);
            q.setParameter(1, id_jogador);
            q.setParameter(2, ref);
            q.setParameter(3, tro);
            q.execute();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        }
    }

    void iniciarConversa() throws IOException {
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
            StoredProcedureQuery q = em.createStoredProcedureQuery("iniciarConversa");
            q.registerStoredProcedureParameter(1, Integer.class, ParameterMode.IN);
            q.registerStoredProcedureParameter(2, String.class, ParameterMode.IN);
            q.registerStoredProcedureParameter(3, Integer.class, ParameterMode.OUT);
            q.setParameter(1, id_jogador);
            q.setParameter(2, nome);
            q.execute();
            em.getTransaction().commit();
            int con_id = (int) q.getOutputParameterValue(3);
            System.out.printf("Conversa criada com id %d\n", con_id);
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        }
    }

    void juntarConversa() throws IOException {
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
            StoredProcedureQuery q = em.createStoredProcedureQuery("juntarConversa");
            q.registerStoredProcedureParameter(1, Integer.class, ParameterMode.IN);
            q.registerStoredProcedureParameter(2, Integer.class, ParameterMode.IN);
            q.setParameter(1, id_jogador);
            q.setParameter(2, id_conversa);
            q.execute();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        }
    }

    void enviarMensagem() throws IOException {
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
            StoredProcedureQuery q = em.createStoredProcedureQuery("enviarMensagem");
            q.registerStoredProcedureParameter(1, Integer.class, ParameterMode.IN);
            q.registerStoredProcedureParameter(2, Integer.class, ParameterMode.IN);
            q.registerStoredProcedureParameter(3, String.class, ParameterMode.IN);
            q.setParameter(1, id_jogador);
            q.setParameter(2, id_conversa);
            q.setParameter(3, texto);
            q.execute();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        }
    }

    void jogadorTotalInfo() {
        em.getTransaction().begin();
        System.out.println("Criando vista... ");
        try {
            Query q = em.createNativeQuery("CREATE OR REPLACE VIEW JOGADOR_TOTAL_INFO " +
                    "AS SELECT v_id_jogador as id_jogador, v_estado as estado, v_email as email, " +
                    "v_nome as nome, n_jogos, n_partidas, pontos_total " +
                    "FROM get_jti_data()");
            q.executeUpdate();
            em.getTransaction().commit();
            System.out.println("Vista criada");
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        }
    }
}
