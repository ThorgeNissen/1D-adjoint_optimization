function D1 = D1_2Ord_open(N,h)
    
    D1 = D1_2Ord_periodic(N,h);
    % Use second order right-sided stencil for left bdry and 
    D1(1,1:3)   = [-3/2, 2, -0.5]/h;
    % Use second order left-sided stencil for right bdry and 
    D1(end,end-2:end)   = [0.5, -2, 3/2]/h;
    
    % Overrite periodic boundary
    D1(1,end)            = 0;
    D1(end,1)            = 0;
    
end