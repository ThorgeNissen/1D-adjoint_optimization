function q_xixi = D2_xi(q, params)

    D2_xi = params.geom.D2_xi; 
    
    % reshape von Feld zu Vektor -> Ableitung -> reshape von Vektor zu Feld
    q_rs        = reshape(q,params.geom.N_eta * params.geom.N_xi,1);
    q_xixi_rs     = D2_xi*q_rs;
    q_xixi        = reshape(q_xixi_rs,params.geom.N_xi,params.geom.N_eta);

end