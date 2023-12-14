<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2023/12/2
  Time: 13:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>访问被拒绝</title>
    <script src="<c:url value="/bootstrap/js/jquery.js"/>"></script>
    <jsp:include page="/bootstrap.jsp"/>
</head>
<body>
<jsp:include page="/common/navbar.jsp"/>
<div class="container">
    <h1>访问被拒绝</h1>
    <p>很抱歉，您没有访问此页面的权限，请尝试<a href="<c:url value="/login.jsp"/>">登录</a>。</p>
</div>
</html>
