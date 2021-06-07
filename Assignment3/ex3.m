%% 3.a

P= 10000;
lambda = [1500, 1600, 1700, 1800, 1900, 2000];
C= 10;
f= 10^7;
b= 0;
% Number of simulations
N= 10;
PL= zeros(1, N);
APD= zeros(1, N);
MPD= zeros(1, N);
TT= zeros(1, N);

pl= zeros(1, length(lambda));
pl_errhigh= zeros(1, length(lambda));
pl_errlow= zeros(1, length(lambda));

apd= zeros(1, length(lambda));
apd_errhigh= zeros(1, length(lambda));
apd_errlow= zeros(1, length(lambda));

mpd= zeros(1, length(lambda));
mpd_errhigh= zeros(1, length(lambda));
mpd_errlow= zeros(1, length(lambda));

tt= zeros(1, length(lambda));
tt_errhigh= zeros(1, length(lambda));
tt_errlow= zeros(1, length(lambda));

for i = 1:length(lambda)
    for j = 1:N
        [PL(j) , APD(j) , MPD(j) , TT(j)]= Simulator2(lambda(i),C,f,P,b);
    end
    
    % 90 percent confidence interval
    alfa= 0.1;

    % packet loss (%)
    pl(i)= mean(PL);
    pl_errhigh(i)= norminv(1-alfa/2) * sqrt(var(PL)/N);
    pl_errlow(i)= pl_errhigh(i);

    % average packet delay (milliseconds)
    apd(i)= mean(APD);
    apd_errhigh(i)= norminv(1-alfa/2) * sqrt(var(APD)/N);
    apd_errlow(i)= apd_errhigh(i);

    % maximum packet delay (milliseconds)
    mpd(i)= mean(MPD);
    mpd_errhigh(i)= norminv(1-alfa/2) * sqrt(var(MPD)/N);
    mpd_errlow(i)= mpd_errhigh(i);

    % transmitted throughput (Mbps)
    tt(i)= mean(TT);
    tt_errhigh(i)= norminv(1-alfa/2) * sqrt(var(TT)/N);
    tt_errlow(i)= tt_errhigh(i);
end

figure(1)
bar(lambda, apd);
title('Average packet delay (milliseconds)');
grid on
hold on
er = errorbar(lambda, apd, apd_errlow, apd_errhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';
hold off

figure(2)
bar(lambda, mpd);
title('Maximum packet delay (milliseconds)');
grid on
hold on
er = errorbar(lambda, mpd, mpd_errlow, mpd_errhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';
hold off

figure(3)
bar(lambda, tt);
title('Transmitted throughput (Mbps)');
grid on
hold on
er = errorbar(lambda, tt, tt_errlow, tt_errhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';
hold off

%% 3.b

P= 10000;
lambda = [1500, 1600, 1700, 1800, 1900, 2000];
C= 10;
f= 10^7;
b= 0;
% Number of simulations
N= 40;
PL= zeros(1, N);
APD= zeros(1, N);
MPD= zeros(1, N);
TT= zeros(1, N);

pl= zeros(1, length(lambda));
pl_errhigh= zeros(1, length(lambda));
pl_errlow= zeros(1, length(lambda));

apd= zeros(1, length(lambda));
apd_errhigh= zeros(1, length(lambda));
apd_errlow= zeros(1, length(lambda));

mpd= zeros(1, length(lambda));
mpd_errhigh= zeros(1, length(lambda));
mpd_errlow= zeros(1, length(lambda));

tt= zeros(1, length(lambda));
tt_errhigh= zeros(1, length(lambda));
tt_errlow= zeros(1, length(lambda));

for i = 1:length(lambda)
    for j = 1:N
        [PL(j) , APD(j) , MPD(j) , TT(j)]= Simulator2(lambda(i),C,f,P,b);
    end
    
    % 90 percent confidence interval
    alfa= 0.1;

    % packet loss (%)
    pl(i)= mean(PL);
    pl_errhigh(i)= norminv(1-alfa/2) * sqrt(var(PL)/N);
    pl_errlow(i)= pl_errhigh(i);

    % average packet delay (milliseconds)
    apd(i)= mean(APD);
    apd_errhigh(i)= norminv(1-alfa/2) * sqrt(var(APD)/N);
    apd_errlow(i)= apd_errhigh(i);

    % maximum packet delay (milliseconds)
    mpd(i)= mean(MPD);
    mpd_errhigh(i)= norminv(1-alfa/2) * sqrt(var(MPD)/N);
    mpd_errlow(i)= mpd_errhigh(i);

    % transmitted throughput (Mbps)
    tt(i)= mean(TT);
    tt_errhigh(i)= norminv(1-alfa/2) * sqrt(var(TT)/N);
    tt_errlow(i)= tt_errhigh(i);
end

figure(1)
bar(lambda, apd);
title('Average packet delay (milliseconds)');
grid on
hold on
er = errorbar(lambda, apd, apd_errlow, apd_errhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';
hold off

figure(2)
bar(lambda, mpd);
title('Maximum packet delay (milliseconds)');
grid on
hold on
er = errorbar(lambda, mpd, mpd_errlow, mpd_errhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';
hold off

figure(3)
bar(lambda, tt);
title('Transmitted throughput (Mbps)');
grid on
hold on
er = errorbar(lambda, tt, tt_errlow, tt_errhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';
hold off

%% 3.c

