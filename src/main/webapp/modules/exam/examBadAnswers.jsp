<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.User" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.BadAnswer" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.util.ServletHelper" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.BadAnswerDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.QuestionDao" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.Question" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>我的错题本</title>
    <jsp:include page="/bootstrap.jsp"/>
</head>
<body>
<jsp:include page="/common/navbar.jsp"/>

<%
    ServletHelper.checkLoggedIn(request, response, false);
    BadAnswerDao dao = new BadAnswerDao();
    QuestionDao questionDao = new QuestionDao();
    User user = (User) request.getSession().getAttribute("user");
    List<BadAnswer> badAnswerList = dao.getBadAnswers(user.getId());
    pageContext.setAttribute("badAnswers", badAnswerList);
%>

<div class="container-md">
    <h1>错题本</h1>
    <p>这里记录了您所做过的错题，当您下一次模拟测试中回答正确时，问题会自动从错题本中删除。您也可以在这里手动移除它们。</p>
    <table class="table">
        <thead>
        <tr>
            <th scope="col">问题</th>
            <th scope="col">删除此错题</th>
        </tr>
        </thead>
        <tbody>
        <%
            int count = 0;
        %>
        <c:forEach items="${badAnswers}" var="result">
            <c:set scope="page" var="result2" value="${result}"/>
            <%
                BadAnswer result = (BadAnswer) pageContext.getAttribute("result2");
                Question question = questionDao.getQuestionById(result.getQuestionId()).orElse(null);
                pageContext.setAttribute("question", question);
            %>
            <tr class="table">
                <td>
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <b><%=++count%>. ${question.title}</b>
                            </div>
                            <div class="col">
                                您的回答：<%=Arrays.toString(result.generateAnswers()).replace("[]", "<未作答>")%>
                                正确答案：<%=question == null ? "<问题已被删除>" : Arrays.toString(question.generateCorrectOptions())%>
                            </div>
                        </div>
                    </div>
                </td>
                <td>
                    <div class="container">
                        <div class="row">
                            <div class="col">
                    <a href="javascript:deleteBadAnswers(${result.id})">删除</a>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>


<%--$("#submitBtn").click(function () {--%>
<%--    var questions = [];--%>
<%--    $("input[type=checkbox]:checked").each(function () {--%>
<%--        questions.push($(this).attr("name"));--%>
<%--    });--%>
<%--    $.ajax({--%>
<%--        url: "<c:url value="/exam-submit-servlet"/>",--%>
<%--        type: "post",--%>
<%--        data: {--%>
<%--            questions: questions--%>
<%--        },--%>
<%--        success: function (data) {--%>
<%--            alert(data);--%>
<%--        }--%>
<%--    });--%>
});
<script>
    function deleteBadAnswers(badAnswerId) {
        const r = confirm("你确定要删除这条错题吗？\n这条错题将会被永久删除（真的很久！）");
        if (r === true) {
            const url = `/remove-bad-answer?id=` + badAnswerId;
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