function u1 =RK4(u0,dt, t,rhs, params)
% Runge Kutta 4. Ordnung

% die vier Aufrufe der rechten Seiten; 
% egal, ob rhs zahl, vektor  oder vektoren=matrix zurueckgibt: 
% solange Dimension u entspricht geht alles glatt.  
 
k1=rhs(u0          , t     , params);
k2=rhs(u0+dt/2* k1 , t+dt/2, params);
k3=rhs(u0+dt/2* k2 , t+dt/2, params);
k4=rhs(u0+dt* k3   , t+dt  , params);



u1 = u0+dt/6 * (k1 + 2*k2 +2*k3+k4) ;

end