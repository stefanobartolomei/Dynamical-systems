%% Correlation dimension of Henon Map with Grassberger-Procaccia algorithm
%% [expected for a = 1.4 b = 0.3 D(2) = 1.25]
rng shuffle

N = 2*10^4; % # points
a = 1.4;
b = 0.3; % |b| < 1

% Henon map
f = @(x,y) y + 1 - a*x^2;
g = @(x) b*x;

x = [0.1; zeros(N-1,1)];
y = [0.2; zeros(N-1,1)];

for i = 1:N-1
    x(i+1) = f(x(i),y(i));
    y(i+1) = g(x(i));
end

figure
plot(x,y,'.')
xlabel('x','interpreter','latex','fontsize',14)
ylabel('y','interpreter','latex','fontsize',14)
title(['Henon Map with $a =$ ',num2str(a),' and $b =$ ',num2str(b)]...
    ,'interpreter','latex','fontsize',16)

% Algorithm Grassberger-Procaccia
L = [100 5 1.5 1 0.5 0.25 0.1 0.05 0.025 0.01 0.005 0.0025 0.001 0.0005 0.0001 0.00005]';% lunghezza box
H = size(L,1); % # differente values for L

N_count = zeros(N,H);

for h = 1:H
    for i = 1:N
        % theta(L - ||x_i - x_j||)
        auN = (sqrt((x - x(i)).^2 + (y - y(i)).^2) <= L(h));
        
        N_count(i,h) = (sum(auN) - 1)/N;
    end
end

C_media = mean(N_count)';

% Metodo dei minimi quadrati to fit result log L vs log N(L) 
m = 5; % element to start fitting (L = 0.5)
M = size(L,1)-1; % last element to fit (L = 0.0001)

Y = log(C_media(m:M));
A = [log(L(m:M)) ones(M - m + 1,1)];
V = 1*eye(M - m + 1);

B = (transpose(A)*V*A)\(transpose(A)*V);
theta = B*Y;
U = B*V*transpose(B);

txt_D = ['$D(2) \simeq $',num2str(theta(1)),'$\pm$ ',num2str(sqrt(U(1,1)))]; % result D(2) correlation dim

disp('----------------------------')
fprintf('D(2) = %f\n',theta(1))
disp('----------------------------')

figure
loglog(L,C_media,'k*','MarkerSize',15)
grid on
hold on
loglog(L(m:M),exp(theta(2)).*L(m:M).^theta(1),'r-','LineWidth',2)
xlabel('$\ln L$','interpreter','latex','fontsize',12)
ylabel('$\ln C(L)$','interpreter','latex','fontsize',12)
title(['GP algorithm for Henon Map for $a =$ ',num2str(a),' and $b =$ ',num2str(b)],...
    'interpreter','latex','fontsize',16)
annotation('textbox',[0.5 0.1 0.2 0.1],'String',{txt_D},...
    'FitBoxToText','on','interpreter','latex')
clear 