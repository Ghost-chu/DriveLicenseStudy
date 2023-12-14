package com.ghostchu.ytkj.drivelicensestudy.servlet;

import com.ghostchu.ytkj.drivelicensestudy.dao.QuestionDao;
import com.ghostchu.ytkj.drivelicensestudy.util.DataWrapper;
import com.ghostchu.ytkj.drivelicensestudy.util.ServletHelper;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "questionDeleteServlet", value = "/question-delete-servlet")
public class QuestionDeleteServlet extends HttpServlet {
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        ServletHelper.checkLoggedIn(req,resp,true);
        QuestionDao dao = new QuestionDao();
        if(dao.deleteQuestion(Long.parseLong(req.getParameter("id")))){
            ServletHelper.responseJson(resp, new DataWrapper("删除成功", null, null));
        }else{
            ServletHelper.responseJson(resp, new DataWrapper("删除失败，系统内部错误", null, null));
        }
    }
}
