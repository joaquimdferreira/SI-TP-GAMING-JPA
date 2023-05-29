package model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.sql.Timestamp;
import java.text.ParseException;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

@Entity
@Table(name = "compra")
public class Compra implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_compra", unique = true, nullable = false)
    private int id;
    @ManyToOne
    @JoinColumn(name="id_jogador", referencedColumnName = "id_jogador", nullable = false)
    private Jogador jogador;
    @ManyToOne
    @JoinColumn(name="ref_jogo", referencedColumnName = "ref_jogo", nullable = false)
    private Jogo jogo;
    @Column(nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date data;
    @Column(precision = 4, scale = 2, nullable = false)
    private float preco;

    public static boolean verifyData(Date data) throws ParseException {
        DateFormat date_format_obj = new SimpleDateFormat("dd/MM/yy HH:mm:ss");
        Timestamp curr = new Timestamp(System.currentTimeMillis());
        Date dt = DateFormat.getDateInstance().parse(date_format_obj.format(curr));
        if(data.compareTo(dt) <= 0) return true;
        return false;
    }
    public static boolean verifyPreco(float preco){
        if(preco >= 0) return true;
        return false;
    }

    public Compra() {}
    public Compra(int id, Date data, float preco) {
        this.id= id;
        this.data = data;
        this.preco = preco;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Jogador getJogador() { return jogador; }
    public void setJogador(Jogador jogador) { this.jogador = jogador; }

    public Jogo getJogo() { return jogo; }
    public void setJogo(Jogo jogo) { this.jogo = jogo; }

    public Date getData() { return data; }
    public void setData(Date data) { this.data = data; }

    public float getPreco() { return preco; }
    public void setPreco(float preco) { this.preco = preco; }

}
