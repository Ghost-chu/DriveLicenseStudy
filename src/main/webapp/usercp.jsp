<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.UserDao" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.User" %>
<%@ page import="java.util.Optional" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.util.ServletHelper" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.ExamResultDao" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.ExamDetailDao" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.QuestionDao" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2023/12/2
  Time: 20:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户控制面板</title>
    <script src="<c:url value="/bootstrap/js/jquery.js"/>"></script>
    <jsp:include page="/bootstrap.jsp"/>
</head>
<body>
<jsp:include page="/common/navbar.jsp"/>
<%
    ServletHelper.checkLoggedIn(request, response, false);
    User user = (User) session.getAttribute("user");
    request.setAttribute("user", user);
%>
<div class="container-md">
    <div class="alert alert-primary" role="alert">
        <b>公告：</b>用户管理面板维护中，目前暂不支持密码找回和用户名修改功能！问就是偷懒了！
    </div>
    <h1>用户管理面板</h1>
    <%
        String welcome = "您已作为站点用户登录到系统。";
        if (user.isAdmin()) {
            welcome = "您已作为系统管理员登录到系统，隐藏版块已为您开放。";
        }
    %>
    <div class="bd-callout bd-callout-success">
        <h5 id="conveying-meaning-to-assistive-technologies">欢迎您回来，<%=user.getUsername()%>
        </h5>
        <p><%=welcome%>
        </p>
    </div>

<%

    ExamResultDao examResultDao = new ExamResultDao();
    double rate = examResultDao.getUserExamCorrectRate(user.getId());
    String rateString = String.format("%.2f",rate * 100) + "%";
    String advice;
    if(rate > 0.9){
        advice = "考试通过率很高，继续练习吧";
    }else if(rate > 0.7){
        advice = "继续练习，达到 90% 再考试";
    }else {
        advice = "考试通过率很低，达到 90% 以上再报名";
    }

    ExamDetailDao examDetailDao = new ExamDetailDao();
    QuestionDao questionDao = new QuestionDao();
    long answeredCount = examDetailDao.getUserAnsweredUniqueQuestionsCount(user.getId());
    long totalQuestionsCount = questionDao.getQuestions().size();
    double rateAnswered = (double) answeredCount / totalQuestionsCount;
    String rateAnsweredString = String.format("%.2f",rateAnswered * 100) + "%";

    long examCount = examResultDao.getExamResults(user.getId()).size();
%>

    <div class="container" style="margin-bottom: 20px">
        <div class="row">
            <div class="col-sm">
                <!--学习进度-->
                <div class="card border-primary" style="height: 150px" >
                    <div class="card-body text-primary">
                        <h5 class="card-title"><%=rateAnsweredString%></h5>
                        <p class="card-text">您已探索题库中的 <%=answeredCount%>/<%=totalQuestionsCount%> 道题</p>
                        <p class="card-text"><small class="text-muted">继续加油吧！</small></p>
                    </div>
                </div>
            </div>
            <div class="col-sm">
                <div class="card border-primary"  style="height: 150px">
                    <div class="card-body text-primary">
                        <h5 class="card-title"><%=rateString%></h5>
                        <p class="card-text">答题正确率</p>
                        <p class="card-text"><small class="text-muted"><%=advice%></small></p>
                    </div>
                </div>
            </div>
            <div class="col-sm">
                <div class="card border-primary"  style="height: 150px">
                    <div class="card-body text-primary">
                        <h5 class="card-title"><%=examCount%></h5>
                        <p class="card-text">模拟考试次数</p>
                        <p class="card-text"><small class="text-muted">更多的考试=更大的机会，别放弃！</small></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container" style="margin-bottom: 5px">
        <div class="row">
            <div class="col-sm">
                <div class="card" style="width: 18rem;  height: 170px">
                    <%--            <img src="..." class="card-img-top" alt="...">--%>
                    <div class="card-body">
                        <h5 class="card-title">更改密码</h5>
                        <p class="card-text">修改您的用户密码</p>
                        <a href="#" class="btn btn-primary" disabled>点了也没用</a>
                    </div>
                </div>
            </div>
            <div class="col-sm">
                <div class="card" style="width: 18rem; height: 170px">
                    <%--            <img src="..." class="card-img-top" alt="...">--%>
                    <div class="card-body">
                        <h5 class="card-title">更改用户名</h5>
                        <p class="card-text">修改您的用户名</p>
                        <a href="#" class="btn btn-primary" disabled>还没做完</a>
                    </div>
                </div>
            </div>
            <div class="col-sm">
                <div class="card" style="width: 18rem;  height: 170px">
                    <%--            <img src="..." class="card-img-top" alt="...">--%>
                    <div class="card-body">
                        <h5 class="card-title">登出</h5>
                        <p class="card-text">从当前系统中安全登出</p>
                        <a href="<c:url value="/logout.jsp"/>" class="btn btn-primary">安全登出</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <c:if test="${requestScope.user.admin}">
    <div class="container" style="margin-bottom: 5px">
        <div class="row">
            <div class="col-sm">
                <div class="card" style="width: 18rem; height: 170px">
                        <%--            <img src="..." class="card-img-top" alt="...">--%>
                    <div class="card-body">
                        <h5 class="card-title">管理题库（管理员）</h5>
                        <p class="card-text">添加、删除或编辑本站题库题目</p>
                        <a href="<c:url value="/modules/question-management/manageQuestion.jsp"/>"
                           class="btn btn-primary">打开题库管理器</a>
                    </div>
                </div>
            </div>
            <div class="col-sm">
                <div class="card" style="width: 18rem; height: 170px">
                        <%--            <img src="..." class="card-img-top" alt="...">--%>
                    <div class="card-body">
                        <h5 class="card-title">管理课程（管理员）</h5>
                        <p class="card-text">添加、删除或编辑本站课程库课程</p>
                        <a href="<c:url value="/modules/lession-study/manageStudy.jsp"/>" class="btn btn-primary">打开课程管理器</a>
                    </div>
                </div>
            </div>
            <div class="col-sm">
                <div class="card" style="width: 18rem; height: 170px">
                        <%--            <img src="..." class="card-img-top" alt="...">--%>
                    <div class="card-body">
                        <h5 class="card-title">占位符（管理员）</h5>
                        <p class="card-text">我也不知道这里可以放点什么</p>
                        <a href="#" class="btn btn-primary" disabled>只有管理员能看到的世界~</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</c:if>

<hr>

<footer>
    <blockquote class="blockquote mb-0 card-body">
        <p id="hitokoto_text">Loading...</p>
        <footer class="blockquote-footer">
            <small class="text-muted" id="hitokoto_source"></small>
        </footer>
    </blockquote>
</footer>
<script defer>
    fetch('https://v1.hitokoto.cn')
        .then(response => response.json())
        .then(data => {
            const hitokoto = document.querySelector('#hitokoto_text')
            hitokoto.href = `https://hitokoto.cn/?c=d&c=k&uuid=${data.uuid}`
            hitokoto.innerText = data.hitokoto
            const hitokotoSource = document.querySelector('#hitokoto_source')
            hitokotoSource.innerText = data.from
        })
        .catch(console.error)
</script>

</body>
</html>
