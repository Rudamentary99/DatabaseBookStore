package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Address;
import model.AddressDao;
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
	private AddressDao ad = new AddressDao();

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
			} else if (action != null && action.equals("createPubAddress")) {
				Address a = new Address();
				a.setStreet(request.getParameter("street"));
				a.setCity(request.getParameter("city"));
				a.setState(request.getParameter("state"));
				a.setZip(request.getParameter("zip"));

				if (pd.createPublisherAddress(a, Integer.parseInt(request.getParameter("pubID")))) {
					request.setAttribute("createMessage", "Address Created");
				} else {
					request.setAttribute("createMessage", "Address Creation failed. Please try again later");
				}

				doGetPubAddress(request, response, Integer.parseInt(request.getParameter("pubID")));

			} else if (action != null && action.equals("viewPubAddresses")) {

				request.getSession().setAttribute("pubAddresses",
						pd.loadPublisherAddresses(Integer.parseInt(request.getParameter("pubID"))));
				RequestDispatcher requestDispatcher = getServletContext()
						.getRequestDispatcher("/jsp/PublisherAddress.jsp");
				requestDispatcher.forward(request, response);

			} else if (action !=null && action.equals("deletePubAddress")) {
				Address a = new Address();
				a.setAddressID(Integer.parseInt(request.getParameter("addressID")));
				if (ad.delete(a) > 0) {
					System.out.println("address Deleted");
					
				}
				
				doGetPubAddress(request, response, Integer.parseInt(request.getParameter("pubID")));
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

	private void doGetPubAddress(HttpServletRequest request, HttpServletResponse response, int pubID)
			throws ServletException, IOException {
		request.getSession().setAttribute("pubAddresses", pd.loadPublisherAddresses(pubID));

		RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/PublisherAddress.jsp");
		requestDispatcher.forward(request, response);
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
