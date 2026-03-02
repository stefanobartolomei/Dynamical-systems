rng shuffle

T = 1000; % time evolution
f = @(z) mod(2*z,1); % Bernoulli map

lambda = log(2); % LE of Bernoulli map
gamma_critico = 0.5*(1 - exp(-lambda)); % gamma fro transition to syncro
disp(gamma_critico) % expected gamma critico (not numerical result)

gamma = 0.26; % fix value
% variables
x = zeros(T,1); 
y = zeros(T,1);

% inizialite varaibles and simulate
x(1) = rand();
y(1) = rand();
for t = 1:T-1
    x(t+1) = (1 - gamma)*f(x(t)) + gamma*f(y(t));
    y(t+1) = gamma*f(x(t)) + (1 - gamma)*f(y(t));
end

figure
plot(x,y,'.')
hold on
plot(linspace(0,1,100),linspace(0,1,100),'k-')
hold off
xlabel('x','interpreter','latex','fontsize',16)
ylabel('y','interpreter','latex','fontsize',16)
title(['Coupled Bernoulli map with coupling $\gamma$ = ',num2str(gamma)],...
    'interpreter','latex','fontsize',14)

figure
subplot(2,1,1)
plot(0.5*(x-y))
ylabel('$v = \frac{1}{2}(x - y)$','interpreter','latex','fontsize',14)

subplot(2,1,2)
plot(log(abs(0.5*(x-y))))
xlabel('Time','interpreter','latex')
ylabel('$\ln\left|v\right|$','interpreter','latex','fontsize',14)

clear