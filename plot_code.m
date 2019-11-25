pload_plot=zeros(2400,1);
c=1;
for i=1:100:2400
    for j=i:i+100
        pload_plot(j,1)=pload(c,1);
    end
    c=c+1;
end