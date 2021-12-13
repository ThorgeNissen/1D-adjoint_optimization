function D2 = D2_4Ord_periodic(N,h)

    tmp     = ones(N,1);
    coeffs  = [-1, 16, -30];
    D2      = spdiags([tmp*coeffs(1), tmp*coeffs(2), tmp*coeffs(3), tmp*coeffs(2), tmp*coeffs(1)], -2:2, N,N)/(12*h^2);

    % periodic boundary conditions
    D2(1:2,end-1:end)    = [coeffs(1:2); 0, coeffs(1)]/(12*h^2);
    D2(end-1:end,1:2)    = [coeffs(1), 0; coeffs(2), coeffs(1)]/(12*h^2);
    
end