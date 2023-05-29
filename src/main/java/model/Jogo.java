package model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Entity
@Table(name = "jogo")
public class Jogo implements Serializable {

    @Id
    @Column(name="ref_jogo", unique = true, nullable = false, length = 10)
    private String ref;
    @Column(name="nome", nullable = false)
    private String nome;
    @Column(name="url", nullable = false)
    private String url;

    public static boolean verifyRef(String ref){
        if(ref.length() == 10) return true;
        return false;
    }
    public static boolean verifyUrl(String url){
        String regex = "^www(.+)$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(url);
        return matcher.matches();
    }

    public Jogo() {}
    public Jogo(String ref, String nome, String url) {
        this.ref = ref;
        this.nome = nome;
        this.url = url;
    }

    public String getRef() { return ref; }
    public void setRef(String ref) { this.ref = ref; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }
}
