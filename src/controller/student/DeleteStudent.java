package controller.student;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import controller.ActionForward;
import controller.IAction;
import model.dao.StudentDao;
import model.dto.StudentDto;

public class DeleteStudent implements IAction {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		System.out.println(new StudentDao().deleteStudent(id));
		return null;
	}

}
