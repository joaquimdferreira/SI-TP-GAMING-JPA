package model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Set;

@Entity
@Table(name = "jogo")
public class Jogo implements Serializable {
    @Id
    @Column(name="ref_jogo",nullable = false,length = 10)
    private String ref;

    @Column(name="nome",unique = true, nullable = false,length = 50)
    private String nome;

    @Column(name="url",nullable = false,length = 50)
    private String url;

    //SETTER E GETTER??
    @OneToMany
    private Set<Compra> compras;

    public Jogo() {}

    public Jogo(String ref, String nome, String url) {
        this.ref = ref;
        this.nome = nome;
        this.url = url;
    }

    public String getRef() { return this.ref; }

    public void setRef(String ref) { this.ref = ref; }

    public void setId(String ref) { this.ref = ref; }

    public String getNome() { return this.nome; }

    public void setNome(String nome) { this.nome = nome; }

    public String getUrl() { return this.url; }

    public void setUrl(String url) { this.url = url; }
}
