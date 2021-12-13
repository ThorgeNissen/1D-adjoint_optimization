function q_xi = D_xi(q, params)

    D1_xi = params.geom.D1_xi; 
    
    % reshape von Feld zu Vektor -> Ableitung -> reshape von Vektor zu Feld
    q_rs        = reshape(q,params.geom.N_eta * params.geom.N_xi,1);
    q_xi_rs     = D1_xi*q_rs;
    q_xi        = reshape(q_xi_rs,params.geom.N_xi,params.geom.N_eta);

end