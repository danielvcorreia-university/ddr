%% 4.a

P= 100000;
lambda= 1800;
C= 10;
f= 1000000;
b= 0;
% Number of simulations
N= 10;
PL= zeros(1, N);
APD= zeros(1, N);
MPD= zeros(1, N);
TT= zeros(1, N);

for i = 1:N
    [PL(i) , APD(i) , MPD(i) , TT(i)]= Simulator3(lambda,C,f,P,b);
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