<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.CategoryDao" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.Category" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.StudyDao" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.Study" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2023/12/2
  Time: 13:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>课程学习</title>
    <jsp:include page="/bootstrap.jsp"/>

    <%
        String categoryStr = request.getParameter("category");
        CategoryDao dao = new CategoryDao();
        Category category = dao.getCategoryByName(categoryStr).orElseThrow();
        StudyDao studyDao = new StudyDao();
        List<Study> studyList = studyDao.getStudiesByCategory(category);
        request.setAttribute("studies", studyList);
    %>
</head>
<body>
<jsp:include page="/common/navbar.jsp"/>
<div class="container-md">
    <h1>课程学习 - <%=category.getCategoryName()%></h1>
    <table class="table">
        <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">课程标题</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${requestScope.studies}" var="study">
            <tr>
                <th scope="row">${study.id}</th>
                <td><a href="study.jsp?id=${study.id}">${study.title}</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
