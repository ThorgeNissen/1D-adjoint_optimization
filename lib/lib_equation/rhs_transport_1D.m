function rhs = rhs_transport_1D(q, ~, params)
    
    rhs         = zeros(params.geom.N_xi,1);   
    u_lambda    = params.init.u_lambda;
    % right hande side
    if (~params.direct.bool_fric)
        rhs(:)    = -u_lambda*D_xi(q,params) + params.opt.s(:,params.opt.iter);
    else
        eps         = params.direct.epsilon;
        rhs(:)      = -u_lambda.*D_xi(q,params) + eps*D2_xi(q,params) + params.opt.s(:,params.opt.iter);
    end
    
    
end