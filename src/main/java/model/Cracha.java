package model;

import jakarta.persistence.*;

import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Entity
@Table(name = "cracha")
public class Cracha {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_cracha", unique = true, nullable = false)
    private int id;
    @Column(name = "nome_cracha", nullable = false)
    private String nome;
    @ManyToOne
    @JoinColumn(name = "ref_jogo", referencedColumnName = "ref_jogo", nullable = false)
    private Jogo jogo;
    @Column(name = "pontos_limite", nullable = false)
    private int pontos;
    @Column(name = "url_imagem", nullable = false)
    private String url;

    @ManyToMany
    private Set<Jogador> cracha_jogador;

    public static boolean verifyUrl(String url){
        String regex = "^www(.+)$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(url);
        return matcher.matches();
    }

    public Cracha() {}
    public Cracha(int id, String nome, int pontos, String url) {
        this.id = id;
        this.nome = nome;
        this.pontos = pontos;
        this.url = url;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public Jogo getJogo() { return jogo; }
    public void setJogo(Jogo jogo) { this.jogo = jogo; }

    public int getPontos() { return pontos; }
    public void setPontos(int pontos) { this.pontos = pontos; }

    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }

    public Set<Jogador> getCracha_jogador() { return cracha_jogador; }
    public void setCracha_jogador(Set<Jogador> cracha_jogador) { this.cracha_jogador = cracha_jogador; }

}
