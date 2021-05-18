% Consider a multiple choice testsuch that each question has npossible answers and only one is
% correct.  Assume  that  the  student  has  studied  a  percentage 𝑝(with 0%≤𝑝≤100%)  of  the
% test  content.  When aquestion addressesthe  content the  studenthas  studied,  he  selects  the
% right answerwith 100%  of probability. Otherwise, he selects randomly one of the nanswers
% with a uniform distribution.

% Acontecimentos:
% E  - O aluno responde corretamente 
% F1 - O aluno sabe a resposta
% F2 - O aluno não sabe a resposta

%% 1.a
% When 𝑝=60%and 𝑛=4,  determine  the  probability  
% of  the  student  to  select  the  right answer.Answer: 70%

% P(E) = P(E|F1) * F1 + P(E|F2) * P(F2)
% p == F1

p = 0.6;
n = 4;

p_final = 1 * p + 1/n * (1-p);
p_1a_percentage = p_final * 100

%% 1.b
% When 𝑝=70%and 𝑛=5,  determine  the  probability  of  the student  to  known  the
% answer when he selects the right answer.Answer: 92.1%

% P (F1|E) = P(E|F1) * F1 / P(E)

p = 0.7;
n = 5;

p_final = 1 * p / (p + (1-p)/n);
p_1b_percentage = p_final * 100

%% 1.c
x= linspace(0,1,100);
f1= 1*x + 1/3 * (1-x);
f2= 1*x + 1/4 * (1-x);
f3= 1*x + 1/5 * (1-x);

plot(x*100,f1*100,'b-',x*100,f2*100,'b--',x*100,f3*100,'b:');
xlabel('percentage of test content studied')
legend('n=3','n=4','n=5','location','NorthWest');
ylim([0 100])
title('Probability of right answer (%)')
grid on

%% 1.d
x= linspace(0,1,100);
f1 = x ./ (x + (1-x)/3);
f2 = x ./ (x + (1-x)/4);
f3 = x ./ (x + (1-x)/5);
plot(x*100,f1*100,'b-',x*100,f2*100,'b--',x*100,f3*100,'b:');
title('Probability of knowing the answer')
xlabel('p(%)')
legend('n=3','n=4','n=5','location','NorthWest');
ylim([0 100])
grid on