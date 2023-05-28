package model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.lang.annotation.Target;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Entity
@Table(name="partida")
public class Partida implements Serializable {
    @Id
    @GeneratedValue
    @Column(name="n_partida",nullable = false)
    private int n_partida;

    @ManyToOne
    @JoinColumn(name = "ref_jogo", nullable = false)
    private Jogo jogo;

    @Column(name = "data_inicio",nullable = false)
    private Date data_inicio;

    @Column(name = "data_fim")
    private Date data_fim;

    @ManyToOne
    @JoinColumn(name = "id_regiao",nullable = false)
    private Regiao regiao;
    public Partida() {};

    public Partida(int n_partida, Date data_inicio, Date data_fim) {
        this.n_partida = n_partida;
        this.data_inicio = data_inicio;
        this.data_fim = data_fim;
    }

    public int getN_partida() { return this.n_partida; }
    public void setN_partida(int n_partida) { this.n_partida = n_partida; }

    public Jogo getJogo() { return this.jogo; }
    public void setJogo(Jogo jogo) { this.jogo = jogo; }

    public Date getData_inicio() { return this.data_inicio; }
    public void setData_inicio(Date data_inicio) { this.data_inicio = data_inicio; }

    public Date getData_fim() { return this.data_fim; }
    public void setData_fim(Date data_fim) { this.data_fim = data_fim; }

    public Regiao getRegiao() { return this.regiao; }
    public void setRegiao(Regiao regiao) { this.regiao = regiao; }

    public boolean checkDataInicio(Date data) throws ParseException {
        DateFormat date_format_obj = new SimpleDateFormat("dd/MM/yy HH:mm:ss");
        Timestamp curr = new Timestamp(System.currentTimeMillis());
        Date dt = DateFormat.getDateInstance().parse(date_format_obj.format(curr));
        if(data.compareTo(dt) <= 0) return true;
        return false;
    }

    public boolean checkDataFim(Date data) throws ParseException {
        DateFormat date_format_obj = new SimpleDateFormat("dd/MM/yy HH:mm:ss");
        Timestamp curr = new Timestamp(System.currentTimeMillis());
        Date dt = DateFormat.getDateInstance().parse(date_format_obj.format(curr));
        if(data.compareTo(dt) <= 0 && data.after(this.data_fim)) return true;
        return false;
    }
}
