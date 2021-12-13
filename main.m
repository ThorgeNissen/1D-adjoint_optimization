function main

    %% 
    clear;
    clc;
    close all;
    
    %% Initialize folder structure
    params  = setPath;
    
    %% Initialize simulation
    params = parameter(params);
    
    %% Solve Burgers equation initially
    [params, q0]    = init_direct(params);
    [params, Q]     = calc_direct(params,q0);
    params.opt.J(1) = params.opt.objective_fun(Q, params.opt.q_ref);
    
    %% Plot result of Burgers equation
    figure(1)
    title(params.base.case)
    pcolor(Q')
    colormap('parula')
    shading flat
    colorbar
    title('Direct Solution of 1D Burgers equation')
    subtitle(['Objetive value: J=',num2str(params.opt.J(1))])
    xlabel('xi')
    ylabel('iterations')
    
    figure(2)
    plot(params.geom.xi, Q(:,params.time.iterations))
    title(['Solution at last iteration (',num2str(params.time.iterations),')'])
    subtitle(['Objetive value: J=',num2str(params.opt.J(1))])
    xlabel('xi')
    ylabel('q')
    
    %% Adjoint based optimization
    if params.opt.bool
       [params, Q, Qs]     = calc_adjointField(params, Q); 
    end
    
end