function [bag,svm] = bagOfWordsTrain(imdsTrain)
    %Create a bag of features
    bag = bagOfFeatures(imdsTrain, ...
        'StrongestFeatures', 0.99, ...
        'VocabularySize', 2000, ...
        'PointSelection', 'Detector');
    
    %Create histogramns
    vecTrain = encode(bag,imdsTrain);
    %Get image labels
    trainLabels = imdsTrain.Labels;

    %Fit svm to data
    svm = fitcsvm(vecTrain,trainLabels);
    %Apply cross-validation
    svm = crossval(svm,'KFold',3);
    %The trained SVM
    svm = svm.Trained{1};
end