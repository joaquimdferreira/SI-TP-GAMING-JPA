package model;

import jakarta.persistence.*;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Set;

@Entity
@Table(name = "mensagem")
public class Mensagem {
    @Id
    @GeneratedValue
    @Column(name = "id_mensagem", nullable = false)
    private int id;

    @ManyToOne
    @JoinColumn(name = "id_conversa",nullable = false)
    private Conversa conversa;

    @Column(name = "data",nullable = false)
    private Date data;

    @Column(name = "texto",nullable = false)
    private String texto;

    @ManyToOne
    @JoinColumn(name = "id_jogador",nullable = false)
    private Jogador jogador;

    public Mensagem() {}

    public Mensagem(int id, Date data, String texto) {
        this.id = id;
        this.data = data;
        this.texto = texto;
    }

    public int getId() { return this.id; }
    public void setId(int id) { this.id = id; }

    public Conversa getConversa() { return this.conversa; }
    public void setConversa(Conversa c) { this.conversa = c; }

    public Date getData() { return this.data; }
    public void setData(Date data) { this.data = data; }

    public String getTexto() { return this.texto; }
    public void setTexto(String t) { this.texto = t; }

    public Jogador getJogador() { return this.jogador; }
    public void setJogador(Jogador j) { this.jogador = j; }

    public static boolean verifyData(Date data) throws ParseException {
        DateFormat date_format_obj = new SimpleDateFormat("dd/MM/yy HH:mm:ss");
        Timestamp curr = new Timestamp(System.currentTimeMillis());
        Date dt = DateFormat.getDateInstance().parse(date_format_obj.format(curr));
        if(data.compareTo(dt) <= 0) return true;
        return false;
    }
}
