for i=1:8760
    out = 2*rand(1, 1);
    sign=randi(2,1,1);
    if sign==1
        testdata(i,1)=totalEnergy(i,1)+out;
    end
    if sign==2
        testdata(i,1)=totalEnergy(i,1)-out;
    end
end