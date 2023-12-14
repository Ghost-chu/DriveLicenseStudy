package com.ghostchu.ytkj.drivelicensestudy.dao;

import com.ghostchu.ytkj.drivelicensestudy.bean.ExamResult;
import com.ghostchu.ytkj.drivelicensestudy.util.C3P0;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Connection;
import java.util.Collections;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ExamResultDao {
    private static final Logger LOGGER = Logger.getLogger("ExamResultDao");
    public List<ExamResult> getExamResults() {
        String sql = "SELECT * FROM exam_result ORDER BY id DESC";
        try (Connection conn = C3P0.getCon()){
            return new QueryRunner().query(conn, sql, new BeanListHandler<>(ExamResult.class));
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getExamResults", e);
        }
        return Collections.emptyList();
    }

    public List<ExamResult> getExamResults(long userId) {
        String sql = "SELECT * FROM exam_result WHERE userId = ? ORDER BY id DESC";
        try (Connection conn = C3P0.getCon()){
            return new QueryRunner().query(conn, sql, new BeanListHandler<>(ExamResult.class), userId);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getExamResults (userId)", e);
        }
        return Collections.emptyList();
    }

    public double getUserExamCorrectRate(long userId){
        String sql = "SELECT SUM(correctNumber) FROM exam_result WHERE userId =?";
        String sql2 = "SELECT SUM(totalNumber) FROM exam_result WHERE userId =?";
        try (Connection conn = C3P0.getCon()){
            long correctNumber = ((BigDecimal)new QueryRunner().query(conn, sql, new ScalarHandler<>(), userId)).longValue();
            long totalNumber =  ((BigDecimal)new QueryRunner().query(conn, sql2, new ScalarHandler<>(), userId)).longValue();
            return (double)correctNumber/totalNumber;
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getUserExamCorrectRate (userId)", e);
        }
        return -1;
    }

    public long insertExamResult(ExamResult examResult){
        String sql = "INSERT INTO exam_result (userId, category, totalNumber, correctNumber, score) VALUES (?,?,?,?,?)";
        try (Connection conn = C3P0.getCon()){
            BigInteger bi =  new QueryRunner().insert(conn, sql, new ScalarHandler<>(), examResult.getUserId(), examResult.getCategory(), examResult.getTotalNumber(), examResult.getCorrectNumber(), examResult.getScore());
            return bi.longValue();
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 插入出错：insertExamResult", e);
        }
        return -1;
    }
}
