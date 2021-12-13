function [params, Q, Qs] = calc_adjointField(params, Q)

    helper_x    = (1.15*[-params.opt.geom.width,params.opt.geom.width] + params.opt.geom.xi) * params.geom.L_xi;
    helper_y    = [-1000,10000];

    for i=1:params.opt.loop
        [params, qs0]           = init_adjoint(params);
        [params, Qs]            = calc_adjoint(params, qs0, Q);
        
        % adjust source field
        params.opt.s    = params.opt.s + Qs * params.opt.alpha;
        
        [params, q0]        = init_direct(params);
        [params, Q]         = calc_direct(params,q0);
        params.opt.J(i+1)   = params.opt.objective_fun(Q, params.opt.q_ref);
        
        if i==1 | mod(i,5)==0
            figure(3)
            subplot(2,2,1)
            pcolor(Q')
            hold on
            colormap('parula')
            shading flat
            colorbar
            title(['Direct solution of: ',params.base.case])
            subtitle(['Objetive value: J=',num2str(params.opt.J(i+1))])
            xlabel('xi')
            ylabel('iterations')
            plot([helper_x(1),helper_x(1)]/params.geom.L_xi*params.geom.N_xi,[helper_y(1),helper_y(2)],'k')
            plot([helper_x(2),helper_x(2)]/params.geom.L_xi*params.geom.N_xi,[helper_y(1),helper_y(2)],'k')
            hold off

            subplot(2,2,2)
            pcolor(Qs')
            hold on
            colormap('parula')
            shading flat
            colorbar
            title(['Adjoint solution of',params.base.case])
            xlabel('xi')
            ylabel('iterations')
            plot([helper_x(1),helper_x(1)]/params.geom.L_xi*params.geom.N_xi,[helper_y(1),helper_y(2)],'k')
            plot([helper_x(2),helper_x(2)]/params.geom.L_xi*params.geom.N_xi,[helper_y(1),helper_y(2)],'k')
            hold off

            subplot(2,2,3)
            plot(params.geom.xi, Q(:,params.time.iterations))
            hold on
            plot([helper_x(1),helper_x(1)],[helper_y(1),helper_y(2)],'k')
            plot([helper_x(2),helper_x(2)],[helper_y(1),helper_y(2)],'k')
            title(['Solution at last iteration (',num2str(params.time.iterations),')'])
            subtitle(['Objetive value: J=',num2str(params.opt.J(1))])
            xlabel('xi')
            ylabel('q')
            ylim([0,params.init.q0+5])
            xlim([0,params.geom.L_xi])
            yyaxis right
            ylim([min(Qs(:,1)),max(Qs(:,1))*1.25])
            plot(params.geom.xi,Qs(:,1))
            ylabel('qs')
            hold off

            subplot(2,2,4)
            pcolor(flip(Qs'))
            hold on
            colormap('parula')
            shading flat
            colorbar
            title(['Actual temporal development of adjoint solution of' ,params.base.case])
            xlabel('xi')
            ylabel('iterations')
            plot([helper_x(1),helper_x(1)]/params.geom.L_xi*params.geom.N_xi,[helper_y(1),helper_y(2)],'k')
            plot([helper_x(2),helper_x(2)]/params.geom.L_xi*params.geom.N_xi,[helper_y(1),helper_y(2)],'k')
            hold off
        end
    end
    
    figure(4)
    plot(params.opt.J)
    title('Convergence of J')
end