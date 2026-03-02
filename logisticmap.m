%% Logistic map x_{n+1} = a x_n (1- x_n)

rng shuffle
N = 100;

f = @(z,a) a.*z.*(1 - z); % logistic map

L = linspace(0,1,100);
x = zeros(N,1);
x(1) = 0.1;

for r = [2.6 3.2 3.5 4]
    
    figure
    subplot(2,1,1)
    plot(L,L,'k-')
    hold on
    plot(L,f(L,r),'b-','LineWidth',2)
    plot(linspace(x(1),x(1),2),linspace(0,x(1),2),'g-')
    for i = 1:N-1
        x(i+1) = f(x(i),r);
        plot(linspace(x(i),x(i),2),linspace(x(i),x(i+1),2),'g-')
        plot(linspace(x(i),x(i+1),2),linspace(x(i+1),x(i+1),2),'g-')
    end
    
    hold off
    xlabel('$x_n$','interpreter','latex','fontsize',12)
    ylabel('$x_{n+1}$','interpreter','latex','fontsize',12)
    title(['Logistic Map with r = ',num2str(r)],'interpreter','latex','fontsize',18)
    
    subplot(2,1,2)
    plot(x)
    xlabel('Time','interpreter','latex','fontsize',12)
    ylabel('$x_n$','interpreter','latex','fontsize',16)
end
clear