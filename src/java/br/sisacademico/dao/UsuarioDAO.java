package br.sisacademico.dao;

import br.sisacademico.model.Usuario;
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

            String query = "SELECT idUsuario, email, senha, \"tipo\", IdTipoUsuario FROM TB_USUARIO INNER JOIN \"tb_tipoUsuario\" ON idTipoUsuario = \"idTipo\" WHERE email = ? AND senha = ?";

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
                        resultados.getInt("IdTipoUsuario"));
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

        String select = "SELECT idUsuario, email, \"tipo\", IdTipoUsuario FROM TB_USUARIO INNER JOIN \"tb_tipoUsuario\" ON idTipoUsuario = \"idTipo\"";

        ResultSet resultados = stm.executeQuery(select);

        while (resultados.next()) {
            Usuario u = new Usuario();
            u.setIdUsuario(resultados.getInt("idUsuario"));
            u.setEmail(resultados.getString("email"));
            u.setTipo(resultados.getString("tipo"));
            u.setIdTipoUsuario(resultados.getInt("IdTipoUsuario"));

            usuarios.add(u);
        }

        stm.getConnection().close();

        return usuarios;
    }

    public Usuario getUsuario(int idUsuario) {
        Usuario u = new Usuario();

        try {
            stm = ConnectionFactory.getConnection().createStatement(
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);

            String select = "SELECT idUsuario, email, \"tipo\", IdTipoUsuario FROM TB_USUARIO INNER JOIN \"tb_tipoUsuario\" ON IDTIPOUSUARIO = \"idTipo\" WHERE idUsuario = " + idUsuario;

            ResultSet resultados = stm.executeQuery(select);

            while (resultados.next()) {
                u.setIdUsuario(resultados.getInt("idUsuario"));
                u.setEmail(resultados.getString("email"));
                u.setTipo(resultados.getString("tipo"));
                u.setIdTipoUsuario(resultados.getInt("IdTipoUsuario"));
            }

            stm.getConnection().close();

            return u;

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
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

    public boolean cadastrarUsuario(String email, String senha, int tipo) {
        try {
            String query = "INSERT INTO TB_USUARIO (email, senha, idTipoUsuario) VALUES(?, ?, ?)";

            PreparedStatement stm = ConnectionFactory.getConnection().prepareStatement(query);

            stm.setString(1, email);
            stm.setString(2, senha);
            stm.setInt(3, tipo);

            stm.execute();

            stm.getConnection().close();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean atualizaUsuario(int idUsuario, String emailNovo, String senhaNova, int tipoNovo, boolean alteraSenha) {
        try {
            String query = "";
            PreparedStatement stm;
            if (alteraSenha) {
                query = "UPDATE TB_USUARIO SET email = ?, senha = ?, idTipoUsuario = ? WHERE idUsuario = ?";
                stm = ConnectionFactory.getConnection().prepareStatement(query);

                stm.setString(1, emailNovo);
                stm.setString(2, senhaNova);
                stm.setInt(3, tipoNovo);
                stm.setInt(4, idUsuario);

            } else {
                query = "UPDATE TB_USUARIO SET email = ?, idTipoUsuario = ? WHERE idUsuario = ?";
                stm = ConnectionFactory.getConnection().prepareStatement(query);

                stm.setString(1, emailNovo);
                stm.setInt(2, tipoNovo);
                stm.setInt(3, idUsuario);

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
