package com.ghostchu.ytkj.drivelicensestudy.dao;

import com.ghostchu.ytkj.drivelicensestudy.bean.Category;
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

public class CategoryDao {
    private static final Logger LOGGER = Logger.getLogger("CategoryDao");

    public List<Category> getCategories() {
        String sql = "SELECT * FROM category ORDER BY id";
        try (Connection conn = C3P0.getCon()) {
            return new QueryRunner().query(conn, sql, new BeanListHandler<>(Category.class));
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getStudyById", e);
        }
        return Collections.emptyList();
    }

    public Optional<Category> getCategoryById(long id) {
        String sql = "SELECT * FROM category WHERE id = ? LIMIT 1";
        try (Connection conn = C3P0.getCon()) {
            return Optional.ofNullable(new QueryRunner().query(conn, sql, new BeanHandler<>(Category.class), id));
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getCategoryById", e);
        }
        return Optional.empty();
    }

    public Optional<Category> getCategoryByName(String name) {
        String sql = "SELECT * FROM category WHERE categoryName = ? LIMIT 1";
        try (Connection conn = C3P0.getCon()) {
            return Optional.ofNullable(new QueryRunner().query(conn, sql, new BeanHandler<>(Category.class), name));
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getCategoryByName", e);
        }
        return Optional.empty();
    }
}
