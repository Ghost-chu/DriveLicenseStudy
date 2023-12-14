package com.ghostchu.ytkj.drivelicensestudy.servlet;

import com.ghostchu.ytkj.drivelicensestudy.bean.User;
import com.ghostchu.ytkj.drivelicensestudy.dao.UserDao;
import com.ghostchu.ytkj.drivelicensestudy.util.DataWrapper;
import com.ghostchu.ytkj.drivelicensestudy.util.ServletHelper;
import com.google.common.hash.Hashing;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.Optional;

@WebServlet(name = "registerServletAjax", value = "/register-servlet-ajax")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        ServletHelper.responseJson(resp, new DataWrapper("此接口不支持 GET 请求方法", null, null));
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String email = req.getParameter("email").trim();
        String username = req.getParameter("username").trim();
        String passwordHash = Hashing.sha512().hashString(req.getParameter("password"), StandardCharsets.UTF_8).toString();
        UserDao userDao = new UserDao();
        Optional<User> user = userDao.getUserByUsername(username);
        if (user.isPresent()) {
            ServletHelper.responseJson(resp, new DataWrapper("此用户名已被使用，换一个用户名吧！", null, null));
            return;
        }
        user = userDao.getUserByEmail(email);
        if (user.isPresent()) {
            ServletHelper.responseJson(resp, new DataWrapper("此邮件地址已被使用，忘记密码了吗？", null, null));
            return;
        }

        long id = userDao.insertUser(new User(-1, email, username, passwordHash, 0));
        if (id == -1) {
            ServletHelper.responseJson(resp, new DataWrapper("注册失败，SQL 执行返回未成功", null, null));
            return;
        }
        User u = userDao.getUserById(id).orElseThrow();
        req.getSession().setAttribute("user", u);
        ServletHelper.responseJson(resp, new DataWrapper("注册成功！您已自动登录！\n即将返回首页……", "/", Map.of("id", u.getId(), "username", u.getUsername(), "email", u.getEmail())));
    }
}
