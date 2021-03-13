function accuracy = resNet18Test(net,images,labels)
    %Classifiy images
    YPred = classify(net,images,'MiniBatchSize',10);
    %Calculate accuracy of classifications
    accuracy = mean(YPred == labels)*100;
end