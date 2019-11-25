function y = fitness_DSM(x,iter,population,cntrb_load,load_time,forecasted_load,obj)
connect=zeros(24,1);
disconnect=zeros(24,1);
sum1=0;
sum2=0;
sum3=0;
for i=1:24
    for k=1:14
        if population(k,iter)==i
            sum1=sum1+(x(k)*cntrb_load(k,1));
        end
        if population(k,iter)==i-1
            sum2=sum2+(x(k)*cntrb_load(k,2));
        end
        if population(k,iter)==i-2
            sum3=sum3+(x(k)*cntrb_load(k,3));
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
            sum1=sum1+(x(k)*cntrb_load(k,1));
        end
        if load_time(k,1)==i-1 && population(k,iter)~=i-1
            sum2=sum2+(x(k)*cntrb_load(k,2));
        end
        if load_time(k,1)==i-2 && population(k,iter)~=i-2
            sum3=sum3+(x(k)*cntrb_load(k,3));
        end
    end
    disconnect(i,1)=sum1+sum2+sum3;
end
pload=forecasted_load+connect-disconnect;
y = ((sum(pload-obj))^2);