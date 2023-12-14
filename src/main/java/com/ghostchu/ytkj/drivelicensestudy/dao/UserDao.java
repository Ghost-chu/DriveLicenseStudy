package com.ghostchu.ytkj.drivelicensestudy.dao;

import com.ghostchu.ytkj.drivelicensestudy.bean.User;
import com.ghostchu.ytkj.drivelicensestudy.util.C3P0;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDao {
    private static final Logger LOGGER = Logger.getLogger("UserDao");


    /**
     * 通过邮箱获取用户对象
     *
     * @param email 邮箱地址
     * @return 用户对象，可能为null
     * @throws SQLException
     */
    public Optional<User> getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ? LIMIT 1";
        try (PreparedStatement ps = C3P0.getCon().prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet set = ps.executeQuery();
            if (set.next()) {
                return Optional.ofNullable(new User(set.getLong("id"), set.getString("email"), set.getString("username"), set.getString("passwordHash"), set.getInt("admin")));
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getUserByEmail", e);
        }
        return Optional.empty();
    }
    /**
     * 通过邮箱获取用户对象
     *
     * @param email 邮箱地址
     * @return 用户对象，可能为null
     * @throws SQLException
     */
    public Optional<User> getUserById(long id) {
        String sql = "SELECT * FROM users WHERE id = ? LIMIT 1";
        try (PreparedStatement ps = C3P0.getCon().prepareStatement(sql)) {
            ps.setLong(1, id);
            ResultSet set = ps.executeQuery();
            if (set.next()) {
                return Optional.ofNullable(new User(set.getLong("id"), set.getString("email"), set.getString("username"), set.getString("passwordHash"), set.getInt("admin")));
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getUserById", e);
        }
        return Optional.empty();
    }


    /**
     * 通过用户名获取用户对象
     *
     * @param username 用户名
     * @return 用户对象
     */
    public Optional<User> getUserByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ? LIMIT 1";
        try (PreparedStatement ps = C3P0.getCon().prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet set = ps.executeQuery();
            if (set.next()) {
                return Optional.ofNullable(new User(set.getLong("id"), set.getString("email"), set.getString("username"), set.getString("passwordHash"), set.getInt("admin")));
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：getUserByEmail", e);
        }
        return Optional.empty();
    }

    //添加
    public long insertUser(User user) {
        String sql = "INSERT INTO users (email, username, passwordHash, admin) VALUES (?,?,?,?)";
        try (PreparedStatement ps = C3P0.getCon().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getPasswordHash());
            ps.setInt(4, user.isAdmin() ? 1 : 0);
            ps.execute();
            return ps.getGeneratedKeys().getLong(1);
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：saveUser", e);
            return -1;
        }


    }

    //删除
    public boolean delUser(int id) {
        String sql = "delete from users where id=?";
        try (PreparedStatement ps = C3P0.getCon().prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.execute();
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：saveUser", e);
            return false;
        }
    }

    //修改
    public boolean modifyUser(User user) {
        String sql = "update users set email=?,username=? where id=?";
        try (PreparedStatement ps = C3P0.getCon().prepareStatement(sql)) {
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getPasswordHash());
            return ps.execute();
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "SQL 查询出错：saveUser", e);
            return false;
        }
    }
}