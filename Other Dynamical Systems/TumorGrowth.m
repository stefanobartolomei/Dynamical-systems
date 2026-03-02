%% ES 2.3.3 Strogatz
% The growth of cancerous tumors can be modeled by the Gompertz law, where
% N(t) is proportional to the number of cells in the tumor, and a,b >0
% parameters.

a = 0.5; % rapidity to reach plateau
b = 2;  % 1/b is the saturation number of tumor cells

T = 100; % time evolution
dt = 1/T;


f = @(x,c_1,c_2) -c_1*x*log(x*c_2); % Gompertz law

K = 5; % number of system simulation

figure
yline([1/b 0],'--',{'Stable','Unstable'},'LineWidth',2,'Color','r')
ylim([0,b])
grid on
hold on
for k = 0:K
    N = zeros(1,T); % # cells
    N(1) = 0.2 + k*0.5; % initial state

    for t = 1:T-1
        % Modified Euler
        auN = N(t) + f(N(t),a,b)*dt;
        N(t+1) = N(t) + 0.5*(f(N(t),a,b) + f(auN,a,b))*dt;
    end

    plot(N,'-')
    pause(0.1)

    clear N
end
xlabel('Time','Interpreter','latex')
ylabel('Number of cells','Interpreter','latex')
title(['Gompertz Law for Tumor Growth with $a$ =', num2str(a),' $b$ = ',num2str(b)],'Interpreter','latex','FontSize',14)

clear
