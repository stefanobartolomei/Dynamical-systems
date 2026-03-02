%% Bernoulli map
rng shuffle

N = 50; % time evolution
a = 2;
f = @(x) mod(a*x,1); % Bernoulli map

L = linspace(0,1,100);
x = zeros(N,1); % vector state
x(1) = rand();

% plot coweb
figure
plot(L,L,'k-')
hold on
plot(L,f(L),'b-','LineWidth',2)
plot(linspace(x(1),x(1),2),linspace(0,x(1),2),'g-')
plot(x(1),0,'ro')
for i = 1:N-1
    x(i+1) = f(x(i)); % evolution
    plot(linspace(x(i),x(i),2),linspace(x(i),x(i+1),2),'g-')
    plot(linspace(x(i),x(i+1),2),linspace(x(i+1),x(i+1),2),'g-')
end
hold off
xlabel('$x_n$','interpreter','latex','fontsize',16)
ylabel('$x_{n+1}$','interpreter','latex','fontsize',16)
title(['Bernoulli map with $a =$ ',num2str(a)],'interpreter','latex','fontsize',18)

% signal vector
s = x >= 0.5;
s_one = sum(s);
prob_one  = s_one/size(s,1);
h = - prob_one*log(prob_one)  - (1 - prob_one)*log(1 - prob_one);
h_true = log(2);

fprintf('\n')
disp('--------------------------------------')
fprintf('Entropy for Bernoulli process h = %f\n',h)
fprintf('Expected entropy : %f\n',h_true)
disp('--------------------------------------')
fprintf('\n')
figure
subplot(2,1,1)
plot(linspace(0,10,N),x,'b-o','MarkerEdgeColor','r')
ylabel('$x(t)$','interpreter','latex','fontsize',16)
title(['Evolution of $x(t)$ and signal $s(t)$ for Bernoulli map with $a =$ ',num2str(a)],'interpreter','latex','fontsize',12)

subplot(2,1,2)
plot(linspace(0,10,N),s,'k-s','MarkerFaceColor','k')
ylabel('$s(t)$','interpreter','latex','fontsize',16)
xlabel('Time $t$','interpreter','latex','fontsize',16)
clear