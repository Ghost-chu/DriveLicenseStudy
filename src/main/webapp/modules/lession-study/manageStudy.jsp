<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.CategoryDao" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.QuestionDao" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.Question" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.Study" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.StudyDao" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.util.ServletHelper" %>
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
    <title>课程管理</title>
    <script src="<c:url value="/bootstrap/js/jquery.js"/>"></script>
    <jsp:include page="/bootstrap.jsp"/>
</head>
<body>
<jsp:include page="/common/navbar.jsp"/>
<%
    ServletHelper.checkLoggedIn(request,response,true);
    StudyDao dao = new StudyDao();
    List<Study> studies = dao.getStudies();
    request.setAttribute("studies", studies);
%>
<div class="container-fluid">
    <h1>课程管理</h1>
    <a class="btn btn-primary" href="insertStudy.jsp" role="button">添加课程</a>
    <table class="table">
        <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">分类</th>
            <th scope="col">标题</th>
            <th scope="col">BV号</th>
            <th scope="col">编辑</th>
            <th scope="col">删除</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${requestScope.studies}" var="study">
            <tr>
                <th scope="row">${study.id}</th>
                <td>${study.category}</td>
                <td>${study.title}</td>
                <td>${study.bvnumber}</td>
                <td><a href="editStudy.jsp?id=${study.id}">编辑</a></td>
                <td><a href="javascript:deleteStudy(${study.id})">删除</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
<script>
    function deleteStudy(studyId) {
        const r = confirm("你确定要删除序号为 " + studyId + " 的这条课程吗？\n这条课程将会被永久删除（真的很久！）");
        if (r === true) {
            const url = `/study-delete-servlet?id=` + studyId;
            fetch(url, {
                method: 'DELETE'
            })
                .then(response => response.json())
                .then(data => alert(data.message))
                .then(() => window.location.reload());
        }
    }
</script>
</html>
