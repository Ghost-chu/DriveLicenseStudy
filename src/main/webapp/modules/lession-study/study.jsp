<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.StudyDao" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.Study" %><%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2023/12/2
  Time: 14:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>课程学习 - 课程页</title>
    <jsp:include page="/bootstrap.jsp"/>
    <%
        long id = Long.parseLong(request.getParameter("id"));
        StudyDao dao = new StudyDao();
        Study study = dao.getStudyById(id).orElseThrow();

    %>
</head>
<body>
<jsp:include page="/common/navbar.jsp"/>
<div class="container-md">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">首页</li>
            <li class="breadcrumb-item">课程学习</li>
            <li class="breadcrumb-item"><%=study.getCategory()%></li>
            <li class="breadcrumb-item active" aria-current="page"><%=study.getTitle()%>
            </li>
        </ol>
    </nav>
    <div class="container-md" id="description">
        <%=study.getDescription()%>
    </div>
    <%--suppress JspAbsolutePathInspection --%>
    <iframe src="//player.bilibili.com/player.html?bvid=<%=study.getBvnumber()%>&cid=339262048&page=1&high_quality=1&danmaku=0"
            allowfullscreen="allowfullscreen" width="100%" height="500" scrolling="no" frameborder="0"
            sandbox="allow-top-navigation allow-same-origin allow-forms allow-scripts"></iframe>

</div>
</body>
</html>
