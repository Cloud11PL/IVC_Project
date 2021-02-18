function [bag,svm] = bagOfWordsTrain(A,B)

    imdsTrain = imageDatastore(cat(1,A.Files,B.Files));
    imdsTrain.Labels = cat(1,A.Labels,B.Labels);

    bag = bagOfFeatures(imdsTrain, ...
        'StrongestFeatures', 0.99, ...
        'VocabularySize', 2000, ...
        'PointSelection', 'Detector');
    
    % 'PointSelection', 'Detector'
    
    vecTrain = encode(bag,imdsTrain);
    trainLabels = imdsTrain.Labels;

    svm = fitcsvm(vecTrain,trainLabels);
    svm = crossval(svm,'KFold',3);
    svm = svm.Trained{1};
end