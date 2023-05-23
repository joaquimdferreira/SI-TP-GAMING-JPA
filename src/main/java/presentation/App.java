/*
 Walter Vieira (2022-04-22)
 Sistemas de Informa��o - projeto JPAAulas_ex3
 C�digo desenvolvido para iulustra��o dos conceitos sobre acesso a dados, concretizados com base na especifica��o JPA.
 Todos os exemplos foram desenvolvidos com EclipseLinlk (3.1.0-M1), usando o ambientre Eclipse IDE vers�o 2022-03 (4.23.0).
 
N�o existe a pretens�o de que o c�digo estaja completo.

Embora tenha sido colocado um esfor�o significativo na corre��o do c�digo, n�o h� garantias de que ele n�o contenha erros que possam 
acarretar problemas v�rios, em particular, no que respeita � consist�ncia dos dados.  
 
*/

package presentation;

import java.util.Scanner;


import businessLogic.*;


/**
 * Hello world!
 *
 */

public class App 
{
	protected interface ITest {
		void test();
	}

	public static void main( String[] args ) throws Exception
   {   BLService srv = new BLService();
   	ITest[] tests = new ITest[] {
         () -> {try { srv.test1(); } catch(Exception e) {}} 
//         , () -> {try { srv.teste2(); } catch(Exception e) {}} 
//         , () -> {try { srv.teste3(); } catch(Exception e) {}} 
//         , () -> {try { srv.teste4(); } catch(Exception e) {}} 
//         , () -> {try { srv.teste5(); } catch(Exception e) {}} 
      };
   	
   	Scanner imp = new Scanner(System.in );
   	System.out.printf("Escolha um teste (1-%d)? ",tests.length);
   	int option = imp.nextInt();
   	if (option >= 1 && option <= tests.length)
   		tests[--option].test();


       	 
   }
}
