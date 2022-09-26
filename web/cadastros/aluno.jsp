<%@page import="br.sisacademico.model.Aluno"%>
<%@page import="br.sisacademico.model.Usuario"%>
<%@page import="br.sisacademico.dao.UsuarioDAO"%>
<%@page import="br.sisacademico.model.Curso"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");

    String acao = "CADASTRO";
    String txtBotao = "Cadastrar";
    ArrayList<Curso> listaCursos = (ArrayList) session.getAttribute("listaCursos");
    String nomeAluno = "";
    String idAluno = "";
    int idCurso = -1;
    int idUsuario;
    idUsuario = (Integer) session.getAttribute("idUsuario");
    int ra = (int) Math.floor(Math.random() * 100000000);

    if (request.getParameter("idAluno") != null) {
        nomeAluno = request.getParameter("nome");
        ra = Integer.parseInt(request.getParameter("ra"));
        idAluno = request.getParameter("idAluno");
        idCurso = Integer.parseInt(request.getParameter("idCurso"));
        idUsuario = (Integer) session.getAttribute("idUsuario");
        acao = "EDICAO";
        txtBotao = "Atualizar este Aluno";
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
        <jsp:include page="../menu.jsp"></jsp:include>
            <div class="container mt-10 pt-4">
                <div style="width: 40%; margin: 0 auto;">
                    <form method="post" action="../AlunoController">
                    <%
                        if (request.getParameter("erro") != null) {
                            if (!Boolean.parseBoolean(request.getParameter("erro"))) {
                    %>
                    <div class="alert alert-danger alert-dismissible d-flex align-items-center" role="alert">
                        <div class="container-fluid col-md-6"><strong>Aluno já cadastrado!</strong></div>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>                    
                    <%
                            }
                        }
                        if (request.getParameter("ok") != null) {
                            if (!Boolean.parseBoolean(request.getParameter("ok"))) {
                    %>                       
                    <div class="alert alert-success alert-dismissible d-flex align-items-center" role="alert">
                        <div class="container-fluid col-md-13"><strong>Aluno cadastrado com sucesso!</strong></div>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>                    
                    <%                            }
                        }
                    %>
                    <div class="form-goup">
                        <label><b>RA:</b></label>
                        <input type="text" class="form-control" readonly required name="raAluno" maxlength="9" value="<%=ra%>">
                    </div>
                    <label><b>Nome do Aluno:</b></label>
                    <div class="input-group form-group">
                        <div class="input-group-text">
                            <i class="bi bi-person-circle"></i>
                        </div>
                        <input type="text" class="form-control" required name="nomeAluno" maxlength="50" value="<%=nomeAluno%>">
                    </div>
                    <label><b>E-mail:</b></label>
                    <div class="input-group form-group">
                        <div class="input-group-text">
                            <i class="bi bi-envelope-fill"></i>
                        </div>
                        <input title="Insira e-mail no formato email@email.com"
                               pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" 
                               required 
                               type="email" 
                               name="email" 
                               class="form-control"
                               placeholder="E-mail do aluno"
                               value=""/>
                    </div>
                    <label><b>CPF:</b></label>
                    <div class="input-group form-group">
                        <div class="input-group-text">
                            <i class="bi bi-postcard-fill"></i>
                        </div>
                        <input required 
                               type="text" 
                               name="CPF"
                               id="CPF" size="12" 
                               maxlength="14" placeholder="Ex: 000.000.000-00"  
                               class="form-control"
                               OnKeyPress="formatar('###.###.###-##', this)"
                               value=""
                               />
                    </div>
                    <label><b>Data de Nascimento:</b></label>
                    <div class="input-group form-group">
                        <div class="input-group-text">
                            <i class="bi bi-calendar-fill"></i>
                        </div>
                        <input value="" required type="date" name="nascimento"
                               id="nascimento" size="8"
                               maxlength="10" placeholder="Ex: 01/01/2022"  
                               class="form-control"  OnKeyPress="formatar('##/##/####', this)"/>
                    </div>
                    <label><b>Curso</b></label>
                    <div class="input-group form-group">
                        <div class="input-group-text">
                            <i class="bi bi-book-half"></i>
                        </div>
                        <select class="form-control" name="idCurso">
                            <%
                                for (Curso c : listaCursos) {
                                    String opc = "";
                                    if (c.getIdCurso() == idCurso)
                                        opc = "selected";
                            %>

                            <option <%=opc%> value="<%=c.getIdCurso()%>"><%= c.getNomeCurso() + " (" + c.getTipoCurso() + ")"%></option>
                            <% }%>
                        </select>
                    </div>
                    <div class="mt-4">
                        <input type="submit" class="btn btn-primary btn-md w-100" value="<%=txtBotao%>">
                    </div>
                    <input type="hidden" name="idUsuario" value="<%=idUsuario%>">
                    <input type="hidden" name="acao" value="<%=acao%>">
                    <input type="hidden" name="idAluno" value="<%=idAluno%>">
                </form>
            </div>
        </div>
    </body>
</html>
