package model;

import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name="jogador")
public class Jogador implements Serializable {

    @Id
    @GeneratedValue
    @Column(name="id_jogador",nullable = false)
    private int id;
    private String email;
    private String nome;
    private String estado;
    private int id_regiao;

    public Jogador() {}
    public Jogador(int id) { this.id = id; }

    public int getId_jogador() { return id; }
    public void setId_jogador(int id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public int getId_regiao() { return id_regiao; }
    public void setId_regiao(int id_regiao) { this.id_regiao = id_regiao; }

}
