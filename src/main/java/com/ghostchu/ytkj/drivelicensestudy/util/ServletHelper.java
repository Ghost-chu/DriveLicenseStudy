package com.ghostchu.ytkj.drivelicensestudy.util;

import com.ghostchu.ytkj.drivelicensestudy.bean.User;
import com.google.gson.Gson;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

public class ServletHelper {
    private static final Gson GSON = new Gson();

    public static void responseJson(HttpServletResponse resp, Object object) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter writer = resp.getWriter();
        writer.print(GSON.toJson(object));
    }

    public static void checkLoggedIn(HttpServletRequest request, HttpServletResponse response, boolean adminPrivilege) throws IOException {
        Object idObj = request.getSession().getAttribute("user");
        if (idObj == null) {
            response.sendRedirect("/access-denied.jsp");
            return;
        }
        if (adminPrivilege) {
            if (!((User) idObj).isAdmin()) {
                response.sendRedirect("/access-denied.jsp");
            }
        }
    }
}
