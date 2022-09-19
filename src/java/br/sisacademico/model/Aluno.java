package br.sisacademico.model;

public class Aluno {

    private int idAluno;
    private int ra;
    private int idUsuario;
    private String nomeAluno;
    private Curso curso;
    private Usuario usuario;


    public Aluno(int idAluno, int ra, String nomeAluno, Curso curso, int idUsuario) {
        this.idAluno = idAluno;
        this.ra = ra;
        this.nomeAluno = nomeAluno;
        this.curso = curso;
        this.idUsuario = idUsuario;
    }

    public Aluno() {
    }

    public int getIdAluno() {
        return idAluno;
    }

    public void setIdAluno(int idAluno) {
        this.idAluno = idAluno;
    }

    public int getRa() {
        return ra;
    }

    public void setRa(int ra) {
        this.ra = ra;
    }

    public String getNomeAluno() {
        return nomeAluno;
    }

    public void setNomeAluno(String nomeAluno) {
        this.nomeAluno = nomeAluno;
    }

    public Curso getCurso() {
        return curso;
    }

    public void setCurso(Curso curso) {
        this.curso = curso;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public Usuario getUsuario() {
        return usuario;
    }
    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

}
