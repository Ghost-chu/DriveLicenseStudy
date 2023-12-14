<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.CategoryDao" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.Question" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.QuestionDao" %>
<%@ page import="com.oracle.wls.shaded.org.apache.xpath.objects.XString" %>
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
    <title>插入问题</title>
    <script src="<c:url value="/bootstrap/js/jquery.js"/>"></script>
    <jsp:include page="/bootstrap.jsp"/>
</head>
<body>
<jsp:include page="/common/navbar.jsp"/>
<%
    ServletHelper.checkLoggedIn(request,response,true);
    CategoryDao dao = new CategoryDao();
    List<String> selectiveCategories = dao.getCategories().stream().map(Category::getCategoryName).toList();
    request.setAttribute("categories", selectiveCategories);
    QuestionDao edit = new QuestionDao();
    Question question = edit.getQuestionById(Long.parseLong(request.getParameter("id"))).orElseThrow();
    String studyCategoryName = question.getCategory();
    int pos = 0;

    for (int i = 0; i < selectiveCategories.size(); i++) {
        if (selectiveCategories.get(i).equals(studyCategoryName)) {
            pos = i;
            break;
        }
    }

    String questionTitle = question.getTitle();
    String correct = question.getCorrect();
    String optionA = question.getOptionA();
    String optionB = question.getOptionB();
    String optionC = question.getOptionC();
    String optionD = question.getOptionD();

%>
<div class="container-md">
    <h1>向题库插入问题</h1>

    <form action="<c:url value="/question-update-servlet"/>" method="post">
        <div class="form-group">
            <label for="category">题目分类</label>
            <small id="categoryHelp" class="form-text text-muted">选择题目分类类型</small>
            <select id="category" name="category" class="form-control" aria-describedby="categoryHelp">
                <c:forEach items="${requestScope.categories}" var="categoryName">
                    <option value="${categoryName}">${categoryName}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label for="title">题干</label>
            <textarea rows="5" class="form-control" id="title" name="title"></textarea>
        </div>
        <div class="form-group">
            <label for="answerA">候选答案A（必填）</label>
            <input type="text" class="form-control" id="answerA" name="answerA">
            <label for="answerB">候选答案B（必填）</label>
            <input type="text" class="form-control" id="answerB" name="answerB">
            <label for="answerC">候选答案C</label>
            <input type="text" class="form-control" id="answerC" name="answerC">
            <label for="answerD">候选答案D</label>
            <input type="text" class="form-control" id="answerD" name="answerD">
        </div>
        <small id="correct-desc" class="form-text">选择本题的正确答案</small>
        <div class="form-group form-check">
            <input type="checkbox" class="form-check-input" id="isCorrectA" name="correctAnswer" value="A">
            <label class="form-check-label" for="isCorrectA" >A</label>
        </div>
        <div class="form-group form-check">
            <input type="checkbox" class="form-check-input" id="isCorrectB" name="correctAnswer" value="B">
            <label class="form-check-label" for="isCorrectB">B</label>
        </div>
        <div class="form-group form-check">
            <input type="checkbox" class="form-check-input" id="isCorrectC" name="correctAnswer" value="C">
            <label class="form-check-label" for="isCorrectC">C</label>
        </div>
        <div class="form-group form-check">
            <input type="checkbox" class="form-check-input" id="isCorrectD" name="correctAnswer" value="D">
            <label class="form-check-label" for="isCorrectD">D</label>
        </div>
        <button id="submitBtn" type="submit" class="btn btn-primary">确认无误，保存到数据库</button>
    </form>
</div>
</body>
<script>
    const categoryElement = document.getElementById("category");
    categoryElement.selectedIndex = <%=pos%>;
    const titleElement = document.getElementById("title");
    titleElement.value = "<%=questionTitle%>";
    const correctElement = document.getElementById("correct");
    correctElement.value = "<%=correct%>";
    const optionAElement = document.getElementById("optionA");
    optionAElement.value = "<%=optionA%>";
    const optionBElement = document.getElementById("optionB");
    optionBElement.value = "<%=optionB%>";
    const optionCElement = document.getElementById("optionC");
    optionCElement.value = "<%=optionC%>";
    const optionDElement = document.getElementById("optionD");
    optionDElement.value = "<%=optionD%>";

</script>
</html>
