% function accuracy = resNet18Test(net,imdsTest)
%     
%     inputSize = net.Layers(1).InputSize;
%     
% %     rotationRange = [0 360];
% %     pixelRange = [-30 30];
% %     scaleRange = [0.9 1.1];
% % 
% %      imageAugmenter = imageDataAugmenter( ...
% %             'RandRotation', rotationRange, ...
% %             'RandXReflection',true, ...
% %             'RandYReflection',true, ...
% %             'RandXTranslation',pixelRange, ...
% %             'RandYTranslation',pixelRange, ...
% %             'RandXScale',scaleRange, ...
% %             'RandYScale',scaleRange);
% 
% 
%     augimdsTest = augmentedImageDatastore(inputSize(1:2),imdsTest,...
%         'ColorPreprocessing','gray2rgb');
%         
% %     augimdsTest = augmentedImageDatastore(inputSize(1:2),imdsTest,...
% %         'DataAugmentation',imageAugmenter, ...
% %         'ColorPreprocessing','gray2rgb');
% 
%     YPred = classify(net,augimdsTest);
%     accuracy = mean(YPred == imdsTest.Labels)*100;
%     
% end


function accuracy = resNet18Test(net,images,labels)
    YPred = classify(net,images);
    accuracy = mean(YPred == labels)*100;
end