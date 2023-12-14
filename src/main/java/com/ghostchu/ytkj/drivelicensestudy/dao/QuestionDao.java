package com.ghostchu.ytkj.drivelicensestudy.dao;

import com.ghostchu.ytkj.drivelicensestudy.bean.Category;
import com.ghostchu.ytkj.drivelicensestudy.bean.Question;
import com.ghostchu.ytkj.drivelicensestudy.util.C3P0;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.Connection;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

public class QuestionDao {

    private static final Logger LOGGER = Logger.getLogger("QuestionDao");

    /**
     * 通过ID查询课程
     *
     * @param id 课程号
     * @return 可空课程对象
     */
    public Optional<Question> getQuestionById(long id) {
        String sql = "SELECT * FROM questions WHERE id = ? LIMIT 1";
        try (Connection conn = C3P0.getCon()) {
            return Optional.ofNullable(new QueryRunner().query(conn, sql, new BeanHandler<>(Question.class), id));
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getQuestionById", e);
        }
        return Optional.empty();
    }

    public List<Question> getQuestions() {
        String sql = "SELECT * FROM questions";
        try (Connection conn = C3P0.getCon()) {
            return new QueryRunner().query(conn, sql, new BeanListHandler<>(Question.class));
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getQuestions", e);
        }
        return Collections.emptyList();
    }

    public List<Question> getRandomQuestionsInCategory(Category category) {
        String sql = "SELECT * FROM questions WHERE category = ? ORDER BY rand() LIMIT ?";
        try (Connection conn = C3P0.getCon()) {
            return new QueryRunner().query(conn, sql, new BeanListHandler<>(Question.class), category.getCategoryName(), category.getExamQuestions());
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getUserByEmail", e);
        }
        return Collections.emptyList();
    }

    public void insertQuestion(Question question) {
        String sql = "INSERT INTO questions (category, title, attachment, optionA, optionB, optionC, optionD, correct) VALUES (?,?,?,?,?,?,?,?)";
        try (Connection conn = C3P0.getCon()) {
            new QueryRunner().insert(conn, sql, new ScalarHandler<>(), question.getCategory(), question.getTitle(), question.getAttachment(), question.getOptionA(), question.getOptionB(), question.getOptionC(), question.getOptionD(), question.getCorrect());
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：insertQuestion", e);
        }
    }

    public boolean deleteQuestion(long id) {
        String sql = "DELETE FROM questions WHERE id=?";
        try (Connection conn = C3P0.getCon()) {
            return new QueryRunner().update(conn, sql, id) != 0;
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getUserByEmail", e);
        }
        return false;
    }


    public boolean updateQuestion(Question question) {
        String sql = "UPDATE questions SET category = ?, title = ?,correct = ?, optionA = ?,optionB = ?,optionC = ?,optionD = ? WHERE id = ?";
        try (Connection conn = C3P0.getCon()) {
            return new QueryRunner().update(conn, sql, question.getCategory(), question.getTitle(), question.getCorrect(), question.getOptionA(), question.getOptionB(), question.getOptionC(), question.getOptionD(), question.getId()) != 0;
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：updateStudy", e);
            return false;
        }
    }

}
