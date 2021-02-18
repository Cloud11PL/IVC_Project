%unzip('catdog.zip');
%imds = imageDatastore('catdog', ...
%     'IncludeSubfolders',true, ...
%     'LabelSource','foldernames'); 
%[A,B,C] = splitEachLabel(imds,0.33,0.33);

%%%Train bag of words classifier

%Train for A and B
%[bagA,svmA] = bagOfWordsTrain(A,B);

%Train for C and C
%[bagB,svmB] = bagOfWordsTrain(B,C);

%Train for C and A
%[bagC,svmC] = bagOfWordsTrain(C,A);

%%%Train ResNet18 classifier

%netA = resNet18Train(A,B);