function result = bagOfWordsTest(bag,svm,images,labels)
    %Get the number of images
    imageCount = size(images,4);
    %Initialize array for images histograms
    vecTest = zeros(imageCount,bag.VocabularySize);
    
    %Loop over images
    for i = 1:imageCount
        %Get histogram for image
        vecTest(i,:) = encode(bag,images(:,:,:,i));
    end
    
    %Calculate loss using svm
    result = loss(svm,vecTest,labels);
    %Calculate accuracy
    result = (1 - result) * 100;
end