function qs1 = RK4_adjoint(qs0, dt, t, rhs, params, q)

    k1=rhs(qs0          , t     , params, q);
    k2=rhs(qs0+dt/2* k1 , t+dt/2, params, q);
    k3=rhs(qs0+dt/2* k2 , t+dt/2, params, q);
    k4=rhs(qs0+dt* k3   , t+dt  , params, q);

    qs1 = qs0+dt/6 * (k1 + 2*k2 +2*k3+k4) ;
    
end