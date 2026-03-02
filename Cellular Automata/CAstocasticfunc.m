function varargout = CAstocasticfunc(varargin)
x = varargin{1};
r = varargin{2};

%% TABLE
% 000
% 001
% 010
% 011
% 100
% 101
% 110
% 111

N = size(x,1);
s = zeros(N,1);
s(1) = x(N) + x(1) + x(2);
for i = 2:N-1
    s(i) = x(i-1) + x(i) + x(i+1);
end
s(N) = x(N-1) + x(N) + x(1);

%   state    number 1 of neighbors
R = [0              0
     0              1
     1              1
     1              2
     0              1
     0              2
     1              2
     1              2];
 
D = size(R,1);
for i = 1:D
    new = (x == R(i,1)) & (s == R(i,2));
    x(new) = rand(sum(new),1) < r(i);
end

varargout{1} = x;
end