@doc doc"""
#### Objet
Cette fonction calcule une solution approchée du problème

```math
\min_{||s||< \Delta}  q(s) = s^{t} g + \frac{1}{2} s^{t}Hs
```

par l'algorithme du gradient conjugué tronqué

#### Syntaxe
```julia
s = Gradient_Conjugue_Tronque(g,H,option)
```

#### Entrées :   
   - g : (Array{Float,1}) un vecteur de ``\mathbb{R}^n``
   - H : (Array{Float,2}) une matrice symétrique de ``\mathbb{R}^{n\times n}``
   - options          : (Array{Float,1})
      - delta    : le rayon de la région de confiance
      - max_iter : le nombre maximal d'iterations
      - tol      : la tolérance pour la condition d'arrêt sur le gradient

#### Sorties:
   - s : (Array{Float,1}) le pas s qui approche la solution du problème : ``min_{||s||< \Delta} q(s)``

#### Exemple d'appel:
```julia
gradf(x)=[-400*x[1]*(x[2]-x[1]^2)-2*(1-x[1]) ; 200*(x[2]-x[1]^2)]
hessf(x)=[-400*(x[2]-3*x[1]^2)+2  -400*x[1];-400*x[1]  200]
xk = [1; 0]
options = []
s = Gradient_Conjugue_Tronque(gradf(xk),hessf(xk),options)
```
"""
function Gradient_Conjugue_Tronque(g,H,options)

    "# Si option est vide on initialise les 3 paramètres par défaut"
    if options == []
        delta = 2
        max_iter = 100
        tol = 1e-6
    else
        delta = options[1]
        max_iter = options[2]
        tol = options[3]
    end
    
    n = length(g)
    j = 0
    gj = g
    gj_1 = g
    g0 = g
    s = zeros(n)
    p = -g
    while (j<2*n) && norm(gj) > norm(g0)*tol
        k = p' * H * p
        if k <= 0
            a = (norm(p)^2)
            b = (s'*p+p'*s)
            c = (norm(s)^2-delta^2)
            delta_equa = b^2 - 4 * a * c
            sigma1 = (-b+sqrt(delta_equa))/(2*a)
            sigma2 = (-b-sqrt(delta_equa))/(2*a)

            q(y) = g'*y+(1/2)*y'*H*y
            if q(s + sigma1 * p)<q(s + sigma2 * p)
                sigma = sigma1
            else
                sigma = sigma2
            end 
            s = s + sigma * p
            break
        end
        alpha = (gj' * gj) / k
        if norm(s+alpha*p)>=delta
            a = (norm(p)^2)
            b = (s'*p+p'*s)
            c = (norm(s)^2-delta^2)
            delta_equa = b^2 - 4 * a * c
            sigma1 = (-b+sqrt(delta_equa))/(2*a)
            sigma2 = (-b-sqrt(delta_equa))/(2*a)

            if sigma1>0
                sigma = sigma1
            elseif sigma2>0
                sigma = sigma2
            end 
            s = s + sigma * p
            break
        end
        s = s + alpha * p
        gj_1 = gj + alpha * H * p
        beta = (gj_1' * gj_1) / (gj' * gj)
        p = -gj_1 + beta * p
        j = j + 1
        gj = gj_1
    end

   
    return s
end
