/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JTextField;

/**
 *
 * @author Paulo
 */
public class Tela {

    /**
     * @param args the command line arguments
     */
    //public static void main(String[] args) {
	public void Monta(){
        // TODO code application logic here

        JFrame fPrincipal = new JFrame() ;
        fPrincipal.setSize(800, 600);

        JPanel j = new JPanel() ;

        JMenu mCadastro  = new JMenu("Cadastro") ;
        JMenuItem m1 = new JMenuItem("Clientes");
        m1.setVisible(true);
        mCadastro.add(m1);
        
        JMenu mMovimento = new JMenu("Movimento") ;
        
        j.add(mCadastro) ;
        j.add(mMovimento) ;


        JLabel lblCd_Cliente = new JLabel("Código :") ;
        j.add(lblCd_Cliente);
        JTextField txtCd_Cliente = new JTextField(20) ;
        j.add(txtCd_Cliente) ;

        JLabel lblNm_Cliente = new JLabel("Nome :") ;
        j.add(lblNm_Cliente);
        JTextField txtNm_Cliente = new JTextField(40) ;
        j.add(txtNm_Cliente) ;

        JLabel lblDs_Enderec = new JLabel("Endereço :") ;
        j.add(lblDs_Enderec);
        JTextField txtDs_Enderec = new JTextField(40) ;
        j.add(txtDs_Enderec) ;
        
        fPrincipal.add(j) ;
        fPrincipal.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        fPrincipal.setVisible(true);

    }

}
