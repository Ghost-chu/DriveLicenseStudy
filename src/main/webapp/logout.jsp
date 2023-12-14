<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2023/12/2
  Time: 13:51
  To change this template use File | Settings | File Templates.
--%>
<%
    request.getSession().invalidate();
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登出系统</title>
    <script src="<c:url value="/bootstrap/js/jquery.js"/>"></script>
    <jsp:include page="/bootstrap.jsp"/>
</head>
<body>
<jsp:include page="/common/navbar.jsp"/>
<div class="container">
    <h1>登出成功</h1>
    <p>点击<a href="<c:url value="/index.jsp"/>">此处</a>返回系统首页。</p>
</div>
</html>
