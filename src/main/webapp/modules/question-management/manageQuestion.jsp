<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.CategoryDao" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.QuestionDao" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.Question" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
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
    <title>题库管理</title>
    <script src="<c:url value="/bootstrap/js/jquery.js"/>"></script>
    <jsp:include page="/bootstrap.jsp"/>
</head>
<body>
<jsp:include page="/common/navbar.jsp"/>
<%
    ServletHelper.checkLoggedIn(request,response,true);
    QuestionDao dao = new QuestionDao();
    List<Question> questions = dao.getQuestions();
    request.setAttribute("questions", questions);
    questions.forEach(q->{
        q.setTitle(StringUtils.substring(q.getTitle(), 0, 70));
        if(q.getTitle().length() >=70){
            q.setTitle(q.getTitle()+"...");
        }
    });
%>
<div class="container-fluid">
    <h1>题库管理</h1>
    <a class="btn btn-primary" href="insertQuestion.jsp" role="button">添加问题</a>
    <table class="table">
        <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">分类</th>
            <th scope="col">标题</th>
            <th scope="col">编辑</th>
            <th scope="col">删除</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${requestScope.questions}" var="question">
            <tr>
                <th scope="row">${question.id}</th>
                <td>${question.category}</td>
                <td>${question.title}</td>
                <td><a href="editQuestion.jsp?id=${question.id}">编辑</a></td>
                <td><a href="javascript:deleteQuestion(${question.id})">删除</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
<script>
    function deleteQuestion(employerNumber) {
        const r = confirm("你确定要删除序号为 " + employerNumber + " 的这条问题吗？\n这条数据将会被永久删除（真的很久！）");
        if (r === true) {
            const url = `/question-delete-servlet?id=` + employerNumber;
            fetch(url, {
                method: 'DELETE'
            })
                .then(response => response.text())
                .then(data => alert(data))
                .then(() => window.location.reload());
        }
    }
</script>
</html>
