package br.sisacademico.controllers;

import br.sisacademico.dao.UsuarioDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/usuarioServlet")

public class usuarioServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String tipoAcao = request.getParameter("tipoAcao");

            if (tipoAcao.equals("delete")) {
                UsuarioDAO uDAO = new UsuarioDAO();
                int idUsuarioDeletado = Integer.parseInt(request.getParameter("idUsuario"));
                if (uDAO.verificaUsuariocomAluno(idUsuarioDeletado) == false) {
                    //out.print("Vou deletar o usuário " + idUsuarioDeletado);
                    if (uDAO.deletarUsuario(idUsuarioDeletado)) {
                        response.sendRedirect("gestaousuarios.jsp?acao=deletar");
                    } else {
                        response.sendRedirect("gestaousuarios.jsp?acao=false");
                    }
                }
                response.sendRedirect("gestaousuarios.jsp?acao=erro");
            }

            if (tipoAcao.equals("insere")) {
                UsuarioDAO uDAO = new UsuarioDAO();
                String email = request.getParameter("email");
                String senha = request.getParameter("senha");
                String nome = request.getParameter("nome");
                Date nascimento = Date.valueOf(request.getParameter("nascimento"));
                String CPF = request.getParameter("CPF");

                //criptografia da senha 
                MessageDigest m = MessageDigest.getInstance("SHA-256");
                m.update(senha.getBytes(), 0, senha.length());

                int idTipo = Integer.parseInt(request.getParameter("idTipoUsuario"));
                if (uDAO.verificaUsuario(email) == false) {
                    if (uDAO.cadastrarUsuario(email, new BigInteger(1, m.digest()).toString(16), idTipo, nome, nascimento, CPF)) {
                        response.sendRedirect("gestaousuarios.jsp?acao=true");
                    } else {
                        response.sendRedirect("gestaousuarios.jsp?acao=false");
                    }
                }
                response.sendRedirect("gestaousuarios.jsp?acao=email");
            }

            if (tipoAcao.equals("edicao")) {
                String nome = request.getParameter("nome");
                String email = request.getParameter("email");
                String senha = request.getParameter("senha");
                Date nascimento = Date.valueOf(request.getParameter("nascimento"));
                String CPF = request.getParameter("CPF");
                String checkSenha = request.getParameter("alteraSenha");
                int idTipoNovo = Integer.parseInt(request.getParameter("idTipoUsuario"));
                int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                boolean alteraSenha = false;
                if (checkSenha != null) {
                    alteraSenha = checkSenha.equals("on");
                }

                //criptografia da senha 
                String senhaCripto = "";
                if (alteraSenha) {
                    MessageDigest m = MessageDigest.getInstance("SHA-256");
                    m.update(senha.getBytes(), 0, senha.length());
                    senhaCripto = new BigInteger(1, m.digest()).toString(16);
                }

                UsuarioDAO uDAO = new UsuarioDAO();
                if (uDAO.verificaEdicaoUsuario(email, idUsuario) == false) {
                    response.sendRedirect("gestaousuarios.jsp?acao=edicaoerro");
                } else {
                    if (uDAO.atualizaUsuario(idUsuario, nome, email, senhaCripto, idTipoNovo, alteraSenha, nascimento, CPF)) {
                        response.sendRedirect("gestaousuarios.jsp?acao=edicaook");
                    } else {
                        response.sendRedirect("gestaousuarios.jsp?acao=edicaoerro");
                    }
                }
            }

            if (tipoAcao.equals("alteraSenha")) {
                //é preciso verificar a senha antiga informada

                //pega o e-mail da session:
                HttpSession session = request.getSession();
                String nome = (String) session.getAttribute("nome");
                String email = (String) session.getAttribute("emailUsuario");
                String senhaDigitada = request.getParameter("senhaAntiga");
                int tipo1 = (Integer) session.getAttribute("IdTipoUsuario");

                MessageDigest m = MessageDigest.getInstance("SHA-256");
                m.update(senhaDigitada.getBytes(), 0, senhaDigitada.length());
                String senhaAntigaCripto = new BigInteger(1, m.digest()).toString(16);

                String senhaNova = request.getParameter("senhaNova_1");
                m.update(senhaNova.getBytes(), 0, senhaNova.length());
                String senhaNovaCripto = new BigInteger(1, m.digest()).toString(16);

                UsuarioDAO uDAO = new UsuarioDAO();
                if (uDAO.autentica(email, senhaAntigaCripto) != null) {
                    int idUsuario = (Integer) session.getAttribute("idUsuario");
                    if (uDAO.resetSenhaUsuario(idUsuario, nome, email, senhaNovaCripto, tipo1, true)) {
                        response.sendRedirect("cadastros/alterarsenha.jsp?acao=true");
                    } else {
                        response.sendRedirect("cadastros/alterarsenha.jsp?acao=false");
                    }

                } else {
                    response.sendRedirect("cadastros/alterarsenha.jsp?acao=false");
                }
            }

        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(usuarioServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
