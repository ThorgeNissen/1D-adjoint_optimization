function q_etaeta = D2_eta(q, params)

    D2_eta = params.geom.D2_eta; 
    
    % reshape von Feld zu Vektor -> Ableitung -> reshape von Vektor zu Feld
    q_rs            = reshape(q,params.geom.Neta * params.geom.Nxi,1);
    q_etaeta_rs     = D2_eta*q_rs;
    q_etaeta        = reshape(q_etaeta_rs,params.geom.Nxi,params.geom.Neta);

end