rng shuffle

N = 2*10^4; % # points
dt = 0.01;

% parameter
a = 0.15;
b = 0.4;
c = 8.5;

% Rossler model
f = @(y,z) - y - z;
g = @(x,y) x + a*y;
h = @(x,z) b + z*(x-c);

x = [0.1; zeros(N-1,1)];
y = [0.2; zeros(N-1,1)];
z = [0.15; zeros(N-1,1)];

for i = 1:N-1
    aux = x(i) + 0.5*f(y(i),z(i))*dt;
    auy = y(i) + 0.5*g(x(i),y(i))*dt;
    auz = z(i) + 0.5*h(x(i),z(i))*dt;
    
    x(i+1) = x(i) + f(auy,auz)*dt;
    y(i+1) = y(i) + g(aux,auy)*dt;
    z(i+1) = z(i) + h(aux,auz)*dt;
end

figure
subplot(2,1,1)
plot(x,y,'b')
ylabel('$y$','interpreter','latex','fontsize',14)
title(['Rossler Map with a = ',num2str(a),' b = ',num2str(b),' and c = ',num2str(c)]...
    ,'interpreter','latex','fontsize',16)

subplot(2,1,2)
plot(x,z,'b')
xlabel('$x$','interpreter','latex','fontsize',14)
ylabel('$z$','interpreter','latex','fontsize',14)

figure
subplot(3,1,1)
plot(x,'b')
ylabel('$x(t)$','interpreter','latex','fontsize',14)
subplot(3,1,2)
plot(y,'b')
ylabel('$y(t)$','interpreter','latex','fontsize',14)
subplot(3,1,3)
plot(z,'b')
ylabel('$z(t)$','interpreter','latex','fontsize',14)
xlabel('Time','interpreter','latex','fontsize',14)

clear