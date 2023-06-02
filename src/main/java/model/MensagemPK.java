package model;

import jakarta.persistence.Embeddable;

import java.io.Serializable;

@Embeddable
public class MensagemPK implements Serializable {

    private int mensagem;
    private int conversa;
    private int jogador;

    public MensagemPK() {}

    public int getMensagem() { return this.mensagem; }
    public void setMensagem(int mensagem) { this.mensagem = mensagem; }

    public int getConversa() { return this.conversa; }
    public void setConversa(int conversa) { this.conversa = conversa; }

    public int getJogador() { return this.jogador; }
    public void setJogador(int j) { this.jogador = j; }

}
