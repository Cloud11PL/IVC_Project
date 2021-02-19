function images = gaussianNoise(images,sd)
    for i = 1:size(images,4)
        mat = normrnd(0,sd,224,224,3);
        image = images(:,:,:,i);
        images(:,:,:,i) = image + mat;
    end
    images = uint8(images);
end




