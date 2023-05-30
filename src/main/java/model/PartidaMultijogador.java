package model;

import jakarta.persistence.*;

import java.util.Set;

@Entity
@IdClass(PartidaMultijogador.class)
@Table(name = "partida_multijogador")
public class PartidaMultijogador {
    @Id
    @ManyToOne
    @PrimaryKeyJoinColumn(name = "n_partida")
    private Partida partida;
    @Id
    @OneToOne
    @JoinColumn(name = "id_jogador",nullable = false)
    private Jogador jogador;
    @Column(name = "pontuacao",nullable = false)
    private int pontuacao;

    public enum Estado {
        PorIniciar,
        AguardarJogadores,
        EmCurso,
        Terminada
    }

    @Enumerated(EnumType.STRING)
    @Column(name = "estado", nullable = false)
    private Estado estado;

    public PartidaMultijogador() {}
    public PartidaMultijogador(int pontuacao, Estado estado) {
        this.pontuacao = pontuacao;
        this.estado = estado;
    }

    public Partida getPartida() { return this.partida; }
    public void setPartida(Partida p) { this.partida = p; }

    public Jogador getJogador() { return this.jogador; }
    public void setJogador(Jogador j) { this.jogador = j; }

    public int getPontuacao() { return this.pontuacao; }
    public void setPontuacao(int p) { this.pontuacao = p; }

    public Estado getEstado() { return this.estado; }
    public void setEstado(Estado e) { this.estado = e; }

    public boolean checkCompra(Compra compra, Jogo jogo){
        if(getJogador().getId() == compra.getJogador().getId()
                && jogo.getRef() == compra.getJogo().getRef()
        ) return true;
        return false;
    }

}
