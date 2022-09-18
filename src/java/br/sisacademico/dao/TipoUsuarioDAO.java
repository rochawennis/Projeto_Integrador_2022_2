/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package br.sisacademico.dao;

import br.sisacademico.model.TipoUsuario;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Acer
 */
public class TipoUsuarioDAO {

    private static Statement stm = null;

    public ArrayList<TipoUsuario> getTodosTiposUsuarios() throws SQLException {

        String query = "SELECT \"idTipo\" , \"tipo\"  FROM \"tb_tipoUsuario\" ORDER BY \"tipo\" ";

        ArrayList<TipoUsuario> tipoUsuario = new ArrayList<>();

        stm = ConnectionFactory.getConnection().createStatement(
                ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_READ_ONLY);

        ResultSet resultados = stm.executeQuery(query);

        while (resultados.next()) {
            TipoUsuario c = new TipoUsuario();
            c.setIdTipo(resultados.getInt("idTipo"));
            c.setTipo(resultados.getString("tipo"));
            tipoUsuario.add(c);
        }

        stm.getConnection().close();

        return tipoUsuario;
    }

}
