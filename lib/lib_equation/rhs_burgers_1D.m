function rhs = rhs_burgers_1D(q, ~, params)
    
    rhs         = zeros(params.geom.N_xi,1);   
    % right hande side
    if (~params.direct.bool_fric)
        rhs(:)    = -q.*D_xi(q,params) + params.opt.s(:,params.opt.iter);
    else
        eps         = params.direct.epsilon;
        rhs(:)      = -q.*D_xi(q,params) + eps*D2_xi(q,params) + params.opt.s(:,params.opt.iter);
    end
    
    
end