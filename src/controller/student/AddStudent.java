package controller.student;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ActionForward;
import controller.IAction;
import model.dao.StudentDao;

public class AddStudent implements IAction {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id=request.getParameter("id");
		String name=request.getParameter("name");
		int gender=Integer.parseInt(request.getParameter("gender"));
		String university=request.getParameter("university");
		String classes=request.getParameter("classes");
		System.out.println(new StudentDao().insertNewStudent(id, name,gender,university,classes,true));
		return null;
	}

}
