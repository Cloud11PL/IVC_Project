function [bag,svm] = bagOfWordsTrain(imdsTrain)

    bag = bagOfFeatures(imdsTrain, ...
        'StrongestFeatures', 0.99, ...
        'VocabularySize', 2000, ...
        'PointSelection', 'Detector');
        
    vecTrain = encode(bag,imdsTrain);
    trainLabels = imdsTrain.Labels;

    svm = fitcsvm(vecTrain,trainLabels);
    svm = crossval(svm,'KFold',3);
    svm = svm.Trained{1};
end