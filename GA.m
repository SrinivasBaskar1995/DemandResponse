% Program for Genetic algorithm to minimize the constrained function ga_test
clear all;
clc;
% Setup the Genetic Algorithm
fitnessfunction= @ga_test;
N = 1310;  % number of optimization (decision) variables
popsize = 8 ; % set population size = number of chromosomes
max_iteration = 50;  % max number of iterations
minimum_cost = 120;  % minimum cost
mutation_rate = 0.01; % mutation rate
selection_rate = 0.5; % selection rate: fraction of population 
nbits = 1;
Nt = nbits*N; % total number of bits in a chormosome
number_mutations = mutation_rate*N*(popsize-1); % number of mutations
% #population members that survive (Nkeep = Xrate*Npop); Nkeep survive for mating, and (Npop - Nkeep) are discarded to make room for the new offspring
keep = floor(selection_rate*popsize); 
iga=0; % generation counter initialized
pop=round(rand(popsize,Nt)); % random population of 1s and 0s
cost=feval(fitnessfunction,pop); % calculates population cost using fitnessfunction
[cost,ind]=sort(cost); % min cost in element 1
pop=pop(ind,:); % sorts population with lowest cost first
minc(1)=min(cost); % minc contains min of population
while iga < max_iteration  %Iterate through generations
iga=iga+1; % increments generation counter
% Pair and mate
M=ceil((M-keep)/2); % number of matings weights chromosomes based upon position in list probability distribution function
prob=flipud([1:keep]'/sum([1:keep])); 
odds=[0 cumsum(prob(1:keep))]; 
pick1=rand(1,popsize); % mate #1
pick2=rand(1,popsize); % mate #2
% parents contain the indicies of the chromosomes that will mate
ic=1;
while ic<=M
for id=2:keep+1
if pick1(ic)<=odds(id) & pick1(ic)>odds(id-1)
ma(ic)=id-1;
end % if
if pick2(ic)<=odds(id) & pick2(ic)>odds(id-1)
pa(ic)=id-1;
end % if
end % id
ic=ic+1;
end % while
ix=1:2:keep; % index of mate #1
xp=ceil(rand(1,M)*(Nt-1)); % crossover point
pop(keep+ix,:)=[pop(ma,1:xp) pop(pa,xp+1:Nt)];
% first offspring
pop(keep+ix+1,:)=[pop(pa,1:xp) pop(ma,xp+1:Nt)];
% second offspring
%_______________________________________________________
% Mutate the population
number_mutations=ceil((popsize-1)*Nt*mutation_rate); % total number of mutations
mrow=ceil(rand(1,number_mutations)*(popsize-1))+1; % row to mutate
mcol=ceil(rand(1,number_mutations)*Nt); % column to mutate
for ii=1:number_mutations
pop(mrow(ii),mcol(ii))=abs(pop(mrow(ii),mcol(ii))-1);
end 
%_______________________________________________________
% The population is re-evaluated for cost decode
cost(2:popsize)=feval(fitnessfunction,pop(2:popsize,:));
%_______________________________________________________
% Sort the costs and associated parameters
[cost,ind]=sort(cost);
pop=pop(ind,:);
%_______________________________________________________
% Stopping criteria
if iga>maxit | cost(1)<mincost
break
end
[iga cost(1)]
end