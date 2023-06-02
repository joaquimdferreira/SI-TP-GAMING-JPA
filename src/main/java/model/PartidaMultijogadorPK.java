package model;

import jakarta.persistence.Embeddable;

import java.io.Serializable;

@Embeddable
public class PartidaMultijogadorPK implements Serializable {

    private int partida;
    private int jogador;

    public PartidaMultijogadorPK() {}

    public int getPartida() { return this.partida; }
    public void setPartida(int p) { this.partida = p; }

    public int getJogador() { return this.jogador; }
    public void setJogador(int j) { this.jogador = j; }

}
