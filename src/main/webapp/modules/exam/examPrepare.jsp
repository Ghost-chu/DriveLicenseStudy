<%@ page import="com.ghostchu.ytkj.drivelicensestudy.util.ServletHelper" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.CategoryDao" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.Category" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    ServletHelper.checkLoggedIn(request, response, false);
    CategoryDao categoryDao = new CategoryDao();
    List<Category> categories = categoryDao.getCategories().stream().filter(f -> f.getExamQuestions() > 0).toList();
    pageContext.setAttribute("categories", categories);
%>
<!DOCTYPE html>
<html>
<head>
    <title>模拟考试</title>
    <jsp:include page="/bootstrap.jsp"/>
</head>
<body>
<jsp:include page="/common/navbar.jsp"/>
<div class="jumbotron">
    <h1>模拟开始</h1>
    <p class="lead">学习的怎么样？来看看吧！</p>
    <hr class="my-4">
    <p>选择你想要开始的考试科目，开始作答！</p>
</div>

<div class="container-md">
    <div class="container">
        <div class="row row-cols-3">
            <c:forEach items="${pageScope.categories}" var="category">
                <c:if test="${category.examQuestions != 0}">
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">${category.categoryName}</h5>
                                <p class="card-text">${category.categoryName}模拟测验，共有 ${category.examQuestions} 道题。</p>
                                <a href="<c:url value="/exam-setup-servlet?category=${category.categoryName}"/>"
                                   class="btn btn-primary">试试看！</a>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>