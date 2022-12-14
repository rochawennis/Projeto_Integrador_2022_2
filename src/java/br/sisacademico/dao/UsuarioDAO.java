package br.sisacademico.dao;

import br.sisacademico.model.Usuario;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class UsuarioDAO {

    private static Statement stm = null;

    public Usuario autentica(String email, String senha) {
        try {
            Usuario u = null;

            String query = "SELECT idUsuario, nome_usuario, email, senha, \"tipo\", IdTipoUsuario FROM TB_USUARIO INNER JOIN \"tb_tipoUsuario\" ON idTipoUsuario = \"idTipo\" WHERE email = ? AND senha = ? ORDER BY NOME_USUARIO ASC";

            PreparedStatement stm = ConnectionFactory.getConnection().prepareStatement(query);

            stm.setString(1, email);
            stm.setString(2, senha);

            ResultSet resultados = stm.executeQuery();
            while (resultados.next()) {
                u = new Usuario(
                        resultados.getInt("idUsuario"),
                        email,
                        senha,
                        resultados.getString("tipo"),
                        resultados.getInt("IdTipoUsuario"),
                        resultados.getString("nome_usuario"));
            }

            stm.getConnection().close();

            return u;
        } catch (Exception e) {
            return null;
        }
    }

    public ArrayList<Usuario> getUsuarios() throws SQLException {
        ArrayList<Usuario> usuarios = new ArrayList<>();

        stm = ConnectionFactory.getConnection().createStatement(
                ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_READ_ONLY);

        String select = "SELECT idUsuario, email, \"tipo\", IdTipoUsuario, nome_usuario FROM TB_USUARIO INNER JOIN \"tb_tipoUsuario\" ON idTipoUsuario = \"idTipo\" ORDER BY NOME_USUARIO ASC";

        ResultSet resultados = stm.executeQuery(select);

        while (resultados.next()) {
            Usuario u = new Usuario();
            u.setIdUsuario(resultados.getInt("idUsuario"));
            u.setEmail(resultados.getString("email"));
            u.setTipo(resultados.getString("tipo"));
            u.setIdTipoUsuario(resultados.getInt("IdTipoUsuario"));
            u.setNome(resultados.getString("nome_usuario"));

            usuarios.add(u);
        }

        stm.getConnection().close();

        return usuarios;
    }

    public boolean verificaUsuariocomAluno(int idUsuario) {
        try {
            String query = "SELECT IDUSUARIO FROM TB_ALUNO where IDUSUARIO = ?";
            PreparedStatement stm = ConnectionFactory.getConnection().prepareStatement(query);

            stm.setInt(1, idUsuario);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                if (idUsuario == (rs.getInt("IDUSUARIO"))) {
                    stm.getConnection().close();
                    return true;
                }
            }
            stm.getConnection().close();
        } catch (SQLException ex) {
            return false;
        }

        return false;

    }

    public Usuario getUsuario(int idUsuario) {
        Usuario u = new Usuario();

        try {
            stm = ConnectionFactory.getConnection().createStatement(
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);

            String select = "SELECT idUsuario, email, \"tipo\", IdTipoUsuario, nome_usuario, DATADENASCIMENTO, CPF FROM TB_USUARIO INNER JOIN \"tb_tipoUsuario\" ON IDTIPOUSUARIO = \"idTipo\" WHERE idUsuario = " + idUsuario;

            ResultSet resultados = stm.executeQuery(select);

            while (resultados.next()) {
                u.setIdUsuario(resultados.getInt("idUsuario"));
                u.setEmail(resultados.getString("email"));
                u.setTipo(resultados.getString("tipo"));
                u.setIdTipoUsuario(resultados.getInt("IdTipoUsuario"));
                u.setNome(resultados.getString("nome_usuario"));
                u.setNascimento(resultados.getDate("DATADENASCIMENTO"));
                u.setCPF(resultados.getString("CPF"));

            }

            stm.getConnection().close();
            return u;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean verificaUsuario(String email) {
        try {
            String query = "select email FROM TB_USUARIO WHERE email = ?";
            PreparedStatement stm = ConnectionFactory.getConnection()
                    .prepareStatement(query);

            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                if (email.equals(rs.getString("email"))) {
                    stm.getConnection().close();
                    return true;
                }
            }
            stm.getConnection().close();
            return false;

        } catch (SQLException ex) {
            return false;
        }
    }

    public boolean verificaEdicaoUsuario(String email, int idUsuario) {
        try {
            String query = "select idusuario, email FROM TB_USUARIO WHERE email = ? and idusuario = ?";
            PreparedStatement stm = ConnectionFactory.getConnection()
                    .prepareStatement(query);

            String query1 = "select email FROM TB_USUARIO WHERE email = ?";
            PreparedStatement stm1 = ConnectionFactory.getConnection()
                    .prepareStatement(query1);

            stm.setString(1, email);
            stm.setInt(2, idUsuario);
            stm1.setString(1, email);
            ResultSet rs = stm.executeQuery();
            ResultSet rs1 = stm1.executeQuery();
            while (rs1.next()) {
                while (rs.next()) {
                    if (email.equals(rs.getString("email")) && idUsuario == (rs.getInt("idusuario"))) {
                        stm.getConnection().close();
                        return true;
                    } else {
                        stm.getConnection().close();
                        return false;
                    }
                }
                stm.getConnection().close();
                return false;
            }
            stm.getConnection().close();
            stm1.getConnection().close();
            return true;

        } catch (SQLException ex) {
            return false;
        }
    }

    public boolean deletarUsuario(int idUsuario) {
        try {
            String query = "DELETE FROM TB_USUARIO WHERE idUsuario = ?";

            PreparedStatement stm = ConnectionFactory.getConnection().prepareStatement(query);

            stm.setInt(1, idUsuario);

            stm.execute();

            stm.getConnection().close();

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean cadastrarUsuario(String email, String senha, int tipo, String nome, Date nascimento, String CPF) {
        try {
            String query = "INSERT INTO TB_USUARIO (email, senha, idTipoUsuario, nome_usuario, datadenascimento, CPF)"
                    + " VALUES(?, ?, ?, ?, ?, ?)";

            PreparedStatement stm = ConnectionFactory.getConnection().prepareStatement(query);

            stm.setString(1, email);
            stm.setString(2, senha);
            stm.setInt(3, tipo);
            stm.setString(4, nome);
            stm.setDate(5, nascimento);
            stm.setString(6, CPF);
            stm.execute();

            stm.getConnection().close();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean resetSenhaUsuario(int idUsuario, String nome, String emailNovo, String senhaNova, int tipoNovo, boolean alteraSenha) {
        try {
            String query = "UPDATE TB_USUARIO SET email = ?, senha = ?, idTipoUsuario = ?, nome_usuario = ? WHERE idUsuario = ?";

            PreparedStatement stm = ConnectionFactory.getConnection().prepareStatement(query);
            if (alteraSenha) {
                stm.setString(1, emailNovo);
                stm.setString(2, senhaNova);
                stm.setInt(3, tipoNovo);
                stm.setString(4, nome);
                stm.setInt(5, idUsuario);
            }
            stm.execute();
            stm.getConnection().close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean atualizaUsuario(int idUsuario, String nome, String emailNovo, String senhaNova, int tipoNovo, boolean alteraSenha, Date nascimento, String CPF) {
        try {
            String query = "";
            PreparedStatement stm;

            if (alteraSenha) {
                query = "UPDATE TB_USUARIO SET email = ?, senha = ?, idTipoUsuario = ?, nome_usuario = ? WHERE idUsuario = ?";
                stm = ConnectionFactory.getConnection().prepareStatement(query);

                stm.setString(1, emailNovo);
                stm.setString(2, senhaNova);
                stm.setInt(3, tipoNovo);
                stm.setString(4, nome);
                stm.setInt(5, idUsuario);
            } else {
                query = "UPDATE TB_USUARIO SET email = ?, senha = ?, idTipoUsuario = ?, nome_usuario = ?, DATADENASCIMENTO = ?, CPF = ? WHERE idUsuario = ?";
                stm = ConnectionFactory.getConnection().prepareStatement(query);
                stm.setString(1, emailNovo);
                stm.setString(2, senhaNova);
                stm.setInt(3, tipoNovo);
                stm.setString(4, nome);
                stm.setDate(5, nascimento);
                stm.setString(6, CPF);
                stm.setInt(7, idUsuario);
            }
            stm.execute();
            stm.getConnection().close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
