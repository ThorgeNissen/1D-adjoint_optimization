function [params, q0] = init_direct(params)
    
    % Initilization
    q0  = params.init.q0_fun(params.init.q0, params.geom.N_xi);
    
    CFL = max([params.init.q0, params.init.q0_bc'])*params.time.dt/params.geom.h_xi;
    display(["CFL = ",num2str(CFL)])
    params.time.CFL = CFL;
    if CFL >= 0.75
        display(["WARNING: CFL > 0.75"])
    end

end