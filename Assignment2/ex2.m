%% ex 2.a

R = 10000;
lambda = [100, 120, 140, 160, 180, 200];
p = 20;
% Configuration 1 %
N = 10;
n = 10;
S = 100;
W = 0;
fname = 'movies.txt';

blocking = zeros(1, length(lambda));
blocking_errhigh = zeros(1, length(lambda));
blocking_errlow = zeros(1, length(lambda));

occupation = zeros(1, length(lambda));
occupation_errhigh = zeros(1, length(lambda));
occupation_errlow = zeros(1, length(lambda));

for i = 1:length(lambda)
    for j = 1:N
        [b(j), o(j)] = simulator2(lambda(i),p,n,S,W,R,fname);
    end
    
    %90% confidence interval%
    alfa = 0.1;                          
    blocking(i) = mean(b);
    blocking_errhigh(i) = norminv(1-alfa/2) * sqrt(var(b)/N);
    blocking_errlow(i) = blocking_errhigh(i);
    
    occupation(i) = mean(o);
    occupation_errhigh(i) = norminv(1-alfa/2) * sqrt(var(o)/N);
    occupation_errlow(i) = blocking_errhigh(i);
end

figure(1)
bar(lambda, blocking);
title('Blocking Probabilities of 4K Movies');
grid on

hold on

er = errorbar(lambda, blocking, blocking_errlow, blocking_errhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';

hold off

figure(2)
bar(lambda, occupation);
title('Blocking Probabilities of HD Movies');
ylim([0, 100]);
grid on

hold on

er = errorbar(lambda, occupation, occupation_errlow, occupation_errhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';

hold off

%% 2.b

R = 10000;
lambda = [100, 120, 140, 160, 180, 200];
p = 20;
% Configuration 1, 2, 3 %
n = [10, 4, 1];
N = 10;
S = [100, 250, 1000];
W = 0;
fname = 'movies.txt';

blocking = zeros(1, length(lambda));
occupation = zeros(1, length(lambda));

blocking2 = zeros(1, length(lambda));
occupation2 = zeros(1, length(lambda));

blocking3 = zeros(1, length(lambda));
occupation3 = zeros(1, length(lambda));

for i = 1:length(lambda)
    for l = 1:3
        for j = 1:N
            [b(j), o(j)] = simulator2(lambda(i),p,n(l),S(l),W,R,fname);
        end

        if l == 1                      
            blocking(i) = mean(b);
            occupation(i) = mean(o);
        elseif l == 2                       
            blocking2(i) = mean(b);
            occupation2(i) = mean(o);
        elseif l == 3                     
            blocking3(i) = mean(b);
            occupation3(i) = mean(o);
        end
    end
end

figure(1)
bar(lambda, [blocking;blocking2;blocking3]);
title('Blocking Probabilities of 4K Movies');
grid on
legend("Configuration 1 - 10 servers, 100 Mbps", "Configuration 2 - 4 servers, 250 Mbps", "Configuration 3 - 1 server, 1000 Mbps", 'Location', 'southeast');

figure(2)
bar(lambda, [occupation;occupation2;occupation3]);
title('Blocking Probabilities of HD Movies');
ylim([0, 100]);
grid on
legend("Configuration 1 - 10 servers, 100 Mbps", "Configuration 2 - 4 servers, 250 Mbps", "Configuration 3 - 1 server, 1000 Mbps", 'Location', 'northwest');

%% 2.c

R = 10000;
lambda = [100, 120, 140, 160, 180, 200];
p = 20;
% Configuration 1, 2, 3 %
n = [10, 4, 1];
N = 10;
S = [100, 250, 1000];
W = 400;
fname = 'movies.txt';

blocking = zeros(1, length(lambda));
occupation = zeros(1, length(lambda));

blocking2 = zeros(1, length(lambda));
occupation2 = zeros(1, length(lambda));

blocking3 = zeros(1, length(lambda));
occupation3 = zeros(1, length(lambda));

for i = 1:length(lambda)
    for l = 1:3
        for j = 1:N
            [b(j), o(j)] = simulator2(lambda(i),p,n(l),S(l),W,R,fname);
        end

        if l == 1                      
            blocking(i) = mean(b);
            occupation(i) = mean(o);
        elseif l == 2                       
            blocking2(i) = mean(b);
            occupation2(i) = mean(o);
        elseif l == 3                     
            blocking3(i) = mean(b);
            occupation3(i) = mean(o);
        end
    end
end

figure(1)
bar(lambda, [blocking;blocking2;blocking3]);
title('Blocking Probabilities of 4K Movies');
grid on
legend("Configuration 1 - 10 servers, 100 Mbps", "Configuration 2 - 4 servers, 250 Mbps", "Configuration 3 - 1 server, 1000 Mbps", 'Location', 'southeast');

figure(2)
bar(lambda, [occupation;occupation2;occupation3]);
title('Blocking Probabilities of HD Movies');
ylim([0, 100]);
grid on
legend("Configuration 1 - 10 servers, 100 Mbps", "Configuration 2 - 4 servers, 250 Mbps", "Configuration 3 - 1 server, 1000 Mbps", 'Location', 'northwest');

%% 2.d

R = 10000;
lambda = [100, 120, 140, 160, 180, 200];
p = 20;
% Configuration 1, 2, 3 %
n = [10, 4, 1];
N = 10;
S = [100, 250, 1000];
W = 600;
fname = 'movies.txt';

blocking = zeros(1, length(lambda));
occupation = zeros(1, length(lambda));

blocking2 = zeros(1, length(lambda));
occupation2 = zeros(1, length(lambda));

blocking3 = zeros(1, length(lambda));
occupation3 = zeros(1, length(lambda));

for i = 1:length(lambda)
    for l = 1:3
        for j = 1:N
            [b(j), o(j)] = simulator2(lambda(i),p,n(l),S(l),W,R,fname);
        end

        if l == 1                      
            blocking(i) = mean(b);
            occupation(i) = mean(o);
        elseif l == 2                       
            blocking2(i) = mean(b);
            occupation2(i) = mean(o);
        elseif l == 3                     
            blocking3(i) = mean(b);
            occupation3(i) = mean(o);
        end
    end
end

figure(1)
bar(lambda, [blocking;blocking2;blocking3]);
title('Blocking Probabilities of 4K Movies');
grid on
legend("Configuration 1 - 10 servers, 100 Mbps", "Configuration 2 - 4 servers, 250 Mbps", "Configuration 3 - 1 server, 1000 Mbps", 'Location', 'southeast');

figure(2)
bar(lambda, [occupation;occupation2;occupation3]);
title('Blocking Probabilities of HD Movies');
ylim([0, 100]);
grid on
legend("Configuration 1 - 10 servers, 100 Mbps", "Configuration 2 - 4 servers, 250 Mbps", "Configuration 3 - 1 server, 1000 Mbps", 'Location', 'northwest');

%% 2.e

R = 100000;
lambda = 100000/24;
p = 24;
n = [7, 6]; % variable %
N = 10;
S = 10000;
% W = 36000; % variable %
fname = 'movies.txt';

blocking = zeros(1, length(lambda));
occupation = zeros(1, length(lambda));

blocking2 = zeros(1, length(lambda));
occupation2 = zeros(1, length(lambda));

for i = 1:length(lambda)
    for l = 1:2
        for j = 1:N
            [b(j), o(j)] = simulator2(lambda,p,n(l),S,W,R,fname);
        end

        if l == 1                      
            blocking(i) = mean(b);
            occupation(i) = mean(o);
        elseif l == 2                       
            blocking2(i) = mean(b);
            occupation2(i) = mean(o);
        end
    end
end

figure(1)
bar(lambda, [blocking;blocking2]);
title('Blocking Probabilities of 4K Movies');
ylim([0, 2]);
grid on
legend("7 servers, 10000 Mbps", "6 server, 10000 Mbps", 'Location', 'northwest');

figure(2)
bar(lambda, [occupation;occupation2]);
title('Blocking Probabilities of HD Movies');
ylim([0, 2]);
grid on
legend("7 servers, 10000 Mbps", "6 server, 10000 Mbps", 'Location', 'northwest');
