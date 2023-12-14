<%--
  Created by IntelliJ IDEA.
  User: 35409
  Date: 2023/11/29
  Time: 8:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<html>--%>
<%--<head>--%>
<%--    <title>Title</title>--%>
<%--    <jsp:include page="/bootstrap.jsp"/>--%>
<%--</head>--%>
<%--<body>--%>


<%--<form action="LogonServlet" method="post">--%>
<%--    账号:<input type="name" name="name"><br>--%>
<%--    密码:<input type="password" name="password"><br>--%>
<%--    <input type="submit" value="ok">--%>
<%--    如果没有注册请点击<a href="register.jsp">这里</a>--%>

<%--</form>--%>
<%--</body>--%>
<%--</html>--%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>登陆系统</title>
    <jsp:include page="/bootstrap.jsp"/>
    <link rel="stylesheet" type="text/css" href="css/my-login.css">
</head>

<body class="my-login-page">
<section class="h-100">
    <div class="container h-100">
        <div class="row justify-content-md-center h-20">
            <div class="card-wrapper">
                <div>
                    <br> <br> <br> <br>
                    <center><h3>烟科学车</h3></center>
                </div>
                <div class="card fat">
                    <div class="card-body">
                        <h4 class="card-title">系统登陆</h4>
                        <form method="POST" class="my-login-validation" novalidate="" action="">
                            <div class="form-group">
                                <label for="username">用户名</label>
                                <input id="username" type="text" class="form-control" name="username" value="" required
                                       autofocus>
                            </div>

                            <div class="form-group">
                                <label for="password">密码
                                    <a href="forgot.jsp" class="float-right">
                                        忘记密码？
                                    </a>
                                </label>
                                <input id="password" type="password" class="form-control" name="password" required
                                       data-eye>
                                <div class="invalid-feedback">
                                    需要填写密码
                                </div>
                            </div>

                            <%--                            <div class="form-group">--%>
                            <%--                                <div class="custom-checkbox custom-control">--%>
                            <%--                                    <input type="checkbox" name="remember" id="remember" class="custom-control-input">--%>
                            <%--                                    <label for="remember" class="custom-control-label">Remember Me</label>--%>
                            <%--                                </div>--%>
                            <%--                            </div>--%>

                            <div class="form-group m-0">
                                <button type="submit" id="loginBtn" class="btn btn-primary btn-block">
                                    登录
                                </button>
                            </div>
                            <div class="mt-4 text-center">
                                还没有账号？ <a href="register.jsp">注册一个</a>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="footer">
                    烟科学车 - 仅用于课程设计作业
                </div>
            </div>
        </div>
    </div>
</section>
<script src="js/popper.min.js" crossorigin="anonymous"></script>
<script src="js/my-login.js"></script>
<script>
    $(function () {
        $("#loginBtn").click(function () {
            event.preventDefault()
            const $userId = $("#username");//储存文本框的jQ对象
            const $pwd = $("#password");//储存密码框的jQ对象
            //登录的ajax
            $.ajax({
                url: "/login-servlet-ajax",
                type: "post",
                data: {
                    username: $userId.val(),
                    password: $pwd.val()
                },
                success: function (result) {
                    if (result.message !== undefined) {
                        alert(result.message)
                    }
                    if (result.jumpUrl !== undefined) {
                        window.location = result.jumpUrl
                    }
                },
                error: function (result) {
                    alert("炸锅了炸锅了，出错了！！！\n" + result)
                }
            });
        })
    });
</script>
</body>
</html>

