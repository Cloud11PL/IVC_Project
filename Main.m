%unzip('catdog.zip');
% imds = imageDatastore('catdog', ...
%      'IncludeSubfolders',true, ...
%      'LabelSource','foldernames');
% shuffleImds = shuffle(imds);
% 
% [testA,testB,testC] = splitEachLabel(shuffleImds,0.33,0.33);
% 
% trainA = imageDatastore(cat(1,testB.Files,testC.Files), ...
%      'IncludeSubfolders',true, ...
%      'LabelSource','foldernames');
% trainB = imageDatastore(cat(1,testC.Files,testA.Files), ...
%      'IncludeSubfolders',true, ...
%      'LabelSource','foldernames');
% trainC = imageDatastore(cat(1,testA.Files,testB.Files), ...
%      'IncludeSubfolders',true, ...
%      'LabelSource','foldernames');
%  

global testAImgs
global testBImgs
global testCImgs

% testAImgs = imdsToImages(testA); 
% testBImgs = imdsToImages(testB); 
% testCImgs = imdsToImages(testC); 

global testALabels
global testBLabels
global testCLabels

% testALabels = testA.Labels;
% testBLabels = testB.Labels;
% testCLabels = testC.Labels;

%%%Train bag of words classifier

global bagA
global bagB
global bagC

global svmA
global svmB
global svmC

%[bagA,svmA] = bagOfWordsTrain(trainA);

%[bagB,svmB] = bagOfWordsTrain(trainB);

%[bagC,svmC] = bagOfWordsTrain(trainC);

%%%Train ResNet18 classifier

%netA = resNet18Train(A,B);

%netB = resNet18Train(B,C);

%netC = resNet18Train(C,A);

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



% Run GNOISE TEST

gNoiseSD = [0 2 4 6 8 10 12 14 16 18];
cIncSD = [1.0, 1.03, 1.06, 1.09, 1.12, 1.15, 1.18, 1.21, 1.24, 1.27];
gBlurTimes = [0 1 2 3 4 5 6 7 8 9];
bIncSD = [ 0, 5, 10, 15, 20, 25, 30, 35, 40, 45];
oLen = [ 0, 5, 10, 15, 20, 25, 30, 35, 40, 45 ];


% accs = [];
% 
% for i = 1:numel(gNoiseSD)
%     sd = gNoiseSD(i);
%     imgs = gaussianNoise(testAImgs,sd);
%     acc = bagOfWordsTest(bagA,svmA,imgs,testALabels);
%     accs = cat(1,accs,acc);
% 

%test(gNoiseSD,@gaussianNoise);

%test(gBlurTimes,@gaussianBlur);

%test(bIncSD,@imageBrightness);

test(oLen,@occlusion);


function test(vars,pert)

    global testAImgs
    global testBImgs
    global testCImgs
    
    global testALabels
    global testBLabels
    global testCLabels
    
    global bagA
    global bagB
    global bagC

    global svmA
    global svmB
    global svmC

    accs = [];

    for i = 1:numel(vars)
        var = vars(i);
        
        imgsA = pert(testAImgs,var);
        accA = bagOfWordsTest(bagA,svmA,imgsA,testALabels);
        
        imgsB = pert(testBImgs,var);
        accB = bagOfWordsTest(bagB,svmB,imgsB,testBLabels);
        
        imgsC = pert(testCImgs,var);
        accC = bagOfWordsTest(bagC,svmC,imgsC,testCLabels);
        
        acc = (accA + accB + accC)/3;
        
        accs = cat(1,accs,acc);
    end
    
    plot(vars,accs);
end


