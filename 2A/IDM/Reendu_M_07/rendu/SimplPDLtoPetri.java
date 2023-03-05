package simplepdl.manip;

import java.io.IOException;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import org.eclipse.emf.common.util.EList;
import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.emf.ecore.resource.ResourceSet;
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl;
import org.eclipse.emf.ecore.xmi.impl.XMIResourceFactoryImpl;

import Petri.Reseau;
import Petri.ReseauElements;
import Petri.Place;
import Petri.Arc;
import Petri.PetriElements;
import Petri.Transition;
import simplepdl.Process;
import simplepdl.SimplepdlPackage;
import simplepdl.WorkDefinition;
import simplepdl.WorkSequence;
import simplepdl.WorkSequenceType;
import simplepdl.Ressources;
import simplepdl.BesoinRessources;
import Petri.PetriFactory;
import Petri.PetriPackage;

public class SimplPDLtoPetri {

	public static void main(String[] args) {
		
		// Charger les package Petri et simplpdl afin de les enregistrer dans le registre d'Eclipse.
		SimplepdlPackage packageInstancePDL = SimplepdlPackage.eINSTANCE;
		PetriPackage packageInstancePetri = PetriPackage.eINSTANCE;
		
		// Enregistrer l'extension ".xmi" comme devant être ouverte à
		// l'aide d'un objet "XMIResourceFactoryImpl"
		Resource.Factory.Registry reg = Resource.Factory.Registry.INSTANCE;
		Map<String, Object> m = reg.getExtensionToFactoryMap();
		m.put("xmi", new XMIResourceFactoryImpl());
		
		// Créer un objet resourceSetImpl qui contiendra une ressource EMF (le modèle)
		ResourceSet resSet = new ResourceSetImpl();

		//Définir la ressource (le modèle simplpdl existant)
		URI modelURI = URI.createURI("models/SimplePDLCreator_Created_Process.xmi");
		Resource resource = resSet.getResource(modelURI,true);
		
		// Définir la ressource (le nouveau modèle petri)
		URI modelURI_ = URI.createURI("models/PetriCreator_Created_Process.xmi");
		Resource resourcePetri = resSet.createResource(modelURI_);
		
		// La fabrique pour fabriquer les éléments de Petri
	    PetriFactory myFactory = PetriFactory.eINSTANCE;
	    
	    // Récupérer le réseau pdl
	    Process process = (Process) resource.getContents().get(0);
	    
	    // Créer le réseau Petri
 		Reseau reseau = myFactory.createReseau();
 		reseau.setName(process.getName());
 		
 		// Ajouter le réseau dans le modèle
 		resourcePetri.getContents().add(reseau);
 		PetriElements petriElements = myFactory.createPetriElements();
 	    
 		// Parcourir les éléments de réseau simplpdl en transformant chacun à son équivalent en réseau Petri
 		for (Object o : process.getProcessElements()) {
 			if (o instanceof WorkDefinition) { // Transformation d'une WorkDefinition
 				WorkDefinition wd = (WorkDefinition) o;
 				
 				// La création des places nécessaires
 				Place p1 = myFactory.createPlace();
 			    p1.setName(wd.getName() + "_ready");
 			    p1.setJetons(1);
 			    reseau.getReseauElements().add(p1);
 			    
 			    Place p2 = myFactory.createPlace();
 			    p2.setName(wd.getName() + "_started");
 			    reseau.getReseauElements().add(p2);
 			    
 			    Place p3 = myFactory.createPlace();
 			    p3.setName(wd.getName() + "_running");
 			    reseau.getReseauElements().add(p3);
 			    
 			    Place p4 = myFactory.createPlace();
 			    p4.setName(wd.getName() + "_finished");
 			    reseau.getReseauElements().add(p4);
 			    
 			    //La création des transitions nécessaires
 			    Transition t1 = myFactory.createTransition();
 			    t1.setName(wd.getName() + "_start");
 			    reseau.getReseauElements().add(t1);
 			    
 			    Transition t2 = myFactory.createTransition();
 			    t2.setName(wd.getName() + "_finish");
 			    reseau.getReseauElements().add(t2);
 			    
 			    //La création des arcs nécessaires
 			    Arc arc1 = myFactory.createArc();
 			    arc1.setName(wd.getName()+"arc1");
 			    arc1.setPredecessor(p1);
 			    arc1.setSuccessor(t1);
 			    reseau.getReseauElements().add(arc1);
 			    
 			    Arc arc2 = myFactory.createArc();
 			    arc2.setName(wd.getName()+"arc2");
 			    arc2.setPredecessor(t1);
 			    arc2.setSuccessor(p2);
 			    reseau.getReseauElements().add(arc2);
 			    
 			    Arc arc3 = myFactory.createArc();
 			    arc3.setName(wd.getName()+"arc3");
 			    arc3.setPredecessor(t1);
 			    arc3.setSuccessor(p3);
 			    reseau.getReseauElements().add(arc3);
 			    
 			    Arc arc4 = myFactory.createArc();
 			    arc4.setName(wd.getName()+"arc4");
 			    arc4.setPredecessor(p3);
 			    arc4.setSuccessor(t2);
 			    reseau.getReseauElements().add(arc4);
 			    
 			    Arc arc5 = myFactory.createArc();
 			    arc5.setName(wd.getName()+"arc5");
 			    arc5.setPredecessor(t2);
 			    arc5.setSuccessor(p4);
 			    reseau.getReseauElements().add(arc5);
 			    
 			} else if (o instanceof WorkSequence) { // Transformation d'une workSequence
 				WorkSequence ws = (WorkSequence) o;
 				Arc arc = myFactory.createArc();
 				
 				if (ws.getLinkType() == WorkSequenceType.START_TO_START) {
 					arc.setName(ws.getPredecessor().getName()+"Start_To_START"+ws.getSuccessor().getName());
 					for (Object j : reseau.getReseauElements()) {
 						if (j instanceof Place) {
 							Place place = (Place) j;
 							if (place.getName().equals(ws.getPredecessor().getName() + "_started")) {
 								arc.setPredecessor(place);
 							}
 						} else if (j instanceof Transition) {
 							Transition transition = (Transition) j;
 							if (transition.getName().equals(ws.getSuccessor().getName() + "_start")) {
 								arc.setSuccessor(transition);
 							}
 						}
 					}
 				} else if (ws.getLinkType() == WorkSequenceType.START_TO_FINISH) {
 					arc.setName(ws.getPredecessor().getName()+"Start_To_FINISH"+ws.getSuccessor().getName());
 					for (Object j : reseau.getReseauElements()) {
 						if (j instanceof Place) {
 							Place place = (Place) j;
 							if (place.getName().equals(ws.getPredecessor().getName() + "_started")) {
 								arc.setPredecessor(place);
 							}
 						} else if (j instanceof Transition) {
 							Transition transition = (Transition) j;
 							if (transition.getName().equals(ws.getSuccessor().getName() + "_finish")) {
 								arc.setSuccessor(transition);
 							}
 						}
 					}
 				} else if (ws.getLinkType() == WorkSequenceType.FINISH_TO_FINISH) {
 					arc.setName(ws.getPredecessor().getName()+"Finish_To_FINISH"+ws.getSuccessor().getName());
 					for (Object j : reseau.getReseauElements()) {
 						if (j instanceof Place) {
 							Place place = (Place) j;
 							if (place.getName().equals(ws.getPredecessor().getName() + "_finished")) {
 								arc.setPredecessor(place);
 							}
 						} else if (j instanceof Transition) {
 							Transition transition = (Transition) j;
 							if (transition.getName().equals(ws.getSuccessor().getName() + "_finish")) {
 								arc.setSuccessor(transition);
 							}
 						}
 					}
 				} else if (ws.getLinkType() == WorkSequenceType.FINISH_TO_START) {
 					arc.setName(ws.getPredecessor().getName()+"Finish_To_START"+ws.getSuccessor().getName());
 					for (Object j : reseau.getReseauElements()) {
 						if (j instanceof Place) {
 							Place place = (Place) j;
 							if (place.getName().equals(ws.getPredecessor().getName() + "_finished")) {
 								arc.setPredecessor(place);
 							}
 						} else if (j instanceof Transition) {
 							Transition transition = (Transition) j;
 							if (transition.getName().equals(ws.getSuccessor().getName() + "_start")) {
 								arc.setSuccessor(transition);
 							}
 						}
 					}
 				}
 				reseau.getReseauElements().add(arc);
 			} else if (o instanceof Ressources) { // Transformation d'une Ressource
 			// La création de la place nécessaire
 				Ressources ressources = (Ressources) o;
 				Place p1 = myFactory.createPlace();
 			    p1.setName(ressources.getName());
 			    p1.setJetons(ressources.getQuantity());
 			    reseau.getReseauElements().add(p1);
 			    
 			   for (Object q : ressources.getAllocate()) {
  				   if (q instanceof BesoinRessources) { // Transformation d'une BesoinRessources
  		 				BesoinRessources bs = (BesoinRessources) q;
  		 				// La création de l'arc nécessaire
  		 				Arc arc = myFactory.createArc();
  		 				arc.setName(bs.getUser().getName() + "_needs_" + bs.getRessource().getName());
  		 				arc.setPredecessor(p1);
  						for (Object j : reseau.getReseauElements()) {
  							if (j instanceof Transition) {
  								Transition transition = (Transition) j;
  								if (transition.getName().equals(bs.getUser().getName() + "_start")) {
  									arc.setSuccessor(transition);
  								}
  							}
  						}
					arc.setEchange(bs.getNeed());
					reseau.getReseauElements().add(arc);
  		 			}
  			   }
 			    
 			}
 			
 		}
		
		// Sauver la ressource
	    try {
	    	resourcePetri.save(Collections.EMPTY_MAP);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

}
