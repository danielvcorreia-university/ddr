% Consider  a  wireless  link between  multiple  stations  for  data  communications with  a  bit  error
% rate(ber)  of𝑝.Assume  that errors  in  the  different  bits  of  a  data  packet  are  statistically
% independent(i.e., the number of errors of a data packet is a binomial random variable).

%% 2.a
% Determine  the  probability  of  a  data  packet  of  100  Bytes  to  be  received  without  errors
% when 𝑝=10^−2. Answer: 0.0322%

n = 100 * 8;
p = 10^-2;
i = 0;

% p_final = nchoosek(n, i) * p^i * (1-p)^(n-i)
p_2a_percentage = ((1-p)^(n-i)) * 100

%% 2.b
% Determine  the  probability  of a  data  packet  of  1000  Bytes  to  be  received  with  exactly
% one errorwhen 𝑝=10−3.Answer: 0.2676%

n = 1000 * 8;
p = 10^-3;
i = 1;

p_2b_percentage = (nchoosek(n, i) * p^i * (1-p)^(n-i)) * 100

%% 2.c
% Determine the probability of a data packet of 200 Bytes to be received with one or more
% errorswhen 𝑝=10−4. Answer: 14.7863%

n = 200 * 8;
p = 10^-4;
i = 0;

% p(>=1) == 1 - p(0)
p_2c_percentage = (1 - nchoosek(n, i) * p^i * (1-p)^(n-i)) * 100

%% 2.d

x = logspace(-8,-2);
f1 = nchoosek(100*8, 0) .* x.^0 .* (1-x).^(100*8-0);
f2 = nchoosek(200*8, 0) .* x.^0 .* (1-x).^(200*8-0);
f3 = nchoosek(1000*8, 0) .* x.^0 .* (1-x).^(1000*8-0);
semilogx(x,f1*100,'b-',x,f2*100,'b--',x,f3*100,'b:');
title('Probability of packet reception without errors (%)')
xlabel('Bit Error Rate')
legend('100 bytes','200 bytes','1000 bytes','location','SouthWest');
ylim([0 100])
grid on

%% 2.e
% Draw a plotwith the same look as the answer belowof the probability of a data packet
% being received without errors (for 𝑝=10−4, 10−3and 10−2)as a function of the packet
% size (from 64 Bytes up to 1518 Bytes).

x = linspace(64, 1518);
f1 = 1 * (10^-4).^0 * (1-10^-4).^(x*8-0);
f2 = 1 * (10^-3).^0 * (1-10^-3).^(x*8-0);
f3 = 1 * (10^-2).^0 * (1-10^-2).^(x*8-0);
semilogy(x,f1,'b-',x,f2,'b--',x,f3,'b:');
title('Probability of packet reception without errors')
xlabel('Packet size (Bytes)')
legend('ber=1e-4','ber=1e-3','ber=1e-2','location','SouthWest');
xlim([0 1600])
grid on