package hello;

import java.util.*;

import javax.ejb.*;
import javax.persistence.*;

@Singleton
public class Facade {
	
	//int id_personne = 0;
	//int id_adresse = 0;
	//private HashMap<Integer,Personne> listePersonnes = new HashMap<Integer,Personne>();
	//private HashMap<Integer,Adresse> listeAdresses = new HashMap<Integer,Adresse>();
	
	@PersistenceContext(unitName = "MaPU")
	private EntityManager em;
	
	public void ajoutPersonne(String nom, String prenom) {
		//listePersonnes.put(id_personne, new Personne(nom,prenom));
		Personne p = new Personne();
		p.setNom(nom);
		p.setPrenom(prenom);
		em.persist(p);
		//id_personne++;
	}
	
	public void ajoutAdresse(String rue, String ville) {
		//listeAdresses.put(id_adresse, new Adresse(rue,ville));
		Adresse p = new Adresse();
		p.setRue(rue);
		p.setVille(ville);
		em.persist(p);
		//id_adresse++;
	}

	public void associer(int personneId, int adresseId) {
		/*Personne personne = listePersonnes.get(personneId);
		Adresse adress = listeAdresses.get(adresseId);*/
		Personne p = em.find(Personne.class, personneId);
		Adresse a = em.find(Adresse.class, adresseId);
		p.addAdress(a);
	}
	
	public Collection<Personne> listePersonnes() {
		/*List<Personne> list = new ArrayList<Personne>();
		for (Map.Entry mapentry : listePersonnes.entrySet()) {
			list.add((Personne) mapentry.getValue());
		}
		return list;*/
		TypedQuery<Personne> req = em.createQuery("SELECT p FROM Personne p",
				 Personne.class);
		return req.getResultList();
	}
	public Collection<Adresse> listeAdresses() {
		/*List<Adresse> list = new ArrayList<Adresse>();
		for (Map.Entry mapentry : listeAdresses.entrySet()) {
			list.add((Adresse) mapentry.getValue());
		}
		return list;*/
		TypedQuery<Adresse> req = em.createQuery("SELECT a FROM Adresse a",
				 Adresse.class);
		return req.getResultList();
	}
}
