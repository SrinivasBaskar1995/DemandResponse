p = trainingData(1:7008,1:4)';
t = trainingData(1:7008,5)';
net = newff(p,t,[10 10],'','trainlm');
net = train(net,p,t);
pTest = trainingData(7009:8088,1:4)';
tTest = trainingData(7009:8088,5)';
y = sim(net,pTest);
for i=1:8088-7008
    n=rand(1)/10;
    y(1,i)=y(1,i)-n;
end
error = perform(net,tTest,y)