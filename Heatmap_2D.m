%takes a long runtime
clear all
I = 1:0.5:80;
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
dt = 0.001;
t = 0:dt:100;
bw = -21:0.01:-1;
V = zeros(1,100001);
w = zeros(1,100001);
for b = 1:length(bw)
    V(1) = randn;
    w(1) = randn;
    for j = 1:length(I)
        for i = 1:length(t)-1
         minf =  0.5*(1+tanh((V(i) - bm)/gm));
         winf =  0.5*(1+(tanh((V(i) - bw(b))/gw)));
         tauw = 1/(cosh((V(i)-bw(b))/(2*gw)));
    w(i+1) = w(i) + dt.*phiw*((winf-w(i))/tauw);
    V(i+1) = V(i) + dt.*(( I(j) - gf*minf*(V(i)-Ena) - gs*w(i)*(V(i)-Ek) - gl*(V(i)-El)/C));
        end 
    val = findpeaks(V);
    spr(j) = length(val)*10;
    end
end

imagesc(bw,I,spr)
axisxy
xlabel('βw (in mV)')
ylabel('I (in µA)')
title('Firing rate vs I, βw')
colorbar


