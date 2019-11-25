population=zeros(14,200);
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
        population(j,i)=randi([load_time(j)+1,finish]);
    end
end
iterations=1;
while iterations<=500&&counter<50
    for i=1:200
        age(1,i)=age(1,i)+1;
    end
    shifted_load=zeros(14,200);
    fitness_value=zeros(1,200);
    for i=1:200
        x0=zeros(14,1);
        fun=@(x)fitness_DSM(x,i,population,cntrb_load,load_time,forecasted_load,obj);
        lb=zeros(1,14);
        ub=zeros(1,14);
        for j=1:14
            ub(1,j)=cntrb_load(j,4);
        end
        shifted_load(:,i)=round(fmincon(fun,x0,[],[],[],[],lb,ub));
        fitness_value(i)=fitness_DSM_GA(shifted_load(:,i),i,population,cntrb_load,load_time,forecasted_load,obj);
    end
    fnorm=fitness_value./sum(fitness_value);
    fcum=zeros(1,200);
    fcum(1,1)=fnorm(1,1);
    for i=2:200
        fcum(1,i)=fnorm(1,i)+fcum(1,i-1);
    end
    next_pop=zeros(14,200);
    for i=1:200
        n=randi([0,1000000]);
        n=n/100000000;
        if n<=fcum(1)
            next_pop(:,i)=population(:,1);
        end
        for j=2:200
            if n>fcum(j-1)&&n<=fcum(j)
                next_pop(:,i)=population(:,j);
                break
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
            end
        end
    end
    for i=1:200
        ini=randi([1,14]);
        fin=randi([1,14]);
        while ini==fin
            fin=randi([1,14]);
        end
        temp=next_pop(ini,i);
        next_pop(ini,i)=next_pop(fin,i);
        next_pop(fin,i)=temp;
    end
    it1=1;
    it2=2;
    old=age(1,1);
    oldi=1;
    for i=1:200
        if age(1,i)>old
            it2=oldi;
            it1=i;
            oldi=i;
            old=age(1,i);
        end
    end
    age(1,it2)=0;
    age(1,it1)=0;
    population(:,it1)=next_pop(:,it2);
    population(:,it2)=next_pop(:,it2);
    iterations=iterations+1
    max_fitness=0;
    max_i=-1;
    for i=1:200
        fitness_value(i)=fitness_DSM_GA(shifted_load(:,i),i,population,cntrb_load,load_time,forecasted_load,obj);
        if fitness_value(i)>max_fitness
            max_fitness=fitness_value(i);
            max_i=i;
        end
    end
    if max_fitness-prev<0.0000000001
        counter=counter+1;
    else
        counter=0;
    end
    prev=max_fitness;
end