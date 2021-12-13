function [params] = parameter(params)

    % Base Settings
    % =====================================================================
    switch params.base.case 
        case "1D-Burgers"
            params.direct.equation      = @rhs_burgers_1D;
        case "1D-Transport"
            params.direct.equation      = @rhs_transport_1D;
    end    
    params.direct.bool_fric   = 0;
    if params.direct.bool_fric
        params.direct.epsilon = 5e-2;
    end

    % Geometric settings
    % =====================================================================
    params.geom.L_xi        = 2*pi;
    params.geom.N_xi        = 256;
    params.geom.h_xi        = params.geom.L_xi / params.geom.N_xi;
    params.geom.xi          = linspace(0,params.geom.L_xi, params.geom.N_xi);
    
    params.geom.L_eta       = 1;
    params.geom.N_eta       = 1;
    params.geom.h_eta       = params.geom.L_xi / params.geom.N_xi;
    params.geom.bdry_con    = "compact";
    
    params.geom.order       = 4;
    if params.geom.order == 2
        params.geom.D1_xi       = D1_2Ord_open(params.geom.N_xi, params.geom.h_xi);
        params.geom.D2_xi       = D2_2Ord_open(params.geom.N_xi, params.geom.h_xi);
    elseif params.geom.order == 4
        params.geom.D1_xi       = D1_4Ord_open(params.geom.N_xi, params.geom.h_xi);
        params.geom.D2_xi       = D2_4Ord_open(params.geom.N_xi, params.geom.h_xi);
    end
    params.geom.D1_xi       = kron(speye(params.geom.L_eta), params.geom.D1_xi);
    params.geom.D2_xi       = kron(speye(params.geom.L_eta), params.geom.D2_xi);
    
    if params.geom.L_eta > 1
        if params.geom.order == 2
            params.geom.D1_eta      = D1_2Ord_open(params.geom.N_eta, params.geom.h_eta);
            params.geom.D2_eta      = D2_2Ord_open(params.geom.N_eta, params.geom.h_eta);
        elseif params.geom.order == 4
            params.geom.D1_eta      = D1_4Ord_open(params.geom.N_eta, params.geom.h_eta);
            params.geom.D2_eta      = D2_4Ord_open(params.geom.N_eta, params.geom.h_eta);
        end
        params.geom.D1_eta      = kron(params.geom.D1_eta,speye(params.geom.L_xi));
        params.geom.D2_eta      = kron(params.geom.D2_eta,speye(params.geom.L_xi));
    end
        
    % Time settings
    % =====================================================================
    params.time.iterations  = 1024;
    params.time.dt          = 4e-4;
    
    % Init parameter
    % =====================================================================
    params.init.q0          = 25;
    params.init.q0_fun      = @(q0, len) ones(len,1)*q0;
    %params.init.q0_fun      = @(q0, len) 1+sin(q0)';
    params.init.q0_bc       = ones(params.time.iterations,1)*(params.init.q0);
    %params.init.q0_bc       = linspace(0,20,params.time.iterations)';
    params.init.u_lambda    = 10;
    
    % Optimization
    % =====================================================================
    params.opt.bool         = 1;
    switch params.base.case 
        case "1D-Burgers"
            params.opt.equation      = @rhs_adjoint_burgers_1D;
        case "1D-Transport"
            params.opt.equation      = @rhs_adjoint_transport_1D;
    end
    params.opt.loop             = 50;
    
    % initial source function
    params.opt.s                = zeros(params.geom.N_xi, params.time.iterations,1);
    params.opt.q_ref            = params.init.q0_fun(params.init.q0, params.geom.N_xi) + 1;
    params.opt.qs_bc            = zeros(params.time.iterations,1)*(params.init.q0);
    params.opt.objective_fun    = @(Q, q_ref) trapz((1:params.time.iterations)*params.time.dt,trapz(params.geom.xi,(Q-q_ref).^2));
    params.opt.J                = zeros(params.opt.loop+1,1);
    
    
    % area of optimization
    params.opt.geom.xi          = 0.75; % percentage of domain length
    params.opt.geom.width       = 0.05; % * params.geom.L_xi
    params.opt.geom.smoothing   = 1.5;
    params.opt.sigma            = 1-0.5*(1 + tanh((abs(params.geom.xi'-params.opt.geom.xi*params.geom.L_xi)-params.opt.geom.width*params.geom.L_xi)/(params.opt.geom.smoothing*params.geom.h_xi)));

    plot(params.geom.xi, params.opt.sigma)
    title('sigma')
    params.opt.alpha            = 2e1;
end