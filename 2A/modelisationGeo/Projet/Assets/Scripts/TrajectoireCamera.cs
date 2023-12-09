using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TrajectoireCamera : MonoBehaviour
{

    public float duration = 1f;

    // Liste des points en entrée
    private List<float> X = new List<float>();
    private List<float> Y = new List<float>();
    
    // Donnees i.e. points cliqués
    private GameObject Donnees;
    
    // Translation de la caméra
    // Liste des points composant la courbe
    private List<Vector3> ListePoints = new List<Vector3>();

    // Pas d'échantillonage construire la parametrisation
    private float pas = 1/100f;
    
    // degres des polynomes par morceaux
    public int degres = 5;
    // nombre d'itération de subdivision
    public int nombreIteration = 20;
    
        //////////////////////////////////////////////////////////////////////////
    // fonction : subdivise                                                 //
    // semantique : réalise nombreIteration subdivision pour des polys de   //
    //              degres degres                                           //
    // params : - List<float> X : abscisses des point de controle           //
    //          - List<float> Y : odronnees des point de controle           //
    // sortie :                                                             //
    //          - (List<float>, List<float>) : points de la courbe          //
    //////////////////////////////////////////////////////////////////////////
    (List<float>, List<float>) subdivise(List<float> X, List<float> Y) {
        List<float> Xres = new List<float>();
        List<float> Yres = new List<float>();
        
        for (int i=0; i<X.Count; i++) {
	    Xres.Add(X[i]);
	    Xres.Add(X[i]);
	    Yres.Add(Y[i]);
	    Yres.Add(Y[i]);
	}
        
        for (int k=0; k<nombreIteration; k++) {
		
	    for (int j = 0; j < Xres.Count-1; j++)
            {
                Xres[j] = (Xres[j] + Xres[j + 1]) / 2;
                Yres[j] = (Yres[j] + Yres[j + 1]) / 2;
            }
	    Xres.Add((Xres[0]+Xres[Xres.Count-1])/2);
	    Yres.Add((Yres[0]+Yres[Yres.Count-1])/2);
        }
        
        return (Xres, Yres);
    }

    List<Quaternion> rotation(GameObject camera, List<float> X, List<float> Y) {
        
        List<Quaternion> listeRotations = new List<Quaternion>();
        Vector3 cameraPosition = camera.transform.position;
        float x = cameraPosition.x;
        float y = cameraPosition.y;
        float z = cameraPosition.z;
        
        float centerX = 0f;
        float centerY = 0f;
        
        for (int i=0; i<X.Count; i++) 
        {
            centerX += X[i];
            centerY += Y[i];
        }
        
        centerX = centerX/X.Count;
        centerY = centerY/Y.Count;
        
        // On redirige la rotation vers le centre (si c'est pas déjà fait)
        /*Vector3 startPoint = new Vector3(x, y, z);
        Vector3 endPoint = new Vector3(centerX, y, centerY);
        Vector3 direction = endPoint - startPoint;
        
        Quaternion rotation = Quaternion.LookRotation(direction);
        listeRotations.Add(rotation);*/
        
        Vector3 endPoint = new Vector3(centerX, y, centerY);
        for (int i=0; i<X.Count; i++) 
        {
            Vector3 startPoint = new Vector3(X[i], y, Y[i]);
            Vector3 direction = endPoint - startPoint;
            Quaternion rotation = Quaternion.LookRotation(direction);
            Quaternion.Normalize(rotation);
            listeRotations.Add(rotation);
        }
        
        return listeRotations;
    }
    
    
    List<float> buildEchantillonnage()
    {   
        // Echantillonage des pas temporels
        List<float> tToEval = new List<float>();

        for (float t = 0; t <= 1; t += pas)
        {
            tToEval.Add(t);
        }
        return tToEval;
    }

    Vector2 DeCasteljau(List<float> X, List<float> Y, float t)
    {
        // Si le polygone de controle est de degre 0, on renvoie le point
        if (X.Count == 1)
        {
            return new Vector2(X[0], Y[0]);
        }
        // Sinon on construit le polygone de controle de degre inferieur
        else
        {
            List<float> X2 = new List<float>();
            List<float> Y2 = new List<float>();
            for (int i = 0; i < X.Count - 1; ++i)
            {
                X2.Add((1 - t) * X[i] + t * X[i + 1]);
                Y2.Add((1 - t) * Y[i] + t * Y[i + 1]);
            }
            return DeCasteljau(X2, Y2, t);
        }
    }
    

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Return))
        {
        
            // Récupérer les points d'entrée
            var ListePointsCliques = GameObject.Find("Donnees").GetComponent<Points>();
            if (ListePointsCliques.X.Count > 0)
            {
            	X = ListePointsCliques.X;
                Y = ListePointsCliques.Y;
            }
        
            // Appliquer les rotations à la Caméra
            GameObject[] objects = GameObject.FindGameObjectsWithTag("MainCamera");
            GameObject camera = objects[0];
   
   	    float y = camera.transform.position.y;
            /*List<float> T = buildEchantillonnage();
            Vector2 point = new Vector2();*/
            
            List<float> X_new = new List<float>();
    	    List<float> Y_new = new List<float>();
    	    
    	    /*X.Add(X[0]);
    	    Y.Add(Y[0]);*/
    	            	        	    
            /*foreach (float t in T)
            {
                point = DeCasteljau(X, Y, t);
                ListePoints.Add(new Vector3(point.x,y,point.y));
                X_new.Add(point.x);
                Y_new.Add(point.y);
            }*/
            
            //ListePoints.Add(camera.transform.position);
            (X_new,Y_new) = subdivise(X,Y);
            for(int i=0; i<X_new.Count; i++) {
            	ListePoints.Add(new Vector3(X_new[i],y,Y_new[i]));
            }

            List<Quaternion> listeRotations = rotation(camera,X_new,Y_new);
   
            StartCoroutine(InterpolateCamera(camera, listeRotations));

        }
    }
    
    
private IEnumerator InterpolateCamera(GameObject camera, List<Quaternion> rotations)
	{
    float elapsedTime = 0f;
    int rotationIndex = 0;
    float y = camera.transform.position.y;

    while (true)
    {
        Quaternion startRotation = rotations[rotationIndex];
        Quaternion targetRotation = rotations[(rotationIndex + 1) % rotations.Count];

        while (elapsedTime < duration)
        {
            elapsedTime += Time.deltaTime;
            float t = Mathf.Clamp01(elapsedTime / duration);
            Quaternion interpolatedRotation = Quaternion.Slerp(startRotation, targetRotation, t);

            if (camera != null)
            {
                camera.transform.rotation = interpolatedRotation;
                camera.transform.position = ListePoints[rotationIndex];
            }

            yield return null;
        }

        elapsedTime = 0f;
        rotationIndex = (rotationIndex + 1) % rotations.Count;
        
        // si on veut un seul tour
        //if (rotationIndex ==0) {break;}

    }
}
    

    void OnDrawGizmos()
    {
        Gizmos.color = Color.blue;
        for(int i = 0; i < ListePoints.Count - 1; ++i)
        {
            Gizmos.DrawLine(ListePoints[i], ListePoints[i+1]);
        }
        if (ListePoints.Count > 0 ) {
            Gizmos.DrawLine(ListePoints[ListePoints.Count - 1], ListePoints[0]);
        }
    }
}
