function result = bagOfWordsTest(bag,svm,imdsTest)
    vecTest = encode(bag,imdsTest);
    testLabels = imdsTest.Labels;
    result = loss(svm,vecTest,testLabels);
    result = (1 - result) * 100;
end