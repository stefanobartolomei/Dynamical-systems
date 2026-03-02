rng shuffle

T = 200; % time evolution
p = 0.7; % parameter skew map (p = 0.5 tend map)

LE = -p*log(p) - (1 - p)*log(1-p); % LE of Skew map
gamma_critico = 0.5*(1 - exp(-LE)); % gamma for transition to syncro
disp('Critical value:')
disp(gamma_critico)

% variables
x = zeros(T,1); 
y = zeros(T,1);

gamma = (0.2:0.01:0.23)';
N = size(gamma,1);
W = zeros(T,N);

for i = 1:N 
    
    % inizialite varaibles and simulate
    x(1) = rand();
    y(1) = rand();
    
    for t = 1:T-1
        x(t+1) = (1 - gamma(i))*f(x(t),p) + gamma(i)*f(y(t),p);
        y(t+1) = gamma(i)*f(x(t),p) + (1 - gamma(i))*f(y(t),p);
    end
    
    W(:,i) = abs(x - y);
    
end

figure
plot(W,'LineWidth',3)
xlabel('Time','interpreter','latex','fontsize',16)
ylabel('$\left|x - y\right|$','interpreter','latex','fontsize',16)
title('Syncronization Error','interpreter','latex','fontsize',18)
legend([repmat('$\gamma$ = ',N,1) num2str(gamma)],'interpreter','latex')
% saveas(gcf,'C:\Users\sbart\Desktop\università\Sistemi dinamici e Teoria del caos\Dispense\Tenda Sincro.jpg')
figure
subplot(2,2,1)
plot(W(:,1))
title(['$\gamma$ = ',num2str(gamma(1))],'interpreter','latex')

subplot(2,2,2)
plot(W(:,2))
title(['$\gamma$ = ',num2str(gamma(2))],'interpreter','latex')

subplot(2,2,3)
plot(W(:,3))
title(['$\gamma$ = ',num2str(gamma(3))],'interpreter','latex')

subplot(2,2,4)
plot(W(:,4))
title(['$\gamma$ = ',num2str(gamma(4))],'interpreter','latex')
% saveas(gcf,'C:\Users\sbart\Desktop\università triennale\Sistemi dinamici e Teoria del caos\Dispense\Tenda Sincro 4.jpg')
clear
% skew map
function znew = f(z,p)
if z < p
    znew = z/p;
else
    znew = (1 - z)/(1 - p);
end
end