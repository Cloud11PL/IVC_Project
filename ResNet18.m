unzip('catdog.zip');
imds = imageDatastore('catdog', ...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames'); 
[imdsTrain,imdsTest] = splitEachLabel(imds,0.8);

net = resnet18;

if isa(net,'SeriesNetwork') 
  lgraph = layerGraph(net.Layers); 
else
  lgraph = layerGraph(net);
end 

[learnableLayer,classLayer] = findLayersToReplace(lgraph);

numClasses = numel(categories(imdsTrain.Labels));

newLearnableLayer = [
    fullyConnectedLayer(15, ...
        'Name','fc1', ...
        'WeightLearnRateFactor',10, ...
        'BiasLearnRateFactor',10),...
    fullyConnectedLayer(numClasses, ...
        'Name','fc2', ...
        'WeightLearnRateFactor',10, ...
        'BiasLearnRateFactor',10)];
    
lgraph = replaceLayer(lgraph,learnableLayer.Name,newLearnableLayer);

newClassLayer = classificationLayer('Name','output');
lgraph = replaceLayer(lgraph,classLayer.Name,newClassLayer);

layers = lgraph.Layers;
connections = lgraph.Connections;

fcidx = getnameidx({layers.Name},learnableLayer.Name);

layers(1:fcidx) = freezeWeights(net.Layers(1:fcidx));
lgraph = createLgraphUsingConnections(layers,connections);

inputSize = net.Layers(1).InputSize;

rotationRange = [0 360];
pixelRange = [-30 30];
scaleRange = [0.9 1.1];

imageAugmenter = imageDataAugmenter( ...
    'RandRotation', rotationRange, ...
    'RandXReflection',true, ...
    'RandYReflection',true, ...
    'RandXTranslation',pixelRange, ...
    'RandYTranslation',pixelRange, ...
    'RandXScale',scaleRange, ...
    'RandYScale',scaleRange);

augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain, ...
    'DataAugmentation',imageAugmenter, ...
    'ColorPreprocessing','gray2rgb');

%augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation,...
%    'ColorPreprocessing','gray2rgb');


augimdsTest = augmentedImageDatastore(inputSize(1:2),imdsTest,...
    'ColorPreprocessing','gray2rgb');

% miniBatchSize = 10;
% valFrequency = floor(numel(augimdsTrain.Files)/miniBatchSize);
% options = trainingOptions('sgdm', ...
%     'MiniBatchSize',miniBatchSize, ...
%     'MaxEpochs',6, ...
%     'InitialLearnRate',3e-4, ...
%     'Shuffle','every-epoch', ...
%     'ValidationData',augimdsValidation, ...
%     'ValidationFrequency',valFrequency, ...
%     'Verbose',false, ...
%     'Plots','training-progress');

c = cvpartition(augimdsTrain.NumObservations,'KFold',3);

for i = 1:3
 
 trainingInd = training(c,i);
 valInd = test(c,i);
 
 trainingSet = subset(augimdsTrain,trainingInd);
 valSet = subset(augimdsTrain,valInd);
 
 options = trainingOptions('sgdm', ...
    'MiniBatchSize',10, ...
    'MaxEpochs',1, ...
    'InitialLearnRate',3e-4, ...
    'Shuffle','every-epoch', ...
    'ValidationData',valSet, ...
    'ValidationFrequency',valFrequency, ...
    'Verbose',false, ...
    'Plots','training-progress');

    net = trainNetwork(augimdsTrain,lgraph,options);
    
    if isa(net,'SeriesNetwork') 
        lgraph = layerGraph(net.Layers); 
    else
        lgraph = layerGraph(net);
    end 
end

[YPred,probs] = classify(net,augimdsTest);
accuracy = mean(YPred == imdsTest.Labels);

idx = randperm(numel(imdsTest.Files),4);
figure
for i = 1:4
    subplot(2,2,i)
    I = readimage(imdsTest,idx(i));
    imshow(I)
    label = YPred(idx(i));
    title(string(label) + ", " + num2str(100*max(probs(idx(i),:)),3) + "%");
end
