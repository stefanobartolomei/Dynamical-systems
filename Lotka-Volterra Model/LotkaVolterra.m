%% LOTKA-VOLTERRA model

rng shuffle

% parameters
K1 = 0.2; % rate of growth for prey
K2 = 0.3; % rate of extinction for predators

T = 5000; % time of numerical simulation
dt = 0.01; % step

% functions in ODE
f = @(x_1,x_2) K1*x_1*(1 - x_2);
g = @(x_1,x_2) -K2*x_2*(1 - x_1);

% vector space
campo_LotkaVolterra(K1,K2)

N = 5; % number of scenarios

% numerical simulation
for i = 1:N
    x = zeros(1,T);
    y = zeros(1,T);
    
    % initial condition
    x(1) = randi(2) + rand();
    y(1) = randi(2) + rand();
    plot(x(1),y(1),'ko') % plot initial point
    
    % Runge-Kutta IV order
    for t = 1:(T-1)
        x1 = f(x(t),y(t))*dt;
        y1 = g(x(t),y(t))*dt;

        x2 = f(x(t)+0.5*x1,y(t)+0.5*y1)*dt;
        y2 = g(x(t)+0.5*x1,y(t)+0.5*y1)*dt;

        x3 = f(x(t)+0.5*x2,y(t)+0.5*y2)*dt;
        y3 = g(x(t)+0.5*x2,y(t)+0.5*y2)*dt;

        x4 = f(x(t)+x3,y(t)+y3)*dt;
        y4 = g(x(t)+x3,y(t)+y3)*dt;

        x(t+1) = x(t) + (1/6)*(x1+2*x2+2*x3+x4);
        y(t+1) = y(t) + (1/6)*(y1+2*y2+2*y3+y4);
    end
    plot(x,y) % plot trajectory
    
    if i == N
        X = x;
        Y = y;
    end
    
    clear x y
end
title('Lotka-Volterra phase space','interpreter','latex','fontsize',18)
xlabel('prey population','interpreter','latex','fontsize',14)
ylabel('predator population','interpreter','latex','fontsize',14)
hold off

figure
plot(linspace(0,10,T),X,'k')
hold on
plot(linspace(0,10,T),Y,'k--')
title('Behavior in prey-predator population','interpreter','latex','fontsize',18)
xlabel('Time','interpreter','latex','fontsize',14)
ylabel('Population','interpreter','latex','fontsize',14)
legend('Prey','Predator','interpret','latex')


clear
