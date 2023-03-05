import java.rmi.*;
import java.rmi.server.*;
import java.util.*;
import java.rmi.registry.*;

public class CarnetImpl extends UnicastRemoteObject implements Carnet {

	private Map<String, RFiche> utilisateurs;
	private int nCarnet;
	
	public CarnetImpl(int n) throws RemoteException {
		this.utilisateurs = new HashMap<>();
		this.nCarnet = n;
	}

	public void Ajouter(SFiche sf) throws RemoteException {
		try {
		    RFiche rf = new RFicheImpl(sf.getNom(), sf.getEmail());
		    this.utilisateurs.put(sf.getNom(), rf);
		} catch (Exception e) {
		    e.printStackTrace();
		}
	}
	
	public RFiche Consulter(String n, boolean forward) throws RemoteException {
		RFiche tmp = utilisateurs.get(n);
		if (tmp == null && forward) {
			try {
			    Carnet other = (Carnet) Naming.lookup("//localhost:4000/Carnet" + (this.nCarnet % 2) + 1);
			    tmp = other.Consulter(n,false);
			} catch (Exception e) {
			    System.out.println(e.toString());
			}
		}
		return tmp;
	}
	
	public static void main(String args[]) {
		try {
			Registry registry = LocateRegistry.createRegistry(4000);
			Integer i = new Integer(args[0]);
			int n = i.intValue();
			Naming.rebind("//localhost:4000/Carnet" + n, new CarnetImpl(n));
			System.out.println("HelloImpl " + " bound in registry");
		} catch (Exception exc) {exc.printStackTrace(); }
	}
}
