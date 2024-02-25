function [xk_1,yk_1] = iteration(xk,yk,Fx,Fy,gamma,A)

    i = sub2ind(size(Fx),round(yk),round(xk));

    Bx = - gamma * Fx(i);
    xk_1 = A*xk + Bx;

    By = - gamma * Fy(i);
    yk_1 = A*yk + By;
end