import java.rmi.*;
import java.rmi.server.*;

public class SFicheImpl implements SFiche{
	
	private String nom;
	private String email;
	
	public SFicheImpl(String nom, String mail) {this.nom = nom; this.email = mail;}
	
	public String getNom() {return nom;}
	public String getEmail() {return email;}
}
