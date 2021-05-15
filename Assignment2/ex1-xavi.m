%% Ex 1a
lambda = 20;
C = 100;
M = 4;
R = 500;
fname = 'movies.txt'
N = 10;
results = zeros(2,N);

for it = 1:N
    [results(1,it) results(2,it)] = simulator1(lambda,C,M,R,fname)
end
alfa = 0.1;
media = mean(results(1,:));
term = norminv(1-alfa/2)*sqrt(var(results(1,:))/N);

media2 = mean(results(2,:));
term2 = norminv(1-alfa/2)*sqrt(var(results(2,:))/N);


fprintf('Blocking probability(%%) = %.2e +- %.2e\n',media,term)
fprintf('Average occupation(Mbps) = %.2e +- %.2e\n',media2,term2)

%% Ex 1b

lambda = [10 15 20 25 30 35 40];
C = 100;
M = 4;
R = 500;
fname = 'movies.txt'
N = 10;

media,term,media2,term2 = zeros(1,7);

for i = 1:7
    
    results = zeros(2,N);
    
    for it = 1:N
        [results(1,it) results(2,it)] = simulator1(lambda(i),C,M,R,fname);
    end
    alfa = 0.1;
    media(i) = mean(results(1,:));
    term(i) = norminv(1-alfa/2)*sqrt(var(results(1,:))/N);

    media2(i) = mean(results(2,:));
    term2(i) = norminv(1-alfa/2)*sqrt(var(results(2,:))/N);

end

figure(1)
bar(lambda,media)

hold on

er = errorbar(lambda,media,term);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
ylim([-10 60])
grid on
title('Blocking probability (%)')
xlabel('λ(requests/hour)')

hold off

figure(2)
bar(lambda,media2)

hold on

er = errorbar(lambda,media2,term2);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
ylim([0 100])
grid on
title('Average server occupation (Mbps)')
xlabel('λ(requests/hour)')

hold off

%% Ex 1c

lambda = [10 15 20 25 30 35 40];
C = 100;
M = 4;
R = 5000;
fname = 'movies.txt'
N = 10;

media,term,media2,term2 = zeros(1,7);

for i = 1:7
    
    results = zeros(2,N);
    
    for it = 1:N
        [results(1,it) results(2,it)] = simulator1(lambda(i),C,M,R,fname);
    end
    alfa = 0.1;
    media(i) = mean(results(1,:));
    term(i) = norminv(1-alfa/2)*sqrt(var(results(1,:))/N);

    media2(i) = mean(results(2,:));
    term2(i) = norminv(1-alfa/2)*sqrt(var(results(2,:))/N);

end

figure(3)
bar(lambda,media)

hold on

er = errorbar(lambda,media,term);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
ylim([-10 60])
grid on
title('Blocking probability (%)')
xlabel('λ(requests/hour)')

hold off

figure(4)
bar(lambda,media2)

hold on

er = errorbar(lambda,media2,term2);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
ylim([0 100])
grid on
title('Average server occupation (Mbps)')
xlabel('λ(requests/hour)')

hold off

%% Ex 1d

lambda = [100 150 200 250 300 350 400];
C = 1000;
M = 4;
R = 5000;
fname = 'movies.txt'
N = 10;

media,term,media2,term2 = zeros(1,7);

for i = 1:7
    
    results = zeros(2,N);
    
    for it = 1:N
        [results(1,it) results(2,it)] = simulator1(lambda(i),C,M,R,fname);
    end
    alfa = 0.1;
    media(i) = mean(results(1,:));
    term(i) = norminv(1-alfa/2)*sqrt(var(results(1,:))/N);

    media2(i) = mean(results(2,:));
    term2(i) = norminv(1-alfa/2)*sqrt(var(results(2,:))/N);

end

figure(5)
bar(lambda,media)

hold on

er = errorbar(lambda,media,term);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
ylim([-10 60])
grid on
title('Blocking probability (%)')
xlabel('λ(requests/hour)')

hold off

figure(6)
bar(lambda,media2)

hold on

er = errorbar(lambda,media2,term2);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  
ylim([0 1000])
grid on
title('Average server occupation (Mbps)')
xlabel('λ(requests/hour)')

hold off

%% Ex 1e

lambda = [10 15 20 25 30 35 40];
C = 100;
M = 4;
R = 5000;
fname = 'movies.txt'
N = 10;

media,term,media2,term2 = zeros(2,7);

for i = 1:7
    
    results = zeros(2,N);
    
    for it = 1:N
        [results(1,it) results(2,it)] = simulator1(lambda(i),C,M,R,fname);
    end
    alfa = 0.1;
    media(1,i) = mean(results(1,:));
    term(1,i) = norminv(1-alfa/2)*sqrt(var(results(1,:))/N);

    media2(1,i) = mean(results(2,:));
    term2(1,i) = norminv(1-alfa/2)*sqrt(var(results(2,:))/N);
    
    ro = lambda(i)/(1/(86.3/60));
    
    a= 1;
    p= 1;
    for n= 100/4:-1:1
        a= a*n/ro;
        p= p+a;
    end
    
    media(2,i)= (1/p)*100;  

    a= 100/4;
    numerator= a;
    for j= 25-1:-1:1
        a= a*j/ro;
        numerator= numerator+a;
    end
    a= 1;
    denominator= a;
    for j= 25:-1:1
        a= a*j/ro;
        denominator= denominator+a;
    end
    
    media2(2,i) = (numerator/denominator)*M;
end

figure(7)
bar(lambda,media)
ylim([-10 60])
grid on

title('Blocking probability (%)')
xlabel('λ(requests/hour)')



figure(8)
bar(lambda,media2)

ylim([0 100])
grid on
title('Average server occupation (Mbps)')
xlabel('λ(requests/hour)')

%% Ex 1f
lambda = [100 150 200 250 300 350 400];
C = 1000;
M = 4;
R = 20000;
fname = 'movies.txt'
N = 10;

media,term,media2,term2 = zeros(2,7);

for i = 1:7
    
    results = zeros(2,N);
    
    for it = 1:N
        [results(1,it) results(2,it)] = simulator1(lambda(i),C,M,R,fname);
    end
    alfa = 0.1;
    media(1,i) = mean(results(1,:));
    term(1,i) = norminv(1-alfa/2)*sqrt(var(results(1,:))/N);

    media2(1,i) = mean(results(2,:));
    term2(1,i) = norminv(1-alfa/2)*sqrt(var(results(2,:))/N);
    
    ro = lambda(i)/(1/(86.3/60));
    
    a= 1;
    p= 1;
    for n= 1000/4:-1:1
        a= a*n/ro;
        p= p+a;
    end
    
    media(2,i)= (1/p)*100;  

    a= 1000/4;
    numerator= a;
    for j= 250-1:-1:1
        a= a*j/ro;
        numerator= numerator+a;
    end
    a= 1;
    denominator= a;
    for j= 250:-1:1
        a= a*j/ro;
        denominator= denominator+a;
    end
    
    media2(2,i) = (numerator/denominator)*M;
end

figure(9)
bar(lambda,media)
ylim([-10 60])
grid on

title('Blocking probability (%)')
xlabel('λ(requests/hour)')



figure(10)
bar(lambda,media2)

grid on
title('Average server occupation (Mbps)')
xlabel('λ(requests/hour)')

