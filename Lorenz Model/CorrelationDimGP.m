%% Correlation dimension of Lorentz model with Grassberger-Procaccia algorithm
% [expected D_F = 2.01]

rng shuffle
N = 2*10^4; % time evolution
dt = 0.01;

% simulate Lorenz model
sigma = 10;
r = 28;
b = 8/3;

f = @(x,y) sigma*(y - x);
g = @(x,y,z) r*x - y - x*z;
h = @(x,y,z) x*y - b*z;

x = zeros(N,1);
y = zeros(N,1);
z = zeros(N,1);

x(1) = 0.;
y(1) = 1.;
z(1) = 1.05;

for i = 1:N
    x(i+1) = x(i) + 0.5*dt*f(x(i),y(i));
    y(i+1) = y(i) + 0.5*dt*g(x(i),y(i),z(i));
    z(i+1) = z(i) + 0.5*dt*h(x(i),y(i),z(i));
end

% figure
% plot3(x,y,z,'b-')
% grid on
% title('Lorentz Model','interpreter','latex','fontsize',16)

% Algorithm Grassberger-Procaccia
L = [100 5 1.5 1 0.5 0.25 0.1 0.05 0.025]';% length of box
H = size(L,1); % # different values of L

N_count = zeros(N,H);

for h = 1:H
    for i = 1:N
        % theta(L - ||x_i - x_j||)
        auN = (sqrt((x - x(i)).^2 + (y - y(i)).^2 + (z - z(i)).^2) <= L(h));
        
        N_count(i,h) = (sum(auN) - 1)/N;
    end
end

C_media = mean(N_count)';

% Metodo dei minimi quadrati to fit result log L vs log N(L) 
m = 2; % element to start fitting (L = 5)
M = size(L,1)-1; % last element to fit (L = 0.05)

Y = log(C_media(m:M));
A = [log(L(m:M)) ones(M - m + 1,1)];
V = 1*eye(M - m + 1);

B = (transpose(A)*V*A)\(transpose(A)*V);
theta = B*Y;
U = B*V*transpose(B);

txt_D = ['$D(2) \simeq $',num2str(theta(1)),'$\pm$ ',num2str(sqrt(U(1,1)))]; % result D(2) correlation dim
disp('--------------------------')
fprintf('D(2) = %f\n',theta(1))
disp('--------------------------')

figure
loglog(L,C_media,'k*')
grid on
hold on
loglog(L(m:M),exp(theta(2)).*L(m:M).^theta(1),'r-','LineWidth',2)
xlabel('$\ln L$','interpreter','latex','fontsize',12)
ylabel('$\ln C(L)$','interpreter','latex','fontsize',12)
title(['GP algorithm for Lorent Model for $\sigma$ = ',num2str(sigma),' and r = ',num2str(r),' and b = ',num2str(b)],...
    'interpreter','latex','fontsize',12)
annotation('textbox',[0.5 0.1 0.2 0.1],'String',{txt_D},...
    'FitBoxToText','on','interpreter','latex')

clear 
