% unzip('catdog.zip');
% imds = imageDatastore('catdog', ...
%      'IncludeSubfolders',true, ...
%      'LabelSource','foldernames'); 
% [A,B,C] = splitEachLabel(imds,0.33,0.33);

[A,B,C] = splitIMDS();

%%%Train bag of words classifier

[bagA,svmA] = bagOfWordsTrain(A,B);

[bagB,svmB] = bagOfWordsTrain(B,C);

[bagC,svmC] = bagOfWordsTrain(C,A);

%%%Train ResNet18 classifier

netA = resNet18Train(A,B);

netB = resNet18Train(B,C);

netC = resNet18Train(C,A);


%imgsGN0 = gaussianNoise(C,0.01);
%imgsGN2 = gaussianNoise(C,2);
%imgsGN3 = gaussianNoise(C,18);

%res1 = bagOfWordsTest(bagA,svmA,imgsGN0,C.Labels);
%res2 = bagOfWordsTest(bagA,svmA,imgsGN2,C.Labels);
%res3 = bagOfWordsTest(bagA,svmA,imgsGN3,C.Labels);

%imgsTest = imdsToImages(C);
% 
% imgsGB1 = gaussianBlur(imgsTest);
% 
% resB1 = bagOfWordsTest(bagA,svmA,imgsGB1,C.Labels);
% resN1 = resNet18Test(netA,imgsGB1,C.Labels);
% 
% imgsGB2 = gaussianBlur(imgsGB1);
% 
% res2 = bagOfWordsTest(bagA,svmA,imgsGB2,C.Labels);
% resN2 = resNet18Test(netA,imgsGB2,C.Labels);

