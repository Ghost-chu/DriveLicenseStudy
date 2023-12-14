package com.ghostchu.ytkj.drivelicensestudy.servlet;

import com.ghostchu.ytkj.drivelicensestudy.bean.Category;
import com.ghostchu.ytkj.drivelicensestudy.bean.Question;
import com.ghostchu.ytkj.drivelicensestudy.dao.CategoryDao;
import com.ghostchu.ytkj.drivelicensestudy.dao.QuestionDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "examSetupServlet", value = "/exam-setup-servlet")
public class ExamSetupServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        CategoryDao categoryDao = new CategoryDao();
        QuestionDao questionDao = new QuestionDao();
        String categoryParam = req.getParameter("category");
        Category category = categoryDao.getCategoryByName(categoryParam).orElseThrow();
        List<Question> questionList = questionDao.getRandomQuestionsInCategory(category);
        req.getSession().setAttribute("examQuestions", questionList);
        req.getSession().setAttribute("examCategory",category);
        resp.sendRedirect("/modules/exam/examAnswer.jsp");
    }
}
