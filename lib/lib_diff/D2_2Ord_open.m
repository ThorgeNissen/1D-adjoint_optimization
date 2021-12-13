function D2 = D2_2Ord_open(N,h)
    
    D2 = D2_2Ord_periodic(N,h);
    % Use second order right-sided for left bdry and 
    D2(1,1:4)   = [2, -5, 4, -1]/(h^2);
    % Use second order left-sided for right bdry and 
    D2(end,end-3:end) = [-1, 4, -5, 2]/(h^2);

end