rng shuffle

N = 10^5;
dt = 0.01;

sigma = 10;
b = 8/3;
r = 28;

f = @(x,y) sigma*(y - x);
g = @(x,y,z) r*x - y - z*x;
h = @(x,y,z) x*y - b*z;

x = [0.1; zeros(N-1,1)];
y = [0.3; zeros(N-1,1)];
z = [0.15; zeros(N-1,1)];

for i = 1:N-1
    aux = x(i) + 0.5*dt*f(x(i),y(i));
    auy = y(i) + 0.5*dt*g(x(i),y(i),z(i));
    auz = z(i) + 0.5*dt*h(x(i),y(i),z(i));
    
    x(i+1) = x(i) + dt*f(aux,auy);
    y(i+1) = y(i) + dt*g(aux,auy,auz);
    z(i+1) = z(i) + dt*h(aux,auy,auz);
end


% funz correlation for x(t)
tau = (1:1000)';
T = size(tau,1);
C = zeros(T,1);

m = mean(x)^2;
for t = 1:T
    
    for i = 1:(N-t)
        C(t) = C(t) + (x(t+i)*x(i) - m);
    end
    
    C(t) = C(t)/(N-t);
end


figure
plot(tau,C/C(1),'b-')
yline(0,'r--')
xlabel('$\tau$','interpreter','latex','fontsize',14)
ylabel('$\frac{C(\tau)}{C(0)}$','interpreter','latex','fontsize',14)
title('Correlation function for Lorenz Model for $x(t)$ signal','interpreter','latex','fontsize',16)

clear
    
    
