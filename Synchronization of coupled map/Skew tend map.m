rng shuffle

T = 5000; % time evolution
p = 0.7; % parameter skew map (for p = 0.5 tend map)

LE = -p*log(p) - (1 - p)*log(1 - p); % LE of skew map
gamma_critico = 0.5*(1 - exp(-LE)); % gamma fro transition to syncro
disp('Critical value:')
disp(gamma_critico)

gamma = 0.22; % fix value
% variables
x = zeros(T,1); 
y = zeros(T,1);

% inizialite variables and simulate
x(1) = rand();
y(1) = rand();
for t = 1:T-1
    x(t+1) = (1 - gamma)*f(x(t),p) + gamma*f(y(t),p);
    y(t+1) = gamma*f(x(t),p) + (1 - gamma)*f(y(t),p);
end

figure
plot(x,y,'.')
hold on
plot(linspace(0,1,100),linspace(0,1,100),'k-')
hold off
xlabel('x','interpreter','latex','fontsize',16)
ylabel('y','interpreter','latex','fontsize',16)
title(['Coupled skew tend map with $p$ = ',num2str(p),' and coupling $\gamma$ = ',num2str(gamma)],...
    'interpreter','latex','fontsize',13)

figure
subplot(2,1,1)
plot(0.5*(x-y))
xlabel('Time','interpreter','latex')
ylabel('$v = \frac{1}{2}(x - y)$','interpreter','latex','fontsize',14)

subplot(2,1,2)
plot(log(abs(0.5*(x-y))))
xlabel('Time','interpreter','latex')
ylabel('$\ln\left|v\right|$','interpreter','latex','fontsize',14)

clear
% skew map
function znew = f(z,p)
if z < p
    znew = z/p;
else
    znew = (1 - z)/(1 - p);
end

end
