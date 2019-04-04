package Servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SheetieServlet
 */
@WebServlet("/SheetieServlet")
public class SheeteMueServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SheeteMueServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(final HttpServletRequest request, final HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getServletPath().equals("/SheetieServlet")) {
			RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/product-page.jsp");
			requestDispatcher.forward(request, response);
		} else {

			System.out.println(request.getServletPath());
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
