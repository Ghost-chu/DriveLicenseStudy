package com.ghostchu.ytkj.drivelicensestudy.servlet;

import com.ghostchu.ytkj.drivelicensestudy.bean.Question;
import com.ghostchu.ytkj.drivelicensestudy.dao.QuestionDao;
import com.ghostchu.ytkj.drivelicensestudy.util.ServletHelper;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "UpdateServlet", value = "/question-update-servlet")
public class UpdateQuestionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        ServletHelper.checkLoggedIn(req,resp,true);
        String category = req.getParameter("category");
        String title = req.getParameter("title");
        String correct = req.getParameter("correct");
        String optionA = req.getParameter("optionA");
        String optionB = req.getParameter("optionB");
        String optionC = req.getParameter("optionC");
        String optionD = req.getParameter("optionD");
        int id = Integer.parseInt(req.getParameter("id"));
        QuestionDao dao = new QuestionDao();
        dao.insertQuestion(new Question(
                -1,
                category,
                title,
                null,
                optionA,
                optionB,
                optionC,
                optionD,
                String.join(";", correct)
        ));

        resp.sendRedirect("/modules/question-management/insertQuestion.jsp");
        resp.sendRedirect("/modules/lession-study/editStudy.jsp");
    }
}
