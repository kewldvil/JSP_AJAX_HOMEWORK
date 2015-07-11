package controller.student;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import controller.ActionForward;
import controller.IAction;
import model.dao.StudentDao;
import model.dto.StudentDto;

public class ListStudent implements IAction {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String name = request.getParameter("name");
		String classes =request.getParameter("classes");
		String status = request.getParameter("status");
		ArrayList<StudentDto> studentList= new StudentDao().listStudent(name,classes,status);
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
//		String listStudent= new Gson().toJson(studentList);
					
		request.setAttribute("listStudent", studentList);
//		response.getWriter().write(listStudent);
		System.out.println(name);
		System.out.println(studentList);
		
		
		
		return null;
	}

}
