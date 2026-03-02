function varargout = CAfunc(varargin)
x = varargin{1}; % state vector at time t
r = varargin{2}; % rule CA in base 10

%% Ordine Tabella
% Base 2    
% 0 0 0    1
% 0 0 1    2
% 0 1 0    4
% 0 1 1    8
% 1 0 0    16
% 1 0 1    32
% 1 1 0    64
% 1 1 1    128


N = size(x,1);

% state neighbors 3
s = zeros(N,1);
s(1) = x(N) + x(1) + x(2);
for i = 2:N-1
    s(i) = x(i-1) + x(i) + x(i+1);
end
s(N) = x(N-1) + x(N) + x(1);

%   rule    state    number 1 of neighbors
R = [0        0        0
     0        0        1
     0        1        1
     0        1        2
     0        0        1
     0        0        2
     0        1        2
     0        1        2];
 
% evaluate rule
p = str2double(dec2bin(r));
for i = 8:-1:1
    if (p - 10^i) >= 0
        R(i+1,1) = 1;
        p = p - 10^i;
    else
        R(i+1,1) = 0;
    end
end

for i = 1:8
    new = (x == R(i,2)) & (s == R(i,3));
    x(new) = R(i,1);
end             

varargout{1} = x; % state vector at time t+1
end