package com.ghostchu.ytkj.drivelicensestudy.dao;

import com.ghostchu.ytkj.drivelicensestudy.bean.Category;
import com.ghostchu.ytkj.drivelicensestudy.bean.Study;
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

public class StudyDao {
    private static final Logger LOGGER = Logger.getLogger("StudyDao");

    /**
     * 通过ID查询课程
     *
     * @param id 课程号
     * @return 可空课程对象
     */
    public Optional<Study> getStudyById(long id) {
        String sql = "SELECT * FROM study WHERE id = ? LIMIT 1";
        try (Connection conn = C3P0.getCon()) {
            return Optional.ofNullable(new QueryRunner().query(conn, sql, new BeanHandler<>(Study.class), id));
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getStudyById", e);
        }
        return Optional.empty();
    }

    public boolean deleteStudyById(long id) {
        String sql = "DELETE FROM study WHERE id = ?";
        try (Connection conn = C3P0.getCon()) {
            return new QueryRunner().update(conn, sql, id) != 0;
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：deleteStudyById", e);
        }
        return false;
    }

    public List<Study> getStudies() {
        String sql = "SELECT * FROM study";
        try (Connection conn = C3P0.getCon()) {
            return new QueryRunner().query(conn, sql, new BeanListHandler<>(Study.class));
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getStudies", e);
            return Collections.emptyList();
        }
    }

    public List<Study> getStudiesByCategory(Category category) {
        String sql = "SELECT * FROM study WHERE category = ?";
        try (Connection conn = C3P0.getCon()) {
            return new QueryRunner().query(conn, sql, new BeanListHandler<>(Study.class), category.getCategoryName());
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getStudiesByCategory", e);
            return Collections.emptyList();
        }
    }

    public boolean insertStudy(Study study) {
        String sql = "INSERT INTO study (category, title, bvnumber, description) VALUES (?,?,?,?)";
        try (Connection conn = C3P0.getCon()) {
            return new QueryRunner().update(conn, sql, study.getCategory(), study.getTitle(), study.getBvnumber(), study.getDescription()) != 0;
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：insertStudy", e);
            return false;
        }
    }

    public boolean updateStudy(Study study) {
        String sql = "UPDATE study SET category = ?, title = ?, bvnumber = ?, description = ? WHERE id = ?";
        try (Connection conn = C3P0.getCon()) {
            return new QueryRunner().update(conn, sql, study.getCategory(), study.getTitle(), study.getBvnumber(), study.getDescription(), study.getId()) != 0;
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：updateStudy", e);
            return false;
        }
    }

}
