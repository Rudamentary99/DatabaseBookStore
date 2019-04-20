package servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Address;
import model.AddressDao;
import model.HashVal;
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

		} else if (action != null && action.equals("createUser")) {
			if (request.getParameter("password").equals(request.getParameter("confirmPassword"))) {
				HashVal hash = new HashVal();
				User u = new User(); 
				u.setEmail(request.getParameter("email"));
				u.setFirstName(request.getParameter("firstName"));
				u.setLastName(request.getParameter("lastName"));
				u.setDate_of_birth(toSqlDate(request.getParameter("DOB")));
				u.setPassword(hash.hashValue(request.getParameter("password")).toString());
				if (request.getParameter("phone") != null || request.getParameter("phone").length() > 9) {
					u.setPhone(request.getParameter("phone"));
				}
				u = ud.create(u);
				if (u != null) {
					request.setAttribute("message", "Account has been created!");
					RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/login.jsp");
					requestDispatcher.forward(request, response);
				} else {
					request.setAttribute("message", "Error making account. Please try again later");
					RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/CreateUser.jsp");
					requestDispatcher.forward(request, response);
				}
				
			} else {
				request.setAttribute("message", "Passwords do not match");
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/CreateUser.jsp");
				requestDispatcher.forward(request, response);
			}
		} else if (action != null && action.equals("newPassword")) {
			User u = (User) request.getSession().getAttribute("User");

			if (request.getParameter("newPass").equals(request.getParameter("confirmPass"))) {
				if (ud.updatePassword(u.getUserID(), request.getParameter("currentPass"),
						request.getParameter("newPass"))) {
					RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/user.jsp");
					requestDispatcher.forward(request, response);
				} else {
					request.setAttribute("message", "Incorrect current password");
					RequestDispatcher requestDispatcher = getServletContext()
							.getRequestDispatcher("/jsp/NewPassword.jsp");
					requestDispatcher.forward(request, response);
				}
			} else {
				request.setAttribute("message", "New password and confirm new password did not match");
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/NewPassword.jsp");
				requestDispatcher.forward(request, response);
			}
		} else if (action != null && action.equals("saveInfo")) {
			User cU = (User) request.getAttribute("User");
			User u = new User();
			u.setUserID(cU.getUserID());
			u.setFirstName(request.getParameter("fName"));
			u.setLastName(request.getParameter("lName"));
			u.setEmail(request.getParameter("email"));
			u.setPhone("phone");
			ud.update(u);
		} else if (action != null && action.equals("login")) {
			HashVal hash = new HashVal();
			System.out.println("User attempting login");
			User u = new User();
			String message;
			String style;
			u = ud.loginUser(request.getParameter("inputEmail"), hash.hashValue(request.getParameter("inputPassword")).toString());
			if (u != null) {
				style = "color:green";
				message = "Enjoy Shopping, " + u.getFirstName() + " " + u.getLastName();
				request.getSession().setAttribute("User", u);
				System.out.println("login sucess");
				request.setAttribute("message", message);
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/index.jsp");
				requestDispatcher.forward(request, response);
			} else {
				System.out.println("login failure");
				style = "color:red";
				message = "wrong Username or Password";
				request.setAttribute("message", message);
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/login.jsp");
				requestDispatcher.forward(request, response);
			}
			request.setAttribute("style", style);

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
	
	public java.sql.Date toSqlDate(String htmlDate) {
		String date = htmlDate;
		date.replace("[", "");
		date.replace("]", "");

		SimpleDateFormat df = new SimpleDateFormat("yyyy-dd-mm");
		Date jDate;
		try {
			jDate = df.parse(date);
			return new java.sql.Date(jDate.getTime());

		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

}
