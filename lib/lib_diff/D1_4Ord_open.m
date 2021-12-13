function D1 = D1_4Ord_open(N,h)

    D1  = D1_4Ord_periodic(N,h);
  
    % Overrite periodic boundary
    D1(1:4,end-3:end)    = zeros(4,4);
    D1(end-3:end,1:4)    = zeros(4,4);
    
    % Use second order right-sided stencil for left bdry
    D1(1:2,1:5)  = [-25 48 -36 16 -3 ; -3 -10 18 -6 1]/(12*h);
    
    % Use second order left-sided stencil for right bdry and 
    D1(end-1:end,end-4:end) = -rot90([-25 48 -36 16 -3 ; -3 -10 18 -6 1]/(12*h),2);
  
end