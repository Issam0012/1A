function [F_h, F_p] = HPSS(S)

    n1 = 30;
    F_h = medfilt2(S, [1 n1]);

    n2 = 30;
    F_p = medfilt2(S, [n2 1]);

end