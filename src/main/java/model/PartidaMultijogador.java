package model;

import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name = "partida_multijogador")
public class PartidaMultijogador implements Serializable {

    @EmbeddedId
    private PartidaMultijogadorPK pmPK;

    @ManyToOne
    @JoinColumn(name = "n_partida")
    private Partida partida;
    @OneToOne
    @JoinColumn(name = "id_jogador")
    private Jogador jogador;

    @Column(name = "pontuacao", nullable = false)
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

    public PartidaMultijogadorPK getPartidaMultijogadorID() { return this.pmPK; }
    public void setPartidaMultijogadorID(PartidaMultijogadorPK p) { this.pmPK = p; }

    public int getPontuacao() { return this.pontuacao; }
    public void setPontuacao(int p) { this.pontuacao = p; }

    public Estado getEstado() { return this.estado; }
    public void setEstado(Estado e) { this.estado = e; }

    public boolean checkCompra(Compra compra, Jogo jogo){
        if(getPartidaMultijogadorID().getJogador() == compra.getJogador().getId()
                && jogo.getRef() == compra.getJogo().getRef()
        ) return true;
        return false;
    }

}
