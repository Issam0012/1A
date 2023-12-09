package hello;

import java.io.IOException;

import javax.ejb.EJB;
//import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import java.util.*;

/**
 * Servlet implementation class Application
 */
@WebServlet("/Application")
public class Application extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB
	private Facade facade;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Application() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());

        String op = request.getParameter("op");

        if (op.equals("ajoutPersonne")) {
        	String nom = request.getParameter("Nom");
        	String prenom = request.getParameter("Prenom");
        	facade.ajoutPersonne(nom, prenom);
        	response.sendRedirect("index.html");
        }
        if (op.equals("ajoutAdresse")) {
        	String rue = request.getParameter("rue");
        	String ville = request.getParameter("ville");
        	facade.ajoutAdresse(rue, ville);
        	response.sendRedirect("index.html");
        }
        if (op.equals("associer")) {
        	request.setAttribute("listePersonnes", facade.listePersonnes());
        	request.setAttribute("listeAdresses", facade.listeAdresses());
        	request.getRequestDispatcher("associer.jsp").forward(request, response);
        }
        if (op.equals("choix")) {
        	// par soucis de simplification j'ai pris que les premiers cases cochés
        	String[] valeurs_personnes = request.getParameterValues("personne");
        	String[] valeurs_adresses = request.getParameterValues("adresse");
        	String idpersonne = valeurs_personnes[0];
        	String idadresse = valeurs_adresses[0];
        	facade.associer(Integer.parseInt(idpersonne), Integer.parseInt(idadresse));
        	response.sendRedirect("index.html");
        }
        if (op.equals("lister")) {
        	request.setAttribute("listePersonnes", facade.listePersonnes());
        	request.getRequestDispatcher("lister.jsp").forward(request, response);
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
