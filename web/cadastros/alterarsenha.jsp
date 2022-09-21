<%@page import="br.sisacademico.model.Usuario"%>
<%@page import="br.sisacademico.dao.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (!session.isNew() && session.getAttribute("autenticado") != null) {
        if (!(Boolean) session.getAttribute("autenticado")) {
            response.sendRedirect(request.getContextPath() + "/index.jsp?acesso=false");
        }
    } else {
        response.sendRedirect(request.getContextPath() + "/index.jsp?acesso=false");
    }
    String acao = "alteraSenha";

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alterar senha</title>
        <link rel="icon" href="../img/icon.ico" type="image/x-icon" />
    </head>
    <body>
        <jsp:include page="../menu.jsp"/>
        <script src="../js/validaSenha.js"></script>
        <%            if (request.getParameter("acao") != null) {
                if (Boolean.parseBoolean(request.getParameter("acao"))) {
        %>
        <div class="text-center alert alert-success" style="margin: 0 auto !important; margin-top:  30px;">Senha alterada!</div>
        <%
        } else {
        %>
        <div class="text-center alert alert-danger" style="margin: 0 auto !important; margin-top:  30px;">Senha antiga não confere!</div>
        <%
                }
            }
        %>
        <div class="container mt-5">
            <div style="width: 50%; margin: 0 auto !important;">
                <form method="post" action="../usuarioServlet">

                    <div class="form-group" style="padding-top: 25px;">
                        <label><b>Senha Atual:</b></label>
                        <input type="password" name="senhaAntiga" class="form-control"/>
                    </div>

                    <div class="form-group" style="padding-top: 25px;">
                        <label><b>Senha nova:</b></label>
                        <input type="password" name="senhaNova_1" id="senha" class="form-control required"/>
                    </div>

                    <div class="form-group" style="padding-top: 25px;">
                        <label><b>Repita a nova senha:</b></label>
                        <input type="password" name="senhaNova_2" id="senha_confirm" class="form-control required"/>
                    </div>
                    <input type="hidden" name="IdTipoUsuario" value="<%=session.getAttribute("IdTipoUsuario")%>"/>
                    <br/>
                    <div class="d-grid gap-2">
                        <input type="hidden" name="tipoAcao" value="<%=acao%>"/>
                        <button type="submit" class="btn btn-primary btn-block">Alterar</button>
                        <a href="<%=request.getContextPath()%>/home.jsp" class="btn btn-danger">Voltar</a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
