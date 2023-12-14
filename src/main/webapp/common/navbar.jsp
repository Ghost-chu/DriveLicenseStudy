<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.CategoryDao" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    body{
        background-color: #f1f1f1;
    }
</style>
<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2023/12/2
  Time: 13:36
  To change this template use File | Settings | File Templates.
--%>
<%
    CategoryDao dao = new CategoryDao();
    List<Category> categories = dao.getCategories();
    request.setAttribute("categories", categories);
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #409697">
    <a class="navbar-brand" href="#">
        <img src="<c:url value="/image/icon.png"/>" width="32" height="32" alt="">
    </a>
    <a class="navbar-brand" href="<c:url value="/"/>">烟科学车</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse"
            data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
            aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="<c:url value="/"/>">首页 <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"></a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="<c:url value="/modules/lession-study/welcome-study.jsp"/>"
                   role="button" data-toggle="dropdown" aria-expanded="false">
                    课程学习
                </a>
                <div class="dropdown-menu">
                    <c:forEach items="${requestScope.categories}" var="category">
                        <a class="dropdown-item"
                           href="<c:url value="/modules/lession-study/lession-study-index.jsp?category=${category.categoryName}"/>">${category.categoryName}</a>
                    </c:forEach>
                </div>
            </li>
            <c:if test="${sessionScope.user != null}">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="<c:url value="/modules/lession-study/welcome-study.jsp"/>"
                       role="button" data-toggle="dropdown" aria-expanded="false">
                        考试系统
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="<c:url value="/modules/exam/examPrepare.jsp"/>">在线模拟考试</a>
                        <a class="dropdown-item" href="<c:url value="/modules/exam/examBadAnswers.jsp"/>">我的错题本</a>
                    </div>
                </li>
            </c:if>
        </ul>
        <c:if test="${sessionScope.user != null}">
            <a class="nav-link" style="color:#ffffff"
               href="<c:url value="/usercp.jsp"/>">进入 <%=((User) session.getAttribute("user")).getUsername()%>
                用户控制面板</a>
        </c:if>
        <c:if test="${sessionScope.user == null}">
            <a class="nav-link" style="color:#ffffff" href="<c:url value="/login.jsp"/>">您好，游客。请登录</a>
        </c:if>

    </div>
</nav>
