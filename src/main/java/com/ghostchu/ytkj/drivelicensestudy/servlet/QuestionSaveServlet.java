package com.ghostchu.ytkj.drivelicensestudy.servlet;

import com.ghostchu.ytkj.drivelicensestudy.bean.Question;
import com.ghostchu.ytkj.drivelicensestudy.dao.QuestionDao;
import com.ghostchu.ytkj.drivelicensestudy.util.ServletHelper;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;

@WebServlet(name = "questionSaveServlet", value = "/question-save-servlet")
public class QuestionSaveServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        ServletHelper.checkLoggedIn(req,resp,true);
        String category = req.getParameter("category");
        String title = req.getParameter("title");
        String answerA = req.getParameter("answerA");
        String answerB = req.getParameter("answerB");
        String answerC = req.getParameter("answerC");
        String answerD = req.getParameter("answerD");
        String[] correctAnswer = req.getParameterValues("correctAnswer");

        System.out.println("category: "+category);
        System.out.println("title: "+title);
        System.out.println("answerA: "+answerA);
        System.out.println("answerB: "+answerB);
        System.out.println("answerC: "+answerC);
        System.out.println("answerD: "+answerD);
        System.out.println("correctAnswer: "+ Arrays.toString(correctAnswer));

        QuestionDao dao = new QuestionDao();
        dao.insertQuestion(new Question(
                -1,
                category,
                title,
                null,
                answerA,
                answerB,
                answerC,
                answerD,
                String.join(";", correctAnswer)
        ));

        resp.sendRedirect("/modules/question-management/insertQuestion.jsp");
    }
}
