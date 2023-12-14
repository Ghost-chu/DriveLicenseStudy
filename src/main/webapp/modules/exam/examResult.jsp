<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.Question" %>
<%@ page import="java.util.LinkedHashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.util.ServletHelper" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>考试结束</title>
    <jsp:include page="/bootstrap.jsp"/>
</head>
<body>
<jsp:include page="/common/navbar.jsp"/>
<%
    ServletHelper.checkLoggedIn(request, response, false);
    Map<Long, String[]> questionCallback = (Map<Long, String[]>) session.getAttribute("examCallback");
    Map<Question, Boolean> questionResult = (Map<Question, Boolean>) session.getAttribute("examResult");
    Map<Long, String[]> questionReference = (Map<Long, String[]>) session.getAttribute("examReference");
%>

<div class="container-md">
    <h1>考试结束</h1>
    <c:if test="${sessionScope.examStatus == 'true'}">
        <h3 style="color: green">成绩合格，考试通过</h3>
    </c:if>
    <c:if test="${sessionScope.examStatus == 'false'}">
        <h3 style="color: red">成绩不及格，考试未通过</h3>
    </c:if>
    <ul>
        <li>考试成绩：${sessionScope.examScore}</li>
    </ul>
    <table class="table">
        <thead>
        <tr>
            <th scope="col">问题</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${sessionScope.examResult}" var="result">
            <c:set scope="page" var="questionId" value="${result.key.id}"/>
            <%
                int count = 0;
            %>
            <c:if test="${!result.value}">
                <tr class="bg-danger">
            </c:if>
            <c:if test="${result.value}">
                <tr class="bg-success">
            </c:if>
            <td>
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <b><%=++count%>. ${result.key.title}</b>
                        </div>
                        <div class="col">
                            您的回答：<%=questionCallback.get(pageContext.getAttribute("questionId")).length == 0 ? "<未作答>" : Arrays.toString(questionCallback.get(pageContext.getAttribute("questionId")))%>
                            正确答案：<%=Arrays.toString(questionReference.get(pageContext.getAttribute("questionId")))%>
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
<script>
    // change the tr background color to blue via css style way when any checkbox is checked
    $("input[type=checkbox]").change(function () {
        const tr = $(this).parent().parent().parent().parent().parent();
        if ($(this).is(":checked")) {
            tr.addClass("bg-info");
        } else {
            tr.removeClass("bg-info");
        }
    });


</script>


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
</script>
</html>