function net = resNet18Train(imdsTrain)

    %Get resnet18 model
    net = resnet18;
    
    %get graph on net
    lgraph = layerGraph(net);
    
    %find the layers we will replace
    [learnableLayer,classLayer] = findLayersToReplace(lgraph);
    
    %The number of classes we are classifying
    numClasses = numel(categories(imdsTrain.Labels));
    
    %Create the new fully connected layer we will use
    newLearnableLayer = [
        fullyConnectedLayer(40, ...
            'Name','fc1', ...
            'WeightLearnRateFactor',10, ...
            'BiasLearnRateFactor',10),...
        fullyConnectedLayer(numClasses, ...
            'Name','fc2', ...
            'WeightLearnRateFactor',10, ...
            'BiasLearnRateFactor',10)];
     
    %Replace the fully connected layer    
    lgraph = replaceLayer(lgraph,learnableLayer.Name,newLearnableLayer);

    %Create new classificaton layer
    newClassLayer = classificationLayer('Name','output');
    %Replace the classification layer
    lgraph = replaceLayer(lgraph,classLayer.Name,newClassLayer);

    %Get the layers and connections
    layers = lgraph.Layers;
    connections = lgraph.Connections;

    %Get the index of the fully connected layers so we can freeze
    fcidx = getnameidx({layers.Name},learnableLayer.Name);

    %Freeze layer before fully connected layers
    layers(1:fcidx) = freezeWeights(net.Layers(1:fcidx));
    %connect our layers
    lgraph = createLgraphUsingConnections(layers,connections);

    %The input size of the net
    inputSize = net.Layers(1).InputSize;

    %Augmentation ranges we will apply
    rotationRange = [0 360];
    pixelRange = [-30 30];
    scaleRange = [0.9 1.1];

    %Augmentations to apply
    imageAugmenter = imageDataAugmenter( ...
        'RandRotation', rotationRange, ...
        'RandXReflection',true, ...
        'RandYReflection',true, ...
        'RandXTranslation',pixelRange, ...
        'RandYTranslation',pixelRange, ...
        'RandXScale',scaleRange, ...
        'RandYScale',scaleRange);

    %Apply augmentations
    augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain, ...
        'DataAugmentation',imageAugmenter, ...
        'ColorPreprocessing','gray2rgb');

    %Partition images for cross validation
    c = cvpartition(augimdsTrain.NumObservations,'KFold',3);

    %Loop over kfold chocies
    for i = 1:3
        
        %Get trainind indices
        trainingInd = training(c,i);
        %Get validation indicies
        valInd = test(c,i);

        %Get training set
        trainingSet = subset(augimdsTrain,trainingInd);
        %Get validation set
        valSet = subset(augimdsTrain,valInd);

        %Set the options for our training
        options = trainingOptions('sgdm', ...
            'MiniBatchSize',10, ...
            'MaxEpochs',1, ...
            'InitialLearnRate',3e-4, ...
            'Shuffle','every-epoch', ...
            'ValidationData',valSet, ...
            'ValidationFrequency',30, ...
            'Verbose',false);

        %Train the network
        net = trainNetwork(trainingSet,lgraph,options);

        %Create graph of net for retraining
        lgraph = layerGraph(net);
    end       
end