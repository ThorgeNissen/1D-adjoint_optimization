function [D] = D_periodicFourthOrd(N,h)
% Expicit Derivate Matrix 4th order, divisor returned 
% 
% N number of Points
% h = Delta x   

alpha2=-1 ;
alpha3= 0 ;
alpha1= 8 ;

D = sparse(alpha1*(diag(ones(N-1,1),1) - diag(ones(N-1,1),-1)) + ...  
           alpha2*(diag(ones(N-2,1),2) - diag(ones(N-2,1),-2)) + ...        
           alpha3*(diag(ones(N-3,1),3) - diag(ones(N-3,1),-3)) ) ;

D(1:2,N-1:end)  = [1, -8; 0, 1];
D(N-1:N,1:2)    = [-1, 0; 8, -1];
 
D = 1/(12*h)*D;

end
