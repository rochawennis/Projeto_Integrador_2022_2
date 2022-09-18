<%@page import="br.sisacademico.dao.TipoUsuarioDAO"%>
<%@page import="br.sisacademico.model.TipoUsuario"%>
<%@page import="br.sisacademico.model.Usuario"%>
<%@page import="br.sisacademico.dao.UsuarioDAO"%>
<%@page import="br.sisacademico.dao.AlunoDao"%>
<%@page import="br.sisacademico.model.Aluno"%>
<%@page import="br.sisacademico.model.Curso"%>
<%@page import="java.util.ArrayList"%>
<%@page import="br.sisacademico.dao.CursoDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (!session.isNew() && session.getAttribute("autenticado") != null) {
        if (!(Boolean) session.getAttribute("autenticado")) {
            response.sendRedirect(request.getContextPath() + "/index.jsp?acesso=false");
        }
    } else {
        response.sendRedirect(request.getContextPath() + "/index.jsp?acesso=false");
    }

    TipoUsuarioDAO tDao = new TipoUsuarioDAO();
    ArrayList<TipoUsuario> listaTipos = tDao.getTodosTiposUsuarios();

    boolean acessoFull = session.getAttribute("tipoUsuario").equals("admin") ? true : false;

    if (!acessoFull) {
        response.sendRedirect("../404.jsp");
    }

    //-------------
    String tipoAcao = "insere";
    String labelBotao = "Cadastrar";
    Usuario u = new Usuario();
    u.setEmail("");
    u.setTipo("");
    String disabilitado = "";
    boolean campoSenhaHabilitado = true;
    if (request.getParameter("idUsuario") != null) {
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        UsuarioDAO uDAO = new UsuarioDAO();
        u = uDAO.getUsuario(idUsuario);
        tipoAcao = "edicao";
        labelBotao = "Confirmar alterações";
        campoSenhaHabilitado = false;
        int idUsuarioLogado = (Integer) session.getAttribute("idUsuario");
        disabilitado = (idUsuario == idUsuarioLogado) ? "disabled" : "";
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script language="javascript">
            function enableDisable(bEnable, textBoxID)
            {
                document.getElementById(textBoxID).disabled = !bEnable;
            }
        </script>
    </head>
    <body>
        <jsp:include page="../menu.jsp"/>
        <div class="container mt-5">
            <div style="width: 50%; margin: 0 auto !important;">
                <form method="post" action="../usuarioServlet">
                    <div class="form-group" style="padding-top: 25px;">
                        <label><b>E-mail:</b></label>
                        <input type="email" name="email" class="form-control"
                               placeholder="E-mail do usuário"
                               value="<%=u.getEmail()%>"/>
                    </div>

                    <div class="form-group" style="padding-top: 25px;">
                        <label><b>Senha:</b></label>
                        <input type="password" <%= (campoSenhaHabilitado == false) ? "disabled" : ""%> name="senha" id="textBox" class="form-control"
                               value=""/>
                        <% if (!campoSenhaHabilitado) { %>
                        <input type="checkbox" name="alteraSenha" id="checkBox" onclick="enableDisable(this.checked, 'textBox')">
                        Alterar a senha do usuário
                        </input>
                        <% }%>
                    </div>
                    <br/>
                    <div class="form-group">
                        <label><b>Selecione o tipo de acesso:</b></label>
                        <select name="idTipoUsuario" class="form-control" <%=disabilitado%>>
                            <%
                                for (TipoUsuario c : listaTipos) {
                                    String opc = "";
                                    if (c.getIdTipo() == u.getIdTipoUsuario())
                                        opc = "selected";
                            %>

                            <option <%=opc%> value="<%=c.getIdTipo()%>"><%= c.getTipo()%></option>
                            <% }%>
                        </select>
                    </div>
                    <br/>
                    <div class="d-grid gap-2">              
                        <input type="hidden" name="tipoAcao" value="<%=tipoAcao%>"/>
                        <input type="hidden" name="idUsuario" value="<%=u.getIdUsuario()%>"/>
                        <input type="submit" class="btn btn-primary btn-block" 
                               value="<%=labelBotao%>"/> 
                        <a href="<%=request.getContextPath()%>/gestaousuarios.jsp" class="btn btn-danger">Voltar</a>

                    </div>
                </form>
            </div>
        </div> 
    </body>
</html>
