package com.ghostchu.ytkj.drivelicensestudy.dao;

import com.ghostchu.ytkj.drivelicensestudy.bean.BadAnswer;
import com.ghostchu.ytkj.drivelicensestudy.util.C3P0;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import java.sql.Connection;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BadAnswerDao {
    private static final Logger LOGGER = Logger.getLogger("BadAnswerDao");

    public List<BadAnswer> getBadAnswers(long userId){
        String sql = "SELECT * FROM badanswers ORDER BY id";
        try (Connection conn = C3P0.getCon()) {
            return new QueryRunner().query(conn, sql, new BeanListHandler<>(BadAnswer.class));
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getBadAnswers", e);
        }
        return Collections.emptyList();
    }

    public Optional<BadAnswer> getBadAnswer(long answerId){
        String sql = "SELECT * FROM badanswers ORDER BY id";
        try (Connection conn = C3P0.getCon()) {
            return Optional.ofNullable(new QueryRunner().query(conn, sql, new BeanHandler<>(BadAnswer.class)));
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getBadAnswer", e);
        }
        return Optional.empty();
    }


    public boolean insertBadAnswer(BadAnswer badAnswer){
        String sql = "INSERT INTO badanswers (userId, questionId, myAnswer) VALUES (?,?,?) ON DUPLICATE KEY UPDATE myAnswer = ?";
        try (Connection conn = C3P0.getCon()) {
            new QueryRunner().update(conn, sql, badAnswer.getUserId(), badAnswer.getQuestionId(), badAnswer.getMyAnswer(), badAnswer.getMyAnswer());
            return true;
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 插入出错：insertBadAnswer", e);
        }
        return false;
    }

    public boolean deleteBadAnswer(long answerId){
        String sql = "DELETE FROM badanswers WHERE id =?";
        try (Connection conn = C3P0.getCon()) {
            new QueryRunner().update(conn, sql, answerId);
            return true;
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 删除出错：deleteBadAnswer", e);
        }
        return false;
    }

    public boolean deleteBadAnswer(long userId, long questionId){
        String sql = "DELETE FROM badanswers WHERE userId =? AND questionId =?";
        try (Connection conn = C3P0.getCon()) {
            new QueryRunner().update(conn, sql, userId, questionId);
            return true;
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 删除出错：deleteBadAnswer", e);
        }
        return false;
    }
}
