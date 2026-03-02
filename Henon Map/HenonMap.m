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

for i = 1:N-1
    x(i+1) = f(x(i),y(i));
    y(i+1) = g(x(i));
end

figure
plot(x,y,'b.')
xlabel('x','interpreter','latex','fontsize',14)
ylabel('y','interpreter','latex','fontsize',14)
grid on
title(['Henon Map with $a$ = ',num2str(a),' and $b$ = ',num2str(b)],'interpreter','latex',...
    'fontsize',16)
clear
