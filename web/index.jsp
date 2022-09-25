<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="br.sisacademico.controllers.processaLogin"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SisAcadêmico</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/5.5.2/bootbox.min.js"></script>
        <link rel="icon" href="img/icon.ico" type="image/x-icon" />
        <style>
            .login-card{
                padding: 100px 0 0 0;
                width: 380px;
                margin: 0 auto;
            }
            body{
                background-color: #eee;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">
                    <img src="<%=request.getContextPath()%>/img/logo.png" alt="" width="30" height="30" class="d-inline-block align-text-top">
                    SisAcadêmico
                </a>
            </div>
        </nav>
        <div class="container-fluid justify-content-between">
            <div class="row">
                <div class="login-card">
                    <div class="card">
                        <div class="card-body">
                            <form action="processaLogin" method="post">
                                <div class="form-group">
                                    <label>E-mail<span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <div class="input-group-text"><i class="bi bi-person-fill">
                                            </i>
                                        </div>
                                        <input required
                                               title="Insira e-mail no formato email@email.com" 
                                               pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" 
                                               type="email" 
                                               name="email" 
                                               class="form-control" 
                                               placeholder="E-mail">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label>Senha<span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <div class="input-group-text"><i class="bi bi-lock-fill"></i></div>
                                        <input 
                                            pattern="(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\W+)(?=^.{8,50}$).*$"
                                            title="Mínimo de 8 caracteres contendo: 1 letra maiúscula, 1 letra minúscula, 1 numeral e 1 caracter especial" 
                                            required type="password"  
                                            name="senha" 
                                            class="form-control" 
                                            placeholder="Senha">
                                    </div>
                                </div>
                                <br/>
                                <%
                                    if (!session.isNew() && session.getAttribute("autenticado") != null) {
                                        if (!(Boolean) session.getAttribute("autenticado")) {
                                            session.invalidate();
                                %>
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <strong>Usuário ou senha inválidos!</strong>
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                                <%                                        }
                                    }
                                %> 
                                <%
                                    if (request.getAttribute("status") == "resetSuccess") {
                                %>
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    <strong>Senha alterada com sucesso!</strong>
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                                <%
                                    }
                                %> 
                                <%
                                    if (request.getAttribute("status") == "resetFailed") {
                                %>
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <strong>Usuário não possui cadastro!</strong>
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                                <%
                                    }
                                %>                                 
                                <div class="d-grid">
                                    <button class="btn btn-lg btn-success btn-block" type="submit">Entrar</button>
                                    <a href="forgotPassword.jsp" class="btn btn-block text-primary ">Esqueci minha senha</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
