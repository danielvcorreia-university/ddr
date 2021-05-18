%% 3.a
% the probability of the link being in one of the five states;

p1 = 1 / (1 + 1/180 + 1/180 * 20/40 + 1/180 * 20/40 * 10/20 + 1/180 * 20/40 * 10/20 * 5/2);
p2 = 1/180 / (1 + 1/180 + 1/180 * 20/40 + 1/180 * 20/40 * 10/20 + 1/180 * 20/40 * 10/20 * 5/2);
p3 = 1/180 * 20/40 / (1 + 1/180 + 1/180 * 20/40 + 1/180 * 20/40 * 10/20 + 1/180 * 20/40 * 10/20 * 5/2);
p4 = 1/180 * 20/40 * 10/20 / (1 + 1/180 + 1/180 * 20/40 + 1/180 * 20/40 * 10/20 + 1/180 * 20/40 * 10/20 * 5/2);
p5 = 1/180 * 20/40 * 10/20 * 5/2 / (1 + 1/180 + 1/180 * 20/40 + 1/180 * 20/40 * 10/20 + 1/180 * 20/40 * 10/20 * 5/2);

%% 3.b
% the average percentage of time the link is in each of the five states;

% a probabilidade de cada estado é igual à percentagem média de tempo que o link está nesse estado

%% 3.c
% the average ber of the link;

avg_ber = p1*10^-6 + p2*10^-5 + p3*10^-4 + p4*10^-3 + p5*10^-2; 

%% 3.d
% the average time duration (in minutes) that the link stays in each of the five states

avg_t1 = 1 / 1 * 60;
avg_t2 = 1 / (20+180) * 60;
avg_t3 = 1 / (10+40) * 60;
avg_t4 = 1 / (5+20) * 60;
avg_t5 = 1 / (2) * 60;

%% 3.e
% the probability of the link being in interference state
% Inference state is 10^-3 or greater

p_inference = p4 + p5;

%% 3.f
% the average ber of the link when it is in the interference state.

avg_ber_interference = (p4*10^-3 + p5*10^-2) / (p4 + p5);