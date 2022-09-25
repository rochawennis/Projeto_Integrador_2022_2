<%@page import="br.sisacademico.dao.TipoUsuarioDAO"%>
<%@page import="br.sisacademico.model.TipoUsuario"%>
<%@page import="br.sisacademico.model.Usuario"%>
<%@page import="br.sisacademico.dao.UsuarioDAO"%>
<%@page import="java.util.ArrayList"%>
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
    u.setNome("");
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
        disabilitado = (idUsuario == idUsuarioLogado) ? "pointer-events: none;" : "";
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="../img/icon.ico" type="image/x-icon" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
        <script language="javascript">
            function enableDisable(bEnable, textBoxID)
            {
                document.getElementById(textBoxID).disabled = !bEnable;
            }
        </script>
        <script language="javascript">
            function formatar(mascara, documento) {
                var i = documento.value.length;
                var saida = mascara.substring(0, 1);
                var texto = mascara.substring(i);
                if (texto.substring(0, 1) !== saida) {
                    documento.value += texto.substring(0, 1);
                }
            }
        </script>
    </head>
    <body>
        <jsp:include page="../menu.jsp"/>
        <div>
            <div style="width: 30%; margin: 0 auto ;">
                <form method="post" action="../usuarioServlet">
                    <div class="form-group" style="padding-top: 25px;">
                        <label><b>Nome:</b></label>
                        <div class="input-group form-group">
                            <div class="input-group-text">
                                <i class="bi bi-person-circle"></i>
                            </div>
                            <input required type="text" name="nome" class="form-control"
                                   placeholder="Nome"
                                   value="<%=u.getNome()%>"/>
                        </div>
                        <label><b>E-mail:</b></label>
                        <div class="input-group form-group">
                            <div class="input-group-text">
                                <i class="bi bi-envelope-fill"></i>
                            </div>
                            <input required type="email" name="email" class="form-control"
                                   placeholder="E-mail do usuário"
                                   value="<%=u.getEmail()%>"/>
                        </div>
                        <label><b>CPF:</b></label>
                        <div class="input-group form-group">
                            <div class="input-group-text">
                                <i class="bi bi-postcard-fill"></i>
                            </div>
                            <input required type="text" id="Cpf" size="12" maxlength="14" placeholder="Ex: 000.000.000-00"  class="form-control"  OnKeyPress="formatar('###.###.###-##', this)"/>
                        </div>
                        <label><b>Senha:</b></label>
                        <div class="input-group form-group">
                            <div class="input-group-text">
                                <i class="bi bi-lock-fill"></i>
                            </div>
                            <input required type="password" <%= (campoSenhaHabilitado == false) ? "disabled" : ""%> name="senha" id="textBox" class="form-control"
                                   value=""/> 
                        </div>
                        <% if (!campoSenhaHabilitado) { %>
                        <input type="checkbox" name="alteraSenha" id="checkBox" onclick="enableDisable(this.checked, 'textBox')">
                        Alterar a senha do usuário
                        </input>
                        <% }%>
                        <br/>
                        <div class="form-group">
                            <label><b>Selecione o tipo de acesso:</b></label>
                            <select required name="idTipoUsuario" class="form-control" style="<%=disabilitado%>">
                                <<option> </option>
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
                    </div>
                </form>
            </div>
        </div> 
    </body>
</html>
