function [params, Qs] = calc_adjoint(params, qs0, Q)

    Qs  = zeros(params.geom.N_xi, params.time.iterations,1);

    for iter=params.time.iterations:-1:1
      
        q           = Q(:,iter);
        qs_new      = RK4_adjoint(qs0, -params.time.dt, iter, params.opt.equation, params, q);
        qs_new(end)  = params.opt.qs_bc(iter);
        qs0         = qs_new;
        
        % save source terms
        Qs(:,iter)  = qs_new;
    end


end