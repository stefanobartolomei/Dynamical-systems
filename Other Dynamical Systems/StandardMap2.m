%% Standard Map
rng shuffle

eps = [0 0.05 0.1 0.5 1]'; % perturbation
T = 1000; % time of a single simulation
N = 50; % simulation per eps

x = zeros(T,N);
y = zeros(T,N);

% initial conditions
x(1,:) = rand(1,N);
y(1,:) = rand(1,N);

% numerical simulation
for k = 1:size(eps,1) % for each value of eps
    
    figure
    xlim([-0.5 0.5])
    ylim([-0.5 0.5])
    for i = 1:N % iteration per eps
        hold on
        for t = 1:T-1 % single dynamical evolution
            y(t+1,i) = mod(y(t,i) + eps(k)*sin(2*pi*x(t,i)),1);
            x(t+1,i) = mod(x(t,i) + y(t+1,i),1);
        end
        plot(x(:,i)-0.5,y(:,i)-0.5,'b.','LineWidth',0.1)
    end
    hold off
    title(['Standard Map Phase Potrait with $\epsilon$ = ',num2str(eps(k))],...
        'interpreter','latex','fontsize',16)
    xlabel('Action Variable $I$','interpreter','latex','fontsize',14)
    ylabel('Angle Variable $\phi$','interpreter','latex','fontsize',14)
    
end
clear
