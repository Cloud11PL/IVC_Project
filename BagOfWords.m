unzip('catdog.zip');
imds = imageDatastore('catdog', ...
        'IncludeSubfolders',true, ...
        'LabelSource','foldernames'); 
    
imds = shuffle(imds);

bag = bagOfFeatures(imds, ...
    'StrongestFeatures', 0.99, ...
    'VocabularySize', 2000);

vec = encode(bag,imds);

partIdx = floor(size(vec,1)*0.8);

vecTrain = vec(1:partIdx,:);
vecTest = vec(partIdx+1:size(vec,1),:);

trainLabels = imds.Labels(1:partIdx,:);
testLabels = imds.Labels(partIdx+1:size(vec,1),:);

svm = fitcsvm(vecTrain,trainLabels);
svm = crossval(svm,'KFold',20);
svm = svm.Trained{1};

res = loss(svm,vecTest,testLabels);
