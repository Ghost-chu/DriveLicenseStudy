<%@ page import="com.oracle.wls.shaded.org.apache.xpath.objects.XString" %><%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2023/12/2
  Time: 14:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册成功</title>
    <jsp:include page="/bootstrap.jsp"/>
</head>
<body>
<jsp:include page="/common/navbar.jsp"/>
<form action="" method="post">
    <%
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        session.setAttribute("id",id);
        String name = request.getParameter("name");
        session.setAttribute("name",name);
        String password = request.getParameter("name");
        session.setAttribute("name",name);
    %>
</form>
</body>
</html>
