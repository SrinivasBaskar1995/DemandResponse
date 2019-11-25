for i=73:744
    test(1,1)=newtotalEnergy(i-72+504,1);
    test(1,2)=newtotalEnergy(i-72,1);
    test(1,3)=newtotalEnergy(i-72+168,1);
    test(1,4)=newtotalEnergy(i-72+336,1);
    december(i,1)=sim(net1,test')
end