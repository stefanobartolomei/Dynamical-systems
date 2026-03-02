rng shuffle

N = 100; % number cells
T = 50; % time simulation

init_density = 0.5; % number initial 1 cells
x = [(rand(N,1) < init_density) zeros(N,T-1)];

%% Regole
% Classe 1: Regole 0, 32, 160, 232 convergono allo stato uniforme
% Classe 2: Regole 4, 108, 218, 250 convergono ad un punto fisso o ad un
% motivo fisso
% Classe 3: Regole 22, 30, 126, 150, 182 convergono ad uno stato casuale
% Classe 4: Regole 110 presentano punti fissi, cicli limite etc

%   [000 001 010 011 100 101 110 111] 
% r = [0.3 0.4 0.7 0.2 0.1 0.5 0.5 0.5];
r = rand(8,1);
for t = 1:T-1
    % aggiorna
    x(:,t+1) = CAstocasticfunc(x(:,t),r);
end

contourf(transpose(x))
colormap([0 0 0
    1 1 1])
xlabel('Space','interpreter','latex','fontsize',14)
ylabel('Time','interpreter','latex','fontsize',14)
colorbar('southoutside')
title('Probabilistic Cellular Automata','interpreter','latex','fontsize',18)

clear