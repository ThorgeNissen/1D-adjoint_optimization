function rhs = rhs_adjoint_transport_1D(qs, ~, params, q)

    rhs         = zeros(params.geom.N_xi,1);
    g           = (q - params.opt.q_ref) .* params.opt.sigma;

    % Assuming constant sigma over time
    % rhs of adjoint equation
    rhs(:)      = -params.init.u_lambda*D_xi(qs, params) + g;

end