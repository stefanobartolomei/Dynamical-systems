%% Lyapunov exponent calculation as function of the parameter 'a'

N = 10000;
n = 500;

a = (3:0.005:4)';
LE = zeros(size(a,1),1);

for k = 1:size(a,1)
    x = 0.2;
    
    for i = 1:N
        x = a(k)*x*(1 - x);
        
        if i > n
            LE(k)= LE(k) + log(abs(a(k)*(1 - 2*x)));
        end
    end
end

LE = LE./(N-n);

figure
plot(a,LE,'b','LineWidth',1)
yline(0,'r--','LineWidth',2)
title('Lyapunov Exponent for Logistic map $x_{n+1} = rx_n(1-x_n)$',...
    'interpreter','latex','fontsize',14)
xlabel('$r$','interpreter','latex','fontsize',18)
ylabel('$\lambda$','interpreter','latex','fontsize',18)

clear