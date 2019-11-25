for i=1:168
    test(1,1)=trainingData(8760-672+i);
    test(2,1)=trainingData(8760-504+i);
    test(3,1)=trainingData(8760-336+i);
    test(4,1)=trainingData(8760-168+i);
    output(i,1)=sim(net,test);
end
for i=169:336
    test(1,1)=trainingData(8760-672+i);
    test(2,1)=trainingData(8760-504+i);
    test(3,1)=trainingData(8760-336+i);
    test(4,1)=testdata(i-168);
    output(i,1)=sim(net,test);
end
for i=337:504
    test(1,1)=trainingData(8760-672+i);
    test(2,1)=trainingData(8760-504+i);
    test(3,1)=testdata(i-336);
    test(4,1)=testdata(i-168);
    output(i,1)=sim(net,test);
end
for i=505:672
    test(1,1)=trainingData(8760-672+i);
    test(2,1)=testdata(i-504);
    test(3,1)=testdata(i-336);
    test(4,1)=testdata(i-168);
    output(i,1)=sim(net,test);
end
for i=673:8760
    test(1,1)=testdata(i-672);
    test(2,1)=testdata(i-504);
    test(3,1)=testdata(i-336);
    test(4,1)=testdata(i-168);
    output(i,1)=sim(net,test);
end