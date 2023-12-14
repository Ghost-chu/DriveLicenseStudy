package com.ghostchu.ytkj.drivelicensestudy.servlet;

import com.ghostchu.ytkj.drivelicensestudy.bean.User;
import com.ghostchu.ytkj.drivelicensestudy.dao.UserDao;
import com.ghostchu.ytkj.drivelicensestudy.util.DataWrapper;
import com.ghostchu.ytkj.drivelicensestudy.util.ServletHelper;
import com.google.common.hash.Hashing;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.Optional;

@WebServlet(name = "loginServletAjax", value = "/login-servlet-ajax")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletHelper.responseJson(resp, new DataWrapper("此接口不支持 GET 请求方法", null, null));
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username = req.getParameter("username");
        String passwordHash = Hashing.sha512().hashString(req.getParameter("password"), StandardCharsets.UTF_8).toString();
        UserDao userDao = new UserDao();
        Optional<User> user = userDao.getUserByUsername(username);
        if (user.isEmpty()) {
            ServletHelper.responseJson(resp, new DataWrapper("用户不存在，请核对后再试", null, null));
            return;
        }
        User u = user.get();
        String hash = u.getPasswordHash();
        if (!passwordHash.equals(hash)) {
            ServletHelper.responseJson(resp, new DataWrapper("用户名或密码错误", null, null));
            return;
        }
        req.getSession().setAttribute("user", u);
        ServletHelper.responseJson(resp, new DataWrapper("登陆成功！\n即将返回首页……", "/", Map.of("id", u.getId(), "username", u.getUsername(), "email", u.getEmail())));
    }
}
