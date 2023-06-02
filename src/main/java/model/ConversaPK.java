package model;

import jakarta.persistence.Embeddable;

import java.io.Serializable;

@Embeddable
public class ConversaPK implements Serializable {

    private int conversa;
    private int jogador;

    private ConversaPK() {}

    public int getConversa() { return this.conversa; }
    public void setConversa(int conversa) { this.conversa = conversa; }

    public int getJogador() { return this.jogador; }
    public void setJogador(int j) { this.jogador = j; }

}
