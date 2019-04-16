package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BookDao;
import model.GenreDao;
import model.PublisherDao;
import model.User;

/**
 * Servlet implementation class AdminServlet
 */
@WebServlet(urlPatterns = { "/AdminServlet", "/AdminBook" })
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BookDao bd = new BookDao();
	private GenreDao gd = new GenreDao();
	private PublisherDao pd = new PublisherDao();
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User u = (User) request.getSession().getAttribute("User");
		if (u != null && u.isAdmin()) {
			System.out.println("isAdmin");
			String action = request.getParameter("action");
			System.out.println(action);
			if (action != null && action.equals("createGenre")) {
				if (gd.create(request.getParameter("genreName")) == null) {
					request.setAttribute("message", "Genre Was Not Created");
				}
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/AdminGenre.jsp");
				requestDispatcher.forward(request, response);
			} else if (action !=null && action.equals("viewPubAddress")) {
				request.setAttribute("pubAddresses", pd.loadPublisherAddresses(Integer.parseInt(request.getParameter("pubId"))));
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/PublisherAddress.jsp");
				requestDispatcher.forward(request, response);

			}
			
			else if (action != null && action.equals("updateGenre")) {
				int rowsUpdated = gd.update(request.getParameter("genreName"));
				if (rowsUpdated < 1) {
					request.setAttribute("updateMessage", "Genre failed to update");
				}
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/AdminGenre.jsp");
				requestDispatcher.forward(request, response);
			} else if (action != null && action.equals("deleteGenre")) {
				int rowsDeleted = gd.delete(request.getParameter("genreName"));
				if (rowsDeleted > 0) {
					request.setAttribute("message", "genre has been deleted");
				} else {
					request.setAttribute("message", "failed to delete genre");
				}
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/AdminGenre.jsp");
				requestDispatcher.forward(request, response);

			} else {
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/index.jsp");
				requestDispatcher.forward(request, response);
			}
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
