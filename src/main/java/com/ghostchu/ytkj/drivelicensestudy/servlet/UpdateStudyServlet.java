package com.ghostchu.ytkj.drivelicensestudy.servlet;

import com.ghostchu.ytkj.drivelicensestudy.bean.Study;
import com.ghostchu.ytkj.drivelicensestudy.dao.StudyDao;
import com.ghostchu.ytkj.drivelicensestudy.util.ServletHelper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "StudyUpdateServlet", value = "/study-update-servlet")
public class UpdateStudyServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ServletHelper.checkLoggedIn(req,resp,true);
        String category = req.getParameter("category").trim();
        String title = req.getParameter("title").trim();
        String description = req.getParameter("description").trim();
        String bvNumber = req.getParameter("bvnumber").trim();
        int id = Integer.parseInt(req.getParameter("id"));
        StudyDao study = new StudyDao();
        study.updateStudy(new Study(id, category, title, description, bvNumber));
        resp.sendRedirect("/modules/lession-study/manageStudy.jsp");
    }
}
