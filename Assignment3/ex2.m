%% 2.a

P= 10000;
lambda= 1800;
C= 10;
f= 1000000;
b= 10^-6;
% Number of simulations
N= 20;
PL= zeros(1, N);
APD= zeros(1, N);
MPD= zeros(1, N);
TT= zeros(1, N);

for i = 1:N
    [PL(i) , APD(i) , MPD(i) , TT(i)]= Simulator2(lambda,C,f,P,b);
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

%% 2.b

P= 10000;
lambda= 1800;
C= 10;
f= 1000000;
b= 10^-5;
% Number of simulations
N= 20;
PL= zeros(1, N);
APD= zeros(1, N);
MPD= zeros(1, N);
TT= zeros(1, N);

for i = 1:N
    [PL(i) , APD(i) , MPD(i) , TT(i)]= Simulator2(lambda,C,f,P,b);
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

%% 2.c

P= 10000;
lambda= 1800;
C= 10;
f= 1000000;
b= 10^-6;

otherProbabilities= (1-0.16-0.25-0.2)/1452;
packetsSize= (64:1518);
probPacketsSize= zeros(1, length(packetsSize));
averagePacketDelay= zeros(1, length(packetsSize));
probPacketsWithoutErrors= zeros(1, length(packetsSize));

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
    
    probPacketsWithoutErrors(i)= (1-b)^(8*packetsSize(i));
end

% Packet Loss (PL)
pl= 0;
for i = 1:length(packetsSize)
    pl= pl + probPacketsSize(i) * (1-probPacketsWithoutErrors(i));
end
pl= pl * 100;

% Average Packet Delay (APD)
averagePacketTrans= 0;
averageSquarePackTrans= 0;
for i = 1:length(packetsSize)
    temp= 8 * packetsSize(i) / (C*1e6);
    averagePacketTrans= averagePacketTrans + probPacketsSize(i) * temp;
    averageSquarePackTrans= averageSquarePackTrans + probPacketsSize(i) * temp^2;
end

averageQueueDelay= lambda * averageSquarePackTrans / (2 * (1-lambda*averagePacketTrans));

term1= 0;
term2= 0;
for i = 1:length(packetsSize)
    averagePacketDelay(i)= averageQueueDelay + 8 * packetsSize(i) / (C*1e6);
    temp= probPacketsSize(i) * probPacketsWithoutErrors(i);
    term1= term1 + (temp * averagePacketDelay(i));
    term2= term2 + temp;
end
apd= term1 / term2;

% Total Throughput (TT)
tt= 0;
for i = 1:length(packetsSize)
    tt= tt + (probPacketsSize(i) * probPacketsWithoutErrors(i) * lambda * (8*packetsSize(i)));
end

fprintf('Packet Lost (%%)           = %.4f\n', pl)
fprintf('Av. Packet Delay (ms)     = %.4f\n', apd * 1000)
fprintf('Throughput (Mbps)         = %4f\n', tt / 1e6)

%% 2.d

P= 10000;
lambda= 1800;
C= 10;
f= 1000000;
b= 10^-5;

otherProbabilities= (1-0.16-0.25-0.2)/1452;
packetsSize= (64:1518);
probPacketsSize= zeros(1, length(packetsSize));
averagePacketDelay= zeros(1, length(packetsSize));
probPacketsWithoutErrors= zeros(1, length(packetsSize));

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
    
    probPacketsWithoutErrors(i)= (1-b)^(8*packetsSize(i));
end

% Packet Loss (PL)
pl= 0;
for i = 1:length(packetsSize)
    pl= pl + probPacketsSize(i) * (1-probPacketsWithoutErrors(i));
end
pl= pl * 100;

% Average Packet Delay (APD)
averagePacketTrans= 0;
averageSquarePackTrans= 0;
for i = 1:length(packetsSize)
    temp= 8 * packetsSize(i) / (C*1e6);
    averagePacketTrans= averagePacketTrans + probPacketsSize(i) * temp;
    averageSquarePackTrans= averageSquarePackTrans + probPacketsSize(i) * temp^2;
end

averageQueueDelay= lambda * averageSquarePackTrans / (2 * (1-lambda*averagePacketTrans));

term1= 0;
term2= 0;
for i = 1:length(packetsSize)
    averagePacketDelay(i)= averageQueueDelay + 8 * packetsSize(i) / (C*1e6);
    temp= probPacketsSize(i) * probPacketsWithoutErrors(i);
    term1= term1 + (temp * averagePacketDelay(i));
    term2= term2 + temp;
end
apd= term1 / term2;

% Total Throughput (TT)
tt= 0;
for i = 1:length(packetsSize)
    tt= tt + (probPacketsSize(i) * probPacketsWithoutErrors(i) * lambda * (8*packetsSize(i)));
end

fprintf('Packet Lost (%%)           = %.4f\n', pl)
fprintf('Av. Packet Delay (ms)     = %.4f\n', apd * 1000)
fprintf('Throughput (Mbps)         = %4f\n', tt / 1e6)