<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.CategoryDao" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.Category" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>开始学习</title>
    <jsp:include page="/bootstrap.jsp"/>
    <%
        CategoryDao dao = new CategoryDao();
        List<Category> categories = dao.getCategories();
        request.setAttribute("categories", categories);
    %>
</head>
<body>
<jsp:include page="/common/navbar.jsp"/>
<div class="jumbotron">
    <h1>开始学习</h1>
    <p class="lead">你想从哪里开始学习……？</p>
    <hr class="my-4">
</div>

<div class="container-md">
    <div class="container">
        <div class="row">
            <c:forEach items="${requestScope.categories}" var="category">
            <div class="col-sm">
                    <div class="card" style="width: 18rem;">
                        <div class="card-body">
                            <h5 class="card-title">${category.categoryName}</h5>
                            <p class="card-text">从 ${category.categoryName} 开始学习</p>
                            <a href="<c:url value="/modules/lession-study/lession-study-index.jsp?category=${category.categoryName}"/>"
                               class="btn btn-primary">学习 ${category.categoryName}</a>
                        </div>
                    </div>
            </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>