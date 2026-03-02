%% ES 12.1.9 Strogatz: Standard Map
% The variables x, y and the governing equations are all to be evaluated
% modulo 2*pi. The nonlinearity parameter k >= 0 is a measure of how hard
% the system is being driven

rng shuffle

N = 1000; % evolution step
S = 50; % number of simulations


for k = [0 1 2 5] % parameter
    
    figure
    title(['Phase-Potrait for Standard Map with $k$ = ',num2str(k)],'Interpreter','latex','FontSize',14)
    xlabel('x-axis','Interpreter','latex','FontSize',12)
    ylabel('y-axis','Interpreter','latex','FontSize',12)
    xlim([0 2*pi])
    ylim([0 2*pi])
    hold on
    grid on
    for s = 0:S
        x = zeros(N,1);
        y = zeros(N,1);
        
        x(1) = 2*pi*s/S;
        y(1) = 2*pi*s/S;
        for i = 1:N-1
            % standard map
            y(i+1) = y(i) + k*sin(x(i));
            y(i+1) = mod(y(i+1),2*pi);
        
            x(i+1) = x(i) + y(i+1);
            x(i+1) = mod(x(i+1),2*pi);
        end
        
        plot(x,y,'.')
        pause(0.1)
        
        clear x y
    end
end
clear