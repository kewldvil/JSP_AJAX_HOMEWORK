package controller.student;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import controller.ActionForward;
import controller.IAction;
import model.dao.StudentDao;
import model.dto.StudentDto;

public class UpdateStatus implements IAction {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String id = request.getParameter("id");
		System.out.println(new StudentDao().updateStudent(id));
//		ArrayList<StudentDto> studentList= new StudentDao().listStudent();
//		response.setContentType("application/json");
//		response.setCharacterEncoding("UTF-8");
//		String listStudent= new Gson().toJson(studentList);
//					
//		request.setAttribute("listStudent", listStudent);
//		response.getWriter().write(listStudent);
		
	//	System.out.println(listStudent);
		return null;
	}

}
