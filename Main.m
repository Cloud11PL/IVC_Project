unzip('catdog.zip');

imds = imageDatastore('catdog', ...
     'IncludeSubfolders',true, ...
     'LabelSource','foldernames');
shuffleImds = shuffle(imds);

[testA,testB,testC] = splitEachLabel(shuffleImds,0.33,0.33);

trainA = imageDatastore(cat(1,testB.Files,testC.Files), ...
     'IncludeSubfolders',true, ...
     'LabelSource','foldernames');
trainB = imageDatastore(cat(1,testC.Files,testA.Files), ...
     'IncludeSubfolders',true, ...
     'LabelSource','foldernames');
trainC = imageDatastore(cat(1,testA.Files,testB.Files), ...
     'IncludeSubfolders',true, ...
     'LabelSource','foldernames');

testAImgs = imdsToImages(testA);
testBImgs = imdsToImages(testB);
testCImgs = imdsToImages(testC);

testALabels = testA.Labels;
testBLabels = testB.Labels;
testCLabels = testC.Labels;

imgs = {testAImgs,testBImgs,testCImgs};
labels = {testALabels,testBLabels,testCLabels};

%Train bag of words classifier

[bagA,svmA] = bagOfWordsTrain(trainA);

[bagB,svmB] = bagOfWordsTrain(trainB);

[bagC,svmC] = bagOfWordsTrain(trainC);

bags = {bagA,bagB,bagC};
svms = {svmA,svmB,svmV};

%Train ResNet18 classifier

netA = resNet18Train(trainA);
netB = resNet18Train(trainB);
netC = resNet18Train(trainC);

nets = {netA,netB,netC};

% Remove all variables. Maybe for memory

save nets bags svms labels imgs;

%load nets bags svams labels imgs;

%clearvars -except nets bags svms images labels;

%Vars

gNoiseSD = [0, 2, 4, 6, 8, 10, 12, 14, 16, 18];
gBlurTimes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
cIncSD = [1.0, 1.03, 1.06, 1.09, 1.12, 1.15, 1.18, 1.21, 1.24, 1.27];

cDecSD = [1.0, 0.90, 0.80, 0.70, 0.60, 0.50, 0.40, 0.30, 0.20, 0.10];
bIncDecSD = [ 0, 5, 10, 15, 20, 25, 30, 35, 40, 45];

hueSatSD = [ 0.00, 0.02, 0.04, 0.06, 0.08, 0.10, 0.12, 0.14, 0.16, 0.18];
oLen = [ 0, 5, 10, 15, 20, 25, 30, 35, 40, 45 ];

%Tests

% RUN ONE AT A TIME

% runTest(bags,svms,nets,images,labels,gNoiseSD,@gaussianNoise,'Gaussian Noise');
% runTest(bags,svms,nets,images,labels,gBlurTimes,@gaussianBlur,'Gaussian Blur');
% runTest(bags,svms,nets,images,labels,cIncSD,@imageContrast,'Contrast Increase');
% 
% runTest(bags,svms,nets,images,labels,cDecSD,@imageContrast,'Contrast Decrease');
% runTest(bags,svms,nets,images,labels,bIncDecSD,@imageBrightness,'Brightness Increase');
% runTest(bags,svms,nets,images,labels,-bIncDecSD,@imageBrightness,'Brightness Decrease');
% 
% runTest(bags,svms,nets,images,labels,hueSatSD,@HSVHue,'Hue Noise');
% runTest(bags,svms,nets,images,labels,hueSatSD,@HSVSaturation,'Saturation Noise');
% runTest(bags,svms,nets,images,labels,oLen,@occlusion,'Occlusion');
