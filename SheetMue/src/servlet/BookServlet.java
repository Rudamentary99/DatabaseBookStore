package servlet;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.w3c.dom.CDATASection;

import model.Book;
import model.BookDao;
import model.CartDao;
import model.User;

/**
 * Servlet implementation class CreateBook
 */
@WebServlet(urlPatterns = { "/CreateBook", "/BookServlet" })
@MultipartConfig
public class BookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final static Logger LOGGER = Logger.getLogger(BookServlet.class.getCanonicalName());
	private Book b = new Book();
	private String forwardPath;
	private BookDao bd = new BookDao();
	private CartDao cd = new CartDao();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public BookServlet() {
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
		
		
		 if (action != null && action.equals("createBook")) {
			Book b = new Book();

			b.setPublisherID(Integer.parseInt(request.getParameter("publisherID")));
			b.setTitle(request.getParameter("title"));
			b.setAuthorName(request.getParameter("authorName"));
			b.setPubDate(toSqlDate(request.getParameter("pubDate")));

			b.setCurrentPrice(Double.parseDouble(request.getParameter("currentPrice")));
			b.setAmountInStock(Integer.parseInt(request.getParameter("amountInStock")));
			b.setDescription(request.getParameter("description"));
			b = bd.create(b);
			if (b != null && b.getTitle() != null) {

				request.getSession().setAttribute("id", Integer.toString(b.getBookID()));
				forwardPath = "/jsp/imgUpload.jsp";
				RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher(forwardPath);
				requestDispatcher.forward(request, response);
			} else {
				System.out.println("addItem Error");
			}
		} else if (action != null && action.equals("addToCart")) {
			
			if (cd.create(((User) request.getSession().getAttribute("User")).getUserID(),
					Integer.parseInt(request.getParameter("bookID")))) {
				System.out.println("item added to cart");
			}
			
			RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/item.jsp");
			requestDispatcher.forward(request, response);

		} 
		 
		 else if (action != null && action.equals("editItem")) {
			Book b = bd.load(Integer.parseInt(request.getParameter("id")));
			request.setAttribute("EditItem", b);
			RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/addItem.jsp");
			requestDispatcher.forward(request, response);

		} else if (action != null && action.endsWith("saveEdit")) {
			Book b = new Book();
			b.setBookID(request.getParameter("id"));
			b.setTitle(request.getParameter("title"));
			b.setAuthorName(request.getParameter("authorName"));
			b.setPubDate(toSqlDate(request.getParameter("pubDate")));
			b.setEdition(Integer.parseInt(request.getParameter("edition")));
			b.setDescription(request.getParameter("description"));
			b.setCurrentPrice(Double.parseDouble(request.getParameter("currentPrice")));
			b.setAmountInStock(Integer.parseInt("amountInStock"));
			bd.update(b);
		} else if (action != null && action.equals("searchBooks")) {
			List<Book> books = bd.search(request.getParameter("search"));
			request.getSession().setAttribute("SearchItems", books);
			
			RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/jsp/search.jsp");
			requestDispatcher.forward(request, response);
		}
		
		
		else if (action != null && action.equals("saveFile")) {

			saveImg(request, response);

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

// the following method was modeled after https://docs.oracle.com/javaee/6/tutorial/doc/glraq.html
	protected void saveImg(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		HttpSession session = request.getSession();
		// Create path components to save the file
		System.out.println("file made");
		final String fileName = Integer.toString(((Book) session.getAttribute("NewItem")).getBookID()) + ".png";
		Path p = Paths.get("eclipse-workspace/SheetMue/WebContent/img" + File.separator + fileName);
		final Part filePart = request.getPart("img");
		System.out.println(p);
		OutputStream out = null;
		InputStream filecontent = null;
		final PrintWriter writer = response.getWriter();

		try {

			if (Files.exists(p)) {
				System.out.println("deleting existing file");
				Files.delete(p);
			}
			System.out.println("saving file");
			Files.createFile(p);
			System.out.println("file saved");

			// get ready to write to file
			out = new FileOutputStream(p.toString());
			// getFileContents
			filecontent = filePart.getInputStream();

			int read = 0;
			final byte[] bytes = new byte[1024];

			// write fileContents to new file
			while ((read = filecontent.read(bytes)) != -1) {
				out.write(bytes, 0, read);
			}

			LOGGER.log(Level.INFO, "File{0}being uploaded to {1}", new Object[] { fileName, p });
			forwardPath = "/jsp/itemCreationSuccess.jsp";
			RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher(forwardPath);
			requestDispatcher.forward(request, response);
		} catch (FileNotFoundException fne) {

			LOGGER.log(Level.SEVERE, "Problems during file upload. Error: {0}", new Object[] { fne.getMessage() });
			forwardPath = "/jsp/imgUpload.jsp";
			RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher(forwardPath);
			requestDispatcher.forward(request, response);
		} finally {
			if (out != null) {
				out.close();
			}
			if (filecontent != null) {
				filecontent.close();
			}
			if (writer != null) {
				writer.close();
			}
		}

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
