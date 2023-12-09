package pack1;

import java.util.ArrayList;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.Collection;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.ejb.EJBException;
import javax.ejb.Singleton;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.transaction.Transactional;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;

@Singleton
@Path("/")
public class Facade {
	
	@PersistenceContext
	private EntityManager em;

	
	private boolean init = false;
	private boolean initRecherche = false;
	private int nbChargement = 0;
	private final int nbRecherche = 10;
	
	private final String SQLPATHFILM = "createdb_film.sql";
	private final String SQLPATHACTEUR = "createdb_acteur.sql"; 
	private final String SQLPATHFILMACTEUR = "createdb_film_acteur.sql";
	    
	
	private String serialiserUtilisateur(Utilisateur utilisateur) {
		
		UtilisateurDTO utilisateurDTO = new UtilisateurDTO(utilisateur.getPseudo(), utilisateur.getNom(), 
				utilisateur.getPrenom(), utilisateur.getMdp(), utilisateur.getNaissance());
		Collection <Film> films = utilisateur.getFilms();
		Collection <UtilisateurFilmDTO> filmsDTO = new ArrayList<UtilisateurFilmDTO>();
		for (Film f : films) {
			UtilisateurFilmDTO film = new UtilisateurFilmDTO(f.getId(), f.getNom());
			filmsDTO.add(film);
		}
		utilisateurDTO.setFilms(filmsDTO);
		Collection <Note> notes= utilisateur.getNotes();
		Collection <NoteDTO> notesDTO = new ArrayList<NoteDTO>();
		for (Note n : notes) {
			NoteDTO note = new NoteDTO(n.getFilm().getId(), n.getUtilisateur().getPseudo(), n.getNote());
			notesDTO.add(note);
		}
		utilisateurDTO.setNotes(notesDTO);
	    return utilisateurDTO.toJson();
	}
	
	private FilmDTO serialiserFilm(Film film) {
		FilmDTO filmDTO = new FilmDTO(film.getId(),film.getNom(),film.getRelease_date(),
				film.getSynopsis(),film.getGenres(),film.getAffiche());
		Collection <Utilisateur> utilisateurs = film.getUtilisateurs();
		Collection <String> utilisateursDTO = new ArrayList<String>();
		for (Utilisateur u : utilisateurs) {
			utilisateursDTO.add(u.getPseudo());
		}
		filmDTO.setUtilisateurs(utilisateursDTO);
		Collection <Note> notes= film.getNotes();
		Collection <NoteDTO> notesDTO = new ArrayList<NoteDTO>();
		for (Note n : notes) {
			NoteDTO note = new NoteDTO(n.getFilm().getId(), n.getUtilisateur().getPseudo(), n.getNote());
			notesDTO.add(note);
		}
		Collection <Acteur> acteurs = film.getActeurs();
		Collection <FilmActeurDTO> acteursDTO = new ArrayList<FilmActeurDTO>();
		for (Acteur a : acteurs) {
			FilmActeurDTO acteur = new FilmActeurDTO(a.getId(), a.getNom());
			acteursDTO.add(acteur);
		}
		filmDTO.setActeurs(acteursDTO);
		return filmDTO;
	}
	
	private ActeurDTO serialiserActeur(Acteur acteur) {
		ActeurDTO acteurDTO = new ActeurDTO(acteur.getId(),acteur.getNom(),acteur.getNaissance(),
				acteur.getDescription(), acteur.getPhoto(), acteur.getFilms_absents());
		Collection <Film> films = acteur.getFilms();
		Collection <UtilisateurFilmDTO> filmsDTO = new ArrayList<UtilisateurFilmDTO>();
		for (Film f : films) {
			UtilisateurFilmDTO filmDTO = new UtilisateurFilmDTO(f.getId(),f.getNom());
			filmsDTO.add(filmDTO);
		}
		acteurDTO.setFilms(filmsDTO);
		return acteurDTO;
	}
	
	@Produces({"application.json"})
	private void initialiser(boolean charger) {
		if (!charger) {
    		initRecherche = true;
    		if(chercherFilm("Forrest Gump")== null) {
    			charger(SQLPATHFILM);
    			charger(SQLPATHACTEUR);
    			while(nbChargement < 2) {
    				
    			}
    			charger(SQLPATHFILMACTEUR);
    			init = true;
    		}
    	}
	}
	
	@Produces({"application.json"})
    private void charger(String fichier) {
            FileReader reader = null;
			try {
				reader = new FileReader(fichier);
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            BufferedReader bufferedReader = new BufferedReader(reader); 
            String line;
            String requete = "";
            try {
				while ((line = bufferedReader.readLine()) != null) {
					requete = requete + line;
				    if (line.trim().endsWith(";")) {
				    }
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            Query query = em.createNativeQuery(requete);
	    	query.executeUpdate();
	    	nbChargement ++;
    }
	
    @POST
    @Path("/ajouterUtilisateur")
    @Consumes({ "application/json" })
    @Transactional
    public Response ajouterUtilisateur(Utilisateur utilisateur) {
    	initialiser(init);
    	if (utilisateur.getMdp() == null) {
    		String errorMessage = "{\"message\": \"merci de choisir un mdp non null \"}";
    		return Response.status(Response.Status.BAD_REQUEST).entity(errorMessage).build();
    	}
    	else if (em.find(Utilisateur.class, utilisateur.getPseudo()) == null) {
    		em.persist(utilisateur);
    		return Response.ok().build();
    	}
    	else {
    		String errorMessage = "{\"message\": \"le pseudo " + utilisateur.getPseudo() + " existe déjà, veuillez en choisir un autre \"}";
    		return Response.status(Response.Status.BAD_REQUEST).entity(errorMessage).build();
        }
    }
    
    
	
	
	@POST
	@Path("/ajouterFilm")
	@Consumes({ "application/json" })
	public void ajoutFilm(Film film)
	{
		initialiser(init);
		em.persist(film);
	}
	
	@POST
	@Path("/ajouterActeur")
	@Consumes({ "application/json" })
	public void ajoutActeur(Acteur acteur ) {
		initialiser(init);
		em.persist(acteur);		
	}
	
	@PUT
	@Path("/ajouterNote")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response ajoutNote(@QueryParam("pseudo") String pseudo,@QueryParam("note") String snvnote, int idFilm) {
		initialiser(init);
		int nvnote = Integer.parseInt(snvnote);
		Utilisateur user = em.find(Utilisateur.class, pseudo);
		Film film = em.find(Film.class, idFilm);
		TypedQuery<Note> req =  em.createQuery("select n from Note n where n.film = ?1 and n.utilisateur = ?2", Note.class);
		req.setParameter(1, film);
		req.setParameter(2, user);
		List<Note> notes = req.getResultList();
		Note note = new Note();
		if (notes.size() < 1) {
			note.setFilm(film);
			note.setUtilisateur(user);
			note.setNote(nvnote);
			note.setId(0);
			em.persist(note);
		}
		else {
			note = notes.get(0);
			note.setNote(nvnote);
			em.merge(note);
		}
		
		List<Note> notesU = (List<Note>) user.getNotes();
		if (note != null && notesU.contains(note)) {
			int ind = notesU.indexOf(note);
			notesU.set(ind, note);
		}
		else {
			notesU.add(note);
		}
		user.setNotes(notesU);
		em.merge(user);
		String json = serialiserUtilisateur(user);
		return Response.ok(json).build();
	}
	
	@PUT
	@Path("/addWatchlist")
	@Consumes("application/json")
	@Produces("application/json")
	public Response ajoutWatchList(@QueryParam("pseudo") String pseudo, int idFilm) {
		initialiser(init);
		Utilisateur utilisateur = new Utilisateur();
		utilisateur = em.find(Utilisateur.class, pseudo);
		Film film = em.find(Film.class, idFilm);
		Collection<Film> films = utilisateur.getFilms();
		if(films.contains(film)) {
			String errorMessage = "{\"message\": \" " + film.getNom() + " existe déjà dans votre watchlist, veuillez en choisir un autre \"}";
    		return Response.status(Response.Status.BAD_REQUEST).entity(errorMessage).build();
		}
		else {
			films.add(film);
			utilisateur.setFilms(films);
			em.merge(utilisateur);
			String json = serialiserUtilisateur(utilisateur); 
			return Response.ok(json).build();
		}
	}
	
	@GET
	@Path("/listeUtilisateur")
	@Produces({ "application/json" })
	public Collection<Utilisateur> listeUtilisateur(){
		TypedQuery<Utilisateur> req=em.createQuery("from Utilisateur", Utilisateur.class);
		return req.getResultList();
	}
	
	@GET
	@Path("/chercherUtilisateur")
	@Produces({ "application/json" })
	public Response chercherUtilisateur(@QueryParam("pseudo") String pseudo, @QueryParam("mdp") String mdp) {
		initialiser(init);
	    TypedQuery<Utilisateur> query = em.createQuery("select u from Utilisateur u where u.pseudo = ?1 and u.mdp = ?2",Utilisateur.class);
	    query.setParameter(1, pseudo);
	    query.setParameter(2, mdp);
	    try {
	    	Utilisateur utilisateur = query.getSingleResult();
		    String json = serialiserUtilisateur(utilisateur);
	        return Response.ok(json).build();
	    } catch (NoResultException e) {
    		return Response.status(Response.Status.BAD_REQUEST).build();
	    }
	}

	@PUT
	@Path("/modifierUtilisateur")
	@Consumes("application/json")
	@Produces("application/json")
	public Response modifierUtilisateur (@QueryParam("pseudo")String pseudo, Utilisateur nUtilisateur) throws EJBException {
		initialiser(init);
	    Utilisateur utilisateur = new Utilisateur();
	    utilisateur = em.find(Utilisateur.class, pseudo);
	    utilisateur.setMdp(nUtilisateur.getMdp());
	    utilisateur.setNaissance(nUtilisateur.getNaissance());
	    utilisateur.setNom(nUtilisateur.getNom());
	    utilisateur.setPrenom(nUtilisateur.getPrenom());
	    utilisateur.setPseudo(nUtilisateur.getPseudo());  
	    
	    em.merge(utilisateur);
	    String json = serialiserUtilisateur(utilisateur);
		return Response.ok(json).build();
	    
	}
	
	
	@GET
	@Path("/chercherFilm")
	@Produces({ "application/json" })
	public Response chercherFilm(@QueryParam("nom") String nom) {
		initialiser(initRecherche);
		String nomNormalise = nom.toLowerCase();
	    TypedQuery<Film> query = em.createQuery("select f from Film f where lower(f.nom) like '%" + nomNormalise + "%'",Film.class);
	    query.setMaxResults(nbRecherche);
	    try {
	        Collection<Film> films =  query.getResultList();
	        if (films.size() <1) {
	        	return null;
	        }
	        Collection<FilmDTO> filmsDTO = new ArrayList<FilmDTO>();
	        for (Film f : films) {
	        	FilmDTO filmDTO = serialiserFilm(f);
	        	filmsDTO.add(filmDTO);
	        }
	        ObjectMapper objectMapper = new ObjectMapper();
	        try {
	            String json = objectMapper.writeValueAsString(filmsDTO);
	            return Response.ok(json).build();
	        } catch (JsonProcessingException e) {
	            e.printStackTrace();
	            return null;
	        }
	    } catch (NoResultException e) {
	        return null;
	    }
	}
	
	@GET
	@Path("/chercherActeur")
	@Produces({ "application/json" })
	public Response chercherActeur(@QueryParam("nom") String nom) {
		initialiser(initRecherche);
		String nomNormalise = nom.toLowerCase();
	    TypedQuery<Acteur> query = em.createQuery("select a from Acteur a where lower(a.nom) like '%" + nomNormalise + "%'",Acteur.class);
	    query.setMaxResults(nbRecherche);
	    try {
	    	Collection<Acteur> acteurs =  query.getResultList();
	        if (acteurs.size() <1) {
	        	return null;
	        }
	        Collection<ActeurDTO> acteursDTO = new ArrayList<ActeurDTO>();
	        for (Acteur a : acteurs) {
	        	ActeurDTO acteurDTO = serialiserActeur(a);
	        	acteursDTO.add(acteurDTO);
	        }
	        ObjectMapper objectMapper = new ObjectMapper();
	        try {
	            String json = objectMapper.writeValueAsString(acteursDTO);
	            return Response.ok(json).build();
	        } catch (JsonProcessingException e) {
	            e.printStackTrace();
	            return null;
	        }
	    } catch (NoResultException e) {
	        return null;
	    }
	}
	
	
	@GET
	@Path("/listFilms")
	@Produces({ "application/json" })
	public Collection<Film> listeFilms(){
		TypedQuery<Film> req=em.createQuery("from Film", Film.class);
		return req.getResultList();
	}
	
	@GET
	@Path("/listNotes")
	@Produces({ "application/json" })
	public Collection<Note> listeNotes(){
		TypedQuery<Note> req=em.createQuery("from Note", Note.class);
		return req.getResultList();
	}
	
	
	@GET
	@Path("/listActeurs")
	@Produces({ "application/json" })
	public Collection<Acteur> listeActeurs(){
		TypedQuery<Acteur>req=em.createQuery("from Acteur", Acteur.class);
		return req.getResultList();
	}
	
	@POST
	@Path("/associer")
	@Produces({ "application/json"})
	public void associer(int filmId, int acteurId) {
		initialiser(init);
		Film film = em.find(Film.class, filmId);
		Acteur acteur = em.find(Acteur.class, acteurId);
		Collection<Acteur> acteurs = film.getActeurs();
		acteurs.add(acteur);
		film.setActeurs(acteurs);
		em.merge(film);
	}

}
