I = 30:5:80;
Ena = 50;
Ek = -100;
El = -70;
gf = 20;
gl = 2;
%gs = 20; %phiw = 0.15; %gw = 10;
C = 2;
bm = -1.2; gm = 18;
dt = 0.1;
t = 0:dt:100;
by = -19; gy = 10; phiy = 0.15;
bz = -10; gz = 15; 
gkdr = 0; %value not clear
V = zeros(1,1001);
y = zeros(1,1001);
z = zeros(1,1001);


    for j = 1:length(I)
    for i = 1:length(t)-1
    V(1) = randn;
    y(1) = randn;
    z(1) = randn;
 minf = (1 + tanh((V(i)-bm)/gm))*0.5;
 yinf = (1 + tanh((V(i)-by)/gy))*0.5;
 tauy = 1/(cosh((V(i)-by)/(2*gy)));
 zinf = (1 + tanh((V(i)-bz)./gz))*0.5;
 tauz = 1/(cosh((V(i)-bz)./(2*gz)));
 
 if I(j) > 50;
    phiz = 0.5; %when current inward, Esub = Ena = 50mV, class 1
    Esub = 50;
    gsub = 3;
    V(i+1) = V(i) + dt.*(( I(j) - gf*minf*(V(i)-Ena) - gkdr*y(i)*(V(i)-Ek) - gsub*z(i)*(V(i) - Esub) - gl*(V(i)-El))./C);
    y(i+1) = y(i) + dt.*phiy*((yinf-y(i))/tauy);
    z(i+1) = z(i) + dt.*phiz*((zinf -z(i))/tauz);
else
    phiz = 0.15; %when current outward, Esub = Ek = -100mV, class 2 gsub =2, class 3 gsub = 7
    Esub = -100;
    gsub = 2;
    V(i+1) = V(i) + dt.*(( I(j) - gf*minf*(V(i)-Ena) - gkdr*y(i)*(V(i)-Ek) - gsub*z(i)*(V(i) - Esub) - gl*(V(i)-El))./C);
    y(i+1) = y(i) + dt.*phiy*((yinf-y(i))/tauy);
    z(i+1) = z(i) + dt.*phiz*((zinf -z(i))/tauz);
 end
 
 val = findpeaks(V);
 spr(j) = length(val)*10;
    
 
end
end
    
    
   figure; plot(t,V) %spike rates
   figure; plot(I,spr,'.') %f vs I curve

