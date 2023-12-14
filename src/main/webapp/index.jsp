<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>烟科学车 - 驾驶员学习平台</title>
    <jsp:include page="/bootstrap.jsp"/>
</head>
<body>
<jsp:include page="/common/navbar.jsp"/>
<div class="jumbotron">
    <h1>烟科学车</h1>
    <p class="lead">你的学车好帮手，但更多的是为了完成 Java 课设作业！</p>
    <hr class="my-4">
    <p>本站的学习内容均来自于互联网，版权由其原作者保留，本项目仅用于学习性质使用，禁止商业盈利。</p>
    <p>请使用 1080P 或以上分辨率访问本站，本站未对手机版进行适配。推荐与设计分辨率为 2560px*1660px</p>
    <a class="btn btn-primary btn-lg" href="<c:url value="/modules/lession-study/welcome-study.jsp"/>" role="button">开始学习！</a>
</div>
<div class="container">
    <div class="row mb-5 pb-md-4 align-items-center">
        <div class="col-md-5">
            <h2>值得信赖</h2>
            <p class="lead font-weight-normal">
                由刚刚考过科目一的两位专业人士编写，祝您考试不翻车
            </p>
            <p>
                大家用了都说好！
            </p>
            <a href="<c:url value="/modules/lession-study/welcome-study.jsp"/>"
               class="btn btn-lg btn-outline-primary mb-3">试试看！</a>
        </div>
        <div class="col-md-7 pl-md-5">
            <img height="425" src="<c:url value="/image/home-02.jpg"/>"/>
        </div>
    </div>
    <div class="row mb-5 pb-md-4 align-items-center">
        <div class="col-md-5">
            <h2>充满BUG</h2>
            <p class="lead font-weight-normal">
                交作业的前一秒都在不断修改的项目，让您体验 500 报错的快乐。
            </p>
            <p>
                人和代码有一个能跑的就行！祖传的代码别乱删！好不好看的不重要，能跑就行！你交个作业又不是上线生产！
            </p>
            <a href="<c:url value="/modules/lession-study/lession-study-index.jsp?category=crashcrashgogogo"/>"
               class="btn btn-lg btn-outline-primary mb-3">一键 500</a>
        </div>
        <div class="col-md-7 pl-md-5">
            <img width="800" src="<c:url value="/image/home-01.jpg" />"/>
        </div>
    </div>
    <div class="row mb-5 pb-md-4 align-items-center">
        <div class="col-md-5">
            <h2>随来随走</h2>
            <p class="lead font-weight-normal">
                想学就学，不想学一键熄火
            </p>
            <p>
                反正没打算让你真的用（
            </p>
            <a href="javascript:closePage();"
               class="btn btn-lg btn-outline-primary mb-3">马上跑路！</a>
        </div>
        <div class="col-md-7 pl-md-5">
            <img width="800" src="<c:url value="/image/home-03.jpg"/>"/>
        </div>
    </div>
    <hr>
    <center><i>编不下去了</i></center>
</div>
</body>
<script>

    function closePage(){
        if(navigator.userAgent.indexOf("Firefox") != -1 || navigator.userAgent.indexOf("Chrome") != -1){
            window.location.href = "about:blank";
            window.close();
        }else{
            window.opener = null;
            window.open("", "_self");
            window.close();
        }
    }
</script>
</html>