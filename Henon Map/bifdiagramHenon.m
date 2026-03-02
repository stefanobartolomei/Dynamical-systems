%% Bifurcation diagram for the Henon map
rng shuffle

N = 10^4; % iteration of single dynamic 

a = (1.:0.001:1.5)'; % interval for 'a' parameter
b = 0.3; % fix

x = zeros(N,1);
y = zeros(N,1);

figure
hold on 
for k = 1:size(a,1)
    x = rand();
    y = rand();
    
    for i = 1:N-1
        x(i+1) = 1 + y(i) - a(k)*(x(i)^2);
        y(i+1) = b*x(i);
    end

    plot(a(k),x(end-100:end),'b.','MarkerSize',0.01)
end
xlabel('\textbf{a}','interpreter','latex','fontsize',18)
ylabel('$\tilde{x}$','interpreter','latex','fontsize',18)
title(['Bifurcation diagram for Henon map with $b =$ ',num2str(b)],'interpreter','latex',...
    'fontsize',14)

clear
