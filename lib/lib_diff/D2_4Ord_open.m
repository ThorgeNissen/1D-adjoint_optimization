function D2 = D2_4Ord_open(N,h)

    D2  = D2_4Ord_periodic(N,h);
   
    % Overrite periodic boundary
    D2(1:4,end-3:end)    = zeros(4,4);
    D2(end-3:end,1:4)    = zeros(4,4);
       
    % Use second order right-sided stencil for left bdry
    D2(1:2,1:6)  = [45, -154, 214, -156, 61, -10; 10, -15, -4, 14, -6, 1]/(12*h^2);
    
    % Use second order left-sided stencil for right bdry and 
    D2(end-1:end,end-5:end) = rot90([45, -154, 214, -156, 61, -10; 10, -15, -4, 14, -6, 1]/(12*h^2),2);
    
end