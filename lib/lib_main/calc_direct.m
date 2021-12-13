function [params, Q] = calc_direct(params, q0)

    Q   = zeros(params.geom.N_xi, params.time.iterations,1);


    for iter=1:params.time.iterations
       
        params.opt.iter  = iter;
       
        q_new    = RK4(q0,params.time.dt,iter,params.direct.equation,params);
        q_new(1) = params.init.q0_bc(iter);
        q0       = q_new;

        % save data
        Q(:,iter)     = q_new;

    end
    

end