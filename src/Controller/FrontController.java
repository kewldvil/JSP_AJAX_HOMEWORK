package Controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("*.jsp")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FrontController() {
		super();
	}

	public void doPost( HttpServletRequest request,HttpServletResponse respone) {
		doProcess( request,respone);
	}

	public void doGet( HttpServletRequest request,HttpServletResponse respone) {
		doProcess(request,respone);
	}

	public void doProcess( HttpServletRequest request, HttpServletResponse response) {
		String RequestURI = request.getRequestURI();

		System.out.println(RequestURI);
		String contextPath = request.getContextPath();
		System.out.println(contextPath);
		String command = RequestURI.substring(contextPath.length());
		ActionForward forward = null;
		IAction action = null;

		System.out.println(command);
		switch(command){
		case "index.jsp":
			System.out.println("fdsdfs");
			break;
		default:
			break;
		}
		if (forward != null) {
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dispatcher = request
						.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request,respone );
			}

		}
	}
}
