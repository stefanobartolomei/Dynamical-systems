rng shuffle

N = 1000; % iteration of single dynamic 
M = 10000; % iteration of systems with fixed r

r = linspace(3.5,4,M);
x = zeros(N,1);
f = @(x,a) a*x*(1-x);

figure
hold on 
for k = 1:M
    x = rand();
    
    for i = 1:N-1
        x(i+1) = f(x(i),r(k));
    end

    plot(r(k),x(end),'b.')
end

xlabel('\textbf{r}','interpreter','latex','fontsize',18)
ylabel('$\textbf{x}^{*}$','interpreter','latex','fontsize',18)
title('Bifurcation diagram for Logistic Map $x_{n+1} = rx_n(1 - x_n)$','interpreter','latex',...
    'fontsize',14)

clear
