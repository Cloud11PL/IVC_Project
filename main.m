clear all
clc

net = resnet18('Weights', 'imagenet')
net.Layers;

lgraph = resnet18('Weights','none')
lgraph.Layers;
%%

%I = imread('images/CATS/cat_1_0.png')
I = imread('fifi_square.jpg');
% Adjust size of the image
sz = net.Layers(1).InputSize;
I = I(1:sz(1),1:sz(2),1:sz(3));

% Classify the image using ResNet-18
label = classify(net, I)

% Show the image and the classification results
%figure
%imshow(I)
%text(10,20,char(label),'Color','white')

%idk1 = net.Layers(1)
%idk = net.Layers(39)