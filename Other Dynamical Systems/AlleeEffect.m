%% ES 2.3.4 Strogatz
% For certain species of organisms, the effective growth rate \dot{N}/N is
% highest at intermediate N. This is called the Allee effect.
% For example, imagine that it is too hard to find mates when N is very
% small, nd there is too much competition for food and other resources whan
% N is large.

f = @(x,r,a,b) r - a*(x - b).^2; % example for Allee effect (for certain value of r,a,b)

% Che condizioni per Allee effect? if b < sqrt(r/a)
figure(1)
fplot(@(x) 2 - 1*(x - 3).^2,[0 5],'b-')
hold on
fplot(@(x) 2 - 1*(x - 1).^2,[0 5],'r-')
ylim([0 3])
title("Example of plot $\frac{\dot{N}}{N} = r - a(N-b)^2$ for Allee Effect",'Interpreter','latex','FontSize',18)
legend('$b < \sqrt{\frac{r}{a}}$','$b > \sqrt{\frac{r}{a}}$','interpreter','latex','fontsize',15,'Location','best')


% Solve unidimensional system
T = 100; % time evolution
dt = 1/T;

g = @(x,r,a,b) x*(r - a*(x - b).^2);

K = 5; % number of simulation

% Parameters value
r = 2;
a = 1;
b = 1;

figure(2)
if b > sqrt(r/a)
    % Allee Effect [b > sqrt(r/a)]
    yline([b + sqrt(r/a) b - sqrt(r/a) 0],'r--',{'Stable','Unstable','Stable'},'LineWidth',2)
    title(['Plot for Allee Effect with $r$ = ',num2str(r),', $a$ = ',num2str(a),', $b$ = ',num2str(b)],'Interpreter','latex','FontSize',14)
else
    % NO Allee Effect [b < sqrt(r/a)]
    yline([b + sqrt(r/a) 0],'r--',{'Stable','Unstable'},'LineWidth',2)
    title(['Plot for No Allee Effect with $r$ = ',num2str(r),', $a$ = ',num2str(a),', $b$ = ',num2str(b)],'Interpreter','latex','FontSize',14)
end
ylim([0 5])
xlabel('Time','Interpreter','latex','FontSize',12)
ylabel('Population','Interpreter','latex','FontSize',12)
grid on
hold on
for k = 0:K

    N = zeros(1,T);
    N(1) = 1 + 0.5*k;

    for t = 1:T-1
        % Eulero modificato
        auN = N(t) + g(N(t),r,a,b)*dt;
        N(t+1) = N(t) + 0.5*(g(N(t),r,a,b) + g(auN,r,a,b))*dt;
    end

    plot(linspace(0,10,T),N,'-')
    pause()

    clear N
end
clear
