<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="br.sisacademico.controllers.processaLogin"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SisAcadêmico</title>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Material+Icons">
        <link rel="stylesheet" href="https://unpkg.com/bootstrap-material-design@4.1.1/dist/css/bootstrap-material-design.min.css" integrity="sha384-wXznGJNEXNG1NFsbm0ugrLFMQPWswR3lds2VeinahP8N0zJw9VWSopbjv2x7WCvX" crossorigin="anonymous">
        <link rel="icon" href="img/icon.ico" type="image/x-icon" />
        <style>
            .login-card{
                padding: 100px 0 0 0;
                width: 380px;
                margin: 0 auto;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <a class="navbar-brand" href="#">
                <img src="<%=request.getContextPath()%>/img/logo.png" alt="" width="30" height="30" class="d-inline-block align-text-top">
                SisAcadêmico
            </a>
        </nav>
        <div class="container">
            <div class="row">
                <div class="login-card">
                    <div class="card">
                        <div class="card-body">
                            <form action="processaLogin" method="post">
                                <div class="form-group">
                                    <input type="email" class="form-control" name="email" placeholder="E-mail"/>
                                </div>
                                <div class="form-group">
                                    <input type="password" class="form-control" name="senha" placeholder="Senha"/>
                                </div>
                                <%
                                    if (!session.isNew() && session.getAttribute("autenticado") != null) {
                                        if (!(Boolean) session.getAttribute("autenticado")) {
                                %>
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <strong>Usuário ou senha inválidos!</strong>
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                                <%
                                        }
                                    }
                                %> 
                                <button class="btn btn-lg btn-outline-info btn-block" type="submit">Entrar</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
