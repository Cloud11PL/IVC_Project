function net = resNet18Train(A,B)

    imdsTrain = imageDatastore(cat(1,A.Files,B.Files));
    imdsTrain.Labels = cat(1,A.Labels,B.Labels);
    
    net = resnet18;
    
    lgraph = layerGraph(net);
    
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
                'ValidationFrequency',30, ...
                'Verbose',false);

             net = trainNetwork(trainingSet,lgraph,options);
    
             lgraph = layerGraph(net);
        
        end       
end