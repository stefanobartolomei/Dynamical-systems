%% Calculation of the largest Lyapunv exponent as a function of the parameter 'a'

rng shuffle

N = 10^5; % # points
b = 0.3; % |b| < 1
a = (1.2:0.0005:1.4)';

% Henon map
f = @(x,y,a) y + 1 - a*x^2;
g = @(x) b*x;

% state vector
x = [0.1; zeros(N-1,1)];
y = [0.2; zeros(N-1,1)];

% Jacobi Matrix
Jf = @(x,u,v,a) -2*a*x*u + v;
Jg = @(u) b*u;

% tangent vector
u = [0.15; zeros(N,1)];
v = [0.1; zeros(N,1)];

% Largest LE
LE = zeros(size(a,1),1); % allocate
n = 10^3; % start calculate

for k = 1:size(a,1)
    
    for i = 1:N-1
        % evolution model
        x(i+1) = f(x(i),y(i),a(k));
        y(i+1) = g(x(i));

        % evolution tangent vector
        u(i+1) = Jf(x(i),u(i),v(i),a(k));
        v(i+1) = Jg(u(i));

        % normalize
        A = norm([u(i+1) v(i+1)]);
        u(i+1) = u(i+1)/A;
        v(i+1) = v(i+1)/A;

        if i > n
            LE(k) = LE(k) + log(A);
        end

    end
    LE(k) = LE(k)/(N-n);
end

figure
plot(a,LE,'b-','LineWidth',1)
yline(0,'r--','LineWidth',2)
xlabel('$a$ parameter','interpreter','latex','fontsize',14)
ylabel('$\lambda_{max}$','interpreter','latex','fontsize',14)
title(['Largest Lyapunov Exponent for Henon Map with $b$ = ',num2str(b),' as function of $a$'],...
    'interpreter','latex','fontsize',11)


clear
