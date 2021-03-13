function images = gaussianNoise(images,sd)
    %Loop over images
    for i = 1:size(images,4)
        %Extract image at index and convert to double
        image = double(images(:,:,:,i));
        %Add random gaussian noise to image and place back in array
        images(:,:,:,i) = image + normrnd(0,sd,224,224,3);
    end
    %Make sure values are 0-255
    images = uint8(images);
end





