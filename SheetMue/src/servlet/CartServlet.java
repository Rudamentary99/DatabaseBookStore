package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Book;
import model.BookDao;
import model.Cart;
import model.CartDao;
import model.CartItem;
import model.User;

/**
 * Servlet implementation class CartServlet
 */
@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Exception goToIndex = null;
	private CartDao cd = new CartDao();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CartServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		System.out.println(action);
		try {

			User u = (User) request.getSession().getAttribute("User");
			if (action != null && u != null && u.getFirstName() != null) {

				if (action.equals("viewCart")) {
					if (request.getSession().getAttribute("CartOrder") == null) {

						Cart cartSave = new Cart();
						Cart cartOrder = cd.load(u.getUserID());
						ArrayList<CartItem> save = new ArrayList<>();
						ArrayList<CartItem> order = cartOrder.getItems();
						int i = 0;
						while (i < order.size()) {

							if (order.get(i).isSavedForLater()) {
								save.add(order.remove(i));
								System.out.println(save);
							}
							i++;
						}
						cartSave.setItems(save);
						cartOrder.setItems(order);
						request.getSession().setAttribute("CartOrder", cartOrder);
						request.getSession().setAttribute("CartSave", cartSave);

					}
					RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/Cart.jsp");
					requestDispatcher.forward(request, response);
				} else if (action.equals("saveForLater")) {
					int id = Integer.parseInt(request.getParameter("bookID"));
					// get current cart
					ArrayList<CartItem> co = ((Cart) request.getSession().getAttribute("CartOrder")).getItems();
					ArrayList<CartItem> cs = ((Cart) request.getSession().getAttribute("CartSave")).getItems();
					// find updated item
					int i = 0;
					boolean searching = true;

					while (searching) {

						if (co.get(i).getBookID() == id) {
							// once found, update the item both on db and view
							searching = false;
							CartItem c = co.remove(i);
							// toggle boolean
							c.setSavedForLater(!c.isSavedForLater());
							cd.update(u.getUserID(), c);
							cs.add(c);

						}
						i++;

					}
					request.getSession().setAttribute("CartOrder", new Cart(co));
					request.getSession().setAttribute("CartSave", new Cart(cs));
					RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/Cart.jsp");
					requestDispatcher.forward(request, response);
				} else if (action.equals("addToOrder")) {
					int id = Integer.parseInt(request.getParameter("bookID"));
					// get current cart
					ArrayList<CartItem> co = ((Cart) request.getSession().getAttribute("CartOrder")).getItems();
					ArrayList<CartItem> cs = ((Cart) request.getSession().getAttribute("CartSave")).getItems();
					// find updated item
					int i = 0;
					boolean searching = true;

					while (searching) {

						if (cs.get(i).getBookID() == id) {
							// once found, update the item both on db and view
							searching = false;
							CartItem c = cs.remove(i);
							// toggle boolean
							c.setSavedForLater(!c.isSavedForLater());
							cd.update(u.getUserID(), c);
							co.add(c);

						}
						i++;

					}
					request.getSession().setAttribute("CartOrder", new Cart(co));
					request.getSession().setAttribute("CartSave", new Cart(cs));
					RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/Cart.jsp");
					requestDispatcher.forward(request, response);

				} else if (action.equals("removeFromCart")) {
					int id = Integer.parseInt(request.getParameter("bookID"));
					// get current cart
					ArrayList<CartItem> co = ((Cart) request.getSession().getAttribute("CartOrder")).getItems();
					ArrayList<CartItem> cs = ((Cart) request.getSession().getAttribute("CartSave")).getItems();
					// find updated item
					boolean isFound = false;
					if (co.size() > 0) {
						int i = 0;
						boolean searching = true;
						while (searching) {

							if (co.get(i).getBookID() == id) {
								searching = false;
								CartItem c = co.remove(i);
								cd.delete(u.getUserID(), c);
								isFound = true; 
							}
							i++;

						}
					} 
					if (cs.size() > 0 && !isFound) {
						int i = 0;
						boolean searching = true;
						while (searching) {

							if (cs.get(i).getBookID() == id) {
								searching = false;
								CartItem c = cs.remove(i);
								cd.delete(u.getUserID(), c);
							}
							i++;

						}					
					}
					
					request.getSession().setAttribute("CartOrder", new Cart(co));
					request.getSession().setAttribute("CartSave", new Cart(cs));
					RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/Cart.jsp");
					requestDispatcher.forward(request, response);
					
				}
			
				else {
					System.out.println("unknown action");
					throw goToIndex;
				}
			} else {
				System.out.println("illegal access");
				throw goToIndex;
			}

		} catch (Exception e) {

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
