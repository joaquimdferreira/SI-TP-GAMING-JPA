package model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.sql.Date;

@Entity
@Table(name = "compra")
public class Compra implements Serializable {
    @Id
    @Column(name="id_compra",nullable = false)
    private Integer id;

    @ManyToOne
    @JoinColumn(name="id_jogador",referencedColumnName = "id_jogador")
    @Column(name="id_jogador",nullable = false)
    private Jogador jogador;

    @ManyToOne
    @JoinColumn(name="ref_jogo",referencedColumnName = "ref_jogo")
    @Column(name="ref_jogo",nullable = false,length = 10)
    private Jogo jogo;

    @Column(nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date data;

    @Column(precision = 4,scale = 2, nullable = false)
    private Float preco;

    public Compra() {}

    public Compra(int id, Jogador jogador, Jogo jogo, Date data, Float preco) {
        this.id= id;
        this.jogador = jogador;
        this.jogo = jogo;
        this.data = data;
        this.preco = preco;
    }

    public int getId() { return this.id; }

    public void setId(int id) { this.id = id; }

    public Jogador getJogador() { return this.jogador; }

    public void setJogador(Jogador jogador) { this.jogador = jogador; }

    public Jogo getJogo() { return this.jogo; }

    public void setJogo(Jogo jogo) { this.jogo = jogo; }

    public Date getData() { return this.data; }

    public void setData(Date data) { this.data = data; }

    public float getPreco() { return this.preco; }

    public void setPreco(float preco) { this.preco = preco; }
}
