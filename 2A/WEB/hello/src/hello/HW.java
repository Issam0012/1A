package hello;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HW
 */
@WebServlet("/HW")
public class HW extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public HW() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
		String s1 = request.getParameter("nb1");
		String s2 = request.getParameter("nb2");
		
		int n1 = Integer.parseInt(s1);
		int n2 = Integer.parseInt(s2);
		int n = n1+n2;
		request.setAttribute("n", n);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/NewFile.jsp");
        dispatcher.forward(request, response);
		//response.getWriter().println("<html><body>Hello World !, votre résultat est : " + n + "</body></html>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
