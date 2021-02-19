% function result = bagOfWordsTest(bag,svm,imdsTest)
%     vecTest = encode(bag,imdsTest);
%     testLabels = imdsTest.Labels;
%     result = loss(svm,vecTest,testLabels);
%     result = (1 - result) * 100;
% end

% function result = bagOfWordsTest(bag,svm,images,labels,i)
%     vecTest = encode(bag,cell2mat(images(i)));
%     testLabels = labels(i);
%     result = loss(svm,vecTest,testLabels);
%     result = (1 - result) * 100;
% end

function result = bagOfWordsTest(bag,svm,images,labels)
    imageCount = size(images,4);
    vecTest = zeros(imageCount,bag.VocabularySize);
    
    for i = 1:imageCount
        vecTest(i,:) = encode(bag,images(:,:,:,i));
    end
    
    result = loss(svm,vecTest,labels);
    result = (1 - result) * 100;
end