package model;

import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name = "partida_normal")
public class PartidaNormal implements Serializable {
    @Id
    @ManyToOne
    @PrimaryKeyJoinColumn(name = "n_partida")
    private Partida partida;

    @OneToOne
    @JoinColumn(name = "id_jogador",nullable = false)
    private Jogador jogador;

    @Column(name = "dificuldade", nullable = false)
    private short dificuldade;

    @Column(name = "pontuacao",nullable = false)
    private int pontuacao;

    public PartidaNormal() {}

    public PartidaNormal(short dificuldade, int pontuacao) {
        this.dificuldade = dificuldade;
        this.pontuacao = pontuacao;
    }

    public Partida getPartida() { return this.partida; }
    public void setPartida(Partida p) { this.partida = p; }

    public Jogador getJogador() { return this.jogador; }
    public void setJogador(Jogador j) { this.jogador = j; }

    public short getDificuldade() { return this.dificuldade; }
    public void setDificuldade(short d) { this.dificuldade = d; }

    public int getPontuacao() { return this.pontuacao; }
    public void setPontuacao(int p) { this.pontuacao = p; }

    public boolean checkDificudade(int d) {
        return d > 0 && d < 6;
    }

}
