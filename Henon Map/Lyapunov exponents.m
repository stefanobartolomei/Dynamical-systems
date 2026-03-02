%% Henon map with a = 1.4 b = 0.3 has expected esponent
%% max LE = 	0.419217, second LE = -1.623190 and DF = 1.258267 (with KP)
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

% Jacobi Matrix
Jf = @(x,u,v) -2*a*x*u + v;
Jg = @(u) b*u;

% tangent vector
u = [0.15; zeros(N,1)];
v = [0.1; zeros(N,1)];

% tangent vector (for LE_2 calculation)
u2 = [0.1; zeros(N,1)];
v2 = [0.3; zeros(N,1)];

% Largest LE
LLE = 0; % allocate
LE2 = 0;

n = 10^3; % start calculate

for i = 1:N-1
    % evolution model
    x(i+1) = f(x(i),y(i));
    y(i+1) = g(x(i));
    
    % evolution tangent vector
    u(i+1) = Jf(x(i),u(i),v(i));
    v(i+1) = Jg(u(i));
    
    u2(i+1) = Jf(x(i),u2(i),v2(i));
    v2(i+1) = Jg(u2(i));
    
    % normalize
    A = norm([u(i+1) v(i+1)]);
    u(i+1) = u(i+1)/A;
    v(i+1) = v(i+1)/A;
    
    % orthogonality and normalize
    B = norm([u2(i+1) v2(i+1)]);
    u2(i+1) = u2(i+1)/B;
    v2(i+1) = v2(i+1)/B;
    u2(i+1) = u2(i+1) - u(i+1)*dot([u(i+1) v(i+1)],[u2(i+1) v2(i+1)])/A;
    v2(i+1) = v2(i+1) - v(i+1)*dot([u(i+1) v(i+1)],[u2(i+1) v2(i+1)])/A;
    
    if i > n
        LLE = LLE + log(A);
        LE2 = LE2 + log(B);
    end
    
end

lamb1 = LLE/(N - n);
lamb2 = 2*(LE2 - LLE)/(N - n);
Df = 1 + lamb1/abs(lamb2);

disp('-------------------------------------')
fprintf('LE = %f\n',lamb1);
fprintf('LE2 =  %f\n',lamb2);
fprintf('DF = %f with KP Conjecture\n',Df);
disp('-------------------------------------')

figure
plot(x,y,'b.')
xlabel('$x$-axis','interpreter','latex','fontsize',14)
ylabel('$y$-axis','interpreter','latex','fontsize',14)
title(['Henon Map with $a$ = ',num2str(a),' and $b$ = ',num2str(b)],'interpreter','latex',...
    'fontsize',16)
clear
