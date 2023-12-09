@doc doc"""
Tester l'algorithme de pas de cauchy

# Entrées :
   * afficher : (Bool) affichage ou non des résultats de chaque test

# Les cas de test (dans l'ordre)
   * fct 1 : x011,x012
   * fct 2 : x021,x022
"""
function tester_pas_cauchy(afficher::Bool,Pas_De_Cauchy::Function)

    @testset "Cas test 1 : g=0" begin
        g = [0, 0]
        H = [1 2;3 4]
        delta = 4
        s,e = Pas_De_Cauchy(g,H,delta)
        @testset "solution" begin
        @test s == [0, 0]
        end
        @testset "e" begin
        @test e == 0
        end
    end
    @testset "Cas test 2 : g!=0 et H=0" begin
        g = [1, 2]
        H = [0 0;0 0]
        delta = 4
        s,e = Pas_De_Cauchy(g,H,delta)
        @testset "solution" begin
        @test s == -(delta*g)/norm(g)
        end
        @testset "e" begin
        @test e == -1
        end
    end
    @testset "Cas test 3 : g!=0 et H < 0" begin
        g = [1, 2]
        H = [-1 0; 0 -1 ]
        delta = 4
        s,e = Pas_De_Cauchy(g,H,delta)
        @testset "solution" begin
        @test s == -(delta*g)/norm(g)
        end
        @testset "e" begin
        @test e == -1
        end
    end
    @testset "Cas test 4 : g!=0 et H < 0" begin
        g = [1, 2]
        H = [-10 -1;-1 -2]
        delta = 4
        s,e = Pas_De_Cauchy(g,H,delta)
        @testset "solution" begin
        @test s == -(delta*g)/norm(g)
        end
        @testset "e" begin
        @test e == -1
        end
    end
    @testset "Cas test 5 : g!=0 et H > 0 et delta petit" begin
        g = [1, 2]
        H = [1 0; 0 1]
        delta = 1/2
        s,e = Pas_De_Cauchy(g,H,delta)
        @testset "solution" begin
        @test s == -(delta*g)/norm(g)
        end
        @testset "e" begin
        @test e == -1
        end
    end
    @testset "Cas test 6 : g!=0 et H > 0 et delta petit" begin
        g = [1, 2]
        H = [10 1; 1 2]
        delta = 1/2
        s,e = Pas_De_Cauchy(g,H,delta)
        @testset "solution" begin
        @test s == -(delta*g)/norm(g)
        end
        @testset "e" begin
        @test e == -1
        end
    end
    @testset "Cas test 7 : g!=0 et H > 0 et delta grand" begin
        g = [1, 2]
        H = [1 0; 0 1]
        delta = 10
        s,e = Pas_De_Cauchy(g,H,delta)
        @testset "solution" begin
        @test s == -((norm(g)^2)/(g'*H*g))*g
        end
        @testset "e" begin
        @test e == 1
        end
    end
    @testset "Cas test 8 : g!=0 et H > 0 et delta grand" begin
        g = [1, 2]
        H = [10 1; 1 2]
        delta = 10
        s,e = Pas_De_Cauchy(g,H,delta)
        @testset "solution" begin
        @test s == -((norm(g)^2)/(g'*H*g))*g
        end
        @testset "e" begin
        @test e == 1
        end
    end
end
