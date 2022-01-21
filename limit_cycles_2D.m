I = -80:0.1:80;
Ena = 50;
Ek = -100;
El = -70;
gf = 20;
gs = 20;
gl = 2;
phiw = 0.15;
C = 2;
bm = -1.2;
gm = 18;
gw = 10;
dt = 0.01;
t = 0:dt:100;
bw = -5; %class 1
% bw = -13, class 2
%bw = -21, class 3
V = zeros(1,10001);
w = zeros(1,10001);

V(1) = 60; %change initial value
w(1) = 0.01; %change initial value
    
for j = 1:length(I)
for i = 1:length(t)-1
    minf = (1 + tanh((V(i)-bm)/gm))*0.5;
    winf = (1 + tanh((V(i)-bw)/gw))*0.5;
    tauw = 1/(cosh((V(i)-bw)/(2*gw)));
    w(i+1) = w(i) + dt.*phiw*((winf-w(i))/tauw);
    V(i+1) = V(i) + dt.*(( I(j) - gf*minf*(V(i)-Ena) - gs*w(i)*(V(i)-Ek) - gl*(V(i)-El)/C));
end 
end
hold on;  plot(V,w,'Linewidth',2)
