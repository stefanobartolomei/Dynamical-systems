%% Evolution of the Correlation function for x(t)

rng shuffle

N = 10^5; % # points
a = 1.4;
b = 0.3; % |b| < 1

% Henon map
f = @(x,y) y + 1 - a*x^2;
g = @(x) b*x;

% state vector
x = [0.1; zeros(N-1,1)];
y = [0.2; zeros(N-1,1)];

% Correlation function for x(t)
tau = (1:100)';
T = size(tau,1);
C = zeros(T,1);

for i = 1:N-1
    x(i+1) = f(x(i),y(i));
    y(i+1) = g(x(i));
end

m = mean(x)^2;
for t = 1:T
    for i = 1:(N-t)
        C(t) = C(t) + (x(i+t)*x(i) - m);
    end
    C(t) = C(t)/(N-t);
end

% Characterist time (loosing memory)
% tau_c = sum(C)/C(1);
% disp('-------------------------------------')
% fprintf('Characteristic time = %f\n',tau_c);
% disp('-------------------------------------')

figure
plot(tau,C/C(1),'b-','LineWidth',1)
yline(0,'r--','LineWidth',2)
xlabel('$\tau$','interpreter','latex','fontsize',14)
ylabel('$\frac{C(\tau)}{C(0)}$','interpreter','latex','fontsize',14)
grid on
title(['Correlation function for Henon map with $a$ = ',num2str(a),' and $b$ = ',num2str(b)],'interpreter','latex',...
    'fontsize',14)

clear
