package servlet;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.User;
import model.UserDao;

/**
 * Servlet implementation class SheetieServlet
 */
@WebServlet("/UserServlet")

public class UserServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(final HttpServletRequest request, final HttpServletResponse response)
			throws ServletException, IOException {
		UserDao ud = new UserDao();
		String action = request.getParameter("action");
		if (action != null && action.equals("editInfo")) {
			request.setAttribute("edit", "true");
			RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/user.jsp");
			requestDispatcher.forward(request, response);
			
		} else if (action !=null && action.equals("saveInfo")){
			User cU = (User) request.getAttribute("User");
			User u = new User();
			u.setUserID(cU.getUserID());
			u.setFirstName(request.getParameter("fName"));
			u.setLastName(request.getParameter("lName"));
			u.setEmail(request.getParameter("email"));
			u.setPhone("phone");
			ud.update(u);
		}else if (action != null && action.equals("login")) {
			System.out.println("User attempting login");
			User u = new User();
			String message;
			String style;
			u.setEmail(request.getParameter("inputEmail"));
			u.setPassword(request.getParameter("inputPassword"));
			u = ud.loginUser(u.getEmail(), u.getPassword());
			if (u != null) {
				style = "color:green";
				message = "Enjoy Shopping, " + u.getFirstName() + " " + u.getLastName();
				request.getSession().setAttribute("User", u);
				System.out.println("login sucess");
			} else {
				System.out.println("login failure");
				style = "color:red";
				message = "wrong Username or Password";
			}
			request.setAttribute("style", style);
			request.setAttribute("message", message);
			RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/index.jsp");
			requestDispatcher.forward(request, response);

		} else {
			RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/index.jsp");
			requestDispatcher.forward(request, response);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
