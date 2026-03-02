rng shuffle

L = 1024; % spatial size
T = 250; % temporal size
epsilon = 2/3; % diffusive coupling per replica

% gamma_critic = 1/2 (1 - exp(-lambda))
% for Bernoulli map: lambda = log(2) ---> gamma_critico = 0.25
% gamma_critico estimates 0.28752
gamma = 0.3; % coupling strength between replicas

x = [rand(L,1) zeros(L,T-1)];
y = [rand(L,1) zeros(L,T-1)];

f = @(z) mod(2*z,1); % Bernoulli map

for t = 1:T-1
    
    % case i = 1 (periodic boundary)
    aux = (1 - epsilon)*x(1,t) + epsilon*0.5*(x(2,t) + x(L,t));
    auy = (1 - epsilon)*y(1,t) + epsilon*0.5*(y(2,t) + y(L,t));
        
    x(1,t+1) = (1 - gamma)*f(aux) + gamma*f(auy);
    y(1,t+1) = (1 - gamma)*f(auy) + gamma*f(aux);
    
    for i = 2:L-1
        aux = (1 - epsilon)*x(i,t) + epsilon*0.5*(x(i+1,t) + x(i-1,t));
        auy = (1 - epsilon)*y(i,t) + epsilon*0.5*(y(i+1,t) + y(i-1,t));
        
        x(i,t+1) = (1 - gamma)*f(aux) + gamma*f(auy);
        y(i,t+1) = (1 - gamma)*f(auy) + gamma*f(aux);
    end
    % case i = L (periodic boundary)
    aux = (1 - epsilon)*x(L,t) + epsilon*0.5*(x(1,t) + x(L-1,t));
    auy = (1 - epsilon)*y(L,t) + epsilon*0.5*(y(1,t) + y(L-1,t));
        
    x(L,t+1) = (1 - gamma)*f(aux) + gamma*f(auy);
    y(L,t+1) = (1 - gamma)*f(auy) + gamma*f(aux);
end

Wsincro = abs(x - y); % synchronization error
p = mean(Wsincro); % spatio average of synchronization error

figure
contourf(transpose(Wsincro) > 10^(-4))
colormap([1 0 0
    1 1 0])
c = colorbar('southoutside');
c.Label.String = 'Syncro <--------> No Synchro';
xlabel('Space','interpreter','latex','fontsize',14)
ylabel('Time','interpreter','latex','fontsize',14)

title('SpatioTemporal Evolution of Syncronization Error','interpreter','latex'...
    ,'fontsize',18)

figure
plot(p)
xlabel('Time','interpreter','latex','fontsize',14)
ylabel('$\rho$(t) = $\langle\mathcal{W}_i(t)\rangle$','interpreter','latex','fontsize',14)
title('Spatial Average Syncronization Error','interpreter','latex','fontsize',18)

clear