% Generate a random initial population
density_init = 0.5;
X = rand(50,50) < density_init;

% Loop over 100 generations.
for t = 1:100
    spy(X)
    title('Game of Life')
    subtitle(['Time generation ',num2str(t)])
    drawnow
    % Whether cells stay alive, die, or generate new cells depends
    % upon how many of their eight possible neighbors are alive.
    % Index vectors increase or decrease the centered index by one.

    n = size(X,1);
    p = [1 1:n-1];
    q = [2:n n];

    % Count how many of the eight neighbors are alive.
    Y = X(:,p) + X(:,q) + X(p,:) + X(q,:) + X(p,p) ...
    + X(q,q) + X(p,q) + X(q,p);

    % A live cell with two live neighbors, or any cell with
    % three live neigbhors, is alive at the next step.
    X = (X & (Y == 2)) | (Y == 3);
    
end

clear
