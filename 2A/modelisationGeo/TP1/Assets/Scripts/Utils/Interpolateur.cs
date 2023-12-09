using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System;
using UnityEngine.UI;


public class Interpolateur : MonoBehaviour
{
    // Pas d'échantillonnage 
    public float pas = 1/100;
    // Conteneur des points cliqués
    public GameObject Donnees;
    // Les points (X,Y) cliqués
    private List<float> X = new List<float>();
    private List<float> Y = new List<float>();
    public enum EInterpolationType { Lagrange, Neville };
    public EInterpolationType InterpolationType = EInterpolationType.Lagrange;
    public enum EParametrisationType { Reguliere, Distance, RacineDistance, Tchebytcheff, None}
    public EParametrisationType ParametrisationType = EParametrisationType.Reguliere;

    // Pour le dessin des courbes
    private List<Vector3> P2DRAW = new List<Vector3>();
    // UI
    public Text text;

    //////////////////////////////////////////////////////////////////////////
    // fonction : buildParametrisationReguliere                             //
    // semantique : construit la parametrisation reguliere et les           //
    //              échantillons de temps selon cette parametrisation       //
    // params :                                                             //
    //          - int nbElem : nombre d'elements de la parametrisation      //
    //          - float pas : pas d'échantillonage                          //
    // sortie :                                                             //
    //          - List<float> T : parametrisation reguliere                 //
    //          - List<float> tToEval : echantillon sur la parametrisation  //
    //////////////////////////////////////////////////////////////////////////
    (List<float>, List<float>) buildParametrisationReguliere(int nbElem, float pas)
    {
        // Vecteur des pas temporels
        List<float> T = new List<float>();
        // Echantillonage des pas temporels
        List<float> tToEval = new List<float>();

        // Construction des pas temporels
        for (int k = 0; k<nbElem; k++)
        {
            T.Add(k);
        }

        // Construction des échantillons
	float min = T.Min();
        float max = T.Max();
        int i = 0;
        
        while ((min+i*pas)<=max)
	{
	    tToEval.Add(min+i*pas);
	    i++;
	}
	
        return (T, tToEval);
    }

    //////////////////////////////////////////////////////////////////////////
    // fonction : buildParametrisationDistance                              //
    // semantique : construit la parametrisation sur les distances et les   //
    //              échantillons de temps selon cette parametrisation       //
    // params :                                                             //
    //          - int nbElem : nombre d'elements de la parametrisation      //
    //          - float pas : pas d'échantillonage                          //
    // sortie :                                                             //
    //          - List<float> T : parametrisation distances                 //
    //          - List<float> tToEval : echantillon sur la parametrisation  //
    //////////////////////////////////////////////////////////////////////////
    (List<float>, List<float>) buildParametrisationDistance(int nbElem, float pas)
    {
        // Vecteur des pas temporels
        List<float> T = new List<float>();
        // Echantillonage des pas temporels
        List<float> tToEval = new List<float>();

        // Construction des pas temporels
        T.Add(0.0f);
        for (int k = 1; k<nbElem; k++)
        {
            float distance = (float) Math.Sqrt((X[k]-X[k-1])*(X[k]-X[k-1])+(Y[k]-Y[k-1])*(Y[k]-Y[k-1]));
            T.Add(T[k-1] + distance);
        }

        // Construction des échantillons
	float min = T.Min();
        float max = T.Max();
        int i = 0;
        
        while ((min+i*pas)<=max)
	{
	    tToEval.Add(min+i*pas);
	    i++;
	}

        return (T, tToEval);
    }

    ////////////////////////////////////////////////////////////////////////////
    // fonction : buildParametrisationRacineDistance                          //
    // semantique : construit la parametrisation sur les racines des distances//
    //              et les échantillons de temps selon cette parametrisation  //
    // params :                                                               //
    //          - int nbElem : nombre d'elements de la parametrisation        //
    //          - float pas : pas d'échantillonage                            //
    // sortie :                                                               //
    //          - List<float> T : parametrisation racines distances           //
    //          - List<float> tToEval : echantillon sur la parametrisation    //
    ////////////////////////////////////////////////////////////////////////////
    (List<float>, List<float>) buildParametrisationRacineDistance(int nbElem, float pas)
    {
        // Vecteur des pas temporels
        List<float> T = new List<float>();
        // Echantillonage des pas temporels
        List<float> tToEval = new List<float>();

        // Construction des pas temporels
        T.Add(0.0f);
        for (int k = 1; k<nbElem; k++)
        {
            float distance = (float) Math.Sqrt(Math.Sqrt((X[k]-X[k-1])*(X[k]-X[k-1])+(Y[k]-Y[k-1])*(Y[k]-Y[k-1])));
            T.Add(T[k-1] + distance);
        }

        // Construction des échantillons
        float min = T.Min();
        float max = T.Max();
        int i = 0;
        
        while ((min+i*pas)<=max)
	{
	    tToEval.Add(min+i*pas);
	    i++;
	}

        return (T, tToEval);
    }

    //////////////////////////////////////////////////////////////////////////
    // fonction : buildParametrisationTchebycheff                           //
    // semantique : construit la parametrisation basée sur Tchebycheff      //
    //              et les échantillons de temps selon cette parametrisation//
    // params :                                                             //
    //          - int nbElem : nombre d'elements de la parametrisation      //
    //          - float pas : pas d'échantillonage                          //
    // sortie :                                                             //
    //          - List<float> T : parametrisation Tchebycheff               //
    //          - List<float> tToEval : echantillon sur la parametrisation  //
    //////////////////////////////////////////////////////////////////////////
    (List<float>, List<float>) buildParametrisationTchebycheff(int nbElem, float pas)
    {
        // Vecteur des pas temporels
        List<float> T = new List<float>();
        // Echantillonage des pas temporels
        List<float> tToEval = new List<float>();

        // Construction des pas temporels
        for (int k = 0; k<nbElem; k++)
        {
            float t = (float) Math.Cos(((2*k+1)*Math.PI)/(2*nbElem+2));
            T.Add(t);
        }

        // Construction des échantillons
        float min = T.Min();
        float max = T.Max();
        int i = 0;
        
        while ((min+i*pas)<=max)
	{
	    tToEval.Add(min+i*pas);
	    i++;
	}

        return (T, tToEval);
    }

    //////////////////////////////////////////////////////////////////////////
    // fonction : applyLagrangeParametrisation                              //
    // semantique : applique la subdivion de Lagrange aux points (x,y)      //
    //              placés en paramètres en suivant les temps indiqués      //
    // params :                                                             //
    //          - List<float> X : liste des abscisses des points            //
    //          - List<float> Y : liste des ordonnées des points            //
    //          - List<float> T : temps de la parametrisation               //
    //          - List<float> tToEval : échantillon des temps sur T         //
    // sortie : rien                                                        //
    //////////////////////////////////////////////////////////////////////////
    void applyLagrangeParametrisation(List<float> X, List<float> Y, List<float> T, List<float> tToEval)
    {
        for (int i = 0; i < tToEval.Count; ++i)
        {
            // Calcul de xpoint et ypoint
            float t = tToEval[i];
            float xpoint = lagrange(t, T, X);
            float ypoint = lagrange(t, T, Y);
            Vector3 pos = new Vector3(xpoint, 0.0f, ypoint);
            P2DRAW.Add(pos);
        }
    }

    //////////////////////////////////////////////////////////////////////////
    // fonction : applyNevilleParametrisation                               //
    // semantique : applique la subdivion de Neville aux points (x,y)       //
    //              placés en paramètres en suivant les temps indiqués      //
    // params :                                                             //
    //          - List<float> X : liste des abscisses des points            //
    //          - List<float> Y : liste des ordonnées des points            //
    //          - List<float> T : temps de la parametrisation               //
    //          - List<float> tToEval : échantillon des temps sur T         //
    // sortie : rien                                                        //
    //////////////////////////////////////////////////////////////////////////
    void applyNevilleParametrisation(List<float> X, List<float> Y, List<float> T, List<float> tToEval)
    {
        for (int i = 0; i < tToEval.Count; ++i)
        {
            // Appliquer neville a l'echantillon i
            // TODO !!
            Vector2 v = neville(X, Y, T, tToEval[i]);
            Vector3 pos = new Vector3(v[0], 0.0f, v[1]);
            P2DRAW.Add(pos);
        }
    }

    //////////////////////////////////////////////////////////////////////////
    // fonction : lagrange                                                  //
    // semantique : calcule la valeur en x du polynome de Lagrange passant  //
    //              par les points de coordonnées (X,Y)                     //
    // params :                                                             //
    //          - float x : point dont on cherche l'ordonnée                //
    //          - List<float> X : liste des abscisses des points            //
    //          - List<float> Y : liste des ordonnées des points            //
    // sortie : valeur en x du polynome de Lagrange passant                 //
    //          par les points de coordonnées (X,Y)                         //
    //////////////////////////////////////////////////////////////////////////
    private float lagrange(float x, List<float> X, List<float> Y)
    {
        float y = 0.0f;
        for (int i=0; i<X.Count; i++)
        {
            float numerateur = 1.0f;
            float denominateur = 1.0f;
            for (int k = 0; k<X.Count; k++)
            {
                if (i != k)
                {
                    numerateur = numerateur * (x - X[k]);
                    denominateur = denominateur * (X[i] - X[k]);
                }
            }
            y = y + (numerateur / denominateur) * Y[i];
        }
        return y;
    }

    //////////////////////////////////////////////////////////////////////////
    // fonction : neville                                                   //
    // semantique : calcule le point atteint par la courbe en t sachant     //
    //              qu'elle passe par les (X,Y) en T                        //
    // params :                                                             //
    //          - List<float> X : liste des abscisses des points            //
    //          - List<float> Y : liste des ordonnées des points            //
    //          - List<float> T : liste des temps de la parametrisation         //
    //          - t : temps ou on cherche le point de la courbe             //
    // sortie : point atteint en t de la courbe                             //
    //////////////////////////////////////////////////////////////////////////
    private Vector2 neville(List<float> X, List<float> Y, List<float> T, float t)
    {
        // TODO !!
        List<float> Xi = new List<float>();
        List<float> Yi = new List<float>();

        for (int i = 0; i < X.Count; i++)
        {
            Xi.Add(X[i]);
            Yi.Add(Y[i]);
        }
        
        for (int j=1; j<X.Count; j++) 
        {
            for (int k=0; k<X.Count-j;k++)
            {
                Xi[k] = (T[k + j] - t) / (T[k + j] - T[k]) * Xi[k] + (t - T[k]) / (T[k + j] - T[k]) * Xi[k + 1];
                Yi[k] = (T[k + j] - t) / (T[k + j] - T[k]) * Yi[k] + (t - T[k]) / (T[k + j] - T[k]) * Yi[k + 1];
            
            }
        }
        return new Vector2(Xi[0],Yi[0]);
    }

    //////////////////////////////////////////////////////////////////////////
    //////////////////////// NE PAS TOUCHER !!! //////////////////////////////
    //////////////////////////////////////////////////////////////////////////
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Return))
        {
            var ListePointsCliques = GameObject.Find("Donnees").GetComponent<Points>();
            List<float> T = new List<float>();
            List<float> tToEval = new List<float>();

            if (ListePointsCliques.X.Count > 0)
            {
                X = ListePointsCliques.X;
                Y = ListePointsCliques.Y;

                if (InterpolationType == EInterpolationType.Lagrange)
                {
                    switch (ParametrisationType)
                    {
                        case EParametrisationType.None:
                            List<float> x = new List<float>();
                            List<float> y = new List<float>();
                            var xmax = 10.0f;
                            var xcur = -10.0f;
                            while(xcur < xmax) {
                                xcur+=pas;
                                x.Add(xcur);
                            }
                            for (int i = 0; i < x.Count; i++)
                            {
                                y.Add(lagrange(x[i], X, Y));
                            }

                            for (int i = 0; i < x.Count; ++i)
                            {
                                Vector3 pos = new Vector3(x[i], 0.0f, y[i]);
                                P2DRAW.Add(pos);
                            }
                            break;
                        case EParametrisationType.Reguliere:
                            (T, tToEval) = buildParametrisationReguliere(X.Count, pas);
                            applyLagrangeParametrisation(X, Y, T, tToEval);
                            break;
                        case EParametrisationType.Distance:
                            (T, tToEval) = buildParametrisationDistance(X.Count, pas);
                            applyLagrangeParametrisation(X, Y, T, tToEval);
                            break;
                        case EParametrisationType.RacineDistance:
                            (T, tToEval) = buildParametrisationRacineDistance(X.Count, pas);
                            applyLagrangeParametrisation(X, Y, T, tToEval);
                            break;
                        case EParametrisationType.Tchebytcheff:
                            (T, tToEval) = buildParametrisationTchebycheff(X.Count, pas);
                            applyLagrangeParametrisation(X, Y, T, tToEval);
                            break;
                    }

                } else if (InterpolationType == EInterpolationType.Neville) {

                    switch (ParametrisationType)
                    {
                        case EParametrisationType.Reguliere:
                            (T, tToEval) = buildParametrisationReguliere(X.Count, pas);
                            applyNevilleParametrisation(X, Y, T, tToEval);
                            break;
                        case EParametrisationType.Distance:
                            (T, tToEval) = buildParametrisationDistance(X.Count, pas);
                            applyNevilleParametrisation(X, Y, T, tToEval);
                            break;
                        case EParametrisationType.RacineDistance:
                            (T, tToEval) = buildParametrisationRacineDistance(X.Count, pas);
                            applyNevilleParametrisation(X, Y, T, tToEval);
                            break;
                        case EParametrisationType.Tchebytcheff:
                            (T, tToEval) = buildParametrisationTchebycheff(X.Count, pas);
                            applyNevilleParametrisation(X, Y, T, tToEval);
                            break;
                        case EParametrisationType.None:
                            text.text = "Vous devez choisir un type de parametrisation pour utiliser Neville";
                            break;
                    }
                }
            }
          }
    }

    //////////////////////////////////////////////////////////////////////////
    //////////////////////// NE PAS TOUCHER !!! //////////////////////////////
    //////////////////////////////////////////////////////////////////////////
    void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.blue;
        for(int i = 0; i < P2DRAW.Count - 1; ++i)
        {
            Gizmos.DrawLine(P2DRAW[i], P2DRAW[i+1]);

        }
    }
}
