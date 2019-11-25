input=transpose(trainingData(:,1:4));
output=sim(net1,input);
output=transpose(output);
t=zeros(672,1);
output1=zeros(8760,1);
output1(1:672,1)=t;
output1(673:8760,1)=output;