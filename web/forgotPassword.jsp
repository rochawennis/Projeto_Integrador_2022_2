<!doctype html>
<html>
    <head>
        <meta charset='utf-8'>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <title>Reset de Senha</title>
        <link rel="icon" href="img/icon.ico" type="image/x-icon" />
        <link
            href='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css'
            rel='stylesheet'>
        <link href='' rel='stylesheet'>
        <script type='text/javascript'
        src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
        <script type='text/javascript'
        src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js'></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/5.5.2/bootbox.min.js"></script>
        <style>
            body {
                background-position: center;
                background-color: #eee;
                background-repeat: no-repeat;
                background-size: cover;
                color: #505050;
                font-family: "Rubik", Helvetica, Arial, sans-serif;
                font-size: 14px;
                font-weight: normal;
                line-height: 1.5;
                text-transform: none
            }

            .forgot {
                background-color: #fff;
                padding: 12px;
                border: 1px solid #dfdfdf
            }

            .padding-bottom-3x {
                padding-bottom: 72px !important
            }

            .card-footer {
                background-color: #fff
            }

            .btn {
                font-size: 13px
            }

            .form-control:focus {
                color: #495057;
                background-color: #fff;
                border-color: #76b7e9;
                outline: 0;
                box-shadow: 0 0 0 0px #28a745
            }
        </style>
    </head>
    <body oncontextmenu='return false' class='snippet-body'>
        <div class="container padding-bottom-3x mb-2 mt-5">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10">
                    <div class="forgot">
                        <h2>Esqueceu sua senha?</h2>
                        <p>Altere sua senha em três etapas fáceis. Isso ajudará você a proteger sua senha!</p>
                        <ol class="list-unstyled">
                            <li><span class="text-primary text-medium">1. </span>Digite seu e-mail abaixo.</li>
                            <li><span class="text-primary text-medium">2. </span>
                                Nosso sistema enviará um código para seu e-mail.</li>
                            <li><span class="text-primary text-medium">3. </span>Digite o código na próxima página.</li>
                        </ol>
                    </div>
                    <%
                        if (request.getAttribute("erro") != null) {
                    %>
                    <div class="alert alert-danger alert-dismissible d-flex align-items-center" role="alert">
                        <div class="container-fluid col-md-6"><strong>E-mail informado não possui cadastro!</strong></div>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>                    
                    <%
                        }
                    %>
                    <form class="card mt-4" action="forgotPassword" method="POST">
                        <div class="card-body">
                            <div class="form-group">
                                <label for="email-for-pass">Insira seu e-mail</label> <input
                                    class="form-control" type="text" name="email" id="email-for-pass" required=""><small
                                    class="form-text text-muted">Digite o endereço de e-mail registrado. Em seguida, enviaremos um código para este e-mail.</small>
                            </div>
                        </div>
                        <div class="card-footer">
                            <button class="btn btn-success" type="submit">Enviar código</button>
                            <a href="index.jsp" class="btn btn-danger" type="submit">Retornar</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>