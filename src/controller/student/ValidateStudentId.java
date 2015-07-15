package controller.student;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ActionForward;
import controller.IAction;
import model.dao.StudentDao;

public class ValidateStudentId implements IAction {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = "13N"+request.getParameter("id");
		response.getWriter().write(Boolean.toString(new StudentDao().validateStudentId(id)));
		
		System.out.println(new StudentDao().validateStudentId(id));
		return null;
	}

}
