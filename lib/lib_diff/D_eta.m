function q_eta = D_eta(q, params)

    D_eta = params.geom.D_eta; 
    
    % reshape von Feld zu Vektor -> Ableitung -> reshape von Vektor zu Feld
    q_rs        = reshape(q,params.geom.Neta * params.geom.Nxi,1);
    q_eta_rs    = D_eta*q_rs;
    q_eta       = reshape(q_eta_rs,params.geom.Nxi,params.geom.Neta);

end