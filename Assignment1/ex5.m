%% 5.a
% Draw  a plotusing a logarithmic scale  for  the Y-axis (use  the MATLAB function
% semilogy)with the probability of false positives for n=2, 3, 4 and 5.Analyzeand justify
% the results.

p1 = 1 / (1 + 8/600 + 8/600 * 5/200 + 8/600 * 5/200 * 2/50 + 8/600 * 5/200 * 2/50 * 1/5);
p2 = 8/600 / (1 + 8/600 + 8/600 * 5/200 + 8/600 * 5/200 * 2/50 + 8/600 * 5/200 * 2/50 * 1/5);
p3 = 8/600 * 5/200 / (1 + 8/600 + 8/600 * 5/200 + 8/600 * 5/200 * 2/50 + 8/600 * 5/200 * 2/50 * 1/5);
p4 = 8/600 * 5/200 * 2/50 / (1 + 8/600 + 8/600 * 5/200 + 8/600 * 5/200 * 2/50 + 8/600 * 5/200 * 2/50 * 1/5);
p5 = 8/600 * 5/200 * 2/50 * 1/5 / (1 + 8/600 + 8/600 * 5/200 + 8/600 * 5/200 * 2/50 + 8/600 * 5/200 * 2/50 * 1/5);

p_e1 = 1 - 1 * (10^-6)^0 * (1-(10^-6))^(64*8);
p_e2 = 1 - 1 * (10^-5)^0 * (1-(10^-5))^(64*8);
p_e3 = 1 - 1 * (10^-4)^0 * (1-(10^-4))^(64*8);
p_e4 = 1 - 1 * (10^-3)^0 * (1-(10^-3))^(64*8);
p_e5 = 1 - 1 * (10^-2)^0 * (1-(10^-2))^(64*8);

p_final = zeros(1,4);
i = 1;

for n = 2:5
    e1 = p_e1^n;
    e2 = p_e2^n;
    e3 = p_e3^n;
    e4 = p_e4^n;
    e5 = p_e5^n;
    
    p_final(i) = (e1 * p1 + e2 * p2 + e3 * p3) / (e1 * p1 + e2 * p2 + e3 * p3 + e4 * p4 + e5 * p5);
    i = i+1;
end

n = linspace(2, 5, 4);
semilogy(n,p_final,'b-');
title('Probability of false positives for N = 2,3,4,5');
xlabel('N packets of 64(Bytes)');
grid on;

%% 5.b
% Draw  a plot with the probability  of false negatives for n=2,  3, 4  and 5.Analyze and
% justify the results.

p_final_b = zeros(1,4);
i = 1;

for n = 2:5
    e1 = 1-p_e1^n;
    e2 = 1-p_e2^n;
    e3 = 1-p_e3^n;
    e4 = 1-p_e4^n;
    e5 = 1-p_e5^n;
    
    p_final_b(i) = (e4 * p4 + e5 * p5) / (e1 * p1 + e2 * p2 + e3 * p3 + e4 * p4 + e5 * p5);
    i = i+1;
end

n = linspace(2, 5, 4);
semilogy(n,p_final_b,'b-');
title('Probability of false negatives for N = 2,3,4,5');
xlabel('N packets of 64(Bytes)');
grid on;

%% 5.c
n = linspace(2, 5, 4);
semilogy(n,p_final,'b-', n,p_final_b,'b--');
title('Probability of false positives and false negatives')
xlabel('N packets of 64(Bytes)');
legend('False positives','False negatives','location','SouthWest');
grid on