package model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Set;

@Entity
@Table(name ="conversa")
public class Conversa implements Serializable {

    @EmbeddedId
    private ConversaPK cPK;

    @Column(name = "id_conversa", nullable = false)
    private int id;
    @ManyToMany
    @JoinColumn(name = "id_jogador")
    private Set<Jogador> jogadores;

    @Column(name = "nome_conversa",nullable = false)
    private String nome;

    public Conversa() {}
    public Conversa(int id, String nome) {
        this.id = id;
        this.nome = nome;
    }

    public int getId() { return this.id; }
    public void setId(int id) { this.id = id; }

    public String getNome() { return this.nome; }
    public void setNome(String n) { this.nome = n; }

    public Set<Jogador> getJogadores() { return this.jogadores; }
    public void setJogadores(Set<Jogador> j) { this.jogadores = j; }

}
