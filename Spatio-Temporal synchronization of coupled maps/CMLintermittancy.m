rng shuffle

L = 1024;
T = 500;
epsilon = 0.361;
a = 3;

x = [rand(L,1) zeros(L,T-1)];
p = zeros(T,1);

for t = 1:T-1
    
    aux = (1 - epsilon)*x(1,t) + epsilon*0.5*(x(2,t) + x(L,t));  
    x(1,t+1) = f(aux,a);
    
    for i = 2:L-1
        aux = (1 - epsilon)*x(i,t) + epsilon*0.5*(x(i+1,t) + x(i-1,t));
        
        x(i,t+1) = f(aux,a);
    end
    
    aux = (1 - epsilon)*x(L,t) + epsilon*0.5*(x(1,t) + x(L-1,t));
    x(L,t+1) = f(aux,a);
    
    p(t) = sum(x(:,t) > 1)/L;
end

figure
contourf(transpose(x))
xlabel('Space','interpreter','latex','fontsize',14)
ylabel('Time','interpreter','latex','fontsize',14)
title('Chate-Manneville model evolution with STI','interpreter','latex',...
    'fontsize',18)
colorbar('southoutside')
colormap([0 0 0;
    1 1 1])

figure
plot(p)
title('Density Active sites Plot','interpreter','latex','fontsize',18)
xlabel('Time','interpreter','latex','fontsize',14)
ylabel('$\rho_{\epsilon}$(t)','interpreter','latex','fontsize',14)

clear
function znew = f(z,a)

if z <= 0.5
    znew = a*z;
elseif ((z > 0.5) && (z < 1))
    znew = a*(1 - z);
elseif z >= 1
    znew = z;
end
end