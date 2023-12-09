package hello;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Calcul
 */
@WebServlet("/Calcul")
public class Calcul extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Calcul() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub		
		/*response.getWriter().println("<html> <head><title>Directory</title></head><body>" +
		 "<h1>Enter a numbers</h1>" + 
		 "<form action= \"HW\" method=\"get\">" +
		 "nb1<input type=\"text\" name=\"nb1\"><br/>" +
		 "nb2<input type=\"text\" name=\"nb2\"><br/>" + 
		"<input type=\"submit\" name=\"op\" value=\"add\">" +
		 "</form>" +
		"</body></html>");*/
		
		// Appel du fichier JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/NewFile.jsp");
        dispatcher.forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
