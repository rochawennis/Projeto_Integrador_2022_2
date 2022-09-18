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

    boolean acessoFull = session.getAttribute("tipoUsuario").equals("admin") ? true : false;

    if (!acessoFull) {
        response.sendRedirect("404.jsp");
    }

    int idUSuarioLogado = (Integer) session.getAttribute("idUsuario");

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="menu.jsp"/>

        <%            if (request.getParameter("acao") != null) {
                if (Boolean.parseBoolean(request.getParameter("acao"))) {
        %>
        <div class="text-center alert alert-success" style="margin: 0 auto !important; margin-top:  30px;">Ação realizada com sucesso!</div>
        <%
        } else {
        %>
        <div class="text-center alert alert-danger" style="margin: 0 auto !important; margin-top:  30px;">Erro ao realizar a operação!</div>
        <%
                }
            }
        %>

        <script src="../js/trataExclusao.js"></script>
        <script>
            $(function () {
                $('[data-toggle="tooltip"]').tooltip();
            });
        </script>
        <%
            UsuarioDAO uDAO = new UsuarioDAO();
            ArrayList<Usuario> usuarios = uDAO.getUsuarios();
            int count = 1;
        %>

        <script src="js/trataExclusao.js"></script>
        <div class="mt-4">
            <div style="width: 90%; margin: 0 auto !important;">

                <table class="table table-bordered text-center">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">E-mail</th>
                            <th scope="col">Tipo de Usuário</th>
                            <th scope="col">Editar</th>
                            <th scope="col">Excluir</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Usuario u : usuarios) {%>
                        <tr>
                            <td><%=count++%></td>
                            <td><%=u.getEmail()%></td>
                            <td><%=u.getTipo()%></td>
                            <td><a href="cadastros/usuario.jsp?idUsuario=<%=u.getIdUsuario()%>" class="btn btn btn-outline-info">Editar</a></td>
                            <%
                                if (u.getIdUsuario() == idUSuarioLogado) {
                            %>
                            <td>
                                <span data-toggle="tooltip" title="Você não pode se deletar!">
                                    <button class="btn btn-secondary btn-outline-secondary" disabled style="pointer-events: none;" type="button" disabled>Apagar</button>
                                </span>
                            </td>
                            <%
                            } else {
                            %>
                            <td><a href="usuarioServlet?tipoAcao=delete&idUsuario=<%=u.getIdUsuario()%>" class="btn btn-outline-danger" id="deleteUsuario">Apagar</a></td>
                            <% } %>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
                <div>
                    <div class="d-grid gap-2 d-md-flex justify-content-between">
                        <a href="cadastros/usuario.jsp" class="btn btn-success">Novo usuário</a>
                        <a href="<%=request.getContextPath()%>/home.jsp" class="btn btn-danger">Voltar</a>
                    </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
