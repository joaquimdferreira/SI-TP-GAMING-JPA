package presentation;

import businessLogic.Services;
import jakarta.persistence.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;

public class Application {
    private enum Option {
        Unknown,
        Exit
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
        //__dbMethods.put(Option.AddCon, new DbWorker() {public void doWork() { Application.this.insertCondutor();}});
    }

    private Option DisplayMenu() {
        Option option=Option.Unknown;

        try
        {
            System.out.println("Empresa GameOn");
            System.out.println();
            System.out.println(" 1.  Sair");
            System.out.println();
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
        svc = new Services(con);
        Option userInput = Option.Unknown;
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
