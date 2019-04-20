package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Address;
import model.AddressDao;
import model.User;
import model.UserDao;

/**
 * Servlet implementation class AddressServlet
 */
@WebServlet("/AddressServlet")
public class AddressServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddressServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		AddressDao ad = new AddressDao();
		String action = request.getParameter("action");
		User u = (User) request.getSession().getAttribute("User");

		if (action != null && action.equals("shippingAddressView")) {
			List<Address> as = ad.loadAllUserAddress(u.getUserID());
			request.setAttribute("userAddresses", as);
			RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/ShippingAddress.jsp");
			requestDispatcher.forward(request, response);

		} else if (action != null && action.equals("createShippingAddress")) {
			Address a = new Address();
			a.setStreet(request.getParameter("street"));
			a.setCity(request.getParameter("city"));
			a.setState(request.getParameter("state"));
			a.setZip(request.getParameter("zip"));
			if (ad.createUserAddress(a, u.getUserID())) {
				List<Address> as = ad.loadAllUserAddress(u.getUserID());
				request.setAttribute("userAddresses", as);
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/ShippingAddress.jsp");
				requestDispatcher.forward(request, response);
			} else {
				request.setAttribute("message", "<h3 style=\"color:red\">Address creation failed. Please check fields and try again.</h3>");
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/CreateAddress.jsp");
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
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
