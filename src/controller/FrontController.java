package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.student.AddStudent;
import controller.student.DeleteStudent;
import controller.student.GetClass;
import controller.student.ValidateStudentId;
import controller.student.ListStudent;
import controller.student.UpdateStatus;
import controller.student.UpdateStudent;


@WebServlet("*.pheak")
public class FrontController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public FrontController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		doProcess(request, response);
	}

	protected void doProcess(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String requestURI = request.getRequestURI();
		System.out.println(requestURI);
		String contextPath = request.getContextPath();
		System.out.println(contextPath);
		String command = requestURI.substring(contextPath.length());
		ActionForward forward = null;
		IAction iAction = null;

		System.out.println(command);

		switch (command) {
		
		case "/index.pheak":
			iAction = new ListStudent();
			break;
		case "/validateStudentId.pheak":
			iAction = new ValidateStudentId();
			break;
		case "/insertStudent.pheak":
			iAction = new AddStudent();
			break;
		case "/updateStudent.pheak":
			iAction = new UpdateStudent();
			break;
		case "/className.pheak":
			iAction = new GetClass();
			break;	
		case "/updateStatus.pheak":
			iAction = new UpdateStatus();
			break;
		case "/deleteStudent.pheak":
			iAction = new DeleteStudent();
			break;
		default:
			forward = new ActionForward();
			forward.setPath("404.jsp");
			forward.setRedirect(false);
			break;

		}
		
		try {
			forward = iAction.execute(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if (forward != null) {
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}

		}
	}
}
