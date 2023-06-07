package presentation;

import businessLogic.Services;
import jakarta.persistence.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;

import businessLogic.*;

public class Application {
    private enum Option {
        Unknown,
        Exit,
        CreatePlayer,
        DeactivatePlayer,
        BanPlayer,
        ObtainPointsPlayer,
        ObtainPointsGame,
        ObtainPointsPlayerGame,
        AssociateBadge,
        IntiateConversation,
        JoinConversation,
        SendMessage,
        ObtainPlayerInfo,
        AssociateBadgeNoSQL,
        AssociateBadgeWithSQL
    }

    private static Application __instance = null;
    private Services svc = null;
    private HashMap<Option,DbWorker> __dbMethods;
    private EntityManager con = null;
    private EntityManagerFactory emf = null;
    BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

    public static Application getInstance() {
        if(__instance == null)
        {
            __instance = new Application();
        }
        return __instance;
    }

    private Application() {}

    private void Login() {
        emf = Persistence.createEntityManagerFactory("SI-JPA");
        con = emf.createEntityManager();
    }

    private void Logout() {
        if (con != null && emf != null) {
            con.close();
            emf.close();
        }
        con = null;
        emf = null;
    }

    private static void clearConsole() throws Exception {
        for (int y = 0; y < 25; y++) //console is 80 columns and 25 lines
            System.out.println("\n");
    }

    private void updateMethods() {
        __dbMethods = new HashMap<Option,DbWorker>();
        Services srv = new Services(con, reader);
        __dbMethods.put(Option.CreatePlayer, new DbWorker() {
            public void doWork() {
                try { srv.createJogador(); } catch (IOException e) { throw new RuntimeException(e); }
            }
        });
        __dbMethods.put(Option.DeactivatePlayer, new DbWorker() {
            public void doWork() {
                try { srv.desativarJogador(); } catch (IOException e) { throw new RuntimeException(e); }
            }
        });
        __dbMethods.put(Option.BanPlayer, new DbWorker() {
            public void doWork() {
                try { srv.banirJogador(); } catch (IOException e) { throw new RuntimeException(e); }
            }
        });
        __dbMethods.put(Option.ObtainPointsPlayer, new DbWorker() {
            public void doWork() {
                try { srv.totalPontosJogador(); } catch (IOException e) { throw new RuntimeException(e); }
            }
        });
        __dbMethods.put(Option.ObtainPointsGame, new DbWorker() {
            public void doWork() {
                try { srv.totalJogosJogador(); } catch (IOException e) { throw new RuntimeException(e); }
            }
        });
        __dbMethods.put(Option.ObtainPointsPlayerGame, new DbWorker() {
            public void doWork() {
                try { srv.pontosJogoPorJogador(); } catch (IOException e) { throw new RuntimeException(e); }
            }
        });
        __dbMethods.put(Option.AssociateBadge, new DbWorker() {
            public void doWork() {
                try { srv.associarCracha(); } catch (IOException e) { throw new RuntimeException(e); }
            }
        });
        __dbMethods.put(Option.IntiateConversation, new DbWorker() {
            public void doWork() {
                try { srv.iniciarConversa(); } catch (IOException e) { throw new RuntimeException(e); }
            }
        });
        __dbMethods.put(Option.JoinConversation, new DbWorker() {
            public void doWork() {
                try { srv.juntarConversa(); } catch (IOException e) { throw new RuntimeException(e); }
            }
        });
        __dbMethods.put(Option.SendMessage, new DbWorker() {
            public void doWork() {
                try { srv.enviarMensagem(); } catch (IOException e) { throw new RuntimeException(e); }
            }
        });
        __dbMethods.put(Option.ObtainPlayerInfo, new DbWorker() {
            public void doWork() { srv.jogadorTotalInfo(); }
        });
        __dbMethods.put(Option.AssociateBadgeNoSQL, new DbWorker() {
            public void doWork() {
                try { srv.associarCracha2(); } catch (IOException e) { throw new RuntimeException(e); }
            }
        });
        __dbMethods.put(Option.AssociateBadgeWithSQL, new DbWorker() {
            public void doWork() {
                try { srv.associarCracha3(); } catch (IOException e) { throw new RuntimeException(e); }
            }
        });
    }

    private Option DisplayMenu() {
        Option option=Option.Unknown;

        try
        {
            System.out.println("Empresa GameOn");
            System.out.println();
            System.out.println(" 1.  Sair");
            System.out.println(" 2.  Criar jogador");
            System.out.println(" 3.  Desativar jogador");
            System.out.println(" 4.  Banir jogador");
            System.out.println(" 5.  Obter Total de Pontos de Jogador");
            System.out.println(" 6.  Obter Total de Jogos de Jogador");
            System.out.println(" 7.  Obter Total de Pontos por Jogador num Jogo");
            System.out.println(" 8.  Associar Cracha");
            System.out.println(" 9.  Iniciar Conversa");
            System.out.println(" 10.  Juntar Conversa");
            System.out.println(" 11.  Enviar Mensagem");
            System.out.println(" 12.  Obter Informação do Jogador");
            System.out.println();
            System.out.println(" 13.  Associar Cracha, sem procedimentos SQL");
            System.out.println(" 14.  Associar Cracha, com funcionalidade original SQL");
            System.out.print(" >");
            String result = reader.readLine();
            option = Option.values()[Integer.parseInt(result)];
        }
        catch(IOException ex) { System.out.print("IOException"); }

        return option;
    }

    //Application loop, clears console, prints menu, gets input and processes it, making sure to close the connection
    public void Run() throws Exception {
        Login();
        svc = new Services(con, reader);
        Option userInput = Option.Unknown;
        updateMethods();
        do {
            clearConsole();
            userInput = DisplayMenu();
            clearConsole();
            try {
                __dbMethods.get(userInput).doWork();	// Executa o método correspondente à opção escolhida
                System.out.println("Pressione a tecla \"Enter\" para continuar... ");
                System.in.read();
                System.in.read();
            }
            catch(NullPointerException ex) {
                System.out.print("");
            }
        }while(userInput!=Option.Exit);
        Logout();
    }
}
