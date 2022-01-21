clear all

I = 50;

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
bw = -21; 
V = -80:0.01:50;

minf = (1 + tanh((V-bm)/gm))*0.5;
wdot = 0.5*(1+(tanh((V - bw)/gw)));

Vdot = (I - gf.*minf.*(V- Ena) - gl.*(V-El))./(gs.*(V-Ek))

figure; plot(V,wdot,'b','Linewidth',1.5); 
hold on; 
plot(V,Vdot,'r','Linewidth',1.5)

xlabel('V (in mV)')
legend('wdot','Vdot')

