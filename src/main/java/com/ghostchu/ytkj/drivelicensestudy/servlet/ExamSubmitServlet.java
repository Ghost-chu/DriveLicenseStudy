package com.ghostchu.ytkj.drivelicensestudy.servlet;

import com.ghostchu.ytkj.drivelicensestudy.bean.*;
import com.ghostchu.ytkj.drivelicensestudy.dao.BadAnswerDao;
import com.ghostchu.ytkj.drivelicensestudy.dao.ExamDetailDao;
import com.ghostchu.ytkj.drivelicensestudy.dao.ExamResultDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "examSubmitServlet", value = "/exam-submit-servlet")
public class ExamSubmitServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User user = (User) req.getSession().getAttribute("user");
        ExamResultDao examResultDao = new ExamResultDao();
        ExamDetailDao examDetailDao = new ExamDetailDao();
        BadAnswerDao badAnswerDao = new BadAnswerDao();
        Category category = (Category) req.getSession().getAttribute("examCategory");
        List<Question> questionList = (List<Question>) req.getSession().getAttribute("examQuestions");
        Map<Question, Boolean> questionResult = new LinkedHashMap<>();
        Map<Long, String[]> questionCallback = new LinkedHashMap<>();
        Map<Long, String[]> questionReference = new LinkedHashMap<>();
        for (Question question : questionList) {
            String[] submitted = req.getParameterValues(String.valueOf(question.getId()));
            String[] reference = question.generateCorrectOptions();
            if (submitted == null) {
                submitted = new String[0];
            }
            if (reference == null) {
                reference = new String[0];
            }
            boolean answerCorrect = Arrays.equals(submitted, reference);
            Arrays.sort(submitted);
            Arrays.sort(reference);
            questionResult.put(question, answerCorrect);
            questionCallback.put(question.getId(), submitted);
            questionReference.put(question.getId(), reference);
            if (!answerCorrect) {
                badAnswerDao.insertBadAnswer(new BadAnswer(-1, user.getId(), question.getId(), String.join(";", submitted)));
            } else {
                badAnswerDao.deleteBadAnswer(user.getId(), question.getId());
            }
        }
        double score = questionResult.values().stream().mapToInt(b -> b ? 1 : 0).sum() * category.getScorePerQuestion();
        int correctCount = questionResult.values().stream().mapToInt(b -> b ? 1 : 0).sum();
        long examId = examResultDao.insertExamResult(new ExamResult(-1,
                user.getId(),
                category.getCategoryName(),
                questionResult.size(),
                correctCount,
                score
        ));
        for (Question question : questionList) {
            String[] submitted = req.getParameterValues(String.valueOf(question.getId()));
            if (submitted == null) {
                submitted = new String[0];
            }
            examDetailDao.insertExamResult(new ExamDetail(-1, user.getId(), examId,
                    question.getId(),
                    String.join(";", submitted)));
        }

        req.getSession().setAttribute("examResult", questionResult);
        req.getSession().setAttribute("examCallback", questionCallback);
        req.getSession().setAttribute("examReference", questionReference);
        req.getSession().setAttribute("examStatus", score >= 90.0d);
        req.getSession().setAttribute("examScore", score);
        req.getSession().setAttribute("examId", examId);
        resp.sendRedirect("/modules/exam/examResult.jsp");
    }
}
