%% 1.a

P= 10000;
lambda= 1800;
C= 10;
f= 1000000;
% Number of simulations
N= 10;
PL= zeros(1, N);
APD= zeros(1, N);
MPD= zeros(1, N);
TT= zeros(1, N);

for i = 1:N
    [PL(i) , APD(i) , MPD(i) , TT(i)]= Simulator1(lambda,C,f,P);
end

% 90 percent confidence interval
alfa= 0.1;

% packet loss (%)
pl= mean(PL);
term= norminv(1-alfa/2) * sqrt(var(PL)/N);

% average packet delay (milliseconds)
apd= mean(APD);
term2= norminv(1-alfa/2) * sqrt(var(APD)/N);

% maximum packet delay (milliseconds)
mpd= mean(MPD);
term3= norminv(1-alfa/2) * sqrt(var(MPD)/N);

% transmitted throughput (Mbps)
tt= mean(TT);
term4= norminv(1-alfa/2) * sqrt(var(TT)/N);

fprintf('Packet Lost (%%)           = %.2e +- %.2e\n', pl, term)
fprintf('Av. Packet Delay (ms)      = %.2e +- %.2e\n', apd, term2)
fprintf('Max. Packet Delay (ms)     = %.2e +- %.2e\n', mpd, term3)
fprintf('Throughput (Mbps)          = %.2e +- %.2e\n', tt, term4)

%% 1.b

P= 10000;
lambda= 1800;
C= 10;
f= 10000;
% Number of simulations
N= 10;
PL= zeros(1, N);
APD= zeros(1, N);
MPD= zeros(1, N);
TT= zeros(1, N);

for i = 1:N
    [PL(i) , APD(i) , MPD(i) , TT(i)]= Simulator1(lambda,C,f,P);
end

% 90 percent confidence interval
alfa= 0.1;

% packet loss (%)
pl= mean(PL);
term= norminv(1-alfa/2) * sqrt(var(PL)/N);

% average packet delay (milliseconds)
apd= mean(APD);
term2= norminv(1-alfa/2) * sqrt(var(APD)/N);

% maximum packet delay (milliseconds)
mpd= mean(MPD);
term3= norminv(1-alfa/2) * sqrt(var(MPD)/N);

% transmitted throughput (Mbps)
tt= mean(TT);
term4= norminv(1-alfa/2) * sqrt(var(TT)/N);

fprintf('Packet Lost (%%)           = %.2e +- %.2e\n', pl, term)
fprintf('Av. Packet Delay (ms)      = %.2e +- %.2e\n', apd, term2)
fprintf('Max. Packet Delay (ms)     = %.2e +- %.2e\n', mpd, term3)
fprintf('Throughput (Mbps)          = %.2e +- %.2e\n', tt, term4)

%% 1.c (TO DO)

P= 10000;
lambda= 1800;
C= 10;
f= 1000000;

% packet loss (%)
pl= 0 % Como é um sistema M/M/1 com uma fila infinita de espera o packet lost teórico é 0.

% average packet delay (milliseconds)
apd= 

% transmitted throughput (Mbps)
tt= mean(TT);
term4= norminv(1-alfa/2) * sqrt(var(TT)/N);

fprintf('Packet Lost (%%)           = %.4f\n', pl)
fprintf('Av. Packet Delay (ms)      = %.4f\n', apd)
fprintf('Throughput (Mbps)          = %.4f\n', tt)

%% 1.e (TO DO)

P= 10000;
lambda= 1800;
C= 10;
f= 1000000;

otherProbabilities= (1-0.16-0.25-0.2)/1452;
packetsSize= (64:1518);
probPacketsSize= zeros(1, length(packetsSize));

for i = 1:length(packetsSize)
    if i == 1
        probPacketsSize(i)= 0.16;
    elseif i == 47
        probPacketsSize(i)= 0.25;
    elseif i == 1455
        probPacketsSize(i)= 0.2;
    else
        probPacketsSize(i)= otherProbabilities;
    end
end

B= 0;
for i = 1:length(packetsSize)
    B= B + packetsSize(i) * probPacketsSize(i);
end

new= (C*1e6)/B*8;

% packet loss (%)
t= 0;
for i = 0:f
    t= t +(lambda/new)^i;
end
pl= (lambda/new)^f / t;

% average packet delay (milliseconds)
numAveragePacketsSystem= 0;
for i = 0:f
    numAveragePacketsSystem= numAveragePacketsSystem + (i*(lambda/new)^i) / (lambda/new)^i;
end

apd= numAveragePacketsSystem / lambda * (1-pl);

% transmitted throughput (Mbps)
tt= mean(TT);
term4= norminv(1-alfa/2) * sqrt(var(TT)/N);

fprintf('Packet Lost (%%)           = %.4f\n', pl)
fprintf('Av. Packet Delay (ms)      = %.4f\n', apd)
fprintf('Throughput (Mbps)          = %.4f\n', tt)