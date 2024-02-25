function [D,A] = nmf(abs_Y,D_0,A_0,N)

    A = A_0;
    D = D_0;
    eps = 1e-14;
    for i=1:N
        A = A .* (D'*abs_Y) ./ (D'*D*A+eps);
        D = D .* (abs_Y*A') ./ (D*A*A'+eps);
    end

    alpha = norm(D,"inf");
    D = D / alpha;
    A = A * alpha;

end