package model;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name="regiao")
public class Regiao implements Serializable {
    @Id
    @GeneratedValue
    @Column(name="id_regiao",nullable = false)
    private Integer id;

    @Column(name="nome_regiao",unique = true, nullable = false)
    private String nome;

    public Regiao() {}

    public Regiao(int id, String nome) {
        this.id = id;
        this.nome = nome;
    }

    public int getId() { return this.id; }

    public void setId(int id) { this.id = id; }

    public String getNome() { return this.nome; }

    public void setNome(String nome) { this.nome = nome; }
}
