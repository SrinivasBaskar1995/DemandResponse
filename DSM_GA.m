population=zeros(14,200);
population_x=zeros(14,200);
age=zeros(1,200);
counter=0;
prev=0;
for i=1:200
    for j=1:14
        if load_time(j)+12>24
            finish=24;
        else
            finish=load_time(j)+12;
        end
        population(j,i)=randi([load_time(j),finish]);
    end
end
for i=1:200
    for j=1:14
        population_x(j,i)=randi([1,cntrb_load(j,4)]);
    end
end
iterations=1;
while iterations<=500&&counter<50
    for i=1:200
        age(1,i)=age(1,i)+1;
    end
    fitness_value=zeros(1,200);
    for i=1:200
        fitness_value(1,i)=fitness_DSM_GA(population_x(:,i),i,population,cntrb_load,load_time,forecasted_load,obj);
    end
    fnorm=(fitness_value./sum(fitness_value));
    fcum=zeros(1,200);
    fcum(1,1)=fnorm(1,1);
    for i=2:200
        fcum(1,i)=fnorm(1,i)+fcum(1,i-1);
    end
    next_pop=zeros(14,200);
    next_pop_x=zeros(14,200);
    for i=1:200
        n=randi([0,1000000]);
        n=n/100000000;
        if n<=fcum(1)
            next_pop(:,i)=population(:,1);
            next_pop_x(:,i)=population_x(:,1);
        else
            for j=2:200
                if n>fcum(j-1)&&n<=fcum(j)
                    next_pop(:,i)=population(:,j);
                    next_pop_x(:,i)=population_x(:,j);
                    break
                end
            end
        end
    end
    for i=1:2:100
        x=randi(1,100);
        if x<=90
            crossover=1;
        else
            crossover=0;
        end
        if crossover==1
            ini=randi([1,14]);
            fin=randi([ini,14]);
            for j=ini:fin
                temp=next_pop(j,i);
                next_pop(j,i)=next_pop(j,i+1);
                next_pop(j,i+1)=temp;
                temp=next_pop_x(j,i);
                next_pop_x(j,i)=next_pop_x(j,i+1);
                next_pop_x(j,i+1)=temp;
            end
        end
    end
    for i=1:200
        x=randi(1,100);
        if x<=10
            mutation=1;
        else
            mutation=0;
        end
        if mutation==1
            ini=randi([1,14]);
            if load_time(ini,1)+12>24
                finish=24;
            else
                finish=load_time(ini,1)+12;
            end
            next_pop(ini,i)=randi([load_time(ini,1)+1,finish]);
            next_pop_x(ini,i)=randi([1,cntrb_load(ini,4)]);
        end
    end
    it1=0;
    max1=0;
    it2=0;
    max2=0;
    for i=1:200
        if age(1,i)>max1
            max2=max1;
            it2=it1;
            max1=age(1,i);
            it1=i;
        else
            if age(1,i)>max2
                max2=age(1,i);
                it2=i;
            end
        end
    end
    age(1,it2)=0;
    age(1,it1)=0;
    iterations=iterations+1
    max_fitness1=0;
    max_i1=0;
    max_fitness2=0;
    max_i2=0;
    for i=1:200
        fitness_value(1,i)=fitness_DSM_GA(next_pop_x(:,i),i,next_pop,cntrb_load,load_time,forecasted_load,obj);
        if fitness_value(1,i)>max_fitness1
            max_fitness2=max_fitness1;
            max_i2=max_i1;
            max_fitness1=fitness_value(1,i);
            max_i1=i;
        else
            if fitness_value(1,i)>max_fitness2
                max_fitness2=fitness_value(1,i);
                max_i2=i;
            end
        end
    end
    population(:,it1)=next_pop(:,max_i1);
    population(:,it2)=next_pop(:,max_i2);
    if max_fitness1-prev<0.0000000001
        counter=counter+1;
    else
        counter=0;
    end
    prev=max_fitness1;
end
max_fitness=0;
maxi=0;
for i=1:200
        fitness_value(1,i)=fitness_DSM_GA(population_x(:,i),i,population,cntrb_load,load_time,forecasted_load,obj);
        if fitness_value(1,i)>max_fitness
            max_fitness=fitness_value(1,i);
            maxi=i;
        end
end
iter=maxi;
connect=zeros(24,1);
disconnect=zeros(24,1);
sum1=0;
sum2=0;
sum3=0;
for i=1:24
    for k=1:14
        if population(k,iter)==i
            sum1=sum1+(population_x(k,iter)*cntrb_load(k,1));
        end
        if population(k,iter)==i-1
            sum2=sum2+(population_x(k,iter)*cntrb_load(k,2));
        end
        if population(k,iter)==i-2
            sum3=sum3+(population_x(k,iter)*cntrb_load(k,3));
        end
    end
    connect(i,1)=sum1+sum2+sum3;
end
sum1=0;
sum2=0;
sum3=0;
for i=1:24
    for k=1:14
        if load_time(k,1)==i && population(k,iter)~=i
            sum1=sum1+(population_x(k,iter)*cntrb_load(k,1));
        end
        if load_time(k,1)==i-1 && population(k,iter)~=i-1
            sum2=sum2+(population_x(k,iter)*cntrb_load(k,2));
        end
        if load_time(k,1)==i-2 && population(k,iter)~=i-2
            sum3=sum3+(population_x(k,iter)*cntrb_load(k,3));
        end
    end
    disconnect(i,1)=sum1+sum2+sum3;
end
pload=forecasted_load+connect-disconnect;