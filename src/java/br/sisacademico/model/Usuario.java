package br.sisacademico.model;

import java.sql.Date;

public class Usuario {

    private int idUsuario;
    private String email;
    private String senha;
    private String tipo;
    private int IdTipoUsuario;
    private String nome;
    private Date nascimento;
    private String CPF;

    public Usuario(int idUsuario, String email, String senha, String tipo, int IdTipoUsuario, String nome) {
        this.idUsuario = idUsuario;
        this.email = email;
        this.senha = senha;
        this.tipo = tipo;
        this.IdTipoUsuario = IdTipoUsuario;
        this.nome = nome;
    }

    public Usuario(int idUsuario, String email, String senha, String tipo, int IdTipoUsuario, String nome, Date nascimento, String CPF) {
        this.idUsuario = idUsuario;
        this.email = email;
        this.senha = senha;
        this.tipo = tipo;
        this.IdTipoUsuario = IdTipoUsuario;
        this.nome = nome;
        this.CPF = CPF;
        this.nascimento = nascimento;
    }

    public Usuario() {
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public int getIdTipoUsuario() {
        return IdTipoUsuario;
    }

    public void setIdTipoUsuario(int IdTipoUsuario) {
        this.IdTipoUsuario = IdTipoUsuario;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Date getNascimento() {
        return nascimento;
    }

    public void setNascimento(Date nascimento) {
        this.nascimento = nascimento;
    }

    public String getCPF() {
        return CPF;
    }

    public void setCPF(String CPF) {
        this.CPF = CPF;
    }

}
