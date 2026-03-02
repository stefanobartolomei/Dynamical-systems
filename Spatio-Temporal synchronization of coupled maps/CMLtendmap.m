rng shuffle

L = 1024; % spatial size
T = 500; % temporal size
epsilon = 2/3; % diffusive coupling per replica

% gamma_critic = 1/2 (1 - exp(-lambda))
% for tend map: lambda = log(2) ---> gamma_critico = 0.25
% gamma_critico estimates 0.17605
gamma = 0.18; % coupling strength between replicas

x = [rand(L,1) zeros(L,T-1)];
y = [rand(L,1) zeros(L,T-1)];
W = [abs(x(:,1) - y(:,1)) zeros(L,T-1)]; % synchronization error
p = [mean(W(:,1)) ; zeros(T-1,1)]; % spatio average of synchronization error

for t = 1:T-1
    
    % case i = 1 (periodic boundary)
    aux = (1 - epsilon)*x(1,t) + epsilon*0.5*(x(2,t) + x(L,t));
    auy = (1 - epsilon)*y(1,t) + epsilon*0.5*(y(2,t) + y(L,t));
        
    x(1,t+1) = (1 - gamma)*f(aux) + gamma*f(auy);
    y(1,t+1) = (1 - gamma)*f(auy) + gamma*f(aux);
        
    W(1,t+1) = abs(x(1,t+1) - y(1,t+1)); 
    for i = 2:L-1
        aux = (1 - epsilon)*x(i,t) + epsilon*0.5*(x(i+1,t) + x(i-1,t));
        auy = (1 - epsilon)*y(i,t) + epsilon*0.5*(y(i+1,t) + y(i-1,t));
        
        x(i,t+1) = (1 - gamma)*f(aux) + gamma*f(auy);
        y(i,t+1) = (1 - gamma)*f(auy) + gamma*f(aux);
        
        W(i,t+1) = abs(x(i,t+1) - y(i,t+1));
    end
    % case i = L (periodic boundary)
    aux = (1 - epsilon)*x(L,t) + epsilon*0.5*(x(1,t) + x(L-1,t));
    auy = (1 - epsilon)*y(L,t) + epsilon*0.5*(y(1,t) + y(L-1,t));
        
    x(L,t+1) = (1 - gamma)*f(aux) + gamma*f(auy);
    y(L,t+1) = (1 - gamma)*f(auy) + gamma*f(aux);

    W(L,t+1) = abs(x(i,t+1) - y(i,t+1));
    
    p(t+1) = mean(W(:,t+1));
end

figure
contourf(transpose(W))
colorbar('southoutside')
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
% tend map
function znew = f(z)
if z >= 0.5
    znew = 3 - 2*z;
else
    znew = 1 + 2*z;
end
end