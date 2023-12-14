package com.ghostchu.ytkj.drivelicensestudy.dao;

import com.ghostchu.ytkj.drivelicensestudy.bean.ExamDetail;
import com.ghostchu.ytkj.drivelicensestudy.util.C3P0;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.sql.Connection;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ExamDetailDao {
    private static final Logger LOGGER = Logger.getLogger("ExamDetailDao");
    public List<ExamDetail> getExamDetails(long examId) {
        String sql = "SELECT * FROM exam_detail WHERE examId = ? ORDER BY id ";
        try (Connection conn = C3P0.getCon()){
            return new QueryRunner().query(conn, sql, new BeanListHandler<>(ExamDetail.class), examId);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getExamDetails", e);
        }
        return Collections.emptyList();
    }

    public long getUserAnsweredUniqueQuestionsCount(long userId){
        String sql = "SELECT COUNT(DISTINCT questionId) FROM exam_detail WHERE userId = ?";
        try (Connection conn = C3P0.getCon()){
           return new QueryRunner().query(conn, sql, new ScalarHandler<>(), userId);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getUserAnsweredUniqueQuestionsCount (userId)", e);
        }
        return -1;
    }

    public boolean insertExamResult(ExamDetail examDetail){
        String sql = "INSERT INTO exam_detail (userId, examId, questionId, myAnswer) VALUES (?,?,?,?)";
        try (Connection conn = C3P0.getCon()){
            return new QueryRunner().update(conn, sql, examDetail.getUserId(), examDetail.getExamId(),examDetail.getQuestionId(), examDetail.getMyAnswer()) > 0;
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 插入出错：insertExamResult", e);
        }
        return false;
    }
}
