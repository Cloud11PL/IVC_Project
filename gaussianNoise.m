function images = gaussianNoise(imds,sd)
    images = readall(transform(imds, ...
        @(x) {imnoise(gray2rgb(x),'gaussian',0,sd)}));
end
