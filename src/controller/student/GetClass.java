package controller.student;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import controller.ActionForward;
import controller.IAction;
import model.dao.StudentDao;

public class GetClass implements IAction{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ArrayList<String> className= new StudentDao().getAllClassName();
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		String allClassName= new Gson().toJson(className);
					
//		request.setAttribute("listStudent", listStudent);
		response.getWriter().write(allClassName);
		System.out.println(className);
		System.out.println(allClassName);
		return null;
	}

}
