package model;

import jakarta.persistence.*;

@Entity
@Table(name = "estatistica_jogo")
public class EstatitisticaJogo {
    @Id
    @OneToOne
    @PrimaryKeyJoinColumn(name = "ref_jogo")
    private Jogo jogo;
    @Column(name = "n_partidas",nullable = false)
    private int n_partidas;
    @Column(name = "n_jogadores",nullable = false)
    private int n_jogadores;
    @Column(name = "total_pontos_jogo",nullable = false)
    private int totalP;

    public EstatitisticaJogo() {}
    public EstatitisticaJogo(int n_partidas, int n_jogadores, int totalP) {
        this.n_partidas = n_partidas;
        this.n_jogadores = n_jogadores;
        this.totalP = totalP;
    }

    public Jogo getJogo() {
        return jogo;
    }
    public void setJogo(Jogo jogo) {
        this.jogo = jogo;
    }

    public int getN_partidas() {
        return n_partidas;
    }
    public void setN_partidas(int n_partidas) {
        this.n_partidas = n_partidas;
    }

    public int getN_jogadores() {
        return n_jogadores;
    }
    public void setN_jogadores(int n_jogadores) {
        this.n_jogadores = n_jogadores;
    }

    public int getTotalP() {
        return totalP;
    }
    public void setTotalP(int totalP) {
        this.totalP = totalP;
    }
}
