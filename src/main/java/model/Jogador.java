package model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

enum EstadoJogador {
    Ativo,
    Inativo,
    Banido
}

@Entity
@Table(name="jogador")
public class Jogador implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_jogador", unique = true, nullable = false)
    private int id;
    @Column(name = "email", unique = true, nullable = false)
    private String email;
    @Column(name = "nome", unique = true, nullable = false)
    private String nome;
    @Enumerated(EnumType.STRING)
    @Column(name = "estado", nullable = false)
    private EstadoJogador estado;
    @ManyToOne
    @JoinColumn(name = "id_regiao", nullable = false)
    private Regiao id_regiao;

    @ManyToMany
    private Set<Cracha> cracha_jogador;
    @ManyToMany
    private Set<Conversa> conversa_jogador;
    @ManyToMany
    private Set<Jogador> amigos;
    @ManyToMany
    private Set<Jogador> amigoDe;

    public static boolean verifyEmail(String email){
        String regex = "^(.+)@(.+)$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

    public Jogador() {}
    public Jogador(int id, String email, String nome, EstadoJogador estado) {
        this.id = id;
        this.email = email;
        this.nome = nome;
        this.estado = estado;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public EstadoJogador getEstado() { return estado; }
    public void setEstado(EstadoJogador estado) { this.estado = estado; }

    public Regiao getId_regiao() { return id_regiao; }
    public void setId_regiao(Regiao id_regiao) { this.id_regiao = id_regiao; }

    public Set<Cracha> getCracha_jogador() { return cracha_jogador; }
    public void setCracha_jogador(Set<Cracha> cracha_jogador) { this.cracha_jogador = cracha_jogador; }

    public Set<Conversa> getConversa_jogador() { return conversa_jogador; }
    public void setConversa_jogador(Set<Conversa> conversa_jogador) { this.conversa_jogador = conversa_jogador; }

    public Set<Jogador> getAmigos() { return amigos; }
    public void setAmigos(Set<Jogador> amigos) { this.amigos = amigos; }

    public Set<Jogador> getAmigoDe() { return amigoDe; }
    public void setAmigoDe(Set<Jogador> amigoDe) { this.amigoDe = amigoDe; }


}
