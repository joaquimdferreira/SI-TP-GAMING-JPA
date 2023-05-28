package model;

import jakarta.persistence.*;

@Entity
@Table(name = "estatistica_jogador")
public class EstatisticaJogador {
    @Id
    @OneToOne
    @PrimaryKeyJoinColumn(name = "id_jogador")
    private Jogador jogador;

    @Column(name = "n_partidas",nullable = false)
    private int n_partidas;

    @Column(name = "n_jogos",nullable = false)
    private int n_jogos;

    @Column(name = "total_pontos_jogador",nullable = false)
    private int totalP;

    public EstatisticaJogador() {}

    public EstatisticaJogador(int n_partidas, int n_jogos, int totalP) {
        this.n_partidas = n_partidas;
        this.n_jogos = n_jogos;
        this.totalP = totalP;
    }

    public Jogador getJogador() { return this.jogador; }
    public void setJogador(Jogador j) { this.jogador = j; }

    public int getN_partidas() { return this.n_partidas; }
    public void setN_partidas(int n_partidas) {
        this.n_partidas = n_partidas;
    }

    public int getN_jogos() {
        return n_jogos;
    }

    public void setN_jogos(int n_jogos) {
        this.n_jogos = n_jogos;
    }

    public int getTotalP() {
        return totalP;
    }

    public void setTotalP(int totalP) {
        this.totalP = totalP;
    }
}
