<%@ page import="com.ghostchu.ytkj.drivelicensestudy.bean.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ghostchu.ytkj.drivelicensestudy.dao.CategoryDao" %>
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
<!DOCTYPE html>
<html>
<head>
    <title>修改课程</title>
    <script src="<c:url value="/bootstrap/js/jquery.js"/>"></script>
    <jsp:include page="/bootstrap.jsp"/>
    <script src='<c:url value="/js/tinymce/tinymce.min.js"/>'></script>
    <script>
        tinymce.init({
            selector: '#description',
            //skin:'oxide-dark',
            language:'zh_CN',
            plugins: 'print preview searchreplace autolink directionality visualblocks visualchars fullscreen image link media template code codesample table charmap hr pagebreak nonbreaking anchor insertdatetime advlist lists wordcount imagetools textpattern paste emoticons autosave bdmap indent2em autoresize lineheight',
            toolbar: 'code undo redo | forecolor backcolor bold italic underline strikethrough link anchor | alignleft aligncenter alignright indent2em lineheight | \
                    formatselect fontselect fontsizeselect | bullist numlist | blockquote subscript superscript removeformat | \
                    table image media bdmap emoticons charmap hr pagebreak insertdatetime | fullscreen ',
            height: 450, //编辑器高度
            min_height: 300,
            fontsize_formats: '12px 14px 16px 18px 24px 36px 48px 56px 72px',
            autosave_ask_before_unload: false,
            icons:'ax-color',

        });
    </script>
</head>
<body>
<jsp:include page="/common/navbar.jsp"/>
<%
    ServletHelper.checkLoggedIn(request,response,true);
    CategoryDao dao = new CategoryDao();
    List<String> selectiveCategories = dao.getCategories().stream().map(Category::getCategoryName).toList();
    request.setAttribute("categories", selectiveCategories);
    StudyDao edit = new StudyDao();
    Study study = edit.getStudyById(Long.parseLong(request.getParameter("id"))).orElseThrow();
    String studyCategoryName = study.getCategory();
    int pos = 0;

    for (int i = 0; i < selectiveCategories.size(); i++) {
        if (selectiveCategories.get(i).equals(studyCategoryName)) {
            pos = i;
            break;
        }
    }

    String studyTitle = study.getTitle();
    String bvNumber = study.getBvnumber();
    String studyDescription = study.getDescription();
%>
<div class="container-md">
    <h1>修改课程</h1>

    <form action="<c:url value="/study-update-servlet"/>" method="post">
        <div class="form-group">
            <input type="text" hidden="hidden" style="display: none" name="id" value="<%=request.getParameter("id")%>"/>
        </div>
        <div class="form-group">
            <label for="category">课程分类</label>
            <small id="categoryHelp" class="form-text text-muted">选择课程分类类型</small>
            <select id="category" name="category" class="form-control" aria-describedby="categoryHelp">
                <c:forEach items="${requestScope.categories}" var="categoryName">
                    <option value="${categoryName}">${categoryName}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label for="title">标题</label>
            <textarea rows="5" class="form-control" id="title" name="title"></textarea>
        </div>
        <div class="form-group">
            <label for="description">描述</label>
            <textarea rows="10" class="form-control" id="description" name="description"></textarea>
        </div>
        <div class="form-group">
            <label for="bvnumber">BV号</label>
            <input type="text" class="form-control" id="bvnumber" name="bvnumber">
        </div>
        <button id="submitBtn" type="submit" class="btn btn-primary">确认无误，保存到数据库</button>
    </form>
</div>
</body>

<script>
    const categoryElement = document.getElementById("category");
    categoryElement.selectedIndex = <%=pos%>;
    const titleElement = document.getElementById("title");
    titleElement.value = "<%=studyTitle%>";
    const descElement = document.getElementById("description");
    descElement.value = "<%=studyDescription%>";
    const bvnumberElement = document.getElementById("bvnumber");
    bvnumberElement.value = "<%=bvNumber%>";
</script>
</html>
