%% CML 2+1 with discountinous map (Bernoulli map)
% the critical behave at the transition to Synchro (ST) for CML is related to 
% the behave to the absorbe state for DP phenomena (universality class)
% which is charachterize by the three indipendent exponents:
% first (theta), second (beta) critical exponents, dinamical exponent (zeta)

% For DP: theta = 0.451, beta = 0.584, zeta = 1.77

%% Numerical analysis for these parameters for CML with Bernoulli map.
rng shuffle

L = 1024; % spatial size
T = 10^4; % temporal size
epsilon = 2/3; % diffusive coupling per replica

gamma = (0.280:0.001:0.290)'; % coupling strength between replicas
rho = zeros(T,size(gamma,1)); % spatio average of synchronization error

f = @(z) mod(2*z,1); % Bernoulli map

for k = 1:size(gamma,1)
    
    % variables
    x = [rand(L,1) zeros(L,T-1)];
    y = [rand(L,1) zeros(L,T-1)];
    
    for t = 1:T-1

        % caso i = 1 (periodic boundary)
        aux = (1 - epsilon)*x(1,t) + epsilon*0.5*(x(2,t) + x(L,t));
        auy = (1 - epsilon)*y(1,t) + epsilon*0.5*(y(2,t) + y(L,t));

        x(1,t+1) = (1 - gamma(k))*f(aux) + gamma(k)*f(auy);
        y(1,t+1) = (1 - gamma(k))*f(auy) + gamma(k)*f(aux);

        for i = 2:L-1
            aux = (1 - epsilon)*x(i,t) + epsilon*0.5*(x(i+1,t) + x(i-1,t));
            auy = (1 - epsilon)*y(i,t) + epsilon*0.5*(y(i+1,t) + y(i-1,t));

            x(i,t+1) = (1 - gamma(k))*f(aux) + gamma(k)*f(auy);
            y(i,t+1) = (1 - gamma(k))*f(auy) + gamma(k)*f(aux);
        end
        % caso i = L (periodic boundary)
        aux = (1 - epsilon)*x(L,t) + epsilon*0.5*(x(1,t) + x(L-1,t));
        auy = (1 - epsilon)*y(L,t) + epsilon*0.5*(y(1,t) + y(L-1,t));

        x(L,t+1) = (1 - gamma(k))*f(aux) + gamma(k)*f(auy);
        y(L,t+1) = (1 - gamma(k))*f(auy) + gamma(k)*f(aux);
    end

    Wsincro = abs(x - y); % synchronization error
    rho(:,k) = mean(Wsincro)'; 
end

figure
loglog(rho(10^3:end,:))

clear