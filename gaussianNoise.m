function images = gaussianNoise(images,sd)
    for i = 1:size(images,4)
        image = images(:,:,:,i);
        images(:,:,:,i) = imnoise(image,'gaussian',0,sd);
    end
    images = uint8(images);
end




