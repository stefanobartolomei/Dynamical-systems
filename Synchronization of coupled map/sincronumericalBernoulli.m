rng shuffle

T = 100; % time evolution
a = 2; % parameter
f = @(z) mod(a*z,1); % Bernoulli map

LE = log(a); % LE of Bernoulli map
gamma_critico = 0.5*(1 - exp(-LE)); % gamma for transition to syncro
disp('Critical value (theory):')
disp(gamma_critico)

% variables
x = zeros(T,1); 
y = zeros(T,1);

gamma = (0.25:0.01:0.3)';
N = size(gamma,1);
W = zeros(T,N);

for i = 1:N 
    
    % inizialite varaibles and simulate
    x(1) = rand();
    y(1) = rand();
    
    for t = 1:T-1
        x(t+1) = (1 - gamma(i))*f(x(t)) + gamma(i)*f(y(t));
        y(t+1) = gamma(i)*f(x(t)) + (1 - gamma(i))*f(y(t));
    end
    
    W(:,i) = abs(x - y);
    
end

figure
plot(W,'LineWidth',3)
xlabel('Time','interpreter','latex','fontsize',16)
ylabel('$\left|x - y\right|$','interpreter','latex','fontsize',16)
title('Syncronization Error','interpreter','latex','fontsize',18)
legend([repmat('$\gamma$ = ',N,1) num2str(gamma)],'interpreter','latex')
%saveas(gcf,'C:\Users\sbart\Desktop\università\Sistemi dinamici e Teoria del caos\Dispense\Bernoulli Sincro.jpg')

figure
subplot(2,2,1)
plot(W(:,2),'LineWidth',1)
title(['$\gamma$ = ',num2str(gamma(2))],'interpreter','latex')

subplot(2,2,2)
plot(W(:,3),'LineWidth',1)
title(['$\gamma$ = ',num2str(gamma(3))],'interpreter','latex')

subplot(2,2,3)
plot(W(:,4),'LineWidth',1)
title(['$\gamma$ = ',num2str(gamma(4))],'interpreter','latex')

subplot(2,2,4)
plot(W(:,5),'LineWidth',1)
title(['$\gamma$ = ',num2str(gamma(5))],'interpreter','latex')
%saveas(gcf,'C:\Users\sbart\Desktop\università\Sistemi dinamici e Teoria del caos\Dispense\Bernoulli Sincro 4.jpg')
clear