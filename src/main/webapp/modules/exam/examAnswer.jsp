<%@ page import="com.ghostchu.ytkj.drivelicensestudy.util.ServletHelper" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    ServletHelper.checkLoggedIn(request, response, false);
%>
<!DOCTYPE html>
<html>
<head>
    <title>考试页面</title>
    <jsp:include page="/bootstrap.jsp"/>
</head>
<body>
<jsp:include page="/common/navbar.jsp"/>

<div class="container-md">
    <h1>考试须知</h1>
    <ul>
        <li>听从工作人员安排，在待考场顺序领取本人学车档案;</li>
        <li>携带并出示本人身份证，接受监考民警审核；</li>
        <li>进入考试区域必须关闭手机；</li>
        <li>进入考试区域不许大声喧哗；</li>
        <li>法规课本不许带入考场(或放进包内)；</li>
        <li>考试结束后，身份证本人收好保存，将档案交到考场前方的交证窗口；</li>
        <li>考试及格的学员在考场出口在工作人员指导下签字后离开考场；</li>
        <li>考试不及格的学员，即可离开考场，听候所在驾校工作人员通知补考时间。</li>
    </ul>
    <p>

    </p>
    <form action="<c:url value="/exam-submit-servlet"/>" method="post">
        <input type="text" hidden="hidden" name="category" value="${sessionScope.examCategory}"/>
        <table class="table">
            <thead>
            <tr>
                <th scope="col">问题</th>
            </tr>
            </thead>
            <tbody>
            <%int count = 0; %>
            <c:forEach items="${sessionScope.examQuestions}" var="question">
            <%
                String trClass = "table";
                if (count % 2 == 0) {
                    trClass = "table-active";
                }
            %>
            <tr class="<%=trClass%>">
                <td>
                    <div class="container">
                        <div class="row">
                            <div class="col">
                                <b><%=++count%>. ${question.title}</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="checkbox" name="${question.id}" id=""
                                           value="A">
                                    <label class="form-check-label">A. ${question.optionA}</label>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="checkbox" name="${question.id}" value="B">
                                    <label class="form-check-label">B. ${question.optionB}</label>
                                </div>
                            </div>
                            <c:if test="${question.optionC != null && !empty(question.optionC)}">
                                <div class="col">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" name="${question.id}" value="C">
                                        <label class="form-check-label">C. ${question.optionC}</label>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${question.optionD != null && !empty(question.optionD)}">
                                <div class="col">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="checkbox" name="${question.id}" value="D">
                                        <label class="form-check-label">D. ${question.optionD}</label>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </td>
            </tr>
                </c:forEach>
            </tbody>
        </table>
        <button id="submitBtn" type="submit" class="btn btn-primary">确认无误</button>
    </form>
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
</html>