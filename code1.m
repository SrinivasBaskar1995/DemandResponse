for i=673:8760
    trainingData(i-672,1)=data20071(i-672,2);
    trainingData(i-672,2)=data20071(i-504,2);
    trainingData(i-672,3)=data20071(i-336,2);
    trainingData(i-672,4)=data20071(i-168,2);
    trainingData(i-672,5)=data20071(i,2);
end