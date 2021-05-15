%% 1.a

lambda= 20;
C= 100;
M= 4;
R= 500;
fname= 'movies.txt';

%number of simulations
N = 10;
b = zeros(1, N);
o = zeros(1, N);

for i = 1:N
    [b(i), o(i)] = simulator1(lambda,C,M,R,fname);
end

%90% confidence interval%
alfa = 0.1;                          
blocking = mean(b);
term = norminv(1-alfa/2) * sqrt(var(b)/N);

occupation = mean(o);
term1 = norminv(1-alfa/2) * sqrt(var(o)/N);

fprintf('Blocking probability (%%)= %.2e +-%.2e\n', blocking, term)

fprintf('Average occupation (Mbps)= %.2e +-%.2e\n', occupation, term1)

%% 1.b

lambdaValues= [10, 15, 20, 25, 30, 35, 40];

blocking = zeros(1, length(lambdaValues));
blocking_errhigh = zeros(1, length(lambdaValues));
blocking_errlow = zeros(1, length(lambdaValues));

occupation = zeros(1, length(lambdaValues));
occupation_errhigh = zeros(1, length(lambdaValues));
occupation_errlow = zeros(1, length(lambdaValues));

for i = 1:length(lambdaValues)
    for j = 1:N
        [b(j), o(j)] = simulator1(lambdaValues(i),C,M,R,fname);
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
bar(lambdaValues, blocking);
grid on

hold on

er = errorbar(lambdaValues, blocking, blocking_errlow, blocking_errhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';

hold off

figure(2)
bar(lambdaValues, occupation);
grid on

hold on

er = errorbar(lambdaValues, occupation, occupation_errlow, occupation_errhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';

hold off

%% 1.c

R= 5000;

lambdaValues= [10, 15, 20, 25, 30, 35, 40];

blocking = zeros(1, length(lambdaValues));
blocking_errhigh = zeros(1, length(lambdaValues));
blocking_errlow = zeros(1, length(lambdaValues));

occupation = zeros(1, length(lambdaValues));
occupation_errhigh = zeros(1, length(lambdaValues));
occupation_errlow = zeros(1, length(lambdaValues));

for i = 1:length(lambdaValues)
    for j = 1:N
        [b(j), o(j)] = simulator1(lambdaValues(i),C,M,R,fname);
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
bar(lambdaValues, blocking);
grid on

hold on

er = errorbar(lambdaValues, blocking, blocking_errlow, blocking_errhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';

hold off

figure(2)
bar(lambdaValues, occupation);
grid on

hold on

er = errorbar(lambdaValues, occupation, occupation_errlow, occupation_errhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';

hold off

%% 1.d

R= 5000;
C= 1000;
M= 4;

lambdaValues= [100, 150, 200, 250, 300, 350, 400];

blocking = zeros(1, length(lambdaValues));
blocking_errhigh = zeros(1, length(lambdaValues));
blocking_errlow = zeros(1, length(lambdaValues));

occupation = zeros(1, length(lambdaValues));
occupation_errhigh = zeros(1, length(lambdaValues));
occupation_errlow = zeros(1, length(lambdaValues));

for i = 1:length(lambdaValues)
    for j = 1:N
        [b(j), o(j)] = simulator1(lambdaValues(i),C,M,R,fname);
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
bar(lambdaValues, blocking);
grid on

hold on

er = errorbar(lambdaValues, blocking, blocking_errlow, blocking_errhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';

hold off

figure(2)
bar(lambdaValues, occupation);
grid on

hold on

er = errorbar(lambdaValues, occupation, occupation_errlow, occupation_errhigh);
er.Color = [0 0 0];
er.LineStyle = 'none';

hold off

%% 1.e

