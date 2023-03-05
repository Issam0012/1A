import java.rmi.*;
import java.rmi.server.*;

public class RFicheImpl extends UnicastRemoteObject implements RFiche{
	
	private String nom;
	private String email;
	
	public RFicheImpl(String nom, String mail) throws RemoteException {this.nom = nom; this.email = mail;}
	
	public String getNom() throws RemoteException {return nom;}
	public String getEmail() throws RemoteException {return email;}
}
