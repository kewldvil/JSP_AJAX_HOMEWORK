package Controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("*.pheak")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FrontController() {
		super();
	}

	public void doPost(HttpServletResponse respone, HttpServletRequest request) {
		doProcess(respone, request);
	}

	public void doGet(HttpServletResponse respone, HttpServletRequest request) {
		doProcess(respone, request);
	}

	public void doProcess(HttpServletResponse respone, HttpServletRequest request) {
		String RequestURI = request.getRequestURI();

		System.out.println(RequestURI);
		String contextPath = request.getContextPath();
		System.out.println(contextPath);
		String command = RequestURI.substring(contextPath.length());
		ActionForward forward = null;
		IAction action = null;

		System.out.println(command);
		switch (command) {
		case "/index.jsp":
			
			break;

		default:
			break;
		}
	}
}
