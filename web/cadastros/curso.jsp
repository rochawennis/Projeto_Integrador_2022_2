<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");

    String idCurso = "";
    String nomeCurso = "";
    String tipoCurso = "";
    String acao = "CADASTRO";
    String txtBotao = "Cadastrar Curso";

    if (request.getParameter("idCurso") != null) {
        nomeCurso = request.getParameter("curso");
        tipoCurso = request.getParameter("tipo");
        idCurso = request.getParameter("idCurso");
        acao = "EDICAO";
        txtBotao = "Alterar este Curso";
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="../img/icon.ico" type="image/x-icon" />
    </head>
    <body>
        <jsp:include page="../menu.jsp"></jsp:include>
            <div class="container mt-4 pt-4">
                <div style="width: 40%; margin: 0 auto;">
                    <form method="post" action="../CursoController">
                    <%
                        if (request.getParameter("erro") != null) {
                            if (!Boolean.parseBoolean(request.getParameter("erro"))) {
                    %>
                    <div class="alert alert-danger alert-dismissible d-flex align-items-center" role="alert">
                        <div class="container-fluid col-md-6"><strong>Curso já cadastrado!</strong></div>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>                    
                    <%
                            }
                        }
                        if (request.getParameter("ok") != null) {
                            if (!Boolean.parseBoolean(request.getParameter("ok"))) {
                    %>                       
                    <div class="alert alert-success alert-dismissible d-flex align-items-center" role="alert">
                        <div class="container-fluid col-md-13"><strong>Curso cadastrado com sucesso!</strong></div>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>                    
                    <%                            }
                        }
                    %>
                    <div class="form-goup">
                        <label>Nome do Curso:</label>
                        <input type="text" class="form-control" required name="nomeCurso" maxlength="90" value="<%=nomeCurso%>">
                    </div>

                    <div class="form-goup mt-4">
                        <label>Tipo de Curso:</label>
                        <input type="text" class="form-control" required name="tipoCurso" maxlength="50" value="<%=tipoCurso%>">
                    </div>

                    <div class="mt-4">
                        <input type="submit" class="btn btn-primary btn-md w-100" value="<%=txtBotao%>">
                    </div>

                    <input type="hidden" name="acao" value="<%=acao%>">
                    <input type="hidden" name="idCurso" value="<%=idCurso%>">
                </form>
            </div>
        </div>
    </body>
</html>
